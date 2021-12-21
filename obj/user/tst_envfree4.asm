
obj/user/tst_envfree4:     file format elf32-i386


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
  800031:	e8 0d 01 00 00       	call   800143 <libmain>
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
	// Testing scenario 4: Freeing the allocated semaphores
	// Testing removing the shared variables
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 00 1f 80 00       	push   $0x801f00
  80004a:	e8 0e 15 00 00       	call   80155d <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 37 17 00 00       	call   80179a <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 b2 17 00 00       	call   80181d <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 10 1f 80 00       	push   $0x801f10
  800079:	e8 ac 04 00 00       	call   80052a <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tsem1", 100,(myEnv->SecondListSize), 50);
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80008c:	6a 32                	push   $0x32
  80008e:	50                   	push   %eax
  80008f:	6a 64                	push   $0x64
  800091:	68 43 1f 80 00       	push   $0x801f43
  800096:	e8 54 19 00 00       	call   8019ef <sys_create_env>
  80009b:	83 c4 10             	add    $0x10,%esp
  80009e:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(envIdProcessA);
  8000a1:	83 ec 0c             	sub    $0xc,%esp
  8000a4:	ff 75 e8             	pushl  -0x18(%ebp)
  8000a7:	e8 61 19 00 00       	call   801a0d <sys_run_env>
  8000ac:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 1) ;
  8000af:	90                   	nop
  8000b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b3:	8b 00                	mov    (%eax),%eax
  8000b5:	83 f8 01             	cmp    $0x1,%eax
  8000b8:	75 f6                	jne    8000b0 <_main+0x78>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000ba:	e8 db 16 00 00       	call   80179a <sys_calculate_free_frames>
  8000bf:	83 ec 08             	sub    $0x8,%esp
  8000c2:	50                   	push   %eax
  8000c3:	68 4c 1f 80 00       	push   $0x801f4c
  8000c8:	e8 5d 04 00 00       	call   80052a <cprintf>
  8000cd:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	ff 75 e8             	pushl  -0x18(%ebp)
  8000d6:	e8 4e 19 00 00       	call   801a29 <sys_free_env>
  8000db:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  8000de:	e8 b7 16 00 00       	call   80179a <sys_calculate_free_frames>
  8000e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  8000e6:	e8 32 17 00 00       	call   80181d <sys_pf_calculate_allocated_pages>
  8000eb:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  8000ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000f4:	74 27                	je     80011d <_main+0xe5>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  8000f6:	83 ec 08             	sub    $0x8,%esp
  8000f9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000fc:	68 80 1f 80 00       	push   $0x801f80
  800101:	e8 24 04 00 00       	call   80052a <cprintf>
  800106:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  800109:	83 ec 04             	sub    $0x4,%esp
  80010c:	68 d0 1f 80 00       	push   $0x801fd0
  800111:	6a 1f                	push   $0x1f
  800113:	68 06 20 80 00       	push   $0x802006
  800118:	e8 6b 01 00 00       	call   800288 <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80011d:	83 ec 08             	sub    $0x8,%esp
  800120:	ff 75 e4             	pushl  -0x1c(%ebp)
  800123:	68 1c 20 80 00       	push   $0x80201c
  800128:	e8 fd 03 00 00       	call   80052a <cprintf>
  80012d:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 4 for envfree completed successfully.\n");
  800130:	83 ec 0c             	sub    $0xc,%esp
  800133:	68 7c 20 80 00       	push   $0x80207c
  800138:	e8 ed 03 00 00       	call   80052a <cprintf>
  80013d:	83 c4 10             	add    $0x10,%esp
	return;
  800140:	90                   	nop
}
  800141:	c9                   	leave  
  800142:	c3                   	ret    

00800143 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800143:	55                   	push   %ebp
  800144:	89 e5                	mov    %esp,%ebp
  800146:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800149:	e8 81 15 00 00       	call   8016cf <sys_getenvindex>
  80014e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800151:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800154:	89 d0                	mov    %edx,%eax
  800156:	c1 e0 03             	shl    $0x3,%eax
  800159:	01 d0                	add    %edx,%eax
  80015b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800162:	01 c8                	add    %ecx,%eax
  800164:	01 c0                	add    %eax,%eax
  800166:	01 d0                	add    %edx,%eax
  800168:	01 c0                	add    %eax,%eax
  80016a:	01 d0                	add    %edx,%eax
  80016c:	89 c2                	mov    %eax,%edx
  80016e:	c1 e2 05             	shl    $0x5,%edx
  800171:	29 c2                	sub    %eax,%edx
  800173:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80017a:	89 c2                	mov    %eax,%edx
  80017c:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800182:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800187:	a1 20 30 80 00       	mov    0x803020,%eax
  80018c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800192:	84 c0                	test   %al,%al
  800194:	74 0f                	je     8001a5 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800196:	a1 20 30 80 00       	mov    0x803020,%eax
  80019b:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001a0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001a9:	7e 0a                	jle    8001b5 <libmain+0x72>
		binaryname = argv[0];
  8001ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ae:	8b 00                	mov    (%eax),%eax
  8001b0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001b5:	83 ec 08             	sub    $0x8,%esp
  8001b8:	ff 75 0c             	pushl  0xc(%ebp)
  8001bb:	ff 75 08             	pushl  0x8(%ebp)
  8001be:	e8 75 fe ff ff       	call   800038 <_main>
  8001c3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c6:	e8 9f 16 00 00       	call   80186a <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	68 e0 20 80 00       	push   $0x8020e0
  8001d3:	e8 52 03 00 00       	call   80052a <cprintf>
  8001d8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001db:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e0:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001eb:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	52                   	push   %edx
  8001f5:	50                   	push   %eax
  8001f6:	68 08 21 80 00       	push   $0x802108
  8001fb:	e8 2a 03 00 00       	call   80052a <cprintf>
  800200:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800203:	a1 20 30 80 00       	mov    0x803020,%eax
  800208:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800219:	83 ec 04             	sub    $0x4,%esp
  80021c:	52                   	push   %edx
  80021d:	50                   	push   %eax
  80021e:	68 30 21 80 00       	push   $0x802130
  800223:	e8 02 03 00 00       	call   80052a <cprintf>
  800228:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800236:	83 ec 08             	sub    $0x8,%esp
  800239:	50                   	push   %eax
  80023a:	68 71 21 80 00       	push   $0x802171
  80023f:	e8 e6 02 00 00       	call   80052a <cprintf>
  800244:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800247:	83 ec 0c             	sub    $0xc,%esp
  80024a:	68 e0 20 80 00       	push   $0x8020e0
  80024f:	e8 d6 02 00 00       	call   80052a <cprintf>
  800254:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800257:	e8 28 16 00 00       	call   801884 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80025c:	e8 19 00 00 00       	call   80027a <exit>
}
  800261:	90                   	nop
  800262:	c9                   	leave  
  800263:	c3                   	ret    

00800264 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800264:	55                   	push   %ebp
  800265:	89 e5                	mov    %esp,%ebp
  800267:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	6a 00                	push   $0x0
  80026f:	e8 27 14 00 00       	call   80169b <sys_env_destroy>
  800274:	83 c4 10             	add    $0x10,%esp
}
  800277:	90                   	nop
  800278:	c9                   	leave  
  800279:	c3                   	ret    

0080027a <exit>:

void
exit(void)
{
  80027a:	55                   	push   %ebp
  80027b:	89 e5                	mov    %esp,%ebp
  80027d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800280:	e8 7c 14 00 00       	call   801701 <sys_env_exit>
}
  800285:	90                   	nop
  800286:	c9                   	leave  
  800287:	c3                   	ret    

00800288 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800288:	55                   	push   %ebp
  800289:	89 e5                	mov    %esp,%ebp
  80028b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80028e:	8d 45 10             	lea    0x10(%ebp),%eax
  800291:	83 c0 04             	add    $0x4,%eax
  800294:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800297:	a1 18 31 80 00       	mov    0x803118,%eax
  80029c:	85 c0                	test   %eax,%eax
  80029e:	74 16                	je     8002b6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002a0:	a1 18 31 80 00       	mov    0x803118,%eax
  8002a5:	83 ec 08             	sub    $0x8,%esp
  8002a8:	50                   	push   %eax
  8002a9:	68 88 21 80 00       	push   $0x802188
  8002ae:	e8 77 02 00 00       	call   80052a <cprintf>
  8002b3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002b6:	a1 00 30 80 00       	mov    0x803000,%eax
  8002bb:	ff 75 0c             	pushl  0xc(%ebp)
  8002be:	ff 75 08             	pushl  0x8(%ebp)
  8002c1:	50                   	push   %eax
  8002c2:	68 8d 21 80 00       	push   $0x80218d
  8002c7:	e8 5e 02 00 00       	call   80052a <cprintf>
  8002cc:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d8:	50                   	push   %eax
  8002d9:	e8 e1 01 00 00       	call   8004bf <vcprintf>
  8002de:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002e1:	83 ec 08             	sub    $0x8,%esp
  8002e4:	6a 00                	push   $0x0
  8002e6:	68 a9 21 80 00       	push   $0x8021a9
  8002eb:	e8 cf 01 00 00       	call   8004bf <vcprintf>
  8002f0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002f3:	e8 82 ff ff ff       	call   80027a <exit>

	// should not return here
	while (1) ;
  8002f8:	eb fe                	jmp    8002f8 <_panic+0x70>

008002fa <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002fa:	55                   	push   %ebp
  8002fb:	89 e5                	mov    %esp,%ebp
  8002fd:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800300:	a1 20 30 80 00       	mov    0x803020,%eax
  800305:	8b 50 74             	mov    0x74(%eax),%edx
  800308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	74 14                	je     800323 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80030f:	83 ec 04             	sub    $0x4,%esp
  800312:	68 ac 21 80 00       	push   $0x8021ac
  800317:	6a 26                	push   $0x26
  800319:	68 f8 21 80 00       	push   $0x8021f8
  80031e:	e8 65 ff ff ff       	call   800288 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800323:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80032a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800331:	e9 b6 00 00 00       	jmp    8003ec <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800336:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800339:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800340:	8b 45 08             	mov    0x8(%ebp),%eax
  800343:	01 d0                	add    %edx,%eax
  800345:	8b 00                	mov    (%eax),%eax
  800347:	85 c0                	test   %eax,%eax
  800349:	75 08                	jne    800353 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80034b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80034e:	e9 96 00 00 00       	jmp    8003e9 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800353:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80035a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800361:	eb 5d                	jmp    8003c0 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800363:	a1 20 30 80 00       	mov    0x803020,%eax
  800368:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80036e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800371:	c1 e2 04             	shl    $0x4,%edx
  800374:	01 d0                	add    %edx,%eax
  800376:	8a 40 04             	mov    0x4(%eax),%al
  800379:	84 c0                	test   %al,%al
  80037b:	75 40                	jne    8003bd <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80037d:	a1 20 30 80 00       	mov    0x803020,%eax
  800382:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800388:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80038b:	c1 e2 04             	shl    $0x4,%edx
  80038e:	01 d0                	add    %edx,%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800395:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800398:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80039f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	01 c8                	add    %ecx,%eax
  8003ae:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b0:	39 c2                	cmp    %eax,%edx
  8003b2:	75 09                	jne    8003bd <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003b4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003bb:	eb 12                	jmp    8003cf <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003bd:	ff 45 e8             	incl   -0x18(%ebp)
  8003c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c5:	8b 50 74             	mov    0x74(%eax),%edx
  8003c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003cb:	39 c2                	cmp    %eax,%edx
  8003cd:	77 94                	ja     800363 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003d3:	75 14                	jne    8003e9 <CheckWSWithoutLastIndex+0xef>
			panic(
  8003d5:	83 ec 04             	sub    $0x4,%esp
  8003d8:	68 04 22 80 00       	push   $0x802204
  8003dd:	6a 3a                	push   $0x3a
  8003df:	68 f8 21 80 00       	push   $0x8021f8
  8003e4:	e8 9f fe ff ff       	call   800288 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003e9:	ff 45 f0             	incl   -0x10(%ebp)
  8003ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003f2:	0f 8c 3e ff ff ff    	jl     800336 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800406:	eb 20                	jmp    800428 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800408:	a1 20 30 80 00       	mov    0x803020,%eax
  80040d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800413:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800416:	c1 e2 04             	shl    $0x4,%edx
  800419:	01 d0                	add    %edx,%eax
  80041b:	8a 40 04             	mov    0x4(%eax),%al
  80041e:	3c 01                	cmp    $0x1,%al
  800420:	75 03                	jne    800425 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800422:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800425:	ff 45 e0             	incl   -0x20(%ebp)
  800428:	a1 20 30 80 00       	mov    0x803020,%eax
  80042d:	8b 50 74             	mov    0x74(%eax),%edx
  800430:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800433:	39 c2                	cmp    %eax,%edx
  800435:	77 d1                	ja     800408 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800437:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80043d:	74 14                	je     800453 <CheckWSWithoutLastIndex+0x159>
		panic(
  80043f:	83 ec 04             	sub    $0x4,%esp
  800442:	68 58 22 80 00       	push   $0x802258
  800447:	6a 44                	push   $0x44
  800449:	68 f8 21 80 00       	push   $0x8021f8
  80044e:	e8 35 fe ff ff       	call   800288 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800453:	90                   	nop
  800454:	c9                   	leave  
  800455:	c3                   	ret    

00800456 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800456:	55                   	push   %ebp
  800457:	89 e5                	mov    %esp,%ebp
  800459:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	8d 48 01             	lea    0x1(%eax),%ecx
  800464:	8b 55 0c             	mov    0xc(%ebp),%edx
  800467:	89 0a                	mov    %ecx,(%edx)
  800469:	8b 55 08             	mov    0x8(%ebp),%edx
  80046c:	88 d1                	mov    %dl,%cl
  80046e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800471:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800475:	8b 45 0c             	mov    0xc(%ebp),%eax
  800478:	8b 00                	mov    (%eax),%eax
  80047a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80047f:	75 2c                	jne    8004ad <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800481:	a0 24 30 80 00       	mov    0x803024,%al
  800486:	0f b6 c0             	movzbl %al,%eax
  800489:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048c:	8b 12                	mov    (%edx),%edx
  80048e:	89 d1                	mov    %edx,%ecx
  800490:	8b 55 0c             	mov    0xc(%ebp),%edx
  800493:	83 c2 08             	add    $0x8,%edx
  800496:	83 ec 04             	sub    $0x4,%esp
  800499:	50                   	push   %eax
  80049a:	51                   	push   %ecx
  80049b:	52                   	push   %edx
  80049c:	e8 b8 11 00 00       	call   801659 <sys_cputs>
  8004a1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b0:	8b 40 04             	mov    0x4(%eax),%eax
  8004b3:	8d 50 01             	lea    0x1(%eax),%edx
  8004b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004bc:	90                   	nop
  8004bd:	c9                   	leave  
  8004be:	c3                   	ret    

008004bf <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004bf:	55                   	push   %ebp
  8004c0:	89 e5                	mov    %esp,%ebp
  8004c2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004c8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004cf:	00 00 00 
	b.cnt = 0;
  8004d2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004d9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e8:	50                   	push   %eax
  8004e9:	68 56 04 80 00       	push   $0x800456
  8004ee:	e8 11 02 00 00       	call   800704 <vprintfmt>
  8004f3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f6:	a0 24 30 80 00       	mov    0x803024,%al
  8004fb:	0f b6 c0             	movzbl %al,%eax
  8004fe:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800504:	83 ec 04             	sub    $0x4,%esp
  800507:	50                   	push   %eax
  800508:	52                   	push   %edx
  800509:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80050f:	83 c0 08             	add    $0x8,%eax
  800512:	50                   	push   %eax
  800513:	e8 41 11 00 00       	call   801659 <sys_cputs>
  800518:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80051b:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800522:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800528:	c9                   	leave  
  800529:	c3                   	ret    

0080052a <cprintf>:

int cprintf(const char *fmt, ...) {
  80052a:	55                   	push   %ebp
  80052b:	89 e5                	mov    %esp,%ebp
  80052d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800530:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800537:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	83 ec 08             	sub    $0x8,%esp
  800543:	ff 75 f4             	pushl  -0xc(%ebp)
  800546:	50                   	push   %eax
  800547:	e8 73 ff ff ff       	call   8004bf <vcprintf>
  80054c:	83 c4 10             	add    $0x10,%esp
  80054f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800552:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800555:	c9                   	leave  
  800556:	c3                   	ret    

00800557 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800557:	55                   	push   %ebp
  800558:	89 e5                	mov    %esp,%ebp
  80055a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055d:	e8 08 13 00 00       	call   80186a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800562:	8d 45 0c             	lea    0xc(%ebp),%eax
  800565:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 f4             	pushl  -0xc(%ebp)
  800571:	50                   	push   %eax
  800572:	e8 48 ff ff ff       	call   8004bf <vcprintf>
  800577:	83 c4 10             	add    $0x10,%esp
  80057a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80057d:	e8 02 13 00 00       	call   801884 <sys_enable_interrupt>
	return cnt;
  800582:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800585:	c9                   	leave  
  800586:	c3                   	ret    

00800587 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800587:	55                   	push   %ebp
  800588:	89 e5                	mov    %esp,%ebp
  80058a:	53                   	push   %ebx
  80058b:	83 ec 14             	sub    $0x14,%esp
  80058e:	8b 45 10             	mov    0x10(%ebp),%eax
  800591:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800594:	8b 45 14             	mov    0x14(%ebp),%eax
  800597:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80059a:	8b 45 18             	mov    0x18(%ebp),%eax
  80059d:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a5:	77 55                	ja     8005fc <printnum+0x75>
  8005a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005aa:	72 05                	jb     8005b1 <printnum+0x2a>
  8005ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005af:	77 4b                	ja     8005fc <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005b1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005b7:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ba:	ba 00 00 00 00       	mov    $0x0,%edx
  8005bf:	52                   	push   %edx
  8005c0:	50                   	push   %eax
  8005c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c4:	ff 75 f0             	pushl  -0x10(%ebp)
  8005c7:	e8 c0 16 00 00       	call   801c8c <__udivdi3>
  8005cc:	83 c4 10             	add    $0x10,%esp
  8005cf:	83 ec 04             	sub    $0x4,%esp
  8005d2:	ff 75 20             	pushl  0x20(%ebp)
  8005d5:	53                   	push   %ebx
  8005d6:	ff 75 18             	pushl  0x18(%ebp)
  8005d9:	52                   	push   %edx
  8005da:	50                   	push   %eax
  8005db:	ff 75 0c             	pushl  0xc(%ebp)
  8005de:	ff 75 08             	pushl  0x8(%ebp)
  8005e1:	e8 a1 ff ff ff       	call   800587 <printnum>
  8005e6:	83 c4 20             	add    $0x20,%esp
  8005e9:	eb 1a                	jmp    800605 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005eb:	83 ec 08             	sub    $0x8,%esp
  8005ee:	ff 75 0c             	pushl  0xc(%ebp)
  8005f1:	ff 75 20             	pushl  0x20(%ebp)
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	ff d0                	call   *%eax
  8005f9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005fc:	ff 4d 1c             	decl   0x1c(%ebp)
  8005ff:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800603:	7f e6                	jg     8005eb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800605:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800608:	bb 00 00 00 00       	mov    $0x0,%ebx
  80060d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800610:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800613:	53                   	push   %ebx
  800614:	51                   	push   %ecx
  800615:	52                   	push   %edx
  800616:	50                   	push   %eax
  800617:	e8 80 17 00 00       	call   801d9c <__umoddi3>
  80061c:	83 c4 10             	add    $0x10,%esp
  80061f:	05 d4 24 80 00       	add    $0x8024d4,%eax
  800624:	8a 00                	mov    (%eax),%al
  800626:	0f be c0             	movsbl %al,%eax
  800629:	83 ec 08             	sub    $0x8,%esp
  80062c:	ff 75 0c             	pushl  0xc(%ebp)
  80062f:	50                   	push   %eax
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	ff d0                	call   *%eax
  800635:	83 c4 10             	add    $0x10,%esp
}
  800638:	90                   	nop
  800639:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063c:	c9                   	leave  
  80063d:	c3                   	ret    

0080063e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80063e:	55                   	push   %ebp
  80063f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800641:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800645:	7e 1c                	jle    800663 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	8d 50 08             	lea    0x8(%eax),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	89 10                	mov    %edx,(%eax)
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	83 e8 08             	sub    $0x8,%eax
  80065c:	8b 50 04             	mov    0x4(%eax),%edx
  80065f:	8b 00                	mov    (%eax),%eax
  800661:	eb 40                	jmp    8006a3 <getuint+0x65>
	else if (lflag)
  800663:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800667:	74 1e                	je     800687 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	8b 00                	mov    (%eax),%eax
  80066e:	8d 50 04             	lea    0x4(%eax),%edx
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	89 10                	mov    %edx,(%eax)
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	8b 00                	mov    (%eax),%eax
  80067b:	83 e8 04             	sub    $0x4,%eax
  80067e:	8b 00                	mov    (%eax),%eax
  800680:	ba 00 00 00 00       	mov    $0x0,%edx
  800685:	eb 1c                	jmp    8006a3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800687:	8b 45 08             	mov    0x8(%ebp),%eax
  80068a:	8b 00                	mov    (%eax),%eax
  80068c:	8d 50 04             	lea    0x4(%eax),%edx
  80068f:	8b 45 08             	mov    0x8(%ebp),%eax
  800692:	89 10                	mov    %edx,(%eax)
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	8b 00                	mov    (%eax),%eax
  800699:	83 e8 04             	sub    $0x4,%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a3:	5d                   	pop    %ebp
  8006a4:	c3                   	ret    

008006a5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a5:	55                   	push   %ebp
  8006a6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006a8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ac:	7e 1c                	jle    8006ca <getint+0x25>
		return va_arg(*ap, long long);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	8d 50 08             	lea    0x8(%eax),%edx
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	89 10                	mov    %edx,(%eax)
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	83 e8 08             	sub    $0x8,%eax
  8006c3:	8b 50 04             	mov    0x4(%eax),%edx
  8006c6:	8b 00                	mov    (%eax),%eax
  8006c8:	eb 38                	jmp    800702 <getint+0x5d>
	else if (lflag)
  8006ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ce:	74 1a                	je     8006ea <getint+0x45>
		return va_arg(*ap, long);
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	8d 50 04             	lea    0x4(%eax),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	89 10                	mov    %edx,(%eax)
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	8b 00                	mov    (%eax),%eax
  8006e2:	83 e8 04             	sub    $0x4,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	99                   	cltd   
  8006e8:	eb 18                	jmp    800702 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ed:	8b 00                	mov    (%eax),%eax
  8006ef:	8d 50 04             	lea    0x4(%eax),%edx
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	89 10                	mov    %edx,(%eax)
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	83 e8 04             	sub    $0x4,%eax
  8006ff:	8b 00                	mov    (%eax),%eax
  800701:	99                   	cltd   
}
  800702:	5d                   	pop    %ebp
  800703:	c3                   	ret    

00800704 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800704:	55                   	push   %ebp
  800705:	89 e5                	mov    %esp,%ebp
  800707:	56                   	push   %esi
  800708:	53                   	push   %ebx
  800709:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070c:	eb 17                	jmp    800725 <vprintfmt+0x21>
			if (ch == '\0')
  80070e:	85 db                	test   %ebx,%ebx
  800710:	0f 84 af 03 00 00    	je     800ac5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800716:	83 ec 08             	sub    $0x8,%esp
  800719:	ff 75 0c             	pushl  0xc(%ebp)
  80071c:	53                   	push   %ebx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	ff d0                	call   *%eax
  800722:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800725:	8b 45 10             	mov    0x10(%ebp),%eax
  800728:	8d 50 01             	lea    0x1(%eax),%edx
  80072b:	89 55 10             	mov    %edx,0x10(%ebp)
  80072e:	8a 00                	mov    (%eax),%al
  800730:	0f b6 d8             	movzbl %al,%ebx
  800733:	83 fb 25             	cmp    $0x25,%ebx
  800736:	75 d6                	jne    80070e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800738:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800743:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80074a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800751:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800758:	8b 45 10             	mov    0x10(%ebp),%eax
  80075b:	8d 50 01             	lea    0x1(%eax),%edx
  80075e:	89 55 10             	mov    %edx,0x10(%ebp)
  800761:	8a 00                	mov    (%eax),%al
  800763:	0f b6 d8             	movzbl %al,%ebx
  800766:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800769:	83 f8 55             	cmp    $0x55,%eax
  80076c:	0f 87 2b 03 00 00    	ja     800a9d <vprintfmt+0x399>
  800772:	8b 04 85 f8 24 80 00 	mov    0x8024f8(,%eax,4),%eax
  800779:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80077b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80077f:	eb d7                	jmp    800758 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800781:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800785:	eb d1                	jmp    800758 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800787:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80078e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800791:	89 d0                	mov    %edx,%eax
  800793:	c1 e0 02             	shl    $0x2,%eax
  800796:	01 d0                	add    %edx,%eax
  800798:	01 c0                	add    %eax,%eax
  80079a:	01 d8                	add    %ebx,%eax
  80079c:	83 e8 30             	sub    $0x30,%eax
  80079f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a5:	8a 00                	mov    (%eax),%al
  8007a7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007aa:	83 fb 2f             	cmp    $0x2f,%ebx
  8007ad:	7e 3e                	jle    8007ed <vprintfmt+0xe9>
  8007af:	83 fb 39             	cmp    $0x39,%ebx
  8007b2:	7f 39                	jg     8007ed <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007b7:	eb d5                	jmp    80078e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bc:	83 c0 04             	add    $0x4,%eax
  8007bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c5:	83 e8 04             	sub    $0x4,%eax
  8007c8:	8b 00                	mov    (%eax),%eax
  8007ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007cd:	eb 1f                	jmp    8007ee <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d3:	79 83                	jns    800758 <vprintfmt+0x54>
				width = 0;
  8007d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007dc:	e9 77 ff ff ff       	jmp    800758 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007e1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007e8:	e9 6b ff ff ff       	jmp    800758 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007ed:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f2:	0f 89 60 ff ff ff    	jns    800758 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007fe:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800805:	e9 4e ff ff ff       	jmp    800758 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80080a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80080d:	e9 46 ff ff ff       	jmp    800758 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800812:	8b 45 14             	mov    0x14(%ebp),%eax
  800815:	83 c0 04             	add    $0x4,%eax
  800818:	89 45 14             	mov    %eax,0x14(%ebp)
  80081b:	8b 45 14             	mov    0x14(%ebp),%eax
  80081e:	83 e8 04             	sub    $0x4,%eax
  800821:	8b 00                	mov    (%eax),%eax
  800823:	83 ec 08             	sub    $0x8,%esp
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	50                   	push   %eax
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
			break;
  800832:	e9 89 02 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800837:	8b 45 14             	mov    0x14(%ebp),%eax
  80083a:	83 c0 04             	add    $0x4,%eax
  80083d:	89 45 14             	mov    %eax,0x14(%ebp)
  800840:	8b 45 14             	mov    0x14(%ebp),%eax
  800843:	83 e8 04             	sub    $0x4,%eax
  800846:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800848:	85 db                	test   %ebx,%ebx
  80084a:	79 02                	jns    80084e <vprintfmt+0x14a>
				err = -err;
  80084c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80084e:	83 fb 64             	cmp    $0x64,%ebx
  800851:	7f 0b                	jg     80085e <vprintfmt+0x15a>
  800853:	8b 34 9d 40 23 80 00 	mov    0x802340(,%ebx,4),%esi
  80085a:	85 f6                	test   %esi,%esi
  80085c:	75 19                	jne    800877 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80085e:	53                   	push   %ebx
  80085f:	68 e5 24 80 00       	push   $0x8024e5
  800864:	ff 75 0c             	pushl  0xc(%ebp)
  800867:	ff 75 08             	pushl  0x8(%ebp)
  80086a:	e8 5e 02 00 00       	call   800acd <printfmt>
  80086f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800872:	e9 49 02 00 00       	jmp    800ac0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800877:	56                   	push   %esi
  800878:	68 ee 24 80 00       	push   $0x8024ee
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	ff 75 08             	pushl  0x8(%ebp)
  800883:	e8 45 02 00 00       	call   800acd <printfmt>
  800888:	83 c4 10             	add    $0x10,%esp
			break;
  80088b:	e9 30 02 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800890:	8b 45 14             	mov    0x14(%ebp),%eax
  800893:	83 c0 04             	add    $0x4,%eax
  800896:	89 45 14             	mov    %eax,0x14(%ebp)
  800899:	8b 45 14             	mov    0x14(%ebp),%eax
  80089c:	83 e8 04             	sub    $0x4,%eax
  80089f:	8b 30                	mov    (%eax),%esi
  8008a1:	85 f6                	test   %esi,%esi
  8008a3:	75 05                	jne    8008aa <vprintfmt+0x1a6>
				p = "(null)";
  8008a5:	be f1 24 80 00       	mov    $0x8024f1,%esi
			if (width > 0 && padc != '-')
  8008aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ae:	7e 6d                	jle    80091d <vprintfmt+0x219>
  8008b0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b4:	74 67                	je     80091d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b9:	83 ec 08             	sub    $0x8,%esp
  8008bc:	50                   	push   %eax
  8008bd:	56                   	push   %esi
  8008be:	e8 0c 03 00 00       	call   800bcf <strnlen>
  8008c3:	83 c4 10             	add    $0x10,%esp
  8008c6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008c9:	eb 16                	jmp    8008e1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008cb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 0c             	pushl  0xc(%ebp)
  8008d5:	50                   	push   %eax
  8008d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d9:	ff d0                	call   *%eax
  8008db:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008de:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e5:	7f e4                	jg     8008cb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e7:	eb 34                	jmp    80091d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008e9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008ed:	74 1c                	je     80090b <vprintfmt+0x207>
  8008ef:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f2:	7e 05                	jle    8008f9 <vprintfmt+0x1f5>
  8008f4:	83 fb 7e             	cmp    $0x7e,%ebx
  8008f7:	7e 12                	jle    80090b <vprintfmt+0x207>
					putch('?', putdat);
  8008f9:	83 ec 08             	sub    $0x8,%esp
  8008fc:	ff 75 0c             	pushl  0xc(%ebp)
  8008ff:	6a 3f                	push   $0x3f
  800901:	8b 45 08             	mov    0x8(%ebp),%eax
  800904:	ff d0                	call   *%eax
  800906:	83 c4 10             	add    $0x10,%esp
  800909:	eb 0f                	jmp    80091a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80090b:	83 ec 08             	sub    $0x8,%esp
  80090e:	ff 75 0c             	pushl  0xc(%ebp)
  800911:	53                   	push   %ebx
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	ff d0                	call   *%eax
  800917:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091a:	ff 4d e4             	decl   -0x1c(%ebp)
  80091d:	89 f0                	mov    %esi,%eax
  80091f:	8d 70 01             	lea    0x1(%eax),%esi
  800922:	8a 00                	mov    (%eax),%al
  800924:	0f be d8             	movsbl %al,%ebx
  800927:	85 db                	test   %ebx,%ebx
  800929:	74 24                	je     80094f <vprintfmt+0x24b>
  80092b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80092f:	78 b8                	js     8008e9 <vprintfmt+0x1e5>
  800931:	ff 4d e0             	decl   -0x20(%ebp)
  800934:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800938:	79 af                	jns    8008e9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80093a:	eb 13                	jmp    80094f <vprintfmt+0x24b>
				putch(' ', putdat);
  80093c:	83 ec 08             	sub    $0x8,%esp
  80093f:	ff 75 0c             	pushl  0xc(%ebp)
  800942:	6a 20                	push   $0x20
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	ff d0                	call   *%eax
  800949:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094c:	ff 4d e4             	decl   -0x1c(%ebp)
  80094f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800953:	7f e7                	jg     80093c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800955:	e9 66 01 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 e8             	pushl  -0x18(%ebp)
  800960:	8d 45 14             	lea    0x14(%ebp),%eax
  800963:	50                   	push   %eax
  800964:	e8 3c fd ff ff       	call   8006a5 <getint>
  800969:	83 c4 10             	add    $0x10,%esp
  80096c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800972:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800975:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800978:	85 d2                	test   %edx,%edx
  80097a:	79 23                	jns    80099f <vprintfmt+0x29b>
				putch('-', putdat);
  80097c:	83 ec 08             	sub    $0x8,%esp
  80097f:	ff 75 0c             	pushl  0xc(%ebp)
  800982:	6a 2d                	push   $0x2d
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	ff d0                	call   *%eax
  800989:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80098f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800992:	f7 d8                	neg    %eax
  800994:	83 d2 00             	adc    $0x0,%edx
  800997:	f7 da                	neg    %edx
  800999:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80099f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a6:	e9 bc 00 00 00       	jmp    800a67 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ab:	83 ec 08             	sub    $0x8,%esp
  8009ae:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b1:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b4:	50                   	push   %eax
  8009b5:	e8 84 fc ff ff       	call   80063e <getuint>
  8009ba:	83 c4 10             	add    $0x10,%esp
  8009bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009ca:	e9 98 00 00 00       	jmp    800a67 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009cf:	83 ec 08             	sub    $0x8,%esp
  8009d2:	ff 75 0c             	pushl  0xc(%ebp)
  8009d5:	6a 58                	push   $0x58
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	ff d0                	call   *%eax
  8009dc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	6a 58                	push   $0x58
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	ff 75 0c             	pushl  0xc(%ebp)
  8009f5:	6a 58                	push   $0x58
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	ff d0                	call   *%eax
  8009fc:	83 c4 10             	add    $0x10,%esp
			break;
  8009ff:	e9 bc 00 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a04:	83 ec 08             	sub    $0x8,%esp
  800a07:	ff 75 0c             	pushl  0xc(%ebp)
  800a0a:	6a 30                	push   $0x30
  800a0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0f:	ff d0                	call   *%eax
  800a11:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	6a 78                	push   $0x78
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a24:	8b 45 14             	mov    0x14(%ebp),%eax
  800a27:	83 c0 04             	add    $0x4,%eax
  800a2a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a30:	83 e8 04             	sub    $0x4,%eax
  800a33:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a3f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a46:	eb 1f                	jmp    800a67 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 e8             	pushl  -0x18(%ebp)
  800a4e:	8d 45 14             	lea    0x14(%ebp),%eax
  800a51:	50                   	push   %eax
  800a52:	e8 e7 fb ff ff       	call   80063e <getuint>
  800a57:	83 c4 10             	add    $0x10,%esp
  800a5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a60:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a67:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a6b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	52                   	push   %edx
  800a72:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a75:	50                   	push   %eax
  800a76:	ff 75 f4             	pushl  -0xc(%ebp)
  800a79:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7c:	ff 75 0c             	pushl  0xc(%ebp)
  800a7f:	ff 75 08             	pushl  0x8(%ebp)
  800a82:	e8 00 fb ff ff       	call   800587 <printnum>
  800a87:	83 c4 20             	add    $0x20,%esp
			break;
  800a8a:	eb 34                	jmp    800ac0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8c:	83 ec 08             	sub    $0x8,%esp
  800a8f:	ff 75 0c             	pushl  0xc(%ebp)
  800a92:	53                   	push   %ebx
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	ff d0                	call   *%eax
  800a98:	83 c4 10             	add    $0x10,%esp
			break;
  800a9b:	eb 23                	jmp    800ac0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a9d:	83 ec 08             	sub    $0x8,%esp
  800aa0:	ff 75 0c             	pushl  0xc(%ebp)
  800aa3:	6a 25                	push   $0x25
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	ff d0                	call   *%eax
  800aaa:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aad:	ff 4d 10             	decl   0x10(%ebp)
  800ab0:	eb 03                	jmp    800ab5 <vprintfmt+0x3b1>
  800ab2:	ff 4d 10             	decl   0x10(%ebp)
  800ab5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab8:	48                   	dec    %eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	3c 25                	cmp    $0x25,%al
  800abd:	75 f3                	jne    800ab2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800abf:	90                   	nop
		}
	}
  800ac0:	e9 47 fc ff ff       	jmp    80070c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ac9:	5b                   	pop    %ebx
  800aca:	5e                   	pop    %esi
  800acb:	5d                   	pop    %ebp
  800acc:	c3                   	ret    

00800acd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800acd:	55                   	push   %ebp
  800ace:	89 e5                	mov    %esp,%ebp
  800ad0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad3:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad6:	83 c0 04             	add    $0x4,%eax
  800ad9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800adc:	8b 45 10             	mov    0x10(%ebp),%eax
  800adf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae2:	50                   	push   %eax
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	ff 75 08             	pushl  0x8(%ebp)
  800ae9:	e8 16 fc ff ff       	call   800704 <vprintfmt>
  800aee:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800af1:	90                   	nop
  800af2:	c9                   	leave  
  800af3:	c3                   	ret    

00800af4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af4:	55                   	push   %ebp
  800af5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afa:	8b 40 08             	mov    0x8(%eax),%eax
  800afd:	8d 50 01             	lea    0x1(%eax),%edx
  800b00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b03:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b09:	8b 10                	mov    (%eax),%edx
  800b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0e:	8b 40 04             	mov    0x4(%eax),%eax
  800b11:	39 c2                	cmp    %eax,%edx
  800b13:	73 12                	jae    800b27 <sprintputch+0x33>
		*b->buf++ = ch;
  800b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b18:	8b 00                	mov    (%eax),%eax
  800b1a:	8d 48 01             	lea    0x1(%eax),%ecx
  800b1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b20:	89 0a                	mov    %ecx,(%edx)
  800b22:	8b 55 08             	mov    0x8(%ebp),%edx
  800b25:	88 10                	mov    %dl,(%eax)
}
  800b27:	90                   	nop
  800b28:	5d                   	pop    %ebp
  800b29:	c3                   	ret    

00800b2a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b2a:	55                   	push   %ebp
  800b2b:	89 e5                	mov    %esp,%ebp
  800b2d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b39:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	01 d0                	add    %edx,%eax
  800b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b4b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b4f:	74 06                	je     800b57 <vsnprintf+0x2d>
  800b51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b55:	7f 07                	jg     800b5e <vsnprintf+0x34>
		return -E_INVAL;
  800b57:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5c:	eb 20                	jmp    800b7e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b5e:	ff 75 14             	pushl  0x14(%ebp)
  800b61:	ff 75 10             	pushl  0x10(%ebp)
  800b64:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b67:	50                   	push   %eax
  800b68:	68 f4 0a 80 00       	push   $0x800af4
  800b6d:	e8 92 fb ff ff       	call   800704 <vprintfmt>
  800b72:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b75:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b78:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b7e:	c9                   	leave  
  800b7f:	c3                   	ret    

00800b80 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b80:	55                   	push   %ebp
  800b81:	89 e5                	mov    %esp,%ebp
  800b83:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b86:	8d 45 10             	lea    0x10(%ebp),%eax
  800b89:	83 c0 04             	add    $0x4,%eax
  800b8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b92:	ff 75 f4             	pushl  -0xc(%ebp)
  800b95:	50                   	push   %eax
  800b96:	ff 75 0c             	pushl  0xc(%ebp)
  800b99:	ff 75 08             	pushl  0x8(%ebp)
  800b9c:	e8 89 ff ff ff       	call   800b2a <vsnprintf>
  800ba1:	83 c4 10             	add    $0x10,%esp
  800ba4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ba7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800baa:	c9                   	leave  
  800bab:	c3                   	ret    

00800bac <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bac:	55                   	push   %ebp
  800bad:	89 e5                	mov    %esp,%ebp
  800baf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb9:	eb 06                	jmp    800bc1 <strlen+0x15>
		n++;
  800bbb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bbe:	ff 45 08             	incl   0x8(%ebp)
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	8a 00                	mov    (%eax),%al
  800bc6:	84 c0                	test   %al,%al
  800bc8:	75 f1                	jne    800bbb <strlen+0xf>
		n++;
	return n;
  800bca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcd:	c9                   	leave  
  800bce:	c3                   	ret    

00800bcf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bcf:	55                   	push   %ebp
  800bd0:	89 e5                	mov    %esp,%ebp
  800bd2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdc:	eb 09                	jmp    800be7 <strnlen+0x18>
		n++;
  800bde:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be1:	ff 45 08             	incl   0x8(%ebp)
  800be4:	ff 4d 0c             	decl   0xc(%ebp)
  800be7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800beb:	74 09                	je     800bf6 <strnlen+0x27>
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	8a 00                	mov    (%eax),%al
  800bf2:	84 c0                	test   %al,%al
  800bf4:	75 e8                	jne    800bde <strnlen+0xf>
		n++;
	return n;
  800bf6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bf9:	c9                   	leave  
  800bfa:	c3                   	ret    

00800bfb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bfb:	55                   	push   %ebp
  800bfc:	89 e5                	mov    %esp,%ebp
  800bfe:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c07:	90                   	nop
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	8d 50 01             	lea    0x1(%eax),%edx
  800c0e:	89 55 08             	mov    %edx,0x8(%ebp)
  800c11:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c14:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c17:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1a:	8a 12                	mov    (%edx),%dl
  800c1c:	88 10                	mov    %dl,(%eax)
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	84 c0                	test   %al,%al
  800c22:	75 e4                	jne    800c08 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c24:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3c:	eb 1f                	jmp    800c5d <strncpy+0x34>
		*dst++ = *src;
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8d 50 01             	lea    0x1(%eax),%edx
  800c44:	89 55 08             	mov    %edx,0x8(%ebp)
  800c47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4a:	8a 12                	mov    (%edx),%dl
  800c4c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	84 c0                	test   %al,%al
  800c55:	74 03                	je     800c5a <strncpy+0x31>
			src++;
  800c57:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c5a:	ff 45 fc             	incl   -0x4(%ebp)
  800c5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c60:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c63:	72 d9                	jb     800c3e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c65:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c68:	c9                   	leave  
  800c69:	c3                   	ret    

00800c6a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c6a:	55                   	push   %ebp
  800c6b:	89 e5                	mov    %esp,%ebp
  800c6d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7a:	74 30                	je     800cac <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7c:	eb 16                	jmp    800c94 <strlcpy+0x2a>
			*dst++ = *src++;
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8d 50 01             	lea    0x1(%eax),%edx
  800c84:	89 55 08             	mov    %edx,0x8(%ebp)
  800c87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c90:	8a 12                	mov    (%edx),%dl
  800c92:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c94:	ff 4d 10             	decl   0x10(%ebp)
  800c97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9b:	74 09                	je     800ca6 <strlcpy+0x3c>
  800c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	84 c0                	test   %al,%al
  800ca4:	75 d8                	jne    800c7e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cac:	8b 55 08             	mov    0x8(%ebp),%edx
  800caf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb2:	29 c2                	sub    %eax,%edx
  800cb4:	89 d0                	mov    %edx,%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cbb:	eb 06                	jmp    800cc3 <strcmp+0xb>
		p++, q++;
  800cbd:	ff 45 08             	incl   0x8(%ebp)
  800cc0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	84 c0                	test   %al,%al
  800cca:	74 0e                	je     800cda <strcmp+0x22>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 10                	mov    (%eax),%dl
  800cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	38 c2                	cmp    %al,%dl
  800cd8:	74 e3                	je     800cbd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	0f b6 d0             	movzbl %al,%edx
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	0f b6 c0             	movzbl %al,%eax
  800cea:	29 c2                	sub    %eax,%edx
  800cec:	89 d0                	mov    %edx,%eax
}
  800cee:	5d                   	pop    %ebp
  800cef:	c3                   	ret    

00800cf0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cf0:	55                   	push   %ebp
  800cf1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf3:	eb 09                	jmp    800cfe <strncmp+0xe>
		n--, p++, q++;
  800cf5:	ff 4d 10             	decl   0x10(%ebp)
  800cf8:	ff 45 08             	incl   0x8(%ebp)
  800cfb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cfe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d02:	74 17                	je     800d1b <strncmp+0x2b>
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	84 c0                	test   %al,%al
  800d0b:	74 0e                	je     800d1b <strncmp+0x2b>
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8a 10                	mov    (%eax),%dl
  800d12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	38 c2                	cmp    %al,%dl
  800d19:	74 da                	je     800cf5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1f:	75 07                	jne    800d28 <strncmp+0x38>
		return 0;
  800d21:	b8 00 00 00 00       	mov    $0x0,%eax
  800d26:	eb 14                	jmp    800d3c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	0f b6 d0             	movzbl %al,%edx
  800d30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d33:	8a 00                	mov    (%eax),%al
  800d35:	0f b6 c0             	movzbl %al,%eax
  800d38:	29 c2                	sub    %eax,%edx
  800d3a:	89 d0                	mov    %edx,%eax
}
  800d3c:	5d                   	pop    %ebp
  800d3d:	c3                   	ret    

00800d3e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	83 ec 04             	sub    $0x4,%esp
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4a:	eb 12                	jmp    800d5e <strchr+0x20>
		if (*s == c)
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d54:	75 05                	jne    800d5b <strchr+0x1d>
			return (char *) s;
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	eb 11                	jmp    800d6c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d5b:	ff 45 08             	incl   0x8(%ebp)
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	84 c0                	test   %al,%al
  800d65:	75 e5                	jne    800d4c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6c:	c9                   	leave  
  800d6d:	c3                   	ret    

00800d6e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d6e:	55                   	push   %ebp
  800d6f:	89 e5                	mov    %esp,%ebp
  800d71:	83 ec 04             	sub    $0x4,%esp
  800d74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d77:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d7a:	eb 0d                	jmp    800d89 <strfind+0x1b>
		if (*s == c)
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d84:	74 0e                	je     800d94 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d86:	ff 45 08             	incl   0x8(%ebp)
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	84 c0                	test   %al,%al
  800d90:	75 ea                	jne    800d7c <strfind+0xe>
  800d92:	eb 01                	jmp    800d95 <strfind+0x27>
		if (*s == c)
			break;
  800d94:	90                   	nop
	return (char *) s;
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d98:	c9                   	leave  
  800d99:	c3                   	ret    

00800d9a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d9a:	55                   	push   %ebp
  800d9b:	89 e5                	mov    %esp,%ebp
  800d9d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da6:	8b 45 10             	mov    0x10(%ebp),%eax
  800da9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dac:	eb 0e                	jmp    800dbc <memset+0x22>
		*p++ = c;
  800dae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db1:	8d 50 01             	lea    0x1(%eax),%edx
  800db4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800db7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dba:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dbc:	ff 4d f8             	decl   -0x8(%ebp)
  800dbf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc3:	79 e9                	jns    800dae <memset+0x14>
		*p++ = c;

	return v;
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc8:	c9                   	leave  
  800dc9:	c3                   	ret    

00800dca <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dca:	55                   	push   %ebp
  800dcb:	89 e5                	mov    %esp,%ebp
  800dcd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ddc:	eb 16                	jmp    800df4 <memcpy+0x2a>
		*d++ = *s++;
  800dde:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de1:	8d 50 01             	lea    0x1(%eax),%edx
  800de4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dea:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ded:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df0:	8a 12                	mov    (%edx),%dl
  800df2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df4:	8b 45 10             	mov    0x10(%ebp),%eax
  800df7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfa:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfd:	85 c0                	test   %eax,%eax
  800dff:	75 dd                	jne    800dde <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e04:	c9                   	leave  
  800e05:	c3                   	ret    

00800e06 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e06:	55                   	push   %ebp
  800e07:	89 e5                	mov    %esp,%ebp
  800e09:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e1e:	73 50                	jae    800e70 <memmove+0x6a>
  800e20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e23:	8b 45 10             	mov    0x10(%ebp),%eax
  800e26:	01 d0                	add    %edx,%eax
  800e28:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2b:	76 43                	jbe    800e70 <memmove+0x6a>
		s += n;
  800e2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e30:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e33:	8b 45 10             	mov    0x10(%ebp),%eax
  800e36:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e39:	eb 10                	jmp    800e4b <memmove+0x45>
			*--d = *--s;
  800e3b:	ff 4d f8             	decl   -0x8(%ebp)
  800e3e:	ff 4d fc             	decl   -0x4(%ebp)
  800e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e44:	8a 10                	mov    (%eax),%dl
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e51:	89 55 10             	mov    %edx,0x10(%ebp)
  800e54:	85 c0                	test   %eax,%eax
  800e56:	75 e3                	jne    800e3b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e58:	eb 23                	jmp    800e7d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5d:	8d 50 01             	lea    0x1(%eax),%edx
  800e60:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e63:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e66:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e69:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6c:	8a 12                	mov    (%edx),%dl
  800e6e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e70:	8b 45 10             	mov    0x10(%ebp),%eax
  800e73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e76:	89 55 10             	mov    %edx,0x10(%ebp)
  800e79:	85 c0                	test   %eax,%eax
  800e7b:	75 dd                	jne    800e5a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e80:	c9                   	leave  
  800e81:	c3                   	ret    

00800e82 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e82:	55                   	push   %ebp
  800e83:	89 e5                	mov    %esp,%ebp
  800e85:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e91:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e94:	eb 2a                	jmp    800ec0 <memcmp+0x3e>
		if (*s1 != *s2)
  800e96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e99:	8a 10                	mov    (%eax),%dl
  800e9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	38 c2                	cmp    %al,%dl
  800ea2:	74 16                	je     800eba <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	0f b6 d0             	movzbl %al,%edx
  800eac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	0f b6 c0             	movzbl %al,%eax
  800eb4:	29 c2                	sub    %eax,%edx
  800eb6:	89 d0                	mov    %edx,%eax
  800eb8:	eb 18                	jmp    800ed2 <memcmp+0x50>
		s1++, s2++;
  800eba:	ff 45 fc             	incl   -0x4(%ebp)
  800ebd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ec0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec9:	85 c0                	test   %eax,%eax
  800ecb:	75 c9                	jne    800e96 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ecd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed2:	c9                   	leave  
  800ed3:	c3                   	ret    

00800ed4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed4:	55                   	push   %ebp
  800ed5:	89 e5                	mov    %esp,%ebp
  800ed7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eda:	8b 55 08             	mov    0x8(%ebp),%edx
  800edd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee0:	01 d0                	add    %edx,%eax
  800ee2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee5:	eb 15                	jmp    800efc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	0f b6 d0             	movzbl %al,%edx
  800eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef2:	0f b6 c0             	movzbl %al,%eax
  800ef5:	39 c2                	cmp    %eax,%edx
  800ef7:	74 0d                	je     800f06 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ef9:	ff 45 08             	incl   0x8(%ebp)
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f02:	72 e3                	jb     800ee7 <memfind+0x13>
  800f04:	eb 01                	jmp    800f07 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f06:	90                   	nop
	return (void *) s;
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0a:	c9                   	leave  
  800f0b:	c3                   	ret    

00800f0c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0c:	55                   	push   %ebp
  800f0d:	89 e5                	mov    %esp,%ebp
  800f0f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f19:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f20:	eb 03                	jmp    800f25 <strtol+0x19>
		s++;
  800f22:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3c 20                	cmp    $0x20,%al
  800f2c:	74 f4                	je     800f22 <strtol+0x16>
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	3c 09                	cmp    $0x9,%al
  800f35:	74 eb                	je     800f22 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	3c 2b                	cmp    $0x2b,%al
  800f3e:	75 05                	jne    800f45 <strtol+0x39>
		s++;
  800f40:	ff 45 08             	incl   0x8(%ebp)
  800f43:	eb 13                	jmp    800f58 <strtol+0x4c>
	else if (*s == '-')
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	3c 2d                	cmp    $0x2d,%al
  800f4c:	75 0a                	jne    800f58 <strtol+0x4c>
		s++, neg = 1;
  800f4e:	ff 45 08             	incl   0x8(%ebp)
  800f51:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f58:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5c:	74 06                	je     800f64 <strtol+0x58>
  800f5e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f62:	75 20                	jne    800f84 <strtol+0x78>
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	3c 30                	cmp    $0x30,%al
  800f6b:	75 17                	jne    800f84 <strtol+0x78>
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	40                   	inc    %eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	3c 78                	cmp    $0x78,%al
  800f75:	75 0d                	jne    800f84 <strtol+0x78>
		s += 2, base = 16;
  800f77:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f82:	eb 28                	jmp    800fac <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f88:	75 15                	jne    800f9f <strtol+0x93>
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 30                	cmp    $0x30,%al
  800f91:	75 0c                	jne    800f9f <strtol+0x93>
		s++, base = 8;
  800f93:	ff 45 08             	incl   0x8(%ebp)
  800f96:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f9d:	eb 0d                	jmp    800fac <strtol+0xa0>
	else if (base == 0)
  800f9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa3:	75 07                	jne    800fac <strtol+0xa0>
		base = 10;
  800fa5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 2f                	cmp    $0x2f,%al
  800fb3:	7e 19                	jle    800fce <strtol+0xc2>
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 39                	cmp    $0x39,%al
  800fbc:	7f 10                	jg     800fce <strtol+0xc2>
			dig = *s - '0';
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	0f be c0             	movsbl %al,%eax
  800fc6:	83 e8 30             	sub    $0x30,%eax
  800fc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcc:	eb 42                	jmp    801010 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	3c 60                	cmp    $0x60,%al
  800fd5:	7e 19                	jle    800ff0 <strtol+0xe4>
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 7a                	cmp    $0x7a,%al
  800fde:	7f 10                	jg     800ff0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f be c0             	movsbl %al,%eax
  800fe8:	83 e8 57             	sub    $0x57,%eax
  800feb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fee:	eb 20                	jmp    801010 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	3c 40                	cmp    $0x40,%al
  800ff7:	7e 39                	jle    801032 <strtol+0x126>
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 5a                	cmp    $0x5a,%al
  801000:	7f 30                	jg     801032 <strtol+0x126>
			dig = *s - 'A' + 10;
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	0f be c0             	movsbl %al,%eax
  80100a:	83 e8 37             	sub    $0x37,%eax
  80100d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801010:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801013:	3b 45 10             	cmp    0x10(%ebp),%eax
  801016:	7d 19                	jge    801031 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801018:	ff 45 08             	incl   0x8(%ebp)
  80101b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801022:	89 c2                	mov    %eax,%edx
  801024:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801027:	01 d0                	add    %edx,%eax
  801029:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102c:	e9 7b ff ff ff       	jmp    800fac <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801031:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801032:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801036:	74 08                	je     801040 <strtol+0x134>
		*endptr = (char *) s;
  801038:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103b:	8b 55 08             	mov    0x8(%ebp),%edx
  80103e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801040:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801044:	74 07                	je     80104d <strtol+0x141>
  801046:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801049:	f7 d8                	neg    %eax
  80104b:	eb 03                	jmp    801050 <strtol+0x144>
  80104d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801050:	c9                   	leave  
  801051:	c3                   	ret    

00801052 <ltostr>:

void
ltostr(long value, char *str)
{
  801052:	55                   	push   %ebp
  801053:	89 e5                	mov    %esp,%ebp
  801055:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801058:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80105f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801066:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106a:	79 13                	jns    80107f <ltostr+0x2d>
	{
		neg = 1;
  80106c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801073:	8b 45 0c             	mov    0xc(%ebp),%eax
  801076:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801079:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801087:	99                   	cltd   
  801088:	f7 f9                	idiv   %ecx
  80108a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80108d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801090:	8d 50 01             	lea    0x1(%eax),%edx
  801093:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801096:	89 c2                	mov    %eax,%edx
  801098:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109b:	01 d0                	add    %edx,%eax
  80109d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a0:	83 c2 30             	add    $0x30,%edx
  8010a3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010ad:	f7 e9                	imul   %ecx
  8010af:	c1 fa 02             	sar    $0x2,%edx
  8010b2:	89 c8                	mov    %ecx,%eax
  8010b4:	c1 f8 1f             	sar    $0x1f,%eax
  8010b7:	29 c2                	sub    %eax,%edx
  8010b9:	89 d0                	mov    %edx,%eax
  8010bb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010be:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c6:	f7 e9                	imul   %ecx
  8010c8:	c1 fa 02             	sar    $0x2,%edx
  8010cb:	89 c8                	mov    %ecx,%eax
  8010cd:	c1 f8 1f             	sar    $0x1f,%eax
  8010d0:	29 c2                	sub    %eax,%edx
  8010d2:	89 d0                	mov    %edx,%eax
  8010d4:	c1 e0 02             	shl    $0x2,%eax
  8010d7:	01 d0                	add    %edx,%eax
  8010d9:	01 c0                	add    %eax,%eax
  8010db:	29 c1                	sub    %eax,%ecx
  8010dd:	89 ca                	mov    %ecx,%edx
  8010df:	85 d2                	test   %edx,%edx
  8010e1:	75 9c                	jne    80107f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ed:	48                   	dec    %eax
  8010ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f5:	74 3d                	je     801134 <ltostr+0xe2>
		start = 1 ;
  8010f7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010fe:	eb 34                	jmp    801134 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801100:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	01 d0                	add    %edx,%eax
  801108:	8a 00                	mov    (%eax),%al
  80110a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80110d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801110:	8b 45 0c             	mov    0xc(%ebp),%eax
  801113:	01 c2                	add    %eax,%edx
  801115:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801118:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111b:	01 c8                	add    %ecx,%eax
  80111d:	8a 00                	mov    (%eax),%al
  80111f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801121:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801124:	8b 45 0c             	mov    0xc(%ebp),%eax
  801127:	01 c2                	add    %eax,%edx
  801129:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112c:	88 02                	mov    %al,(%edx)
		start++ ;
  80112e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801131:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801134:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801137:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80113a:	7c c4                	jl     801100 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80113f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801142:	01 d0                	add    %edx,%eax
  801144:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801147:	90                   	nop
  801148:	c9                   	leave  
  801149:	c3                   	ret    

0080114a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80114a:	55                   	push   %ebp
  80114b:	89 e5                	mov    %esp,%ebp
  80114d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801150:	ff 75 08             	pushl  0x8(%ebp)
  801153:	e8 54 fa ff ff       	call   800bac <strlen>
  801158:	83 c4 04             	add    $0x4,%esp
  80115b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80115e:	ff 75 0c             	pushl  0xc(%ebp)
  801161:	e8 46 fa ff ff       	call   800bac <strlen>
  801166:	83 c4 04             	add    $0x4,%esp
  801169:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801173:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117a:	eb 17                	jmp    801193 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80117f:	8b 45 10             	mov    0x10(%ebp),%eax
  801182:	01 c2                	add    %eax,%edx
  801184:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801187:	8b 45 08             	mov    0x8(%ebp),%eax
  80118a:	01 c8                	add    %ecx,%eax
  80118c:	8a 00                	mov    (%eax),%al
  80118e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801190:	ff 45 fc             	incl   -0x4(%ebp)
  801193:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801196:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801199:	7c e1                	jl     80117c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80119b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011a9:	eb 1f                	jmp    8011ca <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ae:	8d 50 01             	lea    0x1(%eax),%edx
  8011b1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b4:	89 c2                	mov    %eax,%edx
  8011b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b9:	01 c2                	add    %eax,%edx
  8011bb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c1:	01 c8                	add    %ecx,%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011c7:	ff 45 f8             	incl   -0x8(%ebp)
  8011ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d0:	7c d9                	jl     8011ab <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d8:	01 d0                	add    %edx,%eax
  8011da:	c6 00 00             	movb   $0x0,(%eax)
}
  8011dd:	90                   	nop
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ef:	8b 00                	mov    (%eax),%eax
  8011f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fb:	01 d0                	add    %edx,%eax
  8011fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801203:	eb 0c                	jmp    801211 <strsplit+0x31>
			*string++ = 0;
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8d 50 01             	lea    0x1(%eax),%edx
  80120b:	89 55 08             	mov    %edx,0x8(%ebp)
  80120e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	84 c0                	test   %al,%al
  801218:	74 18                	je     801232 <strsplit+0x52>
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	0f be c0             	movsbl %al,%eax
  801222:	50                   	push   %eax
  801223:	ff 75 0c             	pushl  0xc(%ebp)
  801226:	e8 13 fb ff ff       	call   800d3e <strchr>
  80122b:	83 c4 08             	add    $0x8,%esp
  80122e:	85 c0                	test   %eax,%eax
  801230:	75 d3                	jne    801205 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	84 c0                	test   %al,%al
  801239:	74 5a                	je     801295 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80123b:	8b 45 14             	mov    0x14(%ebp),%eax
  80123e:	8b 00                	mov    (%eax),%eax
  801240:	83 f8 0f             	cmp    $0xf,%eax
  801243:	75 07                	jne    80124c <strsplit+0x6c>
		{
			return 0;
  801245:	b8 00 00 00 00       	mov    $0x0,%eax
  80124a:	eb 66                	jmp    8012b2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124c:	8b 45 14             	mov    0x14(%ebp),%eax
  80124f:	8b 00                	mov    (%eax),%eax
  801251:	8d 48 01             	lea    0x1(%eax),%ecx
  801254:	8b 55 14             	mov    0x14(%ebp),%edx
  801257:	89 0a                	mov    %ecx,(%edx)
  801259:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801260:	8b 45 10             	mov    0x10(%ebp),%eax
  801263:	01 c2                	add    %eax,%edx
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126a:	eb 03                	jmp    80126f <strsplit+0x8f>
			string++;
  80126c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8a 00                	mov    (%eax),%al
  801274:	84 c0                	test   %al,%al
  801276:	74 8b                	je     801203 <strsplit+0x23>
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8a 00                	mov    (%eax),%al
  80127d:	0f be c0             	movsbl %al,%eax
  801280:	50                   	push   %eax
  801281:	ff 75 0c             	pushl  0xc(%ebp)
  801284:	e8 b5 fa ff ff       	call   800d3e <strchr>
  801289:	83 c4 08             	add    $0x8,%esp
  80128c:	85 c0                	test   %eax,%eax
  80128e:	74 dc                	je     80126c <strsplit+0x8c>
			string++;
	}
  801290:	e9 6e ff ff ff       	jmp    801203 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801295:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801296:	8b 45 14             	mov    0x14(%ebp),%eax
  801299:	8b 00                	mov    (%eax),%eax
  80129b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a5:	01 d0                	add    %edx,%eax
  8012a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012ad:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b2:	c9                   	leave  
  8012b3:	c3                   	ret    

008012b4 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
  8012b7:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8012ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bd:	c1 e8 0c             	shr    $0xc,%eax
  8012c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	25 ff 0f 00 00       	and    $0xfff,%eax
  8012cb:	85 c0                	test   %eax,%eax
  8012cd:	74 03                	je     8012d2 <malloc+0x1e>
			num++;
  8012cf:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8012d2:	a1 04 30 80 00       	mov    0x803004,%eax
  8012d7:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8012dc:	75 73                	jne    801351 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8012de:	83 ec 08             	sub    $0x8,%esp
  8012e1:	ff 75 08             	pushl  0x8(%ebp)
  8012e4:	68 00 00 00 80       	push   $0x80000000
  8012e9:	e8 13 05 00 00       	call   801801 <sys_allocateMem>
  8012ee:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8012f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8012f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8012f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012fc:	c1 e0 0c             	shl    $0xc,%eax
  8012ff:	89 c2                	mov    %eax,%edx
  801301:	a1 04 30 80 00       	mov    0x803004,%eax
  801306:	01 d0                	add    %edx,%eax
  801308:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  80130d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801312:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801315:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80131c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801321:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801327:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80132e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801333:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80133a:	01 00 00 00 
			sizeofarray++;
  80133e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801343:	40                   	inc    %eax
  801344:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801349:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80134c:	e9 71 01 00 00       	jmp    8014c2 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801351:	a1 28 30 80 00       	mov    0x803028,%eax
  801356:	85 c0                	test   %eax,%eax
  801358:	75 71                	jne    8013cb <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  80135a:	a1 04 30 80 00       	mov    0x803004,%eax
  80135f:	83 ec 08             	sub    $0x8,%esp
  801362:	ff 75 08             	pushl  0x8(%ebp)
  801365:	50                   	push   %eax
  801366:	e8 96 04 00 00       	call   801801 <sys_allocateMem>
  80136b:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  80136e:	a1 04 30 80 00       	mov    0x803004,%eax
  801373:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801376:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801379:	c1 e0 0c             	shl    $0xc,%eax
  80137c:	89 c2                	mov    %eax,%edx
  80137e:	a1 04 30 80 00       	mov    0x803004,%eax
  801383:	01 d0                	add    %edx,%eax
  801385:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  80138a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80138f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801392:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801399:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80139e:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8013a1:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8013a8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013ad:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8013b4:	01 00 00 00 
				sizeofarray++;
  8013b8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013bd:	40                   	inc    %eax
  8013be:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8013c3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8013c6:	e9 f7 00 00 00       	jmp    8014c2 <malloc+0x20e>
			}
			else{
				int count=0;
  8013cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8013d2:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8013d9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8013e0:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8013e7:	eb 7c                	jmp    801465 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8013e9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8013f0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8013f7:	eb 1a                	jmp    801413 <malloc+0x15f>
					{
						if(addresses[j]==i)
  8013f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013fc:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801403:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801406:	75 08                	jne    801410 <malloc+0x15c>
						{
							index=j;
  801408:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80140b:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80140e:	eb 0d                	jmp    80141d <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801410:	ff 45 dc             	incl   -0x24(%ebp)
  801413:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801418:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80141b:	7c dc                	jl     8013f9 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80141d:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801421:	75 05                	jne    801428 <malloc+0x174>
					{
						count++;
  801423:	ff 45 f0             	incl   -0x10(%ebp)
  801426:	eb 36                	jmp    80145e <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801428:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80142b:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801432:	85 c0                	test   %eax,%eax
  801434:	75 05                	jne    80143b <malloc+0x187>
						{
							count++;
  801436:	ff 45 f0             	incl   -0x10(%ebp)
  801439:	eb 23                	jmp    80145e <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  80143b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80143e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801441:	7d 14                	jge    801457 <malloc+0x1a3>
  801443:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801446:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801449:	7c 0c                	jl     801457 <malloc+0x1a3>
							{
								min=count;
  80144b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80144e:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801451:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801454:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801457:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80145e:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801465:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80146c:	0f 86 77 ff ff ff    	jbe    8013e9 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801472:	83 ec 08             	sub    $0x8,%esp
  801475:	ff 75 08             	pushl  0x8(%ebp)
  801478:	ff 75 e4             	pushl  -0x1c(%ebp)
  80147b:	e8 81 03 00 00       	call   801801 <sys_allocateMem>
  801480:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801483:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801488:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80148b:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801492:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801497:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80149d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8014a4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014a9:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8014b0:	01 00 00 00 
				sizeofarray++;
  8014b4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014b9:	40                   	inc    %eax
  8014ba:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  8014bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
  8014c7:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  8014d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8014d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8014de:	eb 30                	jmp    801510 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8014e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014e3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8014ea:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8014ed:	75 1e                	jne    80150d <free+0x49>
  8014ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014f2:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8014f9:	83 f8 01             	cmp    $0x1,%eax
  8014fc:	75 0f                	jne    80150d <free+0x49>
    		is_found=1;
  8014fe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801505:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801508:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  80150b:	eb 0d                	jmp    80151a <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  80150d:	ff 45 ec             	incl   -0x14(%ebp)
  801510:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801515:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801518:	7c c6                	jl     8014e0 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  80151a:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  80151e:	75 3a                	jne    80155a <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  801520:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801523:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  80152a:	c1 e0 0c             	shl    $0xc,%eax
  80152d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801530:	83 ec 08             	sub    $0x8,%esp
  801533:	ff 75 e4             	pushl  -0x1c(%ebp)
  801536:	ff 75 e8             	pushl  -0x18(%ebp)
  801539:	e8 a7 02 00 00       	call   8017e5 <sys_freeMem>
  80153e:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801541:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801544:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  80154b:	00 00 00 00 
    	changes++;
  80154f:	a1 28 30 80 00       	mov    0x803028,%eax
  801554:	40                   	inc    %eax
  801555:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  80155a:	90                   	nop
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
  801560:	83 ec 18             	sub    $0x18,%esp
  801563:	8b 45 10             	mov    0x10(%ebp),%eax
  801566:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801569:	83 ec 04             	sub    $0x4,%esp
  80156c:	68 50 26 80 00       	push   $0x802650
  801571:	68 9f 00 00 00       	push   $0x9f
  801576:	68 73 26 80 00       	push   $0x802673
  80157b:	e8 08 ed ff ff       	call   800288 <_panic>

00801580 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
  801583:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801586:	83 ec 04             	sub    $0x4,%esp
  801589:	68 50 26 80 00       	push   $0x802650
  80158e:	68 a5 00 00 00       	push   $0xa5
  801593:	68 73 26 80 00       	push   $0x802673
  801598:	e8 eb ec ff ff       	call   800288 <_panic>

0080159d <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
  8015a0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015a3:	83 ec 04             	sub    $0x4,%esp
  8015a6:	68 50 26 80 00       	push   $0x802650
  8015ab:	68 ab 00 00 00       	push   $0xab
  8015b0:	68 73 26 80 00       	push   $0x802673
  8015b5:	e8 ce ec ff ff       	call   800288 <_panic>

008015ba <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
  8015bd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015c0:	83 ec 04             	sub    $0x4,%esp
  8015c3:	68 50 26 80 00       	push   $0x802650
  8015c8:	68 b0 00 00 00       	push   $0xb0
  8015cd:	68 73 26 80 00       	push   $0x802673
  8015d2:	e8 b1 ec ff ff       	call   800288 <_panic>

008015d7 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
  8015da:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015dd:	83 ec 04             	sub    $0x4,%esp
  8015e0:	68 50 26 80 00       	push   $0x802650
  8015e5:	68 b6 00 00 00       	push   $0xb6
  8015ea:	68 73 26 80 00       	push   $0x802673
  8015ef:	e8 94 ec ff ff       	call   800288 <_panic>

008015f4 <shrink>:
}
void shrink(uint32 newSize)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
  8015f7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015fa:	83 ec 04             	sub    $0x4,%esp
  8015fd:	68 50 26 80 00       	push   $0x802650
  801602:	68 ba 00 00 00       	push   $0xba
  801607:	68 73 26 80 00       	push   $0x802673
  80160c:	e8 77 ec ff ff       	call   800288 <_panic>

00801611 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
  801614:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801617:	83 ec 04             	sub    $0x4,%esp
  80161a:	68 50 26 80 00       	push   $0x802650
  80161f:	68 bf 00 00 00       	push   $0xbf
  801624:	68 73 26 80 00       	push   $0x802673
  801629:	e8 5a ec ff ff       	call   800288 <_panic>

0080162e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
  801631:	57                   	push   %edi
  801632:	56                   	push   %esi
  801633:	53                   	push   %ebx
  801634:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801640:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801643:	8b 7d 18             	mov    0x18(%ebp),%edi
  801646:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801649:	cd 30                	int    $0x30
  80164b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80164e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801651:	83 c4 10             	add    $0x10,%esp
  801654:	5b                   	pop    %ebx
  801655:	5e                   	pop    %esi
  801656:	5f                   	pop    %edi
  801657:	5d                   	pop    %ebp
  801658:	c3                   	ret    

00801659 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
  80165c:	83 ec 04             	sub    $0x4,%esp
  80165f:	8b 45 10             	mov    0x10(%ebp),%eax
  801662:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801665:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	52                   	push   %edx
  801671:	ff 75 0c             	pushl  0xc(%ebp)
  801674:	50                   	push   %eax
  801675:	6a 00                	push   $0x0
  801677:	e8 b2 ff ff ff       	call   80162e <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	90                   	nop
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <sys_cgetc>:

int
sys_cgetc(void)
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 01                	push   $0x1
  801691:	e8 98 ff ff ff       	call   80162e <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	50                   	push   %eax
  8016aa:	6a 05                	push   $0x5
  8016ac:	e8 7d ff ff ff       	call   80162e <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	c9                   	leave  
  8016b5:	c3                   	ret    

008016b6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8016b6:	55                   	push   %ebp
  8016b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 02                	push   $0x2
  8016c5:	e8 64 ff ff ff       	call   80162e <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 03                	push   $0x3
  8016de:	e8 4b ff ff ff       	call   80162e <syscall>
  8016e3:	83 c4 18             	add    $0x18,%esp
}
  8016e6:	c9                   	leave  
  8016e7:	c3                   	ret    

008016e8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016e8:	55                   	push   %ebp
  8016e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 04                	push   $0x4
  8016f7:	e8 32 ff ff ff       	call   80162e <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_env_exit>:


void sys_env_exit(void)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 06                	push   $0x6
  801710:	e8 19 ff ff ff       	call   80162e <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	90                   	nop
  801719:	c9                   	leave  
  80171a:	c3                   	ret    

0080171b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80171b:	55                   	push   %ebp
  80171c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80171e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	52                   	push   %edx
  80172b:	50                   	push   %eax
  80172c:	6a 07                	push   $0x7
  80172e:	e8 fb fe ff ff       	call   80162e <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
  80173b:	56                   	push   %esi
  80173c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80173d:	8b 75 18             	mov    0x18(%ebp),%esi
  801740:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801743:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801746:	8b 55 0c             	mov    0xc(%ebp),%edx
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	56                   	push   %esi
  80174d:	53                   	push   %ebx
  80174e:	51                   	push   %ecx
  80174f:	52                   	push   %edx
  801750:	50                   	push   %eax
  801751:	6a 08                	push   $0x8
  801753:	e8 d6 fe ff ff       	call   80162e <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80175e:	5b                   	pop    %ebx
  80175f:	5e                   	pop    %esi
  801760:	5d                   	pop    %ebp
  801761:	c3                   	ret    

00801762 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801765:	8b 55 0c             	mov    0xc(%ebp),%edx
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	52                   	push   %edx
  801772:	50                   	push   %eax
  801773:	6a 09                	push   $0x9
  801775:	e8 b4 fe ff ff       	call   80162e <syscall>
  80177a:	83 c4 18             	add    $0x18,%esp
}
  80177d:	c9                   	leave  
  80177e:	c3                   	ret    

0080177f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80177f:	55                   	push   %ebp
  801780:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	ff 75 0c             	pushl  0xc(%ebp)
  80178b:	ff 75 08             	pushl  0x8(%ebp)
  80178e:	6a 0a                	push   $0xa
  801790:	e8 99 fe ff ff       	call   80162e <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 0b                	push   $0xb
  8017a9:	e8 80 fe ff ff       	call   80162e <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
}
  8017b1:	c9                   	leave  
  8017b2:	c3                   	ret    

008017b3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017b3:	55                   	push   %ebp
  8017b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 0c                	push   $0xc
  8017c2:	e8 67 fe ff ff       	call   80162e <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
}
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 0d                	push   $0xd
  8017db:	e8 4e fe ff ff       	call   80162e <syscall>
  8017e0:	83 c4 18             	add    $0x18,%esp
}
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	ff 75 0c             	pushl  0xc(%ebp)
  8017f1:	ff 75 08             	pushl  0x8(%ebp)
  8017f4:	6a 11                	push   $0x11
  8017f6:	e8 33 fe ff ff       	call   80162e <syscall>
  8017fb:	83 c4 18             	add    $0x18,%esp
	return;
  8017fe:	90                   	nop
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	ff 75 0c             	pushl  0xc(%ebp)
  80180d:	ff 75 08             	pushl  0x8(%ebp)
  801810:	6a 12                	push   $0x12
  801812:	e8 17 fe ff ff       	call   80162e <syscall>
  801817:	83 c4 18             	add    $0x18,%esp
	return ;
  80181a:	90                   	nop
}
  80181b:	c9                   	leave  
  80181c:	c3                   	ret    

0080181d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 0e                	push   $0xe
  80182c:	e8 fd fd ff ff       	call   80162e <syscall>
  801831:	83 c4 18             	add    $0x18,%esp
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	ff 75 08             	pushl  0x8(%ebp)
  801844:	6a 0f                	push   $0xf
  801846:	e8 e3 fd ff ff       	call   80162e <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 10                	push   $0x10
  80185f:	e8 ca fd ff ff       	call   80162e <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	90                   	nop
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 14                	push   $0x14
  801879:	e8 b0 fd ff ff       	call   80162e <syscall>
  80187e:	83 c4 18             	add    $0x18,%esp
}
  801881:	90                   	nop
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 15                	push   $0x15
  801893:	e8 96 fd ff ff       	call   80162e <syscall>
  801898:	83 c4 18             	add    $0x18,%esp
}
  80189b:	90                   	nop
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <sys_cputc>:


void
sys_cputc(const char c)
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
  8018a1:	83 ec 04             	sub    $0x4,%esp
  8018a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8018aa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	50                   	push   %eax
  8018b7:	6a 16                	push   $0x16
  8018b9:	e8 70 fd ff ff       	call   80162e <syscall>
  8018be:	83 c4 18             	add    $0x18,%esp
}
  8018c1:	90                   	nop
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 17                	push   $0x17
  8018d3:	e8 56 fd ff ff       	call   80162e <syscall>
  8018d8:	83 c4 18             	add    $0x18,%esp
}
  8018db:	90                   	nop
  8018dc:	c9                   	leave  
  8018dd:	c3                   	ret    

008018de <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	ff 75 0c             	pushl  0xc(%ebp)
  8018ed:	50                   	push   %eax
  8018ee:	6a 18                	push   $0x18
  8018f0:	e8 39 fd ff ff       	call   80162e <syscall>
  8018f5:	83 c4 18             	add    $0x18,%esp
}
  8018f8:	c9                   	leave  
  8018f9:	c3                   	ret    

008018fa <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018fa:	55                   	push   %ebp
  8018fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	52                   	push   %edx
  80190a:	50                   	push   %eax
  80190b:	6a 1b                	push   $0x1b
  80190d:	e8 1c fd ff ff       	call   80162e <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
}
  801915:	c9                   	leave  
  801916:	c3                   	ret    

00801917 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801917:	55                   	push   %ebp
  801918:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80191a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	52                   	push   %edx
  801927:	50                   	push   %eax
  801928:	6a 19                	push   $0x19
  80192a:	e8 ff fc ff ff       	call   80162e <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
}
  801932:	90                   	nop
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801938:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193b:	8b 45 08             	mov    0x8(%ebp),%eax
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	52                   	push   %edx
  801945:	50                   	push   %eax
  801946:	6a 1a                	push   $0x1a
  801948:	e8 e1 fc ff ff       	call   80162e <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	90                   	nop
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
  801956:	83 ec 04             	sub    $0x4,%esp
  801959:	8b 45 10             	mov    0x10(%ebp),%eax
  80195c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80195f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801962:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	6a 00                	push   $0x0
  80196b:	51                   	push   %ecx
  80196c:	52                   	push   %edx
  80196d:	ff 75 0c             	pushl  0xc(%ebp)
  801970:	50                   	push   %eax
  801971:	6a 1c                	push   $0x1c
  801973:	e8 b6 fc ff ff       	call   80162e <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801980:	8b 55 0c             	mov    0xc(%ebp),%edx
  801983:	8b 45 08             	mov    0x8(%ebp),%eax
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	52                   	push   %edx
  80198d:	50                   	push   %eax
  80198e:	6a 1d                	push   $0x1d
  801990:	e8 99 fc ff ff       	call   80162e <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80199d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	51                   	push   %ecx
  8019ab:	52                   	push   %edx
  8019ac:	50                   	push   %eax
  8019ad:	6a 1e                	push   $0x1e
  8019af:	e8 7a fc ff ff       	call   80162e <syscall>
  8019b4:	83 c4 18             	add    $0x18,%esp
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8019bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	52                   	push   %edx
  8019c9:	50                   	push   %eax
  8019ca:	6a 1f                	push   $0x1f
  8019cc:	e8 5d fc ff ff       	call   80162e <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 20                	push   $0x20
  8019e5:	e8 44 fc ff ff       	call   80162e <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
}
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	6a 00                	push   $0x0
  8019f7:	ff 75 14             	pushl  0x14(%ebp)
  8019fa:	ff 75 10             	pushl  0x10(%ebp)
  8019fd:	ff 75 0c             	pushl  0xc(%ebp)
  801a00:	50                   	push   %eax
  801a01:	6a 21                	push   $0x21
  801a03:	e8 26 fc ff ff       	call   80162e <syscall>
  801a08:	83 c4 18             	add    $0x18,%esp
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a10:	8b 45 08             	mov    0x8(%ebp),%eax
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	50                   	push   %eax
  801a1c:	6a 22                	push   $0x22
  801a1e:	e8 0b fc ff ff       	call   80162e <syscall>
  801a23:	83 c4 18             	add    $0x18,%esp
}
  801a26:	90                   	nop
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	50                   	push   %eax
  801a38:	6a 23                	push   $0x23
  801a3a:	e8 ef fb ff ff       	call   80162e <syscall>
  801a3f:	83 c4 18             	add    $0x18,%esp
}
  801a42:	90                   	nop
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
  801a48:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a4b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a4e:	8d 50 04             	lea    0x4(%eax),%edx
  801a51:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	52                   	push   %edx
  801a5b:	50                   	push   %eax
  801a5c:	6a 24                	push   $0x24
  801a5e:	e8 cb fb ff ff       	call   80162e <syscall>
  801a63:	83 c4 18             	add    $0x18,%esp
	return result;
  801a66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a6f:	89 01                	mov    %eax,(%ecx)
  801a71:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	c9                   	leave  
  801a78:	c2 04 00             	ret    $0x4

00801a7b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	ff 75 10             	pushl  0x10(%ebp)
  801a85:	ff 75 0c             	pushl  0xc(%ebp)
  801a88:	ff 75 08             	pushl  0x8(%ebp)
  801a8b:	6a 13                	push   $0x13
  801a8d:	e8 9c fb ff ff       	call   80162e <syscall>
  801a92:	83 c4 18             	add    $0x18,%esp
	return ;
  801a95:	90                   	nop
}
  801a96:	c9                   	leave  
  801a97:	c3                   	ret    

00801a98 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a98:	55                   	push   %ebp
  801a99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 25                	push   $0x25
  801aa7:	e8 82 fb ff ff       	call   80162e <syscall>
  801aac:	83 c4 18             	add    $0x18,%esp
}
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
  801ab4:	83 ec 04             	sub    $0x4,%esp
  801ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801abd:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	50                   	push   %eax
  801aca:	6a 26                	push   $0x26
  801acc:	e8 5d fb ff ff       	call   80162e <syscall>
  801ad1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad4:	90                   	nop
}
  801ad5:	c9                   	leave  
  801ad6:	c3                   	ret    

00801ad7 <rsttst>:
void rsttst()
{
  801ad7:	55                   	push   %ebp
  801ad8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 28                	push   $0x28
  801ae6:	e8 43 fb ff ff       	call   80162e <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
	return ;
  801aee:	90                   	nop
}
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
  801af4:	83 ec 04             	sub    $0x4,%esp
  801af7:	8b 45 14             	mov    0x14(%ebp),%eax
  801afa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801afd:	8b 55 18             	mov    0x18(%ebp),%edx
  801b00:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b04:	52                   	push   %edx
  801b05:	50                   	push   %eax
  801b06:	ff 75 10             	pushl  0x10(%ebp)
  801b09:	ff 75 0c             	pushl  0xc(%ebp)
  801b0c:	ff 75 08             	pushl  0x8(%ebp)
  801b0f:	6a 27                	push   $0x27
  801b11:	e8 18 fb ff ff       	call   80162e <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
	return ;
  801b19:	90                   	nop
}
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <chktst>:
void chktst(uint32 n)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	ff 75 08             	pushl  0x8(%ebp)
  801b2a:	6a 29                	push   $0x29
  801b2c:	e8 fd fa ff ff       	call   80162e <syscall>
  801b31:	83 c4 18             	add    $0x18,%esp
	return ;
  801b34:	90                   	nop
}
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <inctst>:

void inctst()
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 2a                	push   $0x2a
  801b46:	e8 e3 fa ff ff       	call   80162e <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b4e:	90                   	nop
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <gettst>:
uint32 gettst()
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 2b                	push   $0x2b
  801b60:	e8 c9 fa ff ff       	call   80162e <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
}
  801b68:	c9                   	leave  
  801b69:	c3                   	ret    

00801b6a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
  801b6d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 2c                	push   $0x2c
  801b7c:	e8 ad fa ff ff       	call   80162e <syscall>
  801b81:	83 c4 18             	add    $0x18,%esp
  801b84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b87:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b8b:	75 07                	jne    801b94 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b92:	eb 05                	jmp    801b99 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b99:	c9                   	leave  
  801b9a:	c3                   	ret    

00801b9b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b9b:	55                   	push   %ebp
  801b9c:	89 e5                	mov    %esp,%ebp
  801b9e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 2c                	push   $0x2c
  801bad:	e8 7c fa ff ff       	call   80162e <syscall>
  801bb2:	83 c4 18             	add    $0x18,%esp
  801bb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801bb8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801bbc:	75 07                	jne    801bc5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801bbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc3:	eb 05                	jmp    801bca <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801bc5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
  801bcf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 2c                	push   $0x2c
  801bde:	e8 4b fa ff ff       	call   80162e <syscall>
  801be3:	83 c4 18             	add    $0x18,%esp
  801be6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801be9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bed:	75 07                	jne    801bf6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bef:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf4:	eb 05                	jmp    801bfb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bf6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bfb:	c9                   	leave  
  801bfc:	c3                   	ret    

00801bfd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bfd:	55                   	push   %ebp
  801bfe:	89 e5                	mov    %esp,%ebp
  801c00:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 2c                	push   $0x2c
  801c0f:	e8 1a fa ff ff       	call   80162e <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
  801c17:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c1a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c1e:	75 07                	jne    801c27 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c20:	b8 01 00 00 00       	mov    $0x1,%eax
  801c25:	eb 05                	jmp    801c2c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c27:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	ff 75 08             	pushl  0x8(%ebp)
  801c3c:	6a 2d                	push   $0x2d
  801c3e:	e8 eb f9 ff ff       	call   80162e <syscall>
  801c43:	83 c4 18             	add    $0x18,%esp
	return ;
  801c46:	90                   	nop
}
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
  801c4c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801c4d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c50:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c56:	8b 45 08             	mov    0x8(%ebp),%eax
  801c59:	6a 00                	push   $0x0
  801c5b:	53                   	push   %ebx
  801c5c:	51                   	push   %ecx
  801c5d:	52                   	push   %edx
  801c5e:	50                   	push   %eax
  801c5f:	6a 2e                	push   $0x2e
  801c61:	e8 c8 f9 ff ff       	call   80162e <syscall>
  801c66:	83 c4 18             	add    $0x18,%esp
}
  801c69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c6c:	c9                   	leave  
  801c6d:	c3                   	ret    

00801c6e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c6e:	55                   	push   %ebp
  801c6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c74:	8b 45 08             	mov    0x8(%ebp),%eax
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	52                   	push   %edx
  801c7e:	50                   	push   %eax
  801c7f:	6a 2f                	push   $0x2f
  801c81:	e8 a8 f9 ff ff       	call   80162e <syscall>
  801c86:	83 c4 18             	add    $0x18,%esp
}
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    
  801c8b:	90                   	nop

00801c8c <__udivdi3>:
  801c8c:	55                   	push   %ebp
  801c8d:	57                   	push   %edi
  801c8e:	56                   	push   %esi
  801c8f:	53                   	push   %ebx
  801c90:	83 ec 1c             	sub    $0x1c,%esp
  801c93:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c97:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c9b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c9f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ca3:	89 ca                	mov    %ecx,%edx
  801ca5:	89 f8                	mov    %edi,%eax
  801ca7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cab:	85 f6                	test   %esi,%esi
  801cad:	75 2d                	jne    801cdc <__udivdi3+0x50>
  801caf:	39 cf                	cmp    %ecx,%edi
  801cb1:	77 65                	ja     801d18 <__udivdi3+0x8c>
  801cb3:	89 fd                	mov    %edi,%ebp
  801cb5:	85 ff                	test   %edi,%edi
  801cb7:	75 0b                	jne    801cc4 <__udivdi3+0x38>
  801cb9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cbe:	31 d2                	xor    %edx,%edx
  801cc0:	f7 f7                	div    %edi
  801cc2:	89 c5                	mov    %eax,%ebp
  801cc4:	31 d2                	xor    %edx,%edx
  801cc6:	89 c8                	mov    %ecx,%eax
  801cc8:	f7 f5                	div    %ebp
  801cca:	89 c1                	mov    %eax,%ecx
  801ccc:	89 d8                	mov    %ebx,%eax
  801cce:	f7 f5                	div    %ebp
  801cd0:	89 cf                	mov    %ecx,%edi
  801cd2:	89 fa                	mov    %edi,%edx
  801cd4:	83 c4 1c             	add    $0x1c,%esp
  801cd7:	5b                   	pop    %ebx
  801cd8:	5e                   	pop    %esi
  801cd9:	5f                   	pop    %edi
  801cda:	5d                   	pop    %ebp
  801cdb:	c3                   	ret    
  801cdc:	39 ce                	cmp    %ecx,%esi
  801cde:	77 28                	ja     801d08 <__udivdi3+0x7c>
  801ce0:	0f bd fe             	bsr    %esi,%edi
  801ce3:	83 f7 1f             	xor    $0x1f,%edi
  801ce6:	75 40                	jne    801d28 <__udivdi3+0x9c>
  801ce8:	39 ce                	cmp    %ecx,%esi
  801cea:	72 0a                	jb     801cf6 <__udivdi3+0x6a>
  801cec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801cf0:	0f 87 9e 00 00 00    	ja     801d94 <__udivdi3+0x108>
  801cf6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfb:	89 fa                	mov    %edi,%edx
  801cfd:	83 c4 1c             	add    $0x1c,%esp
  801d00:	5b                   	pop    %ebx
  801d01:	5e                   	pop    %esi
  801d02:	5f                   	pop    %edi
  801d03:	5d                   	pop    %ebp
  801d04:	c3                   	ret    
  801d05:	8d 76 00             	lea    0x0(%esi),%esi
  801d08:	31 ff                	xor    %edi,%edi
  801d0a:	31 c0                	xor    %eax,%eax
  801d0c:	89 fa                	mov    %edi,%edx
  801d0e:	83 c4 1c             	add    $0x1c,%esp
  801d11:	5b                   	pop    %ebx
  801d12:	5e                   	pop    %esi
  801d13:	5f                   	pop    %edi
  801d14:	5d                   	pop    %ebp
  801d15:	c3                   	ret    
  801d16:	66 90                	xchg   %ax,%ax
  801d18:	89 d8                	mov    %ebx,%eax
  801d1a:	f7 f7                	div    %edi
  801d1c:	31 ff                	xor    %edi,%edi
  801d1e:	89 fa                	mov    %edi,%edx
  801d20:	83 c4 1c             	add    $0x1c,%esp
  801d23:	5b                   	pop    %ebx
  801d24:	5e                   	pop    %esi
  801d25:	5f                   	pop    %edi
  801d26:	5d                   	pop    %ebp
  801d27:	c3                   	ret    
  801d28:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d2d:	89 eb                	mov    %ebp,%ebx
  801d2f:	29 fb                	sub    %edi,%ebx
  801d31:	89 f9                	mov    %edi,%ecx
  801d33:	d3 e6                	shl    %cl,%esi
  801d35:	89 c5                	mov    %eax,%ebp
  801d37:	88 d9                	mov    %bl,%cl
  801d39:	d3 ed                	shr    %cl,%ebp
  801d3b:	89 e9                	mov    %ebp,%ecx
  801d3d:	09 f1                	or     %esi,%ecx
  801d3f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d43:	89 f9                	mov    %edi,%ecx
  801d45:	d3 e0                	shl    %cl,%eax
  801d47:	89 c5                	mov    %eax,%ebp
  801d49:	89 d6                	mov    %edx,%esi
  801d4b:	88 d9                	mov    %bl,%cl
  801d4d:	d3 ee                	shr    %cl,%esi
  801d4f:	89 f9                	mov    %edi,%ecx
  801d51:	d3 e2                	shl    %cl,%edx
  801d53:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d57:	88 d9                	mov    %bl,%cl
  801d59:	d3 e8                	shr    %cl,%eax
  801d5b:	09 c2                	or     %eax,%edx
  801d5d:	89 d0                	mov    %edx,%eax
  801d5f:	89 f2                	mov    %esi,%edx
  801d61:	f7 74 24 0c          	divl   0xc(%esp)
  801d65:	89 d6                	mov    %edx,%esi
  801d67:	89 c3                	mov    %eax,%ebx
  801d69:	f7 e5                	mul    %ebp
  801d6b:	39 d6                	cmp    %edx,%esi
  801d6d:	72 19                	jb     801d88 <__udivdi3+0xfc>
  801d6f:	74 0b                	je     801d7c <__udivdi3+0xf0>
  801d71:	89 d8                	mov    %ebx,%eax
  801d73:	31 ff                	xor    %edi,%edi
  801d75:	e9 58 ff ff ff       	jmp    801cd2 <__udivdi3+0x46>
  801d7a:	66 90                	xchg   %ax,%ax
  801d7c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d80:	89 f9                	mov    %edi,%ecx
  801d82:	d3 e2                	shl    %cl,%edx
  801d84:	39 c2                	cmp    %eax,%edx
  801d86:	73 e9                	jae    801d71 <__udivdi3+0xe5>
  801d88:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d8b:	31 ff                	xor    %edi,%edi
  801d8d:	e9 40 ff ff ff       	jmp    801cd2 <__udivdi3+0x46>
  801d92:	66 90                	xchg   %ax,%ax
  801d94:	31 c0                	xor    %eax,%eax
  801d96:	e9 37 ff ff ff       	jmp    801cd2 <__udivdi3+0x46>
  801d9b:	90                   	nop

00801d9c <__umoddi3>:
  801d9c:	55                   	push   %ebp
  801d9d:	57                   	push   %edi
  801d9e:	56                   	push   %esi
  801d9f:	53                   	push   %ebx
  801da0:	83 ec 1c             	sub    $0x1c,%esp
  801da3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801da7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801dab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801daf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801db3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801db7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dbb:	89 f3                	mov    %esi,%ebx
  801dbd:	89 fa                	mov    %edi,%edx
  801dbf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dc3:	89 34 24             	mov    %esi,(%esp)
  801dc6:	85 c0                	test   %eax,%eax
  801dc8:	75 1a                	jne    801de4 <__umoddi3+0x48>
  801dca:	39 f7                	cmp    %esi,%edi
  801dcc:	0f 86 a2 00 00 00    	jbe    801e74 <__umoddi3+0xd8>
  801dd2:	89 c8                	mov    %ecx,%eax
  801dd4:	89 f2                	mov    %esi,%edx
  801dd6:	f7 f7                	div    %edi
  801dd8:	89 d0                	mov    %edx,%eax
  801dda:	31 d2                	xor    %edx,%edx
  801ddc:	83 c4 1c             	add    $0x1c,%esp
  801ddf:	5b                   	pop    %ebx
  801de0:	5e                   	pop    %esi
  801de1:	5f                   	pop    %edi
  801de2:	5d                   	pop    %ebp
  801de3:	c3                   	ret    
  801de4:	39 f0                	cmp    %esi,%eax
  801de6:	0f 87 ac 00 00 00    	ja     801e98 <__umoddi3+0xfc>
  801dec:	0f bd e8             	bsr    %eax,%ebp
  801def:	83 f5 1f             	xor    $0x1f,%ebp
  801df2:	0f 84 ac 00 00 00    	je     801ea4 <__umoddi3+0x108>
  801df8:	bf 20 00 00 00       	mov    $0x20,%edi
  801dfd:	29 ef                	sub    %ebp,%edi
  801dff:	89 fe                	mov    %edi,%esi
  801e01:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e05:	89 e9                	mov    %ebp,%ecx
  801e07:	d3 e0                	shl    %cl,%eax
  801e09:	89 d7                	mov    %edx,%edi
  801e0b:	89 f1                	mov    %esi,%ecx
  801e0d:	d3 ef                	shr    %cl,%edi
  801e0f:	09 c7                	or     %eax,%edi
  801e11:	89 e9                	mov    %ebp,%ecx
  801e13:	d3 e2                	shl    %cl,%edx
  801e15:	89 14 24             	mov    %edx,(%esp)
  801e18:	89 d8                	mov    %ebx,%eax
  801e1a:	d3 e0                	shl    %cl,%eax
  801e1c:	89 c2                	mov    %eax,%edx
  801e1e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e22:	d3 e0                	shl    %cl,%eax
  801e24:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e28:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e2c:	89 f1                	mov    %esi,%ecx
  801e2e:	d3 e8                	shr    %cl,%eax
  801e30:	09 d0                	or     %edx,%eax
  801e32:	d3 eb                	shr    %cl,%ebx
  801e34:	89 da                	mov    %ebx,%edx
  801e36:	f7 f7                	div    %edi
  801e38:	89 d3                	mov    %edx,%ebx
  801e3a:	f7 24 24             	mull   (%esp)
  801e3d:	89 c6                	mov    %eax,%esi
  801e3f:	89 d1                	mov    %edx,%ecx
  801e41:	39 d3                	cmp    %edx,%ebx
  801e43:	0f 82 87 00 00 00    	jb     801ed0 <__umoddi3+0x134>
  801e49:	0f 84 91 00 00 00    	je     801ee0 <__umoddi3+0x144>
  801e4f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e53:	29 f2                	sub    %esi,%edx
  801e55:	19 cb                	sbb    %ecx,%ebx
  801e57:	89 d8                	mov    %ebx,%eax
  801e59:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e5d:	d3 e0                	shl    %cl,%eax
  801e5f:	89 e9                	mov    %ebp,%ecx
  801e61:	d3 ea                	shr    %cl,%edx
  801e63:	09 d0                	or     %edx,%eax
  801e65:	89 e9                	mov    %ebp,%ecx
  801e67:	d3 eb                	shr    %cl,%ebx
  801e69:	89 da                	mov    %ebx,%edx
  801e6b:	83 c4 1c             	add    $0x1c,%esp
  801e6e:	5b                   	pop    %ebx
  801e6f:	5e                   	pop    %esi
  801e70:	5f                   	pop    %edi
  801e71:	5d                   	pop    %ebp
  801e72:	c3                   	ret    
  801e73:	90                   	nop
  801e74:	89 fd                	mov    %edi,%ebp
  801e76:	85 ff                	test   %edi,%edi
  801e78:	75 0b                	jne    801e85 <__umoddi3+0xe9>
  801e7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e7f:	31 d2                	xor    %edx,%edx
  801e81:	f7 f7                	div    %edi
  801e83:	89 c5                	mov    %eax,%ebp
  801e85:	89 f0                	mov    %esi,%eax
  801e87:	31 d2                	xor    %edx,%edx
  801e89:	f7 f5                	div    %ebp
  801e8b:	89 c8                	mov    %ecx,%eax
  801e8d:	f7 f5                	div    %ebp
  801e8f:	89 d0                	mov    %edx,%eax
  801e91:	e9 44 ff ff ff       	jmp    801dda <__umoddi3+0x3e>
  801e96:	66 90                	xchg   %ax,%ax
  801e98:	89 c8                	mov    %ecx,%eax
  801e9a:	89 f2                	mov    %esi,%edx
  801e9c:	83 c4 1c             	add    $0x1c,%esp
  801e9f:	5b                   	pop    %ebx
  801ea0:	5e                   	pop    %esi
  801ea1:	5f                   	pop    %edi
  801ea2:	5d                   	pop    %ebp
  801ea3:	c3                   	ret    
  801ea4:	3b 04 24             	cmp    (%esp),%eax
  801ea7:	72 06                	jb     801eaf <__umoddi3+0x113>
  801ea9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ead:	77 0f                	ja     801ebe <__umoddi3+0x122>
  801eaf:	89 f2                	mov    %esi,%edx
  801eb1:	29 f9                	sub    %edi,%ecx
  801eb3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801eb7:	89 14 24             	mov    %edx,(%esp)
  801eba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ebe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ec2:	8b 14 24             	mov    (%esp),%edx
  801ec5:	83 c4 1c             	add    $0x1c,%esp
  801ec8:	5b                   	pop    %ebx
  801ec9:	5e                   	pop    %esi
  801eca:	5f                   	pop    %edi
  801ecb:	5d                   	pop    %ebp
  801ecc:	c3                   	ret    
  801ecd:	8d 76 00             	lea    0x0(%esi),%esi
  801ed0:	2b 04 24             	sub    (%esp),%eax
  801ed3:	19 fa                	sbb    %edi,%edx
  801ed5:	89 d1                	mov    %edx,%ecx
  801ed7:	89 c6                	mov    %eax,%esi
  801ed9:	e9 71 ff ff ff       	jmp    801e4f <__umoddi3+0xb3>
  801ede:	66 90                	xchg   %ax,%ax
  801ee0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ee4:	72 ea                	jb     801ed0 <__umoddi3+0x134>
  801ee6:	89 d9                	mov    %ebx,%ecx
  801ee8:	e9 62 ff ff ff       	jmp    801e4f <__umoddi3+0xb3>
