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

-- Proper Layout parameters based on Android level
local overlayType = 2003
if Build.VERSION.SDK_INT >= 26 then
    overlayType = 2038
end

--------------------------------------------------
-- 1. FLOATING LOGO BUTTON SYSTEM
--------------------------------------------------
local iconParams = WindowManager.LayoutParams()
iconParams.type = overlayType
iconParams.format = PixelFormat.RGBA_8888
iconParams.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
iconParams.width = 130
iconParams.height = 130
iconParams.gravity = Gravity.LEFT or Gravity.TOP
iconParams.x = 100
iconParams.y = 400

local logoButton = Button(context)
logoButton.setText("P")
logoButton.setTextColor(Color.parseColor("#00E5FF"))
logoButton.setTextSize(18)
logoButton.setTypeface(Typeface.DEFAULT_BOLD)

local buttonShape = GradientDrawable()
buttonShape.setShape(GradientDrawable.OVAL)
buttonShape.setColor(Color.parseColor("#1A1A24")) -- Main dark UI background
buttonShape.setStroke(4, Color.parseColor("#00E5FF")) -- Accent blue
logoButton.setBackground(buttonShape)

--------------------------------------------------
-- DRAG LOGIC FOR FLOATING LOGO
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
                -- Registration for a simple click, toggle visibility
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
-- 2. THE UPDATED MAIN UI CARD (IMAGE-BASED)
--------------------------------------------------
local mainParams = WindowManager.LayoutParams()
mainParams.type = overlayType
mainParams.format = PixelFormat.RGBA_8888
mainParams.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
mainParams.width = WindowManager.LayoutParams.WRAP_CONTENT
mainParams.height = WindowManager.LayoutParams.WRAP_CONTENT
mainParams.gravity = Gravity.CENTER

local mainContainer = LinearLayout(context)
_G.PRINZ_MAIN_CONTAINER = mainContainer
mainContainer.setOrientation(LinearLayout.VERTICAL)
mainContainer.setBackground(createShape("#1A1A24", 24, 2, "#00E5FF"))
mainContainer.setPadding(35, 25, 35, 35)

--------------------------------------------------
-- Symmetrical Top Action Bar (Header)
--------------------------------------------------
local headerBar = LinearLayout(context)
headerBar.setOrientation(LinearLayout.HORIZONTAL)
headerBar.setGravity(Gravity.CENTER_VERTICAL)
headerBar.setPadding(0, 0, 0, 15)

local titleText = TextView(context)
titleText.setText("PRINZVAN SYSTEM CONFIG V2.0\nshielded Perception")
titleText.setTextColor(Color.parseColor("#FFFFFF"))
titleText.setTextSize(14)
titleText.setTypeface(Typeface.DEFAULT_BOLD)
titleText.setGravity(Gravity.CENTER)
local titleParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1.0)
titleText.setLayoutParams(titleParams)
headerBar.addView(titleText)

-- Single Right Symmetrical Close Control (×)
local closeButton = TextView(context)
closeButton.setText("×")
closeButton.setTextColor(Color.parseColor("#FFFFFF"))
closeButton.setTextSize(26)
closeButton.setPadding(15, 0, 5, 10)
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

-- Background Brand Identifier Text Area
local brandText = TextView(context)
brandText.setText("Prinzvan Modz")
brandText.setTextColor(Color.parseColor("#FFFFFF"))
brandText.setTextSize(20)
brandText.setGravity(Gravity.CENTER)
brandText.setPadding(0, 40, 0, 40)
mainContainer.addView(brandText)

-- Tabbed Navigation Menu Bar
local tabBar = LinearLayout(context)
tabBar.setOrientation(LinearLayout.HORIZONTAL)
tabBar.setPadding(0, 0, 0, 20)
mainContainer.addView(tabBar)

-- Dynamic FrameLayout content container
local contentFrame = FrameLayout(context)
mainContainer.addView(contentFrame)

-- Page and Button State Tables
local pages = {}
local tabButtons = {}

local function createPage()
    local page = LinearLayout(context)
    page.setOrientation(LinearLayout.VERTICAL)
    page.setVisibility(View.GONE)
    page.setLayoutParams(LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT))
    contentFrame.addView(page)
    return page
end

-- Initialize 5 default content frames
for i = 1, 5 do pages[i] = createPage() end

-- Manage visual activation of tabs
local function switchTab(index)
    for i = 1, #pages do
        if i == index then
            pages[i].setVisibility(View.VISIBLE)
            tabButtons[i].setTextColor(Color.parseColor("#FFFFFF"))
            tabButtons[i].setBackground(createShape("#2A2A3A", 8, 1, "#00E5FF"))
        else
            pages[i].setVisibility(View.GONE)
            tabButtons[i].setTextColor(Color.parseColor("#B0BEC5"))
            tabButtons[i].setBackground(createShape("#1A1A24", 8, 0, nil))
        end
    end
end

-- Create a functional navigation tab view
local function addTab(title, index)
    local btn = Button(context)
    local params = luajava.newInstance("android.widget.LinearLayout$LayoutParams", 0, LinearLayout.LayoutParams.WRAP_CONTENT, 1.0)
    btn.setLayoutParams(params)
    btn.setText(title)
    btn.setTextSize(10)
    btn.setPadding(0, 15, 0, 15)
    btn.setOnClickListener(luajava.createProxy("android.view.View$OnClickListener", {
        onClick = function(v) switchTab(index) end
    }))
    tabBar.addView(btn)
    tabButtons[index] = btn
end

-- Load Default tab definitions
local tabTitles = {"Shield", "Visuals", "Drone", "Prices", "System"}
for i, title in ipairs(tabTitles) do addTab(title, i) end

--------------------------------------------------
-- CONTENT CREATION CONSTRUCTORS (PAGES)
--------------------------------------------------

local function addPageText(page, text, color)
    local txt = TextView(context)
    txt.setText(text)
    txt.setTextColor(Color.parseColor(color or "#FFFFFF"))
    txt.setPadding(0, 8, 0, 8)
    page.addView(txt)
end

local function addPageButton(page, text, callback)
    local btn = Button(context)
    btn.setLayoutParams(LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT))
    btn.setText(text)
    btn.setTextColor(Color.parseColor("#FFFFFF"))
    btn.setBackground(createShape("#2A2A3A", 12, 1, "#00E5FF"))
    btn.setPadding(0, 18, 0, 18)
    btn.setOnClickListener(luajava.createProxy("android.view.View$OnClickListener", {
        onClick = function(v) callback() end
    }))
    page.addView(btn)
end

-- Page 1 (Shield)
addPageText(pages[1], "Status: Plan Verified [Free User]", "#00FF00")
addPageText(pages[1], "License Verification", "#FFFFFF")
addPageButton(pages[1], "VERIFY ACTIVE CONFIGURATION TOKEN", function()
    gg.toast("Verification logic running...")
end)

-- Page 2 (Visuals)
addPageText(pages[2], "Visual Interface Perception", "#FFFFFF")

-- Page 3 (Drone)
addPageText(pages[3], "Matrix Coordinates Console", "#FFFFFF")

-- Page 4 (Prices)
addPageText(pages[4], "Subscription Tiers", "#00E5FF")
addPageText(pages[4], "• 03 Days Access VIP\n• 07 Days Access VIP\n• 30 Days Access Base Access\n• Lifetime Access Base Access", "#FFFFFF")

-- Page 5 (System)
addPageText(pages[5], "UI Lifecycle Termination Matrix", "#B0BEC5")
addPageButton(pages[5], "CLOSE UI WINDOW", function()
    activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
        run = function()
            windowManager.removeView(mainContainer)
            windowManager.removeView(logoButton)
        end
    }))
end)

-- Activate base state
switchTab(1)

--------------------------------------------------
-- RENDER LOOP INITIALIZATION
--------------------------------------------------
activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
    run = function()
        windowManager.addView(logoButton, iconParams)
        windowManager.addView(mainContainer, mainParams)
    end
}))
