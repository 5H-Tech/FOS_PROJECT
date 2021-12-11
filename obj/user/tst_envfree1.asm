
obj/user/tst_envfree1:     file format elf32-i386


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
  800031:	e8 76 01 00 00       	call   8001ac <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests environment free run tef1 5 3
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing scenario 1: without using dynamic allocation/de-allocation, shared variables and semaphores
	// Testing removing the allocated pages in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 46 14 00 00       	call   801489 <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 c1 14 00 00       	call   80150c <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 a0 1c 80 00       	push   $0x801ca0
  800059:	e8 35 05 00 00       	call   800593 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes

	int32 envIdProcessA = sys_create_env("ef_fib", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  800061:	a1 20 30 80 00       	mov    0x803020,%eax
  800066:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80006c:	89 c2                	mov    %eax,%edx
  80006e:	a1 20 30 80 00       	mov    0x803020,%eax
  800073:	8b 40 74             	mov    0x74(%eax),%eax
  800076:	6a 32                	push   $0x32
  800078:	52                   	push   %edx
  800079:	50                   	push   %eax
  80007a:	68 d3 1c 80 00       	push   $0x801cd3
  80007f:	e8 5a 16 00 00       	call   8016de <sys_create_env>
  800084:	83 c4 10             	add    $0x10,%esp
  800087:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_fact", (myEnv->page_WS_max_size)-1,(myEnv->SecondListSize), 50);
  80008a:	a1 20 30 80 00       	mov    0x803020,%eax
  80008f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800095:	89 c2                	mov    %eax,%edx
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 40 74             	mov    0x74(%eax),%eax
  80009f:	48                   	dec    %eax
  8000a0:	6a 32                	push   $0x32
  8000a2:	52                   	push   %edx
  8000a3:	50                   	push   %eax
  8000a4:	68 da 1c 80 00       	push   $0x801cda
  8000a9:	e8 30 16 00 00       	call   8016de <sys_create_env>
  8000ae:	83 c4 10             	add    $0x10,%esp
  8000b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessC = sys_create_env("ef_fos_add",(myEnv->page_WS_max_size)*4,(myEnv->SecondListSize), 50);
  8000b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b9:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000bf:	89 c2                	mov    %eax,%edx
  8000c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c6:	8b 40 74             	mov    0x74(%eax),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	6a 32                	push   $0x32
  8000ce:	52                   	push   %edx
  8000cf:	50                   	push   %eax
  8000d0:	68 e2 1c 80 00       	push   $0x801ce2
  8000d5:	e8 04 16 00 00       	call   8016de <sys_create_env>
  8000da:	83 c4 10             	add    $0x10,%esp
  8000dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	ff 75 ec             	pushl  -0x14(%ebp)
  8000e6:	e8 11 16 00 00       	call   8016fc <sys_run_env>
  8000eb:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	ff 75 e8             	pushl  -0x18(%ebp)
  8000f4:	e8 03 16 00 00       	call   8016fc <sys_run_env>
  8000f9:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessC);
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	ff 75 e4             	pushl  -0x1c(%ebp)
  800102:	e8 f5 15 00 00       	call   8016fc <sys_run_env>
  800107:	83 c4 10             	add    $0x10,%esp

	env_sleep(6000);
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	68 70 17 00 00       	push   $0x1770
  800112:	e8 63 18 00 00       	call   80197a <env_sleep>
  800117:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  80011a:	e8 6a 13 00 00       	call   801489 <sys_calculate_free_frames>
  80011f:	83 ec 08             	sub    $0x8,%esp
  800122:	50                   	push   %eax
  800123:	68 f0 1c 80 00       	push   $0x801cf0
  800128:	e8 66 04 00 00       	call   800593 <cprintf>
  80012d:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  800130:	83 ec 0c             	sub    $0xc,%esp
  800133:	ff 75 ec             	pushl  -0x14(%ebp)
  800136:	e8 dd 15 00 00       	call   801718 <sys_free_env>
  80013b:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	ff 75 e8             	pushl  -0x18(%ebp)
  800144:	e8 cf 15 00 00       	call   801718 <sys_free_env>
  800149:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessC);
  80014c:	83 ec 0c             	sub    $0xc,%esp
  80014f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800152:	e8 c1 15 00 00       	call   801718 <sys_free_env>
  800157:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  80015a:	e8 2a 13 00 00       	call   801489 <sys_calculate_free_frames>
  80015f:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800162:	e8 a5 13 00 00       	call   80150c <sys_pf_calculate_allocated_pages>
  800167:	89 45 dc             	mov    %eax,-0x24(%ebp)

	if((freeFrames_after - freeFrames_before) !=0)
  80016a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80016d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800170:	74 14                	je     800186 <_main+0x14e>
		panic("env_free() does not work correctly... check it again.") ;
  800172:	83 ec 04             	sub    $0x4,%esp
  800175:	68 24 1d 80 00       	push   $0x801d24
  80017a:	6a 26                	push   $0x26
  80017c:	68 5a 1d 80 00       	push   $0x801d5a
  800181:	e8 6b 01 00 00       	call   8002f1 <_panic>

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 e0             	pushl  -0x20(%ebp)
  80018c:	68 70 1d 80 00       	push   $0x801d70
  800191:	e8 fd 03 00 00       	call   800593 <cprintf>
  800196:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 1 for envfree completed successfully.\n");
  800199:	83 ec 0c             	sub    $0xc,%esp
  80019c:	68 d0 1d 80 00       	push   $0x801dd0
  8001a1:	e8 ed 03 00 00       	call   800593 <cprintf>
  8001a6:	83 c4 10             	add    $0x10,%esp
	return;
  8001a9:	90                   	nop
}
  8001aa:	c9                   	leave  
  8001ab:	c3                   	ret    

008001ac <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001ac:	55                   	push   %ebp
  8001ad:	89 e5                	mov    %esp,%ebp
  8001af:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001b2:	e8 07 12 00 00       	call   8013be <sys_getenvindex>
  8001b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001bd:	89 d0                	mov    %edx,%eax
  8001bf:	c1 e0 03             	shl    $0x3,%eax
  8001c2:	01 d0                	add    %edx,%eax
  8001c4:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001cb:	01 c8                	add    %ecx,%eax
  8001cd:	01 c0                	add    %eax,%eax
  8001cf:	01 d0                	add    %edx,%eax
  8001d1:	01 c0                	add    %eax,%eax
  8001d3:	01 d0                	add    %edx,%eax
  8001d5:	89 c2                	mov    %eax,%edx
  8001d7:	c1 e2 05             	shl    $0x5,%edx
  8001da:	29 c2                	sub    %eax,%edx
  8001dc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001e3:	89 c2                	mov    %eax,%edx
  8001e5:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001eb:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f5:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001fb:	84 c0                	test   %al,%al
  8001fd:	74 0f                	je     80020e <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800204:	05 40 3c 01 00       	add    $0x13c40,%eax
  800209:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80020e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800212:	7e 0a                	jle    80021e <libmain+0x72>
		binaryname = argv[0];
  800214:	8b 45 0c             	mov    0xc(%ebp),%eax
  800217:	8b 00                	mov    (%eax),%eax
  800219:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80021e:	83 ec 08             	sub    $0x8,%esp
  800221:	ff 75 0c             	pushl  0xc(%ebp)
  800224:	ff 75 08             	pushl  0x8(%ebp)
  800227:	e8 0c fe ff ff       	call   800038 <_main>
  80022c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80022f:	e8 25 13 00 00       	call   801559 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 34 1e 80 00       	push   $0x801e34
  80023c:	e8 52 03 00 00       	call   800593 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800244:	a1 20 30 80 00       	mov    0x803020,%eax
  800249:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80024f:	a1 20 30 80 00       	mov    0x803020,%eax
  800254:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80025a:	83 ec 04             	sub    $0x4,%esp
  80025d:	52                   	push   %edx
  80025e:	50                   	push   %eax
  80025f:	68 5c 1e 80 00       	push   $0x801e5c
  800264:	e8 2a 03 00 00       	call   800593 <cprintf>
  800269:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80026c:	a1 20 30 80 00       	mov    0x803020,%eax
  800271:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800277:	a1 20 30 80 00       	mov    0x803020,%eax
  80027c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800282:	83 ec 04             	sub    $0x4,%esp
  800285:	52                   	push   %edx
  800286:	50                   	push   %eax
  800287:	68 84 1e 80 00       	push   $0x801e84
  80028c:	e8 02 03 00 00       	call   800593 <cprintf>
  800291:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800294:	a1 20 30 80 00       	mov    0x803020,%eax
  800299:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80029f:	83 ec 08             	sub    $0x8,%esp
  8002a2:	50                   	push   %eax
  8002a3:	68 c5 1e 80 00       	push   $0x801ec5
  8002a8:	e8 e6 02 00 00       	call   800593 <cprintf>
  8002ad:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002b0:	83 ec 0c             	sub    $0xc,%esp
  8002b3:	68 34 1e 80 00       	push   $0x801e34
  8002b8:	e8 d6 02 00 00       	call   800593 <cprintf>
  8002bd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002c0:	e8 ae 12 00 00       	call   801573 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002c5:	e8 19 00 00 00       	call   8002e3 <exit>
}
  8002ca:	90                   	nop
  8002cb:	c9                   	leave  
  8002cc:	c3                   	ret    

008002cd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002cd:	55                   	push   %ebp
  8002ce:	89 e5                	mov    %esp,%ebp
  8002d0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002d3:	83 ec 0c             	sub    $0xc,%esp
  8002d6:	6a 00                	push   $0x0
  8002d8:	e8 ad 10 00 00       	call   80138a <sys_env_destroy>
  8002dd:	83 c4 10             	add    $0x10,%esp
}
  8002e0:	90                   	nop
  8002e1:	c9                   	leave  
  8002e2:	c3                   	ret    

008002e3 <exit>:

void
exit(void)
{
  8002e3:	55                   	push   %ebp
  8002e4:	89 e5                	mov    %esp,%ebp
  8002e6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002e9:	e8 02 11 00 00       	call   8013f0 <sys_env_exit>
}
  8002ee:	90                   	nop
  8002ef:	c9                   	leave  
  8002f0:	c3                   	ret    

008002f1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002f1:	55                   	push   %ebp
  8002f2:	89 e5                	mov    %esp,%ebp
  8002f4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002f7:	8d 45 10             	lea    0x10(%ebp),%eax
  8002fa:	83 c0 04             	add    $0x4,%eax
  8002fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800300:	a1 18 31 80 00       	mov    0x803118,%eax
  800305:	85 c0                	test   %eax,%eax
  800307:	74 16                	je     80031f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800309:	a1 18 31 80 00       	mov    0x803118,%eax
  80030e:	83 ec 08             	sub    $0x8,%esp
  800311:	50                   	push   %eax
  800312:	68 dc 1e 80 00       	push   $0x801edc
  800317:	e8 77 02 00 00       	call   800593 <cprintf>
  80031c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80031f:	a1 00 30 80 00       	mov    0x803000,%eax
  800324:	ff 75 0c             	pushl  0xc(%ebp)
  800327:	ff 75 08             	pushl  0x8(%ebp)
  80032a:	50                   	push   %eax
  80032b:	68 e1 1e 80 00       	push   $0x801ee1
  800330:	e8 5e 02 00 00       	call   800593 <cprintf>
  800335:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800338:	8b 45 10             	mov    0x10(%ebp),%eax
  80033b:	83 ec 08             	sub    $0x8,%esp
  80033e:	ff 75 f4             	pushl  -0xc(%ebp)
  800341:	50                   	push   %eax
  800342:	e8 e1 01 00 00       	call   800528 <vcprintf>
  800347:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80034a:	83 ec 08             	sub    $0x8,%esp
  80034d:	6a 00                	push   $0x0
  80034f:	68 fd 1e 80 00       	push   $0x801efd
  800354:	e8 cf 01 00 00       	call   800528 <vcprintf>
  800359:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80035c:	e8 82 ff ff ff       	call   8002e3 <exit>

	// should not return here
	while (1) ;
  800361:	eb fe                	jmp    800361 <_panic+0x70>

00800363 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800363:	55                   	push   %ebp
  800364:	89 e5                	mov    %esp,%ebp
  800366:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800369:	a1 20 30 80 00       	mov    0x803020,%eax
  80036e:	8b 50 74             	mov    0x74(%eax),%edx
  800371:	8b 45 0c             	mov    0xc(%ebp),%eax
  800374:	39 c2                	cmp    %eax,%edx
  800376:	74 14                	je     80038c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800378:	83 ec 04             	sub    $0x4,%esp
  80037b:	68 00 1f 80 00       	push   $0x801f00
  800380:	6a 26                	push   $0x26
  800382:	68 4c 1f 80 00       	push   $0x801f4c
  800387:	e8 65 ff ff ff       	call   8002f1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80038c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800393:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80039a:	e9 b6 00 00 00       	jmp    800455 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80039f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	01 d0                	add    %edx,%eax
  8003ae:	8b 00                	mov    (%eax),%eax
  8003b0:	85 c0                	test   %eax,%eax
  8003b2:	75 08                	jne    8003bc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003b4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003b7:	e9 96 00 00 00       	jmp    800452 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003ca:	eb 5d                	jmp    800429 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003d7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003da:	c1 e2 04             	shl    $0x4,%edx
  8003dd:	01 d0                	add    %edx,%eax
  8003df:	8a 40 04             	mov    0x4(%eax),%al
  8003e2:	84 c0                	test   %al,%al
  8003e4:	75 40                	jne    800426 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003eb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003f4:	c1 e2 04             	shl    $0x4,%edx
  8003f7:	01 d0                	add    %edx,%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003fe:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800401:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800406:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800408:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	01 c8                	add    %ecx,%eax
  800417:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800419:	39 c2                	cmp    %eax,%edx
  80041b:	75 09                	jne    800426 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80041d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800424:	eb 12                	jmp    800438 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800426:	ff 45 e8             	incl   -0x18(%ebp)
  800429:	a1 20 30 80 00       	mov    0x803020,%eax
  80042e:	8b 50 74             	mov    0x74(%eax),%edx
  800431:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800434:	39 c2                	cmp    %eax,%edx
  800436:	77 94                	ja     8003cc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800438:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80043c:	75 14                	jne    800452 <CheckWSWithoutLastIndex+0xef>
			panic(
  80043e:	83 ec 04             	sub    $0x4,%esp
  800441:	68 58 1f 80 00       	push   $0x801f58
  800446:	6a 3a                	push   $0x3a
  800448:	68 4c 1f 80 00       	push   $0x801f4c
  80044d:	e8 9f fe ff ff       	call   8002f1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800452:	ff 45 f0             	incl   -0x10(%ebp)
  800455:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800458:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045b:	0f 8c 3e ff ff ff    	jl     80039f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800461:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800468:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80046f:	eb 20                	jmp    800491 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800471:	a1 20 30 80 00       	mov    0x803020,%eax
  800476:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80047c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80047f:	c1 e2 04             	shl    $0x4,%edx
  800482:	01 d0                	add    %edx,%eax
  800484:	8a 40 04             	mov    0x4(%eax),%al
  800487:	3c 01                	cmp    $0x1,%al
  800489:	75 03                	jne    80048e <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80048b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80048e:	ff 45 e0             	incl   -0x20(%ebp)
  800491:	a1 20 30 80 00       	mov    0x803020,%eax
  800496:	8b 50 74             	mov    0x74(%eax),%edx
  800499:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80049c:	39 c2                	cmp    %eax,%edx
  80049e:	77 d1                	ja     800471 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004a3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004a6:	74 14                	je     8004bc <CheckWSWithoutLastIndex+0x159>
		panic(
  8004a8:	83 ec 04             	sub    $0x4,%esp
  8004ab:	68 ac 1f 80 00       	push   $0x801fac
  8004b0:	6a 44                	push   $0x44
  8004b2:	68 4c 1f 80 00       	push   $0x801f4c
  8004b7:	e8 35 fe ff ff       	call   8002f1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004bc:	90                   	nop
  8004bd:	c9                   	leave  
  8004be:	c3                   	ret    

008004bf <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004bf:	55                   	push   %ebp
  8004c0:	89 e5                	mov    %esp,%ebp
  8004c2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	8d 48 01             	lea    0x1(%eax),%ecx
  8004cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d0:	89 0a                	mov    %ecx,(%edx)
  8004d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8004d5:	88 d1                	mov    %dl,%cl
  8004d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004da:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e1:	8b 00                	mov    (%eax),%eax
  8004e3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004e8:	75 2c                	jne    800516 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004ea:	a0 24 30 80 00       	mov    0x803024,%al
  8004ef:	0f b6 c0             	movzbl %al,%eax
  8004f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f5:	8b 12                	mov    (%edx),%edx
  8004f7:	89 d1                	mov    %edx,%ecx
  8004f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fc:	83 c2 08             	add    $0x8,%edx
  8004ff:	83 ec 04             	sub    $0x4,%esp
  800502:	50                   	push   %eax
  800503:	51                   	push   %ecx
  800504:	52                   	push   %edx
  800505:	e8 3e 0e 00 00       	call   801348 <sys_cputs>
  80050a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80050d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800510:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800516:	8b 45 0c             	mov    0xc(%ebp),%eax
  800519:	8b 40 04             	mov    0x4(%eax),%eax
  80051c:	8d 50 01             	lea    0x1(%eax),%edx
  80051f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800522:	89 50 04             	mov    %edx,0x4(%eax)
}
  800525:	90                   	nop
  800526:	c9                   	leave  
  800527:	c3                   	ret    

00800528 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800528:	55                   	push   %ebp
  800529:	89 e5                	mov    %esp,%ebp
  80052b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800531:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800538:	00 00 00 
	b.cnt = 0;
  80053b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800542:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800545:	ff 75 0c             	pushl  0xc(%ebp)
  800548:	ff 75 08             	pushl  0x8(%ebp)
  80054b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800551:	50                   	push   %eax
  800552:	68 bf 04 80 00       	push   $0x8004bf
  800557:	e8 11 02 00 00       	call   80076d <vprintfmt>
  80055c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80055f:	a0 24 30 80 00       	mov    0x803024,%al
  800564:	0f b6 c0             	movzbl %al,%eax
  800567:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80056d:	83 ec 04             	sub    $0x4,%esp
  800570:	50                   	push   %eax
  800571:	52                   	push   %edx
  800572:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800578:	83 c0 08             	add    $0x8,%eax
  80057b:	50                   	push   %eax
  80057c:	e8 c7 0d 00 00       	call   801348 <sys_cputs>
  800581:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800584:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80058b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800591:	c9                   	leave  
  800592:	c3                   	ret    

00800593 <cprintf>:

int cprintf(const char *fmt, ...) {
  800593:	55                   	push   %ebp
  800594:	89 e5                	mov    %esp,%ebp
  800596:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800599:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005a0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	83 ec 08             	sub    $0x8,%esp
  8005ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8005af:	50                   	push   %eax
  8005b0:	e8 73 ff ff ff       	call   800528 <vcprintf>
  8005b5:	83 c4 10             	add    $0x10,%esp
  8005b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005be:	c9                   	leave  
  8005bf:	c3                   	ret    

008005c0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005c0:	55                   	push   %ebp
  8005c1:	89 e5                	mov    %esp,%ebp
  8005c3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c6:	e8 8e 0f 00 00       	call   801559 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005cb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	83 ec 08             	sub    $0x8,%esp
  8005d7:	ff 75 f4             	pushl  -0xc(%ebp)
  8005da:	50                   	push   %eax
  8005db:	e8 48 ff ff ff       	call   800528 <vcprintf>
  8005e0:	83 c4 10             	add    $0x10,%esp
  8005e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005e6:	e8 88 0f 00 00       	call   801573 <sys_enable_interrupt>
	return cnt;
  8005eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ee:	c9                   	leave  
  8005ef:	c3                   	ret    

008005f0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005f0:	55                   	push   %ebp
  8005f1:	89 e5                	mov    %esp,%ebp
  8005f3:	53                   	push   %ebx
  8005f4:	83 ec 14             	sub    $0x14,%esp
  8005f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8005fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800600:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800603:	8b 45 18             	mov    0x18(%ebp),%eax
  800606:	ba 00 00 00 00       	mov    $0x0,%edx
  80060b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80060e:	77 55                	ja     800665 <printnum+0x75>
  800610:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800613:	72 05                	jb     80061a <printnum+0x2a>
  800615:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800618:	77 4b                	ja     800665 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80061a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80061d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800620:	8b 45 18             	mov    0x18(%ebp),%eax
  800623:	ba 00 00 00 00       	mov    $0x0,%edx
  800628:	52                   	push   %edx
  800629:	50                   	push   %eax
  80062a:	ff 75 f4             	pushl  -0xc(%ebp)
  80062d:	ff 75 f0             	pushl  -0x10(%ebp)
  800630:	e8 fb 13 00 00       	call   801a30 <__udivdi3>
  800635:	83 c4 10             	add    $0x10,%esp
  800638:	83 ec 04             	sub    $0x4,%esp
  80063b:	ff 75 20             	pushl  0x20(%ebp)
  80063e:	53                   	push   %ebx
  80063f:	ff 75 18             	pushl  0x18(%ebp)
  800642:	52                   	push   %edx
  800643:	50                   	push   %eax
  800644:	ff 75 0c             	pushl  0xc(%ebp)
  800647:	ff 75 08             	pushl  0x8(%ebp)
  80064a:	e8 a1 ff ff ff       	call   8005f0 <printnum>
  80064f:	83 c4 20             	add    $0x20,%esp
  800652:	eb 1a                	jmp    80066e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	ff 75 20             	pushl  0x20(%ebp)
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	ff d0                	call   *%eax
  800662:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800665:	ff 4d 1c             	decl   0x1c(%ebp)
  800668:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80066c:	7f e6                	jg     800654 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80066e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800671:	bb 00 00 00 00       	mov    $0x0,%ebx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80067c:	53                   	push   %ebx
  80067d:	51                   	push   %ecx
  80067e:	52                   	push   %edx
  80067f:	50                   	push   %eax
  800680:	e8 bb 14 00 00       	call   801b40 <__umoddi3>
  800685:	83 c4 10             	add    $0x10,%esp
  800688:	05 14 22 80 00       	add    $0x802214,%eax
  80068d:	8a 00                	mov    (%eax),%al
  80068f:	0f be c0             	movsbl %al,%eax
  800692:	83 ec 08             	sub    $0x8,%esp
  800695:	ff 75 0c             	pushl  0xc(%ebp)
  800698:	50                   	push   %eax
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	ff d0                	call   *%eax
  80069e:	83 c4 10             	add    $0x10,%esp
}
  8006a1:	90                   	nop
  8006a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006a5:	c9                   	leave  
  8006a6:	c3                   	ret    

008006a7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006a7:	55                   	push   %ebp
  8006a8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006aa:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ae:	7e 1c                	jle    8006cc <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	8b 00                	mov    (%eax),%eax
  8006b5:	8d 50 08             	lea    0x8(%eax),%edx
  8006b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bb:	89 10                	mov    %edx,(%eax)
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	83 e8 08             	sub    $0x8,%eax
  8006c5:	8b 50 04             	mov    0x4(%eax),%edx
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	eb 40                	jmp    80070c <getuint+0x65>
	else if (lflag)
  8006cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d0:	74 1e                	je     8006f0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	8b 00                	mov    (%eax),%eax
  8006d7:	8d 50 04             	lea    0x4(%eax),%edx
  8006da:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dd:	89 10                	mov    %edx,(%eax)
  8006df:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	83 e8 04             	sub    $0x4,%eax
  8006e7:	8b 00                	mov    (%eax),%eax
  8006e9:	ba 00 00 00 00       	mov    $0x0,%edx
  8006ee:	eb 1c                	jmp    80070c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	8d 50 04             	lea    0x4(%eax),%edx
  8006f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fb:	89 10                	mov    %edx,(%eax)
  8006fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800700:	8b 00                	mov    (%eax),%eax
  800702:	83 e8 04             	sub    $0x4,%eax
  800705:	8b 00                	mov    (%eax),%eax
  800707:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80070c:	5d                   	pop    %ebp
  80070d:	c3                   	ret    

0080070e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80070e:	55                   	push   %ebp
  80070f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800711:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800715:	7e 1c                	jle    800733 <getint+0x25>
		return va_arg(*ap, long long);
  800717:	8b 45 08             	mov    0x8(%ebp),%eax
  80071a:	8b 00                	mov    (%eax),%eax
  80071c:	8d 50 08             	lea    0x8(%eax),%edx
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	89 10                	mov    %edx,(%eax)
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	8b 00                	mov    (%eax),%eax
  800729:	83 e8 08             	sub    $0x8,%eax
  80072c:	8b 50 04             	mov    0x4(%eax),%edx
  80072f:	8b 00                	mov    (%eax),%eax
  800731:	eb 38                	jmp    80076b <getint+0x5d>
	else if (lflag)
  800733:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800737:	74 1a                	je     800753 <getint+0x45>
		return va_arg(*ap, long);
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	8b 00                	mov    (%eax),%eax
  80073e:	8d 50 04             	lea    0x4(%eax),%edx
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	89 10                	mov    %edx,(%eax)
  800746:	8b 45 08             	mov    0x8(%ebp),%eax
  800749:	8b 00                	mov    (%eax),%eax
  80074b:	83 e8 04             	sub    $0x4,%eax
  80074e:	8b 00                	mov    (%eax),%eax
  800750:	99                   	cltd   
  800751:	eb 18                	jmp    80076b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	8b 00                	mov    (%eax),%eax
  800758:	8d 50 04             	lea    0x4(%eax),%edx
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	89 10                	mov    %edx,(%eax)
  800760:	8b 45 08             	mov    0x8(%ebp),%eax
  800763:	8b 00                	mov    (%eax),%eax
  800765:	83 e8 04             	sub    $0x4,%eax
  800768:	8b 00                	mov    (%eax),%eax
  80076a:	99                   	cltd   
}
  80076b:	5d                   	pop    %ebp
  80076c:	c3                   	ret    

0080076d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	56                   	push   %esi
  800771:	53                   	push   %ebx
  800772:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800775:	eb 17                	jmp    80078e <vprintfmt+0x21>
			if (ch == '\0')
  800777:	85 db                	test   %ebx,%ebx
  800779:	0f 84 af 03 00 00    	je     800b2e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80077f:	83 ec 08             	sub    $0x8,%esp
  800782:	ff 75 0c             	pushl  0xc(%ebp)
  800785:	53                   	push   %ebx
  800786:	8b 45 08             	mov    0x8(%ebp),%eax
  800789:	ff d0                	call   *%eax
  80078b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80078e:	8b 45 10             	mov    0x10(%ebp),%eax
  800791:	8d 50 01             	lea    0x1(%eax),%edx
  800794:	89 55 10             	mov    %edx,0x10(%ebp)
  800797:	8a 00                	mov    (%eax),%al
  800799:	0f b6 d8             	movzbl %al,%ebx
  80079c:	83 fb 25             	cmp    $0x25,%ebx
  80079f:	75 d6                	jne    800777 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007a1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007a5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007ac:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007b3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007ba:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c4:	8d 50 01             	lea    0x1(%eax),%edx
  8007c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8007ca:	8a 00                	mov    (%eax),%al
  8007cc:	0f b6 d8             	movzbl %al,%ebx
  8007cf:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007d2:	83 f8 55             	cmp    $0x55,%eax
  8007d5:	0f 87 2b 03 00 00    	ja     800b06 <vprintfmt+0x399>
  8007db:	8b 04 85 38 22 80 00 	mov    0x802238(,%eax,4),%eax
  8007e2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007e4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007e8:	eb d7                	jmp    8007c1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007ea:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007ee:	eb d1                	jmp    8007c1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007f0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007fa:	89 d0                	mov    %edx,%eax
  8007fc:	c1 e0 02             	shl    $0x2,%eax
  8007ff:	01 d0                	add    %edx,%eax
  800801:	01 c0                	add    %eax,%eax
  800803:	01 d8                	add    %ebx,%eax
  800805:	83 e8 30             	sub    $0x30,%eax
  800808:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80080b:	8b 45 10             	mov    0x10(%ebp),%eax
  80080e:	8a 00                	mov    (%eax),%al
  800810:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800813:	83 fb 2f             	cmp    $0x2f,%ebx
  800816:	7e 3e                	jle    800856 <vprintfmt+0xe9>
  800818:	83 fb 39             	cmp    $0x39,%ebx
  80081b:	7f 39                	jg     800856 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80081d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800820:	eb d5                	jmp    8007f7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800822:	8b 45 14             	mov    0x14(%ebp),%eax
  800825:	83 c0 04             	add    $0x4,%eax
  800828:	89 45 14             	mov    %eax,0x14(%ebp)
  80082b:	8b 45 14             	mov    0x14(%ebp),%eax
  80082e:	83 e8 04             	sub    $0x4,%eax
  800831:	8b 00                	mov    (%eax),%eax
  800833:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800836:	eb 1f                	jmp    800857 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800838:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80083c:	79 83                	jns    8007c1 <vprintfmt+0x54>
				width = 0;
  80083e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800845:	e9 77 ff ff ff       	jmp    8007c1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80084a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800851:	e9 6b ff ff ff       	jmp    8007c1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800856:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800857:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80085b:	0f 89 60 ff ff ff    	jns    8007c1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800861:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800864:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800867:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80086e:	e9 4e ff ff ff       	jmp    8007c1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800873:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800876:	e9 46 ff ff ff       	jmp    8007c1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80087b:	8b 45 14             	mov    0x14(%ebp),%eax
  80087e:	83 c0 04             	add    $0x4,%eax
  800881:	89 45 14             	mov    %eax,0x14(%ebp)
  800884:	8b 45 14             	mov    0x14(%ebp),%eax
  800887:	83 e8 04             	sub    $0x4,%eax
  80088a:	8b 00                	mov    (%eax),%eax
  80088c:	83 ec 08             	sub    $0x8,%esp
  80088f:	ff 75 0c             	pushl  0xc(%ebp)
  800892:	50                   	push   %eax
  800893:	8b 45 08             	mov    0x8(%ebp),%eax
  800896:	ff d0                	call   *%eax
  800898:	83 c4 10             	add    $0x10,%esp
			break;
  80089b:	e9 89 02 00 00       	jmp    800b29 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a3:	83 c0 04             	add    $0x4,%eax
  8008a6:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ac:	83 e8 04             	sub    $0x4,%eax
  8008af:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008b1:	85 db                	test   %ebx,%ebx
  8008b3:	79 02                	jns    8008b7 <vprintfmt+0x14a>
				err = -err;
  8008b5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008b7:	83 fb 64             	cmp    $0x64,%ebx
  8008ba:	7f 0b                	jg     8008c7 <vprintfmt+0x15a>
  8008bc:	8b 34 9d 80 20 80 00 	mov    0x802080(,%ebx,4),%esi
  8008c3:	85 f6                	test   %esi,%esi
  8008c5:	75 19                	jne    8008e0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008c7:	53                   	push   %ebx
  8008c8:	68 25 22 80 00       	push   $0x802225
  8008cd:	ff 75 0c             	pushl  0xc(%ebp)
  8008d0:	ff 75 08             	pushl  0x8(%ebp)
  8008d3:	e8 5e 02 00 00       	call   800b36 <printfmt>
  8008d8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008db:	e9 49 02 00 00       	jmp    800b29 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008e0:	56                   	push   %esi
  8008e1:	68 2e 22 80 00       	push   $0x80222e
  8008e6:	ff 75 0c             	pushl  0xc(%ebp)
  8008e9:	ff 75 08             	pushl  0x8(%ebp)
  8008ec:	e8 45 02 00 00       	call   800b36 <printfmt>
  8008f1:	83 c4 10             	add    $0x10,%esp
			break;
  8008f4:	e9 30 02 00 00       	jmp    800b29 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fc:	83 c0 04             	add    $0x4,%eax
  8008ff:	89 45 14             	mov    %eax,0x14(%ebp)
  800902:	8b 45 14             	mov    0x14(%ebp),%eax
  800905:	83 e8 04             	sub    $0x4,%eax
  800908:	8b 30                	mov    (%eax),%esi
  80090a:	85 f6                	test   %esi,%esi
  80090c:	75 05                	jne    800913 <vprintfmt+0x1a6>
				p = "(null)";
  80090e:	be 31 22 80 00       	mov    $0x802231,%esi
			if (width > 0 && padc != '-')
  800913:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800917:	7e 6d                	jle    800986 <vprintfmt+0x219>
  800919:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80091d:	74 67                	je     800986 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80091f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800922:	83 ec 08             	sub    $0x8,%esp
  800925:	50                   	push   %eax
  800926:	56                   	push   %esi
  800927:	e8 0c 03 00 00       	call   800c38 <strnlen>
  80092c:	83 c4 10             	add    $0x10,%esp
  80092f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800932:	eb 16                	jmp    80094a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800934:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 0c             	pushl  0xc(%ebp)
  80093e:	50                   	push   %eax
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800947:	ff 4d e4             	decl   -0x1c(%ebp)
  80094a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80094e:	7f e4                	jg     800934 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800950:	eb 34                	jmp    800986 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800952:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800956:	74 1c                	je     800974 <vprintfmt+0x207>
  800958:	83 fb 1f             	cmp    $0x1f,%ebx
  80095b:	7e 05                	jle    800962 <vprintfmt+0x1f5>
  80095d:	83 fb 7e             	cmp    $0x7e,%ebx
  800960:	7e 12                	jle    800974 <vprintfmt+0x207>
					putch('?', putdat);
  800962:	83 ec 08             	sub    $0x8,%esp
  800965:	ff 75 0c             	pushl  0xc(%ebp)
  800968:	6a 3f                	push   $0x3f
  80096a:	8b 45 08             	mov    0x8(%ebp),%eax
  80096d:	ff d0                	call   *%eax
  80096f:	83 c4 10             	add    $0x10,%esp
  800972:	eb 0f                	jmp    800983 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800974:	83 ec 08             	sub    $0x8,%esp
  800977:	ff 75 0c             	pushl  0xc(%ebp)
  80097a:	53                   	push   %ebx
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	ff d0                	call   *%eax
  800980:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800983:	ff 4d e4             	decl   -0x1c(%ebp)
  800986:	89 f0                	mov    %esi,%eax
  800988:	8d 70 01             	lea    0x1(%eax),%esi
  80098b:	8a 00                	mov    (%eax),%al
  80098d:	0f be d8             	movsbl %al,%ebx
  800990:	85 db                	test   %ebx,%ebx
  800992:	74 24                	je     8009b8 <vprintfmt+0x24b>
  800994:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800998:	78 b8                	js     800952 <vprintfmt+0x1e5>
  80099a:	ff 4d e0             	decl   -0x20(%ebp)
  80099d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009a1:	79 af                	jns    800952 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009a3:	eb 13                	jmp    8009b8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 0c             	pushl  0xc(%ebp)
  8009ab:	6a 20                	push   $0x20
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	ff d0                	call   *%eax
  8009b2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009b5:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009bc:	7f e7                	jg     8009a5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009be:	e9 66 01 00 00       	jmp    800b29 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009c3:	83 ec 08             	sub    $0x8,%esp
  8009c6:	ff 75 e8             	pushl  -0x18(%ebp)
  8009c9:	8d 45 14             	lea    0x14(%ebp),%eax
  8009cc:	50                   	push   %eax
  8009cd:	e8 3c fd ff ff       	call   80070e <getint>
  8009d2:	83 c4 10             	add    $0x10,%esp
  8009d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009e1:	85 d2                	test   %edx,%edx
  8009e3:	79 23                	jns    800a08 <vprintfmt+0x29b>
				putch('-', putdat);
  8009e5:	83 ec 08             	sub    $0x8,%esp
  8009e8:	ff 75 0c             	pushl  0xc(%ebp)
  8009eb:	6a 2d                	push   $0x2d
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	ff d0                	call   *%eax
  8009f2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009fb:	f7 d8                	neg    %eax
  8009fd:	83 d2 00             	adc    $0x0,%edx
  800a00:	f7 da                	neg    %edx
  800a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a05:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a08:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a0f:	e9 bc 00 00 00       	jmp    800ad0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 e8             	pushl  -0x18(%ebp)
  800a1a:	8d 45 14             	lea    0x14(%ebp),%eax
  800a1d:	50                   	push   %eax
  800a1e:	e8 84 fc ff ff       	call   8006a7 <getuint>
  800a23:	83 c4 10             	add    $0x10,%esp
  800a26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a29:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a2c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a33:	e9 98 00 00 00       	jmp    800ad0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a38:	83 ec 08             	sub    $0x8,%esp
  800a3b:	ff 75 0c             	pushl  0xc(%ebp)
  800a3e:	6a 58                	push   $0x58
  800a40:	8b 45 08             	mov    0x8(%ebp),%eax
  800a43:	ff d0                	call   *%eax
  800a45:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 0c             	pushl  0xc(%ebp)
  800a4e:	6a 58                	push   $0x58
  800a50:	8b 45 08             	mov    0x8(%ebp),%eax
  800a53:	ff d0                	call   *%eax
  800a55:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 0c             	pushl  0xc(%ebp)
  800a5e:	6a 58                	push   $0x58
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	ff d0                	call   *%eax
  800a65:	83 c4 10             	add    $0x10,%esp
			break;
  800a68:	e9 bc 00 00 00       	jmp    800b29 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	ff 75 0c             	pushl  0xc(%ebp)
  800a73:	6a 30                	push   $0x30
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	ff d0                	call   *%eax
  800a7a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 0c             	pushl  0xc(%ebp)
  800a83:	6a 78                	push   $0x78
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	ff d0                	call   *%eax
  800a8a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a90:	83 c0 04             	add    $0x4,%eax
  800a93:	89 45 14             	mov    %eax,0x14(%ebp)
  800a96:	8b 45 14             	mov    0x14(%ebp),%eax
  800a99:	83 e8 04             	sub    $0x4,%eax
  800a9c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800aa8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800aaf:	eb 1f                	jmp    800ad0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ab1:	83 ec 08             	sub    $0x8,%esp
  800ab4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab7:	8d 45 14             	lea    0x14(%ebp),%eax
  800aba:	50                   	push   %eax
  800abb:	e8 e7 fb ff ff       	call   8006a7 <getuint>
  800ac0:	83 c4 10             	add    $0x10,%esp
  800ac3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ac9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ad0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ad4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ad7:	83 ec 04             	sub    $0x4,%esp
  800ada:	52                   	push   %edx
  800adb:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ade:	50                   	push   %eax
  800adf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae2:	ff 75 f0             	pushl  -0x10(%ebp)
  800ae5:	ff 75 0c             	pushl  0xc(%ebp)
  800ae8:	ff 75 08             	pushl  0x8(%ebp)
  800aeb:	e8 00 fb ff ff       	call   8005f0 <printnum>
  800af0:	83 c4 20             	add    $0x20,%esp
			break;
  800af3:	eb 34                	jmp    800b29 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800af5:	83 ec 08             	sub    $0x8,%esp
  800af8:	ff 75 0c             	pushl  0xc(%ebp)
  800afb:	53                   	push   %ebx
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	ff d0                	call   *%eax
  800b01:	83 c4 10             	add    $0x10,%esp
			break;
  800b04:	eb 23                	jmp    800b29 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b06:	83 ec 08             	sub    $0x8,%esp
  800b09:	ff 75 0c             	pushl  0xc(%ebp)
  800b0c:	6a 25                	push   $0x25
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	ff d0                	call   *%eax
  800b13:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b16:	ff 4d 10             	decl   0x10(%ebp)
  800b19:	eb 03                	jmp    800b1e <vprintfmt+0x3b1>
  800b1b:	ff 4d 10             	decl   0x10(%ebp)
  800b1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b21:	48                   	dec    %eax
  800b22:	8a 00                	mov    (%eax),%al
  800b24:	3c 25                	cmp    $0x25,%al
  800b26:	75 f3                	jne    800b1b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b28:	90                   	nop
		}
	}
  800b29:	e9 47 fc ff ff       	jmp    800775 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b2e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b32:	5b                   	pop    %ebx
  800b33:	5e                   	pop    %esi
  800b34:	5d                   	pop    %ebp
  800b35:	c3                   	ret    

00800b36 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
  800b39:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b3c:	8d 45 10             	lea    0x10(%ebp),%eax
  800b3f:	83 c0 04             	add    $0x4,%eax
  800b42:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b45:	8b 45 10             	mov    0x10(%ebp),%eax
  800b48:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4b:	50                   	push   %eax
  800b4c:	ff 75 0c             	pushl  0xc(%ebp)
  800b4f:	ff 75 08             	pushl  0x8(%ebp)
  800b52:	e8 16 fc ff ff       	call   80076d <vprintfmt>
  800b57:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b5a:	90                   	nop
  800b5b:	c9                   	leave  
  800b5c:	c3                   	ret    

00800b5d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b5d:	55                   	push   %ebp
  800b5e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b63:	8b 40 08             	mov    0x8(%eax),%eax
  800b66:	8d 50 01             	lea    0x1(%eax),%edx
  800b69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b72:	8b 10                	mov    (%eax),%edx
  800b74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b77:	8b 40 04             	mov    0x4(%eax),%eax
  800b7a:	39 c2                	cmp    %eax,%edx
  800b7c:	73 12                	jae    800b90 <sprintputch+0x33>
		*b->buf++ = ch;
  800b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b81:	8b 00                	mov    (%eax),%eax
  800b83:	8d 48 01             	lea    0x1(%eax),%ecx
  800b86:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b89:	89 0a                	mov    %ecx,(%edx)
  800b8b:	8b 55 08             	mov    0x8(%ebp),%edx
  800b8e:	88 10                	mov    %dl,(%eax)
}
  800b90:	90                   	nop
  800b91:	5d                   	pop    %ebp
  800b92:	c3                   	ret    

00800b93 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b93:	55                   	push   %ebp
  800b94:	89 e5                	mov    %esp,%ebp
  800b96:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	01 d0                	add    %edx,%eax
  800baa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bb4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb8:	74 06                	je     800bc0 <vsnprintf+0x2d>
  800bba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bbe:	7f 07                	jg     800bc7 <vsnprintf+0x34>
		return -E_INVAL;
  800bc0:	b8 03 00 00 00       	mov    $0x3,%eax
  800bc5:	eb 20                	jmp    800be7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bc7:	ff 75 14             	pushl  0x14(%ebp)
  800bca:	ff 75 10             	pushl  0x10(%ebp)
  800bcd:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bd0:	50                   	push   %eax
  800bd1:	68 5d 0b 80 00       	push   $0x800b5d
  800bd6:	e8 92 fb ff ff       	call   80076d <vprintfmt>
  800bdb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bde:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800be1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800be7:	c9                   	leave  
  800be8:	c3                   	ret    

00800be9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800be9:	55                   	push   %ebp
  800bea:	89 e5                	mov    %esp,%ebp
  800bec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bef:	8d 45 10             	lea    0x10(%ebp),%eax
  800bf2:	83 c0 04             	add    $0x4,%eax
  800bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bf8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bfe:	50                   	push   %eax
  800bff:	ff 75 0c             	pushl  0xc(%ebp)
  800c02:	ff 75 08             	pushl  0x8(%ebp)
  800c05:	e8 89 ff ff ff       	call   800b93 <vsnprintf>
  800c0a:	83 c4 10             	add    $0x10,%esp
  800c0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c10:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c13:	c9                   	leave  
  800c14:	c3                   	ret    

00800c15 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c15:	55                   	push   %ebp
  800c16:	89 e5                	mov    %esp,%ebp
  800c18:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c22:	eb 06                	jmp    800c2a <strlen+0x15>
		n++;
  800c24:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c27:	ff 45 08             	incl   0x8(%ebp)
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	84 c0                	test   %al,%al
  800c31:	75 f1                	jne    800c24 <strlen+0xf>
		n++;
	return n;
  800c33:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c36:	c9                   	leave  
  800c37:	c3                   	ret    

00800c38 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c38:	55                   	push   %ebp
  800c39:	89 e5                	mov    %esp,%ebp
  800c3b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c45:	eb 09                	jmp    800c50 <strnlen+0x18>
		n++;
  800c47:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c4a:	ff 45 08             	incl   0x8(%ebp)
  800c4d:	ff 4d 0c             	decl   0xc(%ebp)
  800c50:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c54:	74 09                	je     800c5f <strnlen+0x27>
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	84 c0                	test   %al,%al
  800c5d:	75 e8                	jne    800c47 <strnlen+0xf>
		n++;
	return n;
  800c5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c62:	c9                   	leave  
  800c63:	c3                   	ret    

00800c64 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c64:	55                   	push   %ebp
  800c65:	89 e5                	mov    %esp,%ebp
  800c67:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c70:	90                   	nop
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	8d 50 01             	lea    0x1(%eax),%edx
  800c77:	89 55 08             	mov    %edx,0x8(%ebp)
  800c7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c80:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c83:	8a 12                	mov    (%edx),%dl
  800c85:	88 10                	mov    %dl,(%eax)
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	84 c0                	test   %al,%al
  800c8b:	75 e4                	jne    800c71 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c90:	c9                   	leave  
  800c91:	c3                   	ret    

00800c92 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
  800c95:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ca5:	eb 1f                	jmp    800cc6 <strncpy+0x34>
		*dst++ = *src;
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	8d 50 01             	lea    0x1(%eax),%edx
  800cad:	89 55 08             	mov    %edx,0x8(%ebp)
  800cb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb3:	8a 12                	mov    (%edx),%dl
  800cb5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	84 c0                	test   %al,%al
  800cbe:	74 03                	je     800cc3 <strncpy+0x31>
			src++;
  800cc0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cc3:	ff 45 fc             	incl   -0x4(%ebp)
  800cc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cc9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ccc:	72 d9                	jb     800ca7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cce:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cd1:	c9                   	leave  
  800cd2:	c3                   	ret    

00800cd3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cd3:	55                   	push   %ebp
  800cd4:	89 e5                	mov    %esp,%ebp
  800cd6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cdf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce3:	74 30                	je     800d15 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ce5:	eb 16                	jmp    800cfd <strlcpy+0x2a>
			*dst++ = *src++;
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	8d 50 01             	lea    0x1(%eax),%edx
  800ced:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cf9:	8a 12                	mov    (%edx),%dl
  800cfb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cfd:	ff 4d 10             	decl   0x10(%ebp)
  800d00:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d04:	74 09                	je     800d0f <strlcpy+0x3c>
  800d06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	84 c0                	test   %al,%al
  800d0d:	75 d8                	jne    800ce7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d15:	8b 55 08             	mov    0x8(%ebp),%edx
  800d18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d1b:	29 c2                	sub    %eax,%edx
  800d1d:	89 d0                	mov    %edx,%eax
}
  800d1f:	c9                   	leave  
  800d20:	c3                   	ret    

00800d21 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d21:	55                   	push   %ebp
  800d22:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d24:	eb 06                	jmp    800d2c <strcmp+0xb>
		p++, q++;
  800d26:	ff 45 08             	incl   0x8(%ebp)
  800d29:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	84 c0                	test   %al,%al
  800d33:	74 0e                	je     800d43 <strcmp+0x22>
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 10                	mov    (%eax),%dl
  800d3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	38 c2                	cmp    %al,%dl
  800d41:	74 e3                	je     800d26 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	0f b6 d0             	movzbl %al,%edx
  800d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4e:	8a 00                	mov    (%eax),%al
  800d50:	0f b6 c0             	movzbl %al,%eax
  800d53:	29 c2                	sub    %eax,%edx
  800d55:	89 d0                	mov    %edx,%eax
}
  800d57:	5d                   	pop    %ebp
  800d58:	c3                   	ret    

00800d59 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d59:	55                   	push   %ebp
  800d5a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d5c:	eb 09                	jmp    800d67 <strncmp+0xe>
		n--, p++, q++;
  800d5e:	ff 4d 10             	decl   0x10(%ebp)
  800d61:	ff 45 08             	incl   0x8(%ebp)
  800d64:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d6b:	74 17                	je     800d84 <strncmp+0x2b>
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	84 c0                	test   %al,%al
  800d74:	74 0e                	je     800d84 <strncmp+0x2b>
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8a 10                	mov    (%eax),%dl
  800d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	38 c2                	cmp    %al,%dl
  800d82:	74 da                	je     800d5e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d88:	75 07                	jne    800d91 <strncmp+0x38>
		return 0;
  800d8a:	b8 00 00 00 00       	mov    $0x0,%eax
  800d8f:	eb 14                	jmp    800da5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	0f b6 d0             	movzbl %al,%edx
  800d99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9c:	8a 00                	mov    (%eax),%al
  800d9e:	0f b6 c0             	movzbl %al,%eax
  800da1:	29 c2                	sub    %eax,%edx
  800da3:	89 d0                	mov    %edx,%eax
}
  800da5:	5d                   	pop    %ebp
  800da6:	c3                   	ret    

00800da7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800da7:	55                   	push   %ebp
  800da8:	89 e5                	mov    %esp,%ebp
  800daa:	83 ec 04             	sub    $0x4,%esp
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800db3:	eb 12                	jmp    800dc7 <strchr+0x20>
		if (*s == c)
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	8a 00                	mov    (%eax),%al
  800dba:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dbd:	75 05                	jne    800dc4 <strchr+0x1d>
			return (char *) s;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	eb 11                	jmp    800dd5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dc4:	ff 45 08             	incl   0x8(%ebp)
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	84 c0                	test   %al,%al
  800dce:	75 e5                	jne    800db5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dd5:	c9                   	leave  
  800dd6:	c3                   	ret    

00800dd7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dd7:	55                   	push   %ebp
  800dd8:	89 e5                	mov    %esp,%ebp
  800dda:	83 ec 04             	sub    $0x4,%esp
  800ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800de3:	eb 0d                	jmp    800df2 <strfind+0x1b>
		if (*s == c)
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ded:	74 0e                	je     800dfd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800def:	ff 45 08             	incl   0x8(%ebp)
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	84 c0                	test   %al,%al
  800df9:	75 ea                	jne    800de5 <strfind+0xe>
  800dfb:	eb 01                	jmp    800dfe <strfind+0x27>
		if (*s == c)
			break;
  800dfd:	90                   	nop
	return (char *) s;
  800dfe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e01:	c9                   	leave  
  800e02:	c3                   	ret    

00800e03 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e03:	55                   	push   %ebp
  800e04:	89 e5                	mov    %esp,%ebp
  800e06:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e15:	eb 0e                	jmp    800e25 <memset+0x22>
		*p++ = c;
  800e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1a:	8d 50 01             	lea    0x1(%eax),%edx
  800e1d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e23:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e25:	ff 4d f8             	decl   -0x8(%ebp)
  800e28:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e2c:	79 e9                	jns    800e17 <memset+0x14>
		*p++ = c;

	return v;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e31:	c9                   	leave  
  800e32:	c3                   	ret    

00800e33 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e33:	55                   	push   %ebp
  800e34:	89 e5                	mov    %esp,%ebp
  800e36:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e45:	eb 16                	jmp    800e5d <memcpy+0x2a>
		*d++ = *s++;
  800e47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4a:	8d 50 01             	lea    0x1(%eax),%edx
  800e4d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e50:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e53:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e56:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e59:	8a 12                	mov    (%edx),%dl
  800e5b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e60:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e63:	89 55 10             	mov    %edx,0x10(%ebp)
  800e66:	85 c0                	test   %eax,%eax
  800e68:	75 dd                	jne    800e47 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6d:	c9                   	leave  
  800e6e:	c3                   	ret    

00800e6f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e6f:	55                   	push   %ebp
  800e70:	89 e5                	mov    %esp,%ebp
  800e72:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e78:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e84:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e87:	73 50                	jae    800ed9 <memmove+0x6a>
  800e89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8f:	01 d0                	add    %edx,%eax
  800e91:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e94:	76 43                	jbe    800ed9 <memmove+0x6a>
		s += n;
  800e96:	8b 45 10             	mov    0x10(%ebp),%eax
  800e99:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ea2:	eb 10                	jmp    800eb4 <memmove+0x45>
			*--d = *--s;
  800ea4:	ff 4d f8             	decl   -0x8(%ebp)
  800ea7:	ff 4d fc             	decl   -0x4(%ebp)
  800eaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ead:	8a 10                	mov    (%eax),%dl
  800eaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800eb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eba:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebd:	85 c0                	test   %eax,%eax
  800ebf:	75 e3                	jne    800ea4 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ec1:	eb 23                	jmp    800ee6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ec3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec6:	8d 50 01             	lea    0x1(%eax),%edx
  800ec9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ecc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ecf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ed2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ed5:	8a 12                	mov    (%edx),%dl
  800ed7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ed9:	8b 45 10             	mov    0x10(%ebp),%eax
  800edc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800edf:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee2:	85 c0                	test   %eax,%eax
  800ee4:	75 dd                	jne    800ec3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee9:	c9                   	leave  
  800eea:	c3                   	ret    

00800eeb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800eeb:	55                   	push   %ebp
  800eec:	89 e5                	mov    %esp,%ebp
  800eee:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efa:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800efd:	eb 2a                	jmp    800f29 <memcmp+0x3e>
		if (*s1 != *s2)
  800eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f02:	8a 10                	mov    (%eax),%dl
  800f04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	38 c2                	cmp    %al,%dl
  800f0b:	74 16                	je     800f23 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	0f b6 d0             	movzbl %al,%edx
  800f15:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	0f b6 c0             	movzbl %al,%eax
  800f1d:	29 c2                	sub    %eax,%edx
  800f1f:	89 d0                	mov    %edx,%eax
  800f21:	eb 18                	jmp    800f3b <memcmp+0x50>
		s1++, s2++;
  800f23:	ff 45 fc             	incl   -0x4(%ebp)
  800f26:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f29:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f2f:	89 55 10             	mov    %edx,0x10(%ebp)
  800f32:	85 c0                	test   %eax,%eax
  800f34:	75 c9                	jne    800eff <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f3b:	c9                   	leave  
  800f3c:	c3                   	ret    

00800f3d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f3d:	55                   	push   %ebp
  800f3e:	89 e5                	mov    %esp,%ebp
  800f40:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f43:	8b 55 08             	mov    0x8(%ebp),%edx
  800f46:	8b 45 10             	mov    0x10(%ebp),%eax
  800f49:	01 d0                	add    %edx,%eax
  800f4b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f4e:	eb 15                	jmp    800f65 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	0f b6 d0             	movzbl %al,%edx
  800f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5b:	0f b6 c0             	movzbl %al,%eax
  800f5e:	39 c2                	cmp    %eax,%edx
  800f60:	74 0d                	je     800f6f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f62:	ff 45 08             	incl   0x8(%ebp)
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f6b:	72 e3                	jb     800f50 <memfind+0x13>
  800f6d:	eb 01                	jmp    800f70 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f6f:	90                   	nop
	return (void *) s;
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f73:	c9                   	leave  
  800f74:	c3                   	ret    

00800f75 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f75:	55                   	push   %ebp
  800f76:	89 e5                	mov    %esp,%ebp
  800f78:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f82:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f89:	eb 03                	jmp    800f8e <strtol+0x19>
		s++;
  800f8b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	3c 20                	cmp    $0x20,%al
  800f95:	74 f4                	je     800f8b <strtol+0x16>
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	3c 09                	cmp    $0x9,%al
  800f9e:	74 eb                	je     800f8b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	3c 2b                	cmp    $0x2b,%al
  800fa7:	75 05                	jne    800fae <strtol+0x39>
		s++;
  800fa9:	ff 45 08             	incl   0x8(%ebp)
  800fac:	eb 13                	jmp    800fc1 <strtol+0x4c>
	else if (*s == '-')
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	8a 00                	mov    (%eax),%al
  800fb3:	3c 2d                	cmp    $0x2d,%al
  800fb5:	75 0a                	jne    800fc1 <strtol+0x4c>
		s++, neg = 1;
  800fb7:	ff 45 08             	incl   0x8(%ebp)
  800fba:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fc1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc5:	74 06                	je     800fcd <strtol+0x58>
  800fc7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fcb:	75 20                	jne    800fed <strtol+0x78>
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	3c 30                	cmp    $0x30,%al
  800fd4:	75 17                	jne    800fed <strtol+0x78>
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	40                   	inc    %eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 78                	cmp    $0x78,%al
  800fde:	75 0d                	jne    800fed <strtol+0x78>
		s += 2, base = 16;
  800fe0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fe4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800feb:	eb 28                	jmp    801015 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff1:	75 15                	jne    801008 <strtol+0x93>
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 30                	cmp    $0x30,%al
  800ffa:	75 0c                	jne    801008 <strtol+0x93>
		s++, base = 8;
  800ffc:	ff 45 08             	incl   0x8(%ebp)
  800fff:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801006:	eb 0d                	jmp    801015 <strtol+0xa0>
	else if (base == 0)
  801008:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80100c:	75 07                	jne    801015 <strtol+0xa0>
		base = 10;
  80100e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	3c 2f                	cmp    $0x2f,%al
  80101c:	7e 19                	jle    801037 <strtol+0xc2>
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	3c 39                	cmp    $0x39,%al
  801025:	7f 10                	jg     801037 <strtol+0xc2>
			dig = *s - '0';
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	0f be c0             	movsbl %al,%eax
  80102f:	83 e8 30             	sub    $0x30,%eax
  801032:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801035:	eb 42                	jmp    801079 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	8a 00                	mov    (%eax),%al
  80103c:	3c 60                	cmp    $0x60,%al
  80103e:	7e 19                	jle    801059 <strtol+0xe4>
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	3c 7a                	cmp    $0x7a,%al
  801047:	7f 10                	jg     801059 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	0f be c0             	movsbl %al,%eax
  801051:	83 e8 57             	sub    $0x57,%eax
  801054:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801057:	eb 20                	jmp    801079 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	3c 40                	cmp    $0x40,%al
  801060:	7e 39                	jle    80109b <strtol+0x126>
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
  801065:	8a 00                	mov    (%eax),%al
  801067:	3c 5a                	cmp    $0x5a,%al
  801069:	7f 30                	jg     80109b <strtol+0x126>
			dig = *s - 'A' + 10;
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	0f be c0             	movsbl %al,%eax
  801073:	83 e8 37             	sub    $0x37,%eax
  801076:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801079:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80107c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80107f:	7d 19                	jge    80109a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801081:	ff 45 08             	incl   0x8(%ebp)
  801084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801087:	0f af 45 10          	imul   0x10(%ebp),%eax
  80108b:	89 c2                	mov    %eax,%edx
  80108d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801090:	01 d0                	add    %edx,%eax
  801092:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801095:	e9 7b ff ff ff       	jmp    801015 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80109a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80109b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80109f:	74 08                	je     8010a9 <strtol+0x134>
		*endptr = (char *) s;
  8010a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a4:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010a9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010ad:	74 07                	je     8010b6 <strtol+0x141>
  8010af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b2:	f7 d8                	neg    %eax
  8010b4:	eb 03                	jmp    8010b9 <strtol+0x144>
  8010b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <ltostr>:

void
ltostr(long value, char *str)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010c8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d3:	79 13                	jns    8010e8 <ltostr+0x2d>
	{
		neg = 1;
  8010d5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010df:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010e2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010e5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010eb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010f0:	99                   	cltd   
  8010f1:	f7 f9                	idiv   %ecx
  8010f3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f9:	8d 50 01             	lea    0x1(%eax),%edx
  8010fc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010ff:	89 c2                	mov    %eax,%edx
  801101:	8b 45 0c             	mov    0xc(%ebp),%eax
  801104:	01 d0                	add    %edx,%eax
  801106:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801109:	83 c2 30             	add    $0x30,%edx
  80110c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80110e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801111:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801116:	f7 e9                	imul   %ecx
  801118:	c1 fa 02             	sar    $0x2,%edx
  80111b:	89 c8                	mov    %ecx,%eax
  80111d:	c1 f8 1f             	sar    $0x1f,%eax
  801120:	29 c2                	sub    %eax,%edx
  801122:	89 d0                	mov    %edx,%eax
  801124:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801127:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80112a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80112f:	f7 e9                	imul   %ecx
  801131:	c1 fa 02             	sar    $0x2,%edx
  801134:	89 c8                	mov    %ecx,%eax
  801136:	c1 f8 1f             	sar    $0x1f,%eax
  801139:	29 c2                	sub    %eax,%edx
  80113b:	89 d0                	mov    %edx,%eax
  80113d:	c1 e0 02             	shl    $0x2,%eax
  801140:	01 d0                	add    %edx,%eax
  801142:	01 c0                	add    %eax,%eax
  801144:	29 c1                	sub    %eax,%ecx
  801146:	89 ca                	mov    %ecx,%edx
  801148:	85 d2                	test   %edx,%edx
  80114a:	75 9c                	jne    8010e8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80114c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801153:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801156:	48                   	dec    %eax
  801157:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80115a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80115e:	74 3d                	je     80119d <ltostr+0xe2>
		start = 1 ;
  801160:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801167:	eb 34                	jmp    80119d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801169:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	01 d0                	add    %edx,%eax
  801171:	8a 00                	mov    (%eax),%al
  801173:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801176:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	01 c2                	add    %eax,%edx
  80117e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801181:	8b 45 0c             	mov    0xc(%ebp),%eax
  801184:	01 c8                	add    %ecx,%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80118a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80118d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801190:	01 c2                	add    %eax,%edx
  801192:	8a 45 eb             	mov    -0x15(%ebp),%al
  801195:	88 02                	mov    %al,(%edx)
		start++ ;
  801197:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80119a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80119d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011a0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a3:	7c c4                	jl     801169 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011a5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ab:	01 d0                	add    %edx,%eax
  8011ad:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011b0:	90                   	nop
  8011b1:	c9                   	leave  
  8011b2:	c3                   	ret    

008011b3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011b3:	55                   	push   %ebp
  8011b4:	89 e5                	mov    %esp,%ebp
  8011b6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011b9:	ff 75 08             	pushl  0x8(%ebp)
  8011bc:	e8 54 fa ff ff       	call   800c15 <strlen>
  8011c1:	83 c4 04             	add    $0x4,%esp
  8011c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011c7:	ff 75 0c             	pushl  0xc(%ebp)
  8011ca:	e8 46 fa ff ff       	call   800c15 <strlen>
  8011cf:	83 c4 04             	add    $0x4,%esp
  8011d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011e3:	eb 17                	jmp    8011fc <strcconcat+0x49>
		final[s] = str1[s] ;
  8011e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011eb:	01 c2                	add    %eax,%edx
  8011ed:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	01 c8                	add    %ecx,%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011f9:	ff 45 fc             	incl   -0x4(%ebp)
  8011fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801202:	7c e1                	jl     8011e5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801204:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80120b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801212:	eb 1f                	jmp    801233 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801214:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801217:	8d 50 01             	lea    0x1(%eax),%edx
  80121a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80121d:	89 c2                	mov    %eax,%edx
  80121f:	8b 45 10             	mov    0x10(%ebp),%eax
  801222:	01 c2                	add    %eax,%edx
  801224:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122a:	01 c8                	add    %ecx,%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801230:	ff 45 f8             	incl   -0x8(%ebp)
  801233:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801236:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801239:	7c d9                	jl     801214 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80123b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123e:	8b 45 10             	mov    0x10(%ebp),%eax
  801241:	01 d0                	add    %edx,%eax
  801243:	c6 00 00             	movb   $0x0,(%eax)
}
  801246:	90                   	nop
  801247:	c9                   	leave  
  801248:	c3                   	ret    

00801249 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801249:	55                   	push   %ebp
  80124a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80124c:	8b 45 14             	mov    0x14(%ebp),%eax
  80124f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801255:	8b 45 14             	mov    0x14(%ebp),%eax
  801258:	8b 00                	mov    (%eax),%eax
  80125a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801261:	8b 45 10             	mov    0x10(%ebp),%eax
  801264:	01 d0                	add    %edx,%eax
  801266:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80126c:	eb 0c                	jmp    80127a <strsplit+0x31>
			*string++ = 0;
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	8d 50 01             	lea    0x1(%eax),%edx
  801274:	89 55 08             	mov    %edx,0x8(%ebp)
  801277:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	8a 00                	mov    (%eax),%al
  80127f:	84 c0                	test   %al,%al
  801281:	74 18                	je     80129b <strsplit+0x52>
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	8a 00                	mov    (%eax),%al
  801288:	0f be c0             	movsbl %al,%eax
  80128b:	50                   	push   %eax
  80128c:	ff 75 0c             	pushl  0xc(%ebp)
  80128f:	e8 13 fb ff ff       	call   800da7 <strchr>
  801294:	83 c4 08             	add    $0x8,%esp
  801297:	85 c0                	test   %eax,%eax
  801299:	75 d3                	jne    80126e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	8a 00                	mov    (%eax),%al
  8012a0:	84 c0                	test   %al,%al
  8012a2:	74 5a                	je     8012fe <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a7:	8b 00                	mov    (%eax),%eax
  8012a9:	83 f8 0f             	cmp    $0xf,%eax
  8012ac:	75 07                	jne    8012b5 <strsplit+0x6c>
		{
			return 0;
  8012ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8012b3:	eb 66                	jmp    80131b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b8:	8b 00                	mov    (%eax),%eax
  8012ba:	8d 48 01             	lea    0x1(%eax),%ecx
  8012bd:	8b 55 14             	mov    0x14(%ebp),%edx
  8012c0:	89 0a                	mov    %ecx,(%edx)
  8012c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cc:	01 c2                	add    %eax,%edx
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012d3:	eb 03                	jmp    8012d8 <strsplit+0x8f>
			string++;
  8012d5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8a 00                	mov    (%eax),%al
  8012dd:	84 c0                	test   %al,%al
  8012df:	74 8b                	je     80126c <strsplit+0x23>
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	8a 00                	mov    (%eax),%al
  8012e6:	0f be c0             	movsbl %al,%eax
  8012e9:	50                   	push   %eax
  8012ea:	ff 75 0c             	pushl  0xc(%ebp)
  8012ed:	e8 b5 fa ff ff       	call   800da7 <strchr>
  8012f2:	83 c4 08             	add    $0x8,%esp
  8012f5:	85 c0                	test   %eax,%eax
  8012f7:	74 dc                	je     8012d5 <strsplit+0x8c>
			string++;
	}
  8012f9:	e9 6e ff ff ff       	jmp    80126c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012fe:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801302:	8b 00                	mov    (%eax),%eax
  801304:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80130b:	8b 45 10             	mov    0x10(%ebp),%eax
  80130e:	01 d0                	add    %edx,%eax
  801310:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801316:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
  801320:	57                   	push   %edi
  801321:	56                   	push   %esi
  801322:	53                   	push   %ebx
  801323:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
  801329:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80132f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801332:	8b 7d 18             	mov    0x18(%ebp),%edi
  801335:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801338:	cd 30                	int    $0x30
  80133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80133d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801340:	83 c4 10             	add    $0x10,%esp
  801343:	5b                   	pop    %ebx
  801344:	5e                   	pop    %esi
  801345:	5f                   	pop    %edi
  801346:	5d                   	pop    %ebp
  801347:	c3                   	ret    

00801348 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801348:	55                   	push   %ebp
  801349:	89 e5                	mov    %esp,%ebp
  80134b:	83 ec 04             	sub    $0x4,%esp
  80134e:	8b 45 10             	mov    0x10(%ebp),%eax
  801351:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801354:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	52                   	push   %edx
  801360:	ff 75 0c             	pushl  0xc(%ebp)
  801363:	50                   	push   %eax
  801364:	6a 00                	push   $0x0
  801366:	e8 b2 ff ff ff       	call   80131d <syscall>
  80136b:	83 c4 18             	add    $0x18,%esp
}
  80136e:	90                   	nop
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <sys_cgetc>:

int
sys_cgetc(void)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 01                	push   $0x1
  801380:	e8 98 ff ff ff       	call   80131d <syscall>
  801385:	83 c4 18             	add    $0x18,%esp
}
  801388:	c9                   	leave  
  801389:	c3                   	ret    

0080138a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80138a:	55                   	push   %ebp
  80138b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	6a 00                	push   $0x0
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	50                   	push   %eax
  801399:	6a 05                	push   $0x5
  80139b:	e8 7d ff ff ff       	call   80131d <syscall>
  8013a0:	83 c4 18             	add    $0x18,%esp
}
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 02                	push   $0x2
  8013b4:	e8 64 ff ff ff       	call   80131d <syscall>
  8013b9:	83 c4 18             	add    $0x18,%esp
}
  8013bc:	c9                   	leave  
  8013bd:	c3                   	ret    

008013be <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 03                	push   $0x3
  8013cd:	e8 4b ff ff ff       	call   80131d <syscall>
  8013d2:	83 c4 18             	add    $0x18,%esp
}
  8013d5:	c9                   	leave  
  8013d6:	c3                   	ret    

008013d7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 04                	push   $0x4
  8013e6:	e8 32 ff ff ff       	call   80131d <syscall>
  8013eb:	83 c4 18             	add    $0x18,%esp
}
  8013ee:	c9                   	leave  
  8013ef:	c3                   	ret    

008013f0 <sys_env_exit>:


void sys_env_exit(void)
{
  8013f0:	55                   	push   %ebp
  8013f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 06                	push   $0x6
  8013ff:	e8 19 ff ff ff       	call   80131d <syscall>
  801404:	83 c4 18             	add    $0x18,%esp
}
  801407:	90                   	nop
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80140d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801410:	8b 45 08             	mov    0x8(%ebp),%eax
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	52                   	push   %edx
  80141a:	50                   	push   %eax
  80141b:	6a 07                	push   $0x7
  80141d:	e8 fb fe ff ff       	call   80131d <syscall>
  801422:	83 c4 18             	add    $0x18,%esp
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
  80142a:	56                   	push   %esi
  80142b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80142c:	8b 75 18             	mov    0x18(%ebp),%esi
  80142f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801432:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801435:	8b 55 0c             	mov    0xc(%ebp),%edx
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	56                   	push   %esi
  80143c:	53                   	push   %ebx
  80143d:	51                   	push   %ecx
  80143e:	52                   	push   %edx
  80143f:	50                   	push   %eax
  801440:	6a 08                	push   $0x8
  801442:	e8 d6 fe ff ff       	call   80131d <syscall>
  801447:	83 c4 18             	add    $0x18,%esp
}
  80144a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80144d:	5b                   	pop    %ebx
  80144e:	5e                   	pop    %esi
  80144f:	5d                   	pop    %ebp
  801450:	c3                   	ret    

00801451 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801454:	8b 55 0c             	mov    0xc(%ebp),%edx
  801457:	8b 45 08             	mov    0x8(%ebp),%eax
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	52                   	push   %edx
  801461:	50                   	push   %eax
  801462:	6a 09                	push   $0x9
  801464:	e8 b4 fe ff ff       	call   80131d <syscall>
  801469:	83 c4 18             	add    $0x18,%esp
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	ff 75 0c             	pushl  0xc(%ebp)
  80147a:	ff 75 08             	pushl  0x8(%ebp)
  80147d:	6a 0a                	push   $0xa
  80147f:	e8 99 fe ff ff       	call   80131d <syscall>
  801484:	83 c4 18             	add    $0x18,%esp
}
  801487:	c9                   	leave  
  801488:	c3                   	ret    

00801489 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801489:	55                   	push   %ebp
  80148a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 0b                	push   $0xb
  801498:	e8 80 fe ff ff       	call   80131d <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
}
  8014a0:	c9                   	leave  
  8014a1:	c3                   	ret    

008014a2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014a2:	55                   	push   %ebp
  8014a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 0c                	push   $0xc
  8014b1:	e8 67 fe ff ff       	call   80131d <syscall>
  8014b6:	83 c4 18             	add    $0x18,%esp
}
  8014b9:	c9                   	leave  
  8014ba:	c3                   	ret    

008014bb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 0d                	push   $0xd
  8014ca:	e8 4e fe ff ff       	call   80131d <syscall>
  8014cf:	83 c4 18             	add    $0x18,%esp
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	ff 75 08             	pushl  0x8(%ebp)
  8014e3:	6a 11                	push   $0x11
  8014e5:	e8 33 fe ff ff       	call   80131d <syscall>
  8014ea:	83 c4 18             	add    $0x18,%esp
	return;
  8014ed:	90                   	nop
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	ff 75 0c             	pushl  0xc(%ebp)
  8014fc:	ff 75 08             	pushl  0x8(%ebp)
  8014ff:	6a 12                	push   $0x12
  801501:	e8 17 fe ff ff       	call   80131d <syscall>
  801506:	83 c4 18             	add    $0x18,%esp
	return ;
  801509:	90                   	nop
}
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 0e                	push   $0xe
  80151b:	e8 fd fd ff ff       	call   80131d <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	ff 75 08             	pushl  0x8(%ebp)
  801533:	6a 0f                	push   $0xf
  801535:	e8 e3 fd ff ff       	call   80131d <syscall>
  80153a:	83 c4 18             	add    $0x18,%esp
}
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 10                	push   $0x10
  80154e:	e8 ca fd ff ff       	call   80131d <syscall>
  801553:	83 c4 18             	add    $0x18,%esp
}
  801556:	90                   	nop
  801557:	c9                   	leave  
  801558:	c3                   	ret    

00801559 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801559:	55                   	push   %ebp
  80155a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 14                	push   $0x14
  801568:	e8 b0 fd ff ff       	call   80131d <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	90                   	nop
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 15                	push   $0x15
  801582:	e8 96 fd ff ff       	call   80131d <syscall>
  801587:	83 c4 18             	add    $0x18,%esp
}
  80158a:	90                   	nop
  80158b:	c9                   	leave  
  80158c:	c3                   	ret    

0080158d <sys_cputc>:


void
sys_cputc(const char c)
{
  80158d:	55                   	push   %ebp
  80158e:	89 e5                	mov    %esp,%ebp
  801590:	83 ec 04             	sub    $0x4,%esp
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801599:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	50                   	push   %eax
  8015a6:	6a 16                	push   $0x16
  8015a8:	e8 70 fd ff ff       	call   80131d <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	90                   	nop
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 17                	push   $0x17
  8015c2:	e8 56 fd ff ff       	call   80131d <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	90                   	nop
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	ff 75 0c             	pushl  0xc(%ebp)
  8015dc:	50                   	push   %eax
  8015dd:	6a 18                	push   $0x18
  8015df:	e8 39 fd ff ff       	call   80131d <syscall>
  8015e4:	83 c4 18             	add    $0x18,%esp
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	52                   	push   %edx
  8015f9:	50                   	push   %eax
  8015fa:	6a 1b                	push   $0x1b
  8015fc:	e8 1c fd ff ff       	call   80131d <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801609:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	52                   	push   %edx
  801616:	50                   	push   %eax
  801617:	6a 19                	push   $0x19
  801619:	e8 ff fc ff ff       	call   80131d <syscall>
  80161e:	83 c4 18             	add    $0x18,%esp
}
  801621:	90                   	nop
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801627:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	52                   	push   %edx
  801634:	50                   	push   %eax
  801635:	6a 1a                	push   $0x1a
  801637:	e8 e1 fc ff ff       	call   80131d <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
}
  80163f:	90                   	nop
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
  801645:	83 ec 04             	sub    $0x4,%esp
  801648:	8b 45 10             	mov    0x10(%ebp),%eax
  80164b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80164e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801651:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	6a 00                	push   $0x0
  80165a:	51                   	push   %ecx
  80165b:	52                   	push   %edx
  80165c:	ff 75 0c             	pushl  0xc(%ebp)
  80165f:	50                   	push   %eax
  801660:	6a 1c                	push   $0x1c
  801662:	e8 b6 fc ff ff       	call   80131d <syscall>
  801667:	83 c4 18             	add    $0x18,%esp
}
  80166a:	c9                   	leave  
  80166b:	c3                   	ret    

0080166c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80166c:	55                   	push   %ebp
  80166d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80166f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	52                   	push   %edx
  80167c:	50                   	push   %eax
  80167d:	6a 1d                	push   $0x1d
  80167f:	e8 99 fc ff ff       	call   80131d <syscall>
  801684:	83 c4 18             	add    $0x18,%esp
}
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80168c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80168f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801692:	8b 45 08             	mov    0x8(%ebp),%eax
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	51                   	push   %ecx
  80169a:	52                   	push   %edx
  80169b:	50                   	push   %eax
  80169c:	6a 1e                	push   $0x1e
  80169e:	e8 7a fc ff ff       	call   80131d <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	c9                   	leave  
  8016a7:	c3                   	ret    

008016a8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	52                   	push   %edx
  8016b8:	50                   	push   %eax
  8016b9:	6a 1f                	push   $0x1f
  8016bb:	e8 5d fc ff ff       	call   80131d <syscall>
  8016c0:	83 c4 18             	add    $0x18,%esp
}
  8016c3:	c9                   	leave  
  8016c4:	c3                   	ret    

008016c5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016c5:	55                   	push   %ebp
  8016c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 20                	push   $0x20
  8016d4:	e8 44 fc ff ff       	call   80131d <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	6a 00                	push   $0x0
  8016e6:	ff 75 14             	pushl  0x14(%ebp)
  8016e9:	ff 75 10             	pushl  0x10(%ebp)
  8016ec:	ff 75 0c             	pushl  0xc(%ebp)
  8016ef:	50                   	push   %eax
  8016f0:	6a 21                	push   $0x21
  8016f2:	e8 26 fc ff ff       	call   80131d <syscall>
  8016f7:	83 c4 18             	add    $0x18,%esp
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	50                   	push   %eax
  80170b:	6a 22                	push   $0x22
  80170d:	e8 0b fc ff ff       	call   80131d <syscall>
  801712:	83 c4 18             	add    $0x18,%esp
}
  801715:	90                   	nop
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	50                   	push   %eax
  801727:	6a 23                	push   $0x23
  801729:	e8 ef fb ff ff       	call   80131d <syscall>
  80172e:	83 c4 18             	add    $0x18,%esp
}
  801731:	90                   	nop
  801732:	c9                   	leave  
  801733:	c3                   	ret    

00801734 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
  801737:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80173a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80173d:	8d 50 04             	lea    0x4(%eax),%edx
  801740:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	52                   	push   %edx
  80174a:	50                   	push   %eax
  80174b:	6a 24                	push   $0x24
  80174d:	e8 cb fb ff ff       	call   80131d <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
	return result;
  801755:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801758:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80175e:	89 01                	mov    %eax,(%ecx)
  801760:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	c9                   	leave  
  801767:	c2 04 00             	ret    $0x4

0080176a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	ff 75 10             	pushl  0x10(%ebp)
  801774:	ff 75 0c             	pushl  0xc(%ebp)
  801777:	ff 75 08             	pushl  0x8(%ebp)
  80177a:	6a 13                	push   $0x13
  80177c:	e8 9c fb ff ff       	call   80131d <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
	return ;
  801784:	90                   	nop
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_rcr2>:
uint32 sys_rcr2()
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 25                	push   $0x25
  801796:	e8 82 fb ff ff       	call   80131d <syscall>
  80179b:	83 c4 18             	add    $0x18,%esp
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
  8017a3:	83 ec 04             	sub    $0x4,%esp
  8017a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017ac:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	50                   	push   %eax
  8017b9:	6a 26                	push   $0x26
  8017bb:	e8 5d fb ff ff       	call   80131d <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c3:	90                   	nop
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <rsttst>:
void rsttst()
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 28                	push   $0x28
  8017d5:	e8 43 fb ff ff       	call   80131d <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
	return ;
  8017dd:	90                   	nop
}
  8017de:	c9                   	leave  
  8017df:	c3                   	ret    

008017e0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017e0:	55                   	push   %ebp
  8017e1:	89 e5                	mov    %esp,%ebp
  8017e3:	83 ec 04             	sub    $0x4,%esp
  8017e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8017e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017ec:	8b 55 18             	mov    0x18(%ebp),%edx
  8017ef:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017f3:	52                   	push   %edx
  8017f4:	50                   	push   %eax
  8017f5:	ff 75 10             	pushl  0x10(%ebp)
  8017f8:	ff 75 0c             	pushl  0xc(%ebp)
  8017fb:	ff 75 08             	pushl  0x8(%ebp)
  8017fe:	6a 27                	push   $0x27
  801800:	e8 18 fb ff ff       	call   80131d <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
	return ;
  801808:	90                   	nop
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <chktst>:
void chktst(uint32 n)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	ff 75 08             	pushl  0x8(%ebp)
  801819:	6a 29                	push   $0x29
  80181b:	e8 fd fa ff ff       	call   80131d <syscall>
  801820:	83 c4 18             	add    $0x18,%esp
	return ;
  801823:	90                   	nop
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <inctst>:

void inctst()
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 2a                	push   $0x2a
  801835:	e8 e3 fa ff ff       	call   80131d <syscall>
  80183a:	83 c4 18             	add    $0x18,%esp
	return ;
  80183d:	90                   	nop
}
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <gettst>:
uint32 gettst()
{
  801840:	55                   	push   %ebp
  801841:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 2b                	push   $0x2b
  80184f:	e8 c9 fa ff ff       	call   80131d <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
}
  801857:	c9                   	leave  
  801858:	c3                   	ret    

00801859 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
  80185c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 2c                	push   $0x2c
  80186b:	e8 ad fa ff ff       	call   80131d <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
  801873:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801876:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80187a:	75 07                	jne    801883 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80187c:	b8 01 00 00 00       	mov    $0x1,%eax
  801881:	eb 05                	jmp    801888 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801883:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
  80188d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 2c                	push   $0x2c
  80189c:	e8 7c fa ff ff       	call   80131d <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
  8018a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018a7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018ab:	75 07                	jne    8018b4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b2:	eb 05                	jmp    8018b9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
  8018be:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 2c                	push   $0x2c
  8018cd:	e8 4b fa ff ff       	call   80131d <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
  8018d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018d8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018dc:	75 07                	jne    8018e5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018de:	b8 01 00 00 00       	mov    $0x1,%eax
  8018e3:	eb 05                	jmp    8018ea <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
  8018ef:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 2c                	push   $0x2c
  8018fe:	e8 1a fa ff ff       	call   80131d <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
  801906:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801909:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80190d:	75 07                	jne    801916 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80190f:	b8 01 00 00 00       	mov    $0x1,%eax
  801914:	eb 05                	jmp    80191b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801916:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	ff 75 08             	pushl  0x8(%ebp)
  80192b:	6a 2d                	push   $0x2d
  80192d:	e8 eb f9 ff ff       	call   80131d <syscall>
  801932:	83 c4 18             	add    $0x18,%esp
	return ;
  801935:	90                   	nop
}
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
  80193b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80193c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80193f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801942:	8b 55 0c             	mov    0xc(%ebp),%edx
  801945:	8b 45 08             	mov    0x8(%ebp),%eax
  801948:	6a 00                	push   $0x0
  80194a:	53                   	push   %ebx
  80194b:	51                   	push   %ecx
  80194c:	52                   	push   %edx
  80194d:	50                   	push   %eax
  80194e:	6a 2e                	push   $0x2e
  801950:	e8 c8 f9 ff ff       	call   80131d <syscall>
  801955:	83 c4 18             	add    $0x18,%esp
}
  801958:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801960:	8b 55 0c             	mov    0xc(%ebp),%edx
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	52                   	push   %edx
  80196d:	50                   	push   %eax
  80196e:	6a 2f                	push   $0x2f
  801970:	e8 a8 f9 ff ff       	call   80131d <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	c9                   	leave  
  801979:	c3                   	ret    

0080197a <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
  80197d:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801980:	8b 55 08             	mov    0x8(%ebp),%edx
  801983:	89 d0                	mov    %edx,%eax
  801985:	c1 e0 02             	shl    $0x2,%eax
  801988:	01 d0                	add    %edx,%eax
  80198a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801991:	01 d0                	add    %edx,%eax
  801993:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199a:	01 d0                	add    %edx,%eax
  80199c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a3:	01 d0                	add    %edx,%eax
  8019a5:	c1 e0 04             	shl    $0x4,%eax
  8019a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019b2:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019b5:	83 ec 0c             	sub    $0xc,%esp
  8019b8:	50                   	push   %eax
  8019b9:	e8 76 fd ff ff       	call   801734 <sys_get_virtual_time>
  8019be:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019c1:	eb 41                	jmp    801a04 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019c6:	83 ec 0c             	sub    $0xc,%esp
  8019c9:	50                   	push   %eax
  8019ca:	e8 65 fd ff ff       	call   801734 <sys_get_virtual_time>
  8019cf:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019d2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019d8:	29 c2                	sub    %eax,%edx
  8019da:	89 d0                	mov    %edx,%eax
  8019dc:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019e5:	89 d1                	mov    %edx,%ecx
  8019e7:	29 c1                	sub    %eax,%ecx
  8019e9:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8019ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019ef:	39 c2                	cmp    %eax,%edx
  8019f1:	0f 97 c0             	seta   %al
  8019f4:	0f b6 c0             	movzbl %al,%eax
  8019f7:	29 c1                	sub    %eax,%ecx
  8019f9:	89 c8                	mov    %ecx,%eax
  8019fb:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8019fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a01:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a07:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a0a:	72 b7                	jb     8019c3 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a0c:	90                   	nop
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
  801a12:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a1c:	eb 03                	jmp    801a21 <busy_wait+0x12>
  801a1e:	ff 45 fc             	incl   -0x4(%ebp)
  801a21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a24:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a27:	72 f5                	jb     801a1e <busy_wait+0xf>
	return i;
  801a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a2c:	c9                   	leave  
  801a2d:	c3                   	ret    
  801a2e:	66 90                	xchg   %ax,%ax

00801a30 <__udivdi3>:
  801a30:	55                   	push   %ebp
  801a31:	57                   	push   %edi
  801a32:	56                   	push   %esi
  801a33:	53                   	push   %ebx
  801a34:	83 ec 1c             	sub    $0x1c,%esp
  801a37:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a3b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a43:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a47:	89 ca                	mov    %ecx,%edx
  801a49:	89 f8                	mov    %edi,%eax
  801a4b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a4f:	85 f6                	test   %esi,%esi
  801a51:	75 2d                	jne    801a80 <__udivdi3+0x50>
  801a53:	39 cf                	cmp    %ecx,%edi
  801a55:	77 65                	ja     801abc <__udivdi3+0x8c>
  801a57:	89 fd                	mov    %edi,%ebp
  801a59:	85 ff                	test   %edi,%edi
  801a5b:	75 0b                	jne    801a68 <__udivdi3+0x38>
  801a5d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a62:	31 d2                	xor    %edx,%edx
  801a64:	f7 f7                	div    %edi
  801a66:	89 c5                	mov    %eax,%ebp
  801a68:	31 d2                	xor    %edx,%edx
  801a6a:	89 c8                	mov    %ecx,%eax
  801a6c:	f7 f5                	div    %ebp
  801a6e:	89 c1                	mov    %eax,%ecx
  801a70:	89 d8                	mov    %ebx,%eax
  801a72:	f7 f5                	div    %ebp
  801a74:	89 cf                	mov    %ecx,%edi
  801a76:	89 fa                	mov    %edi,%edx
  801a78:	83 c4 1c             	add    $0x1c,%esp
  801a7b:	5b                   	pop    %ebx
  801a7c:	5e                   	pop    %esi
  801a7d:	5f                   	pop    %edi
  801a7e:	5d                   	pop    %ebp
  801a7f:	c3                   	ret    
  801a80:	39 ce                	cmp    %ecx,%esi
  801a82:	77 28                	ja     801aac <__udivdi3+0x7c>
  801a84:	0f bd fe             	bsr    %esi,%edi
  801a87:	83 f7 1f             	xor    $0x1f,%edi
  801a8a:	75 40                	jne    801acc <__udivdi3+0x9c>
  801a8c:	39 ce                	cmp    %ecx,%esi
  801a8e:	72 0a                	jb     801a9a <__udivdi3+0x6a>
  801a90:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a94:	0f 87 9e 00 00 00    	ja     801b38 <__udivdi3+0x108>
  801a9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9f:	89 fa                	mov    %edi,%edx
  801aa1:	83 c4 1c             	add    $0x1c,%esp
  801aa4:	5b                   	pop    %ebx
  801aa5:	5e                   	pop    %esi
  801aa6:	5f                   	pop    %edi
  801aa7:	5d                   	pop    %ebp
  801aa8:	c3                   	ret    
  801aa9:	8d 76 00             	lea    0x0(%esi),%esi
  801aac:	31 ff                	xor    %edi,%edi
  801aae:	31 c0                	xor    %eax,%eax
  801ab0:	89 fa                	mov    %edi,%edx
  801ab2:	83 c4 1c             	add    $0x1c,%esp
  801ab5:	5b                   	pop    %ebx
  801ab6:	5e                   	pop    %esi
  801ab7:	5f                   	pop    %edi
  801ab8:	5d                   	pop    %ebp
  801ab9:	c3                   	ret    
  801aba:	66 90                	xchg   %ax,%ax
  801abc:	89 d8                	mov    %ebx,%eax
  801abe:	f7 f7                	div    %edi
  801ac0:	31 ff                	xor    %edi,%edi
  801ac2:	89 fa                	mov    %edi,%edx
  801ac4:	83 c4 1c             	add    $0x1c,%esp
  801ac7:	5b                   	pop    %ebx
  801ac8:	5e                   	pop    %esi
  801ac9:	5f                   	pop    %edi
  801aca:	5d                   	pop    %ebp
  801acb:	c3                   	ret    
  801acc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad1:	89 eb                	mov    %ebp,%ebx
  801ad3:	29 fb                	sub    %edi,%ebx
  801ad5:	89 f9                	mov    %edi,%ecx
  801ad7:	d3 e6                	shl    %cl,%esi
  801ad9:	89 c5                	mov    %eax,%ebp
  801adb:	88 d9                	mov    %bl,%cl
  801add:	d3 ed                	shr    %cl,%ebp
  801adf:	89 e9                	mov    %ebp,%ecx
  801ae1:	09 f1                	or     %esi,%ecx
  801ae3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ae7:	89 f9                	mov    %edi,%ecx
  801ae9:	d3 e0                	shl    %cl,%eax
  801aeb:	89 c5                	mov    %eax,%ebp
  801aed:	89 d6                	mov    %edx,%esi
  801aef:	88 d9                	mov    %bl,%cl
  801af1:	d3 ee                	shr    %cl,%esi
  801af3:	89 f9                	mov    %edi,%ecx
  801af5:	d3 e2                	shl    %cl,%edx
  801af7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801afb:	88 d9                	mov    %bl,%cl
  801afd:	d3 e8                	shr    %cl,%eax
  801aff:	09 c2                	or     %eax,%edx
  801b01:	89 d0                	mov    %edx,%eax
  801b03:	89 f2                	mov    %esi,%edx
  801b05:	f7 74 24 0c          	divl   0xc(%esp)
  801b09:	89 d6                	mov    %edx,%esi
  801b0b:	89 c3                	mov    %eax,%ebx
  801b0d:	f7 e5                	mul    %ebp
  801b0f:	39 d6                	cmp    %edx,%esi
  801b11:	72 19                	jb     801b2c <__udivdi3+0xfc>
  801b13:	74 0b                	je     801b20 <__udivdi3+0xf0>
  801b15:	89 d8                	mov    %ebx,%eax
  801b17:	31 ff                	xor    %edi,%edi
  801b19:	e9 58 ff ff ff       	jmp    801a76 <__udivdi3+0x46>
  801b1e:	66 90                	xchg   %ax,%ax
  801b20:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b24:	89 f9                	mov    %edi,%ecx
  801b26:	d3 e2                	shl    %cl,%edx
  801b28:	39 c2                	cmp    %eax,%edx
  801b2a:	73 e9                	jae    801b15 <__udivdi3+0xe5>
  801b2c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b2f:	31 ff                	xor    %edi,%edi
  801b31:	e9 40 ff ff ff       	jmp    801a76 <__udivdi3+0x46>
  801b36:	66 90                	xchg   %ax,%ax
  801b38:	31 c0                	xor    %eax,%eax
  801b3a:	e9 37 ff ff ff       	jmp    801a76 <__udivdi3+0x46>
  801b3f:	90                   	nop

00801b40 <__umoddi3>:
  801b40:	55                   	push   %ebp
  801b41:	57                   	push   %edi
  801b42:	56                   	push   %esi
  801b43:	53                   	push   %ebx
  801b44:	83 ec 1c             	sub    $0x1c,%esp
  801b47:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b4b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b4f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b53:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b57:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b5b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b5f:	89 f3                	mov    %esi,%ebx
  801b61:	89 fa                	mov    %edi,%edx
  801b63:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b67:	89 34 24             	mov    %esi,(%esp)
  801b6a:	85 c0                	test   %eax,%eax
  801b6c:	75 1a                	jne    801b88 <__umoddi3+0x48>
  801b6e:	39 f7                	cmp    %esi,%edi
  801b70:	0f 86 a2 00 00 00    	jbe    801c18 <__umoddi3+0xd8>
  801b76:	89 c8                	mov    %ecx,%eax
  801b78:	89 f2                	mov    %esi,%edx
  801b7a:	f7 f7                	div    %edi
  801b7c:	89 d0                	mov    %edx,%eax
  801b7e:	31 d2                	xor    %edx,%edx
  801b80:	83 c4 1c             	add    $0x1c,%esp
  801b83:	5b                   	pop    %ebx
  801b84:	5e                   	pop    %esi
  801b85:	5f                   	pop    %edi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    
  801b88:	39 f0                	cmp    %esi,%eax
  801b8a:	0f 87 ac 00 00 00    	ja     801c3c <__umoddi3+0xfc>
  801b90:	0f bd e8             	bsr    %eax,%ebp
  801b93:	83 f5 1f             	xor    $0x1f,%ebp
  801b96:	0f 84 ac 00 00 00    	je     801c48 <__umoddi3+0x108>
  801b9c:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba1:	29 ef                	sub    %ebp,%edi
  801ba3:	89 fe                	mov    %edi,%esi
  801ba5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ba9:	89 e9                	mov    %ebp,%ecx
  801bab:	d3 e0                	shl    %cl,%eax
  801bad:	89 d7                	mov    %edx,%edi
  801baf:	89 f1                	mov    %esi,%ecx
  801bb1:	d3 ef                	shr    %cl,%edi
  801bb3:	09 c7                	or     %eax,%edi
  801bb5:	89 e9                	mov    %ebp,%ecx
  801bb7:	d3 e2                	shl    %cl,%edx
  801bb9:	89 14 24             	mov    %edx,(%esp)
  801bbc:	89 d8                	mov    %ebx,%eax
  801bbe:	d3 e0                	shl    %cl,%eax
  801bc0:	89 c2                	mov    %eax,%edx
  801bc2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc6:	d3 e0                	shl    %cl,%eax
  801bc8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bcc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd0:	89 f1                	mov    %esi,%ecx
  801bd2:	d3 e8                	shr    %cl,%eax
  801bd4:	09 d0                	or     %edx,%eax
  801bd6:	d3 eb                	shr    %cl,%ebx
  801bd8:	89 da                	mov    %ebx,%edx
  801bda:	f7 f7                	div    %edi
  801bdc:	89 d3                	mov    %edx,%ebx
  801bde:	f7 24 24             	mull   (%esp)
  801be1:	89 c6                	mov    %eax,%esi
  801be3:	89 d1                	mov    %edx,%ecx
  801be5:	39 d3                	cmp    %edx,%ebx
  801be7:	0f 82 87 00 00 00    	jb     801c74 <__umoddi3+0x134>
  801bed:	0f 84 91 00 00 00    	je     801c84 <__umoddi3+0x144>
  801bf3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bf7:	29 f2                	sub    %esi,%edx
  801bf9:	19 cb                	sbb    %ecx,%ebx
  801bfb:	89 d8                	mov    %ebx,%eax
  801bfd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c01:	d3 e0                	shl    %cl,%eax
  801c03:	89 e9                	mov    %ebp,%ecx
  801c05:	d3 ea                	shr    %cl,%edx
  801c07:	09 d0                	or     %edx,%eax
  801c09:	89 e9                	mov    %ebp,%ecx
  801c0b:	d3 eb                	shr    %cl,%ebx
  801c0d:	89 da                	mov    %ebx,%edx
  801c0f:	83 c4 1c             	add    $0x1c,%esp
  801c12:	5b                   	pop    %ebx
  801c13:	5e                   	pop    %esi
  801c14:	5f                   	pop    %edi
  801c15:	5d                   	pop    %ebp
  801c16:	c3                   	ret    
  801c17:	90                   	nop
  801c18:	89 fd                	mov    %edi,%ebp
  801c1a:	85 ff                	test   %edi,%edi
  801c1c:	75 0b                	jne    801c29 <__umoddi3+0xe9>
  801c1e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c23:	31 d2                	xor    %edx,%edx
  801c25:	f7 f7                	div    %edi
  801c27:	89 c5                	mov    %eax,%ebp
  801c29:	89 f0                	mov    %esi,%eax
  801c2b:	31 d2                	xor    %edx,%edx
  801c2d:	f7 f5                	div    %ebp
  801c2f:	89 c8                	mov    %ecx,%eax
  801c31:	f7 f5                	div    %ebp
  801c33:	89 d0                	mov    %edx,%eax
  801c35:	e9 44 ff ff ff       	jmp    801b7e <__umoddi3+0x3e>
  801c3a:	66 90                	xchg   %ax,%ax
  801c3c:	89 c8                	mov    %ecx,%eax
  801c3e:	89 f2                	mov    %esi,%edx
  801c40:	83 c4 1c             	add    $0x1c,%esp
  801c43:	5b                   	pop    %ebx
  801c44:	5e                   	pop    %esi
  801c45:	5f                   	pop    %edi
  801c46:	5d                   	pop    %ebp
  801c47:	c3                   	ret    
  801c48:	3b 04 24             	cmp    (%esp),%eax
  801c4b:	72 06                	jb     801c53 <__umoddi3+0x113>
  801c4d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c51:	77 0f                	ja     801c62 <__umoddi3+0x122>
  801c53:	89 f2                	mov    %esi,%edx
  801c55:	29 f9                	sub    %edi,%ecx
  801c57:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c5b:	89 14 24             	mov    %edx,(%esp)
  801c5e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c62:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c66:	8b 14 24             	mov    (%esp),%edx
  801c69:	83 c4 1c             	add    $0x1c,%esp
  801c6c:	5b                   	pop    %ebx
  801c6d:	5e                   	pop    %esi
  801c6e:	5f                   	pop    %edi
  801c6f:	5d                   	pop    %ebp
  801c70:	c3                   	ret    
  801c71:	8d 76 00             	lea    0x0(%esi),%esi
  801c74:	2b 04 24             	sub    (%esp),%eax
  801c77:	19 fa                	sbb    %edi,%edx
  801c79:	89 d1                	mov    %edx,%ecx
  801c7b:	89 c6                	mov    %eax,%esi
  801c7d:	e9 71 ff ff ff       	jmp    801bf3 <__umoddi3+0xb3>
  801c82:	66 90                	xchg   %ax,%ax
  801c84:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c88:	72 ea                	jb     801c74 <__umoddi3+0x134>
  801c8a:	89 d9                	mov    %ebx,%ecx
  801c8c:	e9 62 ff ff ff       	jmp    801bf3 <__umoddi3+0xb3>
