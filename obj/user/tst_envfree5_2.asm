
obj/user/tst_envfree5_2:     file format elf32-i386


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
  800031:	e8 4b 01 00 00       	call   800181 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing removing the shared variables
	// Testing scenario 5_2: Kill programs have already shared variables and they free it [include scenario 5_1]
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 c0 1f 80 00       	push   $0x801fc0
  80004a:	e8 1b 15 00 00       	call   80156a <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 44 17 00 00       	call   8017a7 <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 bf 17 00 00       	call   80182a <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 d0 1f 80 00       	push   $0x801fd0
  800079:	e8 ea 04 00 00       	call   800568 <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tshr4", 2000,100, 50);
  800081:	6a 32                	push   $0x32
  800083:	6a 64                	push   $0x64
  800085:	68 d0 07 00 00       	push   $0x7d0
  80008a:	68 03 20 80 00       	push   $0x802003
  80008f:	e8 68 19 00 00       	call   8019fc <sys_create_env>
  800094:	83 c4 10             	add    $0x10,%esp
  800097:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessB = sys_create_env("ef_tshr5", 2000,100, 50);
  80009a:	6a 32                	push   $0x32
  80009c:	6a 64                	push   $0x64
  80009e:	68 d0 07 00 00       	push   $0x7d0
  8000a3:	68 0c 20 80 00       	push   $0x80200c
  8000a8:	e8 4f 19 00 00       	call   8019fc <sys_create_env>
  8000ad:	83 c4 10             	add    $0x10,%esp
  8000b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	sys_run_env(envIdProcessA);
  8000b3:	83 ec 0c             	sub    $0xc,%esp
  8000b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8000b9:	e8 5c 19 00 00       	call   801a1a <sys_run_env>
  8000be:	83 c4 10             	add    $0x10,%esp
	env_sleep(15000);
  8000c1:	83 ec 0c             	sub    $0xc,%esp
  8000c4:	68 98 3a 00 00       	push   $0x3a98
  8000c9:	e8 ca 1b 00 00       	call   801c98 <env_sleep>
  8000ce:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000d7:	e8 3e 19 00 00       	call   801a1a <sys_run_env>
  8000dc:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 2) ;
  8000df:	90                   	nop
  8000e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000e3:	8b 00                	mov    (%eax),%eax
  8000e5:	83 f8 02             	cmp    $0x2,%eax
  8000e8:	75 f6                	jne    8000e0 <_main+0xa8>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000ea:	e8 b8 16 00 00       	call   8017a7 <sys_calculate_free_frames>
  8000ef:	83 ec 08             	sub    $0x8,%esp
  8000f2:	50                   	push   %eax
  8000f3:	68 18 20 80 00       	push   $0x802018
  8000f8:	e8 6b 04 00 00       	call   800568 <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  800100:	83 ec 0c             	sub    $0xc,%esp
  800103:	ff 75 e8             	pushl  -0x18(%ebp)
  800106:	e8 2b 19 00 00       	call   801a36 <sys_free_env>
  80010b:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  80010e:	83 ec 0c             	sub    $0xc,%esp
  800111:	ff 75 e4             	pushl  -0x1c(%ebp)
  800114:	e8 1d 19 00 00       	call   801a36 <sys_free_env>
  800119:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  80011c:	e8 86 16 00 00       	call   8017a7 <sys_calculate_free_frames>
  800121:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800124:	e8 01 17 00 00       	call   80182a <sys_pf_calculate_allocated_pages>
  800129:	89 45 dc             	mov    %eax,-0x24(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  80012c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800132:	74 27                	je     80015b <_main+0x123>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  800134:	83 ec 08             	sub    $0x8,%esp
  800137:	ff 75 e0             	pushl  -0x20(%ebp)
  80013a:	68 4c 20 80 00       	push   $0x80204c
  80013f:	e8 24 04 00 00       	call   800568 <cprintf>
  800144:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  800147:	83 ec 04             	sub    $0x4,%esp
  80014a:	68 9c 20 80 00       	push   $0x80209c
  80014f:	6a 23                	push   $0x23
  800151:	68 d2 20 80 00       	push   $0x8020d2
  800156:	e8 6b 01 00 00       	call   8002c6 <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80015b:	83 ec 08             	sub    $0x8,%esp
  80015e:	ff 75 e0             	pushl  -0x20(%ebp)
  800161:	68 e8 20 80 00       	push   $0x8020e8
  800166:	e8 fd 03 00 00       	call   800568 <cprintf>
  80016b:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 5_2 for envfree completed successfully.\n");
  80016e:	83 ec 0c             	sub    $0xc,%esp
  800171:	68 48 21 80 00       	push   $0x802148
  800176:	e8 ed 03 00 00       	call   800568 <cprintf>
  80017b:	83 c4 10             	add    $0x10,%esp
	return;
  80017e:	90                   	nop
}
  80017f:	c9                   	leave  
  800180:	c3                   	ret    

00800181 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800181:	55                   	push   %ebp
  800182:	89 e5                	mov    %esp,%ebp
  800184:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800187:	e8 50 15 00 00       	call   8016dc <sys_getenvindex>
  80018c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80018f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800192:	89 d0                	mov    %edx,%eax
  800194:	c1 e0 03             	shl    $0x3,%eax
  800197:	01 d0                	add    %edx,%eax
  800199:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001a0:	01 c8                	add    %ecx,%eax
  8001a2:	01 c0                	add    %eax,%eax
  8001a4:	01 d0                	add    %edx,%eax
  8001a6:	01 c0                	add    %eax,%eax
  8001a8:	01 d0                	add    %edx,%eax
  8001aa:	89 c2                	mov    %eax,%edx
  8001ac:	c1 e2 05             	shl    $0x5,%edx
  8001af:	29 c2                	sub    %eax,%edx
  8001b1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001b8:	89 c2                	mov    %eax,%edx
  8001ba:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001c0:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ca:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001d0:	84 c0                	test   %al,%al
  8001d2:	74 0f                	je     8001e3 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d9:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001de:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001e7:	7e 0a                	jle    8001f3 <libmain+0x72>
		binaryname = argv[0];
  8001e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ec:	8b 00                	mov    (%eax),%eax
  8001ee:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001f3:	83 ec 08             	sub    $0x8,%esp
  8001f6:	ff 75 0c             	pushl  0xc(%ebp)
  8001f9:	ff 75 08             	pushl  0x8(%ebp)
  8001fc:	e8 37 fe ff ff       	call   800038 <_main>
  800201:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800204:	e8 6e 16 00 00       	call   801877 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800209:	83 ec 0c             	sub    $0xc,%esp
  80020c:	68 ac 21 80 00       	push   $0x8021ac
  800211:	e8 52 03 00 00       	call   800568 <cprintf>
  800216:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800219:	a1 20 30 80 00       	mov    0x803020,%eax
  80021e:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800224:	a1 20 30 80 00       	mov    0x803020,%eax
  800229:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80022f:	83 ec 04             	sub    $0x4,%esp
  800232:	52                   	push   %edx
  800233:	50                   	push   %eax
  800234:	68 d4 21 80 00       	push   $0x8021d4
  800239:	e8 2a 03 00 00       	call   800568 <cprintf>
  80023e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800241:	a1 20 30 80 00       	mov    0x803020,%eax
  800246:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80024c:	a1 20 30 80 00       	mov    0x803020,%eax
  800251:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	52                   	push   %edx
  80025b:	50                   	push   %eax
  80025c:	68 fc 21 80 00       	push   $0x8021fc
  800261:	e8 02 03 00 00       	call   800568 <cprintf>
  800266:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800269:	a1 20 30 80 00       	mov    0x803020,%eax
  80026e:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800274:	83 ec 08             	sub    $0x8,%esp
  800277:	50                   	push   %eax
  800278:	68 3d 22 80 00       	push   $0x80223d
  80027d:	e8 e6 02 00 00       	call   800568 <cprintf>
  800282:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	68 ac 21 80 00       	push   $0x8021ac
  80028d:	e8 d6 02 00 00       	call   800568 <cprintf>
  800292:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800295:	e8 f7 15 00 00       	call   801891 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80029a:	e8 19 00 00 00       	call   8002b8 <exit>
}
  80029f:	90                   	nop
  8002a0:	c9                   	leave  
  8002a1:	c3                   	ret    

008002a2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002a2:	55                   	push   %ebp
  8002a3:	89 e5                	mov    %esp,%ebp
  8002a5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002a8:	83 ec 0c             	sub    $0xc,%esp
  8002ab:	6a 00                	push   $0x0
  8002ad:	e8 f6 13 00 00       	call   8016a8 <sys_env_destroy>
  8002b2:	83 c4 10             	add    $0x10,%esp
}
  8002b5:	90                   	nop
  8002b6:	c9                   	leave  
  8002b7:	c3                   	ret    

008002b8 <exit>:

void
exit(void)
{
  8002b8:	55                   	push   %ebp
  8002b9:	89 e5                	mov    %esp,%ebp
  8002bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002be:	e8 4b 14 00 00       	call   80170e <sys_env_exit>
}
  8002c3:	90                   	nop
  8002c4:	c9                   	leave  
  8002c5:	c3                   	ret    

008002c6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002c6:	55                   	push   %ebp
  8002c7:	89 e5                	mov    %esp,%ebp
  8002c9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002cc:	8d 45 10             	lea    0x10(%ebp),%eax
  8002cf:	83 c0 04             	add    $0x4,%eax
  8002d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002d5:	a1 18 31 80 00       	mov    0x803118,%eax
  8002da:	85 c0                	test   %eax,%eax
  8002dc:	74 16                	je     8002f4 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002de:	a1 18 31 80 00       	mov    0x803118,%eax
  8002e3:	83 ec 08             	sub    $0x8,%esp
  8002e6:	50                   	push   %eax
  8002e7:	68 54 22 80 00       	push   $0x802254
  8002ec:	e8 77 02 00 00       	call   800568 <cprintf>
  8002f1:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002f4:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f9:	ff 75 0c             	pushl  0xc(%ebp)
  8002fc:	ff 75 08             	pushl  0x8(%ebp)
  8002ff:	50                   	push   %eax
  800300:	68 59 22 80 00       	push   $0x802259
  800305:	e8 5e 02 00 00       	call   800568 <cprintf>
  80030a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80030d:	8b 45 10             	mov    0x10(%ebp),%eax
  800310:	83 ec 08             	sub    $0x8,%esp
  800313:	ff 75 f4             	pushl  -0xc(%ebp)
  800316:	50                   	push   %eax
  800317:	e8 e1 01 00 00       	call   8004fd <vcprintf>
  80031c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80031f:	83 ec 08             	sub    $0x8,%esp
  800322:	6a 00                	push   $0x0
  800324:	68 75 22 80 00       	push   $0x802275
  800329:	e8 cf 01 00 00       	call   8004fd <vcprintf>
  80032e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800331:	e8 82 ff ff ff       	call   8002b8 <exit>

	// should not return here
	while (1) ;
  800336:	eb fe                	jmp    800336 <_panic+0x70>

00800338 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800338:	55                   	push   %ebp
  800339:	89 e5                	mov    %esp,%ebp
  80033b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80033e:	a1 20 30 80 00       	mov    0x803020,%eax
  800343:	8b 50 74             	mov    0x74(%eax),%edx
  800346:	8b 45 0c             	mov    0xc(%ebp),%eax
  800349:	39 c2                	cmp    %eax,%edx
  80034b:	74 14                	je     800361 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80034d:	83 ec 04             	sub    $0x4,%esp
  800350:	68 78 22 80 00       	push   $0x802278
  800355:	6a 26                	push   $0x26
  800357:	68 c4 22 80 00       	push   $0x8022c4
  80035c:	e8 65 ff ff ff       	call   8002c6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800361:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800368:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80036f:	e9 b6 00 00 00       	jmp    80042a <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800374:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800377:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80037e:	8b 45 08             	mov    0x8(%ebp),%eax
  800381:	01 d0                	add    %edx,%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	85 c0                	test   %eax,%eax
  800387:	75 08                	jne    800391 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800389:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80038c:	e9 96 00 00 00       	jmp    800427 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800391:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800398:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80039f:	eb 5d                	jmp    8003fe <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ac:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003af:	c1 e2 04             	shl    $0x4,%edx
  8003b2:	01 d0                	add    %edx,%eax
  8003b4:	8a 40 04             	mov    0x4(%eax),%al
  8003b7:	84 c0                	test   %al,%al
  8003b9:	75 40                	jne    8003fb <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c9:	c1 e2 04             	shl    $0x4,%edx
  8003cc:	01 d0                	add    %edx,%eax
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003d3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003db:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	01 c8                	add    %ecx,%eax
  8003ec:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003ee:	39 c2                	cmp    %eax,%edx
  8003f0:	75 09                	jne    8003fb <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003f2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003f9:	eb 12                	jmp    80040d <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fb:	ff 45 e8             	incl   -0x18(%ebp)
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 50 74             	mov    0x74(%eax),%edx
  800406:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800409:	39 c2                	cmp    %eax,%edx
  80040b:	77 94                	ja     8003a1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80040d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800411:	75 14                	jne    800427 <CheckWSWithoutLastIndex+0xef>
			panic(
  800413:	83 ec 04             	sub    $0x4,%esp
  800416:	68 d0 22 80 00       	push   $0x8022d0
  80041b:	6a 3a                	push   $0x3a
  80041d:	68 c4 22 80 00       	push   $0x8022c4
  800422:	e8 9f fe ff ff       	call   8002c6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800427:	ff 45 f0             	incl   -0x10(%ebp)
  80042a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80042d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800430:	0f 8c 3e ff ff ff    	jl     800374 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800436:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80043d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800444:	eb 20                	jmp    800466 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800446:	a1 20 30 80 00       	mov    0x803020,%eax
  80044b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800451:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800454:	c1 e2 04             	shl    $0x4,%edx
  800457:	01 d0                	add    %edx,%eax
  800459:	8a 40 04             	mov    0x4(%eax),%al
  80045c:	3c 01                	cmp    $0x1,%al
  80045e:	75 03                	jne    800463 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800460:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800463:	ff 45 e0             	incl   -0x20(%ebp)
  800466:	a1 20 30 80 00       	mov    0x803020,%eax
  80046b:	8b 50 74             	mov    0x74(%eax),%edx
  80046e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800471:	39 c2                	cmp    %eax,%edx
  800473:	77 d1                	ja     800446 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800475:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800478:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80047b:	74 14                	je     800491 <CheckWSWithoutLastIndex+0x159>
		panic(
  80047d:	83 ec 04             	sub    $0x4,%esp
  800480:	68 24 23 80 00       	push   $0x802324
  800485:	6a 44                	push   $0x44
  800487:	68 c4 22 80 00       	push   $0x8022c4
  80048c:	e8 35 fe ff ff       	call   8002c6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800491:	90                   	nop
  800492:	c9                   	leave  
  800493:	c3                   	ret    

00800494 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800494:	55                   	push   %ebp
  800495:	89 e5                	mov    %esp,%ebp
  800497:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80049a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049d:	8b 00                	mov    (%eax),%eax
  80049f:	8d 48 01             	lea    0x1(%eax),%ecx
  8004a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004a5:	89 0a                	mov    %ecx,(%edx)
  8004a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8004aa:	88 d1                	mov    %dl,%cl
  8004ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004af:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004bd:	75 2c                	jne    8004eb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004bf:	a0 24 30 80 00       	mov    0x803024,%al
  8004c4:	0f b6 c0             	movzbl %al,%eax
  8004c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ca:	8b 12                	mov    (%edx),%edx
  8004cc:	89 d1                	mov    %edx,%ecx
  8004ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d1:	83 c2 08             	add    $0x8,%edx
  8004d4:	83 ec 04             	sub    $0x4,%esp
  8004d7:	50                   	push   %eax
  8004d8:	51                   	push   %ecx
  8004d9:	52                   	push   %edx
  8004da:	e8 87 11 00 00       	call   801666 <sys_cputs>
  8004df:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ee:	8b 40 04             	mov    0x4(%eax),%eax
  8004f1:	8d 50 01             	lea    0x1(%eax),%edx
  8004f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004fa:	90                   	nop
  8004fb:	c9                   	leave  
  8004fc:	c3                   	ret    

008004fd <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004fd:	55                   	push   %ebp
  8004fe:	89 e5                	mov    %esp,%ebp
  800500:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800506:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80050d:	00 00 00 
	b.cnt = 0;
  800510:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800517:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80051a:	ff 75 0c             	pushl  0xc(%ebp)
  80051d:	ff 75 08             	pushl  0x8(%ebp)
  800520:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800526:	50                   	push   %eax
  800527:	68 94 04 80 00       	push   $0x800494
  80052c:	e8 11 02 00 00       	call   800742 <vprintfmt>
  800531:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800534:	a0 24 30 80 00       	mov    0x803024,%al
  800539:	0f b6 c0             	movzbl %al,%eax
  80053c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800542:	83 ec 04             	sub    $0x4,%esp
  800545:	50                   	push   %eax
  800546:	52                   	push   %edx
  800547:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80054d:	83 c0 08             	add    $0x8,%eax
  800550:	50                   	push   %eax
  800551:	e8 10 11 00 00       	call   801666 <sys_cputs>
  800556:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800559:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800560:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800566:	c9                   	leave  
  800567:	c3                   	ret    

00800568 <cprintf>:

int cprintf(const char *fmt, ...) {
  800568:	55                   	push   %ebp
  800569:	89 e5                	mov    %esp,%ebp
  80056b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80056e:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800575:	8d 45 0c             	lea    0xc(%ebp),%eax
  800578:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80057b:	8b 45 08             	mov    0x8(%ebp),%eax
  80057e:	83 ec 08             	sub    $0x8,%esp
  800581:	ff 75 f4             	pushl  -0xc(%ebp)
  800584:	50                   	push   %eax
  800585:	e8 73 ff ff ff       	call   8004fd <vcprintf>
  80058a:	83 c4 10             	add    $0x10,%esp
  80058d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800590:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800593:	c9                   	leave  
  800594:	c3                   	ret    

00800595 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800595:	55                   	push   %ebp
  800596:	89 e5                	mov    %esp,%ebp
  800598:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80059b:	e8 d7 12 00 00       	call   801877 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005a0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	83 ec 08             	sub    $0x8,%esp
  8005ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8005af:	50                   	push   %eax
  8005b0:	e8 48 ff ff ff       	call   8004fd <vcprintf>
  8005b5:	83 c4 10             	add    $0x10,%esp
  8005b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005bb:	e8 d1 12 00 00       	call   801891 <sys_enable_interrupt>
	return cnt;
  8005c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005c3:	c9                   	leave  
  8005c4:	c3                   	ret    

008005c5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005c5:	55                   	push   %ebp
  8005c6:	89 e5                	mov    %esp,%ebp
  8005c8:	53                   	push   %ebx
  8005c9:	83 ec 14             	sub    $0x14,%esp
  8005cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8005cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005d8:	8b 45 18             	mov    0x18(%ebp),%eax
  8005db:	ba 00 00 00 00       	mov    $0x0,%edx
  8005e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005e3:	77 55                	ja     80063a <printnum+0x75>
  8005e5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005e8:	72 05                	jb     8005ef <printnum+0x2a>
  8005ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005ed:	77 4b                	ja     80063a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005ef:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005f2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8005f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8005fd:	52                   	push   %edx
  8005fe:	50                   	push   %eax
  8005ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800602:	ff 75 f0             	pushl  -0x10(%ebp)
  800605:	e8 42 17 00 00       	call   801d4c <__udivdi3>
  80060a:	83 c4 10             	add    $0x10,%esp
  80060d:	83 ec 04             	sub    $0x4,%esp
  800610:	ff 75 20             	pushl  0x20(%ebp)
  800613:	53                   	push   %ebx
  800614:	ff 75 18             	pushl  0x18(%ebp)
  800617:	52                   	push   %edx
  800618:	50                   	push   %eax
  800619:	ff 75 0c             	pushl  0xc(%ebp)
  80061c:	ff 75 08             	pushl  0x8(%ebp)
  80061f:	e8 a1 ff ff ff       	call   8005c5 <printnum>
  800624:	83 c4 20             	add    $0x20,%esp
  800627:	eb 1a                	jmp    800643 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800629:	83 ec 08             	sub    $0x8,%esp
  80062c:	ff 75 0c             	pushl  0xc(%ebp)
  80062f:	ff 75 20             	pushl  0x20(%ebp)
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	ff d0                	call   *%eax
  800637:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80063a:	ff 4d 1c             	decl   0x1c(%ebp)
  80063d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800641:	7f e6                	jg     800629 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800643:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800646:	bb 00 00 00 00       	mov    $0x0,%ebx
  80064b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80064e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800651:	53                   	push   %ebx
  800652:	51                   	push   %ecx
  800653:	52                   	push   %edx
  800654:	50                   	push   %eax
  800655:	e8 02 18 00 00       	call   801e5c <__umoddi3>
  80065a:	83 c4 10             	add    $0x10,%esp
  80065d:	05 94 25 80 00       	add    $0x802594,%eax
  800662:	8a 00                	mov    (%eax),%al
  800664:	0f be c0             	movsbl %al,%eax
  800667:	83 ec 08             	sub    $0x8,%esp
  80066a:	ff 75 0c             	pushl  0xc(%ebp)
  80066d:	50                   	push   %eax
  80066e:	8b 45 08             	mov    0x8(%ebp),%eax
  800671:	ff d0                	call   *%eax
  800673:	83 c4 10             	add    $0x10,%esp
}
  800676:	90                   	nop
  800677:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80067a:	c9                   	leave  
  80067b:	c3                   	ret    

0080067c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80067c:	55                   	push   %ebp
  80067d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80067f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800683:	7e 1c                	jle    8006a1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	8d 50 08             	lea    0x8(%eax),%edx
  80068d:	8b 45 08             	mov    0x8(%ebp),%eax
  800690:	89 10                	mov    %edx,(%eax)
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	8b 00                	mov    (%eax),%eax
  800697:	83 e8 08             	sub    $0x8,%eax
  80069a:	8b 50 04             	mov    0x4(%eax),%edx
  80069d:	8b 00                	mov    (%eax),%eax
  80069f:	eb 40                	jmp    8006e1 <getuint+0x65>
	else if (lflag)
  8006a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006a5:	74 1e                	je     8006c5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006aa:	8b 00                	mov    (%eax),%eax
  8006ac:	8d 50 04             	lea    0x4(%eax),%edx
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	89 10                	mov    %edx,(%eax)
  8006b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b7:	8b 00                	mov    (%eax),%eax
  8006b9:	83 e8 04             	sub    $0x4,%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	ba 00 00 00 00       	mov    $0x0,%edx
  8006c3:	eb 1c                	jmp    8006e1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	8d 50 04             	lea    0x4(%eax),%edx
  8006cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d0:	89 10                	mov    %edx,(%eax)
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	8b 00                	mov    (%eax),%eax
  8006d7:	83 e8 04             	sub    $0x4,%eax
  8006da:	8b 00                	mov    (%eax),%eax
  8006dc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006e1:	5d                   	pop    %ebp
  8006e2:	c3                   	ret    

008006e3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006e3:	55                   	push   %ebp
  8006e4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006e6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ea:	7e 1c                	jle    800708 <getint+0x25>
		return va_arg(*ap, long long);
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	8b 00                	mov    (%eax),%eax
  8006f1:	8d 50 08             	lea    0x8(%eax),%edx
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	89 10                	mov    %edx,(%eax)
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	83 e8 08             	sub    $0x8,%eax
  800701:	8b 50 04             	mov    0x4(%eax),%edx
  800704:	8b 00                	mov    (%eax),%eax
  800706:	eb 38                	jmp    800740 <getint+0x5d>
	else if (lflag)
  800708:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80070c:	74 1a                	je     800728 <getint+0x45>
		return va_arg(*ap, long);
  80070e:	8b 45 08             	mov    0x8(%ebp),%eax
  800711:	8b 00                	mov    (%eax),%eax
  800713:	8d 50 04             	lea    0x4(%eax),%edx
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	89 10                	mov    %edx,(%eax)
  80071b:	8b 45 08             	mov    0x8(%ebp),%eax
  80071e:	8b 00                	mov    (%eax),%eax
  800720:	83 e8 04             	sub    $0x4,%eax
  800723:	8b 00                	mov    (%eax),%eax
  800725:	99                   	cltd   
  800726:	eb 18                	jmp    800740 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800728:	8b 45 08             	mov    0x8(%ebp),%eax
  80072b:	8b 00                	mov    (%eax),%eax
  80072d:	8d 50 04             	lea    0x4(%eax),%edx
  800730:	8b 45 08             	mov    0x8(%ebp),%eax
  800733:	89 10                	mov    %edx,(%eax)
  800735:	8b 45 08             	mov    0x8(%ebp),%eax
  800738:	8b 00                	mov    (%eax),%eax
  80073a:	83 e8 04             	sub    $0x4,%eax
  80073d:	8b 00                	mov    (%eax),%eax
  80073f:	99                   	cltd   
}
  800740:	5d                   	pop    %ebp
  800741:	c3                   	ret    

00800742 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800742:	55                   	push   %ebp
  800743:	89 e5                	mov    %esp,%ebp
  800745:	56                   	push   %esi
  800746:	53                   	push   %ebx
  800747:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80074a:	eb 17                	jmp    800763 <vprintfmt+0x21>
			if (ch == '\0')
  80074c:	85 db                	test   %ebx,%ebx
  80074e:	0f 84 af 03 00 00    	je     800b03 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	53                   	push   %ebx
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	ff d0                	call   *%eax
  800760:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800763:	8b 45 10             	mov    0x10(%ebp),%eax
  800766:	8d 50 01             	lea    0x1(%eax),%edx
  800769:	89 55 10             	mov    %edx,0x10(%ebp)
  80076c:	8a 00                	mov    (%eax),%al
  80076e:	0f b6 d8             	movzbl %al,%ebx
  800771:	83 fb 25             	cmp    $0x25,%ebx
  800774:	75 d6                	jne    80074c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800776:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80077a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800781:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800788:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80078f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800796:	8b 45 10             	mov    0x10(%ebp),%eax
  800799:	8d 50 01             	lea    0x1(%eax),%edx
  80079c:	89 55 10             	mov    %edx,0x10(%ebp)
  80079f:	8a 00                	mov    (%eax),%al
  8007a1:	0f b6 d8             	movzbl %al,%ebx
  8007a4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007a7:	83 f8 55             	cmp    $0x55,%eax
  8007aa:	0f 87 2b 03 00 00    	ja     800adb <vprintfmt+0x399>
  8007b0:	8b 04 85 b8 25 80 00 	mov    0x8025b8(,%eax,4),%eax
  8007b7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007b9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007bd:	eb d7                	jmp    800796 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007bf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007c3:	eb d1                	jmp    800796 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007cf:	89 d0                	mov    %edx,%eax
  8007d1:	c1 e0 02             	shl    $0x2,%eax
  8007d4:	01 d0                	add    %edx,%eax
  8007d6:	01 c0                	add    %eax,%eax
  8007d8:	01 d8                	add    %ebx,%eax
  8007da:	83 e8 30             	sub    $0x30,%eax
  8007dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e3:	8a 00                	mov    (%eax),%al
  8007e5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007e8:	83 fb 2f             	cmp    $0x2f,%ebx
  8007eb:	7e 3e                	jle    80082b <vprintfmt+0xe9>
  8007ed:	83 fb 39             	cmp    $0x39,%ebx
  8007f0:	7f 39                	jg     80082b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007f2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007f5:	eb d5                	jmp    8007cc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007fa:	83 c0 04             	add    $0x4,%eax
  8007fd:	89 45 14             	mov    %eax,0x14(%ebp)
  800800:	8b 45 14             	mov    0x14(%ebp),%eax
  800803:	83 e8 04             	sub    $0x4,%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80080b:	eb 1f                	jmp    80082c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80080d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800811:	79 83                	jns    800796 <vprintfmt+0x54>
				width = 0;
  800813:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80081a:	e9 77 ff ff ff       	jmp    800796 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80081f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800826:	e9 6b ff ff ff       	jmp    800796 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80082b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80082c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800830:	0f 89 60 ff ff ff    	jns    800796 <vprintfmt+0x54>
				width = precision, precision = -1;
  800836:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800839:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80083c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800843:	e9 4e ff ff ff       	jmp    800796 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800848:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80084b:	e9 46 ff ff ff       	jmp    800796 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800850:	8b 45 14             	mov    0x14(%ebp),%eax
  800853:	83 c0 04             	add    $0x4,%eax
  800856:	89 45 14             	mov    %eax,0x14(%ebp)
  800859:	8b 45 14             	mov    0x14(%ebp),%eax
  80085c:	83 e8 04             	sub    $0x4,%eax
  80085f:	8b 00                	mov    (%eax),%eax
  800861:	83 ec 08             	sub    $0x8,%esp
  800864:	ff 75 0c             	pushl  0xc(%ebp)
  800867:	50                   	push   %eax
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	ff d0                	call   *%eax
  80086d:	83 c4 10             	add    $0x10,%esp
			break;
  800870:	e9 89 02 00 00       	jmp    800afe <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800875:	8b 45 14             	mov    0x14(%ebp),%eax
  800878:	83 c0 04             	add    $0x4,%eax
  80087b:	89 45 14             	mov    %eax,0x14(%ebp)
  80087e:	8b 45 14             	mov    0x14(%ebp),%eax
  800881:	83 e8 04             	sub    $0x4,%eax
  800884:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800886:	85 db                	test   %ebx,%ebx
  800888:	79 02                	jns    80088c <vprintfmt+0x14a>
				err = -err;
  80088a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80088c:	83 fb 64             	cmp    $0x64,%ebx
  80088f:	7f 0b                	jg     80089c <vprintfmt+0x15a>
  800891:	8b 34 9d 00 24 80 00 	mov    0x802400(,%ebx,4),%esi
  800898:	85 f6                	test   %esi,%esi
  80089a:	75 19                	jne    8008b5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80089c:	53                   	push   %ebx
  80089d:	68 a5 25 80 00       	push   $0x8025a5
  8008a2:	ff 75 0c             	pushl  0xc(%ebp)
  8008a5:	ff 75 08             	pushl  0x8(%ebp)
  8008a8:	e8 5e 02 00 00       	call   800b0b <printfmt>
  8008ad:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008b0:	e9 49 02 00 00       	jmp    800afe <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008b5:	56                   	push   %esi
  8008b6:	68 ae 25 80 00       	push   $0x8025ae
  8008bb:	ff 75 0c             	pushl  0xc(%ebp)
  8008be:	ff 75 08             	pushl  0x8(%ebp)
  8008c1:	e8 45 02 00 00       	call   800b0b <printfmt>
  8008c6:	83 c4 10             	add    $0x10,%esp
			break;
  8008c9:	e9 30 02 00 00       	jmp    800afe <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d1:	83 c0 04             	add    $0x4,%eax
  8008d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8008d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008da:	83 e8 04             	sub    $0x4,%eax
  8008dd:	8b 30                	mov    (%eax),%esi
  8008df:	85 f6                	test   %esi,%esi
  8008e1:	75 05                	jne    8008e8 <vprintfmt+0x1a6>
				p = "(null)";
  8008e3:	be b1 25 80 00       	mov    $0x8025b1,%esi
			if (width > 0 && padc != '-')
  8008e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ec:	7e 6d                	jle    80095b <vprintfmt+0x219>
  8008ee:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008f2:	74 67                	je     80095b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	50                   	push   %eax
  8008fb:	56                   	push   %esi
  8008fc:	e8 0c 03 00 00       	call   800c0d <strnlen>
  800901:	83 c4 10             	add    $0x10,%esp
  800904:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800907:	eb 16                	jmp    80091f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800909:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80090d:	83 ec 08             	sub    $0x8,%esp
  800910:	ff 75 0c             	pushl  0xc(%ebp)
  800913:	50                   	push   %eax
  800914:	8b 45 08             	mov    0x8(%ebp),%eax
  800917:	ff d0                	call   *%eax
  800919:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80091c:	ff 4d e4             	decl   -0x1c(%ebp)
  80091f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800923:	7f e4                	jg     800909 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800925:	eb 34                	jmp    80095b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800927:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80092b:	74 1c                	je     800949 <vprintfmt+0x207>
  80092d:	83 fb 1f             	cmp    $0x1f,%ebx
  800930:	7e 05                	jle    800937 <vprintfmt+0x1f5>
  800932:	83 fb 7e             	cmp    $0x7e,%ebx
  800935:	7e 12                	jle    800949 <vprintfmt+0x207>
					putch('?', putdat);
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 0c             	pushl  0xc(%ebp)
  80093d:	6a 3f                	push   $0x3f
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
  800947:	eb 0f                	jmp    800958 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800949:	83 ec 08             	sub    $0x8,%esp
  80094c:	ff 75 0c             	pushl  0xc(%ebp)
  80094f:	53                   	push   %ebx
  800950:	8b 45 08             	mov    0x8(%ebp),%eax
  800953:	ff d0                	call   *%eax
  800955:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800958:	ff 4d e4             	decl   -0x1c(%ebp)
  80095b:	89 f0                	mov    %esi,%eax
  80095d:	8d 70 01             	lea    0x1(%eax),%esi
  800960:	8a 00                	mov    (%eax),%al
  800962:	0f be d8             	movsbl %al,%ebx
  800965:	85 db                	test   %ebx,%ebx
  800967:	74 24                	je     80098d <vprintfmt+0x24b>
  800969:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80096d:	78 b8                	js     800927 <vprintfmt+0x1e5>
  80096f:	ff 4d e0             	decl   -0x20(%ebp)
  800972:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800976:	79 af                	jns    800927 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800978:	eb 13                	jmp    80098d <vprintfmt+0x24b>
				putch(' ', putdat);
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 0c             	pushl  0xc(%ebp)
  800980:	6a 20                	push   $0x20
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80098a:	ff 4d e4             	decl   -0x1c(%ebp)
  80098d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800991:	7f e7                	jg     80097a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800993:	e9 66 01 00 00       	jmp    800afe <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800998:	83 ec 08             	sub    $0x8,%esp
  80099b:	ff 75 e8             	pushl  -0x18(%ebp)
  80099e:	8d 45 14             	lea    0x14(%ebp),%eax
  8009a1:	50                   	push   %eax
  8009a2:	e8 3c fd ff ff       	call   8006e3 <getint>
  8009a7:	83 c4 10             	add    $0x10,%esp
  8009aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009b6:	85 d2                	test   %edx,%edx
  8009b8:	79 23                	jns    8009dd <vprintfmt+0x29b>
				putch('-', putdat);
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	ff 75 0c             	pushl  0xc(%ebp)
  8009c0:	6a 2d                	push   $0x2d
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	ff d0                	call   *%eax
  8009c7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009d0:	f7 d8                	neg    %eax
  8009d2:	83 d2 00             	adc    $0x0,%edx
  8009d5:	f7 da                	neg    %edx
  8009d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009da:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009dd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009e4:	e9 bc 00 00 00       	jmp    800aa5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009e9:	83 ec 08             	sub    $0x8,%esp
  8009ec:	ff 75 e8             	pushl  -0x18(%ebp)
  8009ef:	8d 45 14             	lea    0x14(%ebp),%eax
  8009f2:	50                   	push   %eax
  8009f3:	e8 84 fc ff ff       	call   80067c <getuint>
  8009f8:	83 c4 10             	add    $0x10,%esp
  8009fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a08:	e9 98 00 00 00       	jmp    800aa5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a0d:	83 ec 08             	sub    $0x8,%esp
  800a10:	ff 75 0c             	pushl  0xc(%ebp)
  800a13:	6a 58                	push   $0x58
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	ff d0                	call   *%eax
  800a1a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a1d:	83 ec 08             	sub    $0x8,%esp
  800a20:	ff 75 0c             	pushl  0xc(%ebp)
  800a23:	6a 58                	push   $0x58
  800a25:	8b 45 08             	mov    0x8(%ebp),%eax
  800a28:	ff d0                	call   *%eax
  800a2a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a2d:	83 ec 08             	sub    $0x8,%esp
  800a30:	ff 75 0c             	pushl  0xc(%ebp)
  800a33:	6a 58                	push   $0x58
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	ff d0                	call   *%eax
  800a3a:	83 c4 10             	add    $0x10,%esp
			break;
  800a3d:	e9 bc 00 00 00       	jmp    800afe <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a42:	83 ec 08             	sub    $0x8,%esp
  800a45:	ff 75 0c             	pushl  0xc(%ebp)
  800a48:	6a 30                	push   $0x30
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	ff d0                	call   *%eax
  800a4f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a52:	83 ec 08             	sub    $0x8,%esp
  800a55:	ff 75 0c             	pushl  0xc(%ebp)
  800a58:	6a 78                	push   $0x78
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	ff d0                	call   *%eax
  800a5f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a62:	8b 45 14             	mov    0x14(%ebp),%eax
  800a65:	83 c0 04             	add    $0x4,%eax
  800a68:	89 45 14             	mov    %eax,0x14(%ebp)
  800a6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6e:	83 e8 04             	sub    $0x4,%eax
  800a71:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a7d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a84:	eb 1f                	jmp    800aa5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 e8             	pushl  -0x18(%ebp)
  800a8c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a8f:	50                   	push   %eax
  800a90:	e8 e7 fb ff ff       	call   80067c <getuint>
  800a95:	83 c4 10             	add    $0x10,%esp
  800a98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a9e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800aa5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800aa9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aac:	83 ec 04             	sub    $0x4,%esp
  800aaf:	52                   	push   %edx
  800ab0:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ab3:	50                   	push   %eax
  800ab4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab7:	ff 75 f0             	pushl  -0x10(%ebp)
  800aba:	ff 75 0c             	pushl  0xc(%ebp)
  800abd:	ff 75 08             	pushl  0x8(%ebp)
  800ac0:	e8 00 fb ff ff       	call   8005c5 <printnum>
  800ac5:	83 c4 20             	add    $0x20,%esp
			break;
  800ac8:	eb 34                	jmp    800afe <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800aca:	83 ec 08             	sub    $0x8,%esp
  800acd:	ff 75 0c             	pushl  0xc(%ebp)
  800ad0:	53                   	push   %ebx
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	ff d0                	call   *%eax
  800ad6:	83 c4 10             	add    $0x10,%esp
			break;
  800ad9:	eb 23                	jmp    800afe <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800adb:	83 ec 08             	sub    $0x8,%esp
  800ade:	ff 75 0c             	pushl  0xc(%ebp)
  800ae1:	6a 25                	push   $0x25
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	ff d0                	call   *%eax
  800ae8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aeb:	ff 4d 10             	decl   0x10(%ebp)
  800aee:	eb 03                	jmp    800af3 <vprintfmt+0x3b1>
  800af0:	ff 4d 10             	decl   0x10(%ebp)
  800af3:	8b 45 10             	mov    0x10(%ebp),%eax
  800af6:	48                   	dec    %eax
  800af7:	8a 00                	mov    (%eax),%al
  800af9:	3c 25                	cmp    $0x25,%al
  800afb:	75 f3                	jne    800af0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800afd:	90                   	nop
		}
	}
  800afe:	e9 47 fc ff ff       	jmp    80074a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b03:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b04:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b07:	5b                   	pop    %ebx
  800b08:	5e                   	pop    %esi
  800b09:	5d                   	pop    %ebp
  800b0a:	c3                   	ret    

00800b0b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
  800b0e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b11:	8d 45 10             	lea    0x10(%ebp),%eax
  800b14:	83 c0 04             	add    $0x4,%eax
  800b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b20:	50                   	push   %eax
  800b21:	ff 75 0c             	pushl  0xc(%ebp)
  800b24:	ff 75 08             	pushl  0x8(%ebp)
  800b27:	e8 16 fc ff ff       	call   800742 <vprintfmt>
  800b2c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b2f:	90                   	nop
  800b30:	c9                   	leave  
  800b31:	c3                   	ret    

00800b32 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b32:	55                   	push   %ebp
  800b33:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b38:	8b 40 08             	mov    0x8(%eax),%eax
  800b3b:	8d 50 01             	lea    0x1(%eax),%edx
  800b3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b41:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b47:	8b 10                	mov    (%eax),%edx
  800b49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4c:	8b 40 04             	mov    0x4(%eax),%eax
  800b4f:	39 c2                	cmp    %eax,%edx
  800b51:	73 12                	jae    800b65 <sprintputch+0x33>
		*b->buf++ = ch;
  800b53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b56:	8b 00                	mov    (%eax),%eax
  800b58:	8d 48 01             	lea    0x1(%eax),%ecx
  800b5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b5e:	89 0a                	mov    %ecx,(%edx)
  800b60:	8b 55 08             	mov    0x8(%ebp),%edx
  800b63:	88 10                	mov    %dl,(%eax)
}
  800b65:	90                   	nop
  800b66:	5d                   	pop    %ebp
  800b67:	c3                   	ret    

00800b68 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b68:	55                   	push   %ebp
  800b69:	89 e5                	mov    %esp,%ebp
  800b6b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b77:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	01 d0                	add    %edx,%eax
  800b7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b89:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b8d:	74 06                	je     800b95 <vsnprintf+0x2d>
  800b8f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b93:	7f 07                	jg     800b9c <vsnprintf+0x34>
		return -E_INVAL;
  800b95:	b8 03 00 00 00       	mov    $0x3,%eax
  800b9a:	eb 20                	jmp    800bbc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b9c:	ff 75 14             	pushl  0x14(%ebp)
  800b9f:	ff 75 10             	pushl  0x10(%ebp)
  800ba2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ba5:	50                   	push   %eax
  800ba6:	68 32 0b 80 00       	push   $0x800b32
  800bab:	e8 92 fb ff ff       	call   800742 <vprintfmt>
  800bb0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bb3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bb6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bbc:	c9                   	leave  
  800bbd:	c3                   	ret    

00800bbe <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bbe:	55                   	push   %ebp
  800bbf:	89 e5                	mov    %esp,%ebp
  800bc1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bc4:	8d 45 10             	lea    0x10(%ebp),%eax
  800bc7:	83 c0 04             	add    $0x4,%eax
  800bca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd0:	ff 75 f4             	pushl  -0xc(%ebp)
  800bd3:	50                   	push   %eax
  800bd4:	ff 75 0c             	pushl  0xc(%ebp)
  800bd7:	ff 75 08             	pushl  0x8(%ebp)
  800bda:	e8 89 ff ff ff       	call   800b68 <vsnprintf>
  800bdf:	83 c4 10             	add    $0x10,%esp
  800be2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800be5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be8:	c9                   	leave  
  800be9:	c3                   	ret    

00800bea <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bf0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bf7:	eb 06                	jmp    800bff <strlen+0x15>
		n++;
  800bf9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bfc:	ff 45 08             	incl   0x8(%ebp)
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	8a 00                	mov    (%eax),%al
  800c04:	84 c0                	test   %al,%al
  800c06:	75 f1                	jne    800bf9 <strlen+0xf>
		n++;
	return n;
  800c08:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c0b:	c9                   	leave  
  800c0c:	c3                   	ret    

00800c0d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c0d:	55                   	push   %ebp
  800c0e:	89 e5                	mov    %esp,%ebp
  800c10:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c1a:	eb 09                	jmp    800c25 <strnlen+0x18>
		n++;
  800c1c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c1f:	ff 45 08             	incl   0x8(%ebp)
  800c22:	ff 4d 0c             	decl   0xc(%ebp)
  800c25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c29:	74 09                	je     800c34 <strnlen+0x27>
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	8a 00                	mov    (%eax),%al
  800c30:	84 c0                	test   %al,%al
  800c32:	75 e8                	jne    800c1c <strnlen+0xf>
		n++;
	return n;
  800c34:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c37:	c9                   	leave  
  800c38:	c3                   	ret    

00800c39 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c39:	55                   	push   %ebp
  800c3a:	89 e5                	mov    %esp,%ebp
  800c3c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c45:	90                   	nop
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	8d 50 01             	lea    0x1(%eax),%edx
  800c4c:	89 55 08             	mov    %edx,0x8(%ebp)
  800c4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c52:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c55:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c58:	8a 12                	mov    (%edx),%dl
  800c5a:	88 10                	mov    %dl,(%eax)
  800c5c:	8a 00                	mov    (%eax),%al
  800c5e:	84 c0                	test   %al,%al
  800c60:	75 e4                	jne    800c46 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c62:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c65:	c9                   	leave  
  800c66:	c3                   	ret    

00800c67 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c67:	55                   	push   %ebp
  800c68:	89 e5                	mov    %esp,%ebp
  800c6a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c7a:	eb 1f                	jmp    800c9b <strncpy+0x34>
		*dst++ = *src;
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8d 50 01             	lea    0x1(%eax),%edx
  800c82:	89 55 08             	mov    %edx,0x8(%ebp)
  800c85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c88:	8a 12                	mov    (%edx),%dl
  800c8a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	84 c0                	test   %al,%al
  800c93:	74 03                	je     800c98 <strncpy+0x31>
			src++;
  800c95:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c98:	ff 45 fc             	incl   -0x4(%ebp)
  800c9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ca1:	72 d9                	jb     800c7c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ca3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ca6:	c9                   	leave  
  800ca7:	c3                   	ret    

00800ca8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ca8:	55                   	push   %ebp
  800ca9:	89 e5                	mov    %esp,%ebp
  800cab:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cb4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb8:	74 30                	je     800cea <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cba:	eb 16                	jmp    800cd2 <strlcpy+0x2a>
			*dst++ = *src++;
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8d 50 01             	lea    0x1(%eax),%edx
  800cc2:	89 55 08             	mov    %edx,0x8(%ebp)
  800cc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ccb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cce:	8a 12                	mov    (%edx),%dl
  800cd0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cd2:	ff 4d 10             	decl   0x10(%ebp)
  800cd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd9:	74 09                	je     800ce4 <strlcpy+0x3c>
  800cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	84 c0                	test   %al,%al
  800ce2:	75 d8                	jne    800cbc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cea:	8b 55 08             	mov    0x8(%ebp),%edx
  800ced:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf0:	29 c2                	sub    %eax,%edx
  800cf2:	89 d0                	mov    %edx,%eax
}
  800cf4:	c9                   	leave  
  800cf5:	c3                   	ret    

00800cf6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cf6:	55                   	push   %ebp
  800cf7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cf9:	eb 06                	jmp    800d01 <strcmp+0xb>
		p++, q++;
  800cfb:	ff 45 08             	incl   0x8(%ebp)
  800cfe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	8a 00                	mov    (%eax),%al
  800d06:	84 c0                	test   %al,%al
  800d08:	74 0e                	je     800d18 <strcmp+0x22>
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	8a 10                	mov    (%eax),%dl
  800d0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	38 c2                	cmp    %al,%dl
  800d16:	74 e3                	je     800cfb <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8a 00                	mov    (%eax),%al
  800d1d:	0f b6 d0             	movzbl %al,%edx
  800d20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	0f b6 c0             	movzbl %al,%eax
  800d28:	29 c2                	sub    %eax,%edx
  800d2a:	89 d0                	mov    %edx,%eax
}
  800d2c:	5d                   	pop    %ebp
  800d2d:	c3                   	ret    

00800d2e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d2e:	55                   	push   %ebp
  800d2f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d31:	eb 09                	jmp    800d3c <strncmp+0xe>
		n--, p++, q++;
  800d33:	ff 4d 10             	decl   0x10(%ebp)
  800d36:	ff 45 08             	incl   0x8(%ebp)
  800d39:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d3c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d40:	74 17                	je     800d59 <strncmp+0x2b>
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	84 c0                	test   %al,%al
  800d49:	74 0e                	je     800d59 <strncmp+0x2b>
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	8a 10                	mov    (%eax),%dl
  800d50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d53:	8a 00                	mov    (%eax),%al
  800d55:	38 c2                	cmp    %al,%dl
  800d57:	74 da                	je     800d33 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5d:	75 07                	jne    800d66 <strncmp+0x38>
		return 0;
  800d5f:	b8 00 00 00 00       	mov    $0x0,%eax
  800d64:	eb 14                	jmp    800d7a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	8a 00                	mov    (%eax),%al
  800d6b:	0f b6 d0             	movzbl %al,%edx
  800d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	0f b6 c0             	movzbl %al,%eax
  800d76:	29 c2                	sub    %eax,%edx
  800d78:	89 d0                	mov    %edx,%eax
}
  800d7a:	5d                   	pop    %ebp
  800d7b:	c3                   	ret    

00800d7c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d7c:	55                   	push   %ebp
  800d7d:	89 e5                	mov    %esp,%ebp
  800d7f:	83 ec 04             	sub    $0x4,%esp
  800d82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d85:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d88:	eb 12                	jmp    800d9c <strchr+0x20>
		if (*s == c)
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8a 00                	mov    (%eax),%al
  800d8f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d92:	75 05                	jne    800d99 <strchr+0x1d>
			return (char *) s;
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	eb 11                	jmp    800daa <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d99:	ff 45 08             	incl   0x8(%ebp)
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	84 c0                	test   %al,%al
  800da3:	75 e5                	jne    800d8a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800da5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800daa:	c9                   	leave  
  800dab:	c3                   	ret    

00800dac <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dac:	55                   	push   %ebp
  800dad:	89 e5                	mov    %esp,%ebp
  800daf:	83 ec 04             	sub    $0x4,%esp
  800db2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800db8:	eb 0d                	jmp    800dc7 <strfind+0x1b>
		if (*s == c)
  800dba:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbd:	8a 00                	mov    (%eax),%al
  800dbf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dc2:	74 0e                	je     800dd2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dc4:	ff 45 08             	incl   0x8(%ebp)
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	84 c0                	test   %al,%al
  800dce:	75 ea                	jne    800dba <strfind+0xe>
  800dd0:	eb 01                	jmp    800dd3 <strfind+0x27>
		if (*s == c)
			break;
  800dd2:	90                   	nop
	return (char *) s;
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dd6:	c9                   	leave  
  800dd7:	c3                   	ret    

00800dd8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800dd8:	55                   	push   %ebp
  800dd9:	89 e5                	mov    %esp,%ebp
  800ddb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800de4:	8b 45 10             	mov    0x10(%ebp),%eax
  800de7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dea:	eb 0e                	jmp    800dfa <memset+0x22>
		*p++ = c;
  800dec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800def:	8d 50 01             	lea    0x1(%eax),%edx
  800df2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800df5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dfa:	ff 4d f8             	decl   -0x8(%ebp)
  800dfd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e01:	79 e9                	jns    800dec <memset+0x14>
		*p++ = c;

	return v;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e06:	c9                   	leave  
  800e07:	c3                   	ret    

00800e08 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e08:	55                   	push   %ebp
  800e09:	89 e5                	mov    %esp,%ebp
  800e0b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e1a:	eb 16                	jmp    800e32 <memcpy+0x2a>
		*d++ = *s++;
  800e1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1f:	8d 50 01             	lea    0x1(%eax),%edx
  800e22:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e25:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e28:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e2b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e2e:	8a 12                	mov    (%edx),%dl
  800e30:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e32:	8b 45 10             	mov    0x10(%ebp),%eax
  800e35:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e38:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3b:	85 c0                	test   %eax,%eax
  800e3d:	75 dd                	jne    800e1c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e42:	c9                   	leave  
  800e43:	c3                   	ret    

00800e44 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e44:	55                   	push   %ebp
  800e45:	89 e5                	mov    %esp,%ebp
  800e47:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e59:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e5c:	73 50                	jae    800eae <memmove+0x6a>
  800e5e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e61:	8b 45 10             	mov    0x10(%ebp),%eax
  800e64:	01 d0                	add    %edx,%eax
  800e66:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e69:	76 43                	jbe    800eae <memmove+0x6a>
		s += n;
  800e6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e71:	8b 45 10             	mov    0x10(%ebp),%eax
  800e74:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e77:	eb 10                	jmp    800e89 <memmove+0x45>
			*--d = *--s;
  800e79:	ff 4d f8             	decl   -0x8(%ebp)
  800e7c:	ff 4d fc             	decl   -0x4(%ebp)
  800e7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e82:	8a 10                	mov    (%eax),%dl
  800e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e87:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e89:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e8f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e92:	85 c0                	test   %eax,%eax
  800e94:	75 e3                	jne    800e79 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e96:	eb 23                	jmp    800ebb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9b:	8d 50 01             	lea    0x1(%eax),%edx
  800e9e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ea4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ea7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800eaa:	8a 12                	mov    (%edx),%dl
  800eac:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800eae:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb4:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb7:	85 c0                	test   %eax,%eax
  800eb9:	75 dd                	jne    800e98 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ebe:	c9                   	leave  
  800ebf:	c3                   	ret    

00800ec0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ec0:	55                   	push   %ebp
  800ec1:	89 e5                	mov    %esp,%ebp
  800ec3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecf:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ed2:	eb 2a                	jmp    800efe <memcmp+0x3e>
		if (*s1 != *s2)
  800ed4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed7:	8a 10                	mov    (%eax),%dl
  800ed9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	38 c2                	cmp    %al,%dl
  800ee0:	74 16                	je     800ef8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ee2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	0f b6 d0             	movzbl %al,%edx
  800eea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	0f b6 c0             	movzbl %al,%eax
  800ef2:	29 c2                	sub    %eax,%edx
  800ef4:	89 d0                	mov    %edx,%eax
  800ef6:	eb 18                	jmp    800f10 <memcmp+0x50>
		s1++, s2++;
  800ef8:	ff 45 fc             	incl   -0x4(%ebp)
  800efb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800efe:	8b 45 10             	mov    0x10(%ebp),%eax
  800f01:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f04:	89 55 10             	mov    %edx,0x10(%ebp)
  800f07:	85 c0                	test   %eax,%eax
  800f09:	75 c9                	jne    800ed4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f10:	c9                   	leave  
  800f11:	c3                   	ret    

00800f12 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f12:	55                   	push   %ebp
  800f13:	89 e5                	mov    %esp,%ebp
  800f15:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f18:	8b 55 08             	mov    0x8(%ebp),%edx
  800f1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1e:	01 d0                	add    %edx,%eax
  800f20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f23:	eb 15                	jmp    800f3a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	0f b6 d0             	movzbl %al,%edx
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	0f b6 c0             	movzbl %al,%eax
  800f33:	39 c2                	cmp    %eax,%edx
  800f35:	74 0d                	je     800f44 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f37:	ff 45 08             	incl   0x8(%ebp)
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f40:	72 e3                	jb     800f25 <memfind+0x13>
  800f42:	eb 01                	jmp    800f45 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f44:	90                   	nop
	return (void *) s;
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f48:	c9                   	leave  
  800f49:	c3                   	ret    

00800f4a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f4a:	55                   	push   %ebp
  800f4b:	89 e5                	mov    %esp,%ebp
  800f4d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f57:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f5e:	eb 03                	jmp    800f63 <strtol+0x19>
		s++;
  800f60:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	3c 20                	cmp    $0x20,%al
  800f6a:	74 f4                	je     800f60 <strtol+0x16>
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3c 09                	cmp    $0x9,%al
  800f73:	74 eb                	je     800f60 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	3c 2b                	cmp    $0x2b,%al
  800f7c:	75 05                	jne    800f83 <strtol+0x39>
		s++;
  800f7e:	ff 45 08             	incl   0x8(%ebp)
  800f81:	eb 13                	jmp    800f96 <strtol+0x4c>
	else if (*s == '-')
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	3c 2d                	cmp    $0x2d,%al
  800f8a:	75 0a                	jne    800f96 <strtol+0x4c>
		s++, neg = 1;
  800f8c:	ff 45 08             	incl   0x8(%ebp)
  800f8f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f9a:	74 06                	je     800fa2 <strtol+0x58>
  800f9c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fa0:	75 20                	jne    800fc2 <strtol+0x78>
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	8a 00                	mov    (%eax),%al
  800fa7:	3c 30                	cmp    $0x30,%al
  800fa9:	75 17                	jne    800fc2 <strtol+0x78>
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	40                   	inc    %eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 78                	cmp    $0x78,%al
  800fb3:	75 0d                	jne    800fc2 <strtol+0x78>
		s += 2, base = 16;
  800fb5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fb9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fc0:	eb 28                	jmp    800fea <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc6:	75 15                	jne    800fdd <strtol+0x93>
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	3c 30                	cmp    $0x30,%al
  800fcf:	75 0c                	jne    800fdd <strtol+0x93>
		s++, base = 8;
  800fd1:	ff 45 08             	incl   0x8(%ebp)
  800fd4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fdb:	eb 0d                	jmp    800fea <strtol+0xa0>
	else if (base == 0)
  800fdd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe1:	75 07                	jne    800fea <strtol+0xa0>
		base = 10;
  800fe3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	8a 00                	mov    (%eax),%al
  800fef:	3c 2f                	cmp    $0x2f,%al
  800ff1:	7e 19                	jle    80100c <strtol+0xc2>
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 39                	cmp    $0x39,%al
  800ffa:	7f 10                	jg     80100c <strtol+0xc2>
			dig = *s - '0';
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	0f be c0             	movsbl %al,%eax
  801004:	83 e8 30             	sub    $0x30,%eax
  801007:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80100a:	eb 42                	jmp    80104e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	8a 00                	mov    (%eax),%al
  801011:	3c 60                	cmp    $0x60,%al
  801013:	7e 19                	jle    80102e <strtol+0xe4>
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	3c 7a                	cmp    $0x7a,%al
  80101c:	7f 10                	jg     80102e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	0f be c0             	movsbl %al,%eax
  801026:	83 e8 57             	sub    $0x57,%eax
  801029:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80102c:	eb 20                	jmp    80104e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	8a 00                	mov    (%eax),%al
  801033:	3c 40                	cmp    $0x40,%al
  801035:	7e 39                	jle    801070 <strtol+0x126>
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	8a 00                	mov    (%eax),%al
  80103c:	3c 5a                	cmp    $0x5a,%al
  80103e:	7f 30                	jg     801070 <strtol+0x126>
			dig = *s - 'A' + 10;
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	0f be c0             	movsbl %al,%eax
  801048:	83 e8 37             	sub    $0x37,%eax
  80104b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80104e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801051:	3b 45 10             	cmp    0x10(%ebp),%eax
  801054:	7d 19                	jge    80106f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801056:	ff 45 08             	incl   0x8(%ebp)
  801059:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801060:	89 c2                	mov    %eax,%edx
  801062:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801065:	01 d0                	add    %edx,%eax
  801067:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80106a:	e9 7b ff ff ff       	jmp    800fea <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80106f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801070:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801074:	74 08                	je     80107e <strtol+0x134>
		*endptr = (char *) s;
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	8b 55 08             	mov    0x8(%ebp),%edx
  80107c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80107e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801082:	74 07                	je     80108b <strtol+0x141>
  801084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801087:	f7 d8                	neg    %eax
  801089:	eb 03                	jmp    80108e <strtol+0x144>
  80108b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80108e:	c9                   	leave  
  80108f:	c3                   	ret    

00801090 <ltostr>:

void
ltostr(long value, char *str)
{
  801090:	55                   	push   %ebp
  801091:	89 e5                	mov    %esp,%ebp
  801093:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801096:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80109d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010a8:	79 13                	jns    8010bd <ltostr+0x2d>
	{
		neg = 1;
  8010aa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010b7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010ba:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010c5:	99                   	cltd   
  8010c6:	f7 f9                	idiv   %ecx
  8010c8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ce:	8d 50 01             	lea    0x1(%eax),%edx
  8010d1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010d4:	89 c2                	mov    %eax,%edx
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	01 d0                	add    %edx,%eax
  8010db:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010de:	83 c2 30             	add    $0x30,%edx
  8010e1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010e6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010eb:	f7 e9                	imul   %ecx
  8010ed:	c1 fa 02             	sar    $0x2,%edx
  8010f0:	89 c8                	mov    %ecx,%eax
  8010f2:	c1 f8 1f             	sar    $0x1f,%eax
  8010f5:	29 c2                	sub    %eax,%edx
  8010f7:	89 d0                	mov    %edx,%eax
  8010f9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ff:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801104:	f7 e9                	imul   %ecx
  801106:	c1 fa 02             	sar    $0x2,%edx
  801109:	89 c8                	mov    %ecx,%eax
  80110b:	c1 f8 1f             	sar    $0x1f,%eax
  80110e:	29 c2                	sub    %eax,%edx
  801110:	89 d0                	mov    %edx,%eax
  801112:	c1 e0 02             	shl    $0x2,%eax
  801115:	01 d0                	add    %edx,%eax
  801117:	01 c0                	add    %eax,%eax
  801119:	29 c1                	sub    %eax,%ecx
  80111b:	89 ca                	mov    %ecx,%edx
  80111d:	85 d2                	test   %edx,%edx
  80111f:	75 9c                	jne    8010bd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801121:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801128:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80112b:	48                   	dec    %eax
  80112c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80112f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801133:	74 3d                	je     801172 <ltostr+0xe2>
		start = 1 ;
  801135:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80113c:	eb 34                	jmp    801172 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80113e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801141:	8b 45 0c             	mov    0xc(%ebp),%eax
  801144:	01 d0                	add    %edx,%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80114b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80114e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801151:	01 c2                	add    %eax,%edx
  801153:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	01 c8                	add    %ecx,%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80115f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801162:	8b 45 0c             	mov    0xc(%ebp),%eax
  801165:	01 c2                	add    %eax,%edx
  801167:	8a 45 eb             	mov    -0x15(%ebp),%al
  80116a:	88 02                	mov    %al,(%edx)
		start++ ;
  80116c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80116f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801172:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801175:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801178:	7c c4                	jl     80113e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80117a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80117d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801180:	01 d0                	add    %edx,%eax
  801182:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801185:	90                   	nop
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80118e:	ff 75 08             	pushl  0x8(%ebp)
  801191:	e8 54 fa ff ff       	call   800bea <strlen>
  801196:	83 c4 04             	add    $0x4,%esp
  801199:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80119c:	ff 75 0c             	pushl  0xc(%ebp)
  80119f:	e8 46 fa ff ff       	call   800bea <strlen>
  8011a4:	83 c4 04             	add    $0x4,%esp
  8011a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011b8:	eb 17                	jmp    8011d1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c0:	01 c2                	add    %eax,%edx
  8011c2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	01 c8                	add    %ecx,%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011ce:	ff 45 fc             	incl   -0x4(%ebp)
  8011d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011d7:	7c e1                	jl     8011ba <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011d9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011e7:	eb 1f                	jmp    801208 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ec:	8d 50 01             	lea    0x1(%eax),%edx
  8011ef:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f2:	89 c2                	mov    %eax,%edx
  8011f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f7:	01 c2                	add    %eax,%edx
  8011f9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ff:	01 c8                	add    %ecx,%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801205:	ff 45 f8             	incl   -0x8(%ebp)
  801208:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80120e:	7c d9                	jl     8011e9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801210:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801213:	8b 45 10             	mov    0x10(%ebp),%eax
  801216:	01 d0                	add    %edx,%eax
  801218:	c6 00 00             	movb   $0x0,(%eax)
}
  80121b:	90                   	nop
  80121c:	c9                   	leave  
  80121d:	c3                   	ret    

0080121e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80122a:	8b 45 14             	mov    0x14(%ebp),%eax
  80122d:	8b 00                	mov    (%eax),%eax
  80122f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801236:	8b 45 10             	mov    0x10(%ebp),%eax
  801239:	01 d0                	add    %edx,%eax
  80123b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801241:	eb 0c                	jmp    80124f <strsplit+0x31>
			*string++ = 0;
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	8d 50 01             	lea    0x1(%eax),%edx
  801249:	89 55 08             	mov    %edx,0x8(%ebp)
  80124c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	84 c0                	test   %al,%al
  801256:	74 18                	je     801270 <strsplit+0x52>
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	8a 00                	mov    (%eax),%al
  80125d:	0f be c0             	movsbl %al,%eax
  801260:	50                   	push   %eax
  801261:	ff 75 0c             	pushl  0xc(%ebp)
  801264:	e8 13 fb ff ff       	call   800d7c <strchr>
  801269:	83 c4 08             	add    $0x8,%esp
  80126c:	85 c0                	test   %eax,%eax
  80126e:	75 d3                	jne    801243 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801270:	8b 45 08             	mov    0x8(%ebp),%eax
  801273:	8a 00                	mov    (%eax),%al
  801275:	84 c0                	test   %al,%al
  801277:	74 5a                	je     8012d3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801279:	8b 45 14             	mov    0x14(%ebp),%eax
  80127c:	8b 00                	mov    (%eax),%eax
  80127e:	83 f8 0f             	cmp    $0xf,%eax
  801281:	75 07                	jne    80128a <strsplit+0x6c>
		{
			return 0;
  801283:	b8 00 00 00 00       	mov    $0x0,%eax
  801288:	eb 66                	jmp    8012f0 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80128a:	8b 45 14             	mov    0x14(%ebp),%eax
  80128d:	8b 00                	mov    (%eax),%eax
  80128f:	8d 48 01             	lea    0x1(%eax),%ecx
  801292:	8b 55 14             	mov    0x14(%ebp),%edx
  801295:	89 0a                	mov    %ecx,(%edx)
  801297:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80129e:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a1:	01 c2                	add    %eax,%edx
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012a8:	eb 03                	jmp    8012ad <strsplit+0x8f>
			string++;
  8012aa:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	84 c0                	test   %al,%al
  8012b4:	74 8b                	je     801241 <strsplit+0x23>
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	0f be c0             	movsbl %al,%eax
  8012be:	50                   	push   %eax
  8012bf:	ff 75 0c             	pushl  0xc(%ebp)
  8012c2:	e8 b5 fa ff ff       	call   800d7c <strchr>
  8012c7:	83 c4 08             	add    $0x8,%esp
  8012ca:	85 c0                	test   %eax,%eax
  8012cc:	74 dc                	je     8012aa <strsplit+0x8c>
			string++;
	}
  8012ce:	e9 6e ff ff ff       	jmp    801241 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012d3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012d7:	8b 00                	mov    (%eax),%eax
  8012d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e3:	01 d0                	add    %edx,%eax
  8012e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012eb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012f0:	c9                   	leave  
  8012f1:	c3                   	ret    

008012f2 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  8012f2:	55                   	push   %ebp
  8012f3:	89 e5                	mov    %esp,%ebp
  8012f5:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	c1 e8 0c             	shr    $0xc,%eax
  8012fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	25 ff 0f 00 00       	and    $0xfff,%eax
  801309:	85 c0                	test   %eax,%eax
  80130b:	74 03                	je     801310 <malloc+0x1e>
		num++;
  80130d:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  801310:	a1 28 30 80 00       	mov    0x803028,%eax
  801315:	85 c0                	test   %eax,%eax
  801317:	75 71                	jne    80138a <malloc+0x98>
		sys_allocateMem(last_addres, size);
  801319:	a1 04 30 80 00       	mov    0x803004,%eax
  80131e:	83 ec 08             	sub    $0x8,%esp
  801321:	ff 75 08             	pushl  0x8(%ebp)
  801324:	50                   	push   %eax
  801325:	e8 e4 04 00 00       	call   80180e <sys_allocateMem>
  80132a:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  80132d:	a1 04 30 80 00       	mov    0x803004,%eax
  801332:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801335:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801338:	c1 e0 0c             	shl    $0xc,%eax
  80133b:	89 c2                	mov    %eax,%edx
  80133d:	a1 04 30 80 00       	mov    0x803004,%eax
  801342:	01 d0                	add    %edx,%eax
  801344:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801349:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80134e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801351:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801358:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80135d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801360:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801367:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80136c:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801373:	01 00 00 00 
		sizeofarray++;
  801377:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80137c:	40                   	inc    %eax
  80137d:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  801382:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801385:	e9 f7 00 00 00       	jmp    801481 <malloc+0x18f>
	} else {
		int count = 0;
  80138a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  801391:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801398:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80139f:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8013a6:	eb 7c                	jmp    801424 <malloc+0x132>
		{
			uint32 *pg = NULL;
  8013a8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  8013af:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8013b6:	eb 1a                	jmp    8013d2 <malloc+0xe0>
				if (addresses[j] == i) {
  8013b8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013bb:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8013c2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8013c5:	75 08                	jne    8013cf <malloc+0xdd>
					index = j;
  8013c7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  8013cd:	eb 0d                	jmp    8013dc <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  8013cf:	ff 45 dc             	incl   -0x24(%ebp)
  8013d2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013d7:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8013da:	7c dc                	jl     8013b8 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  8013dc:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8013e0:	75 05                	jne    8013e7 <malloc+0xf5>
				count++;
  8013e2:	ff 45 f0             	incl   -0x10(%ebp)
  8013e5:	eb 36                	jmp    80141d <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  8013e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013ea:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8013f1:	85 c0                	test   %eax,%eax
  8013f3:	75 05                	jne    8013fa <malloc+0x108>
					count++;
  8013f5:	ff 45 f0             	incl   -0x10(%ebp)
  8013f8:	eb 23                	jmp    80141d <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  8013fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013fd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801400:	7d 14                	jge    801416 <malloc+0x124>
  801402:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801405:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801408:	7c 0c                	jl     801416 <malloc+0x124>
						min = count;
  80140a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80140d:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  801410:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801413:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  801416:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80141d:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801424:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80142b:	0f 86 77 ff ff ff    	jbe    8013a8 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  801431:	83 ec 08             	sub    $0x8,%esp
  801434:	ff 75 08             	pushl  0x8(%ebp)
  801437:	ff 75 e4             	pushl  -0x1c(%ebp)
  80143a:	e8 cf 03 00 00       	call   80180e <sys_allocateMem>
  80143f:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  801442:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801447:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80144a:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  801451:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801456:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80145c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801463:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801468:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80146f:	01 00 00 00 
		sizeofarray++;
  801473:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801478:	40                   	inc    %eax
  801479:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) min_addresss;
  80147e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
  801486:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  80148f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801496:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80149d:	eb 30                	jmp    8014cf <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  80149f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014a2:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8014a9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8014ac:	75 1e                	jne    8014cc <free+0x49>
  8014ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014b1:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8014b8:	83 f8 01             	cmp    $0x1,%eax
  8014bb:	75 0f                	jne    8014cc <free+0x49>
			is_found = 1;
  8014bd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8014c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8014ca:	eb 0d                	jmp    8014d9 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8014cc:	ff 45 ec             	incl   -0x14(%ebp)
  8014cf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014d4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8014d7:	7c c6                	jl     80149f <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8014d9:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8014dd:	75 4f                	jne    80152e <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  8014df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014e2:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8014e9:	c1 e0 0c             	shl    $0xc,%eax
  8014ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  8014ef:	83 ec 08             	sub    $0x8,%esp
  8014f2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8014f5:	68 10 27 80 00       	push   $0x802710
  8014fa:	e8 69 f0 ff ff       	call   800568 <cprintf>
  8014ff:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801502:	83 ec 08             	sub    $0x8,%esp
  801505:	ff 75 e4             	pushl  -0x1c(%ebp)
  801508:	ff 75 e8             	pushl  -0x18(%ebp)
  80150b:	e8 e2 02 00 00       	call   8017f2 <sys_freeMem>
  801510:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801513:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801516:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  80151d:	00 00 00 00 
		changes++;
  801521:	a1 28 30 80 00       	mov    0x803028,%eax
  801526:	40                   	inc    %eax
  801527:	a3 28 30 80 00       	mov    %eax,0x803028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  80152c:	eb 39                	jmp    801567 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  80152e:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801535:	83 ec 08             	sub    $0x8,%esp
  801538:	ff 75 e4             	pushl  -0x1c(%ebp)
  80153b:	68 10 27 80 00       	push   $0x802710
  801540:	e8 23 f0 ff ff       	call   800568 <cprintf>
  801545:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801548:	83 ec 08             	sub    $0x8,%esp
  80154b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80154e:	ff 75 e8             	pushl  -0x18(%ebp)
  801551:	e8 9c 02 00 00       	call   8017f2 <sys_freeMem>
  801556:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801559:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80155c:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801563:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801567:	90                   	nop
  801568:	c9                   	leave  
  801569:	c3                   	ret    

0080156a <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  80156a:	55                   	push   %ebp
  80156b:	89 e5                	mov    %esp,%ebp
  80156d:	83 ec 18             	sub    $0x18,%esp
  801570:	8b 45 10             	mov    0x10(%ebp),%eax
  801573:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801576:	83 ec 04             	sub    $0x4,%esp
  801579:	68 30 27 80 00       	push   $0x802730
  80157e:	68 9d 00 00 00       	push   $0x9d
  801583:	68 53 27 80 00       	push   $0x802753
  801588:	e8 39 ed ff ff       	call   8002c6 <_panic>

0080158d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  80158d:	55                   	push   %ebp
  80158e:	89 e5                	mov    %esp,%ebp
  801590:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801593:	83 ec 04             	sub    $0x4,%esp
  801596:	68 30 27 80 00       	push   $0x802730
  80159b:	68 a2 00 00 00       	push   $0xa2
  8015a0:	68 53 27 80 00       	push   $0x802753
  8015a5:	e8 1c ed ff ff       	call   8002c6 <_panic>

008015aa <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015b0:	83 ec 04             	sub    $0x4,%esp
  8015b3:	68 30 27 80 00       	push   $0x802730
  8015b8:	68 a7 00 00 00       	push   $0xa7
  8015bd:	68 53 27 80 00       	push   $0x802753
  8015c2:	e8 ff ec ff ff       	call   8002c6 <_panic>

008015c7 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
  8015ca:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015cd:	83 ec 04             	sub    $0x4,%esp
  8015d0:	68 30 27 80 00       	push   $0x802730
  8015d5:	68 ab 00 00 00       	push   $0xab
  8015da:	68 53 27 80 00       	push   $0x802753
  8015df:	e8 e2 ec ff ff       	call   8002c6 <_panic>

008015e4 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8015e4:	55                   	push   %ebp
  8015e5:	89 e5                	mov    %esp,%ebp
  8015e7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015ea:	83 ec 04             	sub    $0x4,%esp
  8015ed:	68 30 27 80 00       	push   $0x802730
  8015f2:	68 b0 00 00 00       	push   $0xb0
  8015f7:	68 53 27 80 00       	push   $0x802753
  8015fc:	e8 c5 ec ff ff       	call   8002c6 <_panic>

00801601 <shrink>:
}
void shrink(uint32 newSize) {
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
  801604:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801607:	83 ec 04             	sub    $0x4,%esp
  80160a:	68 30 27 80 00       	push   $0x802730
  80160f:	68 b3 00 00 00       	push   $0xb3
  801614:	68 53 27 80 00       	push   $0x802753
  801619:	e8 a8 ec ff ff       	call   8002c6 <_panic>

0080161e <freeHeap>:
}

void freeHeap(void* virtual_address) {
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
  801621:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801624:	83 ec 04             	sub    $0x4,%esp
  801627:	68 30 27 80 00       	push   $0x802730
  80162c:	68 b7 00 00 00       	push   $0xb7
  801631:	68 53 27 80 00       	push   $0x802753
  801636:	e8 8b ec ff ff       	call   8002c6 <_panic>

0080163b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
  80163e:	57                   	push   %edi
  80163f:	56                   	push   %esi
  801640:	53                   	push   %ebx
  801641:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	8b 55 0c             	mov    0xc(%ebp),%edx
  80164a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80164d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801650:	8b 7d 18             	mov    0x18(%ebp),%edi
  801653:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801656:	cd 30                	int    $0x30
  801658:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80165b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80165e:	83 c4 10             	add    $0x10,%esp
  801661:	5b                   	pop    %ebx
  801662:	5e                   	pop    %esi
  801663:	5f                   	pop    %edi
  801664:	5d                   	pop    %ebp
  801665:	c3                   	ret    

00801666 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
  801669:	83 ec 04             	sub    $0x4,%esp
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801672:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	52                   	push   %edx
  80167e:	ff 75 0c             	pushl  0xc(%ebp)
  801681:	50                   	push   %eax
  801682:	6a 00                	push   $0x0
  801684:	e8 b2 ff ff ff       	call   80163b <syscall>
  801689:	83 c4 18             	add    $0x18,%esp
}
  80168c:	90                   	nop
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <sys_cgetc>:

int
sys_cgetc(void)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 01                	push   $0x1
  80169e:	e8 98 ff ff ff       	call   80163b <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	c9                   	leave  
  8016a7:	c3                   	ret    

008016a8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	50                   	push   %eax
  8016b7:	6a 05                	push   $0x5
  8016b9:	e8 7d ff ff ff       	call   80163b <syscall>
  8016be:	83 c4 18             	add    $0x18,%esp
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    

008016c3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 02                	push   $0x2
  8016d2:	e8 64 ff ff ff       	call   80163b <syscall>
  8016d7:	83 c4 18             	add    $0x18,%esp
}
  8016da:	c9                   	leave  
  8016db:	c3                   	ret    

008016dc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016dc:	55                   	push   %ebp
  8016dd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 03                	push   $0x3
  8016eb:	e8 4b ff ff ff       	call   80163b <syscall>
  8016f0:	83 c4 18             	add    $0x18,%esp
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 04                	push   $0x4
  801704:	e8 32 ff ff ff       	call   80163b <syscall>
  801709:	83 c4 18             	add    $0x18,%esp
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_env_exit>:


void sys_env_exit(void)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 06                	push   $0x6
  80171d:	e8 19 ff ff ff       	call   80163b <syscall>
  801722:	83 c4 18             	add    $0x18,%esp
}
  801725:	90                   	nop
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80172b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172e:	8b 45 08             	mov    0x8(%ebp),%eax
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	52                   	push   %edx
  801738:	50                   	push   %eax
  801739:	6a 07                	push   $0x7
  80173b:	e8 fb fe ff ff       	call   80163b <syscall>
  801740:	83 c4 18             	add    $0x18,%esp
}
  801743:	c9                   	leave  
  801744:	c3                   	ret    

00801745 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801745:	55                   	push   %ebp
  801746:	89 e5                	mov    %esp,%ebp
  801748:	56                   	push   %esi
  801749:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80174a:	8b 75 18             	mov    0x18(%ebp),%esi
  80174d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801750:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801753:	8b 55 0c             	mov    0xc(%ebp),%edx
  801756:	8b 45 08             	mov    0x8(%ebp),%eax
  801759:	56                   	push   %esi
  80175a:	53                   	push   %ebx
  80175b:	51                   	push   %ecx
  80175c:	52                   	push   %edx
  80175d:	50                   	push   %eax
  80175e:	6a 08                	push   $0x8
  801760:	e8 d6 fe ff ff       	call   80163b <syscall>
  801765:	83 c4 18             	add    $0x18,%esp
}
  801768:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80176b:	5b                   	pop    %ebx
  80176c:	5e                   	pop    %esi
  80176d:	5d                   	pop    %ebp
  80176e:	c3                   	ret    

0080176f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801772:	8b 55 0c             	mov    0xc(%ebp),%edx
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	52                   	push   %edx
  80177f:	50                   	push   %eax
  801780:	6a 09                	push   $0x9
  801782:	e8 b4 fe ff ff       	call   80163b <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	ff 75 0c             	pushl  0xc(%ebp)
  801798:	ff 75 08             	pushl  0x8(%ebp)
  80179b:	6a 0a                	push   $0xa
  80179d:	e8 99 fe ff ff       	call   80163b <syscall>
  8017a2:	83 c4 18             	add    $0x18,%esp
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 0b                	push   $0xb
  8017b6:	e8 80 fe ff ff       	call   80163b <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 0c                	push   $0xc
  8017cf:	e8 67 fe ff ff       	call   80163b <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 0d                	push   $0xd
  8017e8:	e8 4e fe ff ff       	call   80163b <syscall>
  8017ed:	83 c4 18             	add    $0x18,%esp
}
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	ff 75 0c             	pushl  0xc(%ebp)
  8017fe:	ff 75 08             	pushl  0x8(%ebp)
  801801:	6a 11                	push   $0x11
  801803:	e8 33 fe ff ff       	call   80163b <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
	return;
  80180b:	90                   	nop
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	ff 75 0c             	pushl  0xc(%ebp)
  80181a:	ff 75 08             	pushl  0x8(%ebp)
  80181d:	6a 12                	push   $0x12
  80181f:	e8 17 fe ff ff       	call   80163b <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
	return ;
  801827:	90                   	nop
}
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 0e                	push   $0xe
  801839:	e8 fd fd ff ff       	call   80163b <syscall>
  80183e:	83 c4 18             	add    $0x18,%esp
}
  801841:	c9                   	leave  
  801842:	c3                   	ret    

00801843 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	ff 75 08             	pushl  0x8(%ebp)
  801851:	6a 0f                	push   $0xf
  801853:	e8 e3 fd ff ff       	call   80163b <syscall>
  801858:	83 c4 18             	add    $0x18,%esp
}
  80185b:	c9                   	leave  
  80185c:	c3                   	ret    

0080185d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80185d:	55                   	push   %ebp
  80185e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 10                	push   $0x10
  80186c:	e8 ca fd ff ff       	call   80163b <syscall>
  801871:	83 c4 18             	add    $0x18,%esp
}
  801874:	90                   	nop
  801875:	c9                   	leave  
  801876:	c3                   	ret    

00801877 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 14                	push   $0x14
  801886:	e8 b0 fd ff ff       	call   80163b <syscall>
  80188b:	83 c4 18             	add    $0x18,%esp
}
  80188e:	90                   	nop
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 15                	push   $0x15
  8018a0:	e8 96 fd ff ff       	call   80163b <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
}
  8018a8:	90                   	nop
  8018a9:	c9                   	leave  
  8018aa:	c3                   	ret    

008018ab <sys_cputc>:


void
sys_cputc(const char c)
{
  8018ab:	55                   	push   %ebp
  8018ac:	89 e5                	mov    %esp,%ebp
  8018ae:	83 ec 04             	sub    $0x4,%esp
  8018b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8018b7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	50                   	push   %eax
  8018c4:	6a 16                	push   $0x16
  8018c6:	e8 70 fd ff ff       	call   80163b <syscall>
  8018cb:	83 c4 18             	add    $0x18,%esp
}
  8018ce:	90                   	nop
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 17                	push   $0x17
  8018e0:	e8 56 fd ff ff       	call   80163b <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	90                   	nop
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	ff 75 0c             	pushl  0xc(%ebp)
  8018fa:	50                   	push   %eax
  8018fb:	6a 18                	push   $0x18
  8018fd:	e8 39 fd ff ff       	call   80163b <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80190a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	52                   	push   %edx
  801917:	50                   	push   %eax
  801918:	6a 1b                	push   $0x1b
  80191a:	e8 1c fd ff ff       	call   80163b <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801927:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192a:	8b 45 08             	mov    0x8(%ebp),%eax
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	52                   	push   %edx
  801934:	50                   	push   %eax
  801935:	6a 19                	push   $0x19
  801937:	e8 ff fc ff ff       	call   80163b <syscall>
  80193c:	83 c4 18             	add    $0x18,%esp
}
  80193f:	90                   	nop
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801945:	8b 55 0c             	mov    0xc(%ebp),%edx
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	52                   	push   %edx
  801952:	50                   	push   %eax
  801953:	6a 1a                	push   $0x1a
  801955:	e8 e1 fc ff ff       	call   80163b <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
}
  80195d:	90                   	nop
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
  801963:	83 ec 04             	sub    $0x4,%esp
  801966:	8b 45 10             	mov    0x10(%ebp),%eax
  801969:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80196c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80196f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801973:	8b 45 08             	mov    0x8(%ebp),%eax
  801976:	6a 00                	push   $0x0
  801978:	51                   	push   %ecx
  801979:	52                   	push   %edx
  80197a:	ff 75 0c             	pushl  0xc(%ebp)
  80197d:	50                   	push   %eax
  80197e:	6a 1c                	push   $0x1c
  801980:	e8 b6 fc ff ff       	call   80163b <syscall>
  801985:	83 c4 18             	add    $0x18,%esp
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80198d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801990:	8b 45 08             	mov    0x8(%ebp),%eax
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	52                   	push   %edx
  80199a:	50                   	push   %eax
  80199b:	6a 1d                	push   $0x1d
  80199d:	e8 99 fc ff ff       	call   80163b <syscall>
  8019a2:	83 c4 18             	add    $0x18,%esp
}
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8019aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	51                   	push   %ecx
  8019b8:	52                   	push   %edx
  8019b9:	50                   	push   %eax
  8019ba:	6a 1e                	push   $0x1e
  8019bc:	e8 7a fc ff ff       	call   80163b <syscall>
  8019c1:	83 c4 18             	add    $0x18,%esp
}
  8019c4:	c9                   	leave  
  8019c5:	c3                   	ret    

008019c6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8019c6:	55                   	push   %ebp
  8019c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8019c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	52                   	push   %edx
  8019d6:	50                   	push   %eax
  8019d7:	6a 1f                	push   $0x1f
  8019d9:	e8 5d fc ff ff       	call   80163b <syscall>
  8019de:	83 c4 18             	add    $0x18,%esp
}
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 20                	push   $0x20
  8019f2:	e8 44 fc ff ff       	call   80163b <syscall>
  8019f7:	83 c4 18             	add    $0x18,%esp
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	6a 00                	push   $0x0
  801a04:	ff 75 14             	pushl  0x14(%ebp)
  801a07:	ff 75 10             	pushl  0x10(%ebp)
  801a0a:	ff 75 0c             	pushl  0xc(%ebp)
  801a0d:	50                   	push   %eax
  801a0e:	6a 21                	push   $0x21
  801a10:	e8 26 fc ff ff       	call   80163b <syscall>
  801a15:	83 c4 18             	add    $0x18,%esp
}
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	50                   	push   %eax
  801a29:	6a 22                	push   $0x22
  801a2b:	e8 0b fc ff ff       	call   80163b <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a39:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	50                   	push   %eax
  801a45:	6a 23                	push   $0x23
  801a47:	e8 ef fb ff ff       	call   80163b <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
}
  801a4f:	90                   	nop
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a58:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a5b:	8d 50 04             	lea    0x4(%eax),%edx
  801a5e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	52                   	push   %edx
  801a68:	50                   	push   %eax
  801a69:	6a 24                	push   $0x24
  801a6b:	e8 cb fb ff ff       	call   80163b <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
	return result;
  801a73:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a76:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a79:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a7c:	89 01                	mov    %eax,(%ecx)
  801a7e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	c9                   	leave  
  801a85:	c2 04 00             	ret    $0x4

00801a88 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	ff 75 10             	pushl  0x10(%ebp)
  801a92:	ff 75 0c             	pushl  0xc(%ebp)
  801a95:	ff 75 08             	pushl  0x8(%ebp)
  801a98:	6a 13                	push   $0x13
  801a9a:	e8 9c fb ff ff       	call   80163b <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa2:	90                   	nop
}
  801aa3:	c9                   	leave  
  801aa4:	c3                   	ret    

00801aa5 <sys_rcr2>:
uint32 sys_rcr2()
{
  801aa5:	55                   	push   %ebp
  801aa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 25                	push   $0x25
  801ab4:	e8 82 fb ff ff       	call   80163b <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
}
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
  801ac1:	83 ec 04             	sub    $0x4,%esp
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801aca:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	50                   	push   %eax
  801ad7:	6a 26                	push   $0x26
  801ad9:	e8 5d fb ff ff       	call   80163b <syscall>
  801ade:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae1:	90                   	nop
}
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <rsttst>:
void rsttst()
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 28                	push   $0x28
  801af3:	e8 43 fb ff ff       	call   80163b <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
	return ;
  801afb:	90                   	nop
}
  801afc:	c9                   	leave  
  801afd:	c3                   	ret    

00801afe <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
  801b01:	83 ec 04             	sub    $0x4,%esp
  801b04:	8b 45 14             	mov    0x14(%ebp),%eax
  801b07:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b0a:	8b 55 18             	mov    0x18(%ebp),%edx
  801b0d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b11:	52                   	push   %edx
  801b12:	50                   	push   %eax
  801b13:	ff 75 10             	pushl  0x10(%ebp)
  801b16:	ff 75 0c             	pushl  0xc(%ebp)
  801b19:	ff 75 08             	pushl  0x8(%ebp)
  801b1c:	6a 27                	push   $0x27
  801b1e:	e8 18 fb ff ff       	call   80163b <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
	return ;
  801b26:	90                   	nop
}
  801b27:	c9                   	leave  
  801b28:	c3                   	ret    

00801b29 <chktst>:
void chktst(uint32 n)
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	ff 75 08             	pushl  0x8(%ebp)
  801b37:	6a 29                	push   $0x29
  801b39:	e8 fd fa ff ff       	call   80163b <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
	return ;
  801b41:	90                   	nop
}
  801b42:	c9                   	leave  
  801b43:	c3                   	ret    

00801b44 <inctst>:

void inctst()
{
  801b44:	55                   	push   %ebp
  801b45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 2a                	push   $0x2a
  801b53:	e8 e3 fa ff ff       	call   80163b <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5b:	90                   	nop
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <gettst>:
uint32 gettst()
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 2b                	push   $0x2b
  801b6d:	e8 c9 fa ff ff       	call   80163b <syscall>
  801b72:	83 c4 18             	add    $0x18,%esp
}
  801b75:	c9                   	leave  
  801b76:	c3                   	ret    

00801b77 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
  801b7a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 2c                	push   $0x2c
  801b89:	e8 ad fa ff ff       	call   80163b <syscall>
  801b8e:	83 c4 18             	add    $0x18,%esp
  801b91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b94:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b98:	75 07                	jne    801ba1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b9f:	eb 05                	jmp    801ba6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ba1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
  801bab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 2c                	push   $0x2c
  801bba:	e8 7c fa ff ff       	call   80163b <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
  801bc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801bc5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801bc9:	75 07                	jne    801bd2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801bcb:	b8 01 00 00 00       	mov    $0x1,%eax
  801bd0:	eb 05                	jmp    801bd7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801bd2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
  801bdc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 2c                	push   $0x2c
  801beb:	e8 4b fa ff ff       	call   80163b <syscall>
  801bf0:	83 c4 18             	add    $0x18,%esp
  801bf3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bf6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bfa:	75 07                	jne    801c03 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bfc:	b8 01 00 00 00       	mov    $0x1,%eax
  801c01:	eb 05                	jmp    801c08 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 2c                	push   $0x2c
  801c1c:	e8 1a fa ff ff       	call   80163b <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
  801c24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c27:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c2b:	75 07                	jne    801c34 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c2d:	b8 01 00 00 00       	mov    $0x1,%eax
  801c32:	eb 05                	jmp    801c39 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c34:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c39:	c9                   	leave  
  801c3a:	c3                   	ret    

00801c3b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	ff 75 08             	pushl  0x8(%ebp)
  801c49:	6a 2d                	push   $0x2d
  801c4b:	e8 eb f9 ff ff       	call   80163b <syscall>
  801c50:	83 c4 18             	add    $0x18,%esp
	return ;
  801c53:	90                   	nop
}
  801c54:	c9                   	leave  
  801c55:	c3                   	ret    

00801c56 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
  801c59:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801c5a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c63:	8b 45 08             	mov    0x8(%ebp),%eax
  801c66:	6a 00                	push   $0x0
  801c68:	53                   	push   %ebx
  801c69:	51                   	push   %ecx
  801c6a:	52                   	push   %edx
  801c6b:	50                   	push   %eax
  801c6c:	6a 2e                	push   $0x2e
  801c6e:	e8 c8 f9 ff ff       	call   80163b <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
}
  801c76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c79:	c9                   	leave  
  801c7a:	c3                   	ret    

00801c7b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c7b:	55                   	push   %ebp
  801c7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c81:	8b 45 08             	mov    0x8(%ebp),%eax
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	52                   	push   %edx
  801c8b:	50                   	push   %eax
  801c8c:	6a 2f                	push   $0x2f
  801c8e:	e8 a8 f9 ff ff       	call   80163b <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
}
  801c96:	c9                   	leave  
  801c97:	c3                   	ret    

00801c98 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
  801c9b:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c9e:	8b 55 08             	mov    0x8(%ebp),%edx
  801ca1:	89 d0                	mov    %edx,%eax
  801ca3:	c1 e0 02             	shl    $0x2,%eax
  801ca6:	01 d0                	add    %edx,%eax
  801ca8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801caf:	01 d0                	add    %edx,%eax
  801cb1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cb8:	01 d0                	add    %edx,%eax
  801cba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cc1:	01 d0                	add    %edx,%eax
  801cc3:	c1 e0 04             	shl    $0x4,%eax
  801cc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801cc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801cd0:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801cd3:	83 ec 0c             	sub    $0xc,%esp
  801cd6:	50                   	push   %eax
  801cd7:	e8 76 fd ff ff       	call   801a52 <sys_get_virtual_time>
  801cdc:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801cdf:	eb 41                	jmp    801d22 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801ce1:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801ce4:	83 ec 0c             	sub    $0xc,%esp
  801ce7:	50                   	push   %eax
  801ce8:	e8 65 fd ff ff       	call   801a52 <sys_get_virtual_time>
  801ced:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801cf0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cf3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cf6:	29 c2                	sub    %eax,%edx
  801cf8:	89 d0                	mov    %edx,%eax
  801cfa:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801cfd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801d00:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d03:	89 d1                	mov    %edx,%ecx
  801d05:	29 c1                	sub    %eax,%ecx
  801d07:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801d0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d0d:	39 c2                	cmp    %eax,%edx
  801d0f:	0f 97 c0             	seta   %al
  801d12:	0f b6 c0             	movzbl %al,%eax
  801d15:	29 c1                	sub    %eax,%ecx
  801d17:	89 c8                	mov    %ecx,%eax
  801d19:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801d1c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d25:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d28:	72 b7                	jb     801ce1 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801d2a:	90                   	nop
  801d2b:	c9                   	leave  
  801d2c:	c3                   	ret    

00801d2d <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801d2d:	55                   	push   %ebp
  801d2e:	89 e5                	mov    %esp,%ebp
  801d30:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801d33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801d3a:	eb 03                	jmp    801d3f <busy_wait+0x12>
  801d3c:	ff 45 fc             	incl   -0x4(%ebp)
  801d3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d42:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d45:	72 f5                	jb     801d3c <busy_wait+0xf>
	return i;
  801d47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d4a:	c9                   	leave  
  801d4b:	c3                   	ret    

00801d4c <__udivdi3>:
  801d4c:	55                   	push   %ebp
  801d4d:	57                   	push   %edi
  801d4e:	56                   	push   %esi
  801d4f:	53                   	push   %ebx
  801d50:	83 ec 1c             	sub    $0x1c,%esp
  801d53:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d57:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d5b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d5f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d63:	89 ca                	mov    %ecx,%edx
  801d65:	89 f8                	mov    %edi,%eax
  801d67:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d6b:	85 f6                	test   %esi,%esi
  801d6d:	75 2d                	jne    801d9c <__udivdi3+0x50>
  801d6f:	39 cf                	cmp    %ecx,%edi
  801d71:	77 65                	ja     801dd8 <__udivdi3+0x8c>
  801d73:	89 fd                	mov    %edi,%ebp
  801d75:	85 ff                	test   %edi,%edi
  801d77:	75 0b                	jne    801d84 <__udivdi3+0x38>
  801d79:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7e:	31 d2                	xor    %edx,%edx
  801d80:	f7 f7                	div    %edi
  801d82:	89 c5                	mov    %eax,%ebp
  801d84:	31 d2                	xor    %edx,%edx
  801d86:	89 c8                	mov    %ecx,%eax
  801d88:	f7 f5                	div    %ebp
  801d8a:	89 c1                	mov    %eax,%ecx
  801d8c:	89 d8                	mov    %ebx,%eax
  801d8e:	f7 f5                	div    %ebp
  801d90:	89 cf                	mov    %ecx,%edi
  801d92:	89 fa                	mov    %edi,%edx
  801d94:	83 c4 1c             	add    $0x1c,%esp
  801d97:	5b                   	pop    %ebx
  801d98:	5e                   	pop    %esi
  801d99:	5f                   	pop    %edi
  801d9a:	5d                   	pop    %ebp
  801d9b:	c3                   	ret    
  801d9c:	39 ce                	cmp    %ecx,%esi
  801d9e:	77 28                	ja     801dc8 <__udivdi3+0x7c>
  801da0:	0f bd fe             	bsr    %esi,%edi
  801da3:	83 f7 1f             	xor    $0x1f,%edi
  801da6:	75 40                	jne    801de8 <__udivdi3+0x9c>
  801da8:	39 ce                	cmp    %ecx,%esi
  801daa:	72 0a                	jb     801db6 <__udivdi3+0x6a>
  801dac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801db0:	0f 87 9e 00 00 00    	ja     801e54 <__udivdi3+0x108>
  801db6:	b8 01 00 00 00       	mov    $0x1,%eax
  801dbb:	89 fa                	mov    %edi,%edx
  801dbd:	83 c4 1c             	add    $0x1c,%esp
  801dc0:	5b                   	pop    %ebx
  801dc1:	5e                   	pop    %esi
  801dc2:	5f                   	pop    %edi
  801dc3:	5d                   	pop    %ebp
  801dc4:	c3                   	ret    
  801dc5:	8d 76 00             	lea    0x0(%esi),%esi
  801dc8:	31 ff                	xor    %edi,%edi
  801dca:	31 c0                	xor    %eax,%eax
  801dcc:	89 fa                	mov    %edi,%edx
  801dce:	83 c4 1c             	add    $0x1c,%esp
  801dd1:	5b                   	pop    %ebx
  801dd2:	5e                   	pop    %esi
  801dd3:	5f                   	pop    %edi
  801dd4:	5d                   	pop    %ebp
  801dd5:	c3                   	ret    
  801dd6:	66 90                	xchg   %ax,%ax
  801dd8:	89 d8                	mov    %ebx,%eax
  801dda:	f7 f7                	div    %edi
  801ddc:	31 ff                	xor    %edi,%edi
  801dde:	89 fa                	mov    %edi,%edx
  801de0:	83 c4 1c             	add    $0x1c,%esp
  801de3:	5b                   	pop    %ebx
  801de4:	5e                   	pop    %esi
  801de5:	5f                   	pop    %edi
  801de6:	5d                   	pop    %ebp
  801de7:	c3                   	ret    
  801de8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ded:	89 eb                	mov    %ebp,%ebx
  801def:	29 fb                	sub    %edi,%ebx
  801df1:	89 f9                	mov    %edi,%ecx
  801df3:	d3 e6                	shl    %cl,%esi
  801df5:	89 c5                	mov    %eax,%ebp
  801df7:	88 d9                	mov    %bl,%cl
  801df9:	d3 ed                	shr    %cl,%ebp
  801dfb:	89 e9                	mov    %ebp,%ecx
  801dfd:	09 f1                	or     %esi,%ecx
  801dff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e03:	89 f9                	mov    %edi,%ecx
  801e05:	d3 e0                	shl    %cl,%eax
  801e07:	89 c5                	mov    %eax,%ebp
  801e09:	89 d6                	mov    %edx,%esi
  801e0b:	88 d9                	mov    %bl,%cl
  801e0d:	d3 ee                	shr    %cl,%esi
  801e0f:	89 f9                	mov    %edi,%ecx
  801e11:	d3 e2                	shl    %cl,%edx
  801e13:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e17:	88 d9                	mov    %bl,%cl
  801e19:	d3 e8                	shr    %cl,%eax
  801e1b:	09 c2                	or     %eax,%edx
  801e1d:	89 d0                	mov    %edx,%eax
  801e1f:	89 f2                	mov    %esi,%edx
  801e21:	f7 74 24 0c          	divl   0xc(%esp)
  801e25:	89 d6                	mov    %edx,%esi
  801e27:	89 c3                	mov    %eax,%ebx
  801e29:	f7 e5                	mul    %ebp
  801e2b:	39 d6                	cmp    %edx,%esi
  801e2d:	72 19                	jb     801e48 <__udivdi3+0xfc>
  801e2f:	74 0b                	je     801e3c <__udivdi3+0xf0>
  801e31:	89 d8                	mov    %ebx,%eax
  801e33:	31 ff                	xor    %edi,%edi
  801e35:	e9 58 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e3a:	66 90                	xchg   %ax,%ax
  801e3c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e40:	89 f9                	mov    %edi,%ecx
  801e42:	d3 e2                	shl    %cl,%edx
  801e44:	39 c2                	cmp    %eax,%edx
  801e46:	73 e9                	jae    801e31 <__udivdi3+0xe5>
  801e48:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e4b:	31 ff                	xor    %edi,%edi
  801e4d:	e9 40 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e52:	66 90                	xchg   %ax,%ax
  801e54:	31 c0                	xor    %eax,%eax
  801e56:	e9 37 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e5b:	90                   	nop

00801e5c <__umoddi3>:
  801e5c:	55                   	push   %ebp
  801e5d:	57                   	push   %edi
  801e5e:	56                   	push   %esi
  801e5f:	53                   	push   %ebx
  801e60:	83 ec 1c             	sub    $0x1c,%esp
  801e63:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e67:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e6b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e6f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e73:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e77:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e7b:	89 f3                	mov    %esi,%ebx
  801e7d:	89 fa                	mov    %edi,%edx
  801e7f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e83:	89 34 24             	mov    %esi,(%esp)
  801e86:	85 c0                	test   %eax,%eax
  801e88:	75 1a                	jne    801ea4 <__umoddi3+0x48>
  801e8a:	39 f7                	cmp    %esi,%edi
  801e8c:	0f 86 a2 00 00 00    	jbe    801f34 <__umoddi3+0xd8>
  801e92:	89 c8                	mov    %ecx,%eax
  801e94:	89 f2                	mov    %esi,%edx
  801e96:	f7 f7                	div    %edi
  801e98:	89 d0                	mov    %edx,%eax
  801e9a:	31 d2                	xor    %edx,%edx
  801e9c:	83 c4 1c             	add    $0x1c,%esp
  801e9f:	5b                   	pop    %ebx
  801ea0:	5e                   	pop    %esi
  801ea1:	5f                   	pop    %edi
  801ea2:	5d                   	pop    %ebp
  801ea3:	c3                   	ret    
  801ea4:	39 f0                	cmp    %esi,%eax
  801ea6:	0f 87 ac 00 00 00    	ja     801f58 <__umoddi3+0xfc>
  801eac:	0f bd e8             	bsr    %eax,%ebp
  801eaf:	83 f5 1f             	xor    $0x1f,%ebp
  801eb2:	0f 84 ac 00 00 00    	je     801f64 <__umoddi3+0x108>
  801eb8:	bf 20 00 00 00       	mov    $0x20,%edi
  801ebd:	29 ef                	sub    %ebp,%edi
  801ebf:	89 fe                	mov    %edi,%esi
  801ec1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ec5:	89 e9                	mov    %ebp,%ecx
  801ec7:	d3 e0                	shl    %cl,%eax
  801ec9:	89 d7                	mov    %edx,%edi
  801ecb:	89 f1                	mov    %esi,%ecx
  801ecd:	d3 ef                	shr    %cl,%edi
  801ecf:	09 c7                	or     %eax,%edi
  801ed1:	89 e9                	mov    %ebp,%ecx
  801ed3:	d3 e2                	shl    %cl,%edx
  801ed5:	89 14 24             	mov    %edx,(%esp)
  801ed8:	89 d8                	mov    %ebx,%eax
  801eda:	d3 e0                	shl    %cl,%eax
  801edc:	89 c2                	mov    %eax,%edx
  801ede:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ee2:	d3 e0                	shl    %cl,%eax
  801ee4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ee8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eec:	89 f1                	mov    %esi,%ecx
  801eee:	d3 e8                	shr    %cl,%eax
  801ef0:	09 d0                	or     %edx,%eax
  801ef2:	d3 eb                	shr    %cl,%ebx
  801ef4:	89 da                	mov    %ebx,%edx
  801ef6:	f7 f7                	div    %edi
  801ef8:	89 d3                	mov    %edx,%ebx
  801efa:	f7 24 24             	mull   (%esp)
  801efd:	89 c6                	mov    %eax,%esi
  801eff:	89 d1                	mov    %edx,%ecx
  801f01:	39 d3                	cmp    %edx,%ebx
  801f03:	0f 82 87 00 00 00    	jb     801f90 <__umoddi3+0x134>
  801f09:	0f 84 91 00 00 00    	je     801fa0 <__umoddi3+0x144>
  801f0f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f13:	29 f2                	sub    %esi,%edx
  801f15:	19 cb                	sbb    %ecx,%ebx
  801f17:	89 d8                	mov    %ebx,%eax
  801f19:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f1d:	d3 e0                	shl    %cl,%eax
  801f1f:	89 e9                	mov    %ebp,%ecx
  801f21:	d3 ea                	shr    %cl,%edx
  801f23:	09 d0                	or     %edx,%eax
  801f25:	89 e9                	mov    %ebp,%ecx
  801f27:	d3 eb                	shr    %cl,%ebx
  801f29:	89 da                	mov    %ebx,%edx
  801f2b:	83 c4 1c             	add    $0x1c,%esp
  801f2e:	5b                   	pop    %ebx
  801f2f:	5e                   	pop    %esi
  801f30:	5f                   	pop    %edi
  801f31:	5d                   	pop    %ebp
  801f32:	c3                   	ret    
  801f33:	90                   	nop
  801f34:	89 fd                	mov    %edi,%ebp
  801f36:	85 ff                	test   %edi,%edi
  801f38:	75 0b                	jne    801f45 <__umoddi3+0xe9>
  801f3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f3f:	31 d2                	xor    %edx,%edx
  801f41:	f7 f7                	div    %edi
  801f43:	89 c5                	mov    %eax,%ebp
  801f45:	89 f0                	mov    %esi,%eax
  801f47:	31 d2                	xor    %edx,%edx
  801f49:	f7 f5                	div    %ebp
  801f4b:	89 c8                	mov    %ecx,%eax
  801f4d:	f7 f5                	div    %ebp
  801f4f:	89 d0                	mov    %edx,%eax
  801f51:	e9 44 ff ff ff       	jmp    801e9a <__umoddi3+0x3e>
  801f56:	66 90                	xchg   %ax,%ax
  801f58:	89 c8                	mov    %ecx,%eax
  801f5a:	89 f2                	mov    %esi,%edx
  801f5c:	83 c4 1c             	add    $0x1c,%esp
  801f5f:	5b                   	pop    %ebx
  801f60:	5e                   	pop    %esi
  801f61:	5f                   	pop    %edi
  801f62:	5d                   	pop    %ebp
  801f63:	c3                   	ret    
  801f64:	3b 04 24             	cmp    (%esp),%eax
  801f67:	72 06                	jb     801f6f <__umoddi3+0x113>
  801f69:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f6d:	77 0f                	ja     801f7e <__umoddi3+0x122>
  801f6f:	89 f2                	mov    %esi,%edx
  801f71:	29 f9                	sub    %edi,%ecx
  801f73:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f77:	89 14 24             	mov    %edx,(%esp)
  801f7a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f82:	8b 14 24             	mov    (%esp),%edx
  801f85:	83 c4 1c             	add    $0x1c,%esp
  801f88:	5b                   	pop    %ebx
  801f89:	5e                   	pop    %esi
  801f8a:	5f                   	pop    %edi
  801f8b:	5d                   	pop    %ebp
  801f8c:	c3                   	ret    
  801f8d:	8d 76 00             	lea    0x0(%esi),%esi
  801f90:	2b 04 24             	sub    (%esp),%eax
  801f93:	19 fa                	sbb    %edi,%edx
  801f95:	89 d1                	mov    %edx,%ecx
  801f97:	89 c6                	mov    %eax,%esi
  801f99:	e9 71 ff ff ff       	jmp    801f0f <__umoddi3+0xb3>
  801f9e:	66 90                	xchg   %ax,%ax
  801fa0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fa4:	72 ea                	jb     801f90 <__umoddi3+0x134>
  801fa6:	89 d9                	mov    %ebx,%ecx
  801fa8:	e9 62 ff ff ff       	jmp    801f0f <__umoddi3+0xb3>
