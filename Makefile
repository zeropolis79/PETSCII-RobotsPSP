SDK_TOP=/usr/local/psp/devkit
INCDIR=$(SDK_TOP)/include
LIBDIR=$(SDK_TOP)/lib

CXX=psp-g++
BIN2ELF=binary2elf

DEBUGFLAGS =	-g
CXXFLAGS =	$(DEBUGFLAGS) -Wall -fmessage-length=0 -Iinclude -I$(INCDIR) -DPLATFORM_SCREEN_WIDTH=480 -DPLATFORM_SCREEN_HEIGHT=272 -DPLATFORM_MAP_WINDOW_TILES_WIDTH=18 -DPLATFORM_MAP_WINDOW_TILES_HEIGHT=10
LDFLAGS =	-L$(LIBDIR) -Wl,-Map,petrobots.map
SOURCES =	petrobots.o Platform.o PlatformPSP.o PT2.3A_replay_cia.o

LIBS =		-lgu -lgum -lm -lwave
LOADLIBES =	$(LIBDIR)/ctrl_stub.a
LOADLIBES +=$(LIBDIR)/display_stub.a
LOADLIBES +=$(LIBDIR)/ge_user_stub.a
LOADLIBES +=$(LIBDIR)/utility_stub.a
LOADLIBES +=$(LIBDIR)/impose_stub.a

OBJECTS=$(SOURCES:.cpp=.o) Tileset.o C64Font.o Faces.o Tiles.o AnimTiles.o Sprites.o Items.o Keys.o Health.o IntroScreen.o GameScreen.o GameOver.o LevelA.o LevelB.o LevelC.o LevelD.o LevelE.o LevelF.o LevelG.o LevelH.o LevelI.o LevelJ.o LevelK.o LevelL.o LevelM.o LevelN.o ModuleSoundFX.o ModuleMetalHeads.o ModuleWin.o ModuleLose.o ModuleMetallicBopAmiga.o ModuleGetPsyched.o ModuleRobotAttack.o ModuleRushinIn.o SoundExplosion.o SoundMedkit.o SoundEMP.o SoundMagnet.o SoundShock.o SoundMove.o SoundPlasma.o SoundPistol.o SoundItemFound.o SoundError.o SoundCycleWeapon.o SoundCycleItem.o SoundDoor.o SoundMenuBeep.o SoundShortBeep.o

EXECUTABLE=petrobots

all: $(SOURCES) $(EXECUTABLE).prx eboot.pbp

$(EXECUTABLE).prx: $(OBJECTS)
	$(LINK.cpp) $^ $(LIBS) $(LOADLIBES) -startfiles -o $@

eboot.pbp: $(EXECUTABLE).prx
	psp-prx-strip -v $(EXECUTABLE).prx
	PrxEncrypter $(EXECUTABLE).prx encrypted.prx
	pack-pbp eboot.pbp PSP/PARAM.SFO PSP/ICON0.PNG /dev/null PSP/PIC0.PNG PSP/PIC1.PNG /dev/null encrypted.prx /dev/null

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $< -o $@
Tileset.o: tileset.amiga
	$(BIN2ELF) --PSP -s tileset -e tilesetEnd tileset.amiga Tileset.o
C64Font.o: PSP/c64font.psp
	$(BIN2ELF) --PSP -s font -e fontEnd PSP/c64font.psp C64Font.o
Faces.o: PSP/faces.psp
	$(BIN2ELF) --PSP -s faces -e facesEnd PSP/faces.psp Faces.o
Tiles.o: PSP/tiles.psp
	$(BIN2ELF) --PSP -s tiles -e tilesEnd PSP/tiles.psp Tiles.o
AnimTiles.o: PSP/animtiles.psp
	$(BIN2ELF) --PSP -s animTiles -e animTilesEnd PSP/animtiles.psp AnimTiles.o
Sprites.o: PSP/sprites.psp
	$(BIN2ELF) --PSP -s sprites -e spritesEnd PSP/sprites.psp Sprites.o
Items.o: PSP/items.psp
	$(BIN2ELF) --PSP -s items -e itemsEnd PSP/items.psp Items.o
Keys.o: PSP/keys.psp
	$(BIN2ELF) --PSP -s keys -e keysEnd PSP/keys.psp Keys.o
Health.o: PSP/health.psp
	$(BIN2ELF) --PSP -s health -e healthEnd PSP/health.psp Health.o
IntroScreen.o: PSP/introscreen.psp
	$(BIN2ELF) --PSP -s introScreen -e introScreenEnd PSP/introscreen.psp IntroScreen.o
GameScreen.o: PSP/gamescreen.psp
	$(BIN2ELF) --PSP -s gameScreen -e gameScreenEnd PSP/gamescreen.psp GameScreen.o
GameOver.o: PSP/gameover.psp
	$(BIN2ELF) --PSP -s gameOver -e gameOverEnd PSP/gameover.psp GameOver.o
LevelA.o: PSP/level-A
	$(BIN2ELF) --PSP -s levelA -e levelAEnd PSP/level-A LevelA.o
LevelB.o: PSP/level-B
	$(BIN2ELF) --PSP -s levelB -e levelBEnd PSP/level-B LevelB.o
LevelC.o: PSP/level-C
	$(BIN2ELF) --PSP -s levelC -e levelCEnd PSP/level-C LevelC.o
LevelD.o: PSP/level-D
	$(BIN2ELF) --PSP -s levelD -e levelDEnd PSP/level-D LevelD.o
LevelE.o: PSP/level-E
	$(BIN2ELF) --PSP -s levelE -e levelEEnd PSP/level-E LevelE.o
LevelF.o: PSP/level-F
	$(BIN2ELF) --PSP -s levelF -e levelFEnd PSP/level-F LevelF.o
LevelG.o: PSP/level-G
	$(BIN2ELF) --PSP -s levelG -e levelGEnd PSP/level-G LevelG.o
LevelH.o: PSP/level-H
	$(BIN2ELF) --PSP -s levelH -e levelHEnd PSP/level-H LevelH.o
LevelI.o: PSP/level-I
	$(BIN2ELF) --PSP -s levelI -e levelIEnd PSP/level-I LevelI.o
LevelJ.o: PSP/level-J
	$(BIN2ELF) --PSP -s levelJ -e levelJEnd PSP/level-J LevelJ.o
LevelK.o: PSP/level-K
	$(BIN2ELF) --PSP -s levelK -e levelKEnd PSP/level-K LevelK.o
LevelL.o: PSP/level-L
	$(BIN2ELF) --PSP -s levelL -e levelLEnd PSP/level-L LevelL.o
LevelM.o: PSP/level-M
	$(BIN2ELF) --PSP -s levelM -e levelMEnd PSP/level-M LevelM.o
LevelN.o: PSP/level-N
	$(BIN2ELF) --PSP -s levelN -e levelNEnd PSP/level-N LevelN.o
ModuleSoundFX.o: Music/mod.soundfx
	$(BIN2ELF) --PSP -s moduleSoundFX -e moduleSoundFXEnd Music/mod.soundfx ModuleSoundFX.o
ModuleMetalHeads.o: Music/mod.metal\ heads
	$(BIN2ELF) --PSP -s moduleMetalHeads -e moduleMetalHeadsEnd "Music/mod.metal heads" ModuleMetalHeads.o
ModuleWin.o: Music/mod.win
	$(BIN2ELF) --PSP -s moduleWin -e moduleWinEnd Music/mod.win ModuleWin.o
ModuleLose.o: Music/mod.lose
	$(BIN2ELF) --PSP -s moduleLose -e moduleLoseEnd Music/mod.lose ModuleLose.o
ModuleMetallicBopAmiga.o: Music/mod.metallic\ bop\ amiga
	$(BIN2ELF) --PSP -s moduleMetallicBopAmiga -e moduleMetallicBopAmigaEnd "Music/mod.metallic bop amiga" ModuleMetallicBopAmiga.o
ModuleGetPsyched.o: Music/mod.get\ psyched
	$(BIN2ELF) --PSP -s moduleGetPsyched -e moduleGetPsychedEnd "Music/mod.get psyched" ModuleGetPsyched.o
ModuleRobotAttack.o: Music/mod.robot\ attack
	$(BIN2ELF) --PSP -s moduleRobotAttack -e moduleRobotAttackEnd "Music/mod.robot attack" ModuleRobotAttack.o
ModuleRushinIn.o: Music/mod.rushin\ in
	$(BIN2ELF) --PSP -s moduleRushinIn -e moduleRushinInEnd "Music/mod.rushin in" ModuleRushinIn.o
SoundExplosion.o: Sounds/sounds_dsbarexp.raw
	$(BIN2ELF) --PSP -s soundExplosion -e soundExplosionEnd Sounds/sounds_dsbarexp.raw SoundExplosion.o
SoundMedkit.o: Sounds/SOUND_MEDKIT.raw
	$(BIN2ELF) --PSP -s soundMedkit -e soundMedkitEnd Sounds/SOUND_MEDKIT.raw SoundMedkit.o
SoundEMP.o: Sounds/SOUND_EMP.raw
	$(BIN2ELF) --PSP -s soundEMP -e soundEMPEnd Sounds/SOUND_EMP.raw SoundEMP.o
SoundMagnet.o: Sounds/SOUND_MAGNET2.raw
	$(BIN2ELF) --PSP -s soundMagnet -e soundMagnetEnd Sounds/SOUND_MAGNET2.raw SoundMagnet.o
SoundShock.o: Sounds/SOUND_SHOCK.raw
	$(BIN2ELF) --PSP -s soundShock -e soundShockEnd Sounds/SOUND_SHOCK.raw SoundShock.o
SoundMove.o: Sounds/SOUND_MOVE.raw
	$(BIN2ELF) --PSP -s soundMove -e soundMoveEnd Sounds/SOUND_MOVE.raw SoundMove.o
SoundPlasma.o: Sounds/SOUND_PLASMA_FASTER.raw
	$(BIN2ELF) --PSP -s soundPlasma -e soundPlasmaEnd Sounds/SOUND_PLASMA_FASTER.raw SoundPlasma.o
SoundPistol.o: Sounds/sounds_dspistol.raw
	$(BIN2ELF) --PSP -s soundPistol -e soundPistolEnd Sounds/sounds_dspistol.raw SoundPistol.o
SoundItemFound.o: Sounds/SOUND_FOUND_ITEM.raw
	$(BIN2ELF) --PSP -s soundItemFound -e soundItemFoundEnd Sounds/SOUND_FOUND_ITEM.raw SoundItemFound.o
SoundError.o: Sounds/SOUND_ERROR.raw
	$(BIN2ELF) --PSP -s soundError -e soundErrorEnd Sounds/SOUND_ERROR.raw SoundError.o
SoundCycleWeapon.o: Sounds/SOUND_CYCLE_WEAPON.raw
	$(BIN2ELF) --PSP -s soundCycleWeapon -e soundCycleWeaponEnd Sounds/SOUND_CYCLE_WEAPON.raw SoundCycleWeapon.o
SoundCycleItem.o: Sounds/SOUND_CYCLE_ITEM.raw
	$(BIN2ELF) --PSP -s soundCycleItem -e soundCycleItemEnd Sounds/SOUND_CYCLE_ITEM.raw SoundCycleItem.o
SoundDoor.o: Sounds/SOUND_DOOR_FASTER.raw
	$(BIN2ELF) --PSP -s soundDoor -e soundDoorEnd Sounds/SOUND_DOOR_FASTER.raw SoundDoor.o
SoundMenuBeep.o: Sounds/SOUND_BEEP2.raw
	$(BIN2ELF) --PSP -s soundMenuBeep -e soundMenuBeepEnd Sounds/SOUND_BEEP2.raw SoundMenuBeep.o
SoundShortBeep.o: Sounds/SOUND_BEEP.raw
	$(BIN2ELF) --PSP -s soundShortBeep -e soundShortBeepEnd Sounds/SOUND_BEEP.raw SoundShortBeep.o

install: eboot.pbp
	cp -v eboot.pbp /run/media/vesuri/disk/psp/game/petrobots/
	rm -f /run/media/vesuri/disk/log.txt
	touch /run/media/vesuri/disk/log.txt
	umount /run/media/vesuri/disk

clean:
	rm -f $(OBJECTS) *.gcda *.gcno *.prx eboot.pbp

#----------- rules --------------
-include PathDefs
PathDefs:
	psp-path-setup > PathDefs || (rm -f PathDefs ; exit 1)
