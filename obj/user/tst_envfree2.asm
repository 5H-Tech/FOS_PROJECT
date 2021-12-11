
obj/user/tst_envfree2:     file format elf32-i386


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
  800031:	e8 43 01 00 00       	call   800179 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests environment free run tef2 10 5
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing scenario 2: using dynamic allocation and free
	// Testing removing the allocated pages (static & dynamic) in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 13 14 00 00       	call   801456 <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 8e 14 00 00       	call   8014d9 <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 60 1c 80 00       	push   $0x801c60
  800059:	e8 02 05 00 00       	call   800560 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes
	int32 envIdProcessA = sys_create_env("ef_ms1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  800061:	a1 20 30 80 00       	mov    0x803020,%eax
  800066:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80006c:	89 c2                	mov    %eax,%edx
  80006e:	a1 20 30 80 00       	mov    0x803020,%eax
  800073:	8b 40 74             	mov    0x74(%eax),%eax
  800076:	6a 32                	push   $0x32
  800078:	52                   	push   %edx
  800079:	50                   	push   %eax
  80007a:	68 93 1c 80 00       	push   $0x801c93
  80007f:	e8 27 16 00 00       	call   8016ab <sys_create_env>
  800084:	83 c4 10             	add    $0x10,%esp
  800087:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_ms2", (myEnv->page_WS_max_size)-3,(myEnv->SecondListSize), 50);
  80008a:	a1 20 30 80 00       	mov    0x803020,%eax
  80008f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800095:	89 c2                	mov    %eax,%edx
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 40 74             	mov    0x74(%eax),%eax
  80009f:	83 e8 03             	sub    $0x3,%eax
  8000a2:	6a 32                	push   $0x32
  8000a4:	52                   	push   %edx
  8000a5:	50                   	push   %eax
  8000a6:	68 9a 1c 80 00       	push   $0x801c9a
  8000ab:	e8 fb 15 00 00       	call   8016ab <sys_create_env>
  8000b0:	83 c4 10             	add    $0x10,%esp
  8000b3:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  8000b6:	83 ec 0c             	sub    $0xc,%esp
  8000b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000bc:	e8 08 16 00 00       	call   8016c9 <sys_run_env>
  8000c1:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000c4:	83 ec 0c             	sub    $0xc,%esp
  8000c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000ca:	e8 fa 15 00 00       	call   8016c9 <sys_run_env>
  8000cf:	83 c4 10             	add    $0x10,%esp

	env_sleep(30000);
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 30 75 00 00       	push   $0x7530
  8000da:	e8 68 18 00 00       	call   801947 <env_sleep>
  8000df:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000e2:	e8 6f 13 00 00       	call   801456 <sys_calculate_free_frames>
  8000e7:	83 ec 08             	sub    $0x8,%esp
  8000ea:	50                   	push   %eax
  8000eb:	68 a4 1c 80 00       	push   $0x801ca4
  8000f0:	e8 6b 04 00 00       	call   800560 <cprintf>
  8000f5:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	ff 75 ec             	pushl  -0x14(%ebp)
  8000fe:	e8 e2 15 00 00       	call   8016e5 <sys_free_env>
  800103:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  800106:	83 ec 0c             	sub    $0xc,%esp
  800109:	ff 75 e8             	pushl  -0x18(%ebp)
  80010c:	e8 d4 15 00 00       	call   8016e5 <sys_free_env>
  800111:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  800114:	e8 3d 13 00 00       	call   801456 <sys_calculate_free_frames>
  800119:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  80011c:	e8 b8 13 00 00       	call   8014d9 <sys_pf_calculate_allocated_pages>
  800121:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  800124:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800127:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80012a:	74 27                	je     800153 <_main+0x11b>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  80012c:	83 ec 08             	sub    $0x8,%esp
  80012f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800132:	68 d8 1c 80 00       	push   $0x801cd8
  800137:	e8 24 04 00 00       	call   800560 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	68 28 1d 80 00       	push   $0x801d28
  800147:	6a 24                	push   $0x24
  800149:	68 5e 1d 80 00       	push   $0x801d5e
  80014e:	e8 6b 01 00 00       	call   8002be <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	ff 75 e4             	pushl  -0x1c(%ebp)
  800159:	68 74 1d 80 00       	push   $0x801d74
  80015e:	e8 fd 03 00 00       	call   800560 <cprintf>
  800163:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 2 for envfree completed successfully.\n");
  800166:	83 ec 0c             	sub    $0xc,%esp
  800169:	68 d4 1d 80 00       	push   $0x801dd4
  80016e:	e8 ed 03 00 00       	call   800560 <cprintf>
  800173:	83 c4 10             	add    $0x10,%esp
	return;
  800176:	90                   	nop
}
  800177:	c9                   	leave  
  800178:	c3                   	ret    

00800179 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800179:	55                   	push   %ebp
  80017a:	89 e5                	mov    %esp,%ebp
  80017c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80017f:	e8 07 12 00 00       	call   80138b <sys_getenvindex>
  800184:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800187:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80018a:	89 d0                	mov    %edx,%eax
  80018c:	c1 e0 03             	shl    $0x3,%eax
  80018f:	01 d0                	add    %edx,%eax
  800191:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800198:	01 c8                	add    %ecx,%eax
  80019a:	01 c0                	add    %eax,%eax
  80019c:	01 d0                	add    %edx,%eax
  80019e:	01 c0                	add    %eax,%eax
  8001a0:	01 d0                	add    %edx,%eax
  8001a2:	89 c2                	mov    %eax,%edx
  8001a4:	c1 e2 05             	shl    $0x5,%edx
  8001a7:	29 c2                	sub    %eax,%edx
  8001a9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001b0:	89 c2                	mov    %eax,%edx
  8001b2:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001b8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c2:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001c8:	84 c0                	test   %al,%al
  8001ca:	74 0f                	je     8001db <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d1:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001d6:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001df:	7e 0a                	jle    8001eb <libmain+0x72>
		binaryname = argv[0];
  8001e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e4:	8b 00                	mov    (%eax),%eax
  8001e6:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001eb:	83 ec 08             	sub    $0x8,%esp
  8001ee:	ff 75 0c             	pushl  0xc(%ebp)
  8001f1:	ff 75 08             	pushl  0x8(%ebp)
  8001f4:	e8 3f fe ff ff       	call   800038 <_main>
  8001f9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001fc:	e8 25 13 00 00       	call   801526 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800201:	83 ec 0c             	sub    $0xc,%esp
  800204:	68 38 1e 80 00       	push   $0x801e38
  800209:	e8 52 03 00 00       	call   800560 <cprintf>
  80020e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80021c:	a1 20 30 80 00       	mov    0x803020,%eax
  800221:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800227:	83 ec 04             	sub    $0x4,%esp
  80022a:	52                   	push   %edx
  80022b:	50                   	push   %eax
  80022c:	68 60 1e 80 00       	push   $0x801e60
  800231:	e8 2a 03 00 00       	call   800560 <cprintf>
  800236:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800239:	a1 20 30 80 00       	mov    0x803020,%eax
  80023e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800244:	a1 20 30 80 00       	mov    0x803020,%eax
  800249:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80024f:	83 ec 04             	sub    $0x4,%esp
  800252:	52                   	push   %edx
  800253:	50                   	push   %eax
  800254:	68 88 1e 80 00       	push   $0x801e88
  800259:	e8 02 03 00 00       	call   800560 <cprintf>
  80025e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800261:	a1 20 30 80 00       	mov    0x803020,%eax
  800266:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80026c:	83 ec 08             	sub    $0x8,%esp
  80026f:	50                   	push   %eax
  800270:	68 c9 1e 80 00       	push   $0x801ec9
  800275:	e8 e6 02 00 00       	call   800560 <cprintf>
  80027a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	68 38 1e 80 00       	push   $0x801e38
  800285:	e8 d6 02 00 00       	call   800560 <cprintf>
  80028a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80028d:	e8 ae 12 00 00       	call   801540 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800292:	e8 19 00 00 00       	call   8002b0 <exit>
}
  800297:	90                   	nop
  800298:	c9                   	leave  
  800299:	c3                   	ret    

0080029a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80029a:	55                   	push   %ebp
  80029b:	89 e5                	mov    %esp,%ebp
  80029d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002a0:	83 ec 0c             	sub    $0xc,%esp
  8002a3:	6a 00                	push   $0x0
  8002a5:	e8 ad 10 00 00       	call   801357 <sys_env_destroy>
  8002aa:	83 c4 10             	add    $0x10,%esp
}
  8002ad:	90                   	nop
  8002ae:	c9                   	leave  
  8002af:	c3                   	ret    

008002b0 <exit>:

void
exit(void)
{
  8002b0:	55                   	push   %ebp
  8002b1:	89 e5                	mov    %esp,%ebp
  8002b3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002b6:	e8 02 11 00 00       	call   8013bd <sys_env_exit>
}
  8002bb:	90                   	nop
  8002bc:	c9                   	leave  
  8002bd:	c3                   	ret    

008002be <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002be:	55                   	push   %ebp
  8002bf:	89 e5                	mov    %esp,%ebp
  8002c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002c4:	8d 45 10             	lea    0x10(%ebp),%eax
  8002c7:	83 c0 04             	add    $0x4,%eax
  8002ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002cd:	a1 18 31 80 00       	mov    0x803118,%eax
  8002d2:	85 c0                	test   %eax,%eax
  8002d4:	74 16                	je     8002ec <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002d6:	a1 18 31 80 00       	mov    0x803118,%eax
  8002db:	83 ec 08             	sub    $0x8,%esp
  8002de:	50                   	push   %eax
  8002df:	68 e0 1e 80 00       	push   $0x801ee0
  8002e4:	e8 77 02 00 00       	call   800560 <cprintf>
  8002e9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002ec:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f1:	ff 75 0c             	pushl  0xc(%ebp)
  8002f4:	ff 75 08             	pushl  0x8(%ebp)
  8002f7:	50                   	push   %eax
  8002f8:	68 e5 1e 80 00       	push   $0x801ee5
  8002fd:	e8 5e 02 00 00       	call   800560 <cprintf>
  800302:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800305:	8b 45 10             	mov    0x10(%ebp),%eax
  800308:	83 ec 08             	sub    $0x8,%esp
  80030b:	ff 75 f4             	pushl  -0xc(%ebp)
  80030e:	50                   	push   %eax
  80030f:	e8 e1 01 00 00       	call   8004f5 <vcprintf>
  800314:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800317:	83 ec 08             	sub    $0x8,%esp
  80031a:	6a 00                	push   $0x0
  80031c:	68 01 1f 80 00       	push   $0x801f01
  800321:	e8 cf 01 00 00       	call   8004f5 <vcprintf>
  800326:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800329:	e8 82 ff ff ff       	call   8002b0 <exit>

	// should not return here
	while (1) ;
  80032e:	eb fe                	jmp    80032e <_panic+0x70>

00800330 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800330:	55                   	push   %ebp
  800331:	89 e5                	mov    %esp,%ebp
  800333:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800336:	a1 20 30 80 00       	mov    0x803020,%eax
  80033b:	8b 50 74             	mov    0x74(%eax),%edx
  80033e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800341:	39 c2                	cmp    %eax,%edx
  800343:	74 14                	je     800359 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 04 1f 80 00       	push   $0x801f04
  80034d:	6a 26                	push   $0x26
  80034f:	68 50 1f 80 00       	push   $0x801f50
  800354:	e8 65 ff ff ff       	call   8002be <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800359:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800360:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800367:	e9 b6 00 00 00       	jmp    800422 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80036c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800376:	8b 45 08             	mov    0x8(%ebp),%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	8b 00                	mov    (%eax),%eax
  80037d:	85 c0                	test   %eax,%eax
  80037f:	75 08                	jne    800389 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800381:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800384:	e9 96 00 00 00       	jmp    80041f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800389:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800390:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800397:	eb 5d                	jmp    8003f6 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800399:	a1 20 30 80 00       	mov    0x803020,%eax
  80039e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003a4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003a7:	c1 e2 04             	shl    $0x4,%edx
  8003aa:	01 d0                	add    %edx,%eax
  8003ac:	8a 40 04             	mov    0x4(%eax),%al
  8003af:	84 c0                	test   %al,%al
  8003b1:	75 40                	jne    8003f3 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c1:	c1 e2 04             	shl    $0x4,%edx
  8003c4:	01 d0                	add    %edx,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003d8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003df:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e2:	01 c8                	add    %ecx,%eax
  8003e4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003e6:	39 c2                	cmp    %eax,%edx
  8003e8:	75 09                	jne    8003f3 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003ea:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003f1:	eb 12                	jmp    800405 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003f3:	ff 45 e8             	incl   -0x18(%ebp)
  8003f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fb:	8b 50 74             	mov    0x74(%eax),%edx
  8003fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800401:	39 c2                	cmp    %eax,%edx
  800403:	77 94                	ja     800399 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800405:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800409:	75 14                	jne    80041f <CheckWSWithoutLastIndex+0xef>
			panic(
  80040b:	83 ec 04             	sub    $0x4,%esp
  80040e:	68 5c 1f 80 00       	push   $0x801f5c
  800413:	6a 3a                	push   $0x3a
  800415:	68 50 1f 80 00       	push   $0x801f50
  80041a:	e8 9f fe ff ff       	call   8002be <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80041f:	ff 45 f0             	incl   -0x10(%ebp)
  800422:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800425:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800428:	0f 8c 3e ff ff ff    	jl     80036c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80042e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800435:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80043c:	eb 20                	jmp    80045e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80043e:	a1 20 30 80 00       	mov    0x803020,%eax
  800443:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800449:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80044c:	c1 e2 04             	shl    $0x4,%edx
  80044f:	01 d0                	add    %edx,%eax
  800451:	8a 40 04             	mov    0x4(%eax),%al
  800454:	3c 01                	cmp    $0x1,%al
  800456:	75 03                	jne    80045b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800458:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80045b:	ff 45 e0             	incl   -0x20(%ebp)
  80045e:	a1 20 30 80 00       	mov    0x803020,%eax
  800463:	8b 50 74             	mov    0x74(%eax),%edx
  800466:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800469:	39 c2                	cmp    %eax,%edx
  80046b:	77 d1                	ja     80043e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80046d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800470:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800473:	74 14                	je     800489 <CheckWSWithoutLastIndex+0x159>
		panic(
  800475:	83 ec 04             	sub    $0x4,%esp
  800478:	68 b0 1f 80 00       	push   $0x801fb0
  80047d:	6a 44                	push   $0x44
  80047f:	68 50 1f 80 00       	push   $0x801f50
  800484:	e8 35 fe ff ff       	call   8002be <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800489:	90                   	nop
  80048a:	c9                   	leave  
  80048b:	c3                   	ret    

0080048c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80048c:	55                   	push   %ebp
  80048d:	89 e5                	mov    %esp,%ebp
  80048f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800492:	8b 45 0c             	mov    0xc(%ebp),%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	8d 48 01             	lea    0x1(%eax),%ecx
  80049a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80049d:	89 0a                	mov    %ecx,(%edx)
  80049f:	8b 55 08             	mov    0x8(%ebp),%edx
  8004a2:	88 d1                	mov    %dl,%cl
  8004a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004a7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ae:	8b 00                	mov    (%eax),%eax
  8004b0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004b5:	75 2c                	jne    8004e3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004b7:	a0 24 30 80 00       	mov    0x803024,%al
  8004bc:	0f b6 c0             	movzbl %al,%eax
  8004bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c2:	8b 12                	mov    (%edx),%edx
  8004c4:	89 d1                	mov    %edx,%ecx
  8004c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c9:	83 c2 08             	add    $0x8,%edx
  8004cc:	83 ec 04             	sub    $0x4,%esp
  8004cf:	50                   	push   %eax
  8004d0:	51                   	push   %ecx
  8004d1:	52                   	push   %edx
  8004d2:	e8 3e 0e 00 00       	call   801315 <sys_cputs>
  8004d7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e6:	8b 40 04             	mov    0x4(%eax),%eax
  8004e9:	8d 50 01             	lea    0x1(%eax),%edx
  8004ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ef:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004f2:	90                   	nop
  8004f3:	c9                   	leave  
  8004f4:	c3                   	ret    

008004f5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004f5:	55                   	push   %ebp
  8004f6:	89 e5                	mov    %esp,%ebp
  8004f8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800505:	00 00 00 
	b.cnt = 0;
  800508:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80050f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800512:	ff 75 0c             	pushl  0xc(%ebp)
  800515:	ff 75 08             	pushl  0x8(%ebp)
  800518:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80051e:	50                   	push   %eax
  80051f:	68 8c 04 80 00       	push   $0x80048c
  800524:	e8 11 02 00 00       	call   80073a <vprintfmt>
  800529:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80052c:	a0 24 30 80 00       	mov    0x803024,%al
  800531:	0f b6 c0             	movzbl %al,%eax
  800534:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80053a:	83 ec 04             	sub    $0x4,%esp
  80053d:	50                   	push   %eax
  80053e:	52                   	push   %edx
  80053f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800545:	83 c0 08             	add    $0x8,%eax
  800548:	50                   	push   %eax
  800549:	e8 c7 0d 00 00       	call   801315 <sys_cputs>
  80054e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800551:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800558:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80055e:	c9                   	leave  
  80055f:	c3                   	ret    

00800560 <cprintf>:

int cprintf(const char *fmt, ...) {
  800560:	55                   	push   %ebp
  800561:	89 e5                	mov    %esp,%ebp
  800563:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800566:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80056d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800570:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800573:	8b 45 08             	mov    0x8(%ebp),%eax
  800576:	83 ec 08             	sub    $0x8,%esp
  800579:	ff 75 f4             	pushl  -0xc(%ebp)
  80057c:	50                   	push   %eax
  80057d:	e8 73 ff ff ff       	call   8004f5 <vcprintf>
  800582:	83 c4 10             	add    $0x10,%esp
  800585:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800588:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80058b:	c9                   	leave  
  80058c:	c3                   	ret    

0080058d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80058d:	55                   	push   %ebp
  80058e:	89 e5                	mov    %esp,%ebp
  800590:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800593:	e8 8e 0f 00 00       	call   801526 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800598:	8d 45 0c             	lea    0xc(%ebp),%eax
  80059b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80059e:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8005a7:	50                   	push   %eax
  8005a8:	e8 48 ff ff ff       	call   8004f5 <vcprintf>
  8005ad:	83 c4 10             	add    $0x10,%esp
  8005b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005b3:	e8 88 0f 00 00       	call   801540 <sys_enable_interrupt>
	return cnt;
  8005b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005bb:	c9                   	leave  
  8005bc:	c3                   	ret    

008005bd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005bd:	55                   	push   %ebp
  8005be:	89 e5                	mov    %esp,%ebp
  8005c0:	53                   	push   %ebx
  8005c1:	83 ec 14             	sub    $0x14,%esp
  8005c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8005c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8005d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8005d8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005db:	77 55                	ja     800632 <printnum+0x75>
  8005dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005e0:	72 05                	jb     8005e7 <printnum+0x2a>
  8005e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005e5:	77 4b                	ja     800632 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005e7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005ea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8005f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8005f5:	52                   	push   %edx
  8005f6:	50                   	push   %eax
  8005f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8005fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8005fd:	e8 fa 13 00 00       	call   8019fc <__udivdi3>
  800602:	83 c4 10             	add    $0x10,%esp
  800605:	83 ec 04             	sub    $0x4,%esp
  800608:	ff 75 20             	pushl  0x20(%ebp)
  80060b:	53                   	push   %ebx
  80060c:	ff 75 18             	pushl  0x18(%ebp)
  80060f:	52                   	push   %edx
  800610:	50                   	push   %eax
  800611:	ff 75 0c             	pushl  0xc(%ebp)
  800614:	ff 75 08             	pushl  0x8(%ebp)
  800617:	e8 a1 ff ff ff       	call   8005bd <printnum>
  80061c:	83 c4 20             	add    $0x20,%esp
  80061f:	eb 1a                	jmp    80063b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800621:	83 ec 08             	sub    $0x8,%esp
  800624:	ff 75 0c             	pushl  0xc(%ebp)
  800627:	ff 75 20             	pushl  0x20(%ebp)
  80062a:	8b 45 08             	mov    0x8(%ebp),%eax
  80062d:	ff d0                	call   *%eax
  80062f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800632:	ff 4d 1c             	decl   0x1c(%ebp)
  800635:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800639:	7f e6                	jg     800621 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80063b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80063e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800643:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800646:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800649:	53                   	push   %ebx
  80064a:	51                   	push   %ecx
  80064b:	52                   	push   %edx
  80064c:	50                   	push   %eax
  80064d:	e8 ba 14 00 00       	call   801b0c <__umoddi3>
  800652:	83 c4 10             	add    $0x10,%esp
  800655:	05 14 22 80 00       	add    $0x802214,%eax
  80065a:	8a 00                	mov    (%eax),%al
  80065c:	0f be c0             	movsbl %al,%eax
  80065f:	83 ec 08             	sub    $0x8,%esp
  800662:	ff 75 0c             	pushl  0xc(%ebp)
  800665:	50                   	push   %eax
  800666:	8b 45 08             	mov    0x8(%ebp),%eax
  800669:	ff d0                	call   *%eax
  80066b:	83 c4 10             	add    $0x10,%esp
}
  80066e:	90                   	nop
  80066f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800677:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80067b:	7e 1c                	jle    800699 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	8b 00                	mov    (%eax),%eax
  800682:	8d 50 08             	lea    0x8(%eax),%edx
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	89 10                	mov    %edx,(%eax)
  80068a:	8b 45 08             	mov    0x8(%ebp),%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	83 e8 08             	sub    $0x8,%eax
  800692:	8b 50 04             	mov    0x4(%eax),%edx
  800695:	8b 00                	mov    (%eax),%eax
  800697:	eb 40                	jmp    8006d9 <getuint+0x65>
	else if (lflag)
  800699:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80069d:	74 1e                	je     8006bd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	8b 00                	mov    (%eax),%eax
  8006a4:	8d 50 04             	lea    0x4(%eax),%edx
  8006a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006aa:	89 10                	mov    %edx,(%eax)
  8006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8006af:	8b 00                	mov    (%eax),%eax
  8006b1:	83 e8 04             	sub    $0x4,%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8006bb:	eb 1c                	jmp    8006d9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	8d 50 04             	lea    0x4(%eax),%edx
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	89 10                	mov    %edx,(%eax)
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	83 e8 04             	sub    $0x4,%eax
  8006d2:	8b 00                	mov    (%eax),%eax
  8006d4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006d9:	5d                   	pop    %ebp
  8006da:	c3                   	ret    

008006db <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006db:	55                   	push   %ebp
  8006dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006e2:	7e 1c                	jle    800700 <getint+0x25>
		return va_arg(*ap, long long);
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	8b 00                	mov    (%eax),%eax
  8006e9:	8d 50 08             	lea    0x8(%eax),%edx
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	89 10                	mov    %edx,(%eax)
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	8b 00                	mov    (%eax),%eax
  8006f6:	83 e8 08             	sub    $0x8,%eax
  8006f9:	8b 50 04             	mov    0x4(%eax),%edx
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	eb 38                	jmp    800738 <getint+0x5d>
	else if (lflag)
  800700:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800704:	74 1a                	je     800720 <getint+0x45>
		return va_arg(*ap, long);
  800706:	8b 45 08             	mov    0x8(%ebp),%eax
  800709:	8b 00                	mov    (%eax),%eax
  80070b:	8d 50 04             	lea    0x4(%eax),%edx
  80070e:	8b 45 08             	mov    0x8(%ebp),%eax
  800711:	89 10                	mov    %edx,(%eax)
  800713:	8b 45 08             	mov    0x8(%ebp),%eax
  800716:	8b 00                	mov    (%eax),%eax
  800718:	83 e8 04             	sub    $0x4,%eax
  80071b:	8b 00                	mov    (%eax),%eax
  80071d:	99                   	cltd   
  80071e:	eb 18                	jmp    800738 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	8b 00                	mov    (%eax),%eax
  800725:	8d 50 04             	lea    0x4(%eax),%edx
  800728:	8b 45 08             	mov    0x8(%ebp),%eax
  80072b:	89 10                	mov    %edx,(%eax)
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	8b 00                	mov    (%eax),%eax
  800732:	83 e8 04             	sub    $0x4,%eax
  800735:	8b 00                	mov    (%eax),%eax
  800737:	99                   	cltd   
}
  800738:	5d                   	pop    %ebp
  800739:	c3                   	ret    

0080073a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80073a:	55                   	push   %ebp
  80073b:	89 e5                	mov    %esp,%ebp
  80073d:	56                   	push   %esi
  80073e:	53                   	push   %ebx
  80073f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800742:	eb 17                	jmp    80075b <vprintfmt+0x21>
			if (ch == '\0')
  800744:	85 db                	test   %ebx,%ebx
  800746:	0f 84 af 03 00 00    	je     800afb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 0c             	pushl  0xc(%ebp)
  800752:	53                   	push   %ebx
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	ff d0                	call   *%eax
  800758:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80075b:	8b 45 10             	mov    0x10(%ebp),%eax
  80075e:	8d 50 01             	lea    0x1(%eax),%edx
  800761:	89 55 10             	mov    %edx,0x10(%ebp)
  800764:	8a 00                	mov    (%eax),%al
  800766:	0f b6 d8             	movzbl %al,%ebx
  800769:	83 fb 25             	cmp    $0x25,%ebx
  80076c:	75 d6                	jne    800744 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80076e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800772:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800779:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800780:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800787:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80078e:	8b 45 10             	mov    0x10(%ebp),%eax
  800791:	8d 50 01             	lea    0x1(%eax),%edx
  800794:	89 55 10             	mov    %edx,0x10(%ebp)
  800797:	8a 00                	mov    (%eax),%al
  800799:	0f b6 d8             	movzbl %al,%ebx
  80079c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80079f:	83 f8 55             	cmp    $0x55,%eax
  8007a2:	0f 87 2b 03 00 00    	ja     800ad3 <vprintfmt+0x399>
  8007a8:	8b 04 85 38 22 80 00 	mov    0x802238(,%eax,4),%eax
  8007af:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007b1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007b5:	eb d7                	jmp    80078e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007b7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007bb:	eb d1                	jmp    80078e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007bd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007c7:	89 d0                	mov    %edx,%eax
  8007c9:	c1 e0 02             	shl    $0x2,%eax
  8007cc:	01 d0                	add    %edx,%eax
  8007ce:	01 c0                	add    %eax,%eax
  8007d0:	01 d8                	add    %ebx,%eax
  8007d2:	83 e8 30             	sub    $0x30,%eax
  8007d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007db:	8a 00                	mov    (%eax),%al
  8007dd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007e0:	83 fb 2f             	cmp    $0x2f,%ebx
  8007e3:	7e 3e                	jle    800823 <vprintfmt+0xe9>
  8007e5:	83 fb 39             	cmp    $0x39,%ebx
  8007e8:	7f 39                	jg     800823 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007ea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007ed:	eb d5                	jmp    8007c4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f2:	83 c0 04             	add    $0x4,%eax
  8007f5:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007fb:	83 e8 04             	sub    $0x4,%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800803:	eb 1f                	jmp    800824 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800805:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800809:	79 83                	jns    80078e <vprintfmt+0x54>
				width = 0;
  80080b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800812:	e9 77 ff ff ff       	jmp    80078e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800817:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80081e:	e9 6b ff ff ff       	jmp    80078e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800823:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800824:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800828:	0f 89 60 ff ff ff    	jns    80078e <vprintfmt+0x54>
				width = precision, precision = -1;
  80082e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800831:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800834:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80083b:	e9 4e ff ff ff       	jmp    80078e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800840:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800843:	e9 46 ff ff ff       	jmp    80078e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800848:	8b 45 14             	mov    0x14(%ebp),%eax
  80084b:	83 c0 04             	add    $0x4,%eax
  80084e:	89 45 14             	mov    %eax,0x14(%ebp)
  800851:	8b 45 14             	mov    0x14(%ebp),%eax
  800854:	83 e8 04             	sub    $0x4,%eax
  800857:	8b 00                	mov    (%eax),%eax
  800859:	83 ec 08             	sub    $0x8,%esp
  80085c:	ff 75 0c             	pushl  0xc(%ebp)
  80085f:	50                   	push   %eax
  800860:	8b 45 08             	mov    0x8(%ebp),%eax
  800863:	ff d0                	call   *%eax
  800865:	83 c4 10             	add    $0x10,%esp
			break;
  800868:	e9 89 02 00 00       	jmp    800af6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80086d:	8b 45 14             	mov    0x14(%ebp),%eax
  800870:	83 c0 04             	add    $0x4,%eax
  800873:	89 45 14             	mov    %eax,0x14(%ebp)
  800876:	8b 45 14             	mov    0x14(%ebp),%eax
  800879:	83 e8 04             	sub    $0x4,%eax
  80087c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80087e:	85 db                	test   %ebx,%ebx
  800880:	79 02                	jns    800884 <vprintfmt+0x14a>
				err = -err;
  800882:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800884:	83 fb 64             	cmp    $0x64,%ebx
  800887:	7f 0b                	jg     800894 <vprintfmt+0x15a>
  800889:	8b 34 9d 80 20 80 00 	mov    0x802080(,%ebx,4),%esi
  800890:	85 f6                	test   %esi,%esi
  800892:	75 19                	jne    8008ad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800894:	53                   	push   %ebx
  800895:	68 25 22 80 00       	push   $0x802225
  80089a:	ff 75 0c             	pushl  0xc(%ebp)
  80089d:	ff 75 08             	pushl  0x8(%ebp)
  8008a0:	e8 5e 02 00 00       	call   800b03 <printfmt>
  8008a5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008a8:	e9 49 02 00 00       	jmp    800af6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008ad:	56                   	push   %esi
  8008ae:	68 2e 22 80 00       	push   $0x80222e
  8008b3:	ff 75 0c             	pushl  0xc(%ebp)
  8008b6:	ff 75 08             	pushl  0x8(%ebp)
  8008b9:	e8 45 02 00 00       	call   800b03 <printfmt>
  8008be:	83 c4 10             	add    $0x10,%esp
			break;
  8008c1:	e9 30 02 00 00       	jmp    800af6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c9:	83 c0 04             	add    $0x4,%eax
  8008cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8008cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d2:	83 e8 04             	sub    $0x4,%eax
  8008d5:	8b 30                	mov    (%eax),%esi
  8008d7:	85 f6                	test   %esi,%esi
  8008d9:	75 05                	jne    8008e0 <vprintfmt+0x1a6>
				p = "(null)";
  8008db:	be 31 22 80 00       	mov    $0x802231,%esi
			if (width > 0 && padc != '-')
  8008e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e4:	7e 6d                	jle    800953 <vprintfmt+0x219>
  8008e6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008ea:	74 67                	je     800953 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ef:	83 ec 08             	sub    $0x8,%esp
  8008f2:	50                   	push   %eax
  8008f3:	56                   	push   %esi
  8008f4:	e8 0c 03 00 00       	call   800c05 <strnlen>
  8008f9:	83 c4 10             	add    $0x10,%esp
  8008fc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008ff:	eb 16                	jmp    800917 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800901:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800905:	83 ec 08             	sub    $0x8,%esp
  800908:	ff 75 0c             	pushl  0xc(%ebp)
  80090b:	50                   	push   %eax
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	ff d0                	call   *%eax
  800911:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800914:	ff 4d e4             	decl   -0x1c(%ebp)
  800917:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80091b:	7f e4                	jg     800901 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091d:	eb 34                	jmp    800953 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80091f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800923:	74 1c                	je     800941 <vprintfmt+0x207>
  800925:	83 fb 1f             	cmp    $0x1f,%ebx
  800928:	7e 05                	jle    80092f <vprintfmt+0x1f5>
  80092a:	83 fb 7e             	cmp    $0x7e,%ebx
  80092d:	7e 12                	jle    800941 <vprintfmt+0x207>
					putch('?', putdat);
  80092f:	83 ec 08             	sub    $0x8,%esp
  800932:	ff 75 0c             	pushl  0xc(%ebp)
  800935:	6a 3f                	push   $0x3f
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	ff d0                	call   *%eax
  80093c:	83 c4 10             	add    $0x10,%esp
  80093f:	eb 0f                	jmp    800950 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800941:	83 ec 08             	sub    $0x8,%esp
  800944:	ff 75 0c             	pushl  0xc(%ebp)
  800947:	53                   	push   %ebx
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	ff d0                	call   *%eax
  80094d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800950:	ff 4d e4             	decl   -0x1c(%ebp)
  800953:	89 f0                	mov    %esi,%eax
  800955:	8d 70 01             	lea    0x1(%eax),%esi
  800958:	8a 00                	mov    (%eax),%al
  80095a:	0f be d8             	movsbl %al,%ebx
  80095d:	85 db                	test   %ebx,%ebx
  80095f:	74 24                	je     800985 <vprintfmt+0x24b>
  800961:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800965:	78 b8                	js     80091f <vprintfmt+0x1e5>
  800967:	ff 4d e0             	decl   -0x20(%ebp)
  80096a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80096e:	79 af                	jns    80091f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800970:	eb 13                	jmp    800985 <vprintfmt+0x24b>
				putch(' ', putdat);
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 0c             	pushl  0xc(%ebp)
  800978:	6a 20                	push   $0x20
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	ff d0                	call   *%eax
  80097f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800982:	ff 4d e4             	decl   -0x1c(%ebp)
  800985:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800989:	7f e7                	jg     800972 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80098b:	e9 66 01 00 00       	jmp    800af6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800990:	83 ec 08             	sub    $0x8,%esp
  800993:	ff 75 e8             	pushl  -0x18(%ebp)
  800996:	8d 45 14             	lea    0x14(%ebp),%eax
  800999:	50                   	push   %eax
  80099a:	e8 3c fd ff ff       	call   8006db <getint>
  80099f:	83 c4 10             	add    $0x10,%esp
  8009a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009ae:	85 d2                	test   %edx,%edx
  8009b0:	79 23                	jns    8009d5 <vprintfmt+0x29b>
				putch('-', putdat);
  8009b2:	83 ec 08             	sub    $0x8,%esp
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	6a 2d                	push   $0x2d
  8009ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bd:	ff d0                	call   *%eax
  8009bf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009c8:	f7 d8                	neg    %eax
  8009ca:	83 d2 00             	adc    $0x0,%edx
  8009cd:	f7 da                	neg    %edx
  8009cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009d5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009dc:	e9 bc 00 00 00       	jmp    800a9d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009e1:	83 ec 08             	sub    $0x8,%esp
  8009e4:	ff 75 e8             	pushl  -0x18(%ebp)
  8009e7:	8d 45 14             	lea    0x14(%ebp),%eax
  8009ea:	50                   	push   %eax
  8009eb:	e8 84 fc ff ff       	call   800674 <getuint>
  8009f0:	83 c4 10             	add    $0x10,%esp
  8009f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009f9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a00:	e9 98 00 00 00       	jmp    800a9d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a05:	83 ec 08             	sub    $0x8,%esp
  800a08:	ff 75 0c             	pushl  0xc(%ebp)
  800a0b:	6a 58                	push   $0x58
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	ff d0                	call   *%eax
  800a12:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a15:	83 ec 08             	sub    $0x8,%esp
  800a18:	ff 75 0c             	pushl  0xc(%ebp)
  800a1b:	6a 58                	push   $0x58
  800a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a20:	ff d0                	call   *%eax
  800a22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a25:	83 ec 08             	sub    $0x8,%esp
  800a28:	ff 75 0c             	pushl  0xc(%ebp)
  800a2b:	6a 58                	push   $0x58
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	ff d0                	call   *%eax
  800a32:	83 c4 10             	add    $0x10,%esp
			break;
  800a35:	e9 bc 00 00 00       	jmp    800af6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a3a:	83 ec 08             	sub    $0x8,%esp
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	6a 30                	push   $0x30
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	ff d0                	call   *%eax
  800a47:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	6a 78                	push   $0x78
  800a52:	8b 45 08             	mov    0x8(%ebp),%eax
  800a55:	ff d0                	call   *%eax
  800a57:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5d:	83 c0 04             	add    $0x4,%eax
  800a60:	89 45 14             	mov    %eax,0x14(%ebp)
  800a63:	8b 45 14             	mov    0x14(%ebp),%eax
  800a66:	83 e8 04             	sub    $0x4,%eax
  800a69:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a7c:	eb 1f                	jmp    800a9d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 e8             	pushl  -0x18(%ebp)
  800a84:	8d 45 14             	lea    0x14(%ebp),%eax
  800a87:	50                   	push   %eax
  800a88:	e8 e7 fb ff ff       	call   800674 <getuint>
  800a8d:	83 c4 10             	add    $0x10,%esp
  800a90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a93:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a96:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a9d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800aa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aa4:	83 ec 04             	sub    $0x4,%esp
  800aa7:	52                   	push   %edx
  800aa8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800aab:	50                   	push   %eax
  800aac:	ff 75 f4             	pushl  -0xc(%ebp)
  800aaf:	ff 75 f0             	pushl  -0x10(%ebp)
  800ab2:	ff 75 0c             	pushl  0xc(%ebp)
  800ab5:	ff 75 08             	pushl  0x8(%ebp)
  800ab8:	e8 00 fb ff ff       	call   8005bd <printnum>
  800abd:	83 c4 20             	add    $0x20,%esp
			break;
  800ac0:	eb 34                	jmp    800af6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ac2:	83 ec 08             	sub    $0x8,%esp
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	53                   	push   %ebx
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	ff d0                	call   *%eax
  800ace:	83 c4 10             	add    $0x10,%esp
			break;
  800ad1:	eb 23                	jmp    800af6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ad3:	83 ec 08             	sub    $0x8,%esp
  800ad6:	ff 75 0c             	pushl  0xc(%ebp)
  800ad9:	6a 25                	push   $0x25
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	ff d0                	call   *%eax
  800ae0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ae3:	ff 4d 10             	decl   0x10(%ebp)
  800ae6:	eb 03                	jmp    800aeb <vprintfmt+0x3b1>
  800ae8:	ff 4d 10             	decl   0x10(%ebp)
  800aeb:	8b 45 10             	mov    0x10(%ebp),%eax
  800aee:	48                   	dec    %eax
  800aef:	8a 00                	mov    (%eax),%al
  800af1:	3c 25                	cmp    $0x25,%al
  800af3:	75 f3                	jne    800ae8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800af5:	90                   	nop
		}
	}
  800af6:	e9 47 fc ff ff       	jmp    800742 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800afb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800afc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aff:	5b                   	pop    %ebx
  800b00:	5e                   	pop    %esi
  800b01:	5d                   	pop    %ebp
  800b02:	c3                   	ret    

00800b03 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b03:	55                   	push   %ebp
  800b04:	89 e5                	mov    %esp,%ebp
  800b06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b09:	8d 45 10             	lea    0x10(%ebp),%eax
  800b0c:	83 c0 04             	add    $0x4,%eax
  800b0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b12:	8b 45 10             	mov    0x10(%ebp),%eax
  800b15:	ff 75 f4             	pushl  -0xc(%ebp)
  800b18:	50                   	push   %eax
  800b19:	ff 75 0c             	pushl  0xc(%ebp)
  800b1c:	ff 75 08             	pushl  0x8(%ebp)
  800b1f:	e8 16 fc ff ff       	call   80073a <vprintfmt>
  800b24:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b27:	90                   	nop
  800b28:	c9                   	leave  
  800b29:	c3                   	ret    

00800b2a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b2a:	55                   	push   %ebp
  800b2b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b30:	8b 40 08             	mov    0x8(%eax),%eax
  800b33:	8d 50 01             	lea    0x1(%eax),%edx
  800b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b39:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3f:	8b 10                	mov    (%eax),%edx
  800b41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b44:	8b 40 04             	mov    0x4(%eax),%eax
  800b47:	39 c2                	cmp    %eax,%edx
  800b49:	73 12                	jae    800b5d <sprintputch+0x33>
		*b->buf++ = ch;
  800b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	8d 48 01             	lea    0x1(%eax),%ecx
  800b53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b56:	89 0a                	mov    %ecx,(%edx)
  800b58:	8b 55 08             	mov    0x8(%ebp),%edx
  800b5b:	88 10                	mov    %dl,(%eax)
}
  800b5d:	90                   	nop
  800b5e:	5d                   	pop    %ebp
  800b5f:	c3                   	ret    

00800b60 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b60:	55                   	push   %ebp
  800b61:	89 e5                	mov    %esp,%ebp
  800b63:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	01 d0                	add    %edx,%eax
  800b77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b81:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b85:	74 06                	je     800b8d <vsnprintf+0x2d>
  800b87:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b8b:	7f 07                	jg     800b94 <vsnprintf+0x34>
		return -E_INVAL;
  800b8d:	b8 03 00 00 00       	mov    $0x3,%eax
  800b92:	eb 20                	jmp    800bb4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b94:	ff 75 14             	pushl  0x14(%ebp)
  800b97:	ff 75 10             	pushl  0x10(%ebp)
  800b9a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b9d:	50                   	push   %eax
  800b9e:	68 2a 0b 80 00       	push   $0x800b2a
  800ba3:	e8 92 fb ff ff       	call   80073a <vprintfmt>
  800ba8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bb4:	c9                   	leave  
  800bb5:	c3                   	ret    

00800bb6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bb6:	55                   	push   %ebp
  800bb7:	89 e5                	mov    %esp,%ebp
  800bb9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bbc:	8d 45 10             	lea    0x10(%ebp),%eax
  800bbf:	83 c0 04             	add    $0x4,%eax
  800bc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc8:	ff 75 f4             	pushl  -0xc(%ebp)
  800bcb:	50                   	push   %eax
  800bcc:	ff 75 0c             	pushl  0xc(%ebp)
  800bcf:	ff 75 08             	pushl  0x8(%ebp)
  800bd2:	e8 89 ff ff ff       	call   800b60 <vsnprintf>
  800bd7:	83 c4 10             	add    $0x10,%esp
  800bda:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be0:	c9                   	leave  
  800be1:	c3                   	ret    

00800be2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800be2:	55                   	push   %ebp
  800be3:	89 e5                	mov    %esp,%ebp
  800be5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800be8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bef:	eb 06                	jmp    800bf7 <strlen+0x15>
		n++;
  800bf1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bf4:	ff 45 08             	incl   0x8(%ebp)
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	8a 00                	mov    (%eax),%al
  800bfc:	84 c0                	test   %al,%al
  800bfe:	75 f1                	jne    800bf1 <strlen+0xf>
		n++;
	return n;
  800c00:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c03:	c9                   	leave  
  800c04:	c3                   	ret    

00800c05 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c05:	55                   	push   %ebp
  800c06:	89 e5                	mov    %esp,%ebp
  800c08:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c12:	eb 09                	jmp    800c1d <strnlen+0x18>
		n++;
  800c14:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c17:	ff 45 08             	incl   0x8(%ebp)
  800c1a:	ff 4d 0c             	decl   0xc(%ebp)
  800c1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c21:	74 09                	je     800c2c <strnlen+0x27>
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	8a 00                	mov    (%eax),%al
  800c28:	84 c0                	test   %al,%al
  800c2a:	75 e8                	jne    800c14 <strnlen+0xf>
		n++;
	return n;
  800c2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c2f:	c9                   	leave  
  800c30:	c3                   	ret    

00800c31 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c31:	55                   	push   %ebp
  800c32:	89 e5                	mov    %esp,%ebp
  800c34:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c3d:	90                   	nop
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8d 50 01             	lea    0x1(%eax),%edx
  800c44:	89 55 08             	mov    %edx,0x8(%ebp)
  800c47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c4d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c50:	8a 12                	mov    (%edx),%dl
  800c52:	88 10                	mov    %dl,(%eax)
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	84 c0                	test   %al,%al
  800c58:	75 e4                	jne    800c3e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c5d:	c9                   	leave  
  800c5e:	c3                   	ret    

00800c5f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c5f:	55                   	push   %ebp
  800c60:	89 e5                	mov    %esp,%ebp
  800c62:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c72:	eb 1f                	jmp    800c93 <strncpy+0x34>
		*dst++ = *src;
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	8d 50 01             	lea    0x1(%eax),%edx
  800c7a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c80:	8a 12                	mov    (%edx),%dl
  800c82:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	84 c0                	test   %al,%al
  800c8b:	74 03                	je     800c90 <strncpy+0x31>
			src++;
  800c8d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c90:	ff 45 fc             	incl   -0x4(%ebp)
  800c93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c96:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c99:	72 d9                	jb     800c74 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c9e:	c9                   	leave  
  800c9f:	c3                   	ret    

00800ca0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ca0:	55                   	push   %ebp
  800ca1:	89 e5                	mov    %esp,%ebp
  800ca3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb0:	74 30                	je     800ce2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cb2:	eb 16                	jmp    800cca <strlcpy+0x2a>
			*dst++ = *src++;
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	8d 50 01             	lea    0x1(%eax),%edx
  800cba:	89 55 08             	mov    %edx,0x8(%ebp)
  800cbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cc6:	8a 12                	mov    (%edx),%dl
  800cc8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cca:	ff 4d 10             	decl   0x10(%ebp)
  800ccd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd1:	74 09                	je     800cdc <strlcpy+0x3c>
  800cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	84 c0                	test   %al,%al
  800cda:	75 d8                	jne    800cb4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ce2:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ce8:	29 c2                	sub    %eax,%edx
  800cea:	89 d0                	mov    %edx,%eax
}
  800cec:	c9                   	leave  
  800ced:	c3                   	ret    

00800cee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cee:	55                   	push   %ebp
  800cef:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cf1:	eb 06                	jmp    800cf9 <strcmp+0xb>
		p++, q++;
  800cf3:	ff 45 08             	incl   0x8(%ebp)
  800cf6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	8a 00                	mov    (%eax),%al
  800cfe:	84 c0                	test   %al,%al
  800d00:	74 0e                	je     800d10 <strcmp+0x22>
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	8a 10                	mov    (%eax),%dl
  800d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	38 c2                	cmp    %al,%dl
  800d0e:	74 e3                	je     800cf3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	0f b6 d0             	movzbl %al,%edx
  800d18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1b:	8a 00                	mov    (%eax),%al
  800d1d:	0f b6 c0             	movzbl %al,%eax
  800d20:	29 c2                	sub    %eax,%edx
  800d22:	89 d0                	mov    %edx,%eax
}
  800d24:	5d                   	pop    %ebp
  800d25:	c3                   	ret    

00800d26 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d26:	55                   	push   %ebp
  800d27:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d29:	eb 09                	jmp    800d34 <strncmp+0xe>
		n--, p++, q++;
  800d2b:	ff 4d 10             	decl   0x10(%ebp)
  800d2e:	ff 45 08             	incl   0x8(%ebp)
  800d31:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d38:	74 17                	je     800d51 <strncmp+0x2b>
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	84 c0                	test   %al,%al
  800d41:	74 0e                	je     800d51 <strncmp+0x2b>
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 10                	mov    (%eax),%dl
  800d48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	38 c2                	cmp    %al,%dl
  800d4f:	74 da                	je     800d2b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d55:	75 07                	jne    800d5e <strncmp+0x38>
		return 0;
  800d57:	b8 00 00 00 00       	mov    $0x0,%eax
  800d5c:	eb 14                	jmp    800d72 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	0f b6 d0             	movzbl %al,%edx
  800d66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d69:	8a 00                	mov    (%eax),%al
  800d6b:	0f b6 c0             	movzbl %al,%eax
  800d6e:	29 c2                	sub    %eax,%edx
  800d70:	89 d0                	mov    %edx,%eax
}
  800d72:	5d                   	pop    %ebp
  800d73:	c3                   	ret    

00800d74 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d74:	55                   	push   %ebp
  800d75:	89 e5                	mov    %esp,%ebp
  800d77:	83 ec 04             	sub    $0x4,%esp
  800d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d80:	eb 12                	jmp    800d94 <strchr+0x20>
		if (*s == c)
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	8a 00                	mov    (%eax),%al
  800d87:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d8a:	75 05                	jne    800d91 <strchr+0x1d>
			return (char *) s;
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	eb 11                	jmp    800da2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d91:	ff 45 08             	incl   0x8(%ebp)
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	8a 00                	mov    (%eax),%al
  800d99:	84 c0                	test   %al,%al
  800d9b:	75 e5                	jne    800d82 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800da2:	c9                   	leave  
  800da3:	c3                   	ret    

00800da4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800da4:	55                   	push   %ebp
  800da5:	89 e5                	mov    %esp,%ebp
  800da7:	83 ec 04             	sub    $0x4,%esp
  800daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800db0:	eb 0d                	jmp    800dbf <strfind+0x1b>
		if (*s == c)
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dba:	74 0e                	je     800dca <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dbc:	ff 45 08             	incl   0x8(%ebp)
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	84 c0                	test   %al,%al
  800dc6:	75 ea                	jne    800db2 <strfind+0xe>
  800dc8:	eb 01                	jmp    800dcb <strfind+0x27>
		if (*s == c)
			break;
  800dca:	90                   	nop
	return (char *) s;
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dce:	c9                   	leave  
  800dcf:	c3                   	ret    

00800dd0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800dd0:	55                   	push   %ebp
  800dd1:	89 e5                	mov    %esp,%ebp
  800dd3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ddc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800de2:	eb 0e                	jmp    800df2 <memset+0x22>
		*p++ = c;
  800de4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de7:	8d 50 01             	lea    0x1(%eax),%edx
  800dea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ded:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800df2:	ff 4d f8             	decl   -0x8(%ebp)
  800df5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800df9:	79 e9                	jns    800de4 <memset+0x14>
		*p++ = c;

	return v;
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dfe:	c9                   	leave  
  800dff:	c3                   	ret    

00800e00 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e12:	eb 16                	jmp    800e2a <memcpy+0x2a>
		*d++ = *s++;
  800e14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e17:	8d 50 01             	lea    0x1(%eax),%edx
  800e1a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e20:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e23:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e26:	8a 12                	mov    (%edx),%dl
  800e28:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e30:	89 55 10             	mov    %edx,0x10(%ebp)
  800e33:	85 c0                	test   %eax,%eax
  800e35:	75 dd                	jne    800e14 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3a:	c9                   	leave  
  800e3b:	c3                   	ret    

00800e3c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e3c:	55                   	push   %ebp
  800e3d:	89 e5                	mov    %esp,%ebp
  800e3f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e51:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e54:	73 50                	jae    800ea6 <memmove+0x6a>
  800e56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e59:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5c:	01 d0                	add    %edx,%eax
  800e5e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e61:	76 43                	jbe    800ea6 <memmove+0x6a>
		s += n;
  800e63:	8b 45 10             	mov    0x10(%ebp),%eax
  800e66:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e69:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e6f:	eb 10                	jmp    800e81 <memmove+0x45>
			*--d = *--s;
  800e71:	ff 4d f8             	decl   -0x8(%ebp)
  800e74:	ff 4d fc             	decl   -0x4(%ebp)
  800e77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7a:	8a 10                	mov    (%eax),%dl
  800e7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e81:	8b 45 10             	mov    0x10(%ebp),%eax
  800e84:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e87:	89 55 10             	mov    %edx,0x10(%ebp)
  800e8a:	85 c0                	test   %eax,%eax
  800e8c:	75 e3                	jne    800e71 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e8e:	eb 23                	jmp    800eb3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e93:	8d 50 01             	lea    0x1(%eax),%edx
  800e96:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e9c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e9f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ea2:	8a 12                	mov    (%edx),%dl
  800ea4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ea6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eac:	89 55 10             	mov    %edx,0x10(%ebp)
  800eaf:	85 c0                	test   %eax,%eax
  800eb1:	75 dd                	jne    800e90 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb6:	c9                   	leave  
  800eb7:	c3                   	ret    

00800eb8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800eb8:	55                   	push   %ebp
  800eb9:	89 e5                	mov    %esp,%ebp
  800ebb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ec4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800eca:	eb 2a                	jmp    800ef6 <memcmp+0x3e>
		if (*s1 != *s2)
  800ecc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ecf:	8a 10                	mov    (%eax),%dl
  800ed1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	38 c2                	cmp    %al,%dl
  800ed8:	74 16                	je     800ef0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800eda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800edd:	8a 00                	mov    (%eax),%al
  800edf:	0f b6 d0             	movzbl %al,%edx
  800ee2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	0f b6 c0             	movzbl %al,%eax
  800eea:	29 c2                	sub    %eax,%edx
  800eec:	89 d0                	mov    %edx,%eax
  800eee:	eb 18                	jmp    800f08 <memcmp+0x50>
		s1++, s2++;
  800ef0:	ff 45 fc             	incl   -0x4(%ebp)
  800ef3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ef6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800efc:	89 55 10             	mov    %edx,0x10(%ebp)
  800eff:	85 c0                	test   %eax,%eax
  800f01:	75 c9                	jne    800ecc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f08:	c9                   	leave  
  800f09:	c3                   	ret    

00800f0a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f0a:	55                   	push   %ebp
  800f0b:	89 e5                	mov    %esp,%ebp
  800f0d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f10:	8b 55 08             	mov    0x8(%ebp),%edx
  800f13:	8b 45 10             	mov    0x10(%ebp),%eax
  800f16:	01 d0                	add    %edx,%eax
  800f18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f1b:	eb 15                	jmp    800f32 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	8a 00                	mov    (%eax),%al
  800f22:	0f b6 d0             	movzbl %al,%edx
  800f25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f28:	0f b6 c0             	movzbl %al,%eax
  800f2b:	39 c2                	cmp    %eax,%edx
  800f2d:	74 0d                	je     800f3c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f2f:	ff 45 08             	incl   0x8(%ebp)
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f38:	72 e3                	jb     800f1d <memfind+0x13>
  800f3a:	eb 01                	jmp    800f3d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f3c:	90                   	nop
	return (void *) s;
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f40:	c9                   	leave  
  800f41:	c3                   	ret    

00800f42 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f42:	55                   	push   %ebp
  800f43:	89 e5                	mov    %esp,%ebp
  800f45:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f4f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f56:	eb 03                	jmp    800f5b <strtol+0x19>
		s++;
  800f58:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	8a 00                	mov    (%eax),%al
  800f60:	3c 20                	cmp    $0x20,%al
  800f62:	74 f4                	je     800f58 <strtol+0x16>
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	3c 09                	cmp    $0x9,%al
  800f6b:	74 eb                	je     800f58 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	3c 2b                	cmp    $0x2b,%al
  800f74:	75 05                	jne    800f7b <strtol+0x39>
		s++;
  800f76:	ff 45 08             	incl   0x8(%ebp)
  800f79:	eb 13                	jmp    800f8e <strtol+0x4c>
	else if (*s == '-')
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7e:	8a 00                	mov    (%eax),%al
  800f80:	3c 2d                	cmp    $0x2d,%al
  800f82:	75 0a                	jne    800f8e <strtol+0x4c>
		s++, neg = 1;
  800f84:	ff 45 08             	incl   0x8(%ebp)
  800f87:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f92:	74 06                	je     800f9a <strtol+0x58>
  800f94:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f98:	75 20                	jne    800fba <strtol+0x78>
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	3c 30                	cmp    $0x30,%al
  800fa1:	75 17                	jne    800fba <strtol+0x78>
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	40                   	inc    %eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	3c 78                	cmp    $0x78,%al
  800fab:	75 0d                	jne    800fba <strtol+0x78>
		s += 2, base = 16;
  800fad:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fb1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fb8:	eb 28                	jmp    800fe2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbe:	75 15                	jne    800fd5 <strtol+0x93>
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 30                	cmp    $0x30,%al
  800fc7:	75 0c                	jne    800fd5 <strtol+0x93>
		s++, base = 8;
  800fc9:	ff 45 08             	incl   0x8(%ebp)
  800fcc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fd3:	eb 0d                	jmp    800fe2 <strtol+0xa0>
	else if (base == 0)
  800fd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd9:	75 07                	jne    800fe2 <strtol+0xa0>
		base = 10;
  800fdb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	3c 2f                	cmp    $0x2f,%al
  800fe9:	7e 19                	jle    801004 <strtol+0xc2>
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	3c 39                	cmp    $0x39,%al
  800ff2:	7f 10                	jg     801004 <strtol+0xc2>
			dig = *s - '0';
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	8a 00                	mov    (%eax),%al
  800ff9:	0f be c0             	movsbl %al,%eax
  800ffc:	83 e8 30             	sub    $0x30,%eax
  800fff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801002:	eb 42                	jmp    801046 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	3c 60                	cmp    $0x60,%al
  80100b:	7e 19                	jle    801026 <strtol+0xe4>
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	3c 7a                	cmp    $0x7a,%al
  801014:	7f 10                	jg     801026 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	8a 00                	mov    (%eax),%al
  80101b:	0f be c0             	movsbl %al,%eax
  80101e:	83 e8 57             	sub    $0x57,%eax
  801021:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801024:	eb 20                	jmp    801046 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	8a 00                	mov    (%eax),%al
  80102b:	3c 40                	cmp    $0x40,%al
  80102d:	7e 39                	jle    801068 <strtol+0x126>
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	8a 00                	mov    (%eax),%al
  801034:	3c 5a                	cmp    $0x5a,%al
  801036:	7f 30                	jg     801068 <strtol+0x126>
			dig = *s - 'A' + 10;
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
  80103b:	8a 00                	mov    (%eax),%al
  80103d:	0f be c0             	movsbl %al,%eax
  801040:	83 e8 37             	sub    $0x37,%eax
  801043:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801046:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801049:	3b 45 10             	cmp    0x10(%ebp),%eax
  80104c:	7d 19                	jge    801067 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80104e:	ff 45 08             	incl   0x8(%ebp)
  801051:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801054:	0f af 45 10          	imul   0x10(%ebp),%eax
  801058:	89 c2                	mov    %eax,%edx
  80105a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80105d:	01 d0                	add    %edx,%eax
  80105f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801062:	e9 7b ff ff ff       	jmp    800fe2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801067:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801068:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80106c:	74 08                	je     801076 <strtol+0x134>
		*endptr = (char *) s;
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	8b 55 08             	mov    0x8(%ebp),%edx
  801074:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801076:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80107a:	74 07                	je     801083 <strtol+0x141>
  80107c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107f:	f7 d8                	neg    %eax
  801081:	eb 03                	jmp    801086 <strtol+0x144>
  801083:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801086:	c9                   	leave  
  801087:	c3                   	ret    

00801088 <ltostr>:

void
ltostr(long value, char *str)
{
  801088:	55                   	push   %ebp
  801089:	89 e5                	mov    %esp,%ebp
  80108b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80108e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801095:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80109c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010a0:	79 13                	jns    8010b5 <ltostr+0x2d>
	{
		neg = 1;
  8010a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ac:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010af:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010b2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010bd:	99                   	cltd   
  8010be:	f7 f9                	idiv   %ecx
  8010c0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c6:	8d 50 01             	lea    0x1(%eax),%edx
  8010c9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010cc:	89 c2                	mov    %eax,%edx
  8010ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d1:	01 d0                	add    %edx,%eax
  8010d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010d6:	83 c2 30             	add    $0x30,%edx
  8010d9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010db:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010de:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010e3:	f7 e9                	imul   %ecx
  8010e5:	c1 fa 02             	sar    $0x2,%edx
  8010e8:	89 c8                	mov    %ecx,%eax
  8010ea:	c1 f8 1f             	sar    $0x1f,%eax
  8010ed:	29 c2                	sub    %eax,%edx
  8010ef:	89 d0                	mov    %edx,%eax
  8010f1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010f7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010fc:	f7 e9                	imul   %ecx
  8010fe:	c1 fa 02             	sar    $0x2,%edx
  801101:	89 c8                	mov    %ecx,%eax
  801103:	c1 f8 1f             	sar    $0x1f,%eax
  801106:	29 c2                	sub    %eax,%edx
  801108:	89 d0                	mov    %edx,%eax
  80110a:	c1 e0 02             	shl    $0x2,%eax
  80110d:	01 d0                	add    %edx,%eax
  80110f:	01 c0                	add    %eax,%eax
  801111:	29 c1                	sub    %eax,%ecx
  801113:	89 ca                	mov    %ecx,%edx
  801115:	85 d2                	test   %edx,%edx
  801117:	75 9c                	jne    8010b5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801119:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801120:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801123:	48                   	dec    %eax
  801124:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801127:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80112b:	74 3d                	je     80116a <ltostr+0xe2>
		start = 1 ;
  80112d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801134:	eb 34                	jmp    80116a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801136:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113c:	01 d0                	add    %edx,%eax
  80113e:	8a 00                	mov    (%eax),%al
  801140:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801143:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801146:	8b 45 0c             	mov    0xc(%ebp),%eax
  801149:	01 c2                	add    %eax,%edx
  80114b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80114e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801151:	01 c8                	add    %ecx,%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801157:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80115a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115d:	01 c2                	add    %eax,%edx
  80115f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801162:	88 02                	mov    %al,(%edx)
		start++ ;
  801164:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801167:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80116a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801170:	7c c4                	jl     801136 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801172:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801175:	8b 45 0c             	mov    0xc(%ebp),%eax
  801178:	01 d0                	add    %edx,%eax
  80117a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80117d:	90                   	nop
  80117e:	c9                   	leave  
  80117f:	c3                   	ret    

00801180 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801180:	55                   	push   %ebp
  801181:	89 e5                	mov    %esp,%ebp
  801183:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801186:	ff 75 08             	pushl  0x8(%ebp)
  801189:	e8 54 fa ff ff       	call   800be2 <strlen>
  80118e:	83 c4 04             	add    $0x4,%esp
  801191:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801194:	ff 75 0c             	pushl  0xc(%ebp)
  801197:	e8 46 fa ff ff       	call   800be2 <strlen>
  80119c:	83 c4 04             	add    $0x4,%esp
  80119f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011b0:	eb 17                	jmp    8011c9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b8:	01 c2                	add    %eax,%edx
  8011ba:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	01 c8                	add    %ecx,%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011c6:	ff 45 fc             	incl   -0x4(%ebp)
  8011c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011cf:	7c e1                	jl     8011b2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011df:	eb 1f                	jmp    801200 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e4:	8d 50 01             	lea    0x1(%eax),%edx
  8011e7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011ea:	89 c2                	mov    %eax,%edx
  8011ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ef:	01 c2                	add    %eax,%edx
  8011f1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f7:	01 c8                	add    %ecx,%eax
  8011f9:	8a 00                	mov    (%eax),%al
  8011fb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011fd:	ff 45 f8             	incl   -0x8(%ebp)
  801200:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801203:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801206:	7c d9                	jl     8011e1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801208:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80120b:	8b 45 10             	mov    0x10(%ebp),%eax
  80120e:	01 d0                	add    %edx,%eax
  801210:	c6 00 00             	movb   $0x0,(%eax)
}
  801213:	90                   	nop
  801214:	c9                   	leave  
  801215:	c3                   	ret    

00801216 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801216:	55                   	push   %ebp
  801217:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801219:	8b 45 14             	mov    0x14(%ebp),%eax
  80121c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801222:	8b 45 14             	mov    0x14(%ebp),%eax
  801225:	8b 00                	mov    (%eax),%eax
  801227:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122e:	8b 45 10             	mov    0x10(%ebp),%eax
  801231:	01 d0                	add    %edx,%eax
  801233:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801239:	eb 0c                	jmp    801247 <strsplit+0x31>
			*string++ = 0;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	8d 50 01             	lea    0x1(%eax),%edx
  801241:	89 55 08             	mov    %edx,0x8(%ebp)
  801244:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	84 c0                	test   %al,%al
  80124e:	74 18                	je     801268 <strsplit+0x52>
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	0f be c0             	movsbl %al,%eax
  801258:	50                   	push   %eax
  801259:	ff 75 0c             	pushl  0xc(%ebp)
  80125c:	e8 13 fb ff ff       	call   800d74 <strchr>
  801261:	83 c4 08             	add    $0x8,%esp
  801264:	85 c0                	test   %eax,%eax
  801266:	75 d3                	jne    80123b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	8a 00                	mov    (%eax),%al
  80126d:	84 c0                	test   %al,%al
  80126f:	74 5a                	je     8012cb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801271:	8b 45 14             	mov    0x14(%ebp),%eax
  801274:	8b 00                	mov    (%eax),%eax
  801276:	83 f8 0f             	cmp    $0xf,%eax
  801279:	75 07                	jne    801282 <strsplit+0x6c>
		{
			return 0;
  80127b:	b8 00 00 00 00       	mov    $0x0,%eax
  801280:	eb 66                	jmp    8012e8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801282:	8b 45 14             	mov    0x14(%ebp),%eax
  801285:	8b 00                	mov    (%eax),%eax
  801287:	8d 48 01             	lea    0x1(%eax),%ecx
  80128a:	8b 55 14             	mov    0x14(%ebp),%edx
  80128d:	89 0a                	mov    %ecx,(%edx)
  80128f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801296:	8b 45 10             	mov    0x10(%ebp),%eax
  801299:	01 c2                	add    %eax,%edx
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012a0:	eb 03                	jmp    8012a5 <strsplit+0x8f>
			string++;
  8012a2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	8a 00                	mov    (%eax),%al
  8012aa:	84 c0                	test   %al,%al
  8012ac:	74 8b                	je     801239 <strsplit+0x23>
  8012ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b1:	8a 00                	mov    (%eax),%al
  8012b3:	0f be c0             	movsbl %al,%eax
  8012b6:	50                   	push   %eax
  8012b7:	ff 75 0c             	pushl  0xc(%ebp)
  8012ba:	e8 b5 fa ff ff       	call   800d74 <strchr>
  8012bf:	83 c4 08             	add    $0x8,%esp
  8012c2:	85 c0                	test   %eax,%eax
  8012c4:	74 dc                	je     8012a2 <strsplit+0x8c>
			string++;
	}
  8012c6:	e9 6e ff ff ff       	jmp    801239 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012cb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8012cf:	8b 00                	mov    (%eax),%eax
  8012d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012db:	01 d0                	add    %edx,%eax
  8012dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012e8:	c9                   	leave  
  8012e9:	c3                   	ret    

008012ea <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012ea:	55                   	push   %ebp
  8012eb:	89 e5                	mov    %esp,%ebp
  8012ed:	57                   	push   %edi
  8012ee:	56                   	push   %esi
  8012ef:	53                   	push   %ebx
  8012f0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012ff:	8b 7d 18             	mov    0x18(%ebp),%edi
  801302:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801305:	cd 30                	int    $0x30
  801307:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80130a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80130d:	83 c4 10             	add    $0x10,%esp
  801310:	5b                   	pop    %ebx
  801311:	5e                   	pop    %esi
  801312:	5f                   	pop    %edi
  801313:	5d                   	pop    %ebp
  801314:	c3                   	ret    

00801315 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801315:	55                   	push   %ebp
  801316:	89 e5                	mov    %esp,%ebp
  801318:	83 ec 04             	sub    $0x4,%esp
  80131b:	8b 45 10             	mov    0x10(%ebp),%eax
  80131e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801321:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	52                   	push   %edx
  80132d:	ff 75 0c             	pushl  0xc(%ebp)
  801330:	50                   	push   %eax
  801331:	6a 00                	push   $0x0
  801333:	e8 b2 ff ff ff       	call   8012ea <syscall>
  801338:	83 c4 18             	add    $0x18,%esp
}
  80133b:	90                   	nop
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <sys_cgetc>:

int
sys_cgetc(void)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 01                	push   $0x1
  80134d:	e8 98 ff ff ff       	call   8012ea <syscall>
  801352:	83 c4 18             	add    $0x18,%esp
}
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	50                   	push   %eax
  801366:	6a 05                	push   $0x5
  801368:	e8 7d ff ff ff       	call   8012ea <syscall>
  80136d:	83 c4 18             	add    $0x18,%esp
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	6a 00                	push   $0x0
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 02                	push   $0x2
  801381:	e8 64 ff ff ff       	call   8012ea <syscall>
  801386:	83 c4 18             	add    $0x18,%esp
}
  801389:	c9                   	leave  
  80138a:	c3                   	ret    

0080138b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 03                	push   $0x3
  80139a:	e8 4b ff ff ff       	call   8012ea <syscall>
  80139f:	83 c4 18             	add    $0x18,%esp
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 04                	push   $0x4
  8013b3:	e8 32 ff ff ff       	call   8012ea <syscall>
  8013b8:	83 c4 18             	add    $0x18,%esp
}
  8013bb:	c9                   	leave  
  8013bc:	c3                   	ret    

008013bd <sys_env_exit>:


void sys_env_exit(void)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 06                	push   $0x6
  8013cc:	e8 19 ff ff ff       	call   8012ea <syscall>
  8013d1:	83 c4 18             	add    $0x18,%esp
}
  8013d4:	90                   	nop
  8013d5:	c9                   	leave  
  8013d6:	c3                   	ret    

008013d7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	52                   	push   %edx
  8013e7:	50                   	push   %eax
  8013e8:	6a 07                	push   $0x7
  8013ea:	e8 fb fe ff ff       	call   8012ea <syscall>
  8013ef:	83 c4 18             	add    $0x18,%esp
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
  8013f7:	56                   	push   %esi
  8013f8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013f9:	8b 75 18             	mov    0x18(%ebp),%esi
  8013fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801402:	8b 55 0c             	mov    0xc(%ebp),%edx
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	56                   	push   %esi
  801409:	53                   	push   %ebx
  80140a:	51                   	push   %ecx
  80140b:	52                   	push   %edx
  80140c:	50                   	push   %eax
  80140d:	6a 08                	push   $0x8
  80140f:	e8 d6 fe ff ff       	call   8012ea <syscall>
  801414:	83 c4 18             	add    $0x18,%esp
}
  801417:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80141a:	5b                   	pop    %ebx
  80141b:	5e                   	pop    %esi
  80141c:	5d                   	pop    %ebp
  80141d:	c3                   	ret    

0080141e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801421:	8b 55 0c             	mov    0xc(%ebp),%edx
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	52                   	push   %edx
  80142e:	50                   	push   %eax
  80142f:	6a 09                	push   $0x9
  801431:	e8 b4 fe ff ff       	call   8012ea <syscall>
  801436:	83 c4 18             	add    $0x18,%esp
}
  801439:	c9                   	leave  
  80143a:	c3                   	ret    

0080143b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80143b:	55                   	push   %ebp
  80143c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	ff 75 0c             	pushl  0xc(%ebp)
  801447:	ff 75 08             	pushl  0x8(%ebp)
  80144a:	6a 0a                	push   $0xa
  80144c:	e8 99 fe ff ff       	call   8012ea <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 0b                	push   $0xb
  801465:	e8 80 fe ff ff       	call   8012ea <syscall>
  80146a:	83 c4 18             	add    $0x18,%esp
}
  80146d:	c9                   	leave  
  80146e:	c3                   	ret    

0080146f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 0c                	push   $0xc
  80147e:	e8 67 fe ff ff       	call   8012ea <syscall>
  801483:	83 c4 18             	add    $0x18,%esp
}
  801486:	c9                   	leave  
  801487:	c3                   	ret    

00801488 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 0d                	push   $0xd
  801497:	e8 4e fe ff ff       	call   8012ea <syscall>
  80149c:	83 c4 18             	add    $0x18,%esp
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	ff 75 0c             	pushl  0xc(%ebp)
  8014ad:	ff 75 08             	pushl  0x8(%ebp)
  8014b0:	6a 11                	push   $0x11
  8014b2:	e8 33 fe ff ff       	call   8012ea <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
	return;
  8014ba:	90                   	nop
}
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	ff 75 0c             	pushl  0xc(%ebp)
  8014c9:	ff 75 08             	pushl  0x8(%ebp)
  8014cc:	6a 12                	push   $0x12
  8014ce:	e8 17 fe ff ff       	call   8012ea <syscall>
  8014d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d6:	90                   	nop
}
  8014d7:	c9                   	leave  
  8014d8:	c3                   	ret    

008014d9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014d9:	55                   	push   %ebp
  8014da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 0e                	push   $0xe
  8014e8:	e8 fd fd ff ff       	call   8012ea <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	ff 75 08             	pushl  0x8(%ebp)
  801500:	6a 0f                	push   $0xf
  801502:	e8 e3 fd ff ff       	call   8012ea <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
}
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 10                	push   $0x10
  80151b:	e8 ca fd ff ff       	call   8012ea <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	90                   	nop
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 14                	push   $0x14
  801535:	e8 b0 fd ff ff       	call   8012ea <syscall>
  80153a:	83 c4 18             	add    $0x18,%esp
}
  80153d:	90                   	nop
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 15                	push   $0x15
  80154f:	e8 96 fd ff ff       	call   8012ea <syscall>
  801554:	83 c4 18             	add    $0x18,%esp
}
  801557:	90                   	nop
  801558:	c9                   	leave  
  801559:	c3                   	ret    

0080155a <sys_cputc>:


void
sys_cputc(const char c)
{
  80155a:	55                   	push   %ebp
  80155b:	89 e5                	mov    %esp,%ebp
  80155d:	83 ec 04             	sub    $0x4,%esp
  801560:	8b 45 08             	mov    0x8(%ebp),%eax
  801563:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801566:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	50                   	push   %eax
  801573:	6a 16                	push   $0x16
  801575:	e8 70 fd ff ff       	call   8012ea <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	90                   	nop
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 17                	push   $0x17
  80158f:	e8 56 fd ff ff       	call   8012ea <syscall>
  801594:	83 c4 18             	add    $0x18,%esp
}
  801597:	90                   	nop
  801598:	c9                   	leave  
  801599:	c3                   	ret    

0080159a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80159a:	55                   	push   %ebp
  80159b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	ff 75 0c             	pushl  0xc(%ebp)
  8015a9:	50                   	push   %eax
  8015aa:	6a 18                	push   $0x18
  8015ac:	e8 39 fd ff ff       	call   8012ea <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	52                   	push   %edx
  8015c6:	50                   	push   %eax
  8015c7:	6a 1b                	push   $0x1b
  8015c9:	e8 1c fd ff ff       	call   8012ea <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	52                   	push   %edx
  8015e3:	50                   	push   %eax
  8015e4:	6a 19                	push   $0x19
  8015e6:	e8 ff fc ff ff       	call   8012ea <syscall>
  8015eb:	83 c4 18             	add    $0x18,%esp
}
  8015ee:	90                   	nop
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	52                   	push   %edx
  801601:	50                   	push   %eax
  801602:	6a 1a                	push   $0x1a
  801604:	e8 e1 fc ff ff       	call   8012ea <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	90                   	nop
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
  801612:	83 ec 04             	sub    $0x4,%esp
  801615:	8b 45 10             	mov    0x10(%ebp),%eax
  801618:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80161b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80161e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801622:	8b 45 08             	mov    0x8(%ebp),%eax
  801625:	6a 00                	push   $0x0
  801627:	51                   	push   %ecx
  801628:	52                   	push   %edx
  801629:	ff 75 0c             	pushl  0xc(%ebp)
  80162c:	50                   	push   %eax
  80162d:	6a 1c                	push   $0x1c
  80162f:	e8 b6 fc ff ff       	call   8012ea <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
}
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80163c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	52                   	push   %edx
  801649:	50                   	push   %eax
  80164a:	6a 1d                	push   $0x1d
  80164c:	e8 99 fc ff ff       	call   8012ea <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801659:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80165c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	51                   	push   %ecx
  801667:	52                   	push   %edx
  801668:	50                   	push   %eax
  801669:	6a 1e                	push   $0x1e
  80166b:	e8 7a fc ff ff       	call   8012ea <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801678:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	52                   	push   %edx
  801685:	50                   	push   %eax
  801686:	6a 1f                	push   $0x1f
  801688:	e8 5d fc ff ff       	call   8012ea <syscall>
  80168d:	83 c4 18             	add    $0x18,%esp
}
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	6a 20                	push   $0x20
  8016a1:	e8 44 fc ff ff       	call   8012ea <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	c9                   	leave  
  8016aa:	c3                   	ret    

008016ab <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016ab:	55                   	push   %ebp
  8016ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	6a 00                	push   $0x0
  8016b3:	ff 75 14             	pushl  0x14(%ebp)
  8016b6:	ff 75 10             	pushl  0x10(%ebp)
  8016b9:	ff 75 0c             	pushl  0xc(%ebp)
  8016bc:	50                   	push   %eax
  8016bd:	6a 21                	push   $0x21
  8016bf:	e8 26 fc ff ff       	call   8012ea <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	50                   	push   %eax
  8016d8:	6a 22                	push   $0x22
  8016da:	e8 0b fc ff ff       	call   8012ea <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	90                   	nop
  8016e3:	c9                   	leave  
  8016e4:	c3                   	ret    

008016e5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016e5:	55                   	push   %ebp
  8016e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	50                   	push   %eax
  8016f4:	6a 23                	push   $0x23
  8016f6:	e8 ef fb ff ff       	call   8012ea <syscall>
  8016fb:	83 c4 18             	add    $0x18,%esp
}
  8016fe:	90                   	nop
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
  801704:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801707:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80170a:	8d 50 04             	lea    0x4(%eax),%edx
  80170d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	52                   	push   %edx
  801717:	50                   	push   %eax
  801718:	6a 24                	push   $0x24
  80171a:	e8 cb fb ff ff       	call   8012ea <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
	return result;
  801722:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801725:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801728:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80172b:	89 01                	mov    %eax,(%ecx)
  80172d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	c9                   	leave  
  801734:	c2 04 00             	ret    $0x4

00801737 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	ff 75 10             	pushl  0x10(%ebp)
  801741:	ff 75 0c             	pushl  0xc(%ebp)
  801744:	ff 75 08             	pushl  0x8(%ebp)
  801747:	6a 13                	push   $0x13
  801749:	e8 9c fb ff ff       	call   8012ea <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
	return ;
  801751:	90                   	nop
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <sys_rcr2>:
uint32 sys_rcr2()
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 25                	push   $0x25
  801763:	e8 82 fb ff ff       	call   8012ea <syscall>
  801768:	83 c4 18             	add    $0x18,%esp
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
  801770:	83 ec 04             	sub    $0x4,%esp
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801779:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	50                   	push   %eax
  801786:	6a 26                	push   $0x26
  801788:	e8 5d fb ff ff       	call   8012ea <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
	return ;
  801790:	90                   	nop
}
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <rsttst>:
void rsttst()
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 28                	push   $0x28
  8017a2:	e8 43 fb ff ff       	call   8012ea <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017aa:	90                   	nop
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
  8017b0:	83 ec 04             	sub    $0x4,%esp
  8017b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8017b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017b9:	8b 55 18             	mov    0x18(%ebp),%edx
  8017bc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017c0:	52                   	push   %edx
  8017c1:	50                   	push   %eax
  8017c2:	ff 75 10             	pushl  0x10(%ebp)
  8017c5:	ff 75 0c             	pushl  0xc(%ebp)
  8017c8:	ff 75 08             	pushl  0x8(%ebp)
  8017cb:	6a 27                	push   $0x27
  8017cd:	e8 18 fb ff ff       	call   8012ea <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d5:	90                   	nop
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <chktst>:
void chktst(uint32 n)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	ff 75 08             	pushl  0x8(%ebp)
  8017e6:	6a 29                	push   $0x29
  8017e8:	e8 fd fa ff ff       	call   8012ea <syscall>
  8017ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f0:	90                   	nop
}
  8017f1:	c9                   	leave  
  8017f2:	c3                   	ret    

008017f3 <inctst>:

void inctst()
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 2a                	push   $0x2a
  801802:	e8 e3 fa ff ff       	call   8012ea <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
	return ;
  80180a:	90                   	nop
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <gettst>:
uint32 gettst()
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 2b                	push   $0x2b
  80181c:	e8 c9 fa ff ff       	call   8012ea <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
  801829:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 2c                	push   $0x2c
  801838:	e8 ad fa ff ff       	call   8012ea <syscall>
  80183d:	83 c4 18             	add    $0x18,%esp
  801840:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801843:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801847:	75 07                	jne    801850 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801849:	b8 01 00 00 00       	mov    $0x1,%eax
  80184e:	eb 05                	jmp    801855 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801850:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
  80185a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 2c                	push   $0x2c
  801869:	e8 7c fa ff ff       	call   8012ea <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
  801871:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801874:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801878:	75 07                	jne    801881 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80187a:	b8 01 00 00 00       	mov    $0x1,%eax
  80187f:	eb 05                	jmp    801886 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801881:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801886:	c9                   	leave  
  801887:	c3                   	ret    

00801888 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801888:	55                   	push   %ebp
  801889:	89 e5                	mov    %esp,%ebp
  80188b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 2c                	push   $0x2c
  80189a:	e8 4b fa ff ff       	call   8012ea <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
  8018a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018a5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018a9:	75 07                	jne    8018b2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018ab:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b0:	eb 05                	jmp    8018b7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
  8018bc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 2c                	push   $0x2c
  8018cb:	e8 1a fa ff ff       	call   8012ea <syscall>
  8018d0:	83 c4 18             	add    $0x18,%esp
  8018d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8018d6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018da:	75 07                	jne    8018e3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018dc:	b8 01 00 00 00       	mov    $0x1,%eax
  8018e1:	eb 05                	jmp    8018e8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	ff 75 08             	pushl  0x8(%ebp)
  8018f8:	6a 2d                	push   $0x2d
  8018fa:	e8 eb f9 ff ff       	call   8012ea <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801902:	90                   	nop
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
  801908:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801909:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80190c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80190f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	6a 00                	push   $0x0
  801917:	53                   	push   %ebx
  801918:	51                   	push   %ecx
  801919:	52                   	push   %edx
  80191a:	50                   	push   %eax
  80191b:	6a 2e                	push   $0x2e
  80191d:	e8 c8 f9 ff ff       	call   8012ea <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
}
  801925:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80192d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801930:	8b 45 08             	mov    0x8(%ebp),%eax
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	52                   	push   %edx
  80193a:	50                   	push   %eax
  80193b:	6a 2f                	push   $0x2f
  80193d:	e8 a8 f9 ff ff       	call   8012ea <syscall>
  801942:	83 c4 18             	add    $0x18,%esp
}
  801945:	c9                   	leave  
  801946:	c3                   	ret    

00801947 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801947:	55                   	push   %ebp
  801948:	89 e5                	mov    %esp,%ebp
  80194a:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80194d:	8b 55 08             	mov    0x8(%ebp),%edx
  801950:	89 d0                	mov    %edx,%eax
  801952:	c1 e0 02             	shl    $0x2,%eax
  801955:	01 d0                	add    %edx,%eax
  801957:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80195e:	01 d0                	add    %edx,%eax
  801960:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801967:	01 d0                	add    %edx,%eax
  801969:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801970:	01 d0                	add    %edx,%eax
  801972:	c1 e0 04             	shl    $0x4,%eax
  801975:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801978:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80197f:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801982:	83 ec 0c             	sub    $0xc,%esp
  801985:	50                   	push   %eax
  801986:	e8 76 fd ff ff       	call   801701 <sys_get_virtual_time>
  80198b:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80198e:	eb 41                	jmp    8019d1 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801990:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801993:	83 ec 0c             	sub    $0xc,%esp
  801996:	50                   	push   %eax
  801997:	e8 65 fd ff ff       	call   801701 <sys_get_virtual_time>
  80199c:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80199f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019a5:	29 c2                	sub    %eax,%edx
  8019a7:	89 d0                	mov    %edx,%eax
  8019a9:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019b2:	89 d1                	mov    %edx,%ecx
  8019b4:	29 c1                	sub    %eax,%ecx
  8019b6:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8019b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019bc:	39 c2                	cmp    %eax,%edx
  8019be:	0f 97 c0             	seta   %al
  8019c1:	0f b6 c0             	movzbl %al,%eax
  8019c4:	29 c1                	sub    %eax,%ecx
  8019c6:	89 c8                	mov    %ecx,%eax
  8019c8:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8019cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8019d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019d7:	72 b7                	jb     801990 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8019d9:	90                   	nop
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
  8019df:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8019e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8019e9:	eb 03                	jmp    8019ee <busy_wait+0x12>
  8019eb:	ff 45 fc             	incl   -0x4(%ebp)
  8019ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f1:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019f4:	72 f5                	jb     8019eb <busy_wait+0xf>
	return i;
  8019f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8019f9:	c9                   	leave  
  8019fa:	c3                   	ret    
  8019fb:	90                   	nop

008019fc <__udivdi3>:
  8019fc:	55                   	push   %ebp
  8019fd:	57                   	push   %edi
  8019fe:	56                   	push   %esi
  8019ff:	53                   	push   %ebx
  801a00:	83 ec 1c             	sub    $0x1c,%esp
  801a03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a13:	89 ca                	mov    %ecx,%edx
  801a15:	89 f8                	mov    %edi,%eax
  801a17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a1b:	85 f6                	test   %esi,%esi
  801a1d:	75 2d                	jne    801a4c <__udivdi3+0x50>
  801a1f:	39 cf                	cmp    %ecx,%edi
  801a21:	77 65                	ja     801a88 <__udivdi3+0x8c>
  801a23:	89 fd                	mov    %edi,%ebp
  801a25:	85 ff                	test   %edi,%edi
  801a27:	75 0b                	jne    801a34 <__udivdi3+0x38>
  801a29:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2e:	31 d2                	xor    %edx,%edx
  801a30:	f7 f7                	div    %edi
  801a32:	89 c5                	mov    %eax,%ebp
  801a34:	31 d2                	xor    %edx,%edx
  801a36:	89 c8                	mov    %ecx,%eax
  801a38:	f7 f5                	div    %ebp
  801a3a:	89 c1                	mov    %eax,%ecx
  801a3c:	89 d8                	mov    %ebx,%eax
  801a3e:	f7 f5                	div    %ebp
  801a40:	89 cf                	mov    %ecx,%edi
  801a42:	89 fa                	mov    %edi,%edx
  801a44:	83 c4 1c             	add    $0x1c,%esp
  801a47:	5b                   	pop    %ebx
  801a48:	5e                   	pop    %esi
  801a49:	5f                   	pop    %edi
  801a4a:	5d                   	pop    %ebp
  801a4b:	c3                   	ret    
  801a4c:	39 ce                	cmp    %ecx,%esi
  801a4e:	77 28                	ja     801a78 <__udivdi3+0x7c>
  801a50:	0f bd fe             	bsr    %esi,%edi
  801a53:	83 f7 1f             	xor    $0x1f,%edi
  801a56:	75 40                	jne    801a98 <__udivdi3+0x9c>
  801a58:	39 ce                	cmp    %ecx,%esi
  801a5a:	72 0a                	jb     801a66 <__udivdi3+0x6a>
  801a5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a60:	0f 87 9e 00 00 00    	ja     801b04 <__udivdi3+0x108>
  801a66:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6b:	89 fa                	mov    %edi,%edx
  801a6d:	83 c4 1c             	add    $0x1c,%esp
  801a70:	5b                   	pop    %ebx
  801a71:	5e                   	pop    %esi
  801a72:	5f                   	pop    %edi
  801a73:	5d                   	pop    %ebp
  801a74:	c3                   	ret    
  801a75:	8d 76 00             	lea    0x0(%esi),%esi
  801a78:	31 ff                	xor    %edi,%edi
  801a7a:	31 c0                	xor    %eax,%eax
  801a7c:	89 fa                	mov    %edi,%edx
  801a7e:	83 c4 1c             	add    $0x1c,%esp
  801a81:	5b                   	pop    %ebx
  801a82:	5e                   	pop    %esi
  801a83:	5f                   	pop    %edi
  801a84:	5d                   	pop    %ebp
  801a85:	c3                   	ret    
  801a86:	66 90                	xchg   %ax,%ax
  801a88:	89 d8                	mov    %ebx,%eax
  801a8a:	f7 f7                	div    %edi
  801a8c:	31 ff                	xor    %edi,%edi
  801a8e:	89 fa                	mov    %edi,%edx
  801a90:	83 c4 1c             	add    $0x1c,%esp
  801a93:	5b                   	pop    %ebx
  801a94:	5e                   	pop    %esi
  801a95:	5f                   	pop    %edi
  801a96:	5d                   	pop    %ebp
  801a97:	c3                   	ret    
  801a98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a9d:	89 eb                	mov    %ebp,%ebx
  801a9f:	29 fb                	sub    %edi,%ebx
  801aa1:	89 f9                	mov    %edi,%ecx
  801aa3:	d3 e6                	shl    %cl,%esi
  801aa5:	89 c5                	mov    %eax,%ebp
  801aa7:	88 d9                	mov    %bl,%cl
  801aa9:	d3 ed                	shr    %cl,%ebp
  801aab:	89 e9                	mov    %ebp,%ecx
  801aad:	09 f1                	or     %esi,%ecx
  801aaf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ab3:	89 f9                	mov    %edi,%ecx
  801ab5:	d3 e0                	shl    %cl,%eax
  801ab7:	89 c5                	mov    %eax,%ebp
  801ab9:	89 d6                	mov    %edx,%esi
  801abb:	88 d9                	mov    %bl,%cl
  801abd:	d3 ee                	shr    %cl,%esi
  801abf:	89 f9                	mov    %edi,%ecx
  801ac1:	d3 e2                	shl    %cl,%edx
  801ac3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ac7:	88 d9                	mov    %bl,%cl
  801ac9:	d3 e8                	shr    %cl,%eax
  801acb:	09 c2                	or     %eax,%edx
  801acd:	89 d0                	mov    %edx,%eax
  801acf:	89 f2                	mov    %esi,%edx
  801ad1:	f7 74 24 0c          	divl   0xc(%esp)
  801ad5:	89 d6                	mov    %edx,%esi
  801ad7:	89 c3                	mov    %eax,%ebx
  801ad9:	f7 e5                	mul    %ebp
  801adb:	39 d6                	cmp    %edx,%esi
  801add:	72 19                	jb     801af8 <__udivdi3+0xfc>
  801adf:	74 0b                	je     801aec <__udivdi3+0xf0>
  801ae1:	89 d8                	mov    %ebx,%eax
  801ae3:	31 ff                	xor    %edi,%edi
  801ae5:	e9 58 ff ff ff       	jmp    801a42 <__udivdi3+0x46>
  801aea:	66 90                	xchg   %ax,%ax
  801aec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801af0:	89 f9                	mov    %edi,%ecx
  801af2:	d3 e2                	shl    %cl,%edx
  801af4:	39 c2                	cmp    %eax,%edx
  801af6:	73 e9                	jae    801ae1 <__udivdi3+0xe5>
  801af8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801afb:	31 ff                	xor    %edi,%edi
  801afd:	e9 40 ff ff ff       	jmp    801a42 <__udivdi3+0x46>
  801b02:	66 90                	xchg   %ax,%ax
  801b04:	31 c0                	xor    %eax,%eax
  801b06:	e9 37 ff ff ff       	jmp    801a42 <__udivdi3+0x46>
  801b0b:	90                   	nop

00801b0c <__umoddi3>:
  801b0c:	55                   	push   %ebp
  801b0d:	57                   	push   %edi
  801b0e:	56                   	push   %esi
  801b0f:	53                   	push   %ebx
  801b10:	83 ec 1c             	sub    $0x1c,%esp
  801b13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b2b:	89 f3                	mov    %esi,%ebx
  801b2d:	89 fa                	mov    %edi,%edx
  801b2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b33:	89 34 24             	mov    %esi,(%esp)
  801b36:	85 c0                	test   %eax,%eax
  801b38:	75 1a                	jne    801b54 <__umoddi3+0x48>
  801b3a:	39 f7                	cmp    %esi,%edi
  801b3c:	0f 86 a2 00 00 00    	jbe    801be4 <__umoddi3+0xd8>
  801b42:	89 c8                	mov    %ecx,%eax
  801b44:	89 f2                	mov    %esi,%edx
  801b46:	f7 f7                	div    %edi
  801b48:	89 d0                	mov    %edx,%eax
  801b4a:	31 d2                	xor    %edx,%edx
  801b4c:	83 c4 1c             	add    $0x1c,%esp
  801b4f:	5b                   	pop    %ebx
  801b50:	5e                   	pop    %esi
  801b51:	5f                   	pop    %edi
  801b52:	5d                   	pop    %ebp
  801b53:	c3                   	ret    
  801b54:	39 f0                	cmp    %esi,%eax
  801b56:	0f 87 ac 00 00 00    	ja     801c08 <__umoddi3+0xfc>
  801b5c:	0f bd e8             	bsr    %eax,%ebp
  801b5f:	83 f5 1f             	xor    $0x1f,%ebp
  801b62:	0f 84 ac 00 00 00    	je     801c14 <__umoddi3+0x108>
  801b68:	bf 20 00 00 00       	mov    $0x20,%edi
  801b6d:	29 ef                	sub    %ebp,%edi
  801b6f:	89 fe                	mov    %edi,%esi
  801b71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b75:	89 e9                	mov    %ebp,%ecx
  801b77:	d3 e0                	shl    %cl,%eax
  801b79:	89 d7                	mov    %edx,%edi
  801b7b:	89 f1                	mov    %esi,%ecx
  801b7d:	d3 ef                	shr    %cl,%edi
  801b7f:	09 c7                	or     %eax,%edi
  801b81:	89 e9                	mov    %ebp,%ecx
  801b83:	d3 e2                	shl    %cl,%edx
  801b85:	89 14 24             	mov    %edx,(%esp)
  801b88:	89 d8                	mov    %ebx,%eax
  801b8a:	d3 e0                	shl    %cl,%eax
  801b8c:	89 c2                	mov    %eax,%edx
  801b8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b92:	d3 e0                	shl    %cl,%eax
  801b94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b9c:	89 f1                	mov    %esi,%ecx
  801b9e:	d3 e8                	shr    %cl,%eax
  801ba0:	09 d0                	or     %edx,%eax
  801ba2:	d3 eb                	shr    %cl,%ebx
  801ba4:	89 da                	mov    %ebx,%edx
  801ba6:	f7 f7                	div    %edi
  801ba8:	89 d3                	mov    %edx,%ebx
  801baa:	f7 24 24             	mull   (%esp)
  801bad:	89 c6                	mov    %eax,%esi
  801baf:	89 d1                	mov    %edx,%ecx
  801bb1:	39 d3                	cmp    %edx,%ebx
  801bb3:	0f 82 87 00 00 00    	jb     801c40 <__umoddi3+0x134>
  801bb9:	0f 84 91 00 00 00    	je     801c50 <__umoddi3+0x144>
  801bbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bc3:	29 f2                	sub    %esi,%edx
  801bc5:	19 cb                	sbb    %ecx,%ebx
  801bc7:	89 d8                	mov    %ebx,%eax
  801bc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bcd:	d3 e0                	shl    %cl,%eax
  801bcf:	89 e9                	mov    %ebp,%ecx
  801bd1:	d3 ea                	shr    %cl,%edx
  801bd3:	09 d0                	or     %edx,%eax
  801bd5:	89 e9                	mov    %ebp,%ecx
  801bd7:	d3 eb                	shr    %cl,%ebx
  801bd9:	89 da                	mov    %ebx,%edx
  801bdb:	83 c4 1c             	add    $0x1c,%esp
  801bde:	5b                   	pop    %ebx
  801bdf:	5e                   	pop    %esi
  801be0:	5f                   	pop    %edi
  801be1:	5d                   	pop    %ebp
  801be2:	c3                   	ret    
  801be3:	90                   	nop
  801be4:	89 fd                	mov    %edi,%ebp
  801be6:	85 ff                	test   %edi,%edi
  801be8:	75 0b                	jne    801bf5 <__umoddi3+0xe9>
  801bea:	b8 01 00 00 00       	mov    $0x1,%eax
  801bef:	31 d2                	xor    %edx,%edx
  801bf1:	f7 f7                	div    %edi
  801bf3:	89 c5                	mov    %eax,%ebp
  801bf5:	89 f0                	mov    %esi,%eax
  801bf7:	31 d2                	xor    %edx,%edx
  801bf9:	f7 f5                	div    %ebp
  801bfb:	89 c8                	mov    %ecx,%eax
  801bfd:	f7 f5                	div    %ebp
  801bff:	89 d0                	mov    %edx,%eax
  801c01:	e9 44 ff ff ff       	jmp    801b4a <__umoddi3+0x3e>
  801c06:	66 90                	xchg   %ax,%ax
  801c08:	89 c8                	mov    %ecx,%eax
  801c0a:	89 f2                	mov    %esi,%edx
  801c0c:	83 c4 1c             	add    $0x1c,%esp
  801c0f:	5b                   	pop    %ebx
  801c10:	5e                   	pop    %esi
  801c11:	5f                   	pop    %edi
  801c12:	5d                   	pop    %ebp
  801c13:	c3                   	ret    
  801c14:	3b 04 24             	cmp    (%esp),%eax
  801c17:	72 06                	jb     801c1f <__umoddi3+0x113>
  801c19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c1d:	77 0f                	ja     801c2e <__umoddi3+0x122>
  801c1f:	89 f2                	mov    %esi,%edx
  801c21:	29 f9                	sub    %edi,%ecx
  801c23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c27:	89 14 24             	mov    %edx,(%esp)
  801c2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c32:	8b 14 24             	mov    (%esp),%edx
  801c35:	83 c4 1c             	add    $0x1c,%esp
  801c38:	5b                   	pop    %ebx
  801c39:	5e                   	pop    %esi
  801c3a:	5f                   	pop    %edi
  801c3b:	5d                   	pop    %ebp
  801c3c:	c3                   	ret    
  801c3d:	8d 76 00             	lea    0x0(%esi),%esi
  801c40:	2b 04 24             	sub    (%esp),%eax
  801c43:	19 fa                	sbb    %edi,%edx
  801c45:	89 d1                	mov    %edx,%ecx
  801c47:	89 c6                	mov    %eax,%esi
  801c49:	e9 71 ff ff ff       	jmp    801bbf <__umoddi3+0xb3>
  801c4e:	66 90                	xchg   %ax,%ax
  801c50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c54:	72 ea                	jb     801c40 <__umoddi3+0x134>
  801c56:	89 d9                	mov    %ebx,%ecx
  801c58:	e9 62 ff ff ff       	jmp    801bbf <__umoddi3+0xb3>
