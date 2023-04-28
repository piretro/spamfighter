--Piretro Software SPAMFIGHTER 2023 Pietro Eccher - pure gideros lua mini game
Swidth = application:getDeviceWidth()
Sheight = application:getDeviceHeight()
--getRandomColor
local function getRdnCol()
	local color_digits = {0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f'}
	local out =""
	for i =1, 6 do 
		out = out..color_digits[math.random(#color_digits)]
	end
	return out
end
--popup class
Popup = Core.class(Sprite)
function Popup:init()
	local txts = {"BUY!!", "SAVE MORE!", "ENLARGE YOUR BRAIN", "SAY YES!", "NO TO NO!", "YES TO NO!", "MAKE BIG BUCKS!", "PRINCE OF NIGERIA HERE"}
	local txtgfx =  TextField.new(nil, "\e[color=#"..getRdnCol().."]"..txts[math.random(#txts)].."\e[color]")
	txtgfx:setScale(2) 
	local x,y,w,h = txtgfx:getBounds(self)
	local image =  Pixel.new("0x"..getRdnCol(), 1, w+50, h+50)
	self:addChild(image)
	image:addChild(txtgfx)
	txtgfx:setPosition(25, 40)	
	--close popup
	local xb = Pixel.new(0x0, 1, 20, 20)
	self:addChild(xb)
	xb:setPosition(w+35, -10)
	local xbt = TextField.new(nil, "\e[color=#fff]X\e[color]")
	xbt:setScale(2) 
	xbt:setPosition(6,17)
	xb:addChild(xbt)
	--drag popup
	local function onMD(self, event)
		if xb:hitTestPoint(event.x, event.y) then			
			self:removeFromParent()
			self = nil
			p=p-1 
			spamMaster(math.random(0,7))
		elseif image:hitTestPoint(event.x, event.y) then
			self.isFocus = true 
			self.x0 = event.x
			self.y0 = event.y
			event:stopPropagation() 
			stage:addChild(self)
		end
	end
	 
	local function onMM(self, event)
		if self.isFocus then
			local dx, dy = event.x - self.x0, event.y - self.y0
			self:setX(self:getX() + dx) 
			self:setY(self:getY() + dy)
			self.x0, self.y0 = event.x, event.y
			event:stopPropagation()
		end
	end
	 
	local function onMU(self, event)
		if self.isFocus then
			self.isFocus = false 
			spamMaster(math.random(25))
			event:stopPropagation()
		end
	end	 
	image:addEventListener(Event.MOUSE_DOWN, onMD, self)
	image:addEventListener(Event.MOUSE_MOVE, onMM, self)
	image:addEventListener(Event.MOUSE_UP, onMU, self)	
end

local function clickspam()	
	print("clickspam")
	spamMaster(math.random(25))
end
p = "0"
--drop popup
function spamMaster(n) 
	if p == 0 then 
		p = TextField.new(nil, "\e[color=#000]YOU WIN\e[color]") 
		p:setScale(4) p:setPosition(100,100) stage:addChild(p) else
		for i = 1, n do
			local popup = Popup.new()
			stage:addChild(popup)
			local w, h = popup:getWidth()*.5, popup:getHeight()*.5
			local maxw, maxh = math.floor(Swidth-w), math.floor(Sheight-h)
			local rx,ry  = math.random(-w, maxw ), math.random(-h, maxh)
			popup:setPosition(rx, ry)
			p=p+1
		end
	end
end
spamMaster(math.random(3))

