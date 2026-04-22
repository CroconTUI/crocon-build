PROJECT 			= barebns1

BAREBNS1_ROOT	= ..\..

INC_DIR				= $(BAREBNS1_ROOT)\include
SRC_DIR 			= $(BAREBNS1_ROOT)\src
RES_DIR				= $(BAREBNS1_ROOT)\res

BIN_DIR 			= $(CROCON_ROOT)\out\demos\$(PROJECT)\bin
OBJ_DIR 			= $(CROCON_ROOT)\out\demos\$(PROJECT)\obj

C_FLAGS				= -MT -W3 -Zi -BHsc -Od

!ifdef DEBUG
	C_FLAGS 	= -Z7 -DDEBUG
	LD_FLAGS	= -debug -pdb:none
!endif


LD_FLAGS 			= -subsystem:console
LD_LIBS				= user32.lib $(CROCON_ROOT)\out\library\bin\crocon.lib

CC_FLAGS			= $(C_FLAGS) -I$(INC_DIR) -I$(CROCON_ROOT)\library\include \
				        -DWIN32 -DWINDOWS

CC_FLAGS_DLL	= $(C_FLAGS) -I$(INC_DIR)

CC				    = cl -nologo
LINKER				= link.exe -nologo

OUT_EXE				= $(BIN_DIR)\barebns1.exe

OBJECTS 			= $(OBJ_DIR)\main.obj

all: prepare $(OUT_EXE)

$(OUT_EXE): $(OBJECTS)
	$(LINKER) $(LD_FLAGS) $(LD_LIBS) -out:$@ $**

{$(SRC_DIR)}.c{$(OBJ_DIR)}.obj:
	$(CC) $(CC_FLAGS) -c $< -Fo$@

{$(SRC_DIR)\os\win32}.c{$(OBJ_DIR)}.obj:
	$(CC) $(CC_FLAGS) -c $< -Fo$@

prepare:
	@if not exist $(CROCON_ROOT)\out mkdir $(CROCON_ROOT)\out
	@if not exist $(CROCON_ROOT)\out\demos mkdir $(CROCON_ROOT)\out\demos
	@if not exist $(CROCON_ROOT)\out\demos\$(PROJECT) mkdir $(CROCON_ROOT)\out\demos\$(PROJECT)
	@if not exist $(OBJ_DIR) mkdir $(OBJ_DIR)
	@if not exist $(BIN_DIR) mkdir $(BIN_DIR)

clean:
	-del $(OBJ_DIR)\*.obj
	-del $(BIN_DIR)\*.exe
	-del $(BIN_DIR)\*.exp
