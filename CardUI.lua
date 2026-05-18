import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.*"
import "android.graphics.drawable.*"
import "android.graphics.*"

local context = activity
local windowManager = context.getSystemService("window")

-- Shape Generator with solid color and rounded corners
local function createShape(solidColor, cornerRadius, strokeWidth, strokeColor)
    local drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(Color.parseColor(solidColor))
    drawable.setCornerRadius(cornerRadius)
    if strokeWidth and strokeColor then
        drawable.setStroke(strokeWidth, Color.parseColor(strokeColor))
    end
    return drawable
end

local overlayType = 2003
if Build.VERSION.SDK_INT >= 26 then
    overlayType = 2038
end

--------------------------------------------------
-- 1. COMPACT FLOATING LOGO BUTTON (90x90)
--------------------------------------------------
local iconParams = WindowManager.LayoutParams()
iconParams.type = overlayType
iconParams.format = PixelFormat.RGBA_8888
iconParams.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
iconParams.width = 90  
iconParams.height = 90 
iconParams.gravity = Gravity.LEFT or Gravity.TOP
iconParams.x = 100
iconParams.y = 400

local logoButton = Button(context)
logoButton.setText("P")
logoButton.setTextColor(Color.parseColor("#00E5FF"))
logoButton.setTextSize(14)
logoButton.setTypeface(Typeface.DEFAULT_BOLD)

local buttonShape = GradientDrawable()
buttonShape.setShape(GradientDrawable.OVAL)
buttonShape.setColor(Color.parseColor("#1A1A24"))
buttonShape.setStroke(3, Color.parseColor("#00E5FF"))
logoButton.setBackground(buttonShape)

--------------------------------------------------
-- FLOATING BUTTON DRAG LOGIC
--------------------------------------------------
local initialX, initialY, initialTouchX, initialTouchY
logoButton.setOnTouchListener(luajava.createProxy("android.view.View$OnTouchListener", {
    onTouch = function(view, event)
        local action = event.getAction()
        if action == MotionEvent.ACTION_DOWN then
            initialX = iconParams.x
            initialY = iconParams.y
            initialTouchX = event.getRawX()
            initialTouchY = event.getRawY()
            return true
        elseif action == MotionEvent.ACTION_MOVE then
            iconParams.x = initialX + math.floor(event.getRawX() - initialTouchX)
            iconParams.y = initialY + math.floor(event.getRawY() - initialTouchY)
            windowManager.updateViewLayout(logoButton, iconParams)
            return true
        elseif action == MotionEvent.ACTION_UP then
            local deltaX = math.abs(event.getRawX() - initialTouchX)
            local deltaY = math.abs(event.getRawY() - initialTouchY)
            if deltaX < 15 and deltaY < 15 then
                activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
                    run = function()
                        logoButton.setVisibility(View.GONE)
                        _G.PRINZ_MAIN_CONTAINER.setVisibility(View.VISIBLE)
                    end
                }))
            end
            return true
        end
        return false
    end
}))

--------------------------------------------------
-- 2. FIXED COMPACT UI CARD (NO MORE SCREEN STRETCH)
--------------------------------------------------
local mainParams = WindowManager.LayoutParams()
mainParams.type = overlayType
mainParams.format = PixelFormat.RGBA_8888
mainParams.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
mainParams.width = 660  -- Fixed strict width profile
mainParams.height = WindowManager.LayoutParams.WRAP_CONTENT
mainParams.gravity = Gravity.CENTER

-- Using a base frame layout wrapper to force Android layout engines to wrap strictly
local rootWrapper = FrameLayout(context)
_G.PRINZ_MAIN_CONTAINER = rootWrapper

local mainContainer = LinearLayout(context)
mainContainer.setOrientation(LinearLayout.VERTICAL)
mainContainer.setBackground(createShape("#1A1A24", 28, 2, "#00E5FF"))
mainContainer.setPadding(35, 30, 35, 35)

local matchParent = LinearLayout.LayoutParams.MATCH_PARENT
local wrapContent = LinearLayout.LayoutParams.WRAP_CONTENT
mainContainer.setLayoutParams(FrameLayout.LayoutParams(matchParent, wrapContent))
rootWrapper.addView(mainContainer)

--------------------------------------------------
-- HEADER BAR WITH RIGHT ALIGNED CORNER (×)
--------------------------------------------------
local headerBar = LinearLayout(context)
headerBar.setOrientation(LinearLayout.HORIZONTAL)
headerBar.setGravity(Gravity.CENTER_VERTICAL)

local titleText = TextView(context)
titleText.setText("Prinzvan System Config V2.0\nshielded Perception")
titleText.setTextColor(Color.parseColor("#FFFFFF"))
titleText.setTextSize(13)
titleText.setTypeface(Typeface.DEFAULT_BOLD)
titleText.setGravity(Gravity.CENTER)
local titleParams = LinearLayout.LayoutParams(0, wrapContent, 1.0)
titleText.setLayoutParams(titleParams)
headerBar.addView(titleText)

local closeButton = TextView(context)
closeButton.setText("×")
closeButton.setTextColor(Color.parseColor("#FFFFFF"))
closeButton.setTextSize(24)
closeButton.setPadding(10, 0, 5, 5)
closeButton.setOnClickListener(luajava.createProxy("android.view.View$OnClickListener", {
    onClick = function(v)
        activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
            run = function()
                _G.PRINZ_MAIN_CONTAINER.setVisibility(View.GONE)
                logoButton.setVisibility(View.VISIBLE)
            end
        }))
    end
}))
headerBar.addView(closeButton)
mainContainer.addView(headerBar)

-- Compact Brand Title
local brandText = TextView(context)
brandText.setText("Prinzvan Modz")
brandText.setTextColor(Color.parseColor("#FFFFFF"))
brandText.setTextSize(19)
brandText.setGravity(Gravity.CENTER)
brandText.setPadding(0, 25, 0, 25)
mainContainer.addView(brandText)

-- Navigation Tab Bar Layout
local tabBar = LinearLayout(context)
tabBar.setOrientation(LinearLayout.HORIZONTAL)
tabBar.setPadding(0, 0, 0, 20)
mainContainer.addView(tabBar)

-- Dynamic Frame Container Window
local contentFrame = FrameLayout(context)
mainContainer.addView(contentFrame)

local pages = {}
local tabButtons = {}

local function createPage()
    local page = LinearLayout(context)
    page.setOrientation(LinearLayout.VERTICAL)
    page.setVisibility(View.GONE)
    page.setLayoutParams(LinearLayout.LayoutParams(matchParent, wrapContent))
    contentFrame.addView(page)
    return page
end

for i = 1, 5 do pages[i] = createPage() end

local function switchTab(index)
    for i = 1, #pages do
        if i == index then
            pages[i].setVisibility(View.VISIBLE)
            tabButtons[i].setTextColor(Color.parseColor("#FFFFFF"))
            tabButtons[i].setBackground(createShape("#2A2A3A", 10, 1, "#00E5FF"))
        else
            pages[i].setVisibility(View.GONE)
            tabButtons[i].setTextColor(Color.parseColor("#B0BEC5"))
            tabButtons[i].setBackground(createShape("#1A1A24", 10, 0, nil))
        end
    end
end

local function addTab(title, index)
    local btn = Button(context)
    local params = luajava.newInstance("android.widget.LinearLayout$LayoutParams", 0, 75, 1.0) -- Low strict static height
    btn.setLayoutParams(params)
    btn.setText(title)
    btn.setTextSize(8.5)
    btn.setPadding(0, 0, 0, 0)
    btn.setOnClickListener(luajava.createProxy("android.view.View$OnClickListener", {
        onClick = function(v) switchTab(index) end
    }))
    tabBar.addView(btn)
    tabButtons[index] = btn
end

local tabTitles = {"Shield", "Visuals", "Drone", "Prices", "System"}
for i, title in ipairs(tabTitles) do addTab(title, i) end

--------------------------------------------------
-- CONTENT UI COMPONENT FACTORY
--------------------------------------------------
local function addPageText(page, text, color)
    local txt = TextView(context)
    txt.setText(text)
    txt.setTextColor(Color.parseColor(color or "#FFFFFF"))
    txt.setPadding(0, 5, 0, 15)
    txt.setTextSize(11)
    page.addView(txt)
end

local function addPageButton(page, text, callback)
    local paddingView = LinearLayout(context)
    paddingView.setPadding(0, 5, 0, 0)
    
    local btn = Button(context)
    btn.setText(text)
    btn.setTextColor(Color.parseColor("#FFFFFF"))
    btn.setTypeface(Typeface.DEFAULT_BOLD)
    btn.setTextSize(11)
    btn.setBackground(createShape("#2A2A3A", 12, 1, "#00E5FF")) 
    btn.setPadding(0, 15, 0, 15)
    btn.setOnClickListener(luajava.createProxy("android.view.View$OnClickListener", {
        onClick = function(v) callback() end
    }))
    
    paddingView.addView(btn, LinearLayout.LayoutParams(matchParent, wrapContent))
    page.addView(paddingView)
end

-- Page Views Data Mappings
addPageText(pages[1], "Status: Plan Verified [Free User]", "#00FF00")
addPageButton(pages[1], "VERIFY ACTIVE CONFIGURATION TOKEN", function()
    gg.toast("Verifying configuration...")
end)

addPageText(pages[2], "Visual Interface Perception Engine Active", "#FFFFFF")
addPageText(pages[3], "Matrix Coordinates Tracking Panel", "#FFFFFF")

addPageText(pages[4], "Premium Tiers Profile List", "#00E5FF")
addPageText(pages[4], "• 03 Days Access VIP\n• 07 Days Access VIP\n• Lifetime Pass Base Pass", "#FFFFFF")

addPageText(pages[5], "UI Lifecycle Termination Matrix", "#B0BEC5")
addPageButton(pages[5], "CLOSE UI WINDOW", function()
    activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
        run = function()
            windowManager.removeView(_G.PRINZ_MAIN_CONTAINER)
            windowManager.removeView(logoButton)
        end
    }))
end)

switchTab(1)

--------------------------------------------------
-- RENDER MOUNT DEPLOYMENT
--------------------------------------------------
activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
    run = function()
        windowManager.addView(logoButton, iconParams)
        logoButton.setVisibility(View.GONE) 
        
        windowManager.addView(_G.PRINZ_MAIN_CONTAINER, mainParams)
    end
}))

while true do
    gg.sleep(100)
end
