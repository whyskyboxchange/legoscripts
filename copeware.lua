--[[
 $$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$$$\ $$\      $$\  $$$$$$\  $$$$$$$\  $$$$$$$$\ 
$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|$$ | $\  $$ |$$  __$$\ $$  __$$\ $$  _____|
$$ /  \__|$$ /  $$ |$$ |  $$ |$$ |      $$ |$$$\ $$ |$$ /  $$ |$$ |  $$ |$$ |      
$$ |      $$ |  $$ |$$$$$$$  |$$$$$\    $$ $$ $$\$$ |$$$$$$$$ |$$$$$$$  |$$$$$\    
$$ |      $$ |  $$ |$$  ____/ $$  __|   $$$$  _$$$$ |$$  __$$ |$$  __$$< $$  __|   
$$ |  $$\ $$ |  $$ |$$ |      $$ |      $$$  / \$$$ |$$ |  $$ |$$ |  $$ |$$ |      
\$$$$$$  | $$$$$$  |$$ |      $$$$$$$$\ $$  /   \$$ |$$ |  $$ |$$ |  $$ |$$$$$$$$\ 
 \______/  \______/ \__|      \________|\__/     \__|\__|  \__|\__|  \__|\________| 
    
  [COPEWARE] 2023 ; Best Free Da hood hub
    • Credits:
        Developing : Russian Dog [Pof]
        UI : Linoria [UI Lib]
        ESP : Kiriot22
  [DISCORD] https://discord.gg/jNY4kGn6CM
]]
local DevelopedBy = "Russian Dog"
local JoinTheDiscord = "https://discord.gg/jNY4kGn6CM"

local COPEWARE_BASE_WATERMARK = 
	([[
 $$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$$$\ $$\      $$\  $$$$$$\  $$$$$$$\  $$$$$$$$\ 
$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|$$ | $\  $$ |$$  __$$\ $$  __$$\ $$  _____|
$$ /  \__|$$ /  $$ |$$ |  $$ |$$ |      $$ |$$$\ $$ |$$ /  $$ |$$ |  $$ |$$ |      
$$ |      $$ |  $$ |$$$$$$$  |$$$$$\    $$ $$ $$\$$ |$$$$$$$$ |$$$$$$$  |$$$$$\    
$$ |      $$ |  $$ |$$  ____/ $$  __|   $$$$  _$$$$ |$$  __$$ |$$  __$$< $$  __|   
$$ |  $$\ $$ |  $$ |$$ |      $$ |      $$$  / \$$$ |$$ |  $$ |$$ |  $$ |$$ |      
\$$$$$$  | $$$$$$  |$$ |      $$$$$$$$\ $$  /   \$$ |$$ |  $$ |$$ |  $$ |$$$$$$$$\ 
 \______/  \______/ \__|      \________|\__/     \__|\__|  \__|\__|  \__|\________|                                                                              
]]);

local Changelog = 
	([[
    v0.9: Used a misconfigured ui lib, had to recode everything
    v0.9A: Used pepsi's ui lib (broken)
    v0.9B: Used rayfield ui lib (changed it on later)
    v0.9C: Added a Camlock Tab
        -[1]: Switched to Linoria UI Lib
        -[2]: Started Project once again
    v1.0: Added Anti Aim / Misc Utilities
        -[1]: CFrame Speed
        -[2]: Spinbot
    v1.0A: Added Camlock, Silent Aim, Improved Anti Aim
    v1.0B: Improved Camlock [smoothness + resolver], easing style/direction of the smoothness, ping based prediction
        -[1]: Added Watermark Console
        -[2]: Added Execution Amount
    v1.0C: Improved Camlock [smoothness fixed + resolver prediction added], new anti aim's (Prediction Breaker)
        -[1]: Added Last Time Exeuction
    v1.1: Improved memory leaks, New functions, new anti aim's (Desync, Walkable Desync)
        -[1]: Fixed Troll AA Toggling on Right AA
        -[2]: Fixed FPS Drops
        -[3]: Added ESP Toggles (Global ESP Lib [NOT OWNED BY COPEWARE])
    v1.1A: Added Aimviewer
]]);

math.randomseed(1);

if (getgenv().COPEWARE_LOADED) then
	rconsolename(string.format("copeware [%s]", game:GetService("HttpService"):GenerateGUID(false)));
	rconsoleprint("@@LIGHT_CYAN@@");
	rconsoleprint(COPEWARE_BASE_WATERMARK .. "\n");
	rconsolewarn("COPEWARE IS LOADED ALREADY!\n");
	task.wait(1.5);
	rconsoleclear();
	return
end;

repeat
	task.wait();
until game:IsLoaded();
-- // VARIABLES
local DMG_GUI_BASE_ASSETID = "rbxassetid://8850953349";
local DMG_GUI_INFO = {
	winning = {
		yes = {text = "Winning: Yes"; color = Color3.fromRGB(20, 202, 47)};
		no = {text = "Winning: No"; color = Color3.fromRGB(255, 0, 0)};
		equal = {text = "Winning: Equal"; color = Color3.fromRGB(232, 235, 52)};
	};
};

local oldfunctions = {
	gc = {
		cgb = collectgarbage;
		ginfo = gcinfo;
	};
};
local rconsoleprint = rconsoleprint;
local rconsolewarn = rconsolewarn;
local rconsoleerr = rconsoleerr;
local mousemoverel = mousemoverel;
local unpack = table.unpack or unpack;
local getupvalue = debug.getupvalue or getupvalue;
local getupvalues = debug.getupvalues or getupvalues;
local setupvalue = debug.setupvalue or setupvalue
local getconstant = debug.getconstant or getconstant;
local getconstants = debug.getconstants or getconstants;
local setconstant = debug.setconstant or setconstant;
local getinfo = debug.getinfo or getinfo;
local isXClosure = is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or istempleclosure or checkclosure;
local isLClosure = islclosure or is_l_closure or (iscclosure and function(f) return not iscclosure(f) end);
local Players = game:GetService("Players");
local UIS = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local TweenService = game:GetService("TweenService");
local Workspace = Workspace or game:GetService("Workspace");
local workspace = workspace or game:GetService("Workspace");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local protectgui;

if syn then 
	protectgui = syn.protect_gui
elseif gethui then
	protectgui = function(obj)
		obj.Parent = gethui();
	end
else
	protectgui = function(obj) 
		obj.Parent = game:GetService("CoreGui");
	end
end

local function dragify(obj, dragsmoothness) 
	dragging = nil
	dragspeed = 0.25;
	draginput = nil;
	dragpos = nil;
	startpos = nil;
	dragstart = nil;

	local function updateinput(input) TweenService:Create(obj, TweenInfo.new(dragsmoothness), {Position = UDim2.new(startpos.X.Scale, startpos.X.Offset + (input.Position - dragstart).X, startpos.Y.Scale, startpos.Y.Offset + (input.Position - dragstart).Y)}):Play(); end
	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch and UIS:GetFocusedTextBox() == nil then
			dragging = true;
			dragstart = input.Position;
			startpos = obj.Position;
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then 
					dragging = false;
				end;
			end);
		end
	end)
	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
			draginput = input;
		end;
	end)
	UIS.InputChanged:Connect(function(input)
		if input == draginput and dragging then 
			updateinput(input);
		end;
	end);
end;

-- // LOCKING INFORMATION GUI
local BASE_DMG_UI = Instance.new("ScreenGui")
BASE_DMG_UI.Name = HttpService:GenerateGUID(false)
BASE_DMG_UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BASE_DMG_UI.IgnoreGuiInset = true
BASE_DMG_UI.ResetOnSpawn = false;

local TARGET_LOCKING_ON_FRAME = Instance.new("Frame")
TARGET_LOCKING_ON_FRAME.Name = HttpService:GenerateGUID(false);
TARGET_LOCKING_ON_FRAME.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
TARGET_LOCKING_ON_FRAME.BorderSizePixel = 1
TARGET_LOCKING_ON_FRAME.BorderColor3 = Color3.fromRGB(53, 53, 53)
TARGET_LOCKING_ON_FRAME.ClipsDescendants = true
TARGET_LOCKING_ON_FRAME.Position = UDim2.fromScale(0.4, 0.85)
TARGET_LOCKING_ON_FRAME.Size = UDim2.fromScale(0.2, 0.1)

local _GRADIENT = Instance.new("UIGradient")
_GRADIENT.Name = HttpService:GenerateGUID(false);
_GRADIENT.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 184, 184)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 11)),
})
_GRADIENT.Offset = Vector2.new(0, 0.125)
_GRADIENT.Rotation = 90
_GRADIENT.Parent = TARGET_LOCKING_ON_FRAME

local TOP_BAR = Instance.new("Frame")
TOP_BAR.Name = HttpService:GenerateGUID(false);
TOP_BAR.BackgroundColor3 = Color3.fromRGB(255, 201, 37)
TOP_BAR.BorderSizePixel = 0
TOP_BAR.Position = UDim2.fromScale(0, -0.00610)
TOP_BAR.Size = UDim2.fromScale(1, 0.036)

local _GRADIENT1 = Instance.new("UIGradient")
_GRADIENT1.Name = HttpService:GenerateGUID(false);
_GRADIENT1.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
_GRADIENT1.Offset = Vector2.new(0, 0.1)
_GRADIENT1.Rotation = 90
_GRADIENT1.Parent = TOP_BAR

TOP_BAR.Parent = TARGET_LOCKING_ON_FRAME

local TARGET_IMAGE = Instance.new("ImageLabel")
TARGET_IMAGE.Name = HttpService:GenerateGUID(false);
TARGET_IMAGE.Image = DMG_GUI_BASE_ASSETID
TARGET_IMAGE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TARGET_IMAGE.BackgroundTransparency = 1
TARGET_IMAGE.BorderSizePixel = 0
TARGET_IMAGE.Position = UDim2.fromScale(0.03, 0.225)
TARGET_IMAGE.Size = UDim2.fromScale(0.19, 0.62)
TARGET_IMAGE.Parent = TARGET_LOCKING_ON_FRAME

local TARGET_LABEL = Instance.new("TextLabel")
TARGET_LABEL.Name = HttpService:GenerateGUID(false);
TARGET_LABEL.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json");
TARGET_LABEL.Text = "dummy [dummy]" -- User / display
TARGET_LABEL.TextColor3 = Color3.fromRGB(202, 202, 202)
TARGET_LABEL.TextSize = 14
TARGET_LABEL.TextWrapped = true
TARGET_LABEL.TextXAlignment = Enum.TextXAlignment.Left
TARGET_LABEL.TextYAlignment = Enum.TextYAlignment.Top
TARGET_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TARGET_LABEL.BackgroundTransparency = 1
TARGET_LABEL.Position = UDim2.fromScale(0.256, 0.2)
TARGET_LABEL.Size = UDim2.fromScale(1, 0.267)

local _STROKE = Instance.new("UIStroke")
_STROKE.Name = HttpService:GenerateGUID(false);
_STROKE.Thickness = 1.35
_STROKE.Parent = TARGET_LABEL

local _GRADIENT2 = Instance.new("UIGradient")
_GRADIENT2.Name = HttpService:GenerateGUID(false);
_GRADIENT2.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
_GRADIENT2.Offset = Vector2.new(0, 0.15)
_GRADIENT2.Rotation = 90
_GRADIENT2.Parent = TARGET_LABEL

local _TSC = Instance.new("UITextSizeConstraint")
_TSC.Name = HttpService:GenerateGUID(false);
_TSC.MaxTextSize = 22
_TSC.MinTextSize = 18
_TSC.Parent = TARGET_LABEL

TARGET_LABEL.Parent = TARGET_LOCKING_ON_FRAME

local _PADDING = Instance.new("UIPadding")
_PADDING.Name = HttpService:GenerateGUID(false);
_PADDING.Parent = TARGET_LOCKING_ON_FRAME

local _HP = Instance.new("TextLabel")
_HP.Name = HttpService:GenerateGUID(false);
_HP.Font = Drawing.Fonts.Monospace;
_HP.Text = "HP: 100"
_HP.TextColor3 = Color3.fromRGB(202, 0, 0)
_HP.TextScaled = true
_HP.TextSize = 14
_HP.TextWrapped = true
_HP.TextXAlignment = Enum.TextXAlignment.Left
_HP.TextYAlignment = Enum.TextYAlignment.Top
_HP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_HP.BackgroundTransparency = 1
_HP.Position = UDim2.fromScale(0.256, 0.475)
_HP.Size = UDim2.fromScale(0.502, 0.243)

local _STROKE1 = Instance.new("UIStroke")
_STROKE1.Name = HttpService:GenerateGUID(false);
_STROKE1.Thickness = 1.35
_STROKE1.Parent = _HP

local _GRADIENT3 = Instance.new("UIGradient")
_GRADIENT3.Name = HttpService:GenerateGUID(false);
_GRADIENT3.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
_GRADIENT3.Offset = Vector2.new(0, 0.15)
_GRADIENT3.Rotation = 90
_GRADIENT3.Parent = _HP

local _TSC1 = Instance.new("UITextSizeConstraint")
_TSC1.Name = HttpService:GenerateGUID(false);
_TSC1.MaxTextSize = 18
_TSC1.MinTextSize = 18
_TSC1.Parent = _HP

_HP.Parent = TARGET_LOCKING_ON_FRAME

local _ISWINNING = Instance.new("TextLabel")
_ISWINNING.Name = HttpService:GenerateGUID(false);
_ISWINNING.Font = Drawing.Fonts.Monospace;
_ISWINNING.Text = "Winning: Yes"
_ISWINNING.TextColor3 = Color3.fromRGB(20, 202, 47)
_ISWINNING.TextScaled = true
_ISWINNING.TextSize = 14
_ISWINNING.TextWrapped = true
_ISWINNING.TextXAlignment = Enum.TextXAlignment.Left
_ISWINNING.TextYAlignment = Enum.TextYAlignment.Top
_ISWINNING.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_ISWINNING.BackgroundTransparency = 1
_ISWINNING.Position = UDim2.fromScale(0.256, 0.725)
_ISWINNING.Size = UDim2.fromScale(0.502, 0.243)

local _STROKE2 = Instance.new("UIStroke")
_STROKE2.Name = HttpService:GenerateGUID(false);
_STROKE2.Thickness = 1.35
_STROKE2.Parent = _ISWINNING

local _GRADIENT4 = Instance.new("UIGradient")
_GRADIENT4.Name = HttpService:GenerateGUID(false);
_GRADIENT4.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
_GRADIENT4.Offset = Vector2.new(0, 0.15)
_GRADIENT4.Rotation = 90
_GRADIENT4.Parent = _ISWINNING

local _TSC2 = Instance.new("UITextSizeConstraint")
_TSC2.Name = HttpService:GenerateGUID(false);
_TSC2.MaxTextSize = 18
_TSC2.MinTextSize = 18
_TSC2.Parent = _ISWINNING

_ISWINNING.Parent = TARGET_LOCKING_ON_FRAME

local _TITLE = Instance.new("TextLabel")
_TITLE.Name = HttpService:GenerateGUID(false);
_TITLE.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json")
_TITLE.Text = "TARGET"
_TITLE.TextColor3 = Color3.fromRGB(202, 202, 202)
_TITLE.TextScaled = true
_TITLE.TextSize = 14
_TITLE.TextWrapped = true
_TITLE.TextXAlignment = Enum.TextXAlignment.Left
_TITLE.TextYAlignment = Enum.TextYAlignment.Top
_TITLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_TITLE.BackgroundTransparency = 1
_TITLE.Position = UDim2.fromScale(0.015, 0.806)
_TITLE.Size = UDim2.fromScale(0.99, 0.15)

local _TITLE2 = Instance.new("TextLabel")
_TITLE2.Name = HttpService:GenerateGUID(false);
_TITLE2.Font = Drawing.Fonts.Monospace;
_TITLE2.Text = "COPEWARE"
_TITLE2.TextColor3 = Color3.fromRGB(202, 202, 202)
_TITLE2.TextScaled = true
_TITLE2.TextSize = 14
_TITLE2.TextWrapped = true
_TITLE2.TextXAlignment = Enum.TextXAlignment.Left
_TITLE2.TextYAlignment = Enum.TextYAlignment.Top
_TITLE2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_TITLE2.BackgroundTransparency = 1
_TITLE2.Position = UDim2.fromScale(0.01, 0.05)
_TITLE2.Size = UDim2.fromScale(0.580, 0.135)

local _STROKE3 = Instance.new("UIStroke")
_STROKE3.Name = HttpService:GenerateGUID(false);
_STROKE3.Thickness = 1.35
_STROKE3.Parent = _TITLE

local _STROKE4 = Instance.new("UIStroke")
_STROKE4.Name = HttpService:GenerateGUID(false);
_STROKE4.Thickness = 1.25
_STROKE4.Parent = _TITLE2

_TITLE.Parent = TARGET_LOCKING_ON_FRAME
_TITLE2.Parent = TARGET_LOCKING_ON_FRAME

TARGET_LOCKING_ON_FRAME.Parent = BASE_DMG_UI;
dragify(TARGET_LOCKING_ON_FRAME, 0.035);

pcall(function()
	BASE_DMG_UI.Parent = game.CoreGui;
	protectgui(BASE_DMG_UI);
end);

local GameData = (HttpService:JSONDecode(game:HttpGet(('https://games.roproxy.com/v1/games?universeIds=%s'):format(tostring(game.GameId))))["data"])[1];
local OldVelocity = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;

getgenv().COPEWARE_BASE_SETTINGS = {
	Instance_Names = {
		Spinbot = {Title = "copeBOT"; Spin = function() local Spinbot = Instance.new("BodyAngularVelocity"); Spinbot.Name = "copeBOT"; Spinbot.MaxTorque = Vector3.new(0, math.huge, 0); return Spinbot; end}
	};
	ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))();
	Lock_CACHE = {
		HIT_PART = "HumanoidRootPart";
		TARGET_LOCKING_ON = nil;
		cached_targets = {};
	};
	Aimviewer_CACHE = {
		Beam = Instance.new("Beam");
		HeadAttachment = Instance.new("Attachment");
		MousePosAttachment = Instance.new("Attachment");
		TARGET_VIEWING_ON = nil;
		cached_targets = {};
	};
	Chams_CACHE = {
		Cham = Instance.new("Highlight");
	};
	SPECIAL_GAMES = {DaHood = 2788229376};
	LP = {LocalPlayer = Players.LocalPlayer or game:GetService("Players").LocalPlayer};
	Mouse = Players.LocalPlayer:GetMouse() or game:GetService("Players").LocalPlayer:GetMouse();
	Title = "copeware.cc";
	Version = "v1.1A";
	AccentColor = Color3.fromRGB(52, 235, 52);
	Watermark = "COPEWARE4L";
	Library = {
		URL = "https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua";
		BetaURL = "https://raw.githubusercontent.com/NatsuDevs/Linoria-Rewrite-Modded-/main/Lib.lua";
		Documentation = "https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Example.lua";
		UILib = "Linoria";
	};
	Folder = {
		Name = "copeware";
	};
	Values = {
		-- // Anticheat bypass
		ACBypass = false;

		-- // Resolver
		ResolverSettings = {
			Resolver = {
				MIN = -10000;
				MAX = 10000
			};
			ResolverPredictions = {
				-- Predictions
				Main = {VECTOR3 = Vector3.new(2.35, 0.85, 3.125); X = 2.35; Y = 0.85; Z = 3.125}; -- Most legit looking resolver prediction if they try to use aa on u;
				Blatant = {VECTOR3 = Vector3.new(3.5, 0.65, 2.5); X = 2.5; Y = 0.65; Z = 3.125}; -- Most blatant looking resolver prediction if they try to use aa on u;
				HVH = {VECTOR3 = Vector3.new(-5.75, 0.65, 4.125); X = -5.75; Y = 0.65; Z = 4.125}; -- Incase someone uses aa on u trying to prove their aa can't be resolved (Hacker vs Hacker prediction);
				Random = {X = math.random(-4.15, 5.25); Y = math.random(-0.25, 1.45); Z = math.random(-5.25, 4.5)};
				BEST = {VECTOR3 = Vector3.new(7.25, 1.10, 6.15); X = 7.25; Y = 1.10; Z = 6.15}; -- Best resolver prediction
				-- Selected Prediction
				BASE_RP_USAGE = "BEST"; -- Stands for base resolver prediction
			};
		};
		-- // Lock
		LockSettings = {
			PING_PREDICTIONS = {
				Low = 0.11;
				Medium = 0.1225;
				Hard = 0.1352;
				Laggy = 0.1504;
			};
			Smoothness = {
				BASE_SMOOTHNESS = 0.0062; -- // The actual smoothness of the lock, can be editted from any cross environment. (Can also be above the max value inputted below but the slider will reset it back to 5 or lower)
				MIN = 0;
				MAX = 5;
			};
			Prediction = {
				BASE_PREDICTION = 0.1639; -- // The actual prediction of the lock, can be editted from any cross environment. (Can also be above the max value inputted below but the slider will reset it back to 5 or lower)
				MIN = 0;
				MAX = 5;
			};
		};
		FindPlayerDistance = 150;
		-- // Anti Aim
		AA_VELOCITY = {
			MIN = -10000;
			MAX = 10000; 
		}; -- The X, Y, Z Velocity Sliders Values
		TROLL_AA_CONFIG = {
			MIN = -10000;
			MAX = 10000;
		};
		SKY_AA_CONFIG = {
			CFG_VELOCITY = Vector3.new(0, 1000, 0);
			HUMANOID_MATCH = function(SKY_V)
				local LP = game:GetService("Players").LocalPlayer;
				local CHAR = LP.Character;
				local HRP = CHAR.HumanoidRootPart;
				local X_V, Y_V, Z_V = HRP.Velocity.X, HRP.Velocity.Y, HRP.Velocity.Z;
				return Vector3.new(X_V, SKY_V or 1000, Z_V);
			end;
		};
		UNDERGROUND_AA_CONFIG = {
			CFG_VELOCITY = Vector3.new(0, -1000, 0);
			HUMANOID_MATCH = function(UNDERGROUND_V)
				local LP = game:GetService("Players").LocalPlayer;
				local CHAR = LP.Character;
				local HRP = CHAR.HumanoidRootPart;
				local X_V, Y_V, Z_V = HRP.Velocity.X, HRP.Velocity.Y, HRP.Velocity.Z;
				return Vector3.new(X_V, UNDERGROUND_V or -1000, Z_V);
			end;
		};
		LEFT_AA_CONFIG = {
			CFG_VELOCITY = Vector3.new(1000, 0, 0);
			HUMANOID_MATCH = function(LEFT_V)
				local LP = game:GetService("Players").LocalPlayer;
				local CHAR = LP.Character;
				local HRP = CHAR.HumanoidRootPart;
				local X_V, Y_V, Z_V = HRP.Velocity.X, HRP.Velocity.Y, HRP.Velocity.Z;
				return Vector3.new(LEFT_V or 1000, Y_V, Z_V);
			end;
		};
		RIGHT_AA_CONFIG = {
			CFG_VELOCITY = Vector3.new(-1000, 0, 0);
			HUMANOID_MATCH = function(RIGHT_V)
				local LP = game:GetService("Players").LocalPlayer;
				local CHAR = LP.Character;
				local HRP = CHAR.HumanoidRootPart;
				local X_V, Y_V, Z_V = HRP.Velocity.X, HRP.Velocity.Y, HRP.Velocity.Z;
				return Vector3.new(RIGHT_V or -1000, Y_V, Z_V);
			end;
		};
	};
	Booleans = {
		-- // IMPORTANT BOOLEANS
		LOCK_SMOOTHNESS_ENABLED = false;
		LOCK_TOGGLED = false; -- Toggle whether whenever you press the lock keybind to lcok on the target or not
		LOCK_ENABLED = false; -- Toggle whether if whenever you are pressing the keybind for the lock to lock on the target or not.
		ANTI_ENABLED = false; -- Toggle for anti lock
		DEADAA_CHECK = false; -- Toggle for dead check

		-- // CONFIGURATED ANTI BOOLEANS
		SKYAA = false;
		UNDERGROUNDAA = false;
		LEFTAA = false;
		RIGHTAA = false;
		TROLLAA = false;
		PBreaker = false;
		SPINAA = false;
		DESYNCAA = false;

		-- // IRELEVANT BOOLEANS
		DEAD_CHECK_ENABLED = false;
		SPINBOT_ENABLED = false;

		-- // AIMVIEWER BOOLEANS
		AIMVIEWER_ENABLED = false;
		AIMVIEWER_TOGGLED = false;
		-- // CFRAME SPEED BOOLEANS
		ACTIVATE_CFS_ENABLED = true; -- Toggle to activate cfs (pressing the cfs keybind will activate it)
		ACTIVATE_SB_ENABLED = true; -- Toggle to activate spinbot (pressing the sb keybind will activate it)
		CFS_ENABLED = false; -- Cframe Speed Keybind to actually start running like flash

	};
	Keybinds = {
		LockEnable = "Q"; --[[ LockEnable = nil ]] -- // Keybind to camlock on the humanoid
		HideUI = "Insert"; -- Keybind to hide ui
		CFS = "Z"; -- Keybind For Cframe Speed
		Aimviewer = "V"; -- Keybind For Aimviewer
	};
	Notifications = {
		ENTRY_NOTIFICATION = {
			Data = {
				Title = "copeware";
				Text = "COPEWARE LOADED! ENJOY";
				Duration = 2.5;
			};
			Boolean = false; -- // Boolean to decide whether when the hub is executed if it should send a core notification or not.
		}; 
	};
}; -- // GLOBAL SETTINGS / Cross Environment Modifications, Just incase you want to instantly disable your lock from your executor / change sets

local function searchClosure(script, upvalueIndex)
	for i, v in pairs(getgc()) do
		local parentScript = rawget(getfenv(v), 'script')

		if type(v) == 'function' and 
			isLClosure(v) and 
			not isXClosure(v) and 
			(
				(script == nil and parentScript.Parent == nil) or script == parentScript
			) 
				and pcall(getupvalue, v, upvalueIndex)
		then
			return v;
		end
	end
end

local function findGun(character) 
	for i, v in next, character:GetChildren() do 
		if v:IsA("Tool") and v:FindFirstChild("Handle") and string.sub(v.Name, 1, 1) == "[" and v:FindFirstChild("Handle"):FindFirstChildWhichIsA("Sound") then 
			return v;
		end
	end
end

-- // Important checks

if not isfolder(COPEWARE_BASE_SETTINGS.Folder.Name) then 
	makefolder(COPEWARE_BASE_SETTINGS.Folder.Name);
	makefolder(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood");
end;
if not isfile(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood/amount_loaded.json") then 
	writefile(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood/amount_loaded.json", HttpService:JSONEncode({LOADED_AMOUNT = 0}))
end;
if (COPEWARE_BASE_SETTINGS.Values.ACBypass == true) then
	if (game.PlaceId == COPEWARE_BASE_SETTINGS.SPECIAL_GAMES.DaHood) then 
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Da%20Hood/AntiCheatBypass.lua"))();
	elseif ReplicatedStorage:FindFirstChild("MainEvent") ~= nil then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Da%20Hood/AntiCheatBypass.lua"))();
	end; -- // Anti Cheat Bypass
end;
if (COPEWARE_BASE_SETTINGS.Notifications.ENTRY_NOTIFICATION.Boolean == true) then 
	StarterGui:SetCore("SendNotification", COPEWARE_BASE_SETTINGS.Notifications.ENTRY_NOTIFICATION.Data);
end;
-- How many times it was loaded
local CACHED_LAST_EXECUTION = HttpService:JSONDecode(readfile(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood/amount_loaded.json"))["LAST_EXECUTION"] or os.time();
writefile(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood/amount_loaded.json", HttpService:JSONEncode({
	LOADED_AMOUNT = HttpService:JSONDecode(readfile(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood/amount_loaded.json"))["LOADED_AMOUNT"] + 1; 
	LAST_EXECUTION = os.time();
}));
function LOAD_COPEWARE_WATERMARK()
	local COPEWARE_DATA = HttpService:JSONDecode(readfile(COPEWARE_BASE_SETTINGS.Folder.Name .. "/da-hood/amount_loaded.json"));
	rconsoleclear();
	rconsolename(string.format("copeware %s [%s : %d]", COPEWARE_BASE_SETTINGS.Version, COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Name, COPEWARE_BASE_SETTINGS.LP.LocalPlayer.UserId));
	rconsoleprint("@@WHITE@@");
	rconsoleprint("\n");
	rconsoleprint("copeware is ready to be executed, press [enter] to load");
	local Input = rconsoleinput();
	if Input == "\13" then rconsoleclear(); end
	rconsoleprint("\n");
	rconsoleprint("@@LIGHT_CYAN@@");
	rconsoleprint(COPEWARE_BASE_WATERMARK .. "\n");
	task.wait(.5);
	rconsoleprint("@@LIGHT_YELLOW@@");
	rconsoleprint(string.format("[%s : %d] - Executed %d Times (Last Execution: %s)", game:GetService("Players").LocalPlayer.Name, game:GetService("Players").LocalPlayer.UserId, COPEWARE_DATA["LOADED_AMOUNT"], tostring(os.date("%Y/%m/%d | %H:%M:%S", CACHED_LAST_EXECUTION))));
	rconsoleprint("\n");
	rconsoleprint(string.format("[Executor]: %s", identifyexecutor()));
	getgenv().COPEWARE_LOADED = true;
end;

LOAD_COPEWARE_WATERMARK();
local COPEWARE_LOAD_TIME = tick();
-- // Coding

local CACHE_COPEWARE_FOLDER = Instance.new("Folder", workspace);
CACHE_COPEWARE_FOLDER.Name = string.rep(HttpService:GenerateGUID(false), 10) .. math.random(1e10, 10e10);

-- // Libraries

local Library = loadstring(game:HttpGet(COPEWARE_BASE_SETTINGS.Library.URL))(); Library.Font = Enum.Font.RobotoMono;
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/ThemeManager.lua"))();
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/SaveManager.lua"))();
-- // Window
Library:SetWatermarkVisibility(true)
Library:SetWatermark(COPEWARE_BASE_SETTINGS.Watermark)

COPEWARE_BASE_SETTINGS.Chams_CACHE.Cham.Name = "copeware|chams";
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Enabled = false;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Segments = 1;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Attachment0 = COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.HeadAttachment;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Attachment1 = COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.MousePosAttachment;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Width0 = 0.15;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Width1 = 0.15;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.FaceCamera = true;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Parent = workspace.Terrain;

COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.HeadAttachment.Name = "copeware|head";
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.MousePosAttachment.Name = "copeware|mousepos";

COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.HeadAttachment.Parent = workspace.Terrain;
COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.MousePosAttachment.Parent = workspace.Terrain;

local Window = Library:CreateWindow({
	Title = string.format("%s - %s - %d", (COPEWARE_BASE_SETTINGS.Title or "copeware"), COPEWARE_BASE_SETTINGS.LP.LocalPlayer.DisplayName, COPEWARE_BASE_SETTINGS.LP.LocalPlayer.UserId) or string.format("copeware - example - %d", math.random(1000000, 99999999));
	Center = false;
	AutoShow = false,
})

-- // CHEATS
local CamlockTab = Window:AddTab("Camlock"); -- // Camlock
local SilentAimTab = Window:AddTab("Silent"); -- // Silent Aim
local AntiAimTab = Window:AddTab("AA"); -- // Anti Aim
local MiscTab = Window:AddTab("Misc"); -- // Misc
-- // IRELEVANT
local SettingsTab = Window:AddTab("Settings"); -- // Settings

-- [[ Tab Coding ]] --
-----------------------------
-- // MAIN
local LockBox = CamlockTab:AddLeftGroupbox("Camlock");
LockBox:AddToggle("LOCKTOGGLE", {
	Text = "Camlock";
	Default = false;
	Tooltip = "Toggles lock on / off"
});
LockBox:AddToggle("SMOOTHNESSTOGGLE", {
	Text = "Smoothness";
	Default = false;
	Tooltip = "Toggles lock smoothness on / off"
});
LockBox:AddLabel("Lock Keybind"):AddKeyPicker("LOCKKeybind", { 
	Default = COPEWARE_BASE_SETTINGS.Keybinds.LockEnable;
	Mode = "Toggle";
	Text = "Uses WorldToViewportPoint on the position of the target then does the prediction you chose to lock on.";
});
LockBox:AddDivider();
LockBox:AddToggle("LOCKPREDICTION_ENABLED", {
	Text = "Prediction";
	Default = false;
	Tooltip = "Toggles lock prediction on / off"
});
LockBox:AddToggle("PING_BASED_PREDICTION", {
	Text = "Ping Based Prediction";
	Default = false;
	Tooltip = "Will set the prediction to the right amount based on the ping of the machine running the script."
});
--[[LockBox:AddSlider("LockSmoothness", {
    Text = "Smoothness";
    Default = 0.0862;
    Min = COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.MIN;
    Max = COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.MAX;
    Rounding = 4; -- // DEICMAL POINT : 2
    Compact = false;
});]]
LockBox:AddInput("LockSmoothnessBOX", {
	Default = 0.0062;
	Numeric = true;
	Finished = true;
	Text = "Smoothness";
	Tooltip = "Edits smoothness of the lock.";
	Placeholder = "smoothness value";
});
--[[LockBox:AddSlider("LockPrediction", {
    Text = "Prediction";
    Default = 0.1509;
    Min = COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.MIN or 0.0;
    Max = COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.MAX or 5;
    Rounding = 4; -- // DEICMAL POINT : 2
    Compact = false;
});]]
LockBox:AddInput("LockPredictionBOX", {
	Default = 0.1639;
	Numeric = true;
	Finished = true;
	Text = "Prediction";
	Tooltip = "Edits prediction of the lock.";
	Placeholder = "prediction value";
});
LockBox:AddDivider();
LockBox:AddDropdown("CamlockHitPart", {
	Values = (function()
		if GameData.universeAvatarType == "MorphToR15" then 
			return 
				{
					-- // Torso / HRP
					"HumanoidRootPart";
					"UpperTorso";
					"LowerTorso";
					-- // Arms / Hands
					"RightUpperArm";
					"RightLowerArm";
					"LeftUpperArm";
					"LeftLowerArm";
					"RightHand";
					"LeftHand";
					-- // Legs / Feet
					"RightFoot";
					"LeftFoot"; 
					"RightLowerLeg";
					"RightUpperLeg";
					"LeftLowerLeg";
					"LeftUpperLeg";
					-- // Head
					"Head";
				};
		elseif GameData.universeAvatarType == "MorphToR6" then 
			return
				{
					-- // Torso / HRP
					"HumanoidRootPart";
					"Torso";
					-- // Arms / Hands
					"Right Arm";
					"Left Arm";
					-- // Legs / Feet
					"Right Leg";
					"Left Leg";
					-- // Head
					"Head";
				};
		elseif GameData.universeAvatarType == "PlayerChoice" then 
			return 
				{
					-- // Torso / HRP
					"HumanoidRootPart";
					"UpperTorso";
					"LowerTorso";
					"Torso";
					-- // Arms / Hands
					"Right Arm";
					"Left Arm";
					"RightUpperArm";
					"RightLowerArm";
					"LeftUpperArm";
					"LeftLowerArm";
					"RightHand";
					"LeftHand";
					-- // Legs / Feet
					"Right Leg";
					"Left Leg";
					"RightFoot";
					"LeftFoot"; 
					"RightLowerLeg";
					"RightUpperLeg";
					"LeftLowerLeg";
					"LeftUpperLeg";
					-- // Head
					"Head"; 
				};
		end
	end)();
	Default = GameData.universeAvatarType == "MorphToR15" and 1 or GameData.universeAvatarType == "MorphToR6" and 1 or GameData.universeAvatarType == "PlayerChoice" and math.random(1, 5);
	Multi = false;
	Text = GameData.universeAvatarType == "MorphToR6" and "Hit Part [R6]" or GameData.universeAvatarType == "MorphToR15" and "Hit Part [R15]" or GameData.universeAvatarType == "PlayerChoice" and "Hit Part [R6/R15]";
	Tooltip = "Part the camlock picks up on.";
});
LockBox:AddDropdown("LOCKTYPE", {
	Values = {"First Person", "Third Person"};
	Default = 1;
	Multi = false;
	Text = "Lock Type [FPS/TPS]";
	Tooltip = "Type of how the lock will function (fp = locks mouse in center, tp = doesnt do anything)";
});
LockBox:AddToggle("LOCK_CHAMS", {
	Text = "Chams";
	Default = false;
	Tooltip = "Toggles lock's chams on / off"
});
LockBox:AddLabel("Chams Color"):AddColorPicker("CHAMS_COLOR", {
	Default = Color3.fromRGB(44, 62, 104);
	Title = "Chams Color";
});
LockBox:AddDivider();
Toggles.LOCKTOGGLE:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.LOCK_TOGGLED = Toggles.LOCKTOGGLE.Value;
end);
Toggles.SMOOTHNESSTOGGLE:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.LOCK_SMOOTHNESS_ENABLED = Toggles.SMOOTHNESSTOGGLE.Value;
end);
Options.CamlockHitPart:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Lock_CACHE.HIT_PART = Options.CamlockHitPart.Value;
end);
Options.LockPredictionBOX:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION = Options.LockPredictionBOX.Value;
end);
Options.LockSmoothnessBOX:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS = Options.LockSmoothnessBOX.Value;
end);
Options.LOCKKeybind:OnClick(function()
	COPEWARE_BASE_SETTINGS.Keybinds.LockEnable = Options.LOCKKeybind.Value;
end);
-- // Resolver
local ResolverBox = CamlockTab:AddRightGroupbox("Resolver");
ResolverBox:AddToggle("RESOLVERTOGGLE", {
	Text = "Resolver";
	Default = false;
	Tooltip = "Toggles resolver on / off"
});
ResolverBox:AddToggle("EXPERIMENTALRESOLVERTOGGLE", {
	Text = "Experimental Resolver";
	Default = false;
	Tooltip = "Toggles experimental resolver on / off"
});
ResolverBox:AddToggle("INSTANTRESOLVER", {
	Text = "Instant Resolver";
	Default = false;
	Tooltip = "Resolve their Velocity instantly.";
});
ResolverBox:AddDivider();
ResolverBox:AddToggle("RESOLVERPREDICTION", {
	Text = "Resolver Prediction";
	Default = false;
	Tooltip = "Toggles resolver prediction on / off"
});
ResolverBox:AddSlider("RP_X", {
	Text = "X Velocity";
	Default = 0;
	Min = -20;
	Max = 20;
	Rounding = 2; -- // DECIMAL POINT: 2 (1.50);
	Compact = false;
});
ResolverBox:AddSlider("RP_Y", {
	Text = "Y Velocity";
	Default = 0;
	Min = -20;
	Max = 20;
	Rounding = 2; -- // DECIMAL POINT: 2 (1.50);
	Compact = false;
});
ResolverBox:AddSlider("RP_Z", {
	Text = "Z Velocity";
	Default = 0;
	Min = -20;
	Max = 20;
	Rounding = 2; -- // DECIMAL POINT: 2 (1.50);
	Compact = false;
});
-- // Resolver Prediction Sliders
ResolverBox:AddDivider();
ResolverBox:AddLabel("Velocities", true);
-- // Velocities booleans
ResolverBox:AddToggle("XRESOLVER", {
	Text = "X Velocity";
	Default = false;
	Tooltip = "Resolve the X Velocity";
});
ResolverBox:AddToggle("YRESOLVER", {
	Text = "Y Velocity";
	Default = false;
	Tooltip = "Resolve the Y Velocity";
});
ResolverBox:AddToggle("ZRESOLVER", {
	Text = "Z Velocity";
	Default = false;
	Tooltip = "Resolve the Z Velocity";
});
ResolverBox:AddDivider();
-- // Velocity Sliders
ResolverBox:AddSlider("XRESOLVERVEL", {
	Text = "X Velocity";
	Default = 0;
	Min = COPEWARE_BASE_SETTINGS.Values.ResolverSettings.Resolver.MIN or -10000;
	Max = COPEWARE_BASE_SETTINGS.Values.ResolverSettings.Resolver.MAX or 10000;
	Rounding = 0;
	Compact = false;
});
ResolverBox:AddSlider("YRESOLVERVEL", {
	Text = "Y Velocity";
	Default = 0;
	Min = COPEWARE_BASE_SETTINGS.Values.ResolverSettings.Resolver.MIN or -10000;
	Max = COPEWARE_BASE_SETTINGS.Values.ResolverSettings.Resolver.MAX or 10000;
	Rounding = 0;
	Compact = false;
});
ResolverBox:AddSlider("ZRESOLVERVEL", {
	Text = "Z Velocity";
	Default = 0;
	Min = COPEWARE_BASE_SETTINGS.Values.ResolverSettings.Resolver.MIN or -10000;
	Max = COPEWARE_BASE_SETTINGS.Values.ResolverSettings.Resolver.MAX or 10000;
	Rounding = 0;
	Compact = false;
});
ResolverBox:AddDivider();
-- // Settings
LockBox:AddToggle("LOCK_DEAD_CHECK", {
	Text = "Dead Check";
	Default = false;
	Tooltip = "If target trying to lock on is dead, then it won't lock on them.";
});
LockBox:AddToggle("AirshotENABLED", {
	Text = "Airshot Toggle";
	Default = false;
	Tooltip = "If target trying to lock on jumps, it will lock on the selected part below the toggle.";
});
LockBox:AddDivider();
LockBox:AddDropdown("AirshotHitPart", {
	Values = (function()
		if GameData.universeAvatarType == "MorphToR15" then 
			return 
				{
					-- // Torso / HRP
					"HumanoidRootPart";
					"UpperTorso";
					"LowerTorso";
					-- // Arms / Hands
					"RightUpperArm";
					"RightLowerArm";
					"LeftUpperArm";
					"LeftLowerArm";
					"RightHand";
					"LeftHand";
					-- // Legs / Feet
					"RightFoot";
					"LeftFoot"; 
					"RightLowerLeg";
					"RightUpperLeg";
					"LeftLowerLeg";
					"LeftUpperLeg";
					-- // Head
					"Head";
				};
		elseif GameData.universeAvatarType == "MorphToR6" then 
			return
				{
					-- // Torso / HRP
					"HumanoidRootPart";
					"Torso";
					-- // Arms / Hands
					"Right Arm";
					"Left Arm";
					-- // Legs / Feet
					"Right Leg";
					"Left Leg";
					-- // Head
					"Head";
				};
		elseif GameData.universeAvatarType == "PlayerChoice" then 
			return 
				{
					-- // Torso / HRP
					"HumanoidRootPart";
					"UpperTorso";
					"LowerTorso";
					"Torso";
					-- // Arms / Hands
					"Right Arm";
					"Left Arm";
					"RightUpperArm";
					"RightLowerArm";
					"LeftUpperArm";
					"LeftLowerArm";
					"RightHand";
					"LeftHand";
					-- // Legs / Feet
					"Right Leg";
					"Left Leg";
					"RightFoot";
					"LeftFoot"; 
					"RightLowerLeg";
					"RightUpperLeg";
					"LeftLowerLeg";
					"LeftUpperLeg";
					-- // Head
					"Head"; 
				};
		end
	end)();
	Default = GameData.universeAvatarType == "MorphToR15" and 3 or GameData.universeAvatarType == "MorphToR6" and 2 or GameData.universeAvatarType == "PlayerChoice" and math.random(3, 6);
	Multi = false;
	Text = GameData.universeAvatarType == "MorphToR6" and "Airshot Part [R6]" or GameData.universeAvatarType == "MorphToR15" and "Airshot Part [R15]" or GameData.universeAvatarType == "PlayerChoice" and "Airshot Part [R6/R15]";
	Tooltip = "Part to lock on when the target jumps if enabled.";
});
LockBox:AddDivider();
LockBox:AddLabel("Smoothness easing / direction", true);
LockBox:AddDropdown("SmoothnessEasingStyle", {
	Values = {
		"Linear";
		"Sine";
		"Back";
		"Quad";
		"Quart";
		"Quint";
		"Bounce";
		"Elastic";
		"Exponential";
		"Circular";
		"Cubic";
	};
	Default = 8;
	Multi = false;
	Text = "Easing Style";
	Tooltip = "Easing style of how the camera will lerp using smoothness.";
}); -- Options.SmoothnessEasingStyle.Value
LockBox:AddDropdown("SmoothnessEasingDirection", {
	Values = {
		"In";
		"Out";
		"InOut";
	};
	Default = 3;
	Multi = false;
	Text = "Easing Direction";
	Tooltip = "Easing direction of how the camera will lerp using smoothness.";
}); -- Options.SmoothnessEasingDirection.Value
-- // Lock Function
function GetNearestPlayer()
	local dist = COPEWARE_BASE_SETTINGS.Values.FindPlayerDistance;
	local Target = nil
	for i, v in pairs(Players:GetPlayers()) do
		if v ~= (COPEWARE_BASE_SETTINGS.LP.LocalPlayer or game:GetService("Players").LocalPlayer) and v.Character:FindFirstChild("Humanoid") and (Toggles.LOCK_DEAD_CHECK.Value == true and v.Character:FindFirstChild("Humanoid").Health > 0 or Toggles.LOCK_DEAD_CHECK.Value == false and v.Character:FindFirstChild("Humanoid").Health) and v.Character:FindFirstChild(COPEWARE_BASE_SETTINGS.Lock_CACHE.HIT_PART) and v then
			local TheirCharacter = v.Character
			local CharacterRoot, Visible = workspace.CurrentCamera:WorldToViewportPoint(TheirCharacter[COPEWARE_BASE_SETTINGS.Lock_CACHE.HIT_PART].Position)
			if Visible then
				local RealMag = (Vector2.new(COPEWARE_BASE_SETTINGS.Mouse.X, COPEWARE_BASE_SETTINGS.Mouse.Y) - Vector2.new(CharacterRoot.X, CharacterRoot.Y)).Magnitude
				if RealMag < dist then
					dist = RealMag
					Target = v;
				end
			end
		end
	end
	return Target
end
--[[ResolverBox:AddInput("RESOLVERTARGET", {
    Default = "";
    Numeric = false;
    Finished = false;
    Text = "Target";
    Tooltip = "Resolve the target's hrp.";
    Placeholder = "";
});]]
-------------------------
-- // ANTI AIM
local AntiAimBox = AntiAimTab:AddLeftGroupbox("Anti Aim");
local AntiAimBox2 = AntiAimTab:AddRightGroupbox("Config AA");
local AntiAimBox3 = AntiAimTab:AddLeftGroupbox("Settings");
AntiAimBox2:AddToggle("SKYAA", {
	Text = "SKY AA";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim in the air";
});
AntiAimBox2:AddToggle("UNDERGROUNDAA", {
	Text = "UNDERGROUND AA";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim under the ground";
});
AntiAimBox2:AddToggle("LEFTAA", {
	Text = "LEFT AA";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim in the left position";
});
AntiAimBox2:AddToggle("RIGHTAA", {
	Text = "RIGHT AA";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim in the right position";
});
AntiAimBox2:AddToggle("TROLLAA", {
	Text = "TROLL AA (Powerful / God)";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim in random positions";
});
AntiAimBox2:AddToggle("PREDICTIONBREAKER", {
	Text = "Prediction Breaker";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim in random positions";
});
AntiAimBox2:AddToggle("SPINAA", {
	Text = "Spin AA (Powerful / God)";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim in random positions";
});
-----------------------------
AntiAimBox:AddToggle("AA", {
	Text = "AA Toggle";
	Default = false;
	Tooltip = "Modifies HRP Velocity to patch camlock / silent aim";
});
AntiAimBox:AddDivider();
AntiAimBox:AddLabel("Velocities", true);
-- // SLIDERS
AntiAimBox:AddSlider("Vel_X", {
	Text = "X Velocity";
	Default = 0;
	Min = COPEWARE_BASE_SETTINGS.Values.AA_VELOCITY.MIN;
	Max = COPEWARE_BASE_SETTINGS.Values.AA_VELOCITY.MAX;
	Rounding = 0;
	Compact = false;
});
AntiAimBox:AddSlider("Vel_Y", {
	Text = "Y Velocity";
	Default = 0;
	Min = COPEWARE_BASE_SETTINGS.Values.AA_VELOCITY.MIN;
	Max = COPEWARE_BASE_SETTINGS.Values.AA_VELOCITY.MAX;
	Rounding = 0;
	Compact = false;
});
AntiAimBox:AddSlider("Vel_Z", {
	Text = "Z Velocity";
	Default = 0;
	Min = COPEWARE_BASE_SETTINGS.Values.AA_VELOCITY.MIN;
	Max = COPEWARE_BASE_SETTINGS.Values.AA_VELOCITY.MAX;
	Rounding = 0;
	Compact = false;
});
-----------------------------
AntiAimBox3:AddToggle("AADEAD", {
	Text = "Dead Check";
	Default = false;
	Tooltip = "Incase the anti aim feature is enabled, whenever you will be ragdolled / dead, your body won't fly or fling itself.";
})
-----------------------------
-- // Toggles

Toggles.AADEAD:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.DEADAA_CHECK = Toggles.AADEAD.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.DEADAA_CHECK == true then
			if game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health < 1 then 
				COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED = true;
			elseif game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
				COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED = false;
			end
		end
		RunService.RenderStepped:Wait();
	end)
end);

-- // NORMAL AA WITH CUSTOM VELOCITY
Toggles.AA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.ANTI_ENABLED = Toggles.AA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.ANTI_ENABLED == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = Vector3.new(Options.Vel_X.Value, Options.Vel_Y.Value, Options.Vel_Z.Value);
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head

		end
	end); -- // There was no other faster loop than this that wouldn't break
end)
-----------------------------
-- // CONFIGURATED AA'S
Toggles.SPINAA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.SPINAA = Toggles.SPINAA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.SPINAA == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.UpperTorso.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LowerTorso.CFrame *= CFrame.Angles(0, 0.1, 0);
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LeftHand.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.RightHand.CFrame *= CFrame.Angles(0, 0.1, 0);

			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LeftFoot.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.RightFoot.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.CFrame *= CFrame.Angles(0, 0.1, 0);

			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.CFrame *= CFrame.Angles(0, 0.1, 0);
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = Vector3.new(1, 1, 1) * 2^16;
			game:GetService("Players").LocalPlayer.Character.Head.CFrame *= CFrame.Angles(0, 0.1, 0);
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end); -- SPIN AA
Toggles.SKYAA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.SKYAA = Toggles.SKYAA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.SKYAA == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = COPEWARE_BASE_SETTINGS.Values.SKY_AA_CONFIG.CFG_VELOCITY;
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end); -- SKY [+Y] ( Vector3.new(0, 10, 0) )
Toggles.UNDERGROUNDAA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.UNDERGROUNDAA = Toggles.UNDERGROUNDAA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.UNDERGROUNDAA == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = COPEWARE_BASE_SETTINGS.Values.UNDERGROUND_AA_CONFIG.CFG_VELOCITY;
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end); -- UNDERGROUND [-Y] ( Vector3.new(0,-10,0) )
Toggles.LEFTAA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.LEFTAA = Toggles.LEFTAA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.LEFTAA == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = COPEWARE_BASE_SETTINGS.Values.LEFT_AA_CONFIG.CFG_VELOCITY;
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end); -- LEFT [+X] ( Vector3.new(10,0,0) )
Toggles.RIGHTAA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.RIGHTAA = Toggles.RIGHTAA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.RIGHTAA == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = COPEWARE_BASE_SETTINGS.Values.RIGHT_AA_CONFIG.CFG_VELOCITY;
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end); -- RIGHT [-X] ( Vector3.new(-10,0,0) )
Toggles.TROLLAA:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.TROLLAA = Toggles.TROLLAA.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.TROLLAA == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = Vector3.new(math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX), math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX));
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end) -- RANDOM [+X,+Y,+Z],[-X,-Y,-Z] : math.random(COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MIN, COPEWARE_BASE_SETTINGS.Values.TROLL_AA_CONFIG.MAX)
Toggles.PREDICTIONBREAKER:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Booleans.PBreaker = Toggles.PREDICTIONBREAKER.Value;
	RunService.Heartbeat:Connect(function()
		if COPEWARE_BASE_SETTINGS.Booleans.PBreaker == true and COPEWARE_BASE_SETTINGS.Booleans.DEAD_CHECK_ENABLED ~= true then
			-- Old Velocity Variables
			local OldVelocitys = {
				-- Torsos
				HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity;
				UpperTorso = game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity;
				LowerTorso = game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity;
				-- Arms / Hands
				LeftUpperArm = game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity;
				LeftLowerArm = game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity;
				RightUpperArm = game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity;
				RightLowerArm = game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity;
				LeftHand = game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity;
				RightHand = game:GetService("Players").LocalPlayer.Character.RightHand.Velocity;    
				-- Legs / Feet
				LeftFoot = game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity;
				RightFoot = game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity;
				LeftLowerLeg = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity;
				LeftUpperLeg = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity;
				RightLowerLeg = game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity;
				RightUpperLeg = game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity;
				-- Head
				Head = game:GetService("Players").LocalPlayer.Character.Head.Velocity;
			};
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = Vector3.new(9e9, 0, 9e9);
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = Vector3.new(9e9, 0, 9e9);
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = Vector3.new(9e9, 0, 9e9);
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = Vector3.new(9e9, 0, 9e9);
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = Vector3.new(9e9, 0, 9e9);
			-----------------------------
			RunService.RenderStepped:Wait();
			-- Torsos
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocitys.HRP
			game:GetService("Players").LocalPlayer.Character.UpperTorso.Velocity = OldVelocitys.UpperTorso
			game:GetService("Players").LocalPlayer.Character.LowerTorso.Velocity = OldVelocitys.LowerTorso
			-- Arms / Hands
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Velocity = OldVelocitys.LeftUpperArm
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Velocity = OldVelocitys.LeftLowerArm
			game:GetService("Players").LocalPlayer.Character.RightUpperArm.Velocity = OldVelocitys.RightUpperArm
			game:GetService("Players").LocalPlayer.Character.RightLowerArm.Velocity = OldVelocitys.RightLowerArm
			game:GetService("Players").LocalPlayer.Character.LeftHand.Velocity = OldVelocitys.LeftHand
			game:GetService("Players").LocalPlayer.Character.RightHand.Velocity = OldVelocitys.RightHand
			-- Legs / Feet
			game:GetService("Players").LocalPlayer.Character.LeftFoot.Velocity = OldVelocitys.LeftFoot
			game:GetService("Players").LocalPlayer.Character.RightFoot.Velocity = OldVelocitys.RightFoot
			game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Velocity = OldVelocitys.LeftLowerLeg
			game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Velocity = OldVelocitys.LeftUpperLeg
			game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Velocity = OldVelocitys.RightLowerLeg
			game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Velocity = OldVelocitys.RightUpperLeg
			-- Head
			game:GetService("Players").LocalPlayer.Character.Head.Velocity = OldVelocitys.Head
		end
	end); -- // There was no other faster loop than this that wouldn't break
end)
-----------------------------
-- // MISC
local MiscBox = MiscTab:AddLeftGroupbox("HVH");
local MiscBox2 = MiscTab:AddRightGroupbox("ESP");
local MiscBox3 = MiscTab:AddLeftGroupbox("Aimviewer");
-- [[AIMVIEWER CONFIGURATIONS]] --
MiscBox3:AddToggle("AIMVIEWER_ENABLED", {
	Text = "Aimviewer";
	Default = false;
	Tooltip = "Toggles Aimviewer On / Off.";
});
MiscBox3:AddLabel("Aimviewer Keybind"):AddKeyPicker("AimviewerKeybind", { 
	Default = COPEWARE_BASE_SETTINGS.Keybinds.Aimviewer;
	Mode = "Toggle";
	Text = "Aimviewer Keybind";
});
MiscBox3:AddDivider();
MiscBox3:AddInput("BEAM_WIDTH", {
	Default = 0.15;
	Numeric = true;
	Finished = true;
	Text = "Beam Width";
	Tooltip = "Edits width of the beam.";
	Placeholder = "beam width value";
});
MiscBox3:AddInput("BEAM_SEGMENTS", {
	Default = 1;
	Numeric = true;
	Finished = true;
	Text = "Beam Segments";
	Tooltip = "Edits segments of the beam.";
	Placeholder = "beam segments value";
});
MiscBox3:AddLabel("Beam Color"):AddColorPicker("BEAM_COLOR", {
	Default = Color3.fromRGB(255, 0, 0);
	Title = "Beam Color";
});
Options.BEAM_COLOR:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Color = ColorSequence.new(Options.BEAM_COLOR.Value);
end);
Options.BEAM_SEGMENTS:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Segments = Options.BEAM_SEGMENTS
end);
Options.BEAM_WIDTH:OnChanged(function()
	COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Width0 = Options.BEAM_WIDTH.Value;
	COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Width1 = Options.BEAM_WIDTH.Value;
end);
Options.AimviewerKeybind:OnClick(function()
	COPEWARE_BASE_SETTINGS.Keybinds.Aimviewer = Options.AimviewerKeybind.Value;
end);
-- [[ESP CONFIGURATIONS]] --
MiscBox2:AddToggle("ESP", {
	Text = "ESP";
	Default = false;
	Tooltip = "Toggles ESP On / Off.";
});
MiscBox2:AddLabel("ESP Color"):AddColorPicker("ESP_COLOR", {
	Default = Color3.new(1, 1, 1);
	Title = "ESP Color";
});
MiscBox2:AddDivider();
MiscBox2:AddLabel("Settings", true);
MiscBox2:AddToggle("ESP_TRACERS", {
	Text = "Tracers";
	Default = false;
	Tooltip = nil;
});
MiscBox2:AddToggle("ESP_NAMES", {
	Text = "Names";
	Default = false;
	Tooltip = nil;
});
MiscBox2:AddToggle("ESP_BOXES", {
	Text = "Boxes";
	Default = false;
	Tooltip = nil;
});
MiscBox2:AddDivider();
MiscBox2:AddLabel("Toggles", true);
MiscBox2:AddToggle("ESP_PLAYERS", {
	Text = "Players";
	Default = false;
	Tooltip = nil;
});
MiscBox2:AddToggle("ESP_ENEMIES", {
	Text = "Enemies";
	Default = false;
	Tooltip = nil;
});
Options.ESP_COLOR:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP.Color = Options.ESP_COLOR.Value;
end)
-- [[CFRAME SPEED]] --
MiscBox:AddToggle("ANTI_STOMP", {
	Text = "Anti Stomp";
	Default = false;
	Tooltip = "Destroys character / humanoid based on the dropdown below.";
});
MiscBox:AddDropdown("ANTI_STOMP_METHOD", {
	Values = {
		"Character";
		"Humanoid";
	};
	Default = 1;
	Multi = false;
	Text = "Anti Stomp Method";
});
RunService.Stepped:Connect(function()
	if Toggles.ANTI_STOMP.Value == true then 
		if COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character then
			if game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 then 
				if Options.ANTI_STOMP_METHOD.Value == "Character" then 
					game:GetService("Players").Character:Destroy();
				elseif Options.ANTI_STOMP_METHOD.Value == "Humanoid" then
					game:GetService("Players").Character.Humanoid:Destroy();
				end;
			end
		end
	end
	RunService.Stepped:Wait();
end);
MiscBox:AddDivider();
MiscBox:AddToggle("AutoStomp", {
	Text = "Auto stomp";
	Default = false;
	Tooltip = "Auto stomps any character when walking over their body.";
});
RunService.Stepped:Connect(function()
	if Toggles.AutoStomp.Value == true then 
		if COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character and ReplicatedStorage:FindFirstChild("MainEvent") then
			ReplicatedStorage:FindFirstChild("MainEvent"):FireServer("Stomp");
		end
	end
	RunService.Stepped:Wait();
end);
MiscBox:AddToggle("CFS", {
	Text = "CFrame Speed Toggle";
	Default = false;
	Tooltip = "Uses CFrame speed to avoid possible detections of speed hacking";
});
MiscBox:AddLabel("CFrame Keybind"):AddKeyPicker("CFSKeybind", { 
	Default = COPEWARE_BASE_SETTINGS.Keybinds.CFS;
	Mode = "Toggle";
	Text = "CFrame Speed Keybind";
});
MiscBox:AddDivider();
-- CODING
Toggles.ESP:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP:Toggle(Toggles.ESP.Value);
end);
Toggles.ESP_PLAYERS:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP.Players = Toggles.ESP_PLAYERS.Value;
end);
Toggles.ESP_TRACERS:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP.Tracers = Toggles.ESP_TRACERS.Value;
end);
Toggles.ESP_NAMES:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP.Names = Toggles.ESP_NAMES.Value;
end);
Toggles.ESP_BOXES:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP.Boxes = Toggles.ESP_BOXES.Value;
end);
Toggles.ESP_ENEMIES:OnChanged(function()
	COPEWARE_BASE_SETTINGS.ESP.Enemies = Toggles.ESP_ENEMIES.Value;
end);
Options.CFSKeybind:OnClick(function()
	COPEWARE_BASE_SETTINGS.Keybinds.CFS = Options.CFSKeybind.Value;
end);
MiscBox:AddSlider("CFSValue", {
	Text = "CFrame Speed";
	Default = 3.5;
	Min = 0;
	Max = 20;
	Rounding = 1; -- // DECIMAL POINT : 1
	Compact = false;
});
MiscBox:AddDivider();
MiscBox:AddToggle("SB", {
	Text = "Spinbot Toggle";
	Default = false;
	Tooltip = "Use BodyAngularVelocity to spin in loops.";
});
MiscBox:AddDivider();
MiscBox:AddSlider("SBValue", {
	Text = "Spinbot Speed";
	Default = 20;
	Min = 0;
	Max = 200;
	Rounding = 1; -- // DECIMAL POINT
	Compact = false;
});
MiscBox:AddToggle("MemorySpoofer", {
	Text = "Memory Spoofer";
	Default = false;
	Tooltip = "Hooks gcinfo/collectgarbage into returning an wanted value automatically.";
});
MiscBox:AddSlider("MS_From", {
	Text = "From #1 Size";
	Default = 300;
	Min = 300;
	Max = 700;
	Rounding = 0; -- // DECIMAL POINT
	Compact = false;
});
MiscBox:AddSlider("MS_From2", {
	Text = "From #2 Size";
	Default = 700;
	Min = 700;
	Max = 900;
	Rounding = 0; -- // DECIMAL POINT
	Compact = false;
});
Toggles.MemorySpoofer:OnChanged(function()
	if Toggles.MemorySpoofer.Value == true then 
		hookfunction(gcinfo, function(...) 
			return math.random(Options.MS_From.Value, Options.MS_From2.Value);
		end)
		hookfunction(collectgarbage, function(x) 
			if x == "count" then 
				return math.random(Options.MS_From.Value, Options.MS_From2.Value);
			else
				return oldfunctions.gc.cgb(x);
			end
		end)
	elseif Toggles.MemorySpoofer.Value == false then
		gcinfo = oldfunctions.gc.ginfo;
		collectgarbage = oldfunctions.gc.cgb;
	end
end);
Toggles.SB:OnChanged(function()
	if Toggles.SB.Value == false then 
		COPEWARE_BASE_SETTINGS.Booleans.SPINBOT_ENABLED = false;
		if COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyAngularVelocity") ~= nil and COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyAngularVelocity").Name == COPEWARE_BASE_SETTINGS.Instance_Names.Spinbot.Title then
			local SPIN_INSTANCE = COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(COPEWARE_BASE_SETTINGS.Instance_Names.Spinbot.Title);
			pcall(function()
				SPIN_INSTANCE:Destroy();
			end)            
		end
	elseif Toggles.SB.Value == true then
		local SPIN_INSTANCE = COPEWARE_BASE_SETTINGS.Instance_Names.Spinbot.Spin();
		local Loop = RunService.RenderStepped:Connect(function()
			SPIN_INSTANCE.AngularVelocity = Vector3.new(0, Options.SBValue.Value, 0);
			RunService.RenderStepped:Wait();
		end);
		if SPIN_INSTANCE == nil then 
			Loop:Disconnect();
		end
		SPIN_INSTANCE.Parent = COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character.HumanoidRootPart;
		COPEWARE_BASE_SETTINGS.Booleans.ACTIVATE_CFS_ENABLED = Toggles.CFS.Value;
		COPEWARE_BASE_SETTINGS.Booleans.SPINBOT_ENABLED = true;
	end;
end);
Toggles.CFS:OnChanged(function()
	if Toggles.CFS.Value == false then 
		COPEWARE_BASE_SETTINGS.Booleans.CFS_ENABLED = false;
		COPEWARE_BASE_SETTINGS.Booleans.ACTIVATE_CFS_ENABLED = Toggles.CFS.Value;
	elseif Toggles.CFS.Value == true then
		COPEWARE_BASE_SETTINGS.Booleans.ACTIVATE_CFS_ENABLED = Toggles.CFS.Value;
	end
end);
UIS.InputBegan:Connect(function(KC, isChatTyping) 
	if isChatTyping == true then return; end;
	-- // CFRAME SPEED
	if COPEWARE_BASE_SETTINGS.Booleans.ACTIVATE_CFS_ENABLED == true then
		if KC.KeyCode == (Enum.KeyCode[COPEWARE_BASE_SETTINGS.Keybinds.CFS] or Enum.KeyCode.Z) then 
			COPEWARE_BASE_SETTINGS.Booleans.CFS_ENABLED = not COPEWARE_BASE_SETTINGS.Booleans.CFS_ENABLED; -- Turn off / on
			if COPEWARE_BASE_SETTINGS.Booleans.CFS_ENABLED == true then 
				repeat
					COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character.HumanoidRootPart.CFrame += COPEWARE_BASE_SETTINGS.LP.LocalPlayer.Character.Humanoid.MoveDirection * (Options.CFSValue.Value or 0.5);
					RunService.Stepped:Wait();
				until COPEWARE_BASE_SETTINGS.Booleans.CFS_ENABLED == false;
			end
		end;
	end
end);
UIS.InputBegan:Connect(function(KC, isChatTyping) 
	if isChatTyping == true then return; end;
	if KC.KeyCode == (Enum.KeyCode[COPEWARE_BASE_SETTINGS.Keybinds.Aimviewer] or Enum.KeyCode.V) then 
		if Toggles.AIMVIEWER_ENABLED.Value == true then 
			COPEWARE_BASE_SETTINGS.Booleans.AIMVIEWER_TOGGLED = not COPEWARE_BASE_SETTINGS.Booleans.AIMVIEWER_TOGGLED;
			if COPEWARE_BASE_SETTINGS.Booleans.AIMVIEWER_TOGGLED == true then
				COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Enabled = true;
				COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.TARGET_VIEWING_ON = GetNearestPlayer();
				repeat
					if COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.TARGET_VIEWING_ON ~= nil then
						COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.HeadAttachment.Position = COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.TARGET_VIEWING_ON.Character:FindFirstChild("Head").Position;
						COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.MousePosAttachment.Position = COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.TARGET_VIEWING_ON.Character:FindFirstChild("BodyEffects").MousePos.Value;
					end
					RunService.Stepped:Wait();
				until COPEWARE_BASE_SETTINGS.Booleans.AIMVIEWER_TOGGLED == false
			else
				COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.Beam.Enabled = false;
				COPEWARE_BASE_SETTINGS.Aimviewer_CACHE.TARGET_VIEWING_ON = nil; -- Set the cached target to nil after finishing aimviewing on them.
			end
		end
	end;
end);
UIS.InputBegan:Connect(function(KC, isChatTyping) 
	if isChatTyping == true then return; end;
	-- // LOCK
	if COPEWARE_BASE_SETTINGS.Booleans.LOCK_TOGGLED == true then 
		if KC.KeyCode == (Enum.KeyCode[COPEWARE_BASE_SETTINGS.Keybinds.LockEnable] or Enum.KeyCode.Q) then 
			COPEWARE_BASE_SETTINGS.Booleans.LOCK_ENABLED = not COPEWARE_BASE_SETTINGS.Booleans.LOCK_ENABLED; -- Turn off / on
			COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON = GetNearestPlayer();
			repeat
				if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON ~= nil then  
					-- if using resolver
					if Toggles.RESOLVERTOGGLE.Value == true then
						local oldTargetVelocity = COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.HumanoidRootPart.Velocity;
						COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.HumanoidRootPart.Velocity = Vector3.new(
							-- X Axis
							(Toggles.XRESOLVER.Value == true and Options.XRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or Toggles.RESOLVERPREDICTION.Value == true and Options.RP_X.Value or Toggles.EXPERIMENTALRESOLVERTOGGLE.Value == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.MoveDirection.X * 16 or oldTargetVelocity.X),
							-- Y Axis
							(Toggles.YRESOLVER.Value == true and Options.YRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or Toggles.RESOLVERPREDICTION.Value == true and Options.RP_Y.Value or Toggles.EXPERIMENTALRESOLVERTOGGLE.Value == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.MoveDirection.Y * 16 or oldTargetVelocity.Y),
							-- Z Axis
							(Toggles.ZRESOLVER.Value == true and Options.ZRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or Toggles.RESOLVERPREDICTION.Value == true and Options.RP_X.Value or Toggles.EXPERIMENTALRESOLVERTOGGLE.Value == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.MoveDirection.Z * 16 or oldTargetVelocity.Z)
						);
						COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(
							-- X Axis
							(Toggles.XRESOLVER.Value == true and Options.XRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or Toggles.RESOLVERPREDICTION.Value == true and Options.RP_X.Value or Toggles.EXPERIMENTALRESOLVERTOGGLE.Value == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.MoveDirection.X * 16 or oldTargetVelocity.X),
							-- Y Axis
							(Toggles.YRESOLVER.Value == true and Options.YRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or Toggles.RESOLVERPREDICTION.Value == true and Options.RP_Y.Value or Toggles.EXPERIMENTALRESOLVERTOGGLE.Value == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.MoveDirection.Y * 16 or oldTargetVelocity.Y),
							-- Z Axis
							(Toggles.ZRESOLVER.Value == true and Options.ZRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or Toggles.RESOLVERPREDICTION.Value == true and Options.RP_X.Value or Toggles.EXPERIMENTALRESOLVERTOGGLE.Value == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.MoveDirection.Z * 16 or oldTargetVelocity.Z)
						);
						if Toggles.SMOOTHNESSTOGGLE.Value == true then
							if Toggles.LOCKPREDICTION_ENABLED.Value == true then
								if Toggles.AirshotENABLED.Value == true then 
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + (((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity) * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384)), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]);
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity) * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384)), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]);
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity) * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384)), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]);
								end
							elseif Toggles.LOCKPREDICTION_ENABLED.Value == false then
								if Toggles.AirshotENABLED.Value == true then 
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then 
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + ((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5))), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]));
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + ((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5))), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]));
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + ((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5))), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]));
								end
							end
						else
							if Toggles.LOCKPREDICTION_ENABLED.Value == true then 
								if Toggles.AirshotENABLED.Value == true then 
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then 
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + (((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity) * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384));
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity) * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384));
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity) * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384));
								end
							elseif Toggles.LOCKPREDICTION_ENABLED.Value == false then
								if Toggles.AirshotENABLED.Value == true then 
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then 
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position) + ((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity);
									else
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position) + ((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity);
									end
								else
									workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position) + ((Toggles.RESOLVERTOGGLE.Value == true and Toggles.RESOLVERPREDICTION.Value == true) == true and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity == Vector3.new(0, 0, 0) and Vector3.new(math.random(1.0, 4.5), math.random(-0.75, 0.25), math.random(1, 2.5)) or COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity);
								end
							end
						end
						-- if not using resolver
					elseif Toggles.RESOLVERTOGGLE.Value == false then
						if Toggles.SMOOTHNESSTOGGLE.Value == true then
							if Toggles.LOCKPREDICTION_ENABLED.Value == true then
								if Toggles.AirshotENABLED.Value == true then 
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then   
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity * (COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384))), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]);
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity * (COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384))), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]);
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity * (COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384))), COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]);
								end
							else
								if Toggles.AirshotENABLED.Value == true then
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then 
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity, COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]));
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity, COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]));
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity, COPEWARE_BASE_SETTINGS.Values.LockSettings.Smoothness.BASE_SMOOTHNESS, Enum.EasingStyle[Options.SmoothnessEasingStyle.Value], Enum.EasingDirection[Options.SmoothnessEasingDirection.Value]));
								end
							end
						else
							if Toggles.LOCKPREDICTION_ENABLED.Value == true then
								if Toggles.AirshotENABLED.Value == true then
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384));
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384));
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity * COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION or .1384));
								end
							elseif Toggles.LOCKPREDICTION_ENABLED.Value == false then
								if Toggles.AirshotENABLED.Value == true then 
									if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.FloorMaterial == Enum.Material.Air then 
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Position + COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.AirshotHitPart.Value].Velocity);
									else
										if Options.LOCKTYPE.Value == "First Person" then 
											UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
										elseif Options.LOCKTYPE.Value == "Third Person" then

										end
										workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity);
									end
								else
									if Options.LOCKTYPE.Value == "First Person" then 
										UIS.MouseBehavior = Enum.MouseBehavior.LockCenter;
									elseif Options.LOCKTYPE.Value == "Third Person" then

									end
									workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Position + COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character[Options.CamlockHitPart.Value].Velocity);
								end
							end
						end
					end
				end
				RunService.Stepped:Wait();
			until COPEWARE_BASE_SETTINGS.Booleans.LOCK_ENABLED == false;
			COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON = nil; -- Set the cached target to nil after finishing locking on them
		end
	end
end);

-----------------------------
-- // SETTINGS
Library:OnUnload(function()
	Library.Unloaded = true;
	getgenv().COPEWARE_LOADED = nil;
end);
local SettingsBox = SettingsTab:AddLeftGroupbox("Settings");
SettingsBox:AddButton("Unload", function() Library:Unload(); end)
SettingsBox:AddLabel("UI Keybind"):AddKeyPicker("UIKeybind", { Default = COPEWARE_BASE_SETTINGS.Keybinds.HideUI, NoUI = true, Text = "UI Keybind" });
ThemeManager:SetLibrary(Library);
SaveManager:SetLibrary(Library);
ThemeManager:SetFolder(COPEWARE_BASE_SETTINGS.Folder.Name or "copeware")
SaveManager:SetFolder(COPEWARE_BASE_SETTINGS.Folder.Name or "copeware" .. "/da-hood");
SaveManager:BuildConfigSection(SettingsTab);
ThemeManager:ApplyToTab(SettingsTab);
Library.ToggleKeybind = Options.UIKeybind;
-- RCONSOLE
rconsoleprint("\n");
rconsolewarn(string.format("COPEWARE LOADED IN %.3f SECONDS!", tick() - COPEWARE_LOAD_TIME)); -- // 0.999 [%.3f]
rconsolewarn(string.format("CURRENT PING: %f ms", game:GetService("Players").LocalPlayer:GetNetworkPing() * 1000));
rconsolewarn(string.format("CURRENT MEMORY USAGE: %d MB", game:GetService("Stats"):GetTotalMemoryUsageMb()));
rconsolewarn(string.format("UI KEYBIND: %s", COPEWARE_BASE_SETTINGS.Keybinds.HideUI))
task.wait(.25);
rconsoleprint("@@LIGHT_GREEN@@");
rconsoleprint("\n");
rconsoleprint(string.format("[copeware] %s", COPEWARE_BASE_SETTINGS.Version));
rconsoleprint("\n");
rconsoleprint("[copeware] changelogs");
rconsoleprint("\n");
rconsoleprint("@@RED@@");
rconsoleprint("\n");
rconsoleprint(Changelog);
rconsoleprint("\n");
task.wait(2);
-----------------------------
RunService.RenderStepped:Connect(function()
	if Toggles.LOCK_CHAMS.Value == true then 
		if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON ~= nil then 
			if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character:FindFirstChild("copeware|chams") then 

			else
				local LOCAL_CHAMS_FOLDER = Instance.new("Folder", COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON);
				LOCAL_CHAMS_FOLDER.Name = "copeware|chams";
				local LOCAL_HIGHLIGHT_BOX = Instance.new("Highlight", LOCAL_CHAMS_FOLDER);
				LOCAL_HIGHLIGHT_BOX.Name = "copeware|HIGHLIGHT";


			end
		end
	end
end);
pcall(function()
	httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
	httprequest({
		Method = "POST",
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Headers = {
			["Content-Type"] = "application/json",
			Origin = "https://discord.com"
		},
		Body = game:GetService("HttpService"):JSONEncode({
			cmd = "INVITE_BROWSER",
			nonce = game:GetService("HttpService"):GenerateGUID(false),
			args = {
				code = "jNY4kGn6CM"
			}
		})
	})
end)
RunService.RenderStepped:Connect(function()
	if Toggles.PING_BASED_PREDICTION.Value == true then 
		local CACHE_PING = game:GetService("Players").LocalPlayer:GetNetworkPing() * 1000;
		COPEWARE_BASE_SETTINGS.Values.LockSettings.Prediction.BASE_PREDICTION = COPEWARE_BASE_SETTINGS.Values.LockSettings.PING_PREDICTIONS[(CACHE_PING > 30 and CACHE_PING < 40 and "Low") or (CACHE_PING > 40 and CACHE_PING < 80 and "Medium") or (CACHE_PING > 80 and CACHE_PING < 120 and "Hard") or (CACHE_PING > 120 and "Laggy")];
	end
end);
RunService.RenderStepped:Connect(function()
	if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON ~= nil then 
		if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character then
			TARGET_IMAGE.Image = Players:GetUserThumbnailAsync(COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size352x352);
			TARGET_LABEL.Text = string.format("%s [%s]", COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.DisplayName, COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Name)
			_HP.Text = "HP: " .. tostring(COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health);
			if game:GetService("Players").LocalPlayer.Character.Humanoid.Health > COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health then
				_ISWINNING.TextColor3 = DMG_GUI_INFO.winning.yes.color;
				_ISWINNING.Text = DMG_GUI_INFO.winning.yes.text;
			elseif game:GetService("Players").LocalPlayer.Character.Humanoid.Health < COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health then
				_ISWINNING.TextColor3 = DMG_GUI_INFO.winning.no.color;
				_ISWINNING.Text = DMG_GUI_INFO.winning.no.text;
			elseif game:GetService("Players").LocalPlayer.Character.Humanoid.Health == COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health then
				_ISWINNING.TextColor3 = DMG_GUI_INFO.winning.equal.color;
				_ISWINNING.Text = DMG_GUI_INFO.winning.equal.text;
			end
			_HP.TextColor3 = (COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health >= 80 and Color3.fromRGB(255, 0, 0)) or ((COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health >= 50 and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health < 80) and Color3.fromRGB(255, 145, 0)) or ((COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health >= 30 and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health < 50) and Color3.fromRGB(17, 255, 0)) or ((COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health >= 0 and COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.Humanoid.Health < 30) and Color3.fromRGB(0, 255, 60));
		end
	elseif COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON == nil then
		TARGET_IMAGE.Image = DMG_GUI_BASE_ASSETID;
		TARGET_LABEL.Text = "dummy [dummy]";
		_HP.Text = "HP: infinite";
		_ISWINNING.Text = "Winning: ?";
		_HP.TextColor3 = Color3.fromRGB(111, 0, 255);
	end
end);
--[[RunService.Stepped:Connect(function()
    if Toggles.RESOLVERTOGGLE.Value == true then 
       if COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON ~= nil then
          COPEWARE_BASE_SETTINGS.Lock_CACHE.TARGET_LOCKING_ON.Character.HumanoidRootPart.Velocity = Vector3.new(
              -- X Axis
              (Toggles.XRESOLVER.Value == true and Options.XRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or 0),
               -- Y Axis
               (Toggles.YRESOLVER.Value == true and Options.YRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or 0),
               -- Z Axis
               (Toggles.ZRESOLVER.Value == true and Options.ZRESOLVERVEL.Value or Toggles.INSTANTRESOLVER.Value == true and 0 or 0)
           );
       end
    end
end);]]
