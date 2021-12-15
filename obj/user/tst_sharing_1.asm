
obj/user/tst_sharing_1:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 fd 02 00 00       	call   800333 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the creation of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 23                	jmp    80006f <_main+0x37>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	c1 e2 04             	shl    $0x4,%edx
  80005d:	01 d0                	add    %edx,%eax
  80005f:	8a 40 04             	mov    0x4(%eax),%al
  800062:	84 c0                	test   %al,%al
  800064:	74 06                	je     80006c <_main+0x34>
			{
				fullWS = 0;
  800066:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006a:	eb 12                	jmp    80007e <_main+0x46>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006c:	ff 45 f0             	incl   -0x10(%ebp)
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 50 74             	mov    0x74(%eax),%edx
  800077:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007a:	39 c2                	cmp    %eax,%edx
  80007c:	77 ce                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007e:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800082:	74 14                	je     800098 <_main+0x60>
  800084:	83 ec 04             	sub    $0x4,%esp
  800087:	68 20 20 80 00       	push   $0x802020
  80008c:	6a 12                	push   $0x12
  80008e:	68 3c 20 80 00       	push   $0x80203c
  800093:	e8 e0 03 00 00       	call   800478 <_panic>
	}

	uint32 *x, *y, *z ;
	cprintf("STEP A: checking the creation of shared variables... \n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 54 20 80 00       	push   $0x802054
  8000a0:	e8 75 06 00 00       	call   80071a <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000a8:	e8 04 18 00 00       	call   8018b1 <sys_calculate_free_frames>
  8000ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000b0:	83 ec 04             	sub    $0x4,%esp
  8000b3:	6a 01                	push   $0x1
  8000b5:	68 00 10 00 00       	push   $0x1000
  8000ba:	68 8b 20 80 00       	push   $0x80208b
  8000bf:	e8 b0 15 00 00       	call   801674 <smalloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000ca:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000d1:	74 14                	je     8000e7 <_main+0xaf>
  8000d3:	83 ec 04             	sub    $0x4,%esp
  8000d6:	68 90 20 80 00       	push   $0x802090
  8000db:	6a 1a                	push   $0x1a
  8000dd:	68 3c 20 80 00       	push   $0x80203c
  8000e2:	e8 91 03 00 00       	call   800478 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8000e7:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000ea:	e8 c2 17 00 00       	call   8018b1 <sys_calculate_free_frames>
  8000ef:	29 c3                	sub    %eax,%ebx
  8000f1:	89 d8                	mov    %ebx,%eax
  8000f3:	83 f8 04             	cmp    $0x4,%eax
  8000f6:	74 14                	je     80010c <_main+0xd4>
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	68 fc 20 80 00       	push   $0x8020fc
  800100:	6a 1b                	push   $0x1b
  800102:	68 3c 20 80 00       	push   $0x80203c
  800107:	e8 6c 03 00 00       	call   800478 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80010c:	e8 a0 17 00 00       	call   8018b1 <sys_calculate_free_frames>
  800111:	89 45 e8             	mov    %eax,-0x18(%ebp)
		z = smalloc("z", PAGE_SIZE + 4, 1);
  800114:	83 ec 04             	sub    $0x4,%esp
  800117:	6a 01                	push   $0x1
  800119:	68 04 10 00 00       	push   $0x1004
  80011e:	68 7a 21 80 00       	push   $0x80217a
  800123:	e8 4c 15 00 00       	call   801674 <smalloc>
  800128:	83 c4 10             	add    $0x10,%esp
  80012b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if (z != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  80012e:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  800135:	74 14                	je     80014b <_main+0x113>
  800137:	83 ec 04             	sub    $0x4,%esp
  80013a:	68 90 20 80 00       	push   $0x802090
  80013f:	6a 1f                	push   $0x1f
  800141:	68 3c 20 80 00       	push   $0x80203c
  800146:	e8 2d 03 00 00       	call   800478 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  2+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80014b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  80014e:	e8 5e 17 00 00       	call   8018b1 <sys_calculate_free_frames>
  800153:	29 c3                	sub    %eax,%ebx
  800155:	89 d8                	mov    %ebx,%eax
  800157:	83 f8 04             	cmp    $0x4,%eax
  80015a:	74 14                	je     800170 <_main+0x138>
  80015c:	83 ec 04             	sub    $0x4,%esp
  80015f:	68 fc 20 80 00       	push   $0x8020fc
  800164:	6a 20                	push   $0x20
  800166:	68 3c 20 80 00       	push   $0x80203c
  80016b:	e8 08 03 00 00       	call   800478 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800170:	e8 3c 17 00 00       	call   8018b1 <sys_calculate_free_frames>
  800175:	89 45 e8             	mov    %eax,-0x18(%ebp)
		y = smalloc("y", 4, 1);
  800178:	83 ec 04             	sub    $0x4,%esp
  80017b:	6a 01                	push   $0x1
  80017d:	6a 04                	push   $0x4
  80017f:	68 7c 21 80 00       	push   $0x80217c
  800184:	e8 eb 14 00 00       	call   801674 <smalloc>
  800189:	83 c4 10             	add    $0x10,%esp
  80018c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (y != (uint32*)(USER_HEAP_START + 3 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  80018f:	81 7d dc 00 30 00 80 	cmpl   $0x80003000,-0x24(%ebp)
  800196:	74 14                	je     8001ac <_main+0x174>
  800198:	83 ec 04             	sub    $0x4,%esp
  80019b:	68 90 20 80 00       	push   $0x802090
  8001a0:	6a 24                	push   $0x24
  8001a2:	68 3c 20 80 00       	push   $0x80203c
  8001a7:	e8 cc 02 00 00       	call   800478 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8001ac:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8001af:	e8 fd 16 00 00       	call   8018b1 <sys_calculate_free_frames>
  8001b4:	29 c3                	sub    %eax,%ebx
  8001b6:	89 d8                	mov    %ebx,%eax
  8001b8:	83 f8 03             	cmp    $0x3,%eax
  8001bb:	74 14                	je     8001d1 <_main+0x199>
  8001bd:	83 ec 04             	sub    $0x4,%esp
  8001c0:	68 fc 20 80 00       	push   $0x8020fc
  8001c5:	6a 25                	push   $0x25
  8001c7:	68 3c 20 80 00       	push   $0x80203c
  8001cc:	e8 a7 02 00 00       	call   800478 <_panic>
	}
	cprintf("Step A is completed successfully!!\n\n\n");
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	68 80 21 80 00       	push   $0x802180
  8001d9:	e8 3c 05 00 00       	call   80071a <cprintf>
  8001de:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking reading & writing... \n");
  8001e1:	83 ec 0c             	sub    $0xc,%esp
  8001e4:	68 a8 21 80 00       	push   $0x8021a8
  8001e9:	e8 2c 05 00 00       	call   80071a <cprintf>
  8001ee:	83 c4 10             	add    $0x10,%esp
	{
		int i=0;
  8001f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<PAGE_SIZE/4;i++)
  8001f8:	eb 2d                	jmp    800227 <_main+0x1ef>
		{
			x[i] = -1;
  8001fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800207:	01 d0                	add    %edx,%eax
  800209:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			y[i] = -1;
  80020f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800212:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800219:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80021c:	01 d0                	add    %edx,%eax
  80021e:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)


	cprintf("STEP B: checking reading & writing... \n");
	{
		int i=0;
		for(;i<PAGE_SIZE/4;i++)
  800224:	ff 45 ec             	incl   -0x14(%ebp)
  800227:	81 7d ec ff 03 00 00 	cmpl   $0x3ff,-0x14(%ebp)
  80022e:	7e ca                	jle    8001fa <_main+0x1c2>
		{
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
  800230:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<2*PAGE_SIZE/4;i++)
  800237:	eb 18                	jmp    800251 <_main+0x219>
		{
			z[i] = -1;
  800239:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80023c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800243:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800246:	01 d0                	add    %edx,%eax
  800248:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
		for(;i<2*PAGE_SIZE/4;i++)
  80024e:	ff 45 ec             	incl   -0x14(%ebp)
  800251:	81 7d ec ff 07 00 00 	cmpl   $0x7ff,-0x14(%ebp)
  800258:	7e df                	jle    800239 <_main+0x201>
		{
			z[i] = -1;
		}

		if( x[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  80025a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025d:	8b 00                	mov    (%eax),%eax
  80025f:	83 f8 ff             	cmp    $0xffffffff,%eax
  800262:	74 14                	je     800278 <_main+0x240>
  800264:	83 ec 04             	sub    $0x4,%esp
  800267:	68 d0 21 80 00       	push   $0x8021d0
  80026c:	6a 39                	push   $0x39
  80026e:	68 3c 20 80 00       	push   $0x80203c
  800273:	e8 00 02 00 00       	call   800478 <_panic>
		if( x[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  800278:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80027b:	05 fc 0f 00 00       	add    $0xffc,%eax
  800280:	8b 00                	mov    (%eax),%eax
  800282:	83 f8 ff             	cmp    $0xffffffff,%eax
  800285:	74 14                	je     80029b <_main+0x263>
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	68 d0 21 80 00       	push   $0x8021d0
  80028f:	6a 3a                	push   $0x3a
  800291:	68 3c 20 80 00       	push   $0x80203c
  800296:	e8 dd 01 00 00       	call   800478 <_panic>

		if( y[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  80029b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80029e:	8b 00                	mov    (%eax),%eax
  8002a0:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002a3:	74 14                	je     8002b9 <_main+0x281>
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	68 d0 21 80 00       	push   $0x8021d0
  8002ad:	6a 3c                	push   $0x3c
  8002af:	68 3c 20 80 00       	push   $0x80203c
  8002b4:	e8 bf 01 00 00       	call   800478 <_panic>
		if( y[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002bc:	05 fc 0f 00 00       	add    $0xffc,%eax
  8002c1:	8b 00                	mov    (%eax),%eax
  8002c3:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002c6:	74 14                	je     8002dc <_main+0x2a4>
  8002c8:	83 ec 04             	sub    $0x4,%esp
  8002cb:	68 d0 21 80 00       	push   $0x8021d0
  8002d0:	6a 3d                	push   $0x3d
  8002d2:	68 3c 20 80 00       	push   $0x80203c
  8002d7:	e8 9c 01 00 00       	call   800478 <_panic>

		if( z[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  8002dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002df:	8b 00                	mov    (%eax),%eax
  8002e1:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 d0 21 80 00       	push   $0x8021d0
  8002ee:	6a 3f                	push   $0x3f
  8002f0:	68 3c 20 80 00       	push   $0x80203c
  8002f5:	e8 7e 01 00 00       	call   800478 <_panic>
		if( z[2*PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002fd:	05 fc 1f 00 00       	add    $0x1ffc,%eax
  800302:	8b 00                	mov    (%eax),%eax
  800304:	83 f8 ff             	cmp    $0xffffffff,%eax
  800307:	74 14                	je     80031d <_main+0x2e5>
  800309:	83 ec 04             	sub    $0x4,%esp
  80030c:	68 d0 21 80 00       	push   $0x8021d0
  800311:	6a 40                	push   $0x40
  800313:	68 3c 20 80 00       	push   $0x80203c
  800318:	e8 5b 01 00 00       	call   800478 <_panic>
	}

	cprintf("Congratulations!! Test of Shared Variables [Create] [1] completed successfully!!\n\n\n");
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	68 fc 21 80 00       	push   $0x8021fc
  800325:	e8 f0 03 00 00       	call   80071a <cprintf>
  80032a:	83 c4 10             	add    $0x10,%esp

	return;
  80032d:	90                   	nop
}
  80032e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800331:	c9                   	leave  
  800332:	c3                   	ret    

00800333 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800333:	55                   	push   %ebp
  800334:	89 e5                	mov    %esp,%ebp
  800336:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800339:	e8 a8 14 00 00       	call   8017e6 <sys_getenvindex>
  80033e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800341:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800344:	89 d0                	mov    %edx,%eax
  800346:	c1 e0 03             	shl    $0x3,%eax
  800349:	01 d0                	add    %edx,%eax
  80034b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800352:	01 c8                	add    %ecx,%eax
  800354:	01 c0                	add    %eax,%eax
  800356:	01 d0                	add    %edx,%eax
  800358:	01 c0                	add    %eax,%eax
  80035a:	01 d0                	add    %edx,%eax
  80035c:	89 c2                	mov    %eax,%edx
  80035e:	c1 e2 05             	shl    $0x5,%edx
  800361:	29 c2                	sub    %eax,%edx
  800363:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80036a:	89 c2                	mov    %eax,%edx
  80036c:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800372:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800377:	a1 20 30 80 00       	mov    0x803020,%eax
  80037c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800382:	84 c0                	test   %al,%al
  800384:	74 0f                	je     800395 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800386:	a1 20 30 80 00       	mov    0x803020,%eax
  80038b:	05 40 3c 01 00       	add    $0x13c40,%eax
  800390:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800395:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800399:	7e 0a                	jle    8003a5 <libmain+0x72>
		binaryname = argv[0];
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	8b 00                	mov    (%eax),%eax
  8003a0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003a5:	83 ec 08             	sub    $0x8,%esp
  8003a8:	ff 75 0c             	pushl  0xc(%ebp)
  8003ab:	ff 75 08             	pushl  0x8(%ebp)
  8003ae:	e8 85 fc ff ff       	call   800038 <_main>
  8003b3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003b6:	e8 c6 15 00 00       	call   801981 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003bb:	83 ec 0c             	sub    $0xc,%esp
  8003be:	68 68 22 80 00       	push   $0x802268
  8003c3:	e8 52 03 00 00       	call   80071a <cprintf>
  8003c8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d0:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003db:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8003e1:	83 ec 04             	sub    $0x4,%esp
  8003e4:	52                   	push   %edx
  8003e5:	50                   	push   %eax
  8003e6:	68 90 22 80 00       	push   $0x802290
  8003eb:	e8 2a 03 00 00       	call   80071a <cprintf>
  8003f0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8003f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f8:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800409:	83 ec 04             	sub    $0x4,%esp
  80040c:	52                   	push   %edx
  80040d:	50                   	push   %eax
  80040e:	68 b8 22 80 00       	push   $0x8022b8
  800413:	e8 02 03 00 00       	call   80071a <cprintf>
  800418:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80041b:	a1 20 30 80 00       	mov    0x803020,%eax
  800420:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800426:	83 ec 08             	sub    $0x8,%esp
  800429:	50                   	push   %eax
  80042a:	68 f9 22 80 00       	push   $0x8022f9
  80042f:	e8 e6 02 00 00       	call   80071a <cprintf>
  800434:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800437:	83 ec 0c             	sub    $0xc,%esp
  80043a:	68 68 22 80 00       	push   $0x802268
  80043f:	e8 d6 02 00 00       	call   80071a <cprintf>
  800444:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800447:	e8 4f 15 00 00       	call   80199b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80044c:	e8 19 00 00 00       	call   80046a <exit>
}
  800451:	90                   	nop
  800452:	c9                   	leave  
  800453:	c3                   	ret    

00800454 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800454:	55                   	push   %ebp
  800455:	89 e5                	mov    %esp,%ebp
  800457:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80045a:	83 ec 0c             	sub    $0xc,%esp
  80045d:	6a 00                	push   $0x0
  80045f:	e8 4e 13 00 00       	call   8017b2 <sys_env_destroy>
  800464:	83 c4 10             	add    $0x10,%esp
}
  800467:	90                   	nop
  800468:	c9                   	leave  
  800469:	c3                   	ret    

0080046a <exit>:

void
exit(void)
{
  80046a:	55                   	push   %ebp
  80046b:	89 e5                	mov    %esp,%ebp
  80046d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800470:	e8 a3 13 00 00       	call   801818 <sys_env_exit>
}
  800475:	90                   	nop
  800476:	c9                   	leave  
  800477:	c3                   	ret    

00800478 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800478:	55                   	push   %ebp
  800479:	89 e5                	mov    %esp,%ebp
  80047b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80047e:	8d 45 10             	lea    0x10(%ebp),%eax
  800481:	83 c0 04             	add    $0x4,%eax
  800484:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800487:	a1 18 31 80 00       	mov    0x803118,%eax
  80048c:	85 c0                	test   %eax,%eax
  80048e:	74 16                	je     8004a6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800490:	a1 18 31 80 00       	mov    0x803118,%eax
  800495:	83 ec 08             	sub    $0x8,%esp
  800498:	50                   	push   %eax
  800499:	68 10 23 80 00       	push   $0x802310
  80049e:	e8 77 02 00 00       	call   80071a <cprintf>
  8004a3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004a6:	a1 00 30 80 00       	mov    0x803000,%eax
  8004ab:	ff 75 0c             	pushl  0xc(%ebp)
  8004ae:	ff 75 08             	pushl  0x8(%ebp)
  8004b1:	50                   	push   %eax
  8004b2:	68 15 23 80 00       	push   $0x802315
  8004b7:	e8 5e 02 00 00       	call   80071a <cprintf>
  8004bc:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c2:	83 ec 08             	sub    $0x8,%esp
  8004c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c8:	50                   	push   %eax
  8004c9:	e8 e1 01 00 00       	call   8006af <vcprintf>
  8004ce:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004d1:	83 ec 08             	sub    $0x8,%esp
  8004d4:	6a 00                	push   $0x0
  8004d6:	68 31 23 80 00       	push   $0x802331
  8004db:	e8 cf 01 00 00       	call   8006af <vcprintf>
  8004e0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004e3:	e8 82 ff ff ff       	call   80046a <exit>

	// should not return here
	while (1) ;
  8004e8:	eb fe                	jmp    8004e8 <_panic+0x70>

008004ea <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004ea:	55                   	push   %ebp
  8004eb:	89 e5                	mov    %esp,%ebp
  8004ed:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8b 50 74             	mov    0x74(%eax),%edx
  8004f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fb:	39 c2                	cmp    %eax,%edx
  8004fd:	74 14                	je     800513 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004ff:	83 ec 04             	sub    $0x4,%esp
  800502:	68 34 23 80 00       	push   $0x802334
  800507:	6a 26                	push   $0x26
  800509:	68 80 23 80 00       	push   $0x802380
  80050e:	e8 65 ff ff ff       	call   800478 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800513:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80051a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800521:	e9 b6 00 00 00       	jmp    8005dc <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800526:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800529:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800530:	8b 45 08             	mov    0x8(%ebp),%eax
  800533:	01 d0                	add    %edx,%eax
  800535:	8b 00                	mov    (%eax),%eax
  800537:	85 c0                	test   %eax,%eax
  800539:	75 08                	jne    800543 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80053b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80053e:	e9 96 00 00 00       	jmp    8005d9 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800543:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80054a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800551:	eb 5d                	jmp    8005b0 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800553:	a1 20 30 80 00       	mov    0x803020,%eax
  800558:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80055e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800561:	c1 e2 04             	shl    $0x4,%edx
  800564:	01 d0                	add    %edx,%eax
  800566:	8a 40 04             	mov    0x4(%eax),%al
  800569:	84 c0                	test   %al,%al
  80056b:	75 40                	jne    8005ad <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80056d:	a1 20 30 80 00       	mov    0x803020,%eax
  800572:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800578:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80057b:	c1 e2 04             	shl    $0x4,%edx
  80057e:	01 d0                	add    %edx,%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800585:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800588:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80058d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80058f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800592:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	01 c8                	add    %ecx,%eax
  80059e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005a0:	39 c2                	cmp    %eax,%edx
  8005a2:	75 09                	jne    8005ad <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005a4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005ab:	eb 12                	jmp    8005bf <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ad:	ff 45 e8             	incl   -0x18(%ebp)
  8005b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b5:	8b 50 74             	mov    0x74(%eax),%edx
  8005b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005bb:	39 c2                	cmp    %eax,%edx
  8005bd:	77 94                	ja     800553 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005c3:	75 14                	jne    8005d9 <CheckWSWithoutLastIndex+0xef>
			panic(
  8005c5:	83 ec 04             	sub    $0x4,%esp
  8005c8:	68 8c 23 80 00       	push   $0x80238c
  8005cd:	6a 3a                	push   $0x3a
  8005cf:	68 80 23 80 00       	push   $0x802380
  8005d4:	e8 9f fe ff ff       	call   800478 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005d9:	ff 45 f0             	incl   -0x10(%ebp)
  8005dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005df:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005e2:	0f 8c 3e ff ff ff    	jl     800526 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005f6:	eb 20                	jmp    800618 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800603:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800606:	c1 e2 04             	shl    $0x4,%edx
  800609:	01 d0                	add    %edx,%eax
  80060b:	8a 40 04             	mov    0x4(%eax),%al
  80060e:	3c 01                	cmp    $0x1,%al
  800610:	75 03                	jne    800615 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800612:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800615:	ff 45 e0             	incl   -0x20(%ebp)
  800618:	a1 20 30 80 00       	mov    0x803020,%eax
  80061d:	8b 50 74             	mov    0x74(%eax),%edx
  800620:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800623:	39 c2                	cmp    %eax,%edx
  800625:	77 d1                	ja     8005f8 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800627:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80062a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80062d:	74 14                	je     800643 <CheckWSWithoutLastIndex+0x159>
		panic(
  80062f:	83 ec 04             	sub    $0x4,%esp
  800632:	68 e0 23 80 00       	push   $0x8023e0
  800637:	6a 44                	push   $0x44
  800639:	68 80 23 80 00       	push   $0x802380
  80063e:	e8 35 fe ff ff       	call   800478 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800643:	90                   	nop
  800644:	c9                   	leave  
  800645:	c3                   	ret    

00800646 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800646:	55                   	push   %ebp
  800647:	89 e5                	mov    %esp,%ebp
  800649:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80064c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	8d 48 01             	lea    0x1(%eax),%ecx
  800654:	8b 55 0c             	mov    0xc(%ebp),%edx
  800657:	89 0a                	mov    %ecx,(%edx)
  800659:	8b 55 08             	mov    0x8(%ebp),%edx
  80065c:	88 d1                	mov    %dl,%cl
  80065e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800661:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800665:	8b 45 0c             	mov    0xc(%ebp),%eax
  800668:	8b 00                	mov    (%eax),%eax
  80066a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80066f:	75 2c                	jne    80069d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800671:	a0 24 30 80 00       	mov    0x803024,%al
  800676:	0f b6 c0             	movzbl %al,%eax
  800679:	8b 55 0c             	mov    0xc(%ebp),%edx
  80067c:	8b 12                	mov    (%edx),%edx
  80067e:	89 d1                	mov    %edx,%ecx
  800680:	8b 55 0c             	mov    0xc(%ebp),%edx
  800683:	83 c2 08             	add    $0x8,%edx
  800686:	83 ec 04             	sub    $0x4,%esp
  800689:	50                   	push   %eax
  80068a:	51                   	push   %ecx
  80068b:	52                   	push   %edx
  80068c:	e8 df 10 00 00       	call   801770 <sys_cputs>
  800691:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800694:	8b 45 0c             	mov    0xc(%ebp),%eax
  800697:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80069d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a0:	8b 40 04             	mov    0x4(%eax),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006ac:	90                   	nop
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006b8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006bf:	00 00 00 
	b.cnt = 0;
  8006c2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006c9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006cc:	ff 75 0c             	pushl  0xc(%ebp)
  8006cf:	ff 75 08             	pushl  0x8(%ebp)
  8006d2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006d8:	50                   	push   %eax
  8006d9:	68 46 06 80 00       	push   $0x800646
  8006de:	e8 11 02 00 00       	call   8008f4 <vprintfmt>
  8006e3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006e6:	a0 24 30 80 00       	mov    0x803024,%al
  8006eb:	0f b6 c0             	movzbl %al,%eax
  8006ee:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006f4:	83 ec 04             	sub    $0x4,%esp
  8006f7:	50                   	push   %eax
  8006f8:	52                   	push   %edx
  8006f9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006ff:	83 c0 08             	add    $0x8,%eax
  800702:	50                   	push   %eax
  800703:	e8 68 10 00 00       	call   801770 <sys_cputs>
  800708:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80070b:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800712:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <cprintf>:

int cprintf(const char *fmt, ...) {
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800720:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800727:	8d 45 0c             	lea    0xc(%ebp),%eax
  80072a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	83 ec 08             	sub    $0x8,%esp
  800733:	ff 75 f4             	pushl  -0xc(%ebp)
  800736:	50                   	push   %eax
  800737:	e8 73 ff ff ff       	call   8006af <vcprintf>
  80073c:	83 c4 10             	add    $0x10,%esp
  80073f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800742:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800745:	c9                   	leave  
  800746:	c3                   	ret    

00800747 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800747:	55                   	push   %ebp
  800748:	89 e5                	mov    %esp,%ebp
  80074a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074d:	e8 2f 12 00 00       	call   801981 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800752:	8d 45 0c             	lea    0xc(%ebp),%eax
  800755:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800758:	8b 45 08             	mov    0x8(%ebp),%eax
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 f4             	pushl  -0xc(%ebp)
  800761:	50                   	push   %eax
  800762:	e8 48 ff ff ff       	call   8006af <vcprintf>
  800767:	83 c4 10             	add    $0x10,%esp
  80076a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80076d:	e8 29 12 00 00       	call   80199b <sys_enable_interrupt>
	return cnt;
  800772:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800775:	c9                   	leave  
  800776:	c3                   	ret    

00800777 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
  80077a:	53                   	push   %ebx
  80077b:	83 ec 14             	sub    $0x14,%esp
  80077e:	8b 45 10             	mov    0x10(%ebp),%eax
  800781:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800784:	8b 45 14             	mov    0x14(%ebp),%eax
  800787:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80078a:	8b 45 18             	mov    0x18(%ebp),%eax
  80078d:	ba 00 00 00 00       	mov    $0x0,%edx
  800792:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800795:	77 55                	ja     8007ec <printnum+0x75>
  800797:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80079a:	72 05                	jb     8007a1 <printnum+0x2a>
  80079c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80079f:	77 4b                	ja     8007ec <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007a1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007a4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007a7:	8b 45 18             	mov    0x18(%ebp),%eax
  8007aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8007af:	52                   	push   %edx
  8007b0:	50                   	push   %eax
  8007b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b4:	ff 75 f0             	pushl  -0x10(%ebp)
  8007b7:	e8 e8 15 00 00       	call   801da4 <__udivdi3>
  8007bc:	83 c4 10             	add    $0x10,%esp
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	ff 75 20             	pushl  0x20(%ebp)
  8007c5:	53                   	push   %ebx
  8007c6:	ff 75 18             	pushl  0x18(%ebp)
  8007c9:	52                   	push   %edx
  8007ca:	50                   	push   %eax
  8007cb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ce:	ff 75 08             	pushl  0x8(%ebp)
  8007d1:	e8 a1 ff ff ff       	call   800777 <printnum>
  8007d6:	83 c4 20             	add    $0x20,%esp
  8007d9:	eb 1a                	jmp    8007f5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007db:	83 ec 08             	sub    $0x8,%esp
  8007de:	ff 75 0c             	pushl  0xc(%ebp)
  8007e1:	ff 75 20             	pushl  0x20(%ebp)
  8007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e7:	ff d0                	call   *%eax
  8007e9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007ec:	ff 4d 1c             	decl   0x1c(%ebp)
  8007ef:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007f3:	7f e6                	jg     8007db <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007f5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007f8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800800:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800803:	53                   	push   %ebx
  800804:	51                   	push   %ecx
  800805:	52                   	push   %edx
  800806:	50                   	push   %eax
  800807:	e8 a8 16 00 00       	call   801eb4 <__umoddi3>
  80080c:	83 c4 10             	add    $0x10,%esp
  80080f:	05 54 26 80 00       	add    $0x802654,%eax
  800814:	8a 00                	mov    (%eax),%al
  800816:	0f be c0             	movsbl %al,%eax
  800819:	83 ec 08             	sub    $0x8,%esp
  80081c:	ff 75 0c             	pushl  0xc(%ebp)
  80081f:	50                   	push   %eax
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	ff d0                	call   *%eax
  800825:	83 c4 10             	add    $0x10,%esp
}
  800828:	90                   	nop
  800829:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80082c:	c9                   	leave  
  80082d:	c3                   	ret    

0080082e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80082e:	55                   	push   %ebp
  80082f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800831:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800835:	7e 1c                	jle    800853 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800837:	8b 45 08             	mov    0x8(%ebp),%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	8d 50 08             	lea    0x8(%eax),%edx
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	89 10                	mov    %edx,(%eax)
  800844:	8b 45 08             	mov    0x8(%ebp),%eax
  800847:	8b 00                	mov    (%eax),%eax
  800849:	83 e8 08             	sub    $0x8,%eax
  80084c:	8b 50 04             	mov    0x4(%eax),%edx
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	eb 40                	jmp    800893 <getuint+0x65>
	else if (lflag)
  800853:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800857:	74 1e                	je     800877 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	8d 50 04             	lea    0x4(%eax),%edx
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	89 10                	mov    %edx,(%eax)
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	83 e8 04             	sub    $0x4,%eax
  80086e:	8b 00                	mov    (%eax),%eax
  800870:	ba 00 00 00 00       	mov    $0x0,%edx
  800875:	eb 1c                	jmp    800893 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	8d 50 04             	lea    0x4(%eax),%edx
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	89 10                	mov    %edx,(%eax)
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	8b 00                	mov    (%eax),%eax
  800889:	83 e8 04             	sub    $0x4,%eax
  80088c:	8b 00                	mov    (%eax),%eax
  80088e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800893:	5d                   	pop    %ebp
  800894:	c3                   	ret    

00800895 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800895:	55                   	push   %ebp
  800896:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800898:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80089c:	7e 1c                	jle    8008ba <getint+0x25>
		return va_arg(*ap, long long);
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	8d 50 08             	lea    0x8(%eax),%edx
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	89 10                	mov    %edx,(%eax)
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	8b 00                	mov    (%eax),%eax
  8008b0:	83 e8 08             	sub    $0x8,%eax
  8008b3:	8b 50 04             	mov    0x4(%eax),%edx
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	eb 38                	jmp    8008f2 <getint+0x5d>
	else if (lflag)
  8008ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008be:	74 1a                	je     8008da <getint+0x45>
		return va_arg(*ap, long);
  8008c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c3:	8b 00                	mov    (%eax),%eax
  8008c5:	8d 50 04             	lea    0x4(%eax),%edx
  8008c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cb:	89 10                	mov    %edx,(%eax)
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	8b 00                	mov    (%eax),%eax
  8008d2:	83 e8 04             	sub    $0x4,%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	99                   	cltd   
  8008d8:	eb 18                	jmp    8008f2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008da:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dd:	8b 00                	mov    (%eax),%eax
  8008df:	8d 50 04             	lea    0x4(%eax),%edx
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	89 10                	mov    %edx,(%eax)
  8008e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ea:	8b 00                	mov    (%eax),%eax
  8008ec:	83 e8 04             	sub    $0x4,%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	99                   	cltd   
}
  8008f2:	5d                   	pop    %ebp
  8008f3:	c3                   	ret    

008008f4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008f4:	55                   	push   %ebp
  8008f5:	89 e5                	mov    %esp,%ebp
  8008f7:	56                   	push   %esi
  8008f8:	53                   	push   %ebx
  8008f9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008fc:	eb 17                	jmp    800915 <vprintfmt+0x21>
			if (ch == '\0')
  8008fe:	85 db                	test   %ebx,%ebx
  800900:	0f 84 af 03 00 00    	je     800cb5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800906:	83 ec 08             	sub    $0x8,%esp
  800909:	ff 75 0c             	pushl  0xc(%ebp)
  80090c:	53                   	push   %ebx
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	ff d0                	call   *%eax
  800912:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800915:	8b 45 10             	mov    0x10(%ebp),%eax
  800918:	8d 50 01             	lea    0x1(%eax),%edx
  80091b:	89 55 10             	mov    %edx,0x10(%ebp)
  80091e:	8a 00                	mov    (%eax),%al
  800920:	0f b6 d8             	movzbl %al,%ebx
  800923:	83 fb 25             	cmp    $0x25,%ebx
  800926:	75 d6                	jne    8008fe <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800928:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80092c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800933:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80093a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800941:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800948:	8b 45 10             	mov    0x10(%ebp),%eax
  80094b:	8d 50 01             	lea    0x1(%eax),%edx
  80094e:	89 55 10             	mov    %edx,0x10(%ebp)
  800951:	8a 00                	mov    (%eax),%al
  800953:	0f b6 d8             	movzbl %al,%ebx
  800956:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800959:	83 f8 55             	cmp    $0x55,%eax
  80095c:	0f 87 2b 03 00 00    	ja     800c8d <vprintfmt+0x399>
  800962:	8b 04 85 78 26 80 00 	mov    0x802678(,%eax,4),%eax
  800969:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80096b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80096f:	eb d7                	jmp    800948 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800971:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800975:	eb d1                	jmp    800948 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800977:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80097e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800981:	89 d0                	mov    %edx,%eax
  800983:	c1 e0 02             	shl    $0x2,%eax
  800986:	01 d0                	add    %edx,%eax
  800988:	01 c0                	add    %eax,%eax
  80098a:	01 d8                	add    %ebx,%eax
  80098c:	83 e8 30             	sub    $0x30,%eax
  80098f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800992:	8b 45 10             	mov    0x10(%ebp),%eax
  800995:	8a 00                	mov    (%eax),%al
  800997:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80099a:	83 fb 2f             	cmp    $0x2f,%ebx
  80099d:	7e 3e                	jle    8009dd <vprintfmt+0xe9>
  80099f:	83 fb 39             	cmp    $0x39,%ebx
  8009a2:	7f 39                	jg     8009dd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009a4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009a7:	eb d5                	jmp    80097e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ac:	83 c0 04             	add    $0x4,%eax
  8009af:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b5:	83 e8 04             	sub    $0x4,%eax
  8009b8:	8b 00                	mov    (%eax),%eax
  8009ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009bd:	eb 1f                	jmp    8009de <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c3:	79 83                	jns    800948 <vprintfmt+0x54>
				width = 0;
  8009c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009cc:	e9 77 ff ff ff       	jmp    800948 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009d1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009d8:	e9 6b ff ff ff       	jmp    800948 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009dd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e2:	0f 89 60 ff ff ff    	jns    800948 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009ee:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009f5:	e9 4e ff ff ff       	jmp    800948 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009fa:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009fd:	e9 46 ff ff ff       	jmp    800948 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a02:	8b 45 14             	mov    0x14(%ebp),%eax
  800a05:	83 c0 04             	add    $0x4,%eax
  800a08:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0e:	83 e8 04             	sub    $0x4,%eax
  800a11:	8b 00                	mov    (%eax),%eax
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	50                   	push   %eax
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	ff d0                	call   *%eax
  800a1f:	83 c4 10             	add    $0x10,%esp
			break;
  800a22:	e9 89 02 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	83 c0 04             	add    $0x4,%eax
  800a2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a30:	8b 45 14             	mov    0x14(%ebp),%eax
  800a33:	83 e8 04             	sub    $0x4,%eax
  800a36:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a38:	85 db                	test   %ebx,%ebx
  800a3a:	79 02                	jns    800a3e <vprintfmt+0x14a>
				err = -err;
  800a3c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a3e:	83 fb 64             	cmp    $0x64,%ebx
  800a41:	7f 0b                	jg     800a4e <vprintfmt+0x15a>
  800a43:	8b 34 9d c0 24 80 00 	mov    0x8024c0(,%ebx,4),%esi
  800a4a:	85 f6                	test   %esi,%esi
  800a4c:	75 19                	jne    800a67 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a4e:	53                   	push   %ebx
  800a4f:	68 65 26 80 00       	push   $0x802665
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	ff 75 08             	pushl  0x8(%ebp)
  800a5a:	e8 5e 02 00 00       	call   800cbd <printfmt>
  800a5f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a62:	e9 49 02 00 00       	jmp    800cb0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a67:	56                   	push   %esi
  800a68:	68 6e 26 80 00       	push   $0x80266e
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	ff 75 08             	pushl  0x8(%ebp)
  800a73:	e8 45 02 00 00       	call   800cbd <printfmt>
  800a78:	83 c4 10             	add    $0x10,%esp
			break;
  800a7b:	e9 30 02 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a80:	8b 45 14             	mov    0x14(%ebp),%eax
  800a83:	83 c0 04             	add    $0x4,%eax
  800a86:	89 45 14             	mov    %eax,0x14(%ebp)
  800a89:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8c:	83 e8 04             	sub    $0x4,%eax
  800a8f:	8b 30                	mov    (%eax),%esi
  800a91:	85 f6                	test   %esi,%esi
  800a93:	75 05                	jne    800a9a <vprintfmt+0x1a6>
				p = "(null)";
  800a95:	be 71 26 80 00       	mov    $0x802671,%esi
			if (width > 0 && padc != '-')
  800a9a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a9e:	7e 6d                	jle    800b0d <vprintfmt+0x219>
  800aa0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800aa4:	74 67                	je     800b0d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aa6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa9:	83 ec 08             	sub    $0x8,%esp
  800aac:	50                   	push   %eax
  800aad:	56                   	push   %esi
  800aae:	e8 0c 03 00 00       	call   800dbf <strnlen>
  800ab3:	83 c4 10             	add    $0x10,%esp
  800ab6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ab9:	eb 16                	jmp    800ad1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800abb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800abf:	83 ec 08             	sub    $0x8,%esp
  800ac2:	ff 75 0c             	pushl  0xc(%ebp)
  800ac5:	50                   	push   %eax
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	ff d0                	call   *%eax
  800acb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ace:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad5:	7f e4                	jg     800abb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad7:	eb 34                	jmp    800b0d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ad9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800add:	74 1c                	je     800afb <vprintfmt+0x207>
  800adf:	83 fb 1f             	cmp    $0x1f,%ebx
  800ae2:	7e 05                	jle    800ae9 <vprintfmt+0x1f5>
  800ae4:	83 fb 7e             	cmp    $0x7e,%ebx
  800ae7:	7e 12                	jle    800afb <vprintfmt+0x207>
					putch('?', putdat);
  800ae9:	83 ec 08             	sub    $0x8,%esp
  800aec:	ff 75 0c             	pushl  0xc(%ebp)
  800aef:	6a 3f                	push   $0x3f
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	ff d0                	call   *%eax
  800af6:	83 c4 10             	add    $0x10,%esp
  800af9:	eb 0f                	jmp    800b0a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800afb:	83 ec 08             	sub    $0x8,%esp
  800afe:	ff 75 0c             	pushl  0xc(%ebp)
  800b01:	53                   	push   %ebx
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	ff d0                	call   *%eax
  800b07:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b0a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b0d:	89 f0                	mov    %esi,%eax
  800b0f:	8d 70 01             	lea    0x1(%eax),%esi
  800b12:	8a 00                	mov    (%eax),%al
  800b14:	0f be d8             	movsbl %al,%ebx
  800b17:	85 db                	test   %ebx,%ebx
  800b19:	74 24                	je     800b3f <vprintfmt+0x24b>
  800b1b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b1f:	78 b8                	js     800ad9 <vprintfmt+0x1e5>
  800b21:	ff 4d e0             	decl   -0x20(%ebp)
  800b24:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b28:	79 af                	jns    800ad9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b2a:	eb 13                	jmp    800b3f <vprintfmt+0x24b>
				putch(' ', putdat);
  800b2c:	83 ec 08             	sub    $0x8,%esp
  800b2f:	ff 75 0c             	pushl  0xc(%ebp)
  800b32:	6a 20                	push   $0x20
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	ff d0                	call   *%eax
  800b39:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b3c:	ff 4d e4             	decl   -0x1c(%ebp)
  800b3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b43:	7f e7                	jg     800b2c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b45:	e9 66 01 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 e8             	pushl  -0x18(%ebp)
  800b50:	8d 45 14             	lea    0x14(%ebp),%eax
  800b53:	50                   	push   %eax
  800b54:	e8 3c fd ff ff       	call   800895 <getint>
  800b59:	83 c4 10             	add    $0x10,%esp
  800b5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b68:	85 d2                	test   %edx,%edx
  800b6a:	79 23                	jns    800b8f <vprintfmt+0x29b>
				putch('-', putdat);
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	6a 2d                	push   $0x2d
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	ff d0                	call   *%eax
  800b79:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b82:	f7 d8                	neg    %eax
  800b84:	83 d2 00             	adc    $0x0,%edx
  800b87:	f7 da                	neg    %edx
  800b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b8f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b96:	e9 bc 00 00 00       	jmp    800c57 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 e8             	pushl  -0x18(%ebp)
  800ba1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba4:	50                   	push   %eax
  800ba5:	e8 84 fc ff ff       	call   80082e <getuint>
  800baa:	83 c4 10             	add    $0x10,%esp
  800bad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bb3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bba:	e9 98 00 00 00       	jmp    800c57 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	6a 58                	push   $0x58
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	ff d0                	call   *%eax
  800bcc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bcf:	83 ec 08             	sub    $0x8,%esp
  800bd2:	ff 75 0c             	pushl  0xc(%ebp)
  800bd5:	6a 58                	push   $0x58
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	ff d0                	call   *%eax
  800bdc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bdf:	83 ec 08             	sub    $0x8,%esp
  800be2:	ff 75 0c             	pushl  0xc(%ebp)
  800be5:	6a 58                	push   $0x58
  800be7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bea:	ff d0                	call   *%eax
  800bec:	83 c4 10             	add    $0x10,%esp
			break;
  800bef:	e9 bc 00 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bf4:	83 ec 08             	sub    $0x8,%esp
  800bf7:	ff 75 0c             	pushl  0xc(%ebp)
  800bfa:	6a 30                	push   $0x30
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	ff d0                	call   *%eax
  800c01:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 0c             	pushl  0xc(%ebp)
  800c0a:	6a 78                	push   $0x78
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	ff d0                	call   *%eax
  800c11:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c14:	8b 45 14             	mov    0x14(%ebp),%eax
  800c17:	83 c0 04             	add    $0x4,%eax
  800c1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c20:	83 e8 04             	sub    $0x4,%eax
  800c23:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c2f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c36:	eb 1f                	jmp    800c57 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c38:	83 ec 08             	sub    $0x8,%esp
  800c3b:	ff 75 e8             	pushl  -0x18(%ebp)
  800c3e:	8d 45 14             	lea    0x14(%ebp),%eax
  800c41:	50                   	push   %eax
  800c42:	e8 e7 fb ff ff       	call   80082e <getuint>
  800c47:	83 c4 10             	add    $0x10,%esp
  800c4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c50:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c57:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c5e:	83 ec 04             	sub    $0x4,%esp
  800c61:	52                   	push   %edx
  800c62:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c65:	50                   	push   %eax
  800c66:	ff 75 f4             	pushl  -0xc(%ebp)
  800c69:	ff 75 f0             	pushl  -0x10(%ebp)
  800c6c:	ff 75 0c             	pushl  0xc(%ebp)
  800c6f:	ff 75 08             	pushl  0x8(%ebp)
  800c72:	e8 00 fb ff ff       	call   800777 <printnum>
  800c77:	83 c4 20             	add    $0x20,%esp
			break;
  800c7a:	eb 34                	jmp    800cb0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c7c:	83 ec 08             	sub    $0x8,%esp
  800c7f:	ff 75 0c             	pushl  0xc(%ebp)
  800c82:	53                   	push   %ebx
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	ff d0                	call   *%eax
  800c88:	83 c4 10             	add    $0x10,%esp
			break;
  800c8b:	eb 23                	jmp    800cb0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c8d:	83 ec 08             	sub    $0x8,%esp
  800c90:	ff 75 0c             	pushl  0xc(%ebp)
  800c93:	6a 25                	push   $0x25
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
  800c98:	ff d0                	call   *%eax
  800c9a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c9d:	ff 4d 10             	decl   0x10(%ebp)
  800ca0:	eb 03                	jmp    800ca5 <vprintfmt+0x3b1>
  800ca2:	ff 4d 10             	decl   0x10(%ebp)
  800ca5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca8:	48                   	dec    %eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	3c 25                	cmp    $0x25,%al
  800cad:	75 f3                	jne    800ca2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800caf:	90                   	nop
		}
	}
  800cb0:	e9 47 fc ff ff       	jmp    8008fc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cb5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cb9:	5b                   	pop    %ebx
  800cba:	5e                   	pop    %esi
  800cbb:	5d                   	pop    %ebp
  800cbc:	c3                   	ret    

00800cbd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cbd:	55                   	push   %ebp
  800cbe:	89 e5                	mov    %esp,%ebp
  800cc0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cc3:	8d 45 10             	lea    0x10(%ebp),%eax
  800cc6:	83 c0 04             	add    $0x4,%eax
  800cc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ccc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccf:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd2:	50                   	push   %eax
  800cd3:	ff 75 0c             	pushl  0xc(%ebp)
  800cd6:	ff 75 08             	pushl  0x8(%ebp)
  800cd9:	e8 16 fc ff ff       	call   8008f4 <vprintfmt>
  800cde:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ce1:	90                   	nop
  800ce2:	c9                   	leave  
  800ce3:	c3                   	ret    

00800ce4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ce4:	55                   	push   %ebp
  800ce5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	8b 40 08             	mov    0x8(%eax),%eax
  800ced:	8d 50 01             	lea    0x1(%eax),%edx
  800cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf9:	8b 10                	mov    (%eax),%edx
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	8b 40 04             	mov    0x4(%eax),%eax
  800d01:	39 c2                	cmp    %eax,%edx
  800d03:	73 12                	jae    800d17 <sprintputch+0x33>
		*b->buf++ = ch;
  800d05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d08:	8b 00                	mov    (%eax),%eax
  800d0a:	8d 48 01             	lea    0x1(%eax),%ecx
  800d0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d10:	89 0a                	mov    %ecx,(%edx)
  800d12:	8b 55 08             	mov    0x8(%ebp),%edx
  800d15:	88 10                	mov    %dl,(%eax)
}
  800d17:	90                   	nop
  800d18:	5d                   	pop    %ebp
  800d19:	c3                   	ret    

00800d1a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d1a:	55                   	push   %ebp
  800d1b:	89 e5                	mov    %esp,%ebp
  800d1d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d29:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	01 d0                	add    %edx,%eax
  800d31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d3b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d3f:	74 06                	je     800d47 <vsnprintf+0x2d>
  800d41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d45:	7f 07                	jg     800d4e <vsnprintf+0x34>
		return -E_INVAL;
  800d47:	b8 03 00 00 00       	mov    $0x3,%eax
  800d4c:	eb 20                	jmp    800d6e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d4e:	ff 75 14             	pushl  0x14(%ebp)
  800d51:	ff 75 10             	pushl  0x10(%ebp)
  800d54:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d57:	50                   	push   %eax
  800d58:	68 e4 0c 80 00       	push   $0x800ce4
  800d5d:	e8 92 fb ff ff       	call   8008f4 <vprintfmt>
  800d62:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d65:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d68:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d6e:	c9                   	leave  
  800d6f:	c3                   	ret    

00800d70 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d76:	8d 45 10             	lea    0x10(%ebp),%eax
  800d79:	83 c0 04             	add    $0x4,%eax
  800d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d82:	ff 75 f4             	pushl  -0xc(%ebp)
  800d85:	50                   	push   %eax
  800d86:	ff 75 0c             	pushl  0xc(%ebp)
  800d89:	ff 75 08             	pushl  0x8(%ebp)
  800d8c:	e8 89 ff ff ff       	call   800d1a <vsnprintf>
  800d91:	83 c4 10             	add    $0x10,%esp
  800d94:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d97:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d9a:	c9                   	leave  
  800d9b:	c3                   	ret    

00800d9c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d9c:	55                   	push   %ebp
  800d9d:	89 e5                	mov    %esp,%ebp
  800d9f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800da2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da9:	eb 06                	jmp    800db1 <strlen+0x15>
		n++;
  800dab:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dae:	ff 45 08             	incl   0x8(%ebp)
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	84 c0                	test   %al,%al
  800db8:	75 f1                	jne    800dab <strlen+0xf>
		n++;
	return n;
  800dba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dbd:	c9                   	leave  
  800dbe:	c3                   	ret    

00800dbf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dbf:	55                   	push   %ebp
  800dc0:	89 e5                	mov    %esp,%ebp
  800dc2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dc5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dcc:	eb 09                	jmp    800dd7 <strnlen+0x18>
		n++;
  800dce:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dd1:	ff 45 08             	incl   0x8(%ebp)
  800dd4:	ff 4d 0c             	decl   0xc(%ebp)
  800dd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ddb:	74 09                	je     800de6 <strnlen+0x27>
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	84 c0                	test   %al,%al
  800de4:	75 e8                	jne    800dce <strnlen+0xf>
		n++;
	return n;
  800de6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800df7:	90                   	nop
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8d 50 01             	lea    0x1(%eax),%edx
  800dfe:	89 55 08             	mov    %edx,0x8(%ebp)
  800e01:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e04:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e07:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e0a:	8a 12                	mov    (%edx),%dl
  800e0c:	88 10                	mov    %dl,(%eax)
  800e0e:	8a 00                	mov    (%eax),%al
  800e10:	84 c0                	test   %al,%al
  800e12:	75 e4                	jne    800df8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e17:	c9                   	leave  
  800e18:	c3                   	ret    

00800e19 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e19:	55                   	push   %ebp
  800e1a:	89 e5                	mov    %esp,%ebp
  800e1c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e2c:	eb 1f                	jmp    800e4d <strncpy+0x34>
		*dst++ = *src;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8d 50 01             	lea    0x1(%eax),%edx
  800e34:	89 55 08             	mov    %edx,0x8(%ebp)
  800e37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3a:	8a 12                	mov    (%edx),%dl
  800e3c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	84 c0                	test   %al,%al
  800e45:	74 03                	je     800e4a <strncpy+0x31>
			src++;
  800e47:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e4a:	ff 45 fc             	incl   -0x4(%ebp)
  800e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e50:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e53:	72 d9                	jb     800e2e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e55:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e58:	c9                   	leave  
  800e59:	c3                   	ret    

00800e5a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e5a:	55                   	push   %ebp
  800e5b:	89 e5                	mov    %esp,%ebp
  800e5d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6a:	74 30                	je     800e9c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e6c:	eb 16                	jmp    800e84 <strlcpy+0x2a>
			*dst++ = *src++;
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8d 50 01             	lea    0x1(%eax),%edx
  800e74:	89 55 08             	mov    %edx,0x8(%ebp)
  800e77:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e7a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e7d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e80:	8a 12                	mov    (%edx),%dl
  800e82:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e84:	ff 4d 10             	decl   0x10(%ebp)
  800e87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e8b:	74 09                	je     800e96 <strlcpy+0x3c>
  800e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e90:	8a 00                	mov    (%eax),%al
  800e92:	84 c0                	test   %al,%al
  800e94:	75 d8                	jne    800e6e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e9c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea2:	29 c2                	sub    %eax,%edx
  800ea4:	89 d0                	mov    %edx,%eax
}
  800ea6:	c9                   	leave  
  800ea7:	c3                   	ret    

00800ea8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ea8:	55                   	push   %ebp
  800ea9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800eab:	eb 06                	jmp    800eb3 <strcmp+0xb>
		p++, q++;
  800ead:	ff 45 08             	incl   0x8(%ebp)
  800eb0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	8a 00                	mov    (%eax),%al
  800eb8:	84 c0                	test   %al,%al
  800eba:	74 0e                	je     800eca <strcmp+0x22>
  800ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebf:	8a 10                	mov    (%eax),%dl
  800ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec4:	8a 00                	mov    (%eax),%al
  800ec6:	38 c2                	cmp    %al,%dl
  800ec8:	74 e3                	je     800ead <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	0f b6 d0             	movzbl %al,%edx
  800ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	0f b6 c0             	movzbl %al,%eax
  800eda:	29 c2                	sub    %eax,%edx
  800edc:	89 d0                	mov    %edx,%eax
}
  800ede:	5d                   	pop    %ebp
  800edf:	c3                   	ret    

00800ee0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ee3:	eb 09                	jmp    800eee <strncmp+0xe>
		n--, p++, q++;
  800ee5:	ff 4d 10             	decl   0x10(%ebp)
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800eee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef2:	74 17                	je     800f0b <strncmp+0x2b>
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	8a 00                	mov    (%eax),%al
  800ef9:	84 c0                	test   %al,%al
  800efb:	74 0e                	je     800f0b <strncmp+0x2b>
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 10                	mov    (%eax),%dl
  800f02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f05:	8a 00                	mov    (%eax),%al
  800f07:	38 c2                	cmp    %al,%dl
  800f09:	74 da                	je     800ee5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f0f:	75 07                	jne    800f18 <strncmp+0x38>
		return 0;
  800f11:	b8 00 00 00 00       	mov    $0x0,%eax
  800f16:	eb 14                	jmp    800f2c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	0f b6 d0             	movzbl %al,%edx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	0f b6 c0             	movzbl %al,%eax
  800f28:	29 c2                	sub    %eax,%edx
  800f2a:	89 d0                	mov    %edx,%eax
}
  800f2c:	5d                   	pop    %ebp
  800f2d:	c3                   	ret    

00800f2e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
  800f31:	83 ec 04             	sub    $0x4,%esp
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f3a:	eb 12                	jmp    800f4e <strchr+0x20>
		if (*s == c)
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f44:	75 05                	jne    800f4b <strchr+0x1d>
			return (char *) s;
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	eb 11                	jmp    800f5c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	84 c0                	test   %al,%al
  800f55:	75 e5                	jne    800f3c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f5c:	c9                   	leave  
  800f5d:	c3                   	ret    

00800f5e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f5e:	55                   	push   %ebp
  800f5f:	89 e5                	mov    %esp,%ebp
  800f61:	83 ec 04             	sub    $0x4,%esp
  800f64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f67:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f6a:	eb 0d                	jmp    800f79 <strfind+0x1b>
		if (*s == c)
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f74:	74 0e                	je     800f84 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f76:	ff 45 08             	incl   0x8(%ebp)
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	84 c0                	test   %al,%al
  800f80:	75 ea                	jne    800f6c <strfind+0xe>
  800f82:	eb 01                	jmp    800f85 <strfind+0x27>
		if (*s == c)
			break;
  800f84:	90                   	nop
	return (char *) s;
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f88:	c9                   	leave  
  800f89:	c3                   	ret    

00800f8a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f8a:	55                   	push   %ebp
  800f8b:	89 e5                	mov    %esp,%ebp
  800f8d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f96:	8b 45 10             	mov    0x10(%ebp),%eax
  800f99:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f9c:	eb 0e                	jmp    800fac <memset+0x22>
		*p++ = c;
  800f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa1:	8d 50 01             	lea    0x1(%eax),%edx
  800fa4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fa7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800faa:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fac:	ff 4d f8             	decl   -0x8(%ebp)
  800faf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fb3:	79 e9                	jns    800f9e <memset+0x14>
		*p++ = c;

	return v;
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb8:	c9                   	leave  
  800fb9:	c3                   	ret    

00800fba <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fba:	55                   	push   %ebp
  800fbb:	89 e5                	mov    %esp,%ebp
  800fbd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fcc:	eb 16                	jmp    800fe4 <memcpy+0x2a>
		*d++ = *s++;
  800fce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd1:	8d 50 01             	lea    0x1(%eax),%edx
  800fd4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fda:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fdd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fe0:	8a 12                	mov    (%edx),%dl
  800fe2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fe4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fea:	89 55 10             	mov    %edx,0x10(%ebp)
  800fed:	85 c0                	test   %eax,%eax
  800fef:	75 dd                	jne    800fce <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801008:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80100e:	73 50                	jae    801060 <memmove+0x6a>
  801010:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801013:	8b 45 10             	mov    0x10(%ebp),%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80101b:	76 43                	jbe    801060 <memmove+0x6a>
		s += n;
  80101d:	8b 45 10             	mov    0x10(%ebp),%eax
  801020:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801023:	8b 45 10             	mov    0x10(%ebp),%eax
  801026:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801029:	eb 10                	jmp    80103b <memmove+0x45>
			*--d = *--s;
  80102b:	ff 4d f8             	decl   -0x8(%ebp)
  80102e:	ff 4d fc             	decl   -0x4(%ebp)
  801031:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801034:	8a 10                	mov    (%eax),%dl
  801036:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801039:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80103b:	8b 45 10             	mov    0x10(%ebp),%eax
  80103e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801041:	89 55 10             	mov    %edx,0x10(%ebp)
  801044:	85 c0                	test   %eax,%eax
  801046:	75 e3                	jne    80102b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801048:	eb 23                	jmp    80106d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80104a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104d:	8d 50 01             	lea    0x1(%eax),%edx
  801050:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801053:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801056:	8d 4a 01             	lea    0x1(%edx),%ecx
  801059:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80105c:	8a 12                	mov    (%edx),%dl
  80105e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801060:	8b 45 10             	mov    0x10(%ebp),%eax
  801063:	8d 50 ff             	lea    -0x1(%eax),%edx
  801066:	89 55 10             	mov    %edx,0x10(%ebp)
  801069:	85 c0                	test   %eax,%eax
  80106b:	75 dd                	jne    80104a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801070:	c9                   	leave  
  801071:	c3                   	ret    

00801072 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801072:	55                   	push   %ebp
  801073:	89 e5                	mov    %esp,%ebp
  801075:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801081:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801084:	eb 2a                	jmp    8010b0 <memcmp+0x3e>
		if (*s1 != *s2)
  801086:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801089:	8a 10                	mov    (%eax),%dl
  80108b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108e:	8a 00                	mov    (%eax),%al
  801090:	38 c2                	cmp    %al,%dl
  801092:	74 16                	je     8010aa <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801094:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801097:	8a 00                	mov    (%eax),%al
  801099:	0f b6 d0             	movzbl %al,%edx
  80109c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	0f b6 c0             	movzbl %al,%eax
  8010a4:	29 c2                	sub    %eax,%edx
  8010a6:	89 d0                	mov    %edx,%eax
  8010a8:	eb 18                	jmp    8010c2 <memcmp+0x50>
		s1++, s2++;
  8010aa:	ff 45 fc             	incl   -0x4(%ebp)
  8010ad:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b9:	85 c0                	test   %eax,%eax
  8010bb:	75 c9                	jne    801086 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
  8010c7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8010cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d0:	01 d0                	add    %edx,%eax
  8010d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010d5:	eb 15                	jmp    8010ec <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	0f b6 d0             	movzbl %al,%edx
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	0f b6 c0             	movzbl %al,%eax
  8010e5:	39 c2                	cmp    %eax,%edx
  8010e7:	74 0d                	je     8010f6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010e9:	ff 45 08             	incl   0x8(%ebp)
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010f2:	72 e3                	jb     8010d7 <memfind+0x13>
  8010f4:	eb 01                	jmp    8010f7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010f6:	90                   	nop
	return (void *) s;
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010fa:	c9                   	leave  
  8010fb:	c3                   	ret    

008010fc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010fc:	55                   	push   %ebp
  8010fd:	89 e5                	mov    %esp,%ebp
  8010ff:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801102:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801109:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801110:	eb 03                	jmp    801115 <strtol+0x19>
		s++;
  801112:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	8a 00                	mov    (%eax),%al
  80111a:	3c 20                	cmp    $0x20,%al
  80111c:	74 f4                	je     801112 <strtol+0x16>
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	8a 00                	mov    (%eax),%al
  801123:	3c 09                	cmp    $0x9,%al
  801125:	74 eb                	je     801112 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8a 00                	mov    (%eax),%al
  80112c:	3c 2b                	cmp    $0x2b,%al
  80112e:	75 05                	jne    801135 <strtol+0x39>
		s++;
  801130:	ff 45 08             	incl   0x8(%ebp)
  801133:	eb 13                	jmp    801148 <strtol+0x4c>
	else if (*s == '-')
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
  801138:	8a 00                	mov    (%eax),%al
  80113a:	3c 2d                	cmp    $0x2d,%al
  80113c:	75 0a                	jne    801148 <strtol+0x4c>
		s++, neg = 1;
  80113e:	ff 45 08             	incl   0x8(%ebp)
  801141:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801148:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114c:	74 06                	je     801154 <strtol+0x58>
  80114e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801152:	75 20                	jne    801174 <strtol+0x78>
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	3c 30                	cmp    $0x30,%al
  80115b:	75 17                	jne    801174 <strtol+0x78>
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	40                   	inc    %eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	3c 78                	cmp    $0x78,%al
  801165:	75 0d                	jne    801174 <strtol+0x78>
		s += 2, base = 16;
  801167:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80116b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801172:	eb 28                	jmp    80119c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801174:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801178:	75 15                	jne    80118f <strtol+0x93>
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	3c 30                	cmp    $0x30,%al
  801181:	75 0c                	jne    80118f <strtol+0x93>
		s++, base = 8;
  801183:	ff 45 08             	incl   0x8(%ebp)
  801186:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80118d:	eb 0d                	jmp    80119c <strtol+0xa0>
	else if (base == 0)
  80118f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801193:	75 07                	jne    80119c <strtol+0xa0>
		base = 10;
  801195:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 00                	mov    (%eax),%al
  8011a1:	3c 2f                	cmp    $0x2f,%al
  8011a3:	7e 19                	jle    8011be <strtol+0xc2>
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	3c 39                	cmp    $0x39,%al
  8011ac:	7f 10                	jg     8011be <strtol+0xc2>
			dig = *s - '0';
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	0f be c0             	movsbl %al,%eax
  8011b6:	83 e8 30             	sub    $0x30,%eax
  8011b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011bc:	eb 42                	jmp    801200 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	3c 60                	cmp    $0x60,%al
  8011c5:	7e 19                	jle    8011e0 <strtol+0xe4>
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	3c 7a                	cmp    $0x7a,%al
  8011ce:	7f 10                	jg     8011e0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	8a 00                	mov    (%eax),%al
  8011d5:	0f be c0             	movsbl %al,%eax
  8011d8:	83 e8 57             	sub    $0x57,%eax
  8011db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011de:	eb 20                	jmp    801200 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	3c 40                	cmp    $0x40,%al
  8011e7:	7e 39                	jle    801222 <strtol+0x126>
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	3c 5a                	cmp    $0x5a,%al
  8011f0:	7f 30                	jg     801222 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	0f be c0             	movsbl %al,%eax
  8011fa:	83 e8 37             	sub    $0x37,%eax
  8011fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801200:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801203:	3b 45 10             	cmp    0x10(%ebp),%eax
  801206:	7d 19                	jge    801221 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801208:	ff 45 08             	incl   0x8(%ebp)
  80120b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801212:	89 c2                	mov    %eax,%edx
  801214:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801217:	01 d0                	add    %edx,%eax
  801219:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80121c:	e9 7b ff ff ff       	jmp    80119c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801221:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801222:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801226:	74 08                	je     801230 <strtol+0x134>
		*endptr = (char *) s;
  801228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122b:	8b 55 08             	mov    0x8(%ebp),%edx
  80122e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801230:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801234:	74 07                	je     80123d <strtol+0x141>
  801236:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801239:	f7 d8                	neg    %eax
  80123b:	eb 03                	jmp    801240 <strtol+0x144>
  80123d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <ltostr>:

void
ltostr(long value, char *str)
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
  801245:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80124f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801256:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80125a:	79 13                	jns    80126f <ltostr+0x2d>
	{
		neg = 1;
  80125c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801263:	8b 45 0c             	mov    0xc(%ebp),%eax
  801266:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801269:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80126c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801277:	99                   	cltd   
  801278:	f7 f9                	idiv   %ecx
  80127a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80127d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801280:	8d 50 01             	lea    0x1(%eax),%edx
  801283:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801286:	89 c2                	mov    %eax,%edx
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	01 d0                	add    %edx,%eax
  80128d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801290:	83 c2 30             	add    $0x30,%edx
  801293:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801295:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801298:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80129d:	f7 e9                	imul   %ecx
  80129f:	c1 fa 02             	sar    $0x2,%edx
  8012a2:	89 c8                	mov    %ecx,%eax
  8012a4:	c1 f8 1f             	sar    $0x1f,%eax
  8012a7:	29 c2                	sub    %eax,%edx
  8012a9:	89 d0                	mov    %edx,%eax
  8012ab:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012b1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012b6:	f7 e9                	imul   %ecx
  8012b8:	c1 fa 02             	sar    $0x2,%edx
  8012bb:	89 c8                	mov    %ecx,%eax
  8012bd:	c1 f8 1f             	sar    $0x1f,%eax
  8012c0:	29 c2                	sub    %eax,%edx
  8012c2:	89 d0                	mov    %edx,%eax
  8012c4:	c1 e0 02             	shl    $0x2,%eax
  8012c7:	01 d0                	add    %edx,%eax
  8012c9:	01 c0                	add    %eax,%eax
  8012cb:	29 c1                	sub    %eax,%ecx
  8012cd:	89 ca                	mov    %ecx,%edx
  8012cf:	85 d2                	test   %edx,%edx
  8012d1:	75 9c                	jne    80126f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012dd:	48                   	dec    %eax
  8012de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012e1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012e5:	74 3d                	je     801324 <ltostr+0xe2>
		start = 1 ;
  8012e7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012ee:	eb 34                	jmp    801324 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	01 d0                	add    %edx,%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801300:	8b 45 0c             	mov    0xc(%ebp),%eax
  801303:	01 c2                	add    %eax,%edx
  801305:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130b:	01 c8                	add    %ecx,%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801311:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801314:	8b 45 0c             	mov    0xc(%ebp),%eax
  801317:	01 c2                	add    %eax,%edx
  801319:	8a 45 eb             	mov    -0x15(%ebp),%al
  80131c:	88 02                	mov    %al,(%edx)
		start++ ;
  80131e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801321:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801324:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801327:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80132a:	7c c4                	jl     8012f0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80132c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80132f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801332:	01 d0                	add    %edx,%eax
  801334:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801337:	90                   	nop
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
  80133d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801340:	ff 75 08             	pushl  0x8(%ebp)
  801343:	e8 54 fa ff ff       	call   800d9c <strlen>
  801348:	83 c4 04             	add    $0x4,%esp
  80134b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80134e:	ff 75 0c             	pushl  0xc(%ebp)
  801351:	e8 46 fa ff ff       	call   800d9c <strlen>
  801356:	83 c4 04             	add    $0x4,%esp
  801359:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136a:	eb 17                	jmp    801383 <strcconcat+0x49>
		final[s] = str1[s] ;
  80136c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80136f:	8b 45 10             	mov    0x10(%ebp),%eax
  801372:	01 c2                	add    %eax,%edx
  801374:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	01 c8                	add    %ecx,%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801380:	ff 45 fc             	incl   -0x4(%ebp)
  801383:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801386:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801389:	7c e1                	jl     80136c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80138b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801392:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801399:	eb 1f                	jmp    8013ba <strcconcat+0x80>
		final[s++] = str2[i] ;
  80139b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139e:	8d 50 01             	lea    0x1(%eax),%edx
  8013a1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013a4:	89 c2                	mov    %eax,%edx
  8013a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a9:	01 c2                	add    %eax,%edx
  8013ab:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b1:	01 c8                	add    %ecx,%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013b7:	ff 45 f8             	incl   -0x8(%ebp)
  8013ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013bd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013c0:	7c d9                	jl     80139b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c8:	01 d0                	add    %edx,%eax
  8013ca:	c6 00 00             	movb   $0x0,(%eax)
}
  8013cd:	90                   	nop
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013df:	8b 00                	mov    (%eax),%eax
  8013e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013eb:	01 d0                	add    %edx,%eax
  8013ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013f3:	eb 0c                	jmp    801401 <strsplit+0x31>
			*string++ = 0;
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	8d 50 01             	lea    0x1(%eax),%edx
  8013fb:	89 55 08             	mov    %edx,0x8(%ebp)
  8013fe:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8a 00                	mov    (%eax),%al
  801406:	84 c0                	test   %al,%al
  801408:	74 18                	je     801422 <strsplit+0x52>
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	0f be c0             	movsbl %al,%eax
  801412:	50                   	push   %eax
  801413:	ff 75 0c             	pushl  0xc(%ebp)
  801416:	e8 13 fb ff ff       	call   800f2e <strchr>
  80141b:	83 c4 08             	add    $0x8,%esp
  80141e:	85 c0                	test   %eax,%eax
  801420:	75 d3                	jne    8013f5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	84 c0                	test   %al,%al
  801429:	74 5a                	je     801485 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80142b:	8b 45 14             	mov    0x14(%ebp),%eax
  80142e:	8b 00                	mov    (%eax),%eax
  801430:	83 f8 0f             	cmp    $0xf,%eax
  801433:	75 07                	jne    80143c <strsplit+0x6c>
		{
			return 0;
  801435:	b8 00 00 00 00       	mov    $0x0,%eax
  80143a:	eb 66                	jmp    8014a2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80143c:	8b 45 14             	mov    0x14(%ebp),%eax
  80143f:	8b 00                	mov    (%eax),%eax
  801441:	8d 48 01             	lea    0x1(%eax),%ecx
  801444:	8b 55 14             	mov    0x14(%ebp),%edx
  801447:	89 0a                	mov    %ecx,(%edx)
  801449:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801450:	8b 45 10             	mov    0x10(%ebp),%eax
  801453:	01 c2                	add    %eax,%edx
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80145a:	eb 03                	jmp    80145f <strsplit+0x8f>
			string++;
  80145c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	84 c0                	test   %al,%al
  801466:	74 8b                	je     8013f3 <strsplit+0x23>
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	0f be c0             	movsbl %al,%eax
  801470:	50                   	push   %eax
  801471:	ff 75 0c             	pushl  0xc(%ebp)
  801474:	e8 b5 fa ff ff       	call   800f2e <strchr>
  801479:	83 c4 08             	add    $0x8,%esp
  80147c:	85 c0                	test   %eax,%eax
  80147e:	74 dc                	je     80145c <strsplit+0x8c>
			string++;
	}
  801480:	e9 6e ff ff ff       	jmp    8013f3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801485:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801486:	8b 45 14             	mov    0x14(%ebp),%eax
  801489:	8b 00                	mov    (%eax),%eax
  80148b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801492:	8b 45 10             	mov    0x10(%ebp),%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80149d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
  8014a7:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8014aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ad:	c1 e8 0c             	shr    $0xc,%eax
  8014b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  8014b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b6:	25 ff 0f 00 00       	and    $0xfff,%eax
  8014bb:	85 c0                	test   %eax,%eax
  8014bd:	74 03                	je     8014c2 <malloc+0x1e>
			num++;
  8014bf:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8014c2:	a1 04 30 80 00       	mov    0x803004,%eax
  8014c7:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8014cc:	75 64                	jne    801532 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8014ce:	83 ec 08             	sub    $0x8,%esp
  8014d1:	ff 75 08             	pushl  0x8(%ebp)
  8014d4:	68 00 00 00 80       	push   $0x80000000
  8014d9:	e8 3a 04 00 00       	call   801918 <sys_allocateMem>
  8014de:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8014e1:	a1 04 30 80 00       	mov    0x803004,%eax
  8014e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8014e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ec:	c1 e0 0c             	shl    $0xc,%eax
  8014ef:	89 c2                	mov    %eax,%edx
  8014f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8014f6:	01 d0                	add    %edx,%eax
  8014f8:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  8014fd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801502:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801508:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80150f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801514:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  80151b:	01 00 00 00 
			sizeofarray++;
  80151f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801524:	40                   	inc    %eax
  801525:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80152a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80152d:	e9 26 01 00 00       	jmp    801658 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  801532:	a1 28 30 80 00       	mov    0x803028,%eax
  801537:	85 c0                	test   %eax,%eax
  801539:	75 62                	jne    80159d <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  80153b:	a1 04 30 80 00       	mov    0x803004,%eax
  801540:	83 ec 08             	sub    $0x8,%esp
  801543:	ff 75 08             	pushl  0x8(%ebp)
  801546:	50                   	push   %eax
  801547:	e8 cc 03 00 00       	call   801918 <sys_allocateMem>
  80154c:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  80154f:	a1 04 30 80 00       	mov    0x803004,%eax
  801554:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801557:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80155a:	c1 e0 0c             	shl    $0xc,%eax
  80155d:	89 c2                	mov    %eax,%edx
  80155f:	a1 04 30 80 00       	mov    0x803004,%eax
  801564:	01 d0                	add    %edx,%eax
  801566:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  80156b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801570:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801573:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80157a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80157f:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801586:	01 00 00 00 
				sizeofarray++;
  80158a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80158f:	40                   	inc    %eax
  801590:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801595:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801598:	e9 bb 00 00 00       	jmp    801658 <malloc+0x1b4>
			}
			else{
				int count=0;
  80159d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8015a4:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8015ab:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8015b2:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8015b9:	eb 7c                	jmp    801637 <malloc+0x193>
				{
					uint32 *pg=NULL;
  8015bb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8015c2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8015c9:	eb 1a                	jmp    8015e5 <malloc+0x141>
					{
						if(addresses[j]==i)
  8015cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015ce:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015d5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8015d8:	75 08                	jne    8015e2 <malloc+0x13e>
						{
							index=j;
  8015da:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8015e0:	eb 0d                	jmp    8015ef <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8015e2:	ff 45 dc             	incl   -0x24(%ebp)
  8015e5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015ea:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8015ed:	7c dc                	jl     8015cb <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  8015ef:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8015f3:	75 05                	jne    8015fa <malloc+0x156>
					{
						count++;
  8015f5:	ff 45 f0             	incl   -0x10(%ebp)
  8015f8:	eb 36                	jmp    801630 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  8015fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015fd:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801604:	85 c0                	test   %eax,%eax
  801606:	75 05                	jne    80160d <malloc+0x169>
						{
							count++;
  801608:	ff 45 f0             	incl   -0x10(%ebp)
  80160b:	eb 23                	jmp    801630 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  80160d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801610:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801613:	7d 14                	jge    801629 <malloc+0x185>
  801615:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801618:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80161b:	7c 0c                	jl     801629 <malloc+0x185>
							{
								min=count;
  80161d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801620:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801623:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801626:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801629:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801630:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801637:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80163e:	0f 86 77 ff ff ff    	jbe    8015bb <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  801644:	83 ec 08             	sub    $0x8,%esp
  801647:	ff 75 08             	pushl  0x8(%ebp)
  80164a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80164d:	e8 c6 02 00 00       	call   801918 <sys_allocateMem>
  801652:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  801655:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801658:	c9                   	leave  
  801659:	c3                   	ret    

0080165a <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80165a:	55                   	push   %ebp
  80165b:	89 e5                	mov    %esp,%ebp
  80165d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801660:	83 ec 04             	sub    $0x4,%esp
  801663:	68 d0 27 80 00       	push   $0x8027d0
  801668:	6a 7b                	push   $0x7b
  80166a:	68 f3 27 80 00       	push   $0x8027f3
  80166f:	e8 04 ee ff ff       	call   800478 <_panic>

00801674 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
  801677:	83 ec 18             	sub    $0x18,%esp
  80167a:	8b 45 10             	mov    0x10(%ebp),%eax
  80167d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801680:	83 ec 04             	sub    $0x4,%esp
  801683:	68 00 28 80 00       	push   $0x802800
  801688:	68 88 00 00 00       	push   $0x88
  80168d:	68 f3 27 80 00       	push   $0x8027f3
  801692:	e8 e1 ed ff ff       	call   800478 <_panic>

00801697 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
  80169a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80169d:	83 ec 04             	sub    $0x4,%esp
  8016a0:	68 00 28 80 00       	push   $0x802800
  8016a5:	68 8e 00 00 00       	push   $0x8e
  8016aa:	68 f3 27 80 00       	push   $0x8027f3
  8016af:	e8 c4 ed ff ff       	call   800478 <_panic>

008016b4 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8016b4:	55                   	push   %ebp
  8016b5:	89 e5                	mov    %esp,%ebp
  8016b7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016ba:	83 ec 04             	sub    $0x4,%esp
  8016bd:	68 00 28 80 00       	push   $0x802800
  8016c2:	68 94 00 00 00       	push   $0x94
  8016c7:	68 f3 27 80 00       	push   $0x8027f3
  8016cc:	e8 a7 ed ff ff       	call   800478 <_panic>

008016d1 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
  8016d4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016d7:	83 ec 04             	sub    $0x4,%esp
  8016da:	68 00 28 80 00       	push   $0x802800
  8016df:	68 99 00 00 00       	push   $0x99
  8016e4:	68 f3 27 80 00       	push   $0x8027f3
  8016e9:	e8 8a ed ff ff       	call   800478 <_panic>

008016ee <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
  8016f1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016f4:	83 ec 04             	sub    $0x4,%esp
  8016f7:	68 00 28 80 00       	push   $0x802800
  8016fc:	68 9f 00 00 00       	push   $0x9f
  801701:	68 f3 27 80 00       	push   $0x8027f3
  801706:	e8 6d ed ff ff       	call   800478 <_panic>

0080170b <shrink>:
}
void shrink(uint32 newSize)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
  80170e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801711:	83 ec 04             	sub    $0x4,%esp
  801714:	68 00 28 80 00       	push   $0x802800
  801719:	68 a3 00 00 00       	push   $0xa3
  80171e:	68 f3 27 80 00       	push   $0x8027f3
  801723:	e8 50 ed ff ff       	call   800478 <_panic>

00801728 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80172e:	83 ec 04             	sub    $0x4,%esp
  801731:	68 00 28 80 00       	push   $0x802800
  801736:	68 a8 00 00 00       	push   $0xa8
  80173b:	68 f3 27 80 00       	push   $0x8027f3
  801740:	e8 33 ed ff ff       	call   800478 <_panic>

00801745 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801745:	55                   	push   %ebp
  801746:	89 e5                	mov    %esp,%ebp
  801748:	57                   	push   %edi
  801749:	56                   	push   %esi
  80174a:	53                   	push   %ebx
  80174b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80174e:	8b 45 08             	mov    0x8(%ebp),%eax
  801751:	8b 55 0c             	mov    0xc(%ebp),%edx
  801754:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801757:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80175a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80175d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801760:	cd 30                	int    $0x30
  801762:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801765:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801768:	83 c4 10             	add    $0x10,%esp
  80176b:	5b                   	pop    %ebx
  80176c:	5e                   	pop    %esi
  80176d:	5f                   	pop    %edi
  80176e:	5d                   	pop    %ebp
  80176f:	c3                   	ret    

00801770 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	83 ec 04             	sub    $0x4,%esp
  801776:	8b 45 10             	mov    0x10(%ebp),%eax
  801779:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80177c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	52                   	push   %edx
  801788:	ff 75 0c             	pushl  0xc(%ebp)
  80178b:	50                   	push   %eax
  80178c:	6a 00                	push   $0x0
  80178e:	e8 b2 ff ff ff       	call   801745 <syscall>
  801793:	83 c4 18             	add    $0x18,%esp
}
  801796:	90                   	nop
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <sys_cgetc>:

int
sys_cgetc(void)
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 01                	push   $0x1
  8017a8:	e8 98 ff ff ff       	call   801745 <syscall>
  8017ad:	83 c4 18             	add    $0x18,%esp
}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	50                   	push   %eax
  8017c1:	6a 05                	push   $0x5
  8017c3:	e8 7d ff ff ff       	call   801745 <syscall>
  8017c8:	83 c4 18             	add    $0x18,%esp
}
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 02                	push   $0x2
  8017dc:	e8 64 ff ff ff       	call   801745 <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
}
  8017e4:	c9                   	leave  
  8017e5:	c3                   	ret    

008017e6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 03                	push   $0x3
  8017f5:	e8 4b ff ff ff       	call   801745 <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 04                	push   $0x4
  80180e:	e8 32 ff ff ff       	call   801745 <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <sys_env_exit>:


void sys_env_exit(void)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 06                	push   $0x6
  801827:	e8 19 ff ff ff       	call   801745 <syscall>
  80182c:	83 c4 18             	add    $0x18,%esp
}
  80182f:	90                   	nop
  801830:	c9                   	leave  
  801831:	c3                   	ret    

00801832 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801832:	55                   	push   %ebp
  801833:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801835:	8b 55 0c             	mov    0xc(%ebp),%edx
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	52                   	push   %edx
  801842:	50                   	push   %eax
  801843:	6a 07                	push   $0x7
  801845:	e8 fb fe ff ff       	call   801745 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
}
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
  801852:	56                   	push   %esi
  801853:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801854:	8b 75 18             	mov    0x18(%ebp),%esi
  801857:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80185a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	56                   	push   %esi
  801864:	53                   	push   %ebx
  801865:	51                   	push   %ecx
  801866:	52                   	push   %edx
  801867:	50                   	push   %eax
  801868:	6a 08                	push   $0x8
  80186a:	e8 d6 fe ff ff       	call   801745 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801875:	5b                   	pop    %ebx
  801876:	5e                   	pop    %esi
  801877:	5d                   	pop    %ebp
  801878:	c3                   	ret    

00801879 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80187c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	52                   	push   %edx
  801889:	50                   	push   %eax
  80188a:	6a 09                	push   $0x9
  80188c:	e8 b4 fe ff ff       	call   801745 <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	ff 75 0c             	pushl  0xc(%ebp)
  8018a2:	ff 75 08             	pushl  0x8(%ebp)
  8018a5:	6a 0a                	push   $0xa
  8018a7:	e8 99 fe ff ff       	call   801745 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
}
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 0b                	push   $0xb
  8018c0:	e8 80 fe ff ff       	call   801745 <syscall>
  8018c5:	83 c4 18             	add    $0x18,%esp
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 0c                	push   $0xc
  8018d9:	e8 67 fe ff ff       	call   801745 <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 0d                	push   $0xd
  8018f2:	e8 4e fe ff ff       	call   801745 <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
}
  8018fa:	c9                   	leave  
  8018fb:	c3                   	ret    

008018fc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018fc:	55                   	push   %ebp
  8018fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	ff 75 0c             	pushl  0xc(%ebp)
  801908:	ff 75 08             	pushl  0x8(%ebp)
  80190b:	6a 11                	push   $0x11
  80190d:	e8 33 fe ff ff       	call   801745 <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
	return;
  801915:	90                   	nop
}
  801916:	c9                   	leave  
  801917:	c3                   	ret    

00801918 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	ff 75 0c             	pushl  0xc(%ebp)
  801924:	ff 75 08             	pushl  0x8(%ebp)
  801927:	6a 12                	push   $0x12
  801929:	e8 17 fe ff ff       	call   801745 <syscall>
  80192e:	83 c4 18             	add    $0x18,%esp
	return ;
  801931:	90                   	nop
}
  801932:	c9                   	leave  
  801933:	c3                   	ret    

00801934 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801934:	55                   	push   %ebp
  801935:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 0e                	push   $0xe
  801943:	e8 fd fd ff ff       	call   801745 <syscall>
  801948:	83 c4 18             	add    $0x18,%esp
}
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	ff 75 08             	pushl  0x8(%ebp)
  80195b:	6a 0f                	push   $0xf
  80195d:	e8 e3 fd ff ff       	call   801745 <syscall>
  801962:	83 c4 18             	add    $0x18,%esp
}
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 10                	push   $0x10
  801976:	e8 ca fd ff ff       	call   801745 <syscall>
  80197b:	83 c4 18             	add    $0x18,%esp
}
  80197e:	90                   	nop
  80197f:	c9                   	leave  
  801980:	c3                   	ret    

00801981 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801981:	55                   	push   %ebp
  801982:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 14                	push   $0x14
  801990:	e8 b0 fd ff ff       	call   801745 <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	90                   	nop
  801999:	c9                   	leave  
  80199a:	c3                   	ret    

0080199b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80199b:	55                   	push   %ebp
  80199c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 15                	push   $0x15
  8019aa:	e8 96 fd ff ff       	call   801745 <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
}
  8019b2:	90                   	nop
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
  8019b8:	83 ec 04             	sub    $0x4,%esp
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019c1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	50                   	push   %eax
  8019ce:	6a 16                	push   $0x16
  8019d0:	e8 70 fd ff ff       	call   801745 <syscall>
  8019d5:	83 c4 18             	add    $0x18,%esp
}
  8019d8:	90                   	nop
  8019d9:	c9                   	leave  
  8019da:	c3                   	ret    

008019db <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019db:	55                   	push   %ebp
  8019dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 17                	push   $0x17
  8019ea:	e8 56 fd ff ff       	call   801745 <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
}
  8019f2:	90                   	nop
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	ff 75 0c             	pushl  0xc(%ebp)
  801a04:	50                   	push   %eax
  801a05:	6a 18                	push   $0x18
  801a07:	e8 39 fd ff ff       	call   801745 <syscall>
  801a0c:	83 c4 18             	add    $0x18,%esp
}
  801a0f:	c9                   	leave  
  801a10:	c3                   	ret    

00801a11 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a14:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a17:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	52                   	push   %edx
  801a21:	50                   	push   %eax
  801a22:	6a 1b                	push   $0x1b
  801a24:	e8 1c fd ff ff       	call   801745 <syscall>
  801a29:	83 c4 18             	add    $0x18,%esp
}
  801a2c:	c9                   	leave  
  801a2d:	c3                   	ret    

00801a2e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a2e:	55                   	push   %ebp
  801a2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a34:	8b 45 08             	mov    0x8(%ebp),%eax
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	52                   	push   %edx
  801a3e:	50                   	push   %eax
  801a3f:	6a 19                	push   $0x19
  801a41:	e8 ff fc ff ff       	call   801745 <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	90                   	nop
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a52:	8b 45 08             	mov    0x8(%ebp),%eax
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	52                   	push   %edx
  801a5c:	50                   	push   %eax
  801a5d:	6a 1a                	push   $0x1a
  801a5f:	e8 e1 fc ff ff       	call   801745 <syscall>
  801a64:	83 c4 18             	add    $0x18,%esp
}
  801a67:	90                   	nop
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
  801a6d:	83 ec 04             	sub    $0x4,%esp
  801a70:	8b 45 10             	mov    0x10(%ebp),%eax
  801a73:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a76:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a79:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a80:	6a 00                	push   $0x0
  801a82:	51                   	push   %ecx
  801a83:	52                   	push   %edx
  801a84:	ff 75 0c             	pushl  0xc(%ebp)
  801a87:	50                   	push   %eax
  801a88:	6a 1c                	push   $0x1c
  801a8a:	e8 b6 fc ff ff       	call   801745 <syscall>
  801a8f:	83 c4 18             	add    $0x18,%esp
}
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	52                   	push   %edx
  801aa4:	50                   	push   %eax
  801aa5:	6a 1d                	push   $0x1d
  801aa7:	e8 99 fc ff ff       	call   801745 <syscall>
  801aac:	83 c4 18             	add    $0x18,%esp
}
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ab4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aba:	8b 45 08             	mov    0x8(%ebp),%eax
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	51                   	push   %ecx
  801ac2:	52                   	push   %edx
  801ac3:	50                   	push   %eax
  801ac4:	6a 1e                	push   $0x1e
  801ac6:	e8 7a fc ff ff       	call   801745 <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	52                   	push   %edx
  801ae0:	50                   	push   %eax
  801ae1:	6a 1f                	push   $0x1f
  801ae3:	e8 5d fc ff ff       	call   801745 <syscall>
  801ae8:	83 c4 18             	add    $0x18,%esp
}
  801aeb:	c9                   	leave  
  801aec:	c3                   	ret    

00801aed <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aed:	55                   	push   %ebp
  801aee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 20                	push   $0x20
  801afc:	e8 44 fc ff ff       	call   801745 <syscall>
  801b01:	83 c4 18             	add    $0x18,%esp
}
  801b04:	c9                   	leave  
  801b05:	c3                   	ret    

00801b06 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b06:	55                   	push   %ebp
  801b07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b09:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0c:	6a 00                	push   $0x0
  801b0e:	ff 75 14             	pushl  0x14(%ebp)
  801b11:	ff 75 10             	pushl  0x10(%ebp)
  801b14:	ff 75 0c             	pushl  0xc(%ebp)
  801b17:	50                   	push   %eax
  801b18:	6a 21                	push   $0x21
  801b1a:	e8 26 fc ff ff       	call   801745 <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
}
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b27:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	50                   	push   %eax
  801b33:	6a 22                	push   $0x22
  801b35:	e8 0b fc ff ff       	call   801745 <syscall>
  801b3a:	83 c4 18             	add    $0x18,%esp
}
  801b3d:	90                   	nop
  801b3e:	c9                   	leave  
  801b3f:	c3                   	ret    

00801b40 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b40:	55                   	push   %ebp
  801b41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b43:	8b 45 08             	mov    0x8(%ebp),%eax
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	50                   	push   %eax
  801b4f:	6a 23                	push   $0x23
  801b51:	e8 ef fb ff ff       	call   801745 <syscall>
  801b56:	83 c4 18             	add    $0x18,%esp
}
  801b59:	90                   	nop
  801b5a:	c9                   	leave  
  801b5b:	c3                   	ret    

00801b5c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b5c:	55                   	push   %ebp
  801b5d:	89 e5                	mov    %esp,%ebp
  801b5f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b62:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b65:	8d 50 04             	lea    0x4(%eax),%edx
  801b68:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	52                   	push   %edx
  801b72:	50                   	push   %eax
  801b73:	6a 24                	push   $0x24
  801b75:	e8 cb fb ff ff       	call   801745 <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
	return result;
  801b7d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b83:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b86:	89 01                	mov    %eax,(%ecx)
  801b88:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8e:	c9                   	leave  
  801b8f:	c2 04 00             	ret    $0x4

00801b92 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	ff 75 10             	pushl  0x10(%ebp)
  801b9c:	ff 75 0c             	pushl  0xc(%ebp)
  801b9f:	ff 75 08             	pushl  0x8(%ebp)
  801ba2:	6a 13                	push   $0x13
  801ba4:	e8 9c fb ff ff       	call   801745 <syscall>
  801ba9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bac:	90                   	nop
}
  801bad:	c9                   	leave  
  801bae:	c3                   	ret    

00801baf <sys_rcr2>:
uint32 sys_rcr2()
{
  801baf:	55                   	push   %ebp
  801bb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 25                	push   $0x25
  801bbe:	e8 82 fb ff ff       	call   801745 <syscall>
  801bc3:	83 c4 18             	add    $0x18,%esp
}
  801bc6:	c9                   	leave  
  801bc7:	c3                   	ret    

00801bc8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
  801bcb:	83 ec 04             	sub    $0x4,%esp
  801bce:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bd4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	50                   	push   %eax
  801be1:	6a 26                	push   $0x26
  801be3:	e8 5d fb ff ff       	call   801745 <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
	return ;
  801beb:	90                   	nop
}
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <rsttst>:
void rsttst()
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 28                	push   $0x28
  801bfd:	e8 43 fb ff ff       	call   801745 <syscall>
  801c02:	83 c4 18             	add    $0x18,%esp
	return ;
  801c05:	90                   	nop
}
  801c06:	c9                   	leave  
  801c07:	c3                   	ret    

00801c08 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c08:	55                   	push   %ebp
  801c09:	89 e5                	mov    %esp,%ebp
  801c0b:	83 ec 04             	sub    $0x4,%esp
  801c0e:	8b 45 14             	mov    0x14(%ebp),%eax
  801c11:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c14:	8b 55 18             	mov    0x18(%ebp),%edx
  801c17:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c1b:	52                   	push   %edx
  801c1c:	50                   	push   %eax
  801c1d:	ff 75 10             	pushl  0x10(%ebp)
  801c20:	ff 75 0c             	pushl  0xc(%ebp)
  801c23:	ff 75 08             	pushl  0x8(%ebp)
  801c26:	6a 27                	push   $0x27
  801c28:	e8 18 fb ff ff       	call   801745 <syscall>
  801c2d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c30:	90                   	nop
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <chktst>:
void chktst(uint32 n)
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	ff 75 08             	pushl  0x8(%ebp)
  801c41:	6a 29                	push   $0x29
  801c43:	e8 fd fa ff ff       	call   801745 <syscall>
  801c48:	83 c4 18             	add    $0x18,%esp
	return ;
  801c4b:	90                   	nop
}
  801c4c:	c9                   	leave  
  801c4d:	c3                   	ret    

00801c4e <inctst>:

void inctst()
{
  801c4e:	55                   	push   %ebp
  801c4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 2a                	push   $0x2a
  801c5d:	e8 e3 fa ff ff       	call   801745 <syscall>
  801c62:	83 c4 18             	add    $0x18,%esp
	return ;
  801c65:	90                   	nop
}
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <gettst>:
uint32 gettst()
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 2b                	push   $0x2b
  801c77:	e8 c9 fa ff ff       	call   801745 <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    

00801c81 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c81:	55                   	push   %ebp
  801c82:	89 e5                	mov    %esp,%ebp
  801c84:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 2c                	push   $0x2c
  801c93:	e8 ad fa ff ff       	call   801745 <syscall>
  801c98:	83 c4 18             	add    $0x18,%esp
  801c9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c9e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ca2:	75 07                	jne    801cab <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ca4:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca9:	eb 05                	jmp    801cb0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801cab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb0:	c9                   	leave  
  801cb1:	c3                   	ret    

00801cb2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cb2:	55                   	push   %ebp
  801cb3:	89 e5                	mov    %esp,%ebp
  801cb5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 2c                	push   $0x2c
  801cc4:	e8 7c fa ff ff       	call   801745 <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
  801ccc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ccf:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cd3:	75 07                	jne    801cdc <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cd5:	b8 01 00 00 00       	mov    $0x1,%eax
  801cda:	eb 05                	jmp    801ce1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cdc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce1:	c9                   	leave  
  801ce2:	c3                   	ret    

00801ce3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ce3:	55                   	push   %ebp
  801ce4:	89 e5                	mov    %esp,%ebp
  801ce6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 2c                	push   $0x2c
  801cf5:	e8 4b fa ff ff       	call   801745 <syscall>
  801cfa:	83 c4 18             	add    $0x18,%esp
  801cfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d00:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d04:	75 07                	jne    801d0d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d06:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0b:	eb 05                	jmp    801d12 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
  801d17:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 2c                	push   $0x2c
  801d26:	e8 1a fa ff ff       	call   801745 <syscall>
  801d2b:	83 c4 18             	add    $0x18,%esp
  801d2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d31:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d35:	75 07                	jne    801d3e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d37:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3c:	eb 05                	jmp    801d43 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	ff 75 08             	pushl  0x8(%ebp)
  801d53:	6a 2d                	push   $0x2d
  801d55:	e8 eb f9 ff ff       	call   801745 <syscall>
  801d5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d5d:	90                   	nop
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
  801d63:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d64:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d67:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d70:	6a 00                	push   $0x0
  801d72:	53                   	push   %ebx
  801d73:	51                   	push   %ecx
  801d74:	52                   	push   %edx
  801d75:	50                   	push   %eax
  801d76:	6a 2e                	push   $0x2e
  801d78:	e8 c8 f9 ff ff       	call   801745 <syscall>
  801d7d:	83 c4 18             	add    $0x18,%esp
}
  801d80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	52                   	push   %edx
  801d95:	50                   	push   %eax
  801d96:	6a 2f                	push   $0x2f
  801d98:	e8 a8 f9 ff ff       	call   801745 <syscall>
  801d9d:	83 c4 18             	add    $0x18,%esp
}
  801da0:	c9                   	leave  
  801da1:	c3                   	ret    
  801da2:	66 90                	xchg   %ax,%ax

00801da4 <__udivdi3>:
  801da4:	55                   	push   %ebp
  801da5:	57                   	push   %edi
  801da6:	56                   	push   %esi
  801da7:	53                   	push   %ebx
  801da8:	83 ec 1c             	sub    $0x1c,%esp
  801dab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801daf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801db3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801db7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dbb:	89 ca                	mov    %ecx,%edx
  801dbd:	89 f8                	mov    %edi,%eax
  801dbf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dc3:	85 f6                	test   %esi,%esi
  801dc5:	75 2d                	jne    801df4 <__udivdi3+0x50>
  801dc7:	39 cf                	cmp    %ecx,%edi
  801dc9:	77 65                	ja     801e30 <__udivdi3+0x8c>
  801dcb:	89 fd                	mov    %edi,%ebp
  801dcd:	85 ff                	test   %edi,%edi
  801dcf:	75 0b                	jne    801ddc <__udivdi3+0x38>
  801dd1:	b8 01 00 00 00       	mov    $0x1,%eax
  801dd6:	31 d2                	xor    %edx,%edx
  801dd8:	f7 f7                	div    %edi
  801dda:	89 c5                	mov    %eax,%ebp
  801ddc:	31 d2                	xor    %edx,%edx
  801dde:	89 c8                	mov    %ecx,%eax
  801de0:	f7 f5                	div    %ebp
  801de2:	89 c1                	mov    %eax,%ecx
  801de4:	89 d8                	mov    %ebx,%eax
  801de6:	f7 f5                	div    %ebp
  801de8:	89 cf                	mov    %ecx,%edi
  801dea:	89 fa                	mov    %edi,%edx
  801dec:	83 c4 1c             	add    $0x1c,%esp
  801def:	5b                   	pop    %ebx
  801df0:	5e                   	pop    %esi
  801df1:	5f                   	pop    %edi
  801df2:	5d                   	pop    %ebp
  801df3:	c3                   	ret    
  801df4:	39 ce                	cmp    %ecx,%esi
  801df6:	77 28                	ja     801e20 <__udivdi3+0x7c>
  801df8:	0f bd fe             	bsr    %esi,%edi
  801dfb:	83 f7 1f             	xor    $0x1f,%edi
  801dfe:	75 40                	jne    801e40 <__udivdi3+0x9c>
  801e00:	39 ce                	cmp    %ecx,%esi
  801e02:	72 0a                	jb     801e0e <__udivdi3+0x6a>
  801e04:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e08:	0f 87 9e 00 00 00    	ja     801eac <__udivdi3+0x108>
  801e0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e13:	89 fa                	mov    %edi,%edx
  801e15:	83 c4 1c             	add    $0x1c,%esp
  801e18:	5b                   	pop    %ebx
  801e19:	5e                   	pop    %esi
  801e1a:	5f                   	pop    %edi
  801e1b:	5d                   	pop    %ebp
  801e1c:	c3                   	ret    
  801e1d:	8d 76 00             	lea    0x0(%esi),%esi
  801e20:	31 ff                	xor    %edi,%edi
  801e22:	31 c0                	xor    %eax,%eax
  801e24:	89 fa                	mov    %edi,%edx
  801e26:	83 c4 1c             	add    $0x1c,%esp
  801e29:	5b                   	pop    %ebx
  801e2a:	5e                   	pop    %esi
  801e2b:	5f                   	pop    %edi
  801e2c:	5d                   	pop    %ebp
  801e2d:	c3                   	ret    
  801e2e:	66 90                	xchg   %ax,%ax
  801e30:	89 d8                	mov    %ebx,%eax
  801e32:	f7 f7                	div    %edi
  801e34:	31 ff                	xor    %edi,%edi
  801e36:	89 fa                	mov    %edi,%edx
  801e38:	83 c4 1c             	add    $0x1c,%esp
  801e3b:	5b                   	pop    %ebx
  801e3c:	5e                   	pop    %esi
  801e3d:	5f                   	pop    %edi
  801e3e:	5d                   	pop    %ebp
  801e3f:	c3                   	ret    
  801e40:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e45:	89 eb                	mov    %ebp,%ebx
  801e47:	29 fb                	sub    %edi,%ebx
  801e49:	89 f9                	mov    %edi,%ecx
  801e4b:	d3 e6                	shl    %cl,%esi
  801e4d:	89 c5                	mov    %eax,%ebp
  801e4f:	88 d9                	mov    %bl,%cl
  801e51:	d3 ed                	shr    %cl,%ebp
  801e53:	89 e9                	mov    %ebp,%ecx
  801e55:	09 f1                	or     %esi,%ecx
  801e57:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e5b:	89 f9                	mov    %edi,%ecx
  801e5d:	d3 e0                	shl    %cl,%eax
  801e5f:	89 c5                	mov    %eax,%ebp
  801e61:	89 d6                	mov    %edx,%esi
  801e63:	88 d9                	mov    %bl,%cl
  801e65:	d3 ee                	shr    %cl,%esi
  801e67:	89 f9                	mov    %edi,%ecx
  801e69:	d3 e2                	shl    %cl,%edx
  801e6b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e6f:	88 d9                	mov    %bl,%cl
  801e71:	d3 e8                	shr    %cl,%eax
  801e73:	09 c2                	or     %eax,%edx
  801e75:	89 d0                	mov    %edx,%eax
  801e77:	89 f2                	mov    %esi,%edx
  801e79:	f7 74 24 0c          	divl   0xc(%esp)
  801e7d:	89 d6                	mov    %edx,%esi
  801e7f:	89 c3                	mov    %eax,%ebx
  801e81:	f7 e5                	mul    %ebp
  801e83:	39 d6                	cmp    %edx,%esi
  801e85:	72 19                	jb     801ea0 <__udivdi3+0xfc>
  801e87:	74 0b                	je     801e94 <__udivdi3+0xf0>
  801e89:	89 d8                	mov    %ebx,%eax
  801e8b:	31 ff                	xor    %edi,%edi
  801e8d:	e9 58 ff ff ff       	jmp    801dea <__udivdi3+0x46>
  801e92:	66 90                	xchg   %ax,%ax
  801e94:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e98:	89 f9                	mov    %edi,%ecx
  801e9a:	d3 e2                	shl    %cl,%edx
  801e9c:	39 c2                	cmp    %eax,%edx
  801e9e:	73 e9                	jae    801e89 <__udivdi3+0xe5>
  801ea0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ea3:	31 ff                	xor    %edi,%edi
  801ea5:	e9 40 ff ff ff       	jmp    801dea <__udivdi3+0x46>
  801eaa:	66 90                	xchg   %ax,%ax
  801eac:	31 c0                	xor    %eax,%eax
  801eae:	e9 37 ff ff ff       	jmp    801dea <__udivdi3+0x46>
  801eb3:	90                   	nop

00801eb4 <__umoddi3>:
  801eb4:	55                   	push   %ebp
  801eb5:	57                   	push   %edi
  801eb6:	56                   	push   %esi
  801eb7:	53                   	push   %ebx
  801eb8:	83 ec 1c             	sub    $0x1c,%esp
  801ebb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ebf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ec3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ec7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ecb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ecf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ed3:	89 f3                	mov    %esi,%ebx
  801ed5:	89 fa                	mov    %edi,%edx
  801ed7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801edb:	89 34 24             	mov    %esi,(%esp)
  801ede:	85 c0                	test   %eax,%eax
  801ee0:	75 1a                	jne    801efc <__umoddi3+0x48>
  801ee2:	39 f7                	cmp    %esi,%edi
  801ee4:	0f 86 a2 00 00 00    	jbe    801f8c <__umoddi3+0xd8>
  801eea:	89 c8                	mov    %ecx,%eax
  801eec:	89 f2                	mov    %esi,%edx
  801eee:	f7 f7                	div    %edi
  801ef0:	89 d0                	mov    %edx,%eax
  801ef2:	31 d2                	xor    %edx,%edx
  801ef4:	83 c4 1c             	add    $0x1c,%esp
  801ef7:	5b                   	pop    %ebx
  801ef8:	5e                   	pop    %esi
  801ef9:	5f                   	pop    %edi
  801efa:	5d                   	pop    %ebp
  801efb:	c3                   	ret    
  801efc:	39 f0                	cmp    %esi,%eax
  801efe:	0f 87 ac 00 00 00    	ja     801fb0 <__umoddi3+0xfc>
  801f04:	0f bd e8             	bsr    %eax,%ebp
  801f07:	83 f5 1f             	xor    $0x1f,%ebp
  801f0a:	0f 84 ac 00 00 00    	je     801fbc <__umoddi3+0x108>
  801f10:	bf 20 00 00 00       	mov    $0x20,%edi
  801f15:	29 ef                	sub    %ebp,%edi
  801f17:	89 fe                	mov    %edi,%esi
  801f19:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f1d:	89 e9                	mov    %ebp,%ecx
  801f1f:	d3 e0                	shl    %cl,%eax
  801f21:	89 d7                	mov    %edx,%edi
  801f23:	89 f1                	mov    %esi,%ecx
  801f25:	d3 ef                	shr    %cl,%edi
  801f27:	09 c7                	or     %eax,%edi
  801f29:	89 e9                	mov    %ebp,%ecx
  801f2b:	d3 e2                	shl    %cl,%edx
  801f2d:	89 14 24             	mov    %edx,(%esp)
  801f30:	89 d8                	mov    %ebx,%eax
  801f32:	d3 e0                	shl    %cl,%eax
  801f34:	89 c2                	mov    %eax,%edx
  801f36:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f3a:	d3 e0                	shl    %cl,%eax
  801f3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f40:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f44:	89 f1                	mov    %esi,%ecx
  801f46:	d3 e8                	shr    %cl,%eax
  801f48:	09 d0                	or     %edx,%eax
  801f4a:	d3 eb                	shr    %cl,%ebx
  801f4c:	89 da                	mov    %ebx,%edx
  801f4e:	f7 f7                	div    %edi
  801f50:	89 d3                	mov    %edx,%ebx
  801f52:	f7 24 24             	mull   (%esp)
  801f55:	89 c6                	mov    %eax,%esi
  801f57:	89 d1                	mov    %edx,%ecx
  801f59:	39 d3                	cmp    %edx,%ebx
  801f5b:	0f 82 87 00 00 00    	jb     801fe8 <__umoddi3+0x134>
  801f61:	0f 84 91 00 00 00    	je     801ff8 <__umoddi3+0x144>
  801f67:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f6b:	29 f2                	sub    %esi,%edx
  801f6d:	19 cb                	sbb    %ecx,%ebx
  801f6f:	89 d8                	mov    %ebx,%eax
  801f71:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f75:	d3 e0                	shl    %cl,%eax
  801f77:	89 e9                	mov    %ebp,%ecx
  801f79:	d3 ea                	shr    %cl,%edx
  801f7b:	09 d0                	or     %edx,%eax
  801f7d:	89 e9                	mov    %ebp,%ecx
  801f7f:	d3 eb                	shr    %cl,%ebx
  801f81:	89 da                	mov    %ebx,%edx
  801f83:	83 c4 1c             	add    $0x1c,%esp
  801f86:	5b                   	pop    %ebx
  801f87:	5e                   	pop    %esi
  801f88:	5f                   	pop    %edi
  801f89:	5d                   	pop    %ebp
  801f8a:	c3                   	ret    
  801f8b:	90                   	nop
  801f8c:	89 fd                	mov    %edi,%ebp
  801f8e:	85 ff                	test   %edi,%edi
  801f90:	75 0b                	jne    801f9d <__umoddi3+0xe9>
  801f92:	b8 01 00 00 00       	mov    $0x1,%eax
  801f97:	31 d2                	xor    %edx,%edx
  801f99:	f7 f7                	div    %edi
  801f9b:	89 c5                	mov    %eax,%ebp
  801f9d:	89 f0                	mov    %esi,%eax
  801f9f:	31 d2                	xor    %edx,%edx
  801fa1:	f7 f5                	div    %ebp
  801fa3:	89 c8                	mov    %ecx,%eax
  801fa5:	f7 f5                	div    %ebp
  801fa7:	89 d0                	mov    %edx,%eax
  801fa9:	e9 44 ff ff ff       	jmp    801ef2 <__umoddi3+0x3e>
  801fae:	66 90                	xchg   %ax,%ax
  801fb0:	89 c8                	mov    %ecx,%eax
  801fb2:	89 f2                	mov    %esi,%edx
  801fb4:	83 c4 1c             	add    $0x1c,%esp
  801fb7:	5b                   	pop    %ebx
  801fb8:	5e                   	pop    %esi
  801fb9:	5f                   	pop    %edi
  801fba:	5d                   	pop    %ebp
  801fbb:	c3                   	ret    
  801fbc:	3b 04 24             	cmp    (%esp),%eax
  801fbf:	72 06                	jb     801fc7 <__umoddi3+0x113>
  801fc1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fc5:	77 0f                	ja     801fd6 <__umoddi3+0x122>
  801fc7:	89 f2                	mov    %esi,%edx
  801fc9:	29 f9                	sub    %edi,%ecx
  801fcb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fcf:	89 14 24             	mov    %edx,(%esp)
  801fd2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fd6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fda:	8b 14 24             	mov    (%esp),%edx
  801fdd:	83 c4 1c             	add    $0x1c,%esp
  801fe0:	5b                   	pop    %ebx
  801fe1:	5e                   	pop    %esi
  801fe2:	5f                   	pop    %edi
  801fe3:	5d                   	pop    %ebp
  801fe4:	c3                   	ret    
  801fe5:	8d 76 00             	lea    0x0(%esi),%esi
  801fe8:	2b 04 24             	sub    (%esp),%eax
  801feb:	19 fa                	sbb    %edi,%edx
  801fed:	89 d1                	mov    %edx,%ecx
  801fef:	89 c6                	mov    %eax,%esi
  801ff1:	e9 71 ff ff ff       	jmp    801f67 <__umoddi3+0xb3>
  801ff6:	66 90                	xchg   %ax,%ax
  801ff8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ffc:	72 ea                	jb     801fe8 <__umoddi3+0x134>
  801ffe:	89 d9                	mov    %ebx,%ecx
  802000:	e9 62 ff ff ff       	jmp    801f67 <__umoddi3+0xb3>
