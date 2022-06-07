function Game.client_onCreate( self )
	print("Game.client_onCreate")

    self.cl = {}
	self.cl.time = {}
	self.cl.time.timeOfDay = 0.0
	self.cl.time.timeProgress = true

	if not sm.isHost then
		g_enableCollisionTumble = true
	end

	if g_unitManager == nil then
		assert( not sm.isHost )
		g_unitManager = UnitManager()
	end
	g_unitManager:cl_onCreate()

	g_effectManager = EffectManager()
	g_effectManager:cl_onCreate()
	
	sm.game.bindChatCommand( "/loadworld", { { "string", "worldName", true } }, "cl_loadWorld", "Loads Specified World" )
	sm.game.bindChatCommand( "/start", { }, "cl_startGame", "Starts the game" )
end

function Game.cl_startGame(self)
	self.network:sendToServer( "MainGameLogic" )
end

function Game.cl_loadWorld(self, world)
	self.network:sendToServer( "sv_loadWorld", { player = sm.localPlayer.getPlayer(), world = world } )
end

function Game.client_onJoined( self, params )
	--self.cl.playIntroCinematic = params.newPlayer
end