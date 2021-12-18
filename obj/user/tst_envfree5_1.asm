
obj/user/tst_envfree5_1:     file format elf32-i386


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
  800031:	e8 10 01 00 00       	call   800146 <libmain>
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
	// Testing scenario 5_1: Kill ONE program has shared variables and it free it
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 60 1e 80 00       	push   $0x801e60
  80004a:	e8 7e 14 00 00       	call   8014cd <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 a7 16 00 00       	call   80170a <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 22 17 00 00       	call   80178d <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 70 1e 80 00       	push   $0x801e70
  800079:	e8 af 04 00 00       	call   80052d <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tshr4", 2000,(myEnv->SecondListSize), 50);
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80008c:	6a 32                	push   $0x32
  80008e:	50                   	push   %eax
  80008f:	68 d0 07 00 00       	push   $0x7d0
  800094:	68 a3 1e 80 00       	push   $0x801ea3
  800099:	e8 c1 18 00 00       	call   80195f <sys_create_env>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(envIdProcessA);
  8000a4:	83 ec 0c             	sub    $0xc,%esp
  8000a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000aa:	e8 ce 18 00 00       	call   80197d <sys_run_env>
  8000af:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 1) ;
  8000b2:	90                   	nop
  8000b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	83 f8 01             	cmp    $0x1,%eax
  8000bb:	75 f6                	jne    8000b3 <_main+0x7b>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000bd:	e8 48 16 00 00       	call   80170a <sys_calculate_free_frames>
  8000c2:	83 ec 08             	sub    $0x8,%esp
  8000c5:	50                   	push   %eax
  8000c6:	68 ac 1e 80 00       	push   $0x801eac
  8000cb:	e8 5d 04 00 00       	call   80052d <cprintf>
  8000d0:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  8000d3:	83 ec 0c             	sub    $0xc,%esp
  8000d6:	ff 75 e8             	pushl  -0x18(%ebp)
  8000d9:	e8 bb 18 00 00       	call   801999 <sys_free_env>
  8000de:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  8000e1:	e8 24 16 00 00       	call   80170a <sys_calculate_free_frames>
  8000e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  8000e9:	e8 9f 16 00 00       	call   80178d <sys_pf_calculate_allocated_pages>
  8000ee:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000f7:	74 27                	je     800120 <_main+0xe8>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n", freeFrames_after);
  8000f9:	83 ec 08             	sub    $0x8,%esp
  8000fc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000ff:	68 e0 1e 80 00       	push   $0x801ee0
  800104:	e8 24 04 00 00       	call   80052d <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp
		panic("env_free() does not work correctly... check it again.");
  80010c:	83 ec 04             	sub    $0x4,%esp
  80010f:	68 30 1f 80 00       	push   $0x801f30
  800114:	6a 1e                	push   $0x1e
  800116:	68 66 1f 80 00       	push   $0x801f66
  80011b:	e8 6b 01 00 00       	call   80028b <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  800120:	83 ec 08             	sub    $0x8,%esp
  800123:	ff 75 e4             	pushl  -0x1c(%ebp)
  800126:	68 7c 1f 80 00       	push   $0x801f7c
  80012b:	e8 fd 03 00 00       	call   80052d <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 5_1 for envfree completed successfully.\n");
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	68 dc 1f 80 00       	push   $0x801fdc
  80013b:	e8 ed 03 00 00       	call   80052d <cprintf>
  800140:	83 c4 10             	add    $0x10,%esp
	return;
  800143:	90                   	nop
}
  800144:	c9                   	leave  
  800145:	c3                   	ret    

00800146 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800146:	55                   	push   %ebp
  800147:	89 e5                	mov    %esp,%ebp
  800149:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80014c:	e8 ee 14 00 00       	call   80163f <sys_getenvindex>
  800151:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800154:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800157:	89 d0                	mov    %edx,%eax
  800159:	c1 e0 03             	shl    $0x3,%eax
  80015c:	01 d0                	add    %edx,%eax
  80015e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800165:	01 c8                	add    %ecx,%eax
  800167:	01 c0                	add    %eax,%eax
  800169:	01 d0                	add    %edx,%eax
  80016b:	01 c0                	add    %eax,%eax
  80016d:	01 d0                	add    %edx,%eax
  80016f:	89 c2                	mov    %eax,%edx
  800171:	c1 e2 05             	shl    $0x5,%edx
  800174:	29 c2                	sub    %eax,%edx
  800176:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80017d:	89 c2                	mov    %eax,%edx
  80017f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800185:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80018a:	a1 20 30 80 00       	mov    0x803020,%eax
  80018f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800195:	84 c0                	test   %al,%al
  800197:	74 0f                	je     8001a8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800199:	a1 20 30 80 00       	mov    0x803020,%eax
  80019e:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001a3:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ac:	7e 0a                	jle    8001b8 <libmain+0x72>
		binaryname = argv[0];
  8001ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b1:	8b 00                	mov    (%eax),%eax
  8001b3:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001b8:	83 ec 08             	sub    $0x8,%esp
  8001bb:	ff 75 0c             	pushl  0xc(%ebp)
  8001be:	ff 75 08             	pushl  0x8(%ebp)
  8001c1:	e8 72 fe ff ff       	call   800038 <_main>
  8001c6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c9:	e8 0c 16 00 00       	call   8017da <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001ce:	83 ec 0c             	sub    $0xc,%esp
  8001d1:	68 40 20 80 00       	push   $0x802040
  8001d6:	e8 52 03 00 00       	call   80052d <cprintf>
  8001db:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001de:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ee:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001f4:	83 ec 04             	sub    $0x4,%esp
  8001f7:	52                   	push   %edx
  8001f8:	50                   	push   %eax
  8001f9:	68 68 20 80 00       	push   $0x802068
  8001fe:	e8 2a 03 00 00       	call   80052d <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800206:	a1 20 30 80 00       	mov    0x803020,%eax
  80020b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80021c:	83 ec 04             	sub    $0x4,%esp
  80021f:	52                   	push   %edx
  800220:	50                   	push   %eax
  800221:	68 90 20 80 00       	push   $0x802090
  800226:	e8 02 03 00 00       	call   80052d <cprintf>
  80022b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800239:	83 ec 08             	sub    $0x8,%esp
  80023c:	50                   	push   %eax
  80023d:	68 d1 20 80 00       	push   $0x8020d1
  800242:	e8 e6 02 00 00       	call   80052d <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 40 20 80 00       	push   $0x802040
  800252:	e8 d6 02 00 00       	call   80052d <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80025a:	e8 95 15 00 00       	call   8017f4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80025f:	e8 19 00 00 00       	call   80027d <exit>
}
  800264:	90                   	nop
  800265:	c9                   	leave  
  800266:	c3                   	ret    

00800267 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800267:	55                   	push   %ebp
  800268:	89 e5                	mov    %esp,%ebp
  80026a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80026d:	83 ec 0c             	sub    $0xc,%esp
  800270:	6a 00                	push   $0x0
  800272:	e8 94 13 00 00       	call   80160b <sys_env_destroy>
  800277:	83 c4 10             	add    $0x10,%esp
}
  80027a:	90                   	nop
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <exit>:

void
exit(void)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800283:	e8 e9 13 00 00       	call   801671 <sys_env_exit>
}
  800288:	90                   	nop
  800289:	c9                   	leave  
  80028a:	c3                   	ret    

0080028b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80028b:	55                   	push   %ebp
  80028c:	89 e5                	mov    %esp,%ebp
  80028e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800291:	8d 45 10             	lea    0x10(%ebp),%eax
  800294:	83 c0 04             	add    $0x4,%eax
  800297:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80029a:	a1 18 31 80 00       	mov    0x803118,%eax
  80029f:	85 c0                	test   %eax,%eax
  8002a1:	74 16                	je     8002b9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002a3:	a1 18 31 80 00       	mov    0x803118,%eax
  8002a8:	83 ec 08             	sub    $0x8,%esp
  8002ab:	50                   	push   %eax
  8002ac:	68 e8 20 80 00       	push   $0x8020e8
  8002b1:	e8 77 02 00 00       	call   80052d <cprintf>
  8002b6:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002b9:	a1 00 30 80 00       	mov    0x803000,%eax
  8002be:	ff 75 0c             	pushl  0xc(%ebp)
  8002c1:	ff 75 08             	pushl  0x8(%ebp)
  8002c4:	50                   	push   %eax
  8002c5:	68 ed 20 80 00       	push   $0x8020ed
  8002ca:	e8 5e 02 00 00       	call   80052d <cprintf>
  8002cf:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d5:	83 ec 08             	sub    $0x8,%esp
  8002d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002db:	50                   	push   %eax
  8002dc:	e8 e1 01 00 00       	call   8004c2 <vcprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002e4:	83 ec 08             	sub    $0x8,%esp
  8002e7:	6a 00                	push   $0x0
  8002e9:	68 09 21 80 00       	push   $0x802109
  8002ee:	e8 cf 01 00 00       	call   8004c2 <vcprintf>
  8002f3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002f6:	e8 82 ff ff ff       	call   80027d <exit>

	// should not return here
	while (1) ;
  8002fb:	eb fe                	jmp    8002fb <_panic+0x70>

008002fd <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002fd:	55                   	push   %ebp
  8002fe:	89 e5                	mov    %esp,%ebp
  800300:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800303:	a1 20 30 80 00       	mov    0x803020,%eax
  800308:	8b 50 74             	mov    0x74(%eax),%edx
  80030b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	74 14                	je     800326 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	68 0c 21 80 00       	push   $0x80210c
  80031a:	6a 26                	push   $0x26
  80031c:	68 58 21 80 00       	push   $0x802158
  800321:	e8 65 ff ff ff       	call   80028b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80032d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800334:	e9 b6 00 00 00       	jmp    8003ef <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800339:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800343:	8b 45 08             	mov    0x8(%ebp),%eax
  800346:	01 d0                	add    %edx,%eax
  800348:	8b 00                	mov    (%eax),%eax
  80034a:	85 c0                	test   %eax,%eax
  80034c:	75 08                	jne    800356 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80034e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800351:	e9 96 00 00 00       	jmp    8003ec <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800356:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80035d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800364:	eb 5d                	jmp    8003c3 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800366:	a1 20 30 80 00       	mov    0x803020,%eax
  80036b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800371:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800374:	c1 e2 04             	shl    $0x4,%edx
  800377:	01 d0                	add    %edx,%eax
  800379:	8a 40 04             	mov    0x4(%eax),%al
  80037c:	84 c0                	test   %al,%al
  80037e:	75 40                	jne    8003c0 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800380:	a1 20 30 80 00       	mov    0x803020,%eax
  800385:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80038b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80038e:	c1 e2 04             	shl    $0x4,%edx
  800391:	01 d0                	add    %edx,%eax
  800393:	8b 00                	mov    (%eax),%eax
  800395:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800398:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80039b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	01 c8                	add    %ecx,%eax
  8003b1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b3:	39 c2                	cmp    %eax,%edx
  8003b5:	75 09                	jne    8003c0 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003b7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003be:	eb 12                	jmp    8003d2 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c0:	ff 45 e8             	incl   -0x18(%ebp)
  8003c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c8:	8b 50 74             	mov    0x74(%eax),%edx
  8003cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003ce:	39 c2                	cmp    %eax,%edx
  8003d0:	77 94                	ja     800366 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003d6:	75 14                	jne    8003ec <CheckWSWithoutLastIndex+0xef>
			panic(
  8003d8:	83 ec 04             	sub    $0x4,%esp
  8003db:	68 64 21 80 00       	push   $0x802164
  8003e0:	6a 3a                	push   $0x3a
  8003e2:	68 58 21 80 00       	push   $0x802158
  8003e7:	e8 9f fe ff ff       	call   80028b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ec:	ff 45 f0             	incl   -0x10(%ebp)
  8003ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003f5:	0f 8c 3e ff ff ff    	jl     800339 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800402:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800409:	eb 20                	jmp    80042b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80040b:	a1 20 30 80 00       	mov    0x803020,%eax
  800410:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800416:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800419:	c1 e2 04             	shl    $0x4,%edx
  80041c:	01 d0                	add    %edx,%eax
  80041e:	8a 40 04             	mov    0x4(%eax),%al
  800421:	3c 01                	cmp    $0x1,%al
  800423:	75 03                	jne    800428 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800425:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800428:	ff 45 e0             	incl   -0x20(%ebp)
  80042b:	a1 20 30 80 00       	mov    0x803020,%eax
  800430:	8b 50 74             	mov    0x74(%eax),%edx
  800433:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800436:	39 c2                	cmp    %eax,%edx
  800438:	77 d1                	ja     80040b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80043a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800440:	74 14                	je     800456 <CheckWSWithoutLastIndex+0x159>
		panic(
  800442:	83 ec 04             	sub    $0x4,%esp
  800445:	68 b8 21 80 00       	push   $0x8021b8
  80044a:	6a 44                	push   $0x44
  80044c:	68 58 21 80 00       	push   $0x802158
  800451:	e8 35 fe ff ff       	call   80028b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800456:	90                   	nop
  800457:	c9                   	leave  
  800458:	c3                   	ret    

00800459 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800459:	55                   	push   %ebp
  80045a:	89 e5                	mov    %esp,%ebp
  80045c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	8d 48 01             	lea    0x1(%eax),%ecx
  800467:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046a:	89 0a                	mov    %ecx,(%edx)
  80046c:	8b 55 08             	mov    0x8(%ebp),%edx
  80046f:	88 d1                	mov    %dl,%cl
  800471:	8b 55 0c             	mov    0xc(%ebp),%edx
  800474:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800482:	75 2c                	jne    8004b0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800484:	a0 24 30 80 00       	mov    0x803024,%al
  800489:	0f b6 c0             	movzbl %al,%eax
  80048c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048f:	8b 12                	mov    (%edx),%edx
  800491:	89 d1                	mov    %edx,%ecx
  800493:	8b 55 0c             	mov    0xc(%ebp),%edx
  800496:	83 c2 08             	add    $0x8,%edx
  800499:	83 ec 04             	sub    $0x4,%esp
  80049c:	50                   	push   %eax
  80049d:	51                   	push   %ecx
  80049e:	52                   	push   %edx
  80049f:	e8 25 11 00 00       	call   8015c9 <sys_cputs>
  8004a4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b3:	8b 40 04             	mov    0x4(%eax),%eax
  8004b6:	8d 50 01             	lea    0x1(%eax),%edx
  8004b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004bf:	90                   	nop
  8004c0:	c9                   	leave  
  8004c1:	c3                   	ret    

008004c2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004c2:	55                   	push   %ebp
  8004c3:	89 e5                	mov    %esp,%ebp
  8004c5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004cb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004d2:	00 00 00 
	b.cnt = 0;
  8004d5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004dc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004df:	ff 75 0c             	pushl  0xc(%ebp)
  8004e2:	ff 75 08             	pushl  0x8(%ebp)
  8004e5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004eb:	50                   	push   %eax
  8004ec:	68 59 04 80 00       	push   $0x800459
  8004f1:	e8 11 02 00 00       	call   800707 <vprintfmt>
  8004f6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f9:	a0 24 30 80 00       	mov    0x803024,%al
  8004fe:	0f b6 c0             	movzbl %al,%eax
  800501:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800507:	83 ec 04             	sub    $0x4,%esp
  80050a:	50                   	push   %eax
  80050b:	52                   	push   %edx
  80050c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800512:	83 c0 08             	add    $0x8,%eax
  800515:	50                   	push   %eax
  800516:	e8 ae 10 00 00       	call   8015c9 <sys_cputs>
  80051b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80051e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800525:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80052b:	c9                   	leave  
  80052c:	c3                   	ret    

0080052d <cprintf>:

int cprintf(const char *fmt, ...) {
  80052d:	55                   	push   %ebp
  80052e:	89 e5                	mov    %esp,%ebp
  800530:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800533:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80053a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	ff 75 f4             	pushl  -0xc(%ebp)
  800549:	50                   	push   %eax
  80054a:	e8 73 ff ff ff       	call   8004c2 <vcprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800555:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800560:	e8 75 12 00 00       	call   8017da <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800565:	8d 45 0c             	lea    0xc(%ebp),%eax
  800568:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80056b:	8b 45 08             	mov    0x8(%ebp),%eax
  80056e:	83 ec 08             	sub    $0x8,%esp
  800571:	ff 75 f4             	pushl  -0xc(%ebp)
  800574:	50                   	push   %eax
  800575:	e8 48 ff ff ff       	call   8004c2 <vcprintf>
  80057a:	83 c4 10             	add    $0x10,%esp
  80057d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800580:	e8 6f 12 00 00       	call   8017f4 <sys_enable_interrupt>
	return cnt;
  800585:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800588:	c9                   	leave  
  800589:	c3                   	ret    

0080058a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80058a:	55                   	push   %ebp
  80058b:	89 e5                	mov    %esp,%ebp
  80058d:	53                   	push   %ebx
  80058e:	83 ec 14             	sub    $0x14,%esp
  800591:	8b 45 10             	mov    0x10(%ebp),%eax
  800594:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800597:	8b 45 14             	mov    0x14(%ebp),%eax
  80059a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80059d:	8b 45 18             	mov    0x18(%ebp),%eax
  8005a0:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a8:	77 55                	ja     8005ff <printnum+0x75>
  8005aa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ad:	72 05                	jb     8005b4 <printnum+0x2a>
  8005af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005b2:	77 4b                	ja     8005ff <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005b4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005ba:	8b 45 18             	mov    0x18(%ebp),%eax
  8005bd:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c2:	52                   	push   %edx
  8005c3:	50                   	push   %eax
  8005c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8005ca:	e8 2d 16 00 00       	call   801bfc <__udivdi3>
  8005cf:	83 c4 10             	add    $0x10,%esp
  8005d2:	83 ec 04             	sub    $0x4,%esp
  8005d5:	ff 75 20             	pushl  0x20(%ebp)
  8005d8:	53                   	push   %ebx
  8005d9:	ff 75 18             	pushl  0x18(%ebp)
  8005dc:	52                   	push   %edx
  8005dd:	50                   	push   %eax
  8005de:	ff 75 0c             	pushl  0xc(%ebp)
  8005e1:	ff 75 08             	pushl  0x8(%ebp)
  8005e4:	e8 a1 ff ff ff       	call   80058a <printnum>
  8005e9:	83 c4 20             	add    $0x20,%esp
  8005ec:	eb 1a                	jmp    800608 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	ff 75 0c             	pushl  0xc(%ebp)
  8005f4:	ff 75 20             	pushl  0x20(%ebp)
  8005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fa:	ff d0                	call   *%eax
  8005fc:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005ff:	ff 4d 1c             	decl   0x1c(%ebp)
  800602:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800606:	7f e6                	jg     8005ee <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800608:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80060b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800610:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800613:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800616:	53                   	push   %ebx
  800617:	51                   	push   %ecx
  800618:	52                   	push   %edx
  800619:	50                   	push   %eax
  80061a:	e8 ed 16 00 00       	call   801d0c <__umoddi3>
  80061f:	83 c4 10             	add    $0x10,%esp
  800622:	05 34 24 80 00       	add    $0x802434,%eax
  800627:	8a 00                	mov    (%eax),%al
  800629:	0f be c0             	movsbl %al,%eax
  80062c:	83 ec 08             	sub    $0x8,%esp
  80062f:	ff 75 0c             	pushl  0xc(%ebp)
  800632:	50                   	push   %eax
  800633:	8b 45 08             	mov    0x8(%ebp),%eax
  800636:	ff d0                	call   *%eax
  800638:	83 c4 10             	add    $0x10,%esp
}
  80063b:	90                   	nop
  80063c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063f:	c9                   	leave  
  800640:	c3                   	ret    

00800641 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800641:	55                   	push   %ebp
  800642:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800644:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800648:	7e 1c                	jle    800666 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80064a:	8b 45 08             	mov    0x8(%ebp),%eax
  80064d:	8b 00                	mov    (%eax),%eax
  80064f:	8d 50 08             	lea    0x8(%eax),%edx
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	89 10                	mov    %edx,(%eax)
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	8b 00                	mov    (%eax),%eax
  80065c:	83 e8 08             	sub    $0x8,%eax
  80065f:	8b 50 04             	mov    0x4(%eax),%edx
  800662:	8b 00                	mov    (%eax),%eax
  800664:	eb 40                	jmp    8006a6 <getuint+0x65>
	else if (lflag)
  800666:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80066a:	74 1e                	je     80068a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80066c:	8b 45 08             	mov    0x8(%ebp),%eax
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	8d 50 04             	lea    0x4(%eax),%edx
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	89 10                	mov    %edx,(%eax)
  800679:	8b 45 08             	mov    0x8(%ebp),%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	83 e8 04             	sub    $0x4,%eax
  800681:	8b 00                	mov    (%eax),%eax
  800683:	ba 00 00 00 00       	mov    $0x0,%edx
  800688:	eb 1c                	jmp    8006a6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80068a:	8b 45 08             	mov    0x8(%ebp),%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	8d 50 04             	lea    0x4(%eax),%edx
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	89 10                	mov    %edx,(%eax)
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	8b 00                	mov    (%eax),%eax
  80069c:	83 e8 04             	sub    $0x4,%eax
  80069f:	8b 00                	mov    (%eax),%eax
  8006a1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a6:	5d                   	pop    %ebp
  8006a7:	c3                   	ret    

008006a8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ab:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006af:	7e 1c                	jle    8006cd <getint+0x25>
		return va_arg(*ap, long long);
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	8d 50 08             	lea    0x8(%eax),%edx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	89 10                	mov    %edx,(%eax)
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	83 e8 08             	sub    $0x8,%eax
  8006c6:	8b 50 04             	mov    0x4(%eax),%edx
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	eb 38                	jmp    800705 <getint+0x5d>
	else if (lflag)
  8006cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d1:	74 1a                	je     8006ed <getint+0x45>
		return va_arg(*ap, long);
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	8b 00                	mov    (%eax),%eax
  8006d8:	8d 50 04             	lea    0x4(%eax),%edx
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	89 10                	mov    %edx,(%eax)
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	8b 00                	mov    (%eax),%eax
  8006e5:	83 e8 04             	sub    $0x4,%eax
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	99                   	cltd   
  8006eb:	eb 18                	jmp    800705 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	8d 50 04             	lea    0x4(%eax),%edx
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	89 10                	mov    %edx,(%eax)
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	8b 00                	mov    (%eax),%eax
  8006ff:	83 e8 04             	sub    $0x4,%eax
  800702:	8b 00                	mov    (%eax),%eax
  800704:	99                   	cltd   
}
  800705:	5d                   	pop    %ebp
  800706:	c3                   	ret    

00800707 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800707:	55                   	push   %ebp
  800708:	89 e5                	mov    %esp,%ebp
  80070a:	56                   	push   %esi
  80070b:	53                   	push   %ebx
  80070c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070f:	eb 17                	jmp    800728 <vprintfmt+0x21>
			if (ch == '\0')
  800711:	85 db                	test   %ebx,%ebx
  800713:	0f 84 af 03 00 00    	je     800ac8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	ff 75 0c             	pushl  0xc(%ebp)
  80071f:	53                   	push   %ebx
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	ff d0                	call   *%eax
  800725:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800728:	8b 45 10             	mov    0x10(%ebp),%eax
  80072b:	8d 50 01             	lea    0x1(%eax),%edx
  80072e:	89 55 10             	mov    %edx,0x10(%ebp)
  800731:	8a 00                	mov    (%eax),%al
  800733:	0f b6 d8             	movzbl %al,%ebx
  800736:	83 fb 25             	cmp    $0x25,%ebx
  800739:	75 d6                	jne    800711 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80073b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800746:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80074d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800754:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80075b:	8b 45 10             	mov    0x10(%ebp),%eax
  80075e:	8d 50 01             	lea    0x1(%eax),%edx
  800761:	89 55 10             	mov    %edx,0x10(%ebp)
  800764:	8a 00                	mov    (%eax),%al
  800766:	0f b6 d8             	movzbl %al,%ebx
  800769:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80076c:	83 f8 55             	cmp    $0x55,%eax
  80076f:	0f 87 2b 03 00 00    	ja     800aa0 <vprintfmt+0x399>
  800775:	8b 04 85 58 24 80 00 	mov    0x802458(,%eax,4),%eax
  80077c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80077e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800782:	eb d7                	jmp    80075b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800784:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800788:	eb d1                	jmp    80075b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80078a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800791:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800794:	89 d0                	mov    %edx,%eax
  800796:	c1 e0 02             	shl    $0x2,%eax
  800799:	01 d0                	add    %edx,%eax
  80079b:	01 c0                	add    %eax,%eax
  80079d:	01 d8                	add    %ebx,%eax
  80079f:	83 e8 30             	sub    $0x30,%eax
  8007a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a8:	8a 00                	mov    (%eax),%al
  8007aa:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ad:	83 fb 2f             	cmp    $0x2f,%ebx
  8007b0:	7e 3e                	jle    8007f0 <vprintfmt+0xe9>
  8007b2:	83 fb 39             	cmp    $0x39,%ebx
  8007b5:	7f 39                	jg     8007f0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007ba:	eb d5                	jmp    800791 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bf:	83 c0 04             	add    $0x4,%eax
  8007c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c8:	83 e8 04             	sub    $0x4,%eax
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007d0:	eb 1f                	jmp    8007f1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d6:	79 83                	jns    80075b <vprintfmt+0x54>
				width = 0;
  8007d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007df:	e9 77 ff ff ff       	jmp    80075b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007e4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007eb:	e9 6b ff ff ff       	jmp    80075b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007f0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f5:	0f 89 60 ff ff ff    	jns    80075b <vprintfmt+0x54>
				width = precision, precision = -1;
  8007fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800801:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800808:	e9 4e ff ff ff       	jmp    80075b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80080d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800810:	e9 46 ff ff ff       	jmp    80075b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800815:	8b 45 14             	mov    0x14(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 14             	mov    %eax,0x14(%ebp)
  80081e:	8b 45 14             	mov    0x14(%ebp),%eax
  800821:	83 e8 04             	sub    $0x4,%eax
  800824:	8b 00                	mov    (%eax),%eax
  800826:	83 ec 08             	sub    $0x8,%esp
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	50                   	push   %eax
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	ff d0                	call   *%eax
  800832:	83 c4 10             	add    $0x10,%esp
			break;
  800835:	e9 89 02 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80083a:	8b 45 14             	mov    0x14(%ebp),%eax
  80083d:	83 c0 04             	add    $0x4,%eax
  800840:	89 45 14             	mov    %eax,0x14(%ebp)
  800843:	8b 45 14             	mov    0x14(%ebp),%eax
  800846:	83 e8 04             	sub    $0x4,%eax
  800849:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80084b:	85 db                	test   %ebx,%ebx
  80084d:	79 02                	jns    800851 <vprintfmt+0x14a>
				err = -err;
  80084f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800851:	83 fb 64             	cmp    $0x64,%ebx
  800854:	7f 0b                	jg     800861 <vprintfmt+0x15a>
  800856:	8b 34 9d a0 22 80 00 	mov    0x8022a0(,%ebx,4),%esi
  80085d:	85 f6                	test   %esi,%esi
  80085f:	75 19                	jne    80087a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800861:	53                   	push   %ebx
  800862:	68 45 24 80 00       	push   $0x802445
  800867:	ff 75 0c             	pushl  0xc(%ebp)
  80086a:	ff 75 08             	pushl  0x8(%ebp)
  80086d:	e8 5e 02 00 00       	call   800ad0 <printfmt>
  800872:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800875:	e9 49 02 00 00       	jmp    800ac3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80087a:	56                   	push   %esi
  80087b:	68 4e 24 80 00       	push   $0x80244e
  800880:	ff 75 0c             	pushl  0xc(%ebp)
  800883:	ff 75 08             	pushl  0x8(%ebp)
  800886:	e8 45 02 00 00       	call   800ad0 <printfmt>
  80088b:	83 c4 10             	add    $0x10,%esp
			break;
  80088e:	e9 30 02 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800893:	8b 45 14             	mov    0x14(%ebp),%eax
  800896:	83 c0 04             	add    $0x4,%eax
  800899:	89 45 14             	mov    %eax,0x14(%ebp)
  80089c:	8b 45 14             	mov    0x14(%ebp),%eax
  80089f:	83 e8 04             	sub    $0x4,%eax
  8008a2:	8b 30                	mov    (%eax),%esi
  8008a4:	85 f6                	test   %esi,%esi
  8008a6:	75 05                	jne    8008ad <vprintfmt+0x1a6>
				p = "(null)";
  8008a8:	be 51 24 80 00       	mov    $0x802451,%esi
			if (width > 0 && padc != '-')
  8008ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b1:	7e 6d                	jle    800920 <vprintfmt+0x219>
  8008b3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b7:	74 67                	je     800920 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008bc:	83 ec 08             	sub    $0x8,%esp
  8008bf:	50                   	push   %eax
  8008c0:	56                   	push   %esi
  8008c1:	e8 0c 03 00 00       	call   800bd2 <strnlen>
  8008c6:	83 c4 10             	add    $0x10,%esp
  8008c9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008cc:	eb 16                	jmp    8008e4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008ce:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008d2:	83 ec 08             	sub    $0x8,%esp
  8008d5:	ff 75 0c             	pushl  0xc(%ebp)
  8008d8:	50                   	push   %eax
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	ff d0                	call   *%eax
  8008de:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008e1:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e8:	7f e4                	jg     8008ce <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ea:	eb 34                	jmp    800920 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008ec:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008f0:	74 1c                	je     80090e <vprintfmt+0x207>
  8008f2:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f5:	7e 05                	jle    8008fc <vprintfmt+0x1f5>
  8008f7:	83 fb 7e             	cmp    $0x7e,%ebx
  8008fa:	7e 12                	jle    80090e <vprintfmt+0x207>
					putch('?', putdat);
  8008fc:	83 ec 08             	sub    $0x8,%esp
  8008ff:	ff 75 0c             	pushl  0xc(%ebp)
  800902:	6a 3f                	push   $0x3f
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	ff d0                	call   *%eax
  800909:	83 c4 10             	add    $0x10,%esp
  80090c:	eb 0f                	jmp    80091d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80090e:	83 ec 08             	sub    $0x8,%esp
  800911:	ff 75 0c             	pushl  0xc(%ebp)
  800914:	53                   	push   %ebx
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	ff d0                	call   *%eax
  80091a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091d:	ff 4d e4             	decl   -0x1c(%ebp)
  800920:	89 f0                	mov    %esi,%eax
  800922:	8d 70 01             	lea    0x1(%eax),%esi
  800925:	8a 00                	mov    (%eax),%al
  800927:	0f be d8             	movsbl %al,%ebx
  80092a:	85 db                	test   %ebx,%ebx
  80092c:	74 24                	je     800952 <vprintfmt+0x24b>
  80092e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800932:	78 b8                	js     8008ec <vprintfmt+0x1e5>
  800934:	ff 4d e0             	decl   -0x20(%ebp)
  800937:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80093b:	79 af                	jns    8008ec <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80093d:	eb 13                	jmp    800952 <vprintfmt+0x24b>
				putch(' ', putdat);
  80093f:	83 ec 08             	sub    $0x8,%esp
  800942:	ff 75 0c             	pushl  0xc(%ebp)
  800945:	6a 20                	push   $0x20
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	ff d0                	call   *%eax
  80094c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094f:	ff 4d e4             	decl   -0x1c(%ebp)
  800952:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800956:	7f e7                	jg     80093f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800958:	e9 66 01 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80095d:	83 ec 08             	sub    $0x8,%esp
  800960:	ff 75 e8             	pushl  -0x18(%ebp)
  800963:	8d 45 14             	lea    0x14(%ebp),%eax
  800966:	50                   	push   %eax
  800967:	e8 3c fd ff ff       	call   8006a8 <getint>
  80096c:	83 c4 10             	add    $0x10,%esp
  80096f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800972:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800975:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800978:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80097b:	85 d2                	test   %edx,%edx
  80097d:	79 23                	jns    8009a2 <vprintfmt+0x29b>
				putch('-', putdat);
  80097f:	83 ec 08             	sub    $0x8,%esp
  800982:	ff 75 0c             	pushl  0xc(%ebp)
  800985:	6a 2d                	push   $0x2d
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	ff d0                	call   *%eax
  80098c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800992:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800995:	f7 d8                	neg    %eax
  800997:	83 d2 00             	adc    $0x0,%edx
  80099a:	f7 da                	neg    %edx
  80099c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009a2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a9:	e9 bc 00 00 00       	jmp    800a6a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b4:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b7:	50                   	push   %eax
  8009b8:	e8 84 fc ff ff       	call   800641 <getuint>
  8009bd:	83 c4 10             	add    $0x10,%esp
  8009c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009cd:	e9 98 00 00 00       	jmp    800a6a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009d2:	83 ec 08             	sub    $0x8,%esp
  8009d5:	ff 75 0c             	pushl  0xc(%ebp)
  8009d8:	6a 58                	push   $0x58
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	ff d0                	call   *%eax
  8009df:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009e2:	83 ec 08             	sub    $0x8,%esp
  8009e5:	ff 75 0c             	pushl  0xc(%ebp)
  8009e8:	6a 58                	push   $0x58
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	ff d0                	call   *%eax
  8009ef:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009f2:	83 ec 08             	sub    $0x8,%esp
  8009f5:	ff 75 0c             	pushl  0xc(%ebp)
  8009f8:	6a 58                	push   $0x58
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	ff d0                	call   *%eax
  8009ff:	83 c4 10             	add    $0x10,%esp
			break;
  800a02:	e9 bc 00 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	ff 75 0c             	pushl  0xc(%ebp)
  800a0d:	6a 30                	push   $0x30
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	ff d0                	call   *%eax
  800a14:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a17:	83 ec 08             	sub    $0x8,%esp
  800a1a:	ff 75 0c             	pushl  0xc(%ebp)
  800a1d:	6a 78                	push   $0x78
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	ff d0                	call   *%eax
  800a24:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	83 c0 04             	add    $0x4,%eax
  800a2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a30:	8b 45 14             	mov    0x14(%ebp),%eax
  800a33:	83 e8 04             	sub    $0x4,%eax
  800a36:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a42:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a49:	eb 1f                	jmp    800a6a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a4b:	83 ec 08             	sub    $0x8,%esp
  800a4e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a51:	8d 45 14             	lea    0x14(%ebp),%eax
  800a54:	50                   	push   %eax
  800a55:	e8 e7 fb ff ff       	call   800641 <getuint>
  800a5a:	83 c4 10             	add    $0x10,%esp
  800a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a60:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a63:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a6a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a71:	83 ec 04             	sub    $0x4,%esp
  800a74:	52                   	push   %edx
  800a75:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a78:	50                   	push   %eax
  800a79:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7f:	ff 75 0c             	pushl  0xc(%ebp)
  800a82:	ff 75 08             	pushl  0x8(%ebp)
  800a85:	e8 00 fb ff ff       	call   80058a <printnum>
  800a8a:	83 c4 20             	add    $0x20,%esp
			break;
  800a8d:	eb 34                	jmp    800ac3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8f:	83 ec 08             	sub    $0x8,%esp
  800a92:	ff 75 0c             	pushl  0xc(%ebp)
  800a95:	53                   	push   %ebx
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	ff d0                	call   *%eax
  800a9b:	83 c4 10             	add    $0x10,%esp
			break;
  800a9e:	eb 23                	jmp    800ac3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800aa0:	83 ec 08             	sub    $0x8,%esp
  800aa3:	ff 75 0c             	pushl  0xc(%ebp)
  800aa6:	6a 25                	push   $0x25
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	ff d0                	call   *%eax
  800aad:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ab0:	ff 4d 10             	decl   0x10(%ebp)
  800ab3:	eb 03                	jmp    800ab8 <vprintfmt+0x3b1>
  800ab5:	ff 4d 10             	decl   0x10(%ebp)
  800ab8:	8b 45 10             	mov    0x10(%ebp),%eax
  800abb:	48                   	dec    %eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	3c 25                	cmp    $0x25,%al
  800ac0:	75 f3                	jne    800ab5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ac2:	90                   	nop
		}
	}
  800ac3:	e9 47 fc ff ff       	jmp    80070f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800acc:	5b                   	pop    %ebx
  800acd:	5e                   	pop    %esi
  800ace:	5d                   	pop    %ebp
  800acf:	c3                   	ret    

00800ad0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad6:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad9:	83 c0 04             	add    $0x4,%eax
  800adc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800adf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae5:	50                   	push   %eax
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	ff 75 08             	pushl  0x8(%ebp)
  800aec:	e8 16 fc ff ff       	call   800707 <vprintfmt>
  800af1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800af4:	90                   	nop
  800af5:	c9                   	leave  
  800af6:	c3                   	ret    

00800af7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af7:	55                   	push   %ebp
  800af8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afd:	8b 40 08             	mov    0x8(%eax),%eax
  800b00:	8d 50 01             	lea    0x1(%eax),%edx
  800b03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b06:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	8b 10                	mov    (%eax),%edx
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	8b 40 04             	mov    0x4(%eax),%eax
  800b14:	39 c2                	cmp    %eax,%edx
  800b16:	73 12                	jae    800b2a <sprintputch+0x33>
		*b->buf++ = ch;
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	8d 48 01             	lea    0x1(%eax),%ecx
  800b20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b23:	89 0a                	mov    %ecx,(%edx)
  800b25:	8b 55 08             	mov    0x8(%ebp),%edx
  800b28:	88 10                	mov    %dl,(%eax)
}
  800b2a:	90                   	nop
  800b2b:	5d                   	pop    %ebp
  800b2c:	c3                   	ret    

00800b2d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b2d:	55                   	push   %ebp
  800b2e:	89 e5                	mov    %esp,%ebp
  800b30:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	01 d0                	add    %edx,%eax
  800b44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b4e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b52:	74 06                	je     800b5a <vsnprintf+0x2d>
  800b54:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b58:	7f 07                	jg     800b61 <vsnprintf+0x34>
		return -E_INVAL;
  800b5a:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5f:	eb 20                	jmp    800b81 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b61:	ff 75 14             	pushl  0x14(%ebp)
  800b64:	ff 75 10             	pushl  0x10(%ebp)
  800b67:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b6a:	50                   	push   %eax
  800b6b:	68 f7 0a 80 00       	push   $0x800af7
  800b70:	e8 92 fb ff ff       	call   800707 <vprintfmt>
  800b75:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b78:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b7b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b81:	c9                   	leave  
  800b82:	c3                   	ret    

00800b83 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b83:	55                   	push   %ebp
  800b84:	89 e5                	mov    %esp,%ebp
  800b86:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b89:	8d 45 10             	lea    0x10(%ebp),%eax
  800b8c:	83 c0 04             	add    $0x4,%eax
  800b8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b92:	8b 45 10             	mov    0x10(%ebp),%eax
  800b95:	ff 75 f4             	pushl  -0xc(%ebp)
  800b98:	50                   	push   %eax
  800b99:	ff 75 0c             	pushl  0xc(%ebp)
  800b9c:	ff 75 08             	pushl  0x8(%ebp)
  800b9f:	e8 89 ff ff ff       	call   800b2d <vsnprintf>
  800ba4:	83 c4 10             	add    $0x10,%esp
  800ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bbc:	eb 06                	jmp    800bc4 <strlen+0x15>
		n++;
  800bbe:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bc1:	ff 45 08             	incl   0x8(%ebp)
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	84 c0                	test   %al,%al
  800bcb:	75 f1                	jne    800bbe <strlen+0xf>
		n++;
	return n;
  800bcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd0:	c9                   	leave  
  800bd1:	c3                   	ret    

00800bd2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdf:	eb 09                	jmp    800bea <strnlen+0x18>
		n++;
  800be1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be4:	ff 45 08             	incl   0x8(%ebp)
  800be7:	ff 4d 0c             	decl   0xc(%ebp)
  800bea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bee:	74 09                	je     800bf9 <strnlen+0x27>
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	84 c0                	test   %al,%al
  800bf7:	75 e8                	jne    800be1 <strnlen+0xf>
		n++;
	return n;
  800bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c0a:	90                   	nop
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	8d 50 01             	lea    0x1(%eax),%edx
  800c11:	89 55 08             	mov    %edx,0x8(%ebp)
  800c14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c17:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c1a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1d:	8a 12                	mov    (%edx),%dl
  800c1f:	88 10                	mov    %dl,(%eax)
  800c21:	8a 00                	mov    (%eax),%al
  800c23:	84 c0                	test   %al,%al
  800c25:	75 e4                	jne    800c0b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c27:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c2a:	c9                   	leave  
  800c2b:	c3                   	ret    

00800c2c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
  800c2f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3f:	eb 1f                	jmp    800c60 <strncpy+0x34>
		*dst++ = *src;
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8d 50 01             	lea    0x1(%eax),%edx
  800c47:	89 55 08             	mov    %edx,0x8(%ebp)
  800c4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4d:	8a 12                	mov    (%edx),%dl
  800c4f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	84 c0                	test   %al,%al
  800c58:	74 03                	je     800c5d <strncpy+0x31>
			src++;
  800c5a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c5d:	ff 45 fc             	incl   -0x4(%ebp)
  800c60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c63:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c66:	72 d9                	jb     800c41 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c68:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c6b:	c9                   	leave  
  800c6c:	c3                   	ret    

00800c6d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c6d:	55                   	push   %ebp
  800c6e:	89 e5                	mov    %esp,%ebp
  800c70:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c79:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7d:	74 30                	je     800caf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7f:	eb 16                	jmp    800c97 <strlcpy+0x2a>
			*dst++ = *src++;
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	8d 50 01             	lea    0x1(%eax),%edx
  800c87:	89 55 08             	mov    %edx,0x8(%ebp)
  800c8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c90:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c93:	8a 12                	mov    (%edx),%dl
  800c95:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c97:	ff 4d 10             	decl   0x10(%ebp)
  800c9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9e:	74 09                	je     800ca9 <strlcpy+0x3c>
  800ca0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	84 c0                	test   %al,%al
  800ca7:	75 d8                	jne    800c81 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800caf:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb5:	29 c2                	sub    %eax,%edx
  800cb7:	89 d0                	mov    %edx,%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cbe:	eb 06                	jmp    800cc6 <strcmp+0xb>
		p++, q++;
  800cc0:	ff 45 08             	incl   0x8(%ebp)
  800cc3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	84 c0                	test   %al,%al
  800ccd:	74 0e                	je     800cdd <strcmp+0x22>
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8a 10                	mov    (%eax),%dl
  800cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	38 c2                	cmp    %al,%dl
  800cdb:	74 e3                	je     800cc0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	0f b6 d0             	movzbl %al,%edx
  800ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f b6 c0             	movzbl %al,%eax
  800ced:	29 c2                	sub    %eax,%edx
  800cef:	89 d0                	mov    %edx,%eax
}
  800cf1:	5d                   	pop    %ebp
  800cf2:	c3                   	ret    

00800cf3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cf3:	55                   	push   %ebp
  800cf4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf6:	eb 09                	jmp    800d01 <strncmp+0xe>
		n--, p++, q++;
  800cf8:	ff 4d 10             	decl   0x10(%ebp)
  800cfb:	ff 45 08             	incl   0x8(%ebp)
  800cfe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d05:	74 17                	je     800d1e <strncmp+0x2b>
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	84 c0                	test   %al,%al
  800d0e:	74 0e                	je     800d1e <strncmp+0x2b>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 10                	mov    (%eax),%dl
  800d15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	38 c2                	cmp    %al,%dl
  800d1c:	74 da                	je     800cf8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d22:	75 07                	jne    800d2b <strncmp+0x38>
		return 0;
  800d24:	b8 00 00 00 00       	mov    $0x0,%eax
  800d29:	eb 14                	jmp    800d3f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	0f b6 d0             	movzbl %al,%edx
  800d33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	0f b6 c0             	movzbl %al,%eax
  800d3b:	29 c2                	sub    %eax,%edx
  800d3d:	89 d0                	mov    %edx,%eax
}
  800d3f:	5d                   	pop    %ebp
  800d40:	c3                   	ret    

00800d41 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
  800d44:	83 ec 04             	sub    $0x4,%esp
  800d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4d:	eb 12                	jmp    800d61 <strchr+0x20>
		if (*s == c)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d57:	75 05                	jne    800d5e <strchr+0x1d>
			return (char *) s;
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	eb 11                	jmp    800d6f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d5e:	ff 45 08             	incl   0x8(%ebp)
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	84 c0                	test   %al,%al
  800d68:	75 e5                	jne    800d4f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 04             	sub    $0x4,%esp
  800d77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d7d:	eb 0d                	jmp    800d8c <strfind+0x1b>
		if (*s == c)
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d87:	74 0e                	je     800d97 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d89:	ff 45 08             	incl   0x8(%ebp)
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	8a 00                	mov    (%eax),%al
  800d91:	84 c0                	test   %al,%al
  800d93:	75 ea                	jne    800d7f <strfind+0xe>
  800d95:	eb 01                	jmp    800d98 <strfind+0x27>
		if (*s == c)
			break;
  800d97:	90                   	nop
	return (char *) s;
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9b:	c9                   	leave  
  800d9c:	c3                   	ret    

00800d9d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
  800da0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800daf:	eb 0e                	jmp    800dbf <memset+0x22>
		*p++ = c;
  800db1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db4:	8d 50 01             	lea    0x1(%eax),%edx
  800db7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dbd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dbf:	ff 4d f8             	decl   -0x8(%ebp)
  800dc2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc6:	79 e9                	jns    800db1 <memset+0x14>
		*p++ = c;

	return v;
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dcb:	c9                   	leave  
  800dcc:	c3                   	ret    

00800dcd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dcd:	55                   	push   %ebp
  800dce:	89 e5                	mov    %esp,%ebp
  800dd0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ddf:	eb 16                	jmp    800df7 <memcpy+0x2a>
		*d++ = *s++;
  800de1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de4:	8d 50 01             	lea    0x1(%eax),%edx
  800de7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ded:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df3:	8a 12                	mov    (%edx),%dl
  800df5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfd:	89 55 10             	mov    %edx,0x10(%ebp)
  800e00:	85 c0                	test   %eax,%eax
  800e02:	75 dd                	jne    800de1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e07:	c9                   	leave  
  800e08:	c3                   	ret    

00800e09 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e09:	55                   	push   %ebp
  800e0a:	89 e5                	mov    %esp,%ebp
  800e0c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e21:	73 50                	jae    800e73 <memmove+0x6a>
  800e23:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e26:	8b 45 10             	mov    0x10(%ebp),%eax
  800e29:	01 d0                	add    %edx,%eax
  800e2b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2e:	76 43                	jbe    800e73 <memmove+0x6a>
		s += n;
  800e30:	8b 45 10             	mov    0x10(%ebp),%eax
  800e33:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e36:	8b 45 10             	mov    0x10(%ebp),%eax
  800e39:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e3c:	eb 10                	jmp    800e4e <memmove+0x45>
			*--d = *--s;
  800e3e:	ff 4d f8             	decl   -0x8(%ebp)
  800e41:	ff 4d fc             	decl   -0x4(%ebp)
  800e44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e47:	8a 10                	mov    (%eax),%dl
  800e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e54:	89 55 10             	mov    %edx,0x10(%ebp)
  800e57:	85 c0                	test   %eax,%eax
  800e59:	75 e3                	jne    800e3e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e5b:	eb 23                	jmp    800e80 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e60:	8d 50 01             	lea    0x1(%eax),%edx
  800e63:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e69:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e6c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6f:	8a 12                	mov    (%edx),%dl
  800e71:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e73:	8b 45 10             	mov    0x10(%ebp),%eax
  800e76:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e79:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7c:	85 c0                	test   %eax,%eax
  800e7e:	75 dd                	jne    800e5d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e83:	c9                   	leave  
  800e84:	c3                   	ret    

00800e85 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e85:	55                   	push   %ebp
  800e86:	89 e5                	mov    %esp,%ebp
  800e88:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e94:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e97:	eb 2a                	jmp    800ec3 <memcmp+0x3e>
		if (*s1 != *s2)
  800e99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9c:	8a 10                	mov    (%eax),%dl
  800e9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	38 c2                	cmp    %al,%dl
  800ea5:	74 16                	je     800ebd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	0f b6 d0             	movzbl %al,%edx
  800eaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	0f b6 c0             	movzbl %al,%eax
  800eb7:	29 c2                	sub    %eax,%edx
  800eb9:	89 d0                	mov    %edx,%eax
  800ebb:	eb 18                	jmp    800ed5 <memcmp+0x50>
		s1++, s2++;
  800ebd:	ff 45 fc             	incl   -0x4(%ebp)
  800ec0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecc:	85 c0                	test   %eax,%eax
  800ece:	75 c9                	jne    800e99 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ed0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed5:	c9                   	leave  
  800ed6:	c3                   	ret    

00800ed7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed7:	55                   	push   %ebp
  800ed8:	89 e5                	mov    %esp,%ebp
  800eda:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800edd:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee3:	01 d0                	add    %edx,%eax
  800ee5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee8:	eb 15                	jmp    800eff <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	0f b6 d0             	movzbl %al,%edx
  800ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef5:	0f b6 c0             	movzbl %al,%eax
  800ef8:	39 c2                	cmp    %eax,%edx
  800efa:	74 0d                	je     800f09 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800efc:	ff 45 08             	incl   0x8(%ebp)
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f05:	72 e3                	jb     800eea <memfind+0x13>
  800f07:	eb 01                	jmp    800f0a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f09:	90                   	nop
	return (void *) s;
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0d:	c9                   	leave  
  800f0e:	c3                   	ret    

00800f0f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0f:	55                   	push   %ebp
  800f10:	89 e5                	mov    %esp,%ebp
  800f12:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f1c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f23:	eb 03                	jmp    800f28 <strtol+0x19>
		s++;
  800f25:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	3c 20                	cmp    $0x20,%al
  800f2f:	74 f4                	je     800f25 <strtol+0x16>
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	3c 09                	cmp    $0x9,%al
  800f38:	74 eb                	je     800f25 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 2b                	cmp    $0x2b,%al
  800f41:	75 05                	jne    800f48 <strtol+0x39>
		s++;
  800f43:	ff 45 08             	incl   0x8(%ebp)
  800f46:	eb 13                	jmp    800f5b <strtol+0x4c>
	else if (*s == '-')
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4b:	8a 00                	mov    (%eax),%al
  800f4d:	3c 2d                	cmp    $0x2d,%al
  800f4f:	75 0a                	jne    800f5b <strtol+0x4c>
		s++, neg = 1;
  800f51:	ff 45 08             	incl   0x8(%ebp)
  800f54:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f5b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5f:	74 06                	je     800f67 <strtol+0x58>
  800f61:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f65:	75 20                	jne    800f87 <strtol+0x78>
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	3c 30                	cmp    $0x30,%al
  800f6e:	75 17                	jne    800f87 <strtol+0x78>
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	40                   	inc    %eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	3c 78                	cmp    $0x78,%al
  800f78:	75 0d                	jne    800f87 <strtol+0x78>
		s += 2, base = 16;
  800f7a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f85:	eb 28                	jmp    800faf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8b:	75 15                	jne    800fa2 <strtol+0x93>
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	3c 30                	cmp    $0x30,%al
  800f94:	75 0c                	jne    800fa2 <strtol+0x93>
		s++, base = 8;
  800f96:	ff 45 08             	incl   0x8(%ebp)
  800f99:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fa0:	eb 0d                	jmp    800faf <strtol+0xa0>
	else if (base == 0)
  800fa2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa6:	75 07                	jne    800faf <strtol+0xa0>
		base = 10;
  800fa8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 2f                	cmp    $0x2f,%al
  800fb6:	7e 19                	jle    800fd1 <strtol+0xc2>
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 39                	cmp    $0x39,%al
  800fbf:	7f 10                	jg     800fd1 <strtol+0xc2>
			dig = *s - '0';
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	0f be c0             	movsbl %al,%eax
  800fc9:	83 e8 30             	sub    $0x30,%eax
  800fcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcf:	eb 42                	jmp    801013 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 60                	cmp    $0x60,%al
  800fd8:	7e 19                	jle    800ff3 <strtol+0xe4>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 7a                	cmp    $0x7a,%al
  800fe1:	7f 10                	jg     800ff3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f be c0             	movsbl %al,%eax
  800feb:	83 e8 57             	sub    $0x57,%eax
  800fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ff1:	eb 20                	jmp    801013 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 40                	cmp    $0x40,%al
  800ffa:	7e 39                	jle    801035 <strtol+0x126>
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	3c 5a                	cmp    $0x5a,%al
  801003:	7f 30                	jg     801035 <strtol+0x126>
			dig = *s - 'A' + 10;
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	0f be c0             	movsbl %al,%eax
  80100d:	83 e8 37             	sub    $0x37,%eax
  801010:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801013:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801016:	3b 45 10             	cmp    0x10(%ebp),%eax
  801019:	7d 19                	jge    801034 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80101b:	ff 45 08             	incl   0x8(%ebp)
  80101e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801021:	0f af 45 10          	imul   0x10(%ebp),%eax
  801025:	89 c2                	mov    %eax,%edx
  801027:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80102a:	01 d0                	add    %edx,%eax
  80102c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102f:	e9 7b ff ff ff       	jmp    800faf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801034:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801035:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801039:	74 08                	je     801043 <strtol+0x134>
		*endptr = (char *) s;
  80103b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103e:	8b 55 08             	mov    0x8(%ebp),%edx
  801041:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801043:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801047:	74 07                	je     801050 <strtol+0x141>
  801049:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104c:	f7 d8                	neg    %eax
  80104e:	eb 03                	jmp    801053 <strtol+0x144>
  801050:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801053:	c9                   	leave  
  801054:	c3                   	ret    

00801055 <ltostr>:

void
ltostr(long value, char *str)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
  801058:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80105b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801062:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801069:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106d:	79 13                	jns    801082 <ltostr+0x2d>
	{
		neg = 1;
  80106f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80107c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80108a:	99                   	cltd   
  80108b:	f7 f9                	idiv   %ecx
  80108d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801090:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801093:	8d 50 01             	lea    0x1(%eax),%edx
  801096:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801099:	89 c2                	mov    %eax,%edx
  80109b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a3:	83 c2 30             	add    $0x30,%edx
  8010a6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ab:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010b0:	f7 e9                	imul   %ecx
  8010b2:	c1 fa 02             	sar    $0x2,%edx
  8010b5:	89 c8                	mov    %ecx,%eax
  8010b7:	c1 f8 1f             	sar    $0x1f,%eax
  8010ba:	29 c2                	sub    %eax,%edx
  8010bc:	89 d0                	mov    %edx,%eax
  8010be:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c9:	f7 e9                	imul   %ecx
  8010cb:	c1 fa 02             	sar    $0x2,%edx
  8010ce:	89 c8                	mov    %ecx,%eax
  8010d0:	c1 f8 1f             	sar    $0x1f,%eax
  8010d3:	29 c2                	sub    %eax,%edx
  8010d5:	89 d0                	mov    %edx,%eax
  8010d7:	c1 e0 02             	shl    $0x2,%eax
  8010da:	01 d0                	add    %edx,%eax
  8010dc:	01 c0                	add    %eax,%eax
  8010de:	29 c1                	sub    %eax,%ecx
  8010e0:	89 ca                	mov    %ecx,%edx
  8010e2:	85 d2                	test   %edx,%edx
  8010e4:	75 9c                	jne    801082 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f0:	48                   	dec    %eax
  8010f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f8:	74 3d                	je     801137 <ltostr+0xe2>
		start = 1 ;
  8010fa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801101:	eb 34                	jmp    801137 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801103:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801106:	8b 45 0c             	mov    0xc(%ebp),%eax
  801109:	01 d0                	add    %edx,%eax
  80110b:	8a 00                	mov    (%eax),%al
  80110d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801110:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801113:	8b 45 0c             	mov    0xc(%ebp),%eax
  801116:	01 c2                	add    %eax,%edx
  801118:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80111b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111e:	01 c8                	add    %ecx,%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801124:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801127:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112a:	01 c2                	add    %eax,%edx
  80112c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112f:	88 02                	mov    %al,(%edx)
		start++ ;
  801131:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801134:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801137:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80113a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80113d:	7c c4                	jl     801103 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	01 d0                	add    %edx,%eax
  801147:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80114a:	90                   	nop
  80114b:	c9                   	leave  
  80114c:	c3                   	ret    

0080114d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80114d:	55                   	push   %ebp
  80114e:	89 e5                	mov    %esp,%ebp
  801150:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801153:	ff 75 08             	pushl  0x8(%ebp)
  801156:	e8 54 fa ff ff       	call   800baf <strlen>
  80115b:	83 c4 04             	add    $0x4,%esp
  80115e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801161:	ff 75 0c             	pushl  0xc(%ebp)
  801164:	e8 46 fa ff ff       	call   800baf <strlen>
  801169:	83 c4 04             	add    $0x4,%esp
  80116c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801176:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117d:	eb 17                	jmp    801196 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801182:	8b 45 10             	mov    0x10(%ebp),%eax
  801185:	01 c2                	add    %eax,%edx
  801187:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	01 c8                	add    %ecx,%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801193:	ff 45 fc             	incl   -0x4(%ebp)
  801196:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801199:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80119c:	7c e1                	jl     80117f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80119e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011ac:	eb 1f                	jmp    8011cd <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b1:	8d 50 01             	lea    0x1(%eax),%edx
  8011b4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b7:	89 c2                	mov    %eax,%edx
  8011b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bc:	01 c2                	add    %eax,%edx
  8011be:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c4:	01 c8                	add    %ecx,%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011ca:	ff 45 f8             	incl   -0x8(%ebp)
  8011cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d3:	7c d9                	jl     8011ae <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011db:	01 d0                	add    %edx,%eax
  8011dd:	c6 00 00             	movb   $0x0,(%eax)
}
  8011e0:	90                   	nop
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f2:	8b 00                	mov    (%eax),%eax
  8011f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fe:	01 d0                	add    %edx,%eax
  801200:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801206:	eb 0c                	jmp    801214 <strsplit+0x31>
			*string++ = 0;
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8d 50 01             	lea    0x1(%eax),%edx
  80120e:	89 55 08             	mov    %edx,0x8(%ebp)
  801211:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	84 c0                	test   %al,%al
  80121b:	74 18                	je     801235 <strsplit+0x52>
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	8a 00                	mov    (%eax),%al
  801222:	0f be c0             	movsbl %al,%eax
  801225:	50                   	push   %eax
  801226:	ff 75 0c             	pushl  0xc(%ebp)
  801229:	e8 13 fb ff ff       	call   800d41 <strchr>
  80122e:	83 c4 08             	add    $0x8,%esp
  801231:	85 c0                	test   %eax,%eax
  801233:	75 d3                	jne    801208 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	84 c0                	test   %al,%al
  80123c:	74 5a                	je     801298 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80123e:	8b 45 14             	mov    0x14(%ebp),%eax
  801241:	8b 00                	mov    (%eax),%eax
  801243:	83 f8 0f             	cmp    $0xf,%eax
  801246:	75 07                	jne    80124f <strsplit+0x6c>
		{
			return 0;
  801248:	b8 00 00 00 00       	mov    $0x0,%eax
  80124d:	eb 66                	jmp    8012b5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124f:	8b 45 14             	mov    0x14(%ebp),%eax
  801252:	8b 00                	mov    (%eax),%eax
  801254:	8d 48 01             	lea    0x1(%eax),%ecx
  801257:	8b 55 14             	mov    0x14(%ebp),%edx
  80125a:	89 0a                	mov    %ecx,(%edx)
  80125c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801263:	8b 45 10             	mov    0x10(%ebp),%eax
  801266:	01 c2                	add    %eax,%edx
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126d:	eb 03                	jmp    801272 <strsplit+0x8f>
			string++;
  80126f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	84 c0                	test   %al,%al
  801279:	74 8b                	je     801206 <strsplit+0x23>
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	8a 00                	mov    (%eax),%al
  801280:	0f be c0             	movsbl %al,%eax
  801283:	50                   	push   %eax
  801284:	ff 75 0c             	pushl  0xc(%ebp)
  801287:	e8 b5 fa ff ff       	call   800d41 <strchr>
  80128c:	83 c4 08             	add    $0x8,%esp
  80128f:	85 c0                	test   %eax,%eax
  801291:	74 dc                	je     80126f <strsplit+0x8c>
			string++;
	}
  801293:	e9 6e ff ff ff       	jmp    801206 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801298:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801299:	8b 45 14             	mov    0x14(%ebp),%eax
  80129c:	8b 00                	mov    (%eax),%eax
  80129e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a8:	01 d0                	add    %edx,%eax
  8012aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b5:	c9                   	leave  
  8012b6:	c3                   	ret    

008012b7 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
  8012ba:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	c1 e8 0c             	shr    $0xc,%eax
  8012c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	25 ff 0f 00 00       	and    $0xfff,%eax
  8012ce:	85 c0                	test   %eax,%eax
  8012d0:	74 03                	je     8012d5 <malloc+0x1e>
			num++;
  8012d2:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8012d5:	a1 04 30 80 00       	mov    0x803004,%eax
  8012da:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8012df:	75 73                	jne    801354 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8012e1:	83 ec 08             	sub    $0x8,%esp
  8012e4:	ff 75 08             	pushl  0x8(%ebp)
  8012e7:	68 00 00 00 80       	push   $0x80000000
  8012ec:	e8 80 04 00 00       	call   801771 <sys_allocateMem>
  8012f1:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8012f4:	a1 04 30 80 00       	mov    0x803004,%eax
  8012f9:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8012fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ff:	c1 e0 0c             	shl    $0xc,%eax
  801302:	89 c2                	mov    %eax,%edx
  801304:	a1 04 30 80 00       	mov    0x803004,%eax
  801309:	01 d0                	add    %edx,%eax
  80130b:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801310:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801315:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801318:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80131f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801324:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80132a:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801331:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801336:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80133d:	01 00 00 00 
			sizeofarray++;
  801341:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801346:	40                   	inc    %eax
  801347:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80134c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80134f:	e9 71 01 00 00       	jmp    8014c5 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801354:	a1 28 30 80 00       	mov    0x803028,%eax
  801359:	85 c0                	test   %eax,%eax
  80135b:	75 71                	jne    8013ce <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  80135d:	a1 04 30 80 00       	mov    0x803004,%eax
  801362:	83 ec 08             	sub    $0x8,%esp
  801365:	ff 75 08             	pushl  0x8(%ebp)
  801368:	50                   	push   %eax
  801369:	e8 03 04 00 00       	call   801771 <sys_allocateMem>
  80136e:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801371:	a1 04 30 80 00       	mov    0x803004,%eax
  801376:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801379:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80137c:	c1 e0 0c             	shl    $0xc,%eax
  80137f:	89 c2                	mov    %eax,%edx
  801381:	a1 04 30 80 00       	mov    0x803004,%eax
  801386:	01 d0                	add    %edx,%eax
  801388:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  80138d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801392:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801395:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80139c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013a1:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8013a4:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8013ab:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013b0:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8013b7:	01 00 00 00 
				sizeofarray++;
  8013bb:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013c0:	40                   	inc    %eax
  8013c1:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8013c6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8013c9:	e9 f7 00 00 00       	jmp    8014c5 <malloc+0x20e>
			}
			else{
				int count=0;
  8013ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8013d5:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8013dc:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8013e3:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8013ea:	eb 7c                	jmp    801468 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8013ec:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8013f3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8013fa:	eb 1a                	jmp    801416 <malloc+0x15f>
					{
						if(addresses[j]==i)
  8013fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013ff:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801406:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801409:	75 08                	jne    801413 <malloc+0x15c>
						{
							index=j;
  80140b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80140e:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801411:	eb 0d                	jmp    801420 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801413:	ff 45 dc             	incl   -0x24(%ebp)
  801416:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80141b:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80141e:	7c dc                	jl     8013fc <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801420:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801424:	75 05                	jne    80142b <malloc+0x174>
					{
						count++;
  801426:	ff 45 f0             	incl   -0x10(%ebp)
  801429:	eb 36                	jmp    801461 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  80142b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80142e:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801435:	85 c0                	test   %eax,%eax
  801437:	75 05                	jne    80143e <malloc+0x187>
						{
							count++;
  801439:	ff 45 f0             	incl   -0x10(%ebp)
  80143c:	eb 23                	jmp    801461 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  80143e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801441:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801444:	7d 14                	jge    80145a <malloc+0x1a3>
  801446:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801449:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80144c:	7c 0c                	jl     80145a <malloc+0x1a3>
							{
								min=count;
  80144e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801451:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801454:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801457:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80145a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801461:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801468:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80146f:	0f 86 77 ff ff ff    	jbe    8013ec <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801475:	83 ec 08             	sub    $0x8,%esp
  801478:	ff 75 08             	pushl  0x8(%ebp)
  80147b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80147e:	e8 ee 02 00 00       	call   801771 <sys_allocateMem>
  801483:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801486:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80148b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80148e:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801495:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80149a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8014a0:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8014a7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014ac:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8014b3:	01 00 00 00 
				sizeofarray++;
  8014b7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014bc:	40                   	inc    %eax
  8014bd:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  8014c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  8014ca:	90                   	nop
  8014cb:	5d                   	pop    %ebp
  8014cc:	c3                   	ret    

008014cd <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 18             	sub    $0x18,%esp
  8014d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d6:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8014d9:	83 ec 04             	sub    $0x4,%esp
  8014dc:	68 b0 25 80 00       	push   $0x8025b0
  8014e1:	68 8d 00 00 00       	push   $0x8d
  8014e6:	68 d3 25 80 00       	push   $0x8025d3
  8014eb:	e8 9b ed ff ff       	call   80028b <_panic>

008014f0 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
  8014f3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014f6:	83 ec 04             	sub    $0x4,%esp
  8014f9:	68 b0 25 80 00       	push   $0x8025b0
  8014fe:	68 93 00 00 00       	push   $0x93
  801503:	68 d3 25 80 00       	push   $0x8025d3
  801508:	e8 7e ed ff ff       	call   80028b <_panic>

0080150d <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801513:	83 ec 04             	sub    $0x4,%esp
  801516:	68 b0 25 80 00       	push   $0x8025b0
  80151b:	68 99 00 00 00       	push   $0x99
  801520:	68 d3 25 80 00       	push   $0x8025d3
  801525:	e8 61 ed ff ff       	call   80028b <_panic>

0080152a <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80152a:	55                   	push   %ebp
  80152b:	89 e5                	mov    %esp,%ebp
  80152d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801530:	83 ec 04             	sub    $0x4,%esp
  801533:	68 b0 25 80 00       	push   $0x8025b0
  801538:	68 9e 00 00 00       	push   $0x9e
  80153d:	68 d3 25 80 00       	push   $0x8025d3
  801542:	e8 44 ed ff ff       	call   80028b <_panic>

00801547 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
  80154a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80154d:	83 ec 04             	sub    $0x4,%esp
  801550:	68 b0 25 80 00       	push   $0x8025b0
  801555:	68 a4 00 00 00       	push   $0xa4
  80155a:	68 d3 25 80 00       	push   $0x8025d3
  80155f:	e8 27 ed ff ff       	call   80028b <_panic>

00801564 <shrink>:
}
void shrink(uint32 newSize)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
  801567:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80156a:	83 ec 04             	sub    $0x4,%esp
  80156d:	68 b0 25 80 00       	push   $0x8025b0
  801572:	68 a8 00 00 00       	push   $0xa8
  801577:	68 d3 25 80 00       	push   $0x8025d3
  80157c:	e8 0a ed ff ff       	call   80028b <_panic>

00801581 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801587:	83 ec 04             	sub    $0x4,%esp
  80158a:	68 b0 25 80 00       	push   $0x8025b0
  80158f:	68 ad 00 00 00       	push   $0xad
  801594:	68 d3 25 80 00       	push   $0x8025d3
  801599:	e8 ed ec ff ff       	call   80028b <_panic>

0080159e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
  8015a1:	57                   	push   %edi
  8015a2:	56                   	push   %esi
  8015a3:	53                   	push   %ebx
  8015a4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015b0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015b3:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015b6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015b9:	cd 30                	int    $0x30
  8015bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015c1:	83 c4 10             	add    $0x10,%esp
  8015c4:	5b                   	pop    %ebx
  8015c5:	5e                   	pop    %esi
  8015c6:	5f                   	pop    %edi
  8015c7:	5d                   	pop    %ebp
  8015c8:	c3                   	ret    

008015c9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
  8015cc:	83 ec 04             	sub    $0x4,%esp
  8015cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8015d5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	52                   	push   %edx
  8015e1:	ff 75 0c             	pushl  0xc(%ebp)
  8015e4:	50                   	push   %eax
  8015e5:	6a 00                	push   $0x0
  8015e7:	e8 b2 ff ff ff       	call   80159e <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
}
  8015ef:	90                   	nop
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_cgetc>:

int
sys_cgetc(void)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 01                	push   $0x1
  801601:	e8 98 ff ff ff       	call   80159e <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	50                   	push   %eax
  80161a:	6a 05                	push   $0x5
  80161c:	e8 7d ff ff ff       	call   80159e <syscall>
  801621:	83 c4 18             	add    $0x18,%esp
}
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 02                	push   $0x2
  801635:	e8 64 ff ff ff       	call   80159e <syscall>
  80163a:	83 c4 18             	add    $0x18,%esp
}
  80163d:	c9                   	leave  
  80163e:	c3                   	ret    

0080163f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80163f:	55                   	push   %ebp
  801640:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 03                	push   $0x3
  80164e:	e8 4b ff ff ff       	call   80159e <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 04                	push   $0x4
  801667:	e8 32 ff ff ff       	call   80159e <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <sys_env_exit>:


void sys_env_exit(void)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 06                	push   $0x6
  801680:	e8 19 ff ff ff       	call   80159e <syscall>
  801685:	83 c4 18             	add    $0x18,%esp
}
  801688:	90                   	nop
  801689:	c9                   	leave  
  80168a:	c3                   	ret    

0080168b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80168b:	55                   	push   %ebp
  80168c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80168e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	52                   	push   %edx
  80169b:	50                   	push   %eax
  80169c:	6a 07                	push   $0x7
  80169e:	e8 fb fe ff ff       	call   80159e <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	c9                   	leave  
  8016a7:	c3                   	ret    

008016a8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
  8016ab:	56                   	push   %esi
  8016ac:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016ad:	8b 75 18             	mov    0x18(%ebp),%esi
  8016b0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	56                   	push   %esi
  8016bd:	53                   	push   %ebx
  8016be:	51                   	push   %ecx
  8016bf:	52                   	push   %edx
  8016c0:	50                   	push   %eax
  8016c1:	6a 08                	push   $0x8
  8016c3:	e8 d6 fe ff ff       	call   80159e <syscall>
  8016c8:	83 c4 18             	add    $0x18,%esp
}
  8016cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016ce:	5b                   	pop    %ebx
  8016cf:	5e                   	pop    %esi
  8016d0:	5d                   	pop    %ebp
  8016d1:	c3                   	ret    

008016d2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8016d2:	55                   	push   %ebp
  8016d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8016d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	52                   	push   %edx
  8016e2:	50                   	push   %eax
  8016e3:	6a 09                	push   $0x9
  8016e5:	e8 b4 fe ff ff       	call   80159e <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
}
  8016ed:	c9                   	leave  
  8016ee:	c3                   	ret    

008016ef <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	ff 75 0c             	pushl  0xc(%ebp)
  8016fb:	ff 75 08             	pushl  0x8(%ebp)
  8016fe:	6a 0a                	push   $0xa
  801700:	e8 99 fe ff ff       	call   80159e <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 0b                	push   $0xb
  801719:	e8 80 fe ff ff       	call   80159e <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 0c                	push   $0xc
  801732:	e8 67 fe ff ff       	call   80159e <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 0d                	push   $0xd
  80174b:	e8 4e fe ff ff       	call   80159e <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	ff 75 0c             	pushl  0xc(%ebp)
  801761:	ff 75 08             	pushl  0x8(%ebp)
  801764:	6a 11                	push   $0x11
  801766:	e8 33 fe ff ff       	call   80159e <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
	return;
  80176e:	90                   	nop
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	ff 75 0c             	pushl  0xc(%ebp)
  80177d:	ff 75 08             	pushl  0x8(%ebp)
  801780:	6a 12                	push   $0x12
  801782:	e8 17 fe ff ff       	call   80159e <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
	return ;
  80178a:	90                   	nop
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 0e                	push   $0xe
  80179c:	e8 fd fd ff ff       	call   80159e <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	ff 75 08             	pushl  0x8(%ebp)
  8017b4:	6a 0f                	push   $0xf
  8017b6:	e8 e3 fd ff ff       	call   80159e <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 10                	push   $0x10
  8017cf:	e8 ca fd ff ff       	call   80159e <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	90                   	nop
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 14                	push   $0x14
  8017e9:	e8 b0 fd ff ff       	call   80159e <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
}
  8017f1:	90                   	nop
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 15                	push   $0x15
  801803:	e8 96 fd ff ff       	call   80159e <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	90                   	nop
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_cputc>:


void
sys_cputc(const char c)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 04             	sub    $0x4,%esp
  801814:	8b 45 08             	mov    0x8(%ebp),%eax
  801817:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80181a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	50                   	push   %eax
  801827:	6a 16                	push   $0x16
  801829:	e8 70 fd ff ff       	call   80159e <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	90                   	nop
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 17                	push   $0x17
  801843:	e8 56 fd ff ff       	call   80159e <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
}
  80184b:	90                   	nop
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	ff 75 0c             	pushl  0xc(%ebp)
  80185d:	50                   	push   %eax
  80185e:	6a 18                	push   $0x18
  801860:	e8 39 fd ff ff       	call   80159e <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80186d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	52                   	push   %edx
  80187a:	50                   	push   %eax
  80187b:	6a 1b                	push   $0x1b
  80187d:	e8 1c fd ff ff       	call   80159e <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80188a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188d:	8b 45 08             	mov    0x8(%ebp),%eax
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	52                   	push   %edx
  801897:	50                   	push   %eax
  801898:	6a 19                	push   $0x19
  80189a:	e8 ff fc ff ff       	call   80159e <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
}
  8018a2:	90                   	nop
  8018a3:	c9                   	leave  
  8018a4:	c3                   	ret    

008018a5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	52                   	push   %edx
  8018b5:	50                   	push   %eax
  8018b6:	6a 1a                	push   $0x1a
  8018b8:	e8 e1 fc ff ff       	call   80159e <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
}
  8018c0:	90                   	nop
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
  8018c6:	83 ec 04             	sub    $0x4,%esp
  8018c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018cf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018d2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	6a 00                	push   $0x0
  8018db:	51                   	push   %ecx
  8018dc:	52                   	push   %edx
  8018dd:	ff 75 0c             	pushl  0xc(%ebp)
  8018e0:	50                   	push   %eax
  8018e1:	6a 1c                	push   $0x1c
  8018e3:	e8 b6 fc ff ff       	call   80159e <syscall>
  8018e8:	83 c4 18             	add    $0x18,%esp
}
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8018f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	52                   	push   %edx
  8018fd:	50                   	push   %eax
  8018fe:	6a 1d                	push   $0x1d
  801900:	e8 99 fc ff ff       	call   80159e <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
}
  801908:	c9                   	leave  
  801909:	c3                   	ret    

0080190a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80190a:	55                   	push   %ebp
  80190b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80190d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801910:	8b 55 0c             	mov    0xc(%ebp),%edx
  801913:	8b 45 08             	mov    0x8(%ebp),%eax
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	51                   	push   %ecx
  80191b:	52                   	push   %edx
  80191c:	50                   	push   %eax
  80191d:	6a 1e                	push   $0x1e
  80191f:	e8 7a fc ff ff       	call   80159e <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80192c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192f:	8b 45 08             	mov    0x8(%ebp),%eax
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	52                   	push   %edx
  801939:	50                   	push   %eax
  80193a:	6a 1f                	push   $0x1f
  80193c:	e8 5d fc ff ff       	call   80159e <syscall>
  801941:	83 c4 18             	add    $0x18,%esp
}
  801944:	c9                   	leave  
  801945:	c3                   	ret    

00801946 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 20                	push   $0x20
  801955:	e8 44 fc ff ff       	call   80159e <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
}
  80195d:	c9                   	leave  
  80195e:	c3                   	ret    

0080195f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80195f:	55                   	push   %ebp
  801960:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	6a 00                	push   $0x0
  801967:	ff 75 14             	pushl  0x14(%ebp)
  80196a:	ff 75 10             	pushl  0x10(%ebp)
  80196d:	ff 75 0c             	pushl  0xc(%ebp)
  801970:	50                   	push   %eax
  801971:	6a 21                	push   $0x21
  801973:	e8 26 fc ff ff       	call   80159e <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801980:	8b 45 08             	mov    0x8(%ebp),%eax
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	50                   	push   %eax
  80198c:	6a 22                	push   $0x22
  80198e:	e8 0b fc ff ff       	call   80159e <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
}
  801996:	90                   	nop
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	50                   	push   %eax
  8019a8:	6a 23                	push   $0x23
  8019aa:	e8 ef fb ff ff       	call   80159e <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
}
  8019b2:	90                   	nop
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
  8019b8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019bb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019be:	8d 50 04             	lea    0x4(%eax),%edx
  8019c1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	52                   	push   %edx
  8019cb:	50                   	push   %eax
  8019cc:	6a 24                	push   $0x24
  8019ce:	e8 cb fb ff ff       	call   80159e <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
	return result;
  8019d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019df:	89 01                	mov    %eax,(%ecx)
  8019e1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8019e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e7:	c9                   	leave  
  8019e8:	c2 04 00             	ret    $0x4

008019eb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	ff 75 10             	pushl  0x10(%ebp)
  8019f5:	ff 75 0c             	pushl  0xc(%ebp)
  8019f8:	ff 75 08             	pushl  0x8(%ebp)
  8019fb:	6a 13                	push   $0x13
  8019fd:	e8 9c fb ff ff       	call   80159e <syscall>
  801a02:	83 c4 18             	add    $0x18,%esp
	return ;
  801a05:	90                   	nop
}
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 25                	push   $0x25
  801a17:	e8 82 fb ff ff       	call   80159e <syscall>
  801a1c:	83 c4 18             	add    $0x18,%esp
}
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    

00801a21 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a21:	55                   	push   %ebp
  801a22:	89 e5                	mov    %esp,%ebp
  801a24:	83 ec 04             	sub    $0x4,%esp
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a2d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	50                   	push   %eax
  801a3a:	6a 26                	push   $0x26
  801a3c:	e8 5d fb ff ff       	call   80159e <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
	return ;
  801a44:	90                   	nop
}
  801a45:	c9                   	leave  
  801a46:	c3                   	ret    

00801a47 <rsttst>:
void rsttst()
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 28                	push   $0x28
  801a56:	e8 43 fb ff ff       	call   80159e <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5e:	90                   	nop
}
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
  801a64:	83 ec 04             	sub    $0x4,%esp
  801a67:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a6d:	8b 55 18             	mov    0x18(%ebp),%edx
  801a70:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a74:	52                   	push   %edx
  801a75:	50                   	push   %eax
  801a76:	ff 75 10             	pushl  0x10(%ebp)
  801a79:	ff 75 0c             	pushl  0xc(%ebp)
  801a7c:	ff 75 08             	pushl  0x8(%ebp)
  801a7f:	6a 27                	push   $0x27
  801a81:	e8 18 fb ff ff       	call   80159e <syscall>
  801a86:	83 c4 18             	add    $0x18,%esp
	return ;
  801a89:	90                   	nop
}
  801a8a:	c9                   	leave  
  801a8b:	c3                   	ret    

00801a8c <chktst>:
void chktst(uint32 n)
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	ff 75 08             	pushl  0x8(%ebp)
  801a9a:	6a 29                	push   $0x29
  801a9c:	e8 fd fa ff ff       	call   80159e <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa4:	90                   	nop
}
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <inctst>:

void inctst()
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 2a                	push   $0x2a
  801ab6:	e8 e3 fa ff ff       	call   80159e <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
	return ;
  801abe:	90                   	nop
}
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <gettst>:
uint32 gettst()
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 2b                	push   $0x2b
  801ad0:	e8 c9 fa ff ff       	call   80159e <syscall>
  801ad5:	83 c4 18             	add    $0x18,%esp
}
  801ad8:	c9                   	leave  
  801ad9:	c3                   	ret    

00801ada <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ada:	55                   	push   %ebp
  801adb:	89 e5                	mov    %esp,%ebp
  801add:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 2c                	push   $0x2c
  801aec:	e8 ad fa ff ff       	call   80159e <syscall>
  801af1:	83 c4 18             	add    $0x18,%esp
  801af4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801af7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801afb:	75 07                	jne    801b04 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801afd:	b8 01 00 00 00       	mov    $0x1,%eax
  801b02:	eb 05                	jmp    801b09 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b04:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 2c                	push   $0x2c
  801b1d:	e8 7c fa ff ff       	call   80159e <syscall>
  801b22:	83 c4 18             	add    $0x18,%esp
  801b25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b28:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b2c:	75 07                	jne    801b35 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b33:	eb 05                	jmp    801b3a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b35:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b3a:	c9                   	leave  
  801b3b:	c3                   	ret    

00801b3c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
  801b3f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 2c                	push   $0x2c
  801b4e:	e8 4b fa ff ff       	call   80159e <syscall>
  801b53:	83 c4 18             	add    $0x18,%esp
  801b56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b59:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b5d:	75 07                	jne    801b66 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b5f:	b8 01 00 00 00       	mov    $0x1,%eax
  801b64:	eb 05                	jmp    801b6b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b66:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b6b:	c9                   	leave  
  801b6c:	c3                   	ret    

00801b6d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b6d:	55                   	push   %ebp
  801b6e:	89 e5                	mov    %esp,%ebp
  801b70:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 2c                	push   $0x2c
  801b7f:	e8 1a fa ff ff       	call   80159e <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
  801b87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b8a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b8e:	75 07                	jne    801b97 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b90:	b8 01 00 00 00       	mov    $0x1,%eax
  801b95:	eb 05                	jmp    801b9c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b97:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b9c:	c9                   	leave  
  801b9d:	c3                   	ret    

00801b9e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	ff 75 08             	pushl  0x8(%ebp)
  801bac:	6a 2d                	push   $0x2d
  801bae:	e8 eb f9 ff ff       	call   80159e <syscall>
  801bb3:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb6:	90                   	nop
}
  801bb7:	c9                   	leave  
  801bb8:	c3                   	ret    

00801bb9 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801bb9:	55                   	push   %ebp
  801bba:	89 e5                	mov    %esp,%ebp
  801bbc:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bbd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bc0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc9:	6a 00                	push   $0x0
  801bcb:	53                   	push   %ebx
  801bcc:	51                   	push   %ecx
  801bcd:	52                   	push   %edx
  801bce:	50                   	push   %eax
  801bcf:	6a 2e                	push   $0x2e
  801bd1:	e8 c8 f9 ff ff       	call   80159e <syscall>
  801bd6:	83 c4 18             	add    $0x18,%esp
}
  801bd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801be1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be4:	8b 45 08             	mov    0x8(%ebp),%eax
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	52                   	push   %edx
  801bee:	50                   	push   %eax
  801bef:	6a 2f                	push   $0x2f
  801bf1:	e8 a8 f9 ff ff       	call   80159e <syscall>
  801bf6:	83 c4 18             	add    $0x18,%esp
}
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    
  801bfb:	90                   	nop

00801bfc <__udivdi3>:
  801bfc:	55                   	push   %ebp
  801bfd:	57                   	push   %edi
  801bfe:	56                   	push   %esi
  801bff:	53                   	push   %ebx
  801c00:	83 ec 1c             	sub    $0x1c,%esp
  801c03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c13:	89 ca                	mov    %ecx,%edx
  801c15:	89 f8                	mov    %edi,%eax
  801c17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c1b:	85 f6                	test   %esi,%esi
  801c1d:	75 2d                	jne    801c4c <__udivdi3+0x50>
  801c1f:	39 cf                	cmp    %ecx,%edi
  801c21:	77 65                	ja     801c88 <__udivdi3+0x8c>
  801c23:	89 fd                	mov    %edi,%ebp
  801c25:	85 ff                	test   %edi,%edi
  801c27:	75 0b                	jne    801c34 <__udivdi3+0x38>
  801c29:	b8 01 00 00 00       	mov    $0x1,%eax
  801c2e:	31 d2                	xor    %edx,%edx
  801c30:	f7 f7                	div    %edi
  801c32:	89 c5                	mov    %eax,%ebp
  801c34:	31 d2                	xor    %edx,%edx
  801c36:	89 c8                	mov    %ecx,%eax
  801c38:	f7 f5                	div    %ebp
  801c3a:	89 c1                	mov    %eax,%ecx
  801c3c:	89 d8                	mov    %ebx,%eax
  801c3e:	f7 f5                	div    %ebp
  801c40:	89 cf                	mov    %ecx,%edi
  801c42:	89 fa                	mov    %edi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	39 ce                	cmp    %ecx,%esi
  801c4e:	77 28                	ja     801c78 <__udivdi3+0x7c>
  801c50:	0f bd fe             	bsr    %esi,%edi
  801c53:	83 f7 1f             	xor    $0x1f,%edi
  801c56:	75 40                	jne    801c98 <__udivdi3+0x9c>
  801c58:	39 ce                	cmp    %ecx,%esi
  801c5a:	72 0a                	jb     801c66 <__udivdi3+0x6a>
  801c5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c60:	0f 87 9e 00 00 00    	ja     801d04 <__udivdi3+0x108>
  801c66:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6b:	89 fa                	mov    %edi,%edx
  801c6d:	83 c4 1c             	add    $0x1c,%esp
  801c70:	5b                   	pop    %ebx
  801c71:	5e                   	pop    %esi
  801c72:	5f                   	pop    %edi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    
  801c75:	8d 76 00             	lea    0x0(%esi),%esi
  801c78:	31 ff                	xor    %edi,%edi
  801c7a:	31 c0                	xor    %eax,%eax
  801c7c:	89 fa                	mov    %edi,%edx
  801c7e:	83 c4 1c             	add    $0x1c,%esp
  801c81:	5b                   	pop    %ebx
  801c82:	5e                   	pop    %esi
  801c83:	5f                   	pop    %edi
  801c84:	5d                   	pop    %ebp
  801c85:	c3                   	ret    
  801c86:	66 90                	xchg   %ax,%ax
  801c88:	89 d8                	mov    %ebx,%eax
  801c8a:	f7 f7                	div    %edi
  801c8c:	31 ff                	xor    %edi,%edi
  801c8e:	89 fa                	mov    %edi,%edx
  801c90:	83 c4 1c             	add    $0x1c,%esp
  801c93:	5b                   	pop    %ebx
  801c94:	5e                   	pop    %esi
  801c95:	5f                   	pop    %edi
  801c96:	5d                   	pop    %ebp
  801c97:	c3                   	ret    
  801c98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c9d:	89 eb                	mov    %ebp,%ebx
  801c9f:	29 fb                	sub    %edi,%ebx
  801ca1:	89 f9                	mov    %edi,%ecx
  801ca3:	d3 e6                	shl    %cl,%esi
  801ca5:	89 c5                	mov    %eax,%ebp
  801ca7:	88 d9                	mov    %bl,%cl
  801ca9:	d3 ed                	shr    %cl,%ebp
  801cab:	89 e9                	mov    %ebp,%ecx
  801cad:	09 f1                	or     %esi,%ecx
  801caf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cb3:	89 f9                	mov    %edi,%ecx
  801cb5:	d3 e0                	shl    %cl,%eax
  801cb7:	89 c5                	mov    %eax,%ebp
  801cb9:	89 d6                	mov    %edx,%esi
  801cbb:	88 d9                	mov    %bl,%cl
  801cbd:	d3 ee                	shr    %cl,%esi
  801cbf:	89 f9                	mov    %edi,%ecx
  801cc1:	d3 e2                	shl    %cl,%edx
  801cc3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cc7:	88 d9                	mov    %bl,%cl
  801cc9:	d3 e8                	shr    %cl,%eax
  801ccb:	09 c2                	or     %eax,%edx
  801ccd:	89 d0                	mov    %edx,%eax
  801ccf:	89 f2                	mov    %esi,%edx
  801cd1:	f7 74 24 0c          	divl   0xc(%esp)
  801cd5:	89 d6                	mov    %edx,%esi
  801cd7:	89 c3                	mov    %eax,%ebx
  801cd9:	f7 e5                	mul    %ebp
  801cdb:	39 d6                	cmp    %edx,%esi
  801cdd:	72 19                	jb     801cf8 <__udivdi3+0xfc>
  801cdf:	74 0b                	je     801cec <__udivdi3+0xf0>
  801ce1:	89 d8                	mov    %ebx,%eax
  801ce3:	31 ff                	xor    %edi,%edi
  801ce5:	e9 58 ff ff ff       	jmp    801c42 <__udivdi3+0x46>
  801cea:	66 90                	xchg   %ax,%ax
  801cec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801cf0:	89 f9                	mov    %edi,%ecx
  801cf2:	d3 e2                	shl    %cl,%edx
  801cf4:	39 c2                	cmp    %eax,%edx
  801cf6:	73 e9                	jae    801ce1 <__udivdi3+0xe5>
  801cf8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801cfb:	31 ff                	xor    %edi,%edi
  801cfd:	e9 40 ff ff ff       	jmp    801c42 <__udivdi3+0x46>
  801d02:	66 90                	xchg   %ax,%ax
  801d04:	31 c0                	xor    %eax,%eax
  801d06:	e9 37 ff ff ff       	jmp    801c42 <__udivdi3+0x46>
  801d0b:	90                   	nop

00801d0c <__umoddi3>:
  801d0c:	55                   	push   %ebp
  801d0d:	57                   	push   %edi
  801d0e:	56                   	push   %esi
  801d0f:	53                   	push   %ebx
  801d10:	83 ec 1c             	sub    $0x1c,%esp
  801d13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d2b:	89 f3                	mov    %esi,%ebx
  801d2d:	89 fa                	mov    %edi,%edx
  801d2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d33:	89 34 24             	mov    %esi,(%esp)
  801d36:	85 c0                	test   %eax,%eax
  801d38:	75 1a                	jne    801d54 <__umoddi3+0x48>
  801d3a:	39 f7                	cmp    %esi,%edi
  801d3c:	0f 86 a2 00 00 00    	jbe    801de4 <__umoddi3+0xd8>
  801d42:	89 c8                	mov    %ecx,%eax
  801d44:	89 f2                	mov    %esi,%edx
  801d46:	f7 f7                	div    %edi
  801d48:	89 d0                	mov    %edx,%eax
  801d4a:	31 d2                	xor    %edx,%edx
  801d4c:	83 c4 1c             	add    $0x1c,%esp
  801d4f:	5b                   	pop    %ebx
  801d50:	5e                   	pop    %esi
  801d51:	5f                   	pop    %edi
  801d52:	5d                   	pop    %ebp
  801d53:	c3                   	ret    
  801d54:	39 f0                	cmp    %esi,%eax
  801d56:	0f 87 ac 00 00 00    	ja     801e08 <__umoddi3+0xfc>
  801d5c:	0f bd e8             	bsr    %eax,%ebp
  801d5f:	83 f5 1f             	xor    $0x1f,%ebp
  801d62:	0f 84 ac 00 00 00    	je     801e14 <__umoddi3+0x108>
  801d68:	bf 20 00 00 00       	mov    $0x20,%edi
  801d6d:	29 ef                	sub    %ebp,%edi
  801d6f:	89 fe                	mov    %edi,%esi
  801d71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d75:	89 e9                	mov    %ebp,%ecx
  801d77:	d3 e0                	shl    %cl,%eax
  801d79:	89 d7                	mov    %edx,%edi
  801d7b:	89 f1                	mov    %esi,%ecx
  801d7d:	d3 ef                	shr    %cl,%edi
  801d7f:	09 c7                	or     %eax,%edi
  801d81:	89 e9                	mov    %ebp,%ecx
  801d83:	d3 e2                	shl    %cl,%edx
  801d85:	89 14 24             	mov    %edx,(%esp)
  801d88:	89 d8                	mov    %ebx,%eax
  801d8a:	d3 e0                	shl    %cl,%eax
  801d8c:	89 c2                	mov    %eax,%edx
  801d8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d92:	d3 e0                	shl    %cl,%eax
  801d94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d9c:	89 f1                	mov    %esi,%ecx
  801d9e:	d3 e8                	shr    %cl,%eax
  801da0:	09 d0                	or     %edx,%eax
  801da2:	d3 eb                	shr    %cl,%ebx
  801da4:	89 da                	mov    %ebx,%edx
  801da6:	f7 f7                	div    %edi
  801da8:	89 d3                	mov    %edx,%ebx
  801daa:	f7 24 24             	mull   (%esp)
  801dad:	89 c6                	mov    %eax,%esi
  801daf:	89 d1                	mov    %edx,%ecx
  801db1:	39 d3                	cmp    %edx,%ebx
  801db3:	0f 82 87 00 00 00    	jb     801e40 <__umoddi3+0x134>
  801db9:	0f 84 91 00 00 00    	je     801e50 <__umoddi3+0x144>
  801dbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801dc3:	29 f2                	sub    %esi,%edx
  801dc5:	19 cb                	sbb    %ecx,%ebx
  801dc7:	89 d8                	mov    %ebx,%eax
  801dc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801dcd:	d3 e0                	shl    %cl,%eax
  801dcf:	89 e9                	mov    %ebp,%ecx
  801dd1:	d3 ea                	shr    %cl,%edx
  801dd3:	09 d0                	or     %edx,%eax
  801dd5:	89 e9                	mov    %ebp,%ecx
  801dd7:	d3 eb                	shr    %cl,%ebx
  801dd9:	89 da                	mov    %ebx,%edx
  801ddb:	83 c4 1c             	add    $0x1c,%esp
  801dde:	5b                   	pop    %ebx
  801ddf:	5e                   	pop    %esi
  801de0:	5f                   	pop    %edi
  801de1:	5d                   	pop    %ebp
  801de2:	c3                   	ret    
  801de3:	90                   	nop
  801de4:	89 fd                	mov    %edi,%ebp
  801de6:	85 ff                	test   %edi,%edi
  801de8:	75 0b                	jne    801df5 <__umoddi3+0xe9>
  801dea:	b8 01 00 00 00       	mov    $0x1,%eax
  801def:	31 d2                	xor    %edx,%edx
  801df1:	f7 f7                	div    %edi
  801df3:	89 c5                	mov    %eax,%ebp
  801df5:	89 f0                	mov    %esi,%eax
  801df7:	31 d2                	xor    %edx,%edx
  801df9:	f7 f5                	div    %ebp
  801dfb:	89 c8                	mov    %ecx,%eax
  801dfd:	f7 f5                	div    %ebp
  801dff:	89 d0                	mov    %edx,%eax
  801e01:	e9 44 ff ff ff       	jmp    801d4a <__umoddi3+0x3e>
  801e06:	66 90                	xchg   %ax,%ax
  801e08:	89 c8                	mov    %ecx,%eax
  801e0a:	89 f2                	mov    %esi,%edx
  801e0c:	83 c4 1c             	add    $0x1c,%esp
  801e0f:	5b                   	pop    %ebx
  801e10:	5e                   	pop    %esi
  801e11:	5f                   	pop    %edi
  801e12:	5d                   	pop    %ebp
  801e13:	c3                   	ret    
  801e14:	3b 04 24             	cmp    (%esp),%eax
  801e17:	72 06                	jb     801e1f <__umoddi3+0x113>
  801e19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e1d:	77 0f                	ja     801e2e <__umoddi3+0x122>
  801e1f:	89 f2                	mov    %esi,%edx
  801e21:	29 f9                	sub    %edi,%ecx
  801e23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e27:	89 14 24             	mov    %edx,(%esp)
  801e2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e32:	8b 14 24             	mov    (%esp),%edx
  801e35:	83 c4 1c             	add    $0x1c,%esp
  801e38:	5b                   	pop    %ebx
  801e39:	5e                   	pop    %esi
  801e3a:	5f                   	pop    %edi
  801e3b:	5d                   	pop    %ebp
  801e3c:	c3                   	ret    
  801e3d:	8d 76 00             	lea    0x0(%esi),%esi
  801e40:	2b 04 24             	sub    (%esp),%eax
  801e43:	19 fa                	sbb    %edi,%edx
  801e45:	89 d1                	mov    %edx,%ecx
  801e47:	89 c6                	mov    %eax,%esi
  801e49:	e9 71 ff ff ff       	jmp    801dbf <__umoddi3+0xb3>
  801e4e:	66 90                	xchg   %ax,%ax
  801e50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e54:	72 ea                	jb     801e40 <__umoddi3+0x134>
  801e56:	89 d9                	mov    %ebx,%ecx
  801e58:	e9 62 ff ff ff       	jmp    801dbf <__umoddi3+0xb3>
