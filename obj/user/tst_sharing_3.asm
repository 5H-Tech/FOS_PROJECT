
obj/user/tst_sharing_3:     file format elf32-i386


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
  800031:	e8 43 02 00 00       	call   800279 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the SPECIAL CASES during the creation of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 48             	sub    $0x48,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003e:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800049:	eb 23                	jmp    80006e <_main+0x36>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800056:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800059:	c1 e2 04             	shl    $0x4,%edx
  80005c:	01 d0                	add    %edx,%eax
  80005e:	8a 40 04             	mov    0x4(%eax),%al
  800061:	84 c0                	test   %al,%al
  800063:	74 06                	je     80006b <_main+0x33>
			{
				fullWS = 0;
  800065:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800069:	eb 12                	jmp    80007d <_main+0x45>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006b:	ff 45 f0             	incl   -0x10(%ebp)
  80006e:	a1 20 30 80 00       	mov    0x803020,%eax
  800073:	8b 50 74             	mov    0x74(%eax),%edx
  800076:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800079:	39 c2                	cmp    %eax,%edx
  80007b:	77 ce                	ja     80004b <_main+0x13>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007d:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800081:	74 14                	je     800097 <_main+0x5f>
  800083:	83 ec 04             	sub    $0x4,%esp
  800086:	68 a0 1d 80 00       	push   $0x801da0
  80008b:	6a 12                	push   $0x12
  80008d:	68 bc 1d 80 00       	push   $0x801dbc
  800092:	e8 27 03 00 00       	call   8003be <_panic>
	}
	cprintf("************************************************\n");
  800097:	83 ec 0c             	sub    $0xc,%esp
  80009a:	68 d4 1d 80 00       	push   $0x801dd4
  80009f:	e8 bc 05 00 00       	call   800660 <cprintf>
  8000a4:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000a7:	83 ec 0c             	sub    $0xc,%esp
  8000aa:	68 08 1e 80 00       	push   $0x801e08
  8000af:	e8 ac 05 00 00       	call   800660 <cprintf>
  8000b4:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	68 64 1e 80 00       	push   $0x801e64
  8000bf:	e8 9c 05 00 00       	call   800660 <cprintf>
  8000c4:	83 c4 10             	add    $0x10,%esp

	uint32 *x, *y, *z ;
	cprintf("STEP A: checking creation of shared object that is already exists... \n\n");
  8000c7:	83 ec 0c             	sub    $0xc,%esp
  8000ca:	68 98 1e 80 00       	push   $0x801e98
  8000cf:	e8 8c 05 00 00       	call   800660 <cprintf>
  8000d4:	83 c4 10             	add    $0x10,%esp
	{
		int ret ;
		//int ret = sys_createSharedObject("x", PAGE_SIZE, 1, (void*)&x);
		x = smalloc("x", PAGE_SIZE, 1);
  8000d7:	83 ec 04             	sub    $0x4,%esp
  8000da:	6a 01                	push   $0x1
  8000dc:	68 00 10 00 00       	push   $0x1000
  8000e1:	68 e0 1e 80 00       	push   $0x801ee0
  8000e6:	e8 33 13 00 00       	call   80141e <smalloc>
  8000eb:	83 c4 10             	add    $0x10,%esp
  8000ee:	89 45 e8             	mov    %eax,-0x18(%ebp)
		int freeFrames = sys_calculate_free_frames() ;
  8000f1:	e8 50 15 00 00       	call   801646 <sys_calculate_free_frames>
  8000f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000f9:	83 ec 04             	sub    $0x4,%esp
  8000fc:	6a 01                	push   $0x1
  8000fe:	68 00 10 00 00       	push   $0x1000
  800103:	68 e0 1e 80 00       	push   $0x801ee0
  800108:	e8 11 13 00 00       	call   80141e <smalloc>
  80010d:	83 c4 10             	add    $0x10,%esp
  800110:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if (x != NULL) panic("Trying to create an already exists object and corresponding error is not returned!!");
  800113:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800117:	74 14                	je     80012d <_main+0xf5>
  800119:	83 ec 04             	sub    $0x4,%esp
  80011c:	68 e4 1e 80 00       	push   $0x801ee4
  800121:	6a 20                	push   $0x20
  800123:	68 bc 1d 80 00       	push   $0x801dbc
  800128:	e8 91 02 00 00       	call   8003be <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong allocation: make sure that you don't allocate any memory if the shared object exists");
  80012d:	e8 14 15 00 00       	call   801646 <sys_calculate_free_frames>
  800132:	89 c2                	mov    %eax,%edx
  800134:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800137:	39 c2                	cmp    %eax,%edx
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 38 1f 80 00       	push   $0x801f38
  800143:	6a 21                	push   $0x21
  800145:	68 bc 1d 80 00       	push   $0x801dbc
  80014a:	e8 6f 02 00 00       	call   8003be <_panic>
	}

	cprintf("STEP B: checking the creation of shared object that exceeds the SHARED area limit... \n\n");
  80014f:	83 ec 0c             	sub    $0xc,%esp
  800152:	68 94 1f 80 00       	push   $0x801f94
  800157:	e8 04 05 00 00       	call   800660 <cprintf>
  80015c:	83 c4 10             	add    $0x10,%esp
	{
		int freeFrames = sys_calculate_free_frames() ;
  80015f:	e8 e2 14 00 00       	call   801646 <sys_calculate_free_frames>
  800164:	89 45 e0             	mov    %eax,-0x20(%ebp)
		uint32 size = USER_HEAP_MAX - USER_HEAP_START ;
  800167:	c7 45 dc 00 00 00 20 	movl   $0x20000000,-0x24(%ebp)
		y = smalloc("y", size, 1);
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	6a 01                	push   $0x1
  800173:	ff 75 dc             	pushl  -0x24(%ebp)
  800176:	68 ec 1f 80 00       	push   $0x801fec
  80017b:	e8 9e 12 00 00       	call   80141e <smalloc>
  800180:	83 c4 10             	add    $0x10,%esp
  800183:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if (y != NULL) panic("Trying to create a shared object that exceed the SHARED area limit and the corresponding error is not returned!!");
  800186:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  80018a:	74 14                	je     8001a0 <_main+0x168>
  80018c:	83 ec 04             	sub    $0x4,%esp
  80018f:	68 f0 1f 80 00       	push   $0x801ff0
  800194:	6a 29                	push   $0x29
  800196:	68 bc 1d 80 00       	push   $0x801dbc
  80019b:	e8 1e 02 00 00       	call   8003be <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong allocation: make sure that you don't allocate any memory if the shared object exceed the SHARED area limit");
  8001a0:	e8 a1 14 00 00       	call   801646 <sys_calculate_free_frames>
  8001a5:	89 c2                	mov    %eax,%edx
  8001a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001aa:	39 c2                	cmp    %eax,%edx
  8001ac:	74 14                	je     8001c2 <_main+0x18a>
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	68 64 20 80 00       	push   $0x802064
  8001b6:	6a 2a                	push   $0x2a
  8001b8:	68 bc 1d 80 00       	push   $0x801dbc
  8001bd:	e8 fc 01 00 00       	call   8003be <_panic>
	}

	cprintf("STEP C: checking the creation of a number of shared objects that exceeds the MAX ALLOWED NUMBER of OBJECTS... \n\n");
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 d8 20 80 00       	push   $0x8020d8
  8001ca:	e8 91 04 00 00       	call   800660 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
	{
		uint32 maxShares = sys_getMaxShares();
  8001d2:	e8 ab 16 00 00       	call   801882 <sys_getMaxShares>
  8001d7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int i ;
		for (i = 0 ; i < maxShares - 1; i++)
  8001da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001e1:	eb 45                	jmp    800228 <_main+0x1f0>
		{
			char shareName[10] ;
			ltostr(i, shareName) ;
  8001e3:	83 ec 08             	sub    $0x8,%esp
  8001e6:	8d 45 c6             	lea    -0x3a(%ebp),%eax
  8001e9:	50                   	push   %eax
  8001ea:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ed:	e8 96 0f 00 00       	call   801188 <ltostr>
  8001f2:	83 c4 10             	add    $0x10,%esp
			z = smalloc(shareName, 1, 1);
  8001f5:	83 ec 04             	sub    $0x4,%esp
  8001f8:	6a 01                	push   $0x1
  8001fa:	6a 01                	push   $0x1
  8001fc:	8d 45 c6             	lea    -0x3a(%ebp),%eax
  8001ff:	50                   	push   %eax
  800200:	e8 19 12 00 00       	call   80141e <smalloc>
  800205:	83 c4 10             	add    $0x10,%esp
  800208:	89 45 d0             	mov    %eax,-0x30(%ebp)
			if (z == NULL) panic("WRONG... supposed no problem in creation here!!");
  80020b:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  80020f:	75 14                	jne    800225 <_main+0x1ed>
  800211:	83 ec 04             	sub    $0x4,%esp
  800214:	68 4c 21 80 00       	push   $0x80214c
  800219:	6a 36                	push   $0x36
  80021b:	68 bc 1d 80 00       	push   $0x801dbc
  800220:	e8 99 01 00 00       	call   8003be <_panic>

	cprintf("STEP C: checking the creation of a number of shared objects that exceeds the MAX ALLOWED NUMBER of OBJECTS... \n\n");
	{
		uint32 maxShares = sys_getMaxShares();
		int i ;
		for (i = 0 ; i < maxShares - 1; i++)
  800225:	ff 45 ec             	incl   -0x14(%ebp)
  800228:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80022b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80022e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800231:	39 c2                	cmp    %eax,%edx
  800233:	77 ae                	ja     8001e3 <_main+0x1ab>
			char shareName[10] ;
			ltostr(i, shareName) ;
			z = smalloc(shareName, 1, 1);
			if (z == NULL) panic("WRONG... supposed no problem in creation here!!");
		}
		z = smalloc("outOfBounds", 1, 1);
  800235:	83 ec 04             	sub    $0x4,%esp
  800238:	6a 01                	push   $0x1
  80023a:	6a 01                	push   $0x1
  80023c:	68 7c 21 80 00       	push   $0x80217c
  800241:	e8 d8 11 00 00       	call   80141e <smalloc>
  800246:	83 c4 10             	add    $0x10,%esp
  800249:	89 45 d0             	mov    %eax,-0x30(%ebp)
		if (z != NULL) panic("Trying to create a shared object that exceed the number of ALLOWED OBJECTS and the corresponding error is not returned!!");
  80024c:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  800250:	74 14                	je     800266 <_main+0x22e>
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	68 88 21 80 00       	push   $0x802188
  80025a:	6a 39                	push   $0x39
  80025c:	68 bc 1d 80 00       	push   $0x801dbc
  800261:	e8 58 01 00 00       	call   8003be <_panic>
	}
	cprintf("Congratulations!! Test of Shared Variables [Create: Special Cases] completed successfully!!\n\n\n");
  800266:	83 ec 0c             	sub    $0xc,%esp
  800269:	68 04 22 80 00       	push   $0x802204
  80026e:	e8 ed 03 00 00       	call   800660 <cprintf>
  800273:	83 c4 10             	add    $0x10,%esp

	return;
  800276:	90                   	nop
}
  800277:	c9                   	leave  
  800278:	c3                   	ret    

00800279 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800279:	55                   	push   %ebp
  80027a:	89 e5                	mov    %esp,%ebp
  80027c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80027f:	e8 f7 12 00 00       	call   80157b <sys_getenvindex>
  800284:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800287:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80028a:	89 d0                	mov    %edx,%eax
  80028c:	c1 e0 03             	shl    $0x3,%eax
  80028f:	01 d0                	add    %edx,%eax
  800291:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800298:	01 c8                	add    %ecx,%eax
  80029a:	01 c0                	add    %eax,%eax
  80029c:	01 d0                	add    %edx,%eax
  80029e:	01 c0                	add    %eax,%eax
  8002a0:	01 d0                	add    %edx,%eax
  8002a2:	89 c2                	mov    %eax,%edx
  8002a4:	c1 e2 05             	shl    $0x5,%edx
  8002a7:	29 c2                	sub    %eax,%edx
  8002a9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8002b0:	89 c2                	mov    %eax,%edx
  8002b2:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8002b8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c2:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8002c8:	84 c0                	test   %al,%al
  8002ca:	74 0f                	je     8002db <libmain+0x62>
		binaryname = myEnv->prog_name;
  8002cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d1:	05 40 3c 01 00       	add    $0x13c40,%eax
  8002d6:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002df:	7e 0a                	jle    8002eb <libmain+0x72>
		binaryname = argv[0];
  8002e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002e4:	8b 00                	mov    (%eax),%eax
  8002e6:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8002eb:	83 ec 08             	sub    $0x8,%esp
  8002ee:	ff 75 0c             	pushl  0xc(%ebp)
  8002f1:	ff 75 08             	pushl  0x8(%ebp)
  8002f4:	e8 3f fd ff ff       	call   800038 <_main>
  8002f9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8002fc:	e8 15 14 00 00       	call   801716 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800301:	83 ec 0c             	sub    $0xc,%esp
  800304:	68 7c 22 80 00       	push   $0x80227c
  800309:	e8 52 03 00 00       	call   800660 <cprintf>
  80030e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800311:	a1 20 30 80 00       	mov    0x803020,%eax
  800316:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80031c:	a1 20 30 80 00       	mov    0x803020,%eax
  800321:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800327:	83 ec 04             	sub    $0x4,%esp
  80032a:	52                   	push   %edx
  80032b:	50                   	push   %eax
  80032c:	68 a4 22 80 00       	push   $0x8022a4
  800331:	e8 2a 03 00 00       	call   800660 <cprintf>
  800336:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800339:	a1 20 30 80 00       	mov    0x803020,%eax
  80033e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800344:	a1 20 30 80 00       	mov    0x803020,%eax
  800349:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80034f:	83 ec 04             	sub    $0x4,%esp
  800352:	52                   	push   %edx
  800353:	50                   	push   %eax
  800354:	68 cc 22 80 00       	push   $0x8022cc
  800359:	e8 02 03 00 00       	call   800660 <cprintf>
  80035e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800361:	a1 20 30 80 00       	mov    0x803020,%eax
  800366:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80036c:	83 ec 08             	sub    $0x8,%esp
  80036f:	50                   	push   %eax
  800370:	68 0d 23 80 00       	push   $0x80230d
  800375:	e8 e6 02 00 00       	call   800660 <cprintf>
  80037a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80037d:	83 ec 0c             	sub    $0xc,%esp
  800380:	68 7c 22 80 00       	push   $0x80227c
  800385:	e8 d6 02 00 00       	call   800660 <cprintf>
  80038a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80038d:	e8 9e 13 00 00       	call   801730 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800392:	e8 19 00 00 00       	call   8003b0 <exit>
}
  800397:	90                   	nop
  800398:	c9                   	leave  
  800399:	c3                   	ret    

0080039a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80039a:	55                   	push   %ebp
  80039b:	89 e5                	mov    %esp,%ebp
  80039d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003a0:	83 ec 0c             	sub    $0xc,%esp
  8003a3:	6a 00                	push   $0x0
  8003a5:	e8 9d 11 00 00       	call   801547 <sys_env_destroy>
  8003aa:	83 c4 10             	add    $0x10,%esp
}
  8003ad:	90                   	nop
  8003ae:	c9                   	leave  
  8003af:	c3                   	ret    

008003b0 <exit>:

void
exit(void)
{
  8003b0:	55                   	push   %ebp
  8003b1:	89 e5                	mov    %esp,%ebp
  8003b3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003b6:	e8 f2 11 00 00       	call   8015ad <sys_env_exit>
}
  8003bb:	90                   	nop
  8003bc:	c9                   	leave  
  8003bd:	c3                   	ret    

008003be <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003be:	55                   	push   %ebp
  8003bf:	89 e5                	mov    %esp,%ebp
  8003c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003c4:	8d 45 10             	lea    0x10(%ebp),%eax
  8003c7:	83 c0 04             	add    $0x4,%eax
  8003ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003cd:	a1 18 31 80 00       	mov    0x803118,%eax
  8003d2:	85 c0                	test   %eax,%eax
  8003d4:	74 16                	je     8003ec <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003d6:	a1 18 31 80 00       	mov    0x803118,%eax
  8003db:	83 ec 08             	sub    $0x8,%esp
  8003de:	50                   	push   %eax
  8003df:	68 24 23 80 00       	push   $0x802324
  8003e4:	e8 77 02 00 00       	call   800660 <cprintf>
  8003e9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003ec:	a1 00 30 80 00       	mov    0x803000,%eax
  8003f1:	ff 75 0c             	pushl  0xc(%ebp)
  8003f4:	ff 75 08             	pushl  0x8(%ebp)
  8003f7:	50                   	push   %eax
  8003f8:	68 29 23 80 00       	push   $0x802329
  8003fd:	e8 5e 02 00 00       	call   800660 <cprintf>
  800402:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800405:	8b 45 10             	mov    0x10(%ebp),%eax
  800408:	83 ec 08             	sub    $0x8,%esp
  80040b:	ff 75 f4             	pushl  -0xc(%ebp)
  80040e:	50                   	push   %eax
  80040f:	e8 e1 01 00 00       	call   8005f5 <vcprintf>
  800414:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800417:	83 ec 08             	sub    $0x8,%esp
  80041a:	6a 00                	push   $0x0
  80041c:	68 45 23 80 00       	push   $0x802345
  800421:	e8 cf 01 00 00       	call   8005f5 <vcprintf>
  800426:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800429:	e8 82 ff ff ff       	call   8003b0 <exit>

	// should not return here
	while (1) ;
  80042e:	eb fe                	jmp    80042e <_panic+0x70>

00800430 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800430:	55                   	push   %ebp
  800431:	89 e5                	mov    %esp,%ebp
  800433:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800436:	a1 20 30 80 00       	mov    0x803020,%eax
  80043b:	8b 50 74             	mov    0x74(%eax),%edx
  80043e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800441:	39 c2                	cmp    %eax,%edx
  800443:	74 14                	je     800459 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800445:	83 ec 04             	sub    $0x4,%esp
  800448:	68 48 23 80 00       	push   $0x802348
  80044d:	6a 26                	push   $0x26
  80044f:	68 94 23 80 00       	push   $0x802394
  800454:	e8 65 ff ff ff       	call   8003be <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800459:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800460:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800467:	e9 b6 00 00 00       	jmp    800522 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80046c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800476:	8b 45 08             	mov    0x8(%ebp),%eax
  800479:	01 d0                	add    %edx,%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	85 c0                	test   %eax,%eax
  80047f:	75 08                	jne    800489 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800481:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800484:	e9 96 00 00 00       	jmp    80051f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800489:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800490:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800497:	eb 5d                	jmp    8004f6 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800499:	a1 20 30 80 00       	mov    0x803020,%eax
  80049e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004a4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004a7:	c1 e2 04             	shl    $0x4,%edx
  8004aa:	01 d0                	add    %edx,%eax
  8004ac:	8a 40 04             	mov    0x4(%eax),%al
  8004af:	84 c0                	test   %al,%al
  8004b1:	75 40                	jne    8004f3 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004c1:	c1 e2 04             	shl    $0x4,%edx
  8004c4:	01 d0                	add    %edx,%eax
  8004c6:	8b 00                	mov    (%eax),%eax
  8004c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	01 c8                	add    %ecx,%eax
  8004e4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004e6:	39 c2                	cmp    %eax,%edx
  8004e8:	75 09                	jne    8004f3 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8004ea:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8004f1:	eb 12                	jmp    800505 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004f3:	ff 45 e8             	incl   -0x18(%ebp)
  8004f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004fb:	8b 50 74             	mov    0x74(%eax),%edx
  8004fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800501:	39 c2                	cmp    %eax,%edx
  800503:	77 94                	ja     800499 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800505:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800509:	75 14                	jne    80051f <CheckWSWithoutLastIndex+0xef>
			panic(
  80050b:	83 ec 04             	sub    $0x4,%esp
  80050e:	68 a0 23 80 00       	push   $0x8023a0
  800513:	6a 3a                	push   $0x3a
  800515:	68 94 23 80 00       	push   $0x802394
  80051a:	e8 9f fe ff ff       	call   8003be <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80051f:	ff 45 f0             	incl   -0x10(%ebp)
  800522:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800525:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800528:	0f 8c 3e ff ff ff    	jl     80046c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80052e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800535:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80053c:	eb 20                	jmp    80055e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80053e:	a1 20 30 80 00       	mov    0x803020,%eax
  800543:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800549:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054c:	c1 e2 04             	shl    $0x4,%edx
  80054f:	01 d0                	add    %edx,%eax
  800551:	8a 40 04             	mov    0x4(%eax),%al
  800554:	3c 01                	cmp    $0x1,%al
  800556:	75 03                	jne    80055b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800558:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80055b:	ff 45 e0             	incl   -0x20(%ebp)
  80055e:	a1 20 30 80 00       	mov    0x803020,%eax
  800563:	8b 50 74             	mov    0x74(%eax),%edx
  800566:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800569:	39 c2                	cmp    %eax,%edx
  80056b:	77 d1                	ja     80053e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80056d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800570:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800573:	74 14                	je     800589 <CheckWSWithoutLastIndex+0x159>
		panic(
  800575:	83 ec 04             	sub    $0x4,%esp
  800578:	68 f4 23 80 00       	push   $0x8023f4
  80057d:	6a 44                	push   $0x44
  80057f:	68 94 23 80 00       	push   $0x802394
  800584:	e8 35 fe ff ff       	call   8003be <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800589:	90                   	nop
  80058a:	c9                   	leave  
  80058b:	c3                   	ret    

0080058c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80058c:	55                   	push   %ebp
  80058d:	89 e5                	mov    %esp,%ebp
  80058f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800592:	8b 45 0c             	mov    0xc(%ebp),%eax
  800595:	8b 00                	mov    (%eax),%eax
  800597:	8d 48 01             	lea    0x1(%eax),%ecx
  80059a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80059d:	89 0a                	mov    %ecx,(%edx)
  80059f:	8b 55 08             	mov    0x8(%ebp),%edx
  8005a2:	88 d1                	mov    %dl,%cl
  8005a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005a7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005b5:	75 2c                	jne    8005e3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005b7:	a0 24 30 80 00       	mov    0x803024,%al
  8005bc:	0f b6 c0             	movzbl %al,%eax
  8005bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c2:	8b 12                	mov    (%edx),%edx
  8005c4:	89 d1                	mov    %edx,%ecx
  8005c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c9:	83 c2 08             	add    $0x8,%edx
  8005cc:	83 ec 04             	sub    $0x4,%esp
  8005cf:	50                   	push   %eax
  8005d0:	51                   	push   %ecx
  8005d1:	52                   	push   %edx
  8005d2:	e8 2e 0f 00 00       	call   801505 <sys_cputs>
  8005d7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e6:	8b 40 04             	mov    0x4(%eax),%eax
  8005e9:	8d 50 01             	lea    0x1(%eax),%edx
  8005ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ef:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005f2:	90                   	nop
  8005f3:	c9                   	leave  
  8005f4:	c3                   	ret    

008005f5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005f5:	55                   	push   %ebp
  8005f6:	89 e5                	mov    %esp,%ebp
  8005f8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800605:	00 00 00 
	b.cnt = 0;
  800608:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80060f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800612:	ff 75 0c             	pushl  0xc(%ebp)
  800615:	ff 75 08             	pushl  0x8(%ebp)
  800618:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80061e:	50                   	push   %eax
  80061f:	68 8c 05 80 00       	push   $0x80058c
  800624:	e8 11 02 00 00       	call   80083a <vprintfmt>
  800629:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80062c:	a0 24 30 80 00       	mov    0x803024,%al
  800631:	0f b6 c0             	movzbl %al,%eax
  800634:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	50                   	push   %eax
  80063e:	52                   	push   %edx
  80063f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800645:	83 c0 08             	add    $0x8,%eax
  800648:	50                   	push   %eax
  800649:	e8 b7 0e 00 00       	call   801505 <sys_cputs>
  80064e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800651:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800658:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80065e:	c9                   	leave  
  80065f:	c3                   	ret    

00800660 <cprintf>:

int cprintf(const char *fmt, ...) {
  800660:	55                   	push   %ebp
  800661:	89 e5                	mov    %esp,%ebp
  800663:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800666:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80066d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800670:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800673:	8b 45 08             	mov    0x8(%ebp),%eax
  800676:	83 ec 08             	sub    $0x8,%esp
  800679:	ff 75 f4             	pushl  -0xc(%ebp)
  80067c:	50                   	push   %eax
  80067d:	e8 73 ff ff ff       	call   8005f5 <vcprintf>
  800682:	83 c4 10             	add    $0x10,%esp
  800685:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800688:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80068b:	c9                   	leave  
  80068c:	c3                   	ret    

0080068d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80068d:	55                   	push   %ebp
  80068e:	89 e5                	mov    %esp,%ebp
  800690:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800693:	e8 7e 10 00 00       	call   801716 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800698:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	83 ec 08             	sub    $0x8,%esp
  8006a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8006a7:	50                   	push   %eax
  8006a8:	e8 48 ff ff ff       	call   8005f5 <vcprintf>
  8006ad:	83 c4 10             	add    $0x10,%esp
  8006b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006b3:	e8 78 10 00 00       	call   801730 <sys_enable_interrupt>
	return cnt;
  8006b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006bb:	c9                   	leave  
  8006bc:	c3                   	ret    

008006bd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006bd:	55                   	push   %ebp
  8006be:	89 e5                	mov    %esp,%ebp
  8006c0:	53                   	push   %ebx
  8006c1:	83 ec 14             	sub    $0x14,%esp
  8006c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8006c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8006cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8006d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8006d8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006db:	77 55                	ja     800732 <printnum+0x75>
  8006dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006e0:	72 05                	jb     8006e7 <printnum+0x2a>
  8006e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006e5:	77 4b                	ja     800732 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006e7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006ea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8006f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8006f5:	52                   	push   %edx
  8006f6:	50                   	push   %eax
  8006f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8006fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8006fd:	e8 36 14 00 00       	call   801b38 <__udivdi3>
  800702:	83 c4 10             	add    $0x10,%esp
  800705:	83 ec 04             	sub    $0x4,%esp
  800708:	ff 75 20             	pushl  0x20(%ebp)
  80070b:	53                   	push   %ebx
  80070c:	ff 75 18             	pushl  0x18(%ebp)
  80070f:	52                   	push   %edx
  800710:	50                   	push   %eax
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	ff 75 08             	pushl  0x8(%ebp)
  800717:	e8 a1 ff ff ff       	call   8006bd <printnum>
  80071c:	83 c4 20             	add    $0x20,%esp
  80071f:	eb 1a                	jmp    80073b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800721:	83 ec 08             	sub    $0x8,%esp
  800724:	ff 75 0c             	pushl  0xc(%ebp)
  800727:	ff 75 20             	pushl  0x20(%ebp)
  80072a:	8b 45 08             	mov    0x8(%ebp),%eax
  80072d:	ff d0                	call   *%eax
  80072f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800732:	ff 4d 1c             	decl   0x1c(%ebp)
  800735:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800739:	7f e6                	jg     800721 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80073b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80073e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800743:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800746:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800749:	53                   	push   %ebx
  80074a:	51                   	push   %ecx
  80074b:	52                   	push   %edx
  80074c:	50                   	push   %eax
  80074d:	e8 f6 14 00 00       	call   801c48 <__umoddi3>
  800752:	83 c4 10             	add    $0x10,%esp
  800755:	05 54 26 80 00       	add    $0x802654,%eax
  80075a:	8a 00                	mov    (%eax),%al
  80075c:	0f be c0             	movsbl %al,%eax
  80075f:	83 ec 08             	sub    $0x8,%esp
  800762:	ff 75 0c             	pushl  0xc(%ebp)
  800765:	50                   	push   %eax
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	ff d0                	call   *%eax
  80076b:	83 c4 10             	add    $0x10,%esp
}
  80076e:	90                   	nop
  80076f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800772:	c9                   	leave  
  800773:	c3                   	ret    

00800774 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800774:	55                   	push   %ebp
  800775:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800777:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80077b:	7e 1c                	jle    800799 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	8b 00                	mov    (%eax),%eax
  800782:	8d 50 08             	lea    0x8(%eax),%edx
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	89 10                	mov    %edx,(%eax)
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	8b 00                	mov    (%eax),%eax
  80078f:	83 e8 08             	sub    $0x8,%eax
  800792:	8b 50 04             	mov    0x4(%eax),%edx
  800795:	8b 00                	mov    (%eax),%eax
  800797:	eb 40                	jmp    8007d9 <getuint+0x65>
	else if (lflag)
  800799:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80079d:	74 1e                	je     8007bd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	8d 50 04             	lea    0x4(%eax),%edx
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	89 10                	mov    %edx,(%eax)
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	83 e8 04             	sub    $0x4,%eax
  8007b4:	8b 00                	mov    (%eax),%eax
  8007b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8007bb:	eb 1c                	jmp    8007d9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	8b 00                	mov    (%eax),%eax
  8007c2:	8d 50 04             	lea    0x4(%eax),%edx
  8007c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c8:	89 10                	mov    %edx,(%eax)
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	8b 00                	mov    (%eax),%eax
  8007cf:	83 e8 04             	sub    $0x4,%eax
  8007d2:	8b 00                	mov    (%eax),%eax
  8007d4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007d9:	5d                   	pop    %ebp
  8007da:	c3                   	ret    

008007db <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007db:	55                   	push   %ebp
  8007dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007e2:	7e 1c                	jle    800800 <getint+0x25>
		return va_arg(*ap, long long);
  8007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e7:	8b 00                	mov    (%eax),%eax
  8007e9:	8d 50 08             	lea    0x8(%eax),%edx
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	89 10                	mov    %edx,(%eax)
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	8b 00                	mov    (%eax),%eax
  8007f6:	83 e8 08             	sub    $0x8,%eax
  8007f9:	8b 50 04             	mov    0x4(%eax),%edx
  8007fc:	8b 00                	mov    (%eax),%eax
  8007fe:	eb 38                	jmp    800838 <getint+0x5d>
	else if (lflag)
  800800:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800804:	74 1a                	je     800820 <getint+0x45>
		return va_arg(*ap, long);
  800806:	8b 45 08             	mov    0x8(%ebp),%eax
  800809:	8b 00                	mov    (%eax),%eax
  80080b:	8d 50 04             	lea    0x4(%eax),%edx
  80080e:	8b 45 08             	mov    0x8(%ebp),%eax
  800811:	89 10                	mov    %edx,(%eax)
  800813:	8b 45 08             	mov    0x8(%ebp),%eax
  800816:	8b 00                	mov    (%eax),%eax
  800818:	83 e8 04             	sub    $0x4,%eax
  80081b:	8b 00                	mov    (%eax),%eax
  80081d:	99                   	cltd   
  80081e:	eb 18                	jmp    800838 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	8d 50 04             	lea    0x4(%eax),%edx
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	89 10                	mov    %edx,(%eax)
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	83 e8 04             	sub    $0x4,%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	99                   	cltd   
}
  800838:	5d                   	pop    %ebp
  800839:	c3                   	ret    

0080083a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80083a:	55                   	push   %ebp
  80083b:	89 e5                	mov    %esp,%ebp
  80083d:	56                   	push   %esi
  80083e:	53                   	push   %ebx
  80083f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800842:	eb 17                	jmp    80085b <vprintfmt+0x21>
			if (ch == '\0')
  800844:	85 db                	test   %ebx,%ebx
  800846:	0f 84 af 03 00 00    	je     800bfb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80084c:	83 ec 08             	sub    $0x8,%esp
  80084f:	ff 75 0c             	pushl  0xc(%ebp)
  800852:	53                   	push   %ebx
  800853:	8b 45 08             	mov    0x8(%ebp),%eax
  800856:	ff d0                	call   *%eax
  800858:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80085b:	8b 45 10             	mov    0x10(%ebp),%eax
  80085e:	8d 50 01             	lea    0x1(%eax),%edx
  800861:	89 55 10             	mov    %edx,0x10(%ebp)
  800864:	8a 00                	mov    (%eax),%al
  800866:	0f b6 d8             	movzbl %al,%ebx
  800869:	83 fb 25             	cmp    $0x25,%ebx
  80086c:	75 d6                	jne    800844 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80086e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800872:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800879:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800880:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800887:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80088e:	8b 45 10             	mov    0x10(%ebp),%eax
  800891:	8d 50 01             	lea    0x1(%eax),%edx
  800894:	89 55 10             	mov    %edx,0x10(%ebp)
  800897:	8a 00                	mov    (%eax),%al
  800899:	0f b6 d8             	movzbl %al,%ebx
  80089c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80089f:	83 f8 55             	cmp    $0x55,%eax
  8008a2:	0f 87 2b 03 00 00    	ja     800bd3 <vprintfmt+0x399>
  8008a8:	8b 04 85 78 26 80 00 	mov    0x802678(,%eax,4),%eax
  8008af:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008b1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008b5:	eb d7                	jmp    80088e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008b7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008bb:	eb d1                	jmp    80088e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008bd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008c7:	89 d0                	mov    %edx,%eax
  8008c9:	c1 e0 02             	shl    $0x2,%eax
  8008cc:	01 d0                	add    %edx,%eax
  8008ce:	01 c0                	add    %eax,%eax
  8008d0:	01 d8                	add    %ebx,%eax
  8008d2:	83 e8 30             	sub    $0x30,%eax
  8008d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008db:	8a 00                	mov    (%eax),%al
  8008dd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008e0:	83 fb 2f             	cmp    $0x2f,%ebx
  8008e3:	7e 3e                	jle    800923 <vprintfmt+0xe9>
  8008e5:	83 fb 39             	cmp    $0x39,%ebx
  8008e8:	7f 39                	jg     800923 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008ea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008ed:	eb d5                	jmp    8008c4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f2:	83 c0 04             	add    $0x4,%eax
  8008f5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fb:	83 e8 04             	sub    $0x4,%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800903:	eb 1f                	jmp    800924 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800905:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800909:	79 83                	jns    80088e <vprintfmt+0x54>
				width = 0;
  80090b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800912:	e9 77 ff ff ff       	jmp    80088e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800917:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80091e:	e9 6b ff ff ff       	jmp    80088e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800923:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800924:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800928:	0f 89 60 ff ff ff    	jns    80088e <vprintfmt+0x54>
				width = precision, precision = -1;
  80092e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800931:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800934:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80093b:	e9 4e ff ff ff       	jmp    80088e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800940:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800943:	e9 46 ff ff ff       	jmp    80088e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800948:	8b 45 14             	mov    0x14(%ebp),%eax
  80094b:	83 c0 04             	add    $0x4,%eax
  80094e:	89 45 14             	mov    %eax,0x14(%ebp)
  800951:	8b 45 14             	mov    0x14(%ebp),%eax
  800954:	83 e8 04             	sub    $0x4,%eax
  800957:	8b 00                	mov    (%eax),%eax
  800959:	83 ec 08             	sub    $0x8,%esp
  80095c:	ff 75 0c             	pushl  0xc(%ebp)
  80095f:	50                   	push   %eax
  800960:	8b 45 08             	mov    0x8(%ebp),%eax
  800963:	ff d0                	call   *%eax
  800965:	83 c4 10             	add    $0x10,%esp
			break;
  800968:	e9 89 02 00 00       	jmp    800bf6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80096d:	8b 45 14             	mov    0x14(%ebp),%eax
  800970:	83 c0 04             	add    $0x4,%eax
  800973:	89 45 14             	mov    %eax,0x14(%ebp)
  800976:	8b 45 14             	mov    0x14(%ebp),%eax
  800979:	83 e8 04             	sub    $0x4,%eax
  80097c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80097e:	85 db                	test   %ebx,%ebx
  800980:	79 02                	jns    800984 <vprintfmt+0x14a>
				err = -err;
  800982:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800984:	83 fb 64             	cmp    $0x64,%ebx
  800987:	7f 0b                	jg     800994 <vprintfmt+0x15a>
  800989:	8b 34 9d c0 24 80 00 	mov    0x8024c0(,%ebx,4),%esi
  800990:	85 f6                	test   %esi,%esi
  800992:	75 19                	jne    8009ad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800994:	53                   	push   %ebx
  800995:	68 65 26 80 00       	push   $0x802665
  80099a:	ff 75 0c             	pushl  0xc(%ebp)
  80099d:	ff 75 08             	pushl  0x8(%ebp)
  8009a0:	e8 5e 02 00 00       	call   800c03 <printfmt>
  8009a5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009a8:	e9 49 02 00 00       	jmp    800bf6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009ad:	56                   	push   %esi
  8009ae:	68 6e 26 80 00       	push   $0x80266e
  8009b3:	ff 75 0c             	pushl  0xc(%ebp)
  8009b6:	ff 75 08             	pushl  0x8(%ebp)
  8009b9:	e8 45 02 00 00       	call   800c03 <printfmt>
  8009be:	83 c4 10             	add    $0x10,%esp
			break;
  8009c1:	e9 30 02 00 00       	jmp    800bf6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c9:	83 c0 04             	add    $0x4,%eax
  8009cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8009cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d2:	83 e8 04             	sub    $0x4,%eax
  8009d5:	8b 30                	mov    (%eax),%esi
  8009d7:	85 f6                	test   %esi,%esi
  8009d9:	75 05                	jne    8009e0 <vprintfmt+0x1a6>
				p = "(null)";
  8009db:	be 71 26 80 00       	mov    $0x802671,%esi
			if (width > 0 && padc != '-')
  8009e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e4:	7e 6d                	jle    800a53 <vprintfmt+0x219>
  8009e6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009ea:	74 67                	je     800a53 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	50                   	push   %eax
  8009f3:	56                   	push   %esi
  8009f4:	e8 0c 03 00 00       	call   800d05 <strnlen>
  8009f9:	83 c4 10             	add    $0x10,%esp
  8009fc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009ff:	eb 16                	jmp    800a17 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a01:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a05:	83 ec 08             	sub    $0x8,%esp
  800a08:	ff 75 0c             	pushl  0xc(%ebp)
  800a0b:	50                   	push   %eax
  800a0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0f:	ff d0                	call   *%eax
  800a11:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a14:	ff 4d e4             	decl   -0x1c(%ebp)
  800a17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a1b:	7f e4                	jg     800a01 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a1d:	eb 34                	jmp    800a53 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a1f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a23:	74 1c                	je     800a41 <vprintfmt+0x207>
  800a25:	83 fb 1f             	cmp    $0x1f,%ebx
  800a28:	7e 05                	jle    800a2f <vprintfmt+0x1f5>
  800a2a:	83 fb 7e             	cmp    $0x7e,%ebx
  800a2d:	7e 12                	jle    800a41 <vprintfmt+0x207>
					putch('?', putdat);
  800a2f:	83 ec 08             	sub    $0x8,%esp
  800a32:	ff 75 0c             	pushl  0xc(%ebp)
  800a35:	6a 3f                	push   $0x3f
  800a37:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3a:	ff d0                	call   *%eax
  800a3c:	83 c4 10             	add    $0x10,%esp
  800a3f:	eb 0f                	jmp    800a50 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a41:	83 ec 08             	sub    $0x8,%esp
  800a44:	ff 75 0c             	pushl  0xc(%ebp)
  800a47:	53                   	push   %ebx
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	ff d0                	call   *%eax
  800a4d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a50:	ff 4d e4             	decl   -0x1c(%ebp)
  800a53:	89 f0                	mov    %esi,%eax
  800a55:	8d 70 01             	lea    0x1(%eax),%esi
  800a58:	8a 00                	mov    (%eax),%al
  800a5a:	0f be d8             	movsbl %al,%ebx
  800a5d:	85 db                	test   %ebx,%ebx
  800a5f:	74 24                	je     800a85 <vprintfmt+0x24b>
  800a61:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a65:	78 b8                	js     800a1f <vprintfmt+0x1e5>
  800a67:	ff 4d e0             	decl   -0x20(%ebp)
  800a6a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a6e:	79 af                	jns    800a1f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a70:	eb 13                	jmp    800a85 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a72:	83 ec 08             	sub    $0x8,%esp
  800a75:	ff 75 0c             	pushl  0xc(%ebp)
  800a78:	6a 20                	push   $0x20
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	ff d0                	call   *%eax
  800a7f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a82:	ff 4d e4             	decl   -0x1c(%ebp)
  800a85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a89:	7f e7                	jg     800a72 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a8b:	e9 66 01 00 00       	jmp    800bf6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a90:	83 ec 08             	sub    $0x8,%esp
  800a93:	ff 75 e8             	pushl  -0x18(%ebp)
  800a96:	8d 45 14             	lea    0x14(%ebp),%eax
  800a99:	50                   	push   %eax
  800a9a:	e8 3c fd ff ff       	call   8007db <getint>
  800a9f:	83 c4 10             	add    $0x10,%esp
  800aa2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800aa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aae:	85 d2                	test   %edx,%edx
  800ab0:	79 23                	jns    800ad5 <vprintfmt+0x29b>
				putch('-', putdat);
  800ab2:	83 ec 08             	sub    $0x8,%esp
  800ab5:	ff 75 0c             	pushl  0xc(%ebp)
  800ab8:	6a 2d                	push   $0x2d
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	ff d0                	call   *%eax
  800abf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ac8:	f7 d8                	neg    %eax
  800aca:	83 d2 00             	adc    $0x0,%edx
  800acd:	f7 da                	neg    %edx
  800acf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ad5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800adc:	e9 bc 00 00 00       	jmp    800b9d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ae1:	83 ec 08             	sub    $0x8,%esp
  800ae4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ae7:	8d 45 14             	lea    0x14(%ebp),%eax
  800aea:	50                   	push   %eax
  800aeb:	e8 84 fc ff ff       	call   800774 <getuint>
  800af0:	83 c4 10             	add    $0x10,%esp
  800af3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800af9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b00:	e9 98 00 00 00       	jmp    800b9d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	6a 58                	push   $0x58
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	ff d0                	call   *%eax
  800b12:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	6a 58                	push   $0x58
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	ff d0                	call   *%eax
  800b22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b25:	83 ec 08             	sub    $0x8,%esp
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	6a 58                	push   $0x58
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	ff d0                	call   *%eax
  800b32:	83 c4 10             	add    $0x10,%esp
			break;
  800b35:	e9 bc 00 00 00       	jmp    800bf6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b3a:	83 ec 08             	sub    $0x8,%esp
  800b3d:	ff 75 0c             	pushl  0xc(%ebp)
  800b40:	6a 30                	push   $0x30
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	ff d0                	call   *%eax
  800b47:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	6a 78                	push   $0x78
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	ff d0                	call   *%eax
  800b57:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b5d:	83 c0 04             	add    $0x4,%eax
  800b60:	89 45 14             	mov    %eax,0x14(%ebp)
  800b63:	8b 45 14             	mov    0x14(%ebp),%eax
  800b66:	83 e8 04             	sub    $0x4,%eax
  800b69:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b7c:	eb 1f                	jmp    800b9d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b7e:	83 ec 08             	sub    $0x8,%esp
  800b81:	ff 75 e8             	pushl  -0x18(%ebp)
  800b84:	8d 45 14             	lea    0x14(%ebp),%eax
  800b87:	50                   	push   %eax
  800b88:	e8 e7 fb ff ff       	call   800774 <getuint>
  800b8d:	83 c4 10             	add    $0x10,%esp
  800b90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b93:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b96:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b9d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ba1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ba4:	83 ec 04             	sub    $0x4,%esp
  800ba7:	52                   	push   %edx
  800ba8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bab:	50                   	push   %eax
  800bac:	ff 75 f4             	pushl  -0xc(%ebp)
  800baf:	ff 75 f0             	pushl  -0x10(%ebp)
  800bb2:	ff 75 0c             	pushl  0xc(%ebp)
  800bb5:	ff 75 08             	pushl  0x8(%ebp)
  800bb8:	e8 00 fb ff ff       	call   8006bd <printnum>
  800bbd:	83 c4 20             	add    $0x20,%esp
			break;
  800bc0:	eb 34                	jmp    800bf6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bc2:	83 ec 08             	sub    $0x8,%esp
  800bc5:	ff 75 0c             	pushl  0xc(%ebp)
  800bc8:	53                   	push   %ebx
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	ff d0                	call   *%eax
  800bce:	83 c4 10             	add    $0x10,%esp
			break;
  800bd1:	eb 23                	jmp    800bf6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bd3:	83 ec 08             	sub    $0x8,%esp
  800bd6:	ff 75 0c             	pushl  0xc(%ebp)
  800bd9:	6a 25                	push   $0x25
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	ff d0                	call   *%eax
  800be0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800be3:	ff 4d 10             	decl   0x10(%ebp)
  800be6:	eb 03                	jmp    800beb <vprintfmt+0x3b1>
  800be8:	ff 4d 10             	decl   0x10(%ebp)
  800beb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bee:	48                   	dec    %eax
  800bef:	8a 00                	mov    (%eax),%al
  800bf1:	3c 25                	cmp    $0x25,%al
  800bf3:	75 f3                	jne    800be8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800bf5:	90                   	nop
		}
	}
  800bf6:	e9 47 fc ff ff       	jmp    800842 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bfb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bfc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bff:	5b                   	pop    %ebx
  800c00:	5e                   	pop    %esi
  800c01:	5d                   	pop    %ebp
  800c02:	c3                   	ret    

00800c03 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c03:	55                   	push   %ebp
  800c04:	89 e5                	mov    %esp,%ebp
  800c06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c09:	8d 45 10             	lea    0x10(%ebp),%eax
  800c0c:	83 c0 04             	add    $0x4,%eax
  800c0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c12:	8b 45 10             	mov    0x10(%ebp),%eax
  800c15:	ff 75 f4             	pushl  -0xc(%ebp)
  800c18:	50                   	push   %eax
  800c19:	ff 75 0c             	pushl  0xc(%ebp)
  800c1c:	ff 75 08             	pushl  0x8(%ebp)
  800c1f:	e8 16 fc ff ff       	call   80083a <vprintfmt>
  800c24:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c27:	90                   	nop
  800c28:	c9                   	leave  
  800c29:	c3                   	ret    

00800c2a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c2a:	55                   	push   %ebp
  800c2b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c30:	8b 40 08             	mov    0x8(%eax),%eax
  800c33:	8d 50 01             	lea    0x1(%eax),%edx
  800c36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c39:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3f:	8b 10                	mov    (%eax),%edx
  800c41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c44:	8b 40 04             	mov    0x4(%eax),%eax
  800c47:	39 c2                	cmp    %eax,%edx
  800c49:	73 12                	jae    800c5d <sprintputch+0x33>
		*b->buf++ = ch;
  800c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4e:	8b 00                	mov    (%eax),%eax
  800c50:	8d 48 01             	lea    0x1(%eax),%ecx
  800c53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c56:	89 0a                	mov    %ecx,(%edx)
  800c58:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5b:	88 10                	mov    %dl,(%eax)
}
  800c5d:	90                   	nop
  800c5e:	5d                   	pop    %ebp
  800c5f:	c3                   	ret    

00800c60 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c60:	55                   	push   %ebp
  800c61:	89 e5                	mov    %esp,%ebp
  800c63:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	01 d0                	add    %edx,%eax
  800c77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c81:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c85:	74 06                	je     800c8d <vsnprintf+0x2d>
  800c87:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c8b:	7f 07                	jg     800c94 <vsnprintf+0x34>
		return -E_INVAL;
  800c8d:	b8 03 00 00 00       	mov    $0x3,%eax
  800c92:	eb 20                	jmp    800cb4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c94:	ff 75 14             	pushl  0x14(%ebp)
  800c97:	ff 75 10             	pushl  0x10(%ebp)
  800c9a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c9d:	50                   	push   %eax
  800c9e:	68 2a 0c 80 00       	push   $0x800c2a
  800ca3:	e8 92 fb ff ff       	call   80083a <vprintfmt>
  800ca8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cb4:	c9                   	leave  
  800cb5:	c3                   	ret    

00800cb6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cb6:	55                   	push   %ebp
  800cb7:	89 e5                	mov    %esp,%ebp
  800cb9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cbc:	8d 45 10             	lea    0x10(%ebp),%eax
  800cbf:	83 c0 04             	add    $0x4,%eax
  800cc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ccb:	50                   	push   %eax
  800ccc:	ff 75 0c             	pushl  0xc(%ebp)
  800ccf:	ff 75 08             	pushl  0x8(%ebp)
  800cd2:	e8 89 ff ff ff       	call   800c60 <vsnprintf>
  800cd7:	83 c4 10             	add    $0x10,%esp
  800cda:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ce0:	c9                   	leave  
  800ce1:	c3                   	ret    

00800ce2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ce2:	55                   	push   %ebp
  800ce3:	89 e5                	mov    %esp,%ebp
  800ce5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ce8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cef:	eb 06                	jmp    800cf7 <strlen+0x15>
		n++;
  800cf1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cf4:	ff 45 08             	incl   0x8(%ebp)
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	84 c0                	test   %al,%al
  800cfe:	75 f1                	jne    800cf1 <strlen+0xf>
		n++;
	return n;
  800d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d03:	c9                   	leave  
  800d04:	c3                   	ret    

00800d05 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d12:	eb 09                	jmp    800d1d <strnlen+0x18>
		n++;
  800d14:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d17:	ff 45 08             	incl   0x8(%ebp)
  800d1a:	ff 4d 0c             	decl   0xc(%ebp)
  800d1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d21:	74 09                	je     800d2c <strnlen+0x27>
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 e8                	jne    800d14 <strnlen+0xf>
		n++;
	return n;
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d3d:	90                   	nop
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8d 50 01             	lea    0x1(%eax),%edx
  800d44:	89 55 08             	mov    %edx,0x8(%ebp)
  800d47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d4d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d50:	8a 12                	mov    (%edx),%dl
  800d52:	88 10                	mov    %dl,(%eax)
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	84 c0                	test   %al,%al
  800d58:	75 e4                	jne    800d3e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5d:	c9                   	leave  
  800d5e:	c3                   	ret    

00800d5f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d72:	eb 1f                	jmp    800d93 <strncpy+0x34>
		*dst++ = *src;
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	8d 50 01             	lea    0x1(%eax),%edx
  800d7a:	89 55 08             	mov    %edx,0x8(%ebp)
  800d7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d80:	8a 12                	mov    (%edx),%dl
  800d82:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d87:	8a 00                	mov    (%eax),%al
  800d89:	84 c0                	test   %al,%al
  800d8b:	74 03                	je     800d90 <strncpy+0x31>
			src++;
  800d8d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d90:	ff 45 fc             	incl   -0x4(%ebp)
  800d93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d96:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d99:	72 d9                	jb     800d74 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d9e:	c9                   	leave  
  800d9f:	c3                   	ret    

00800da0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800da0:	55                   	push   %ebp
  800da1:	89 e5                	mov    %esp,%ebp
  800da3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
  800da9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db0:	74 30                	je     800de2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800db2:	eb 16                	jmp    800dca <strlcpy+0x2a>
			*dst++ = *src++;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8d 50 01             	lea    0x1(%eax),%edx
  800dba:	89 55 08             	mov    %edx,0x8(%ebp)
  800dbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dc6:	8a 12                	mov    (%edx),%dl
  800dc8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dca:	ff 4d 10             	decl   0x10(%ebp)
  800dcd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd1:	74 09                	je     800ddc <strlcpy+0x3c>
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	84 c0                	test   %al,%al
  800dda:	75 d8                	jne    800db4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800de2:	8b 55 08             	mov    0x8(%ebp),%edx
  800de5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de8:	29 c2                	sub    %eax,%edx
  800dea:	89 d0                	mov    %edx,%eax
}
  800dec:	c9                   	leave  
  800ded:	c3                   	ret    

00800dee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dee:	55                   	push   %ebp
  800def:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800df1:	eb 06                	jmp    800df9 <strcmp+0xb>
		p++, q++;
  800df3:	ff 45 08             	incl   0x8(%ebp)
  800df6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	84 c0                	test   %al,%al
  800e00:	74 0e                	je     800e10 <strcmp+0x22>
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	8a 10                	mov    (%eax),%dl
  800e07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0a:	8a 00                	mov    (%eax),%al
  800e0c:	38 c2                	cmp    %al,%dl
  800e0e:	74 e3                	je     800df3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	8a 00                	mov    (%eax),%al
  800e15:	0f b6 d0             	movzbl %al,%edx
  800e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	0f b6 c0             	movzbl %al,%eax
  800e20:	29 c2                	sub    %eax,%edx
  800e22:	89 d0                	mov    %edx,%eax
}
  800e24:	5d                   	pop    %ebp
  800e25:	c3                   	ret    

00800e26 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e26:	55                   	push   %ebp
  800e27:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e29:	eb 09                	jmp    800e34 <strncmp+0xe>
		n--, p++, q++;
  800e2b:	ff 4d 10             	decl   0x10(%ebp)
  800e2e:	ff 45 08             	incl   0x8(%ebp)
  800e31:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e38:	74 17                	je     800e51 <strncmp+0x2b>
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	84 c0                	test   %al,%al
  800e41:	74 0e                	je     800e51 <strncmp+0x2b>
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8a 10                	mov    (%eax),%dl
  800e48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	38 c2                	cmp    %al,%dl
  800e4f:	74 da                	je     800e2b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e55:	75 07                	jne    800e5e <strncmp+0x38>
		return 0;
  800e57:	b8 00 00 00 00       	mov    $0x0,%eax
  800e5c:	eb 14                	jmp    800e72 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8a 00                	mov    (%eax),%al
  800e63:	0f b6 d0             	movzbl %al,%edx
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	8a 00                	mov    (%eax),%al
  800e6b:	0f b6 c0             	movzbl %al,%eax
  800e6e:	29 c2                	sub    %eax,%edx
  800e70:	89 d0                	mov    %edx,%eax
}
  800e72:	5d                   	pop    %ebp
  800e73:	c3                   	ret    

00800e74 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e74:	55                   	push   %ebp
  800e75:	89 e5                	mov    %esp,%ebp
  800e77:	83 ec 04             	sub    $0x4,%esp
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e80:	eb 12                	jmp    800e94 <strchr+0x20>
		if (*s == c)
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e8a:	75 05                	jne    800e91 <strchr+0x1d>
			return (char *) s;
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	eb 11                	jmp    800ea2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e91:	ff 45 08             	incl   0x8(%ebp)
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	8a 00                	mov    (%eax),%al
  800e99:	84 c0                	test   %al,%al
  800e9b:	75 e5                	jne    800e82 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea2:	c9                   	leave  
  800ea3:	c3                   	ret    

00800ea4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ea4:	55                   	push   %ebp
  800ea5:	89 e5                	mov    %esp,%ebp
  800ea7:	83 ec 04             	sub    $0x4,%esp
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eb0:	eb 0d                	jmp    800ebf <strfind+0x1b>
		if (*s == c)
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8a 00                	mov    (%eax),%al
  800eb7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eba:	74 0e                	je     800eca <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ebc:	ff 45 08             	incl   0x8(%ebp)
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	8a 00                	mov    (%eax),%al
  800ec4:	84 c0                	test   %al,%al
  800ec6:	75 ea                	jne    800eb2 <strfind+0xe>
  800ec8:	eb 01                	jmp    800ecb <strfind+0x27>
		if (*s == c)
			break;
  800eca:	90                   	nop
	return (char *) s;
  800ecb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ece:	c9                   	leave  
  800ecf:	c3                   	ret    

00800ed0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ed0:	55                   	push   %ebp
  800ed1:	89 e5                	mov    %esp,%ebp
  800ed3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800edc:	8b 45 10             	mov    0x10(%ebp),%eax
  800edf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ee2:	eb 0e                	jmp    800ef2 <memset+0x22>
		*p++ = c;
  800ee4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee7:	8d 50 01             	lea    0x1(%eax),%edx
  800eea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eed:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ef0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ef2:	ff 4d f8             	decl   -0x8(%ebp)
  800ef5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ef9:	79 e9                	jns    800ee4 <memset+0x14>
		*p++ = c;

	return v;
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efe:	c9                   	leave  
  800eff:	c3                   	ret    

00800f00 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f00:	55                   	push   %ebp
  800f01:	89 e5                	mov    %esp,%ebp
  800f03:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f12:	eb 16                	jmp    800f2a <memcpy+0x2a>
		*d++ = *s++;
  800f14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f17:	8d 50 01             	lea    0x1(%eax),%edx
  800f1a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f20:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f23:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f26:	8a 12                	mov    (%edx),%dl
  800f28:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f30:	89 55 10             	mov    %edx,0x10(%ebp)
  800f33:	85 c0                	test   %eax,%eax
  800f35:	75 dd                	jne    800f14 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f3a:	c9                   	leave  
  800f3b:	c3                   	ret    

00800f3c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f3c:	55                   	push   %ebp
  800f3d:	89 e5                	mov    %esp,%ebp
  800f3f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f51:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f54:	73 50                	jae    800fa6 <memmove+0x6a>
  800f56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f59:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5c:	01 d0                	add    %edx,%eax
  800f5e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f61:	76 43                	jbe    800fa6 <memmove+0x6a>
		s += n;
  800f63:	8b 45 10             	mov    0x10(%ebp),%eax
  800f66:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f69:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f6f:	eb 10                	jmp    800f81 <memmove+0x45>
			*--d = *--s;
  800f71:	ff 4d f8             	decl   -0x8(%ebp)
  800f74:	ff 4d fc             	decl   -0x4(%ebp)
  800f77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7a:	8a 10                	mov    (%eax),%dl
  800f7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f81:	8b 45 10             	mov    0x10(%ebp),%eax
  800f84:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f87:	89 55 10             	mov    %edx,0x10(%ebp)
  800f8a:	85 c0                	test   %eax,%eax
  800f8c:	75 e3                	jne    800f71 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f8e:	eb 23                	jmp    800fb3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f93:	8d 50 01             	lea    0x1(%eax),%edx
  800f96:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f9c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f9f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fa2:	8a 12                	mov    (%edx),%dl
  800fa4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fa6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fac:	89 55 10             	mov    %edx,0x10(%ebp)
  800faf:	85 c0                	test   %eax,%eax
  800fb1:	75 dd                	jne    800f90 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb6:	c9                   	leave  
  800fb7:	c3                   	ret    

00800fb8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fb8:	55                   	push   %ebp
  800fb9:	89 e5                	mov    %esp,%ebp
  800fbb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fca:	eb 2a                	jmp    800ff6 <memcmp+0x3e>
		if (*s1 != *s2)
  800fcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fcf:	8a 10                	mov    (%eax),%dl
  800fd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	38 c2                	cmp    %al,%dl
  800fd8:	74 16                	je     800ff0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	0f b6 d0             	movzbl %al,%edx
  800fe2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	0f b6 c0             	movzbl %al,%eax
  800fea:	29 c2                	sub    %eax,%edx
  800fec:	89 d0                	mov    %edx,%eax
  800fee:	eb 18                	jmp    801008 <memcmp+0x50>
		s1++, s2++;
  800ff0:	ff 45 fc             	incl   -0x4(%ebp)
  800ff3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ff6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ffc:	89 55 10             	mov    %edx,0x10(%ebp)
  800fff:	85 c0                	test   %eax,%eax
  801001:	75 c9                	jne    800fcc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801003:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801008:	c9                   	leave  
  801009:	c3                   	ret    

0080100a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80100a:	55                   	push   %ebp
  80100b:	89 e5                	mov    %esp,%ebp
  80100d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801010:	8b 55 08             	mov    0x8(%ebp),%edx
  801013:	8b 45 10             	mov    0x10(%ebp),%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80101b:	eb 15                	jmp    801032 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	8a 00                	mov    (%eax),%al
  801022:	0f b6 d0             	movzbl %al,%edx
  801025:	8b 45 0c             	mov    0xc(%ebp),%eax
  801028:	0f b6 c0             	movzbl %al,%eax
  80102b:	39 c2                	cmp    %eax,%edx
  80102d:	74 0d                	je     80103c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80102f:	ff 45 08             	incl   0x8(%ebp)
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801038:	72 e3                	jb     80101d <memfind+0x13>
  80103a:	eb 01                	jmp    80103d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80103c:	90                   	nop
	return (void *) s;
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801040:	c9                   	leave  
  801041:	c3                   	ret    

00801042 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801042:	55                   	push   %ebp
  801043:	89 e5                	mov    %esp,%ebp
  801045:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801048:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80104f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801056:	eb 03                	jmp    80105b <strtol+0x19>
		s++;
  801058:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	8a 00                	mov    (%eax),%al
  801060:	3c 20                	cmp    $0x20,%al
  801062:	74 f4                	je     801058 <strtol+0x16>
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	3c 09                	cmp    $0x9,%al
  80106b:	74 eb                	je     801058 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8a 00                	mov    (%eax),%al
  801072:	3c 2b                	cmp    $0x2b,%al
  801074:	75 05                	jne    80107b <strtol+0x39>
		s++;
  801076:	ff 45 08             	incl   0x8(%ebp)
  801079:	eb 13                	jmp    80108e <strtol+0x4c>
	else if (*s == '-')
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	3c 2d                	cmp    $0x2d,%al
  801082:	75 0a                	jne    80108e <strtol+0x4c>
		s++, neg = 1;
  801084:	ff 45 08             	incl   0x8(%ebp)
  801087:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80108e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801092:	74 06                	je     80109a <strtol+0x58>
  801094:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801098:	75 20                	jne    8010ba <strtol+0x78>
  80109a:	8b 45 08             	mov    0x8(%ebp),%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	3c 30                	cmp    $0x30,%al
  8010a1:	75 17                	jne    8010ba <strtol+0x78>
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	40                   	inc    %eax
  8010a7:	8a 00                	mov    (%eax),%al
  8010a9:	3c 78                	cmp    $0x78,%al
  8010ab:	75 0d                	jne    8010ba <strtol+0x78>
		s += 2, base = 16;
  8010ad:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010b1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010b8:	eb 28                	jmp    8010e2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010be:	75 15                	jne    8010d5 <strtol+0x93>
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	3c 30                	cmp    $0x30,%al
  8010c7:	75 0c                	jne    8010d5 <strtol+0x93>
		s++, base = 8;
  8010c9:	ff 45 08             	incl   0x8(%ebp)
  8010cc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010d3:	eb 0d                	jmp    8010e2 <strtol+0xa0>
	else if (base == 0)
  8010d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d9:	75 07                	jne    8010e2 <strtol+0xa0>
		base = 10;
  8010db:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	3c 2f                	cmp    $0x2f,%al
  8010e9:	7e 19                	jle    801104 <strtol+0xc2>
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	3c 39                	cmp    $0x39,%al
  8010f2:	7f 10                	jg     801104 <strtol+0xc2>
			dig = *s - '0';
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	8a 00                	mov    (%eax),%al
  8010f9:	0f be c0             	movsbl %al,%eax
  8010fc:	83 e8 30             	sub    $0x30,%eax
  8010ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801102:	eb 42                	jmp    801146 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	3c 60                	cmp    $0x60,%al
  80110b:	7e 19                	jle    801126 <strtol+0xe4>
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8a 00                	mov    (%eax),%al
  801112:	3c 7a                	cmp    $0x7a,%al
  801114:	7f 10                	jg     801126 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	8a 00                	mov    (%eax),%al
  80111b:	0f be c0             	movsbl %al,%eax
  80111e:	83 e8 57             	sub    $0x57,%eax
  801121:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801124:	eb 20                	jmp    801146 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	3c 40                	cmp    $0x40,%al
  80112d:	7e 39                	jle    801168 <strtol+0x126>
  80112f:	8b 45 08             	mov    0x8(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	3c 5a                	cmp    $0x5a,%al
  801136:	7f 30                	jg     801168 <strtol+0x126>
			dig = *s - 'A' + 10;
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	8a 00                	mov    (%eax),%al
  80113d:	0f be c0             	movsbl %al,%eax
  801140:	83 e8 37             	sub    $0x37,%eax
  801143:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801146:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801149:	3b 45 10             	cmp    0x10(%ebp),%eax
  80114c:	7d 19                	jge    801167 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80114e:	ff 45 08             	incl   0x8(%ebp)
  801151:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801154:	0f af 45 10          	imul   0x10(%ebp),%eax
  801158:	89 c2                	mov    %eax,%edx
  80115a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80115d:	01 d0                	add    %edx,%eax
  80115f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801162:	e9 7b ff ff ff       	jmp    8010e2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801167:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801168:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80116c:	74 08                	je     801176 <strtol+0x134>
		*endptr = (char *) s;
  80116e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801171:	8b 55 08             	mov    0x8(%ebp),%edx
  801174:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801176:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80117a:	74 07                	je     801183 <strtol+0x141>
  80117c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80117f:	f7 d8                	neg    %eax
  801181:	eb 03                	jmp    801186 <strtol+0x144>
  801183:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <ltostr>:

void
ltostr(long value, char *str)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80118e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801195:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80119c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a0:	79 13                	jns    8011b5 <ltostr+0x2d>
	{
		neg = 1;
  8011a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ac:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011af:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011b2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011bd:	99                   	cltd   
  8011be:	f7 f9                	idiv   %ecx
  8011c0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011c6:	8d 50 01             	lea    0x1(%eax),%edx
  8011c9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011cc:	89 c2                	mov    %eax,%edx
  8011ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d1:	01 d0                	add    %edx,%eax
  8011d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d6:	83 c2 30             	add    $0x30,%edx
  8011d9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011db:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011de:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011e3:	f7 e9                	imul   %ecx
  8011e5:	c1 fa 02             	sar    $0x2,%edx
  8011e8:	89 c8                	mov    %ecx,%eax
  8011ea:	c1 f8 1f             	sar    $0x1f,%eax
  8011ed:	29 c2                	sub    %eax,%edx
  8011ef:	89 d0                	mov    %edx,%eax
  8011f1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8011f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011f7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011fc:	f7 e9                	imul   %ecx
  8011fe:	c1 fa 02             	sar    $0x2,%edx
  801201:	89 c8                	mov    %ecx,%eax
  801203:	c1 f8 1f             	sar    $0x1f,%eax
  801206:	29 c2                	sub    %eax,%edx
  801208:	89 d0                	mov    %edx,%eax
  80120a:	c1 e0 02             	shl    $0x2,%eax
  80120d:	01 d0                	add    %edx,%eax
  80120f:	01 c0                	add    %eax,%eax
  801211:	29 c1                	sub    %eax,%ecx
  801213:	89 ca                	mov    %ecx,%edx
  801215:	85 d2                	test   %edx,%edx
  801217:	75 9c                	jne    8011b5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801219:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801220:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801223:	48                   	dec    %eax
  801224:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801227:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80122b:	74 3d                	je     80126a <ltostr+0xe2>
		start = 1 ;
  80122d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801234:	eb 34                	jmp    80126a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801236:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801239:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123c:	01 d0                	add    %edx,%eax
  80123e:	8a 00                	mov    (%eax),%al
  801240:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801243:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	01 c2                	add    %eax,%edx
  80124b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80124e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801251:	01 c8                	add    %ecx,%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801257:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80125a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125d:	01 c2                	add    %eax,%edx
  80125f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801262:	88 02                	mov    %al,(%edx)
		start++ ;
  801264:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801267:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80126a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801270:	7c c4                	jl     801236 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801272:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801275:	8b 45 0c             	mov    0xc(%ebp),%eax
  801278:	01 d0                	add    %edx,%eax
  80127a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80127d:	90                   	nop
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
  801283:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801286:	ff 75 08             	pushl  0x8(%ebp)
  801289:	e8 54 fa ff ff       	call   800ce2 <strlen>
  80128e:	83 c4 04             	add    $0x4,%esp
  801291:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801294:	ff 75 0c             	pushl  0xc(%ebp)
  801297:	e8 46 fa ff ff       	call   800ce2 <strlen>
  80129c:	83 c4 04             	add    $0x4,%esp
  80129f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b0:	eb 17                	jmp    8012c9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b8:	01 c2                	add    %eax,%edx
  8012ba:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	01 c8                	add    %ecx,%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012c6:	ff 45 fc             	incl   -0x4(%ebp)
  8012c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012cf:	7c e1                	jl     8012b2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012df:	eb 1f                	jmp    801300 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e4:	8d 50 01             	lea    0x1(%eax),%edx
  8012e7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012ea:	89 c2                	mov    %eax,%edx
  8012ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ef:	01 c2                	add    %eax,%edx
  8012f1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	01 c8                	add    %ecx,%eax
  8012f9:	8a 00                	mov    (%eax),%al
  8012fb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012fd:	ff 45 f8             	incl   -0x8(%ebp)
  801300:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801303:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801306:	7c d9                	jl     8012e1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801308:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80130b:	8b 45 10             	mov    0x10(%ebp),%eax
  80130e:	01 d0                	add    %edx,%eax
  801310:	c6 00 00             	movb   $0x0,(%eax)
}
  801313:	90                   	nop
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801319:	8b 45 14             	mov    0x14(%ebp),%eax
  80131c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801322:	8b 45 14             	mov    0x14(%ebp),%eax
  801325:	8b 00                	mov    (%eax),%eax
  801327:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80132e:	8b 45 10             	mov    0x10(%ebp),%eax
  801331:	01 d0                	add    %edx,%eax
  801333:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801339:	eb 0c                	jmp    801347 <strsplit+0x31>
			*string++ = 0;
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	8d 50 01             	lea    0x1(%eax),%edx
  801341:	89 55 08             	mov    %edx,0x8(%ebp)
  801344:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	8a 00                	mov    (%eax),%al
  80134c:	84 c0                	test   %al,%al
  80134e:	74 18                	je     801368 <strsplit+0x52>
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	0f be c0             	movsbl %al,%eax
  801358:	50                   	push   %eax
  801359:	ff 75 0c             	pushl  0xc(%ebp)
  80135c:	e8 13 fb ff ff       	call   800e74 <strchr>
  801361:	83 c4 08             	add    $0x8,%esp
  801364:	85 c0                	test   %eax,%eax
  801366:	75 d3                	jne    80133b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	8a 00                	mov    (%eax),%al
  80136d:	84 c0                	test   %al,%al
  80136f:	74 5a                	je     8013cb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801371:	8b 45 14             	mov    0x14(%ebp),%eax
  801374:	8b 00                	mov    (%eax),%eax
  801376:	83 f8 0f             	cmp    $0xf,%eax
  801379:	75 07                	jne    801382 <strsplit+0x6c>
		{
			return 0;
  80137b:	b8 00 00 00 00       	mov    $0x0,%eax
  801380:	eb 66                	jmp    8013e8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801382:	8b 45 14             	mov    0x14(%ebp),%eax
  801385:	8b 00                	mov    (%eax),%eax
  801387:	8d 48 01             	lea    0x1(%eax),%ecx
  80138a:	8b 55 14             	mov    0x14(%ebp),%edx
  80138d:	89 0a                	mov    %ecx,(%edx)
  80138f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801396:	8b 45 10             	mov    0x10(%ebp),%eax
  801399:	01 c2                	add    %eax,%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a0:	eb 03                	jmp    8013a5 <strsplit+0x8f>
			string++;
  8013a2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	84 c0                	test   %al,%al
  8013ac:	74 8b                	je     801339 <strsplit+0x23>
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	8a 00                	mov    (%eax),%al
  8013b3:	0f be c0             	movsbl %al,%eax
  8013b6:	50                   	push   %eax
  8013b7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ba:	e8 b5 fa ff ff       	call   800e74 <strchr>
  8013bf:	83 c4 08             	add    $0x8,%esp
  8013c2:	85 c0                	test   %eax,%eax
  8013c4:	74 dc                	je     8013a2 <strsplit+0x8c>
			string++;
	}
  8013c6:	e9 6e ff ff ff       	jmp    801339 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013cb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013cf:	8b 00                	mov    (%eax),%eax
  8013d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013db:	01 d0                	add    %edx,%eax
  8013dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
  8013ed:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8013f0:	83 ec 04             	sub    $0x4,%esp
  8013f3:	68 d0 27 80 00       	push   $0x8027d0
  8013f8:	6a 16                	push   $0x16
  8013fa:	68 f5 27 80 00       	push   $0x8027f5
  8013ff:	e8 ba ef ff ff       	call   8003be <_panic>

00801404 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  80140a:	83 ec 04             	sub    $0x4,%esp
  80140d:	68 04 28 80 00       	push   $0x802804
  801412:	6a 2e                	push   $0x2e
  801414:	68 f5 27 80 00       	push   $0x8027f5
  801419:	e8 a0 ef ff ff       	call   8003be <_panic>

0080141e <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
  801421:	83 ec 18             	sub    $0x18,%esp
  801424:	8b 45 10             	mov    0x10(%ebp),%eax
  801427:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80142a:	83 ec 04             	sub    $0x4,%esp
  80142d:	68 28 28 80 00       	push   $0x802828
  801432:	6a 3b                	push   $0x3b
  801434:	68 f5 27 80 00       	push   $0x8027f5
  801439:	e8 80 ef ff ff       	call   8003be <_panic>

0080143e <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
  801441:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801444:	83 ec 04             	sub    $0x4,%esp
  801447:	68 28 28 80 00       	push   $0x802828
  80144c:	6a 41                	push   $0x41
  80144e:	68 f5 27 80 00       	push   $0x8027f5
  801453:	e8 66 ef ff ff       	call   8003be <_panic>

00801458 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801458:	55                   	push   %ebp
  801459:	89 e5                	mov    %esp,%ebp
  80145b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80145e:	83 ec 04             	sub    $0x4,%esp
  801461:	68 28 28 80 00       	push   $0x802828
  801466:	6a 47                	push   $0x47
  801468:	68 f5 27 80 00       	push   $0x8027f5
  80146d:	e8 4c ef ff ff       	call   8003be <_panic>

00801472 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
  801475:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801478:	83 ec 04             	sub    $0x4,%esp
  80147b:	68 28 28 80 00       	push   $0x802828
  801480:	6a 4c                	push   $0x4c
  801482:	68 f5 27 80 00       	push   $0x8027f5
  801487:	e8 32 ef ff ff       	call   8003be <_panic>

0080148c <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
  80148f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801492:	83 ec 04             	sub    $0x4,%esp
  801495:	68 28 28 80 00       	push   $0x802828
  80149a:	6a 52                	push   $0x52
  80149c:	68 f5 27 80 00       	push   $0x8027f5
  8014a1:	e8 18 ef ff ff       	call   8003be <_panic>

008014a6 <shrink>:
}
void shrink(uint32 newSize)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
  8014a9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014ac:	83 ec 04             	sub    $0x4,%esp
  8014af:	68 28 28 80 00       	push   $0x802828
  8014b4:	6a 56                	push   $0x56
  8014b6:	68 f5 27 80 00       	push   $0x8027f5
  8014bb:	e8 fe ee ff ff       	call   8003be <_panic>

008014c0 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
  8014c3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014c6:	83 ec 04             	sub    $0x4,%esp
  8014c9:	68 28 28 80 00       	push   $0x802828
  8014ce:	6a 5b                	push   $0x5b
  8014d0:	68 f5 27 80 00       	push   $0x8027f5
  8014d5:	e8 e4 ee ff ff       	call   8003be <_panic>

008014da <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	57                   	push   %edi
  8014de:	56                   	push   %esi
  8014df:	53                   	push   %ebx
  8014e0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014ef:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014f2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014f5:	cd 30                	int    $0x30
  8014f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014fd:	83 c4 10             	add    $0x10,%esp
  801500:	5b                   	pop    %ebx
  801501:	5e                   	pop    %esi
  801502:	5f                   	pop    %edi
  801503:	5d                   	pop    %ebp
  801504:	c3                   	ret    

00801505 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
  801508:	83 ec 04             	sub    $0x4,%esp
  80150b:	8b 45 10             	mov    0x10(%ebp),%eax
  80150e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801511:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	52                   	push   %edx
  80151d:	ff 75 0c             	pushl  0xc(%ebp)
  801520:	50                   	push   %eax
  801521:	6a 00                	push   $0x0
  801523:	e8 b2 ff ff ff       	call   8014da <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	90                   	nop
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <sys_cgetc>:

int
sys_cgetc(void)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 01                	push   $0x1
  80153d:	e8 98 ff ff ff       	call   8014da <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	50                   	push   %eax
  801556:	6a 05                	push   $0x5
  801558:	e8 7d ff ff ff       	call   8014da <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
}
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 02                	push   $0x2
  801571:	e8 64 ff ff ff       	call   8014da <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 03                	push   $0x3
  80158a:	e8 4b ff ff ff       	call   8014da <syscall>
  80158f:	83 c4 18             	add    $0x18,%esp
}
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 04                	push   $0x4
  8015a3:	e8 32 ff ff ff       	call   8014da <syscall>
  8015a8:	83 c4 18             	add    $0x18,%esp
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <sys_env_exit>:


void sys_env_exit(void)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 06                	push   $0x6
  8015bc:	e8 19 ff ff ff       	call   8014da <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
}
  8015c4:	90                   	nop
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	52                   	push   %edx
  8015d7:	50                   	push   %eax
  8015d8:	6a 07                	push   $0x7
  8015da:	e8 fb fe ff ff       	call   8014da <syscall>
  8015df:	83 c4 18             	add    $0x18,%esp
}
  8015e2:	c9                   	leave  
  8015e3:	c3                   	ret    

008015e4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015e4:	55                   	push   %ebp
  8015e5:	89 e5                	mov    %esp,%ebp
  8015e7:	56                   	push   %esi
  8015e8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015e9:	8b 75 18             	mov    0x18(%ebp),%esi
  8015ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	56                   	push   %esi
  8015f9:	53                   	push   %ebx
  8015fa:	51                   	push   %ecx
  8015fb:	52                   	push   %edx
  8015fc:	50                   	push   %eax
  8015fd:	6a 08                	push   $0x8
  8015ff:	e8 d6 fe ff ff       	call   8014da <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80160a:	5b                   	pop    %ebx
  80160b:	5e                   	pop    %esi
  80160c:	5d                   	pop    %ebp
  80160d:	c3                   	ret    

0080160e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801611:	8b 55 0c             	mov    0xc(%ebp),%edx
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	52                   	push   %edx
  80161e:	50                   	push   %eax
  80161f:	6a 09                	push   $0x9
  801621:	e8 b4 fe ff ff       	call   8014da <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	ff 75 0c             	pushl  0xc(%ebp)
  801637:	ff 75 08             	pushl  0x8(%ebp)
  80163a:	6a 0a                	push   $0xa
  80163c:	e8 99 fe ff ff       	call   8014da <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 0b                	push   $0xb
  801655:	e8 80 fe ff ff       	call   8014da <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
}
  80165d:	c9                   	leave  
  80165e:	c3                   	ret    

0080165f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 0c                	push   $0xc
  80166e:	e8 67 fe ff ff       	call   8014da <syscall>
  801673:	83 c4 18             	add    $0x18,%esp
}
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 0d                	push   $0xd
  801687:	e8 4e fe ff ff       	call   8014da <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	ff 75 0c             	pushl  0xc(%ebp)
  80169d:	ff 75 08             	pushl  0x8(%ebp)
  8016a0:	6a 11                	push   $0x11
  8016a2:	e8 33 fe ff ff       	call   8014da <syscall>
  8016a7:	83 c4 18             	add    $0x18,%esp
	return;
  8016aa:	90                   	nop
}
  8016ab:	c9                   	leave  
  8016ac:	c3                   	ret    

008016ad <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016ad:	55                   	push   %ebp
  8016ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	ff 75 0c             	pushl  0xc(%ebp)
  8016b9:	ff 75 08             	pushl  0x8(%ebp)
  8016bc:	6a 12                	push   $0x12
  8016be:	e8 17 fe ff ff       	call   8014da <syscall>
  8016c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c6:	90                   	nop
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 0e                	push   $0xe
  8016d8:	e8 fd fd ff ff       	call   8014da <syscall>
  8016dd:	83 c4 18             	add    $0x18,%esp
}
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	ff 75 08             	pushl  0x8(%ebp)
  8016f0:	6a 0f                	push   $0xf
  8016f2:	e8 e3 fd ff ff       	call   8014da <syscall>
  8016f7:	83 c4 18             	add    $0x18,%esp
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 10                	push   $0x10
  80170b:	e8 ca fd ff ff       	call   8014da <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
}
  801713:	90                   	nop
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 14                	push   $0x14
  801725:	e8 b0 fd ff ff       	call   8014da <syscall>
  80172a:	83 c4 18             	add    $0x18,%esp
}
  80172d:	90                   	nop
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 15                	push   $0x15
  80173f:	e8 96 fd ff ff       	call   8014da <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
}
  801747:	90                   	nop
  801748:	c9                   	leave  
  801749:	c3                   	ret    

0080174a <sys_cputc>:


void
sys_cputc(const char c)
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
  80174d:	83 ec 04             	sub    $0x4,%esp
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801756:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	50                   	push   %eax
  801763:	6a 16                	push   $0x16
  801765:	e8 70 fd ff ff       	call   8014da <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	90                   	nop
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 17                	push   $0x17
  80177f:	e8 56 fd ff ff       	call   8014da <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	90                   	nop
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	ff 75 0c             	pushl  0xc(%ebp)
  801799:	50                   	push   %eax
  80179a:	6a 18                	push   $0x18
  80179c:	e8 39 fd ff ff       	call   8014da <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	52                   	push   %edx
  8017b6:	50                   	push   %eax
  8017b7:	6a 1b                	push   $0x1b
  8017b9:	e8 1c fd ff ff       	call   8014da <syscall>
  8017be:	83 c4 18             	add    $0x18,%esp
}
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    

008017c3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	52                   	push   %edx
  8017d3:	50                   	push   %eax
  8017d4:	6a 19                	push   $0x19
  8017d6:	e8 ff fc ff ff       	call   8014da <syscall>
  8017db:	83 c4 18             	add    $0x18,%esp
}
  8017de:	90                   	nop
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	52                   	push   %edx
  8017f1:	50                   	push   %eax
  8017f2:	6a 1a                	push   $0x1a
  8017f4:	e8 e1 fc ff ff       	call   8014da <syscall>
  8017f9:	83 c4 18             	add    $0x18,%esp
}
  8017fc:	90                   	nop
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
  801802:	83 ec 04             	sub    $0x4,%esp
  801805:	8b 45 10             	mov    0x10(%ebp),%eax
  801808:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80180b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80180e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	6a 00                	push   $0x0
  801817:	51                   	push   %ecx
  801818:	52                   	push   %edx
  801819:	ff 75 0c             	pushl  0xc(%ebp)
  80181c:	50                   	push   %eax
  80181d:	6a 1c                	push   $0x1c
  80181f:	e8 b6 fc ff ff       	call   8014da <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80182c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	52                   	push   %edx
  801839:	50                   	push   %eax
  80183a:	6a 1d                	push   $0x1d
  80183c:	e8 99 fc ff ff       	call   8014da <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801849:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80184c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184f:	8b 45 08             	mov    0x8(%ebp),%eax
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	51                   	push   %ecx
  801857:	52                   	push   %edx
  801858:	50                   	push   %eax
  801859:	6a 1e                	push   $0x1e
  80185b:	e8 7a fc ff ff       	call   8014da <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
}
  801863:	c9                   	leave  
  801864:	c3                   	ret    

00801865 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801868:	8b 55 0c             	mov    0xc(%ebp),%edx
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	52                   	push   %edx
  801875:	50                   	push   %eax
  801876:	6a 1f                	push   $0x1f
  801878:	e8 5d fc ff ff       	call   8014da <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 20                	push   $0x20
  801891:	e8 44 fc ff ff       	call   8014da <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a1:	6a 00                	push   $0x0
  8018a3:	ff 75 14             	pushl  0x14(%ebp)
  8018a6:	ff 75 10             	pushl  0x10(%ebp)
  8018a9:	ff 75 0c             	pushl  0xc(%ebp)
  8018ac:	50                   	push   %eax
  8018ad:	6a 21                	push   $0x21
  8018af:	e8 26 fc ff ff       	call   8014da <syscall>
  8018b4:	83 c4 18             	add    $0x18,%esp
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	50                   	push   %eax
  8018c8:	6a 22                	push   $0x22
  8018ca:	e8 0b fc ff ff       	call   8014da <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
}
  8018d2:	90                   	nop
  8018d3:	c9                   	leave  
  8018d4:	c3                   	ret    

008018d5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018d5:	55                   	push   %ebp
  8018d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	50                   	push   %eax
  8018e4:	6a 23                	push   $0x23
  8018e6:	e8 ef fb ff ff       	call   8014da <syscall>
  8018eb:	83 c4 18             	add    $0x18,%esp
}
  8018ee:	90                   	nop
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
  8018f4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018f7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018fa:	8d 50 04             	lea    0x4(%eax),%edx
  8018fd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	52                   	push   %edx
  801907:	50                   	push   %eax
  801908:	6a 24                	push   $0x24
  80190a:	e8 cb fb ff ff       	call   8014da <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
	return result;
  801912:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801915:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801918:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80191b:	89 01                	mov    %eax,(%ecx)
  80191d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801920:	8b 45 08             	mov    0x8(%ebp),%eax
  801923:	c9                   	leave  
  801924:	c2 04 00             	ret    $0x4

00801927 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	ff 75 10             	pushl  0x10(%ebp)
  801931:	ff 75 0c             	pushl  0xc(%ebp)
  801934:	ff 75 08             	pushl  0x8(%ebp)
  801937:	6a 13                	push   $0x13
  801939:	e8 9c fb ff ff       	call   8014da <syscall>
  80193e:	83 c4 18             	add    $0x18,%esp
	return ;
  801941:	90                   	nop
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_rcr2>:
uint32 sys_rcr2()
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 25                	push   $0x25
  801953:	e8 82 fb ff ff       	call   8014da <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
  801960:	83 ec 04             	sub    $0x4,%esp
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801969:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	50                   	push   %eax
  801976:	6a 26                	push   $0x26
  801978:	e8 5d fb ff ff       	call   8014da <syscall>
  80197d:	83 c4 18             	add    $0x18,%esp
	return ;
  801980:	90                   	nop
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <rsttst>:
void rsttst()
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 28                	push   $0x28
  801992:	e8 43 fb ff ff       	call   8014da <syscall>
  801997:	83 c4 18             	add    $0x18,%esp
	return ;
  80199a:	90                   	nop
}
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
  8019a0:	83 ec 04             	sub    $0x4,%esp
  8019a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019a9:	8b 55 18             	mov    0x18(%ebp),%edx
  8019ac:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019b0:	52                   	push   %edx
  8019b1:	50                   	push   %eax
  8019b2:	ff 75 10             	pushl  0x10(%ebp)
  8019b5:	ff 75 0c             	pushl  0xc(%ebp)
  8019b8:	ff 75 08             	pushl  0x8(%ebp)
  8019bb:	6a 27                	push   $0x27
  8019bd:	e8 18 fb ff ff       	call   8014da <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c5:	90                   	nop
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <chktst>:
void chktst(uint32 n)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	ff 75 08             	pushl  0x8(%ebp)
  8019d6:	6a 29                	push   $0x29
  8019d8:	e8 fd fa ff ff       	call   8014da <syscall>
  8019dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e0:	90                   	nop
}
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <inctst>:

void inctst()
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 2a                	push   $0x2a
  8019f2:	e8 e3 fa ff ff       	call   8014da <syscall>
  8019f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019fa:	90                   	nop
}
  8019fb:	c9                   	leave  
  8019fc:	c3                   	ret    

008019fd <gettst>:
uint32 gettst()
{
  8019fd:	55                   	push   %ebp
  8019fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 2b                	push   $0x2b
  801a0c:	e8 c9 fa ff ff       	call   8014da <syscall>
  801a11:	83 c4 18             	add    $0x18,%esp
}
  801a14:	c9                   	leave  
  801a15:	c3                   	ret    

00801a16 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
  801a19:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 2c                	push   $0x2c
  801a28:	e8 ad fa ff ff       	call   8014da <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
  801a30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a33:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a37:	75 07                	jne    801a40 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a39:	b8 01 00 00 00       	mov    $0x1,%eax
  801a3e:	eb 05                	jmp    801a45 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a45:	c9                   	leave  
  801a46:	c3                   	ret    

00801a47 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
  801a4a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 2c                	push   $0x2c
  801a59:	e8 7c fa ff ff       	call   8014da <syscall>
  801a5e:	83 c4 18             	add    $0x18,%esp
  801a61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a64:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a68:	75 07                	jne    801a71 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a6a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6f:	eb 05                	jmp    801a76 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a71:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a76:	c9                   	leave  
  801a77:	c3                   	ret    

00801a78 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a78:	55                   	push   %ebp
  801a79:	89 e5                	mov    %esp,%ebp
  801a7b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 2c                	push   $0x2c
  801a8a:	e8 4b fa ff ff       	call   8014da <syscall>
  801a8f:	83 c4 18             	add    $0x18,%esp
  801a92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a95:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a99:	75 07                	jne    801aa2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a9b:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa0:	eb 05                	jmp    801aa7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801aa2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
  801aac:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 2c                	push   $0x2c
  801abb:	e8 1a fa ff ff       	call   8014da <syscall>
  801ac0:	83 c4 18             	add    $0x18,%esp
  801ac3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ac6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801aca:	75 07                	jne    801ad3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801acc:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad1:	eb 05                	jmp    801ad8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ad3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad8:	c9                   	leave  
  801ad9:	c3                   	ret    

00801ada <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ada:	55                   	push   %ebp
  801adb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	ff 75 08             	pushl  0x8(%ebp)
  801ae8:	6a 2d                	push   $0x2d
  801aea:	e8 eb f9 ff ff       	call   8014da <syscall>
  801aef:	83 c4 18             	add    $0x18,%esp
	return ;
  801af2:	90                   	nop
}
  801af3:	c9                   	leave  
  801af4:	c3                   	ret    

00801af5 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801af5:	55                   	push   %ebp
  801af6:	89 e5                	mov    %esp,%ebp
  801af8:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801af9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801afc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b02:	8b 45 08             	mov    0x8(%ebp),%eax
  801b05:	6a 00                	push   $0x0
  801b07:	53                   	push   %ebx
  801b08:	51                   	push   %ecx
  801b09:	52                   	push   %edx
  801b0a:	50                   	push   %eax
  801b0b:	6a 2e                	push   $0x2e
  801b0d:	e8 c8 f9 ff ff       	call   8014da <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b18:	c9                   	leave  
  801b19:	c3                   	ret    

00801b1a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b1a:	55                   	push   %ebp
  801b1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b20:	8b 45 08             	mov    0x8(%ebp),%eax
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	52                   	push   %edx
  801b2a:	50                   	push   %eax
  801b2b:	6a 2f                	push   $0x2f
  801b2d:	e8 a8 f9 ff ff       	call   8014da <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
}
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    
  801b37:	90                   	nop

00801b38 <__udivdi3>:
  801b38:	55                   	push   %ebp
  801b39:	57                   	push   %edi
  801b3a:	56                   	push   %esi
  801b3b:	53                   	push   %ebx
  801b3c:	83 ec 1c             	sub    $0x1c,%esp
  801b3f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b43:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b4b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b4f:	89 ca                	mov    %ecx,%edx
  801b51:	89 f8                	mov    %edi,%eax
  801b53:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b57:	85 f6                	test   %esi,%esi
  801b59:	75 2d                	jne    801b88 <__udivdi3+0x50>
  801b5b:	39 cf                	cmp    %ecx,%edi
  801b5d:	77 65                	ja     801bc4 <__udivdi3+0x8c>
  801b5f:	89 fd                	mov    %edi,%ebp
  801b61:	85 ff                	test   %edi,%edi
  801b63:	75 0b                	jne    801b70 <__udivdi3+0x38>
  801b65:	b8 01 00 00 00       	mov    $0x1,%eax
  801b6a:	31 d2                	xor    %edx,%edx
  801b6c:	f7 f7                	div    %edi
  801b6e:	89 c5                	mov    %eax,%ebp
  801b70:	31 d2                	xor    %edx,%edx
  801b72:	89 c8                	mov    %ecx,%eax
  801b74:	f7 f5                	div    %ebp
  801b76:	89 c1                	mov    %eax,%ecx
  801b78:	89 d8                	mov    %ebx,%eax
  801b7a:	f7 f5                	div    %ebp
  801b7c:	89 cf                	mov    %ecx,%edi
  801b7e:	89 fa                	mov    %edi,%edx
  801b80:	83 c4 1c             	add    $0x1c,%esp
  801b83:	5b                   	pop    %ebx
  801b84:	5e                   	pop    %esi
  801b85:	5f                   	pop    %edi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    
  801b88:	39 ce                	cmp    %ecx,%esi
  801b8a:	77 28                	ja     801bb4 <__udivdi3+0x7c>
  801b8c:	0f bd fe             	bsr    %esi,%edi
  801b8f:	83 f7 1f             	xor    $0x1f,%edi
  801b92:	75 40                	jne    801bd4 <__udivdi3+0x9c>
  801b94:	39 ce                	cmp    %ecx,%esi
  801b96:	72 0a                	jb     801ba2 <__udivdi3+0x6a>
  801b98:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b9c:	0f 87 9e 00 00 00    	ja     801c40 <__udivdi3+0x108>
  801ba2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ba7:	89 fa                	mov    %edi,%edx
  801ba9:	83 c4 1c             	add    $0x1c,%esp
  801bac:	5b                   	pop    %ebx
  801bad:	5e                   	pop    %esi
  801bae:	5f                   	pop    %edi
  801baf:	5d                   	pop    %ebp
  801bb0:	c3                   	ret    
  801bb1:	8d 76 00             	lea    0x0(%esi),%esi
  801bb4:	31 ff                	xor    %edi,%edi
  801bb6:	31 c0                	xor    %eax,%eax
  801bb8:	89 fa                	mov    %edi,%edx
  801bba:	83 c4 1c             	add    $0x1c,%esp
  801bbd:	5b                   	pop    %ebx
  801bbe:	5e                   	pop    %esi
  801bbf:	5f                   	pop    %edi
  801bc0:	5d                   	pop    %ebp
  801bc1:	c3                   	ret    
  801bc2:	66 90                	xchg   %ax,%ax
  801bc4:	89 d8                	mov    %ebx,%eax
  801bc6:	f7 f7                	div    %edi
  801bc8:	31 ff                	xor    %edi,%edi
  801bca:	89 fa                	mov    %edi,%edx
  801bcc:	83 c4 1c             	add    $0x1c,%esp
  801bcf:	5b                   	pop    %ebx
  801bd0:	5e                   	pop    %esi
  801bd1:	5f                   	pop    %edi
  801bd2:	5d                   	pop    %ebp
  801bd3:	c3                   	ret    
  801bd4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bd9:	89 eb                	mov    %ebp,%ebx
  801bdb:	29 fb                	sub    %edi,%ebx
  801bdd:	89 f9                	mov    %edi,%ecx
  801bdf:	d3 e6                	shl    %cl,%esi
  801be1:	89 c5                	mov    %eax,%ebp
  801be3:	88 d9                	mov    %bl,%cl
  801be5:	d3 ed                	shr    %cl,%ebp
  801be7:	89 e9                	mov    %ebp,%ecx
  801be9:	09 f1                	or     %esi,%ecx
  801beb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bef:	89 f9                	mov    %edi,%ecx
  801bf1:	d3 e0                	shl    %cl,%eax
  801bf3:	89 c5                	mov    %eax,%ebp
  801bf5:	89 d6                	mov    %edx,%esi
  801bf7:	88 d9                	mov    %bl,%cl
  801bf9:	d3 ee                	shr    %cl,%esi
  801bfb:	89 f9                	mov    %edi,%ecx
  801bfd:	d3 e2                	shl    %cl,%edx
  801bff:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c03:	88 d9                	mov    %bl,%cl
  801c05:	d3 e8                	shr    %cl,%eax
  801c07:	09 c2                	or     %eax,%edx
  801c09:	89 d0                	mov    %edx,%eax
  801c0b:	89 f2                	mov    %esi,%edx
  801c0d:	f7 74 24 0c          	divl   0xc(%esp)
  801c11:	89 d6                	mov    %edx,%esi
  801c13:	89 c3                	mov    %eax,%ebx
  801c15:	f7 e5                	mul    %ebp
  801c17:	39 d6                	cmp    %edx,%esi
  801c19:	72 19                	jb     801c34 <__udivdi3+0xfc>
  801c1b:	74 0b                	je     801c28 <__udivdi3+0xf0>
  801c1d:	89 d8                	mov    %ebx,%eax
  801c1f:	31 ff                	xor    %edi,%edi
  801c21:	e9 58 ff ff ff       	jmp    801b7e <__udivdi3+0x46>
  801c26:	66 90                	xchg   %ax,%ax
  801c28:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c2c:	89 f9                	mov    %edi,%ecx
  801c2e:	d3 e2                	shl    %cl,%edx
  801c30:	39 c2                	cmp    %eax,%edx
  801c32:	73 e9                	jae    801c1d <__udivdi3+0xe5>
  801c34:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c37:	31 ff                	xor    %edi,%edi
  801c39:	e9 40 ff ff ff       	jmp    801b7e <__udivdi3+0x46>
  801c3e:	66 90                	xchg   %ax,%ax
  801c40:	31 c0                	xor    %eax,%eax
  801c42:	e9 37 ff ff ff       	jmp    801b7e <__udivdi3+0x46>
  801c47:	90                   	nop

00801c48 <__umoddi3>:
  801c48:	55                   	push   %ebp
  801c49:	57                   	push   %edi
  801c4a:	56                   	push   %esi
  801c4b:	53                   	push   %ebx
  801c4c:	83 ec 1c             	sub    $0x1c,%esp
  801c4f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c53:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c5b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c63:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c67:	89 f3                	mov    %esi,%ebx
  801c69:	89 fa                	mov    %edi,%edx
  801c6b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c6f:	89 34 24             	mov    %esi,(%esp)
  801c72:	85 c0                	test   %eax,%eax
  801c74:	75 1a                	jne    801c90 <__umoddi3+0x48>
  801c76:	39 f7                	cmp    %esi,%edi
  801c78:	0f 86 a2 00 00 00    	jbe    801d20 <__umoddi3+0xd8>
  801c7e:	89 c8                	mov    %ecx,%eax
  801c80:	89 f2                	mov    %esi,%edx
  801c82:	f7 f7                	div    %edi
  801c84:	89 d0                	mov    %edx,%eax
  801c86:	31 d2                	xor    %edx,%edx
  801c88:	83 c4 1c             	add    $0x1c,%esp
  801c8b:	5b                   	pop    %ebx
  801c8c:	5e                   	pop    %esi
  801c8d:	5f                   	pop    %edi
  801c8e:	5d                   	pop    %ebp
  801c8f:	c3                   	ret    
  801c90:	39 f0                	cmp    %esi,%eax
  801c92:	0f 87 ac 00 00 00    	ja     801d44 <__umoddi3+0xfc>
  801c98:	0f bd e8             	bsr    %eax,%ebp
  801c9b:	83 f5 1f             	xor    $0x1f,%ebp
  801c9e:	0f 84 ac 00 00 00    	je     801d50 <__umoddi3+0x108>
  801ca4:	bf 20 00 00 00       	mov    $0x20,%edi
  801ca9:	29 ef                	sub    %ebp,%edi
  801cab:	89 fe                	mov    %edi,%esi
  801cad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cb1:	89 e9                	mov    %ebp,%ecx
  801cb3:	d3 e0                	shl    %cl,%eax
  801cb5:	89 d7                	mov    %edx,%edi
  801cb7:	89 f1                	mov    %esi,%ecx
  801cb9:	d3 ef                	shr    %cl,%edi
  801cbb:	09 c7                	or     %eax,%edi
  801cbd:	89 e9                	mov    %ebp,%ecx
  801cbf:	d3 e2                	shl    %cl,%edx
  801cc1:	89 14 24             	mov    %edx,(%esp)
  801cc4:	89 d8                	mov    %ebx,%eax
  801cc6:	d3 e0                	shl    %cl,%eax
  801cc8:	89 c2                	mov    %eax,%edx
  801cca:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cce:	d3 e0                	shl    %cl,%eax
  801cd0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cd4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cd8:	89 f1                	mov    %esi,%ecx
  801cda:	d3 e8                	shr    %cl,%eax
  801cdc:	09 d0                	or     %edx,%eax
  801cde:	d3 eb                	shr    %cl,%ebx
  801ce0:	89 da                	mov    %ebx,%edx
  801ce2:	f7 f7                	div    %edi
  801ce4:	89 d3                	mov    %edx,%ebx
  801ce6:	f7 24 24             	mull   (%esp)
  801ce9:	89 c6                	mov    %eax,%esi
  801ceb:	89 d1                	mov    %edx,%ecx
  801ced:	39 d3                	cmp    %edx,%ebx
  801cef:	0f 82 87 00 00 00    	jb     801d7c <__umoddi3+0x134>
  801cf5:	0f 84 91 00 00 00    	je     801d8c <__umoddi3+0x144>
  801cfb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cff:	29 f2                	sub    %esi,%edx
  801d01:	19 cb                	sbb    %ecx,%ebx
  801d03:	89 d8                	mov    %ebx,%eax
  801d05:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d09:	d3 e0                	shl    %cl,%eax
  801d0b:	89 e9                	mov    %ebp,%ecx
  801d0d:	d3 ea                	shr    %cl,%edx
  801d0f:	09 d0                	or     %edx,%eax
  801d11:	89 e9                	mov    %ebp,%ecx
  801d13:	d3 eb                	shr    %cl,%ebx
  801d15:	89 da                	mov    %ebx,%edx
  801d17:	83 c4 1c             	add    $0x1c,%esp
  801d1a:	5b                   	pop    %ebx
  801d1b:	5e                   	pop    %esi
  801d1c:	5f                   	pop    %edi
  801d1d:	5d                   	pop    %ebp
  801d1e:	c3                   	ret    
  801d1f:	90                   	nop
  801d20:	89 fd                	mov    %edi,%ebp
  801d22:	85 ff                	test   %edi,%edi
  801d24:	75 0b                	jne    801d31 <__umoddi3+0xe9>
  801d26:	b8 01 00 00 00       	mov    $0x1,%eax
  801d2b:	31 d2                	xor    %edx,%edx
  801d2d:	f7 f7                	div    %edi
  801d2f:	89 c5                	mov    %eax,%ebp
  801d31:	89 f0                	mov    %esi,%eax
  801d33:	31 d2                	xor    %edx,%edx
  801d35:	f7 f5                	div    %ebp
  801d37:	89 c8                	mov    %ecx,%eax
  801d39:	f7 f5                	div    %ebp
  801d3b:	89 d0                	mov    %edx,%eax
  801d3d:	e9 44 ff ff ff       	jmp    801c86 <__umoddi3+0x3e>
  801d42:	66 90                	xchg   %ax,%ax
  801d44:	89 c8                	mov    %ecx,%eax
  801d46:	89 f2                	mov    %esi,%edx
  801d48:	83 c4 1c             	add    $0x1c,%esp
  801d4b:	5b                   	pop    %ebx
  801d4c:	5e                   	pop    %esi
  801d4d:	5f                   	pop    %edi
  801d4e:	5d                   	pop    %ebp
  801d4f:	c3                   	ret    
  801d50:	3b 04 24             	cmp    (%esp),%eax
  801d53:	72 06                	jb     801d5b <__umoddi3+0x113>
  801d55:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d59:	77 0f                	ja     801d6a <__umoddi3+0x122>
  801d5b:	89 f2                	mov    %esi,%edx
  801d5d:	29 f9                	sub    %edi,%ecx
  801d5f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d63:	89 14 24             	mov    %edx,(%esp)
  801d66:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d6a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d6e:	8b 14 24             	mov    (%esp),%edx
  801d71:	83 c4 1c             	add    $0x1c,%esp
  801d74:	5b                   	pop    %ebx
  801d75:	5e                   	pop    %esi
  801d76:	5f                   	pop    %edi
  801d77:	5d                   	pop    %ebp
  801d78:	c3                   	ret    
  801d79:	8d 76 00             	lea    0x0(%esi),%esi
  801d7c:	2b 04 24             	sub    (%esp),%eax
  801d7f:	19 fa                	sbb    %edi,%edx
  801d81:	89 d1                	mov    %edx,%ecx
  801d83:	89 c6                	mov    %eax,%esi
  801d85:	e9 71 ff ff ff       	jmp    801cfb <__umoddi3+0xb3>
  801d8a:	66 90                	xchg   %ax,%ax
  801d8c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d90:	72 ea                	jb     801d7c <__umoddi3+0x134>
  801d92:	89 d9                	mov    %ebx,%ecx
  801d94:	e9 62 ff ff ff       	jmp    801cfb <__umoddi3+0xb3>
