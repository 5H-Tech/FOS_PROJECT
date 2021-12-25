
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
  800045:	68 c0 1f 80 00       	push   $0x801fc0
  80004a:	e8 c9 15 00 00       	call   801618 <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 f2 17 00 00       	call   801855 <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 6d 18 00 00       	call   8018d8 <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 d0 1f 80 00       	push   $0x801fd0
  800079:	e8 af 04 00 00       	call   80052d <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tshr4", 2000,(myEnv->SecondListSize), 50);
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80008c:	6a 32                	push   $0x32
  80008e:	50                   	push   %eax
  80008f:	68 d0 07 00 00       	push   $0x7d0
  800094:	68 03 20 80 00       	push   $0x802003
  800099:	e8 0c 1a 00 00       	call   801aaa <sys_create_env>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(envIdProcessA);
  8000a4:	83 ec 0c             	sub    $0xc,%esp
  8000a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000aa:	e8 19 1a 00 00       	call   801ac8 <sys_run_env>
  8000af:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 1) ;
  8000b2:	90                   	nop
  8000b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	83 f8 01             	cmp    $0x1,%eax
  8000bb:	75 f6                	jne    8000b3 <_main+0x7b>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000bd:	e8 93 17 00 00       	call   801855 <sys_calculate_free_frames>
  8000c2:	83 ec 08             	sub    $0x8,%esp
  8000c5:	50                   	push   %eax
  8000c6:	68 0c 20 80 00       	push   $0x80200c
  8000cb:	e8 5d 04 00 00       	call   80052d <cprintf>
  8000d0:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  8000d3:	83 ec 0c             	sub    $0xc,%esp
  8000d6:	ff 75 e8             	pushl  -0x18(%ebp)
  8000d9:	e8 06 1a 00 00       	call   801ae4 <sys_free_env>
  8000de:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  8000e1:	e8 6f 17 00 00       	call   801855 <sys_calculate_free_frames>
  8000e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  8000e9:	e8 ea 17 00 00       	call   8018d8 <sys_pf_calculate_allocated_pages>
  8000ee:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000f7:	74 27                	je     800120 <_main+0xe8>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n", freeFrames_after);
  8000f9:	83 ec 08             	sub    $0x8,%esp
  8000fc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000ff:	68 40 20 80 00       	push   $0x802040
  800104:	e8 24 04 00 00       	call   80052d <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp
		panic("env_free() does not work correctly... check it again.");
  80010c:	83 ec 04             	sub    $0x4,%esp
  80010f:	68 90 20 80 00       	push   $0x802090
  800114:	6a 1e                	push   $0x1e
  800116:	68 c6 20 80 00       	push   $0x8020c6
  80011b:	e8 6b 01 00 00       	call   80028b <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  800120:	83 ec 08             	sub    $0x8,%esp
  800123:	ff 75 e4             	pushl  -0x1c(%ebp)
  800126:	68 dc 20 80 00       	push   $0x8020dc
  80012b:	e8 fd 03 00 00       	call   80052d <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 5_1 for envfree completed successfully.\n");
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	68 3c 21 80 00       	push   $0x80213c
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
  80014c:	e8 39 16 00 00       	call   80178a <sys_getenvindex>
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
  8001c9:	e8 57 17 00 00       	call   801925 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001ce:	83 ec 0c             	sub    $0xc,%esp
  8001d1:	68 a0 21 80 00       	push   $0x8021a0
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
  8001f9:	68 c8 21 80 00       	push   $0x8021c8
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
  800221:	68 f0 21 80 00       	push   $0x8021f0
  800226:	e8 02 03 00 00       	call   80052d <cprintf>
  80022b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800239:	83 ec 08             	sub    $0x8,%esp
  80023c:	50                   	push   %eax
  80023d:	68 31 22 80 00       	push   $0x802231
  800242:	e8 e6 02 00 00       	call   80052d <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 a0 21 80 00       	push   $0x8021a0
  800252:	e8 d6 02 00 00       	call   80052d <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80025a:	e8 e0 16 00 00       	call   80193f <sys_enable_interrupt>

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
  800272:	e8 df 14 00 00       	call   801756 <sys_env_destroy>
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
  800283:	e8 34 15 00 00       	call   8017bc <sys_env_exit>
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
  8002ac:	68 48 22 80 00       	push   $0x802248
  8002b1:	e8 77 02 00 00       	call   80052d <cprintf>
  8002b6:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002b9:	a1 00 30 80 00       	mov    0x803000,%eax
  8002be:	ff 75 0c             	pushl  0xc(%ebp)
  8002c1:	ff 75 08             	pushl  0x8(%ebp)
  8002c4:	50                   	push   %eax
  8002c5:	68 4d 22 80 00       	push   $0x80224d
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
  8002e9:	68 69 22 80 00       	push   $0x802269
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
  800315:	68 6c 22 80 00       	push   $0x80226c
  80031a:	6a 26                	push   $0x26
  80031c:	68 b8 22 80 00       	push   $0x8022b8
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
  8003db:	68 c4 22 80 00       	push   $0x8022c4
  8003e0:	6a 3a                	push   $0x3a
  8003e2:	68 b8 22 80 00       	push   $0x8022b8
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
  800445:	68 18 23 80 00       	push   $0x802318
  80044a:	6a 44                	push   $0x44
  80044c:	68 b8 22 80 00       	push   $0x8022b8
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
  80049f:	e8 70 12 00 00       	call   801714 <sys_cputs>
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
  800516:	e8 f9 11 00 00       	call   801714 <sys_cputs>
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
  800560:	e8 c0 13 00 00       	call   801925 <sys_disable_interrupt>
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
  800580:	e8 ba 13 00 00       	call   80193f <sys_enable_interrupt>
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
  8005ca:	e8 79 17 00 00       	call   801d48 <__udivdi3>
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
  80061a:	e8 39 18 00 00       	call   801e58 <__umoddi3>
  80061f:	83 c4 10             	add    $0x10,%esp
  800622:	05 94 25 80 00       	add    $0x802594,%eax
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
  800775:	8b 04 85 b8 25 80 00 	mov    0x8025b8(,%eax,4),%eax
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
  800856:	8b 34 9d 00 24 80 00 	mov    0x802400(,%ebx,4),%esi
  80085d:	85 f6                	test   %esi,%esi
  80085f:	75 19                	jne    80087a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800861:	53                   	push   %ebx
  800862:	68 a5 25 80 00       	push   $0x8025a5
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
  80087b:	68 ae 25 80 00       	push   $0x8025ae
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
  8008a8:	be b1 25 80 00       	mov    $0x8025b1,%esi
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
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
  8012ba:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  8012bd:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  8012c4:	76 0a                	jbe    8012d0 <malloc+0x19>
		return NULL;
  8012c6:	b8 00 00 00 00       	mov    $0x0,%eax
  8012cb:	e9 ad 02 00 00       	jmp    80157d <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d3:	c1 e8 0c             	shr    $0xc,%eax
  8012d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	25 ff 0f 00 00       	and    $0xfff,%eax
  8012e1:	85 c0                	test   %eax,%eax
  8012e3:	74 03                	je     8012e8 <malloc+0x31>
		num++;
  8012e5:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  8012e8:	a1 28 30 80 00       	mov    0x803028,%eax
  8012ed:	85 c0                	test   %eax,%eax
  8012ef:	75 71                	jne    801362 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  8012f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8012f6:	83 ec 08             	sub    $0x8,%esp
  8012f9:	ff 75 08             	pushl  0x8(%ebp)
  8012fc:	50                   	push   %eax
  8012fd:	e8 ba 05 00 00       	call   8018bc <sys_allocateMem>
  801302:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801305:	a1 04 30 80 00       	mov    0x803004,%eax
  80130a:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  80130d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801310:	c1 e0 0c             	shl    $0xc,%eax
  801313:	89 c2                	mov    %eax,%edx
  801315:	a1 04 30 80 00       	mov    0x803004,%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801321:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801326:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801329:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801330:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801335:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801338:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  80133f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801344:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  80134b:	01 00 00 00 
		sizeofarray++;
  80134f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801354:	40                   	inc    %eax
  801355:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  80135a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80135d:	e9 1b 02 00 00       	jmp    80157d <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801362:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801369:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801370:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801377:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  80137e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801385:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  80138c:	eb 72                	jmp    801400 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  80138e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801391:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801398:	85 c0                	test   %eax,%eax
  80139a:	75 12                	jne    8013ae <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  80139c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80139f:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8013a6:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  8013a9:	ff 45 dc             	incl   -0x24(%ebp)
  8013ac:	eb 4f                	jmp    8013fd <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  8013ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013b1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8013b4:	7d 39                	jge    8013ef <malloc+0x138>
  8013b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013bc:	7c 31                	jl     8013ef <malloc+0x138>
					{
						min=count;
  8013be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  8013c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8013c7:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8013ce:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013d1:	c1 e2 0c             	shl    $0xc,%edx
  8013d4:	29 d0                	sub    %edx,%eax
  8013d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  8013d9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8013dc:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8013df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  8013e2:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  8013e9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8013ec:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  8013ef:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  8013f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  8013fd:	ff 45 d4             	incl   -0x2c(%ebp)
  801400:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801405:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801408:	7c 84                	jl     80138e <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  80140a:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  80140e:	0f 85 e3 00 00 00    	jne    8014f7 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801414:	83 ec 08             	sub    $0x8,%esp
  801417:	ff 75 08             	pushl  0x8(%ebp)
  80141a:	ff 75 e0             	pushl  -0x20(%ebp)
  80141d:	e8 9a 04 00 00       	call   8018bc <sys_allocateMem>
  801422:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801425:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80142a:	40                   	inc    %eax
  80142b:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  801430:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801435:	48                   	dec    %eax
  801436:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801439:	eb 42                	jmp    80147d <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  80143b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80143e:	48                   	dec    %eax
  80143f:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801446:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801449:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801450:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801453:	48                   	dec    %eax
  801454:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  80145b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80145e:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801465:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801468:	48                   	dec    %eax
  801469:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801470:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801473:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  80147a:	ff 4d d0             	decl   -0x30(%ebp)
  80147d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801480:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801483:	7f b6                	jg     80143b <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801485:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801488:	40                   	inc    %eax
  801489:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  80148c:	8b 55 08             	mov    0x8(%ebp),%edx
  80148f:	01 ca                	add    %ecx,%edx
  801491:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801498:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80149b:	8d 50 01             	lea    0x1(%eax),%edx
  80149e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014a1:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8014a8:	2b 45 f4             	sub    -0xc(%ebp),%eax
  8014ab:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  8014b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014b5:	40                   	inc    %eax
  8014b6:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  8014bd:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  8014c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014c7:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  8014ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014d1:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8014d4:	eb 11                	jmp    8014e7 <malloc+0x230>
				{
					changed[index] = 1;
  8014d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014d9:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8014e0:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  8014e4:	ff 45 cc             	incl   -0x34(%ebp)
  8014e7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8014ea:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8014ed:	7c e7                	jl     8014d6 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  8014ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014f2:	e9 86 00 00 00       	jmp    80157d <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  8014f7:	a1 04 30 80 00       	mov    0x803004,%eax
  8014fc:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801501:	29 c2                	sub    %eax,%edx
  801503:	89 d0                	mov    %edx,%eax
  801505:	3b 45 08             	cmp    0x8(%ebp),%eax
  801508:	73 07                	jae    801511 <malloc+0x25a>
						return NULL;
  80150a:	b8 00 00 00 00       	mov    $0x0,%eax
  80150f:	eb 6c                	jmp    80157d <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801511:	a1 04 30 80 00       	mov    0x803004,%eax
  801516:	83 ec 08             	sub    $0x8,%esp
  801519:	ff 75 08             	pushl  0x8(%ebp)
  80151c:	50                   	push   %eax
  80151d:	e8 9a 03 00 00       	call   8018bc <sys_allocateMem>
  801522:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801525:	a1 04 30 80 00       	mov    0x803004,%eax
  80152a:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  80152d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801530:	c1 e0 0c             	shl    $0xc,%eax
  801533:	89 c2                	mov    %eax,%edx
  801535:	a1 04 30 80 00       	mov    0x803004,%eax
  80153a:	01 d0                	add    %edx,%eax
  80153c:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801541:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801546:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801549:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801550:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801555:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801558:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  80155f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801564:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  80156b:	01 00 00 00 
					sizeofarray++;
  80156f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801574:	40                   	inc    %eax
  801575:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  80157a:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
  801582:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
  801588:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  80158b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801592:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801599:	eb 30                	jmp    8015cb <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  80159b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80159e:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8015a5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015a8:	75 1e                	jne    8015c8 <free+0x49>
  8015aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015ad:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8015b4:	83 f8 01             	cmp    $0x1,%eax
  8015b7:	75 0f                	jne    8015c8 <free+0x49>
			is_found = 1;
  8015b9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8015c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8015c6:	eb 0d                	jmp    8015d5 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8015c8:	ff 45 ec             	incl   -0x14(%ebp)
  8015cb:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015d0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8015d3:	7c c6                	jl     80159b <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8015d5:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8015d9:	75 3a                	jne    801615 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  8015db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015de:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8015e5:	c1 e0 0c             	shl    $0xc,%eax
  8015e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  8015eb:	83 ec 08             	sub    $0x8,%esp
  8015ee:	ff 75 e4             	pushl  -0x1c(%ebp)
  8015f1:	ff 75 e8             	pushl  -0x18(%ebp)
  8015f4:	e8 a7 02 00 00       	call   8018a0 <sys_freeMem>
  8015f9:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  8015fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ff:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801606:	00 00 00 00 
		changes++;
  80160a:	a1 28 30 80 00       	mov    0x803028,%eax
  80160f:	40                   	inc    %eax
  801610:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801615:	90                   	nop
  801616:	c9                   	leave  
  801617:	c3                   	ret    

00801618 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801618:	55                   	push   %ebp
  801619:	89 e5                	mov    %esp,%ebp
  80161b:	83 ec 18             	sub    $0x18,%esp
  80161e:	8b 45 10             	mov    0x10(%ebp),%eax
  801621:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801624:	83 ec 04             	sub    $0x4,%esp
  801627:	68 10 27 80 00       	push   $0x802710
  80162c:	68 b6 00 00 00       	push   $0xb6
  801631:	68 33 27 80 00       	push   $0x802733
  801636:	e8 50 ec ff ff       	call   80028b <_panic>

0080163b <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
  80163e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801641:	83 ec 04             	sub    $0x4,%esp
  801644:	68 10 27 80 00       	push   $0x802710
  801649:	68 bb 00 00 00       	push   $0xbb
  80164e:	68 33 27 80 00       	push   $0x802733
  801653:	e8 33 ec ff ff       	call   80028b <_panic>

00801658 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
  80165b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80165e:	83 ec 04             	sub    $0x4,%esp
  801661:	68 10 27 80 00       	push   $0x802710
  801666:	68 c0 00 00 00       	push   $0xc0
  80166b:	68 33 27 80 00       	push   $0x802733
  801670:	e8 16 ec ff ff       	call   80028b <_panic>

00801675 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
  801678:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80167b:	83 ec 04             	sub    $0x4,%esp
  80167e:	68 10 27 80 00       	push   $0x802710
  801683:	68 c4 00 00 00       	push   $0xc4
  801688:	68 33 27 80 00       	push   $0x802733
  80168d:	e8 f9 eb ff ff       	call   80028b <_panic>

00801692 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
  801695:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801698:	83 ec 04             	sub    $0x4,%esp
  80169b:	68 10 27 80 00       	push   $0x802710
  8016a0:	68 c9 00 00 00       	push   $0xc9
  8016a5:	68 33 27 80 00       	push   $0x802733
  8016aa:	e8 dc eb ff ff       	call   80028b <_panic>

008016af <shrink>:
}
void shrink(uint32 newSize) {
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
  8016b2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016b5:	83 ec 04             	sub    $0x4,%esp
  8016b8:	68 10 27 80 00       	push   $0x802710
  8016bd:	68 cc 00 00 00       	push   $0xcc
  8016c2:	68 33 27 80 00       	push   $0x802733
  8016c7:	e8 bf eb ff ff       	call   80028b <_panic>

008016cc <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
  8016cf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016d2:	83 ec 04             	sub    $0x4,%esp
  8016d5:	68 10 27 80 00       	push   $0x802710
  8016da:	68 d0 00 00 00       	push   $0xd0
  8016df:	68 33 27 80 00       	push   $0x802733
  8016e4:	e8 a2 eb ff ff       	call   80028b <_panic>

008016e9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
  8016ec:	57                   	push   %edi
  8016ed:	56                   	push   %esi
  8016ee:	53                   	push   %ebx
  8016ef:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016fe:	8b 7d 18             	mov    0x18(%ebp),%edi
  801701:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801704:	cd 30                	int    $0x30
  801706:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801709:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80170c:	83 c4 10             	add    $0x10,%esp
  80170f:	5b                   	pop    %ebx
  801710:	5e                   	pop    %esi
  801711:	5f                   	pop    %edi
  801712:	5d                   	pop    %ebp
  801713:	c3                   	ret    

00801714 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
  801717:	83 ec 04             	sub    $0x4,%esp
  80171a:	8b 45 10             	mov    0x10(%ebp),%eax
  80171d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801720:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	52                   	push   %edx
  80172c:	ff 75 0c             	pushl  0xc(%ebp)
  80172f:	50                   	push   %eax
  801730:	6a 00                	push   $0x0
  801732:	e8 b2 ff ff ff       	call   8016e9 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_cgetc>:

int
sys_cgetc(void)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 01                	push   $0x1
  80174c:	e8 98 ff ff ff       	call   8016e9 <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	50                   	push   %eax
  801765:	6a 05                	push   $0x5
  801767:	e8 7d ff ff ff       	call   8016e9 <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 02                	push   $0x2
  801780:	e8 64 ff ff ff       	call   8016e9 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 03                	push   $0x3
  801799:	e8 4b ff ff ff       	call   8016e9 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 04                	push   $0x4
  8017b2:	e8 32 ff ff ff       	call   8016e9 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_env_exit>:


void sys_env_exit(void)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 06                	push   $0x6
  8017cb:	e8 19 ff ff ff       	call   8016e9 <syscall>
  8017d0:	83 c4 18             	add    $0x18,%esp
}
  8017d3:	90                   	nop
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	52                   	push   %edx
  8017e6:	50                   	push   %eax
  8017e7:	6a 07                	push   $0x7
  8017e9:	e8 fb fe ff ff       	call   8016e9 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
}
  8017f1:	c9                   	leave  
  8017f2:	c3                   	ret    

008017f3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
  8017f6:	56                   	push   %esi
  8017f7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017f8:	8b 75 18             	mov    0x18(%ebp),%esi
  8017fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801801:	8b 55 0c             	mov    0xc(%ebp),%edx
  801804:	8b 45 08             	mov    0x8(%ebp),%eax
  801807:	56                   	push   %esi
  801808:	53                   	push   %ebx
  801809:	51                   	push   %ecx
  80180a:	52                   	push   %edx
  80180b:	50                   	push   %eax
  80180c:	6a 08                	push   $0x8
  80180e:	e8 d6 fe ff ff       	call   8016e9 <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801819:	5b                   	pop    %ebx
  80181a:	5e                   	pop    %esi
  80181b:	5d                   	pop    %ebp
  80181c:	c3                   	ret    

0080181d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801820:	8b 55 0c             	mov    0xc(%ebp),%edx
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	52                   	push   %edx
  80182d:	50                   	push   %eax
  80182e:	6a 09                	push   $0x9
  801830:	e8 b4 fe ff ff       	call   8016e9 <syscall>
  801835:	83 c4 18             	add    $0x18,%esp
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	ff 75 0c             	pushl  0xc(%ebp)
  801846:	ff 75 08             	pushl  0x8(%ebp)
  801849:	6a 0a                	push   $0xa
  80184b:	e8 99 fe ff ff       	call   8016e9 <syscall>
  801850:	83 c4 18             	add    $0x18,%esp
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 0b                	push   $0xb
  801864:	e8 80 fe ff ff       	call   8016e9 <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 0c                	push   $0xc
  80187d:	e8 67 fe ff ff       	call   8016e9 <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 0d                	push   $0xd
  801896:	e8 4e fe ff ff       	call   8016e9 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	ff 75 0c             	pushl  0xc(%ebp)
  8018ac:	ff 75 08             	pushl  0x8(%ebp)
  8018af:	6a 11                	push   $0x11
  8018b1:	e8 33 fe ff ff       	call   8016e9 <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
	return;
  8018b9:	90                   	nop
}
  8018ba:	c9                   	leave  
  8018bb:	c3                   	ret    

008018bc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018bc:	55                   	push   %ebp
  8018bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	ff 75 0c             	pushl  0xc(%ebp)
  8018c8:	ff 75 08             	pushl  0x8(%ebp)
  8018cb:	6a 12                	push   $0x12
  8018cd:	e8 17 fe ff ff       	call   8016e9 <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d5:	90                   	nop
}
  8018d6:	c9                   	leave  
  8018d7:	c3                   	ret    

008018d8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 0e                	push   $0xe
  8018e7:	e8 fd fd ff ff       	call   8016e9 <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	ff 75 08             	pushl  0x8(%ebp)
  8018ff:	6a 0f                	push   $0xf
  801901:	e8 e3 fd ff ff       	call   8016e9 <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
}
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 10                	push   $0x10
  80191a:	e8 ca fd ff ff       	call   8016e9 <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	90                   	nop
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 14                	push   $0x14
  801934:	e8 b0 fd ff ff       	call   8016e9 <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
}
  80193c:	90                   	nop
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 15                	push   $0x15
  80194e:	e8 96 fd ff ff       	call   8016e9 <syscall>
  801953:	83 c4 18             	add    $0x18,%esp
}
  801956:	90                   	nop
  801957:	c9                   	leave  
  801958:	c3                   	ret    

00801959 <sys_cputc>:


void
sys_cputc(const char c)
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
  80195c:	83 ec 04             	sub    $0x4,%esp
  80195f:	8b 45 08             	mov    0x8(%ebp),%eax
  801962:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801965:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	50                   	push   %eax
  801972:	6a 16                	push   $0x16
  801974:	e8 70 fd ff ff       	call   8016e9 <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	90                   	nop
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 17                	push   $0x17
  80198e:	e8 56 fd ff ff       	call   8016e9 <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
}
  801996:	90                   	nop
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	ff 75 0c             	pushl  0xc(%ebp)
  8019a8:	50                   	push   %eax
  8019a9:	6a 18                	push   $0x18
  8019ab:	e8 39 fd ff ff       	call   8016e9 <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	52                   	push   %edx
  8019c5:	50                   	push   %eax
  8019c6:	6a 1b                	push   $0x1b
  8019c8:	e8 1c fd ff ff       	call   8016e9 <syscall>
  8019cd:	83 c4 18             	add    $0x18,%esp
}
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	52                   	push   %edx
  8019e2:	50                   	push   %eax
  8019e3:	6a 19                	push   $0x19
  8019e5:	e8 ff fc ff ff       	call   8016e9 <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
}
  8019ed:	90                   	nop
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	52                   	push   %edx
  801a00:	50                   	push   %eax
  801a01:	6a 1a                	push   $0x1a
  801a03:	e8 e1 fc ff ff       	call   8016e9 <syscall>
  801a08:	83 c4 18             	add    $0x18,%esp
}
  801a0b:	90                   	nop
  801a0c:	c9                   	leave  
  801a0d:	c3                   	ret    

00801a0e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
  801a11:	83 ec 04             	sub    $0x4,%esp
  801a14:	8b 45 10             	mov    0x10(%ebp),%eax
  801a17:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a1a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a1d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a21:	8b 45 08             	mov    0x8(%ebp),%eax
  801a24:	6a 00                	push   $0x0
  801a26:	51                   	push   %ecx
  801a27:	52                   	push   %edx
  801a28:	ff 75 0c             	pushl  0xc(%ebp)
  801a2b:	50                   	push   %eax
  801a2c:	6a 1c                	push   $0x1c
  801a2e:	e8 b6 fc ff ff       	call   8016e9 <syscall>
  801a33:	83 c4 18             	add    $0x18,%esp
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	52                   	push   %edx
  801a48:	50                   	push   %eax
  801a49:	6a 1d                	push   $0x1d
  801a4b:	e8 99 fc ff ff       	call   8016e9 <syscall>
  801a50:	83 c4 18             	add    $0x18,%esp
}
  801a53:	c9                   	leave  
  801a54:	c3                   	ret    

00801a55 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a58:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	51                   	push   %ecx
  801a66:	52                   	push   %edx
  801a67:	50                   	push   %eax
  801a68:	6a 1e                	push   $0x1e
  801a6a:	e8 7a fc ff ff       	call   8016e9 <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
}
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	52                   	push   %edx
  801a84:	50                   	push   %eax
  801a85:	6a 1f                	push   $0x1f
  801a87:	e8 5d fc ff ff       	call   8016e9 <syscall>
  801a8c:	83 c4 18             	add    $0x18,%esp
}
  801a8f:	c9                   	leave  
  801a90:	c3                   	ret    

00801a91 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a91:	55                   	push   %ebp
  801a92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 20                	push   $0x20
  801aa0:	e8 44 fc ff ff       	call   8016e9 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
}
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	6a 00                	push   $0x0
  801ab2:	ff 75 14             	pushl  0x14(%ebp)
  801ab5:	ff 75 10             	pushl  0x10(%ebp)
  801ab8:	ff 75 0c             	pushl  0xc(%ebp)
  801abb:	50                   	push   %eax
  801abc:	6a 21                	push   $0x21
  801abe:	e8 26 fc ff ff       	call   8016e9 <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801acb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	50                   	push   %eax
  801ad7:	6a 22                	push   $0x22
  801ad9:	e8 0b fc ff ff       	call   8016e9 <syscall>
  801ade:	83 c4 18             	add    $0x18,%esp
}
  801ae1:	90                   	nop
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	50                   	push   %eax
  801af3:	6a 23                	push   $0x23
  801af5:	e8 ef fb ff ff       	call   8016e9 <syscall>
  801afa:	83 c4 18             	add    $0x18,%esp
}
  801afd:	90                   	nop
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
  801b03:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b06:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b09:	8d 50 04             	lea    0x4(%eax),%edx
  801b0c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	52                   	push   %edx
  801b16:	50                   	push   %eax
  801b17:	6a 24                	push   $0x24
  801b19:	e8 cb fb ff ff       	call   8016e9 <syscall>
  801b1e:	83 c4 18             	add    $0x18,%esp
	return result;
  801b21:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b2a:	89 01                	mov    %eax,(%ecx)
  801b2c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b32:	c9                   	leave  
  801b33:	c2 04 00             	ret    $0x4

00801b36 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b36:	55                   	push   %ebp
  801b37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	ff 75 10             	pushl  0x10(%ebp)
  801b40:	ff 75 0c             	pushl  0xc(%ebp)
  801b43:	ff 75 08             	pushl  0x8(%ebp)
  801b46:	6a 13                	push   $0x13
  801b48:	e8 9c fb ff ff       	call   8016e9 <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801b50:	90                   	nop
}
  801b51:	c9                   	leave  
  801b52:	c3                   	ret    

00801b53 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b53:	55                   	push   %ebp
  801b54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 25                	push   $0x25
  801b62:	e8 82 fb ff ff       	call   8016e9 <syscall>
  801b67:	83 c4 18             	add    $0x18,%esp
}
  801b6a:	c9                   	leave  
  801b6b:	c3                   	ret    

00801b6c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b6c:	55                   	push   %ebp
  801b6d:	89 e5                	mov    %esp,%ebp
  801b6f:	83 ec 04             	sub    $0x4,%esp
  801b72:	8b 45 08             	mov    0x8(%ebp),%eax
  801b75:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b78:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	50                   	push   %eax
  801b85:	6a 26                	push   $0x26
  801b87:	e8 5d fb ff ff       	call   8016e9 <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8f:	90                   	nop
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <rsttst>:
void rsttst()
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 28                	push   $0x28
  801ba1:	e8 43 fb ff ff       	call   8016e9 <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba9:	90                   	nop
}
  801baa:	c9                   	leave  
  801bab:	c3                   	ret    

00801bac <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bac:	55                   	push   %ebp
  801bad:	89 e5                	mov    %esp,%ebp
  801baf:	83 ec 04             	sub    $0x4,%esp
  801bb2:	8b 45 14             	mov    0x14(%ebp),%eax
  801bb5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bb8:	8b 55 18             	mov    0x18(%ebp),%edx
  801bbb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bbf:	52                   	push   %edx
  801bc0:	50                   	push   %eax
  801bc1:	ff 75 10             	pushl  0x10(%ebp)
  801bc4:	ff 75 0c             	pushl  0xc(%ebp)
  801bc7:	ff 75 08             	pushl  0x8(%ebp)
  801bca:	6a 27                	push   $0x27
  801bcc:	e8 18 fb ff ff       	call   8016e9 <syscall>
  801bd1:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd4:	90                   	nop
}
  801bd5:	c9                   	leave  
  801bd6:	c3                   	ret    

00801bd7 <chktst>:
void chktst(uint32 n)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	ff 75 08             	pushl  0x8(%ebp)
  801be5:	6a 29                	push   $0x29
  801be7:	e8 fd fa ff ff       	call   8016e9 <syscall>
  801bec:	83 c4 18             	add    $0x18,%esp
	return ;
  801bef:	90                   	nop
}
  801bf0:	c9                   	leave  
  801bf1:	c3                   	ret    

00801bf2 <inctst>:

void inctst()
{
  801bf2:	55                   	push   %ebp
  801bf3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 2a                	push   $0x2a
  801c01:	e8 e3 fa ff ff       	call   8016e9 <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
	return ;
  801c09:	90                   	nop
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <gettst>:
uint32 gettst()
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 2b                	push   $0x2b
  801c1b:	e8 c9 fa ff ff       	call   8016e9 <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
  801c28:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 2c                	push   $0x2c
  801c37:	e8 ad fa ff ff       	call   8016e9 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
  801c3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c42:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c46:	75 07                	jne    801c4f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c48:	b8 01 00 00 00       	mov    $0x1,%eax
  801c4d:	eb 05                	jmp    801c54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c54:	c9                   	leave  
  801c55:	c3                   	ret    

00801c56 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
  801c59:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 2c                	push   $0x2c
  801c68:	e8 7c fa ff ff       	call   8016e9 <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
  801c70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c73:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c77:	75 07                	jne    801c80 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c79:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7e:	eb 05                	jmp    801c85 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c85:	c9                   	leave  
  801c86:	c3                   	ret    

00801c87 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c87:	55                   	push   %ebp
  801c88:	89 e5                	mov    %esp,%ebp
  801c8a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 2c                	push   $0x2c
  801c99:	e8 4b fa ff ff       	call   8016e9 <syscall>
  801c9e:	83 c4 18             	add    $0x18,%esp
  801ca1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ca4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ca8:	75 07                	jne    801cb1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801caa:	b8 01 00 00 00       	mov    $0x1,%eax
  801caf:	eb 05                	jmp    801cb6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cb1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb6:	c9                   	leave  
  801cb7:	c3                   	ret    

00801cb8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cb8:	55                   	push   %ebp
  801cb9:	89 e5                	mov    %esp,%ebp
  801cbb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 2c                	push   $0x2c
  801cca:	e8 1a fa ff ff       	call   8016e9 <syscall>
  801ccf:	83 c4 18             	add    $0x18,%esp
  801cd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cd5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cd9:	75 07                	jne    801ce2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cdb:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce0:	eb 05                	jmp    801ce7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ce2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce7:	c9                   	leave  
  801ce8:	c3                   	ret    

00801ce9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ce9:	55                   	push   %ebp
  801cea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	ff 75 08             	pushl  0x8(%ebp)
  801cf7:	6a 2d                	push   $0x2d
  801cf9:	e8 eb f9 ff ff       	call   8016e9 <syscall>
  801cfe:	83 c4 18             	add    $0x18,%esp
	return ;
  801d01:	90                   	nop
}
  801d02:	c9                   	leave  
  801d03:	c3                   	ret    

00801d04 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
  801d07:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d08:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d11:	8b 45 08             	mov    0x8(%ebp),%eax
  801d14:	6a 00                	push   $0x0
  801d16:	53                   	push   %ebx
  801d17:	51                   	push   %ecx
  801d18:	52                   	push   %edx
  801d19:	50                   	push   %eax
  801d1a:	6a 2e                	push   $0x2e
  801d1c:	e8 c8 f9 ff ff       	call   8016e9 <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
}
  801d24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	52                   	push   %edx
  801d39:	50                   	push   %eax
  801d3a:	6a 2f                	push   $0x2f
  801d3c:	e8 a8 f9 ff ff       	call   8016e9 <syscall>
  801d41:	83 c4 18             	add    $0x18,%esp
}
  801d44:	c9                   	leave  
  801d45:	c3                   	ret    
  801d46:	66 90                	xchg   %ax,%ax

00801d48 <__udivdi3>:
  801d48:	55                   	push   %ebp
  801d49:	57                   	push   %edi
  801d4a:	56                   	push   %esi
  801d4b:	53                   	push   %ebx
  801d4c:	83 ec 1c             	sub    $0x1c,%esp
  801d4f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d53:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d5f:	89 ca                	mov    %ecx,%edx
  801d61:	89 f8                	mov    %edi,%eax
  801d63:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d67:	85 f6                	test   %esi,%esi
  801d69:	75 2d                	jne    801d98 <__udivdi3+0x50>
  801d6b:	39 cf                	cmp    %ecx,%edi
  801d6d:	77 65                	ja     801dd4 <__udivdi3+0x8c>
  801d6f:	89 fd                	mov    %edi,%ebp
  801d71:	85 ff                	test   %edi,%edi
  801d73:	75 0b                	jne    801d80 <__udivdi3+0x38>
  801d75:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7a:	31 d2                	xor    %edx,%edx
  801d7c:	f7 f7                	div    %edi
  801d7e:	89 c5                	mov    %eax,%ebp
  801d80:	31 d2                	xor    %edx,%edx
  801d82:	89 c8                	mov    %ecx,%eax
  801d84:	f7 f5                	div    %ebp
  801d86:	89 c1                	mov    %eax,%ecx
  801d88:	89 d8                	mov    %ebx,%eax
  801d8a:	f7 f5                	div    %ebp
  801d8c:	89 cf                	mov    %ecx,%edi
  801d8e:	89 fa                	mov    %edi,%edx
  801d90:	83 c4 1c             	add    $0x1c,%esp
  801d93:	5b                   	pop    %ebx
  801d94:	5e                   	pop    %esi
  801d95:	5f                   	pop    %edi
  801d96:	5d                   	pop    %ebp
  801d97:	c3                   	ret    
  801d98:	39 ce                	cmp    %ecx,%esi
  801d9a:	77 28                	ja     801dc4 <__udivdi3+0x7c>
  801d9c:	0f bd fe             	bsr    %esi,%edi
  801d9f:	83 f7 1f             	xor    $0x1f,%edi
  801da2:	75 40                	jne    801de4 <__udivdi3+0x9c>
  801da4:	39 ce                	cmp    %ecx,%esi
  801da6:	72 0a                	jb     801db2 <__udivdi3+0x6a>
  801da8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801dac:	0f 87 9e 00 00 00    	ja     801e50 <__udivdi3+0x108>
  801db2:	b8 01 00 00 00       	mov    $0x1,%eax
  801db7:	89 fa                	mov    %edi,%edx
  801db9:	83 c4 1c             	add    $0x1c,%esp
  801dbc:	5b                   	pop    %ebx
  801dbd:	5e                   	pop    %esi
  801dbe:	5f                   	pop    %edi
  801dbf:	5d                   	pop    %ebp
  801dc0:	c3                   	ret    
  801dc1:	8d 76 00             	lea    0x0(%esi),%esi
  801dc4:	31 ff                	xor    %edi,%edi
  801dc6:	31 c0                	xor    %eax,%eax
  801dc8:	89 fa                	mov    %edi,%edx
  801dca:	83 c4 1c             	add    $0x1c,%esp
  801dcd:	5b                   	pop    %ebx
  801dce:	5e                   	pop    %esi
  801dcf:	5f                   	pop    %edi
  801dd0:	5d                   	pop    %ebp
  801dd1:	c3                   	ret    
  801dd2:	66 90                	xchg   %ax,%ax
  801dd4:	89 d8                	mov    %ebx,%eax
  801dd6:	f7 f7                	div    %edi
  801dd8:	31 ff                	xor    %edi,%edi
  801dda:	89 fa                	mov    %edi,%edx
  801ddc:	83 c4 1c             	add    $0x1c,%esp
  801ddf:	5b                   	pop    %ebx
  801de0:	5e                   	pop    %esi
  801de1:	5f                   	pop    %edi
  801de2:	5d                   	pop    %ebp
  801de3:	c3                   	ret    
  801de4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801de9:	89 eb                	mov    %ebp,%ebx
  801deb:	29 fb                	sub    %edi,%ebx
  801ded:	89 f9                	mov    %edi,%ecx
  801def:	d3 e6                	shl    %cl,%esi
  801df1:	89 c5                	mov    %eax,%ebp
  801df3:	88 d9                	mov    %bl,%cl
  801df5:	d3 ed                	shr    %cl,%ebp
  801df7:	89 e9                	mov    %ebp,%ecx
  801df9:	09 f1                	or     %esi,%ecx
  801dfb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dff:	89 f9                	mov    %edi,%ecx
  801e01:	d3 e0                	shl    %cl,%eax
  801e03:	89 c5                	mov    %eax,%ebp
  801e05:	89 d6                	mov    %edx,%esi
  801e07:	88 d9                	mov    %bl,%cl
  801e09:	d3 ee                	shr    %cl,%esi
  801e0b:	89 f9                	mov    %edi,%ecx
  801e0d:	d3 e2                	shl    %cl,%edx
  801e0f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e13:	88 d9                	mov    %bl,%cl
  801e15:	d3 e8                	shr    %cl,%eax
  801e17:	09 c2                	or     %eax,%edx
  801e19:	89 d0                	mov    %edx,%eax
  801e1b:	89 f2                	mov    %esi,%edx
  801e1d:	f7 74 24 0c          	divl   0xc(%esp)
  801e21:	89 d6                	mov    %edx,%esi
  801e23:	89 c3                	mov    %eax,%ebx
  801e25:	f7 e5                	mul    %ebp
  801e27:	39 d6                	cmp    %edx,%esi
  801e29:	72 19                	jb     801e44 <__udivdi3+0xfc>
  801e2b:	74 0b                	je     801e38 <__udivdi3+0xf0>
  801e2d:	89 d8                	mov    %ebx,%eax
  801e2f:	31 ff                	xor    %edi,%edi
  801e31:	e9 58 ff ff ff       	jmp    801d8e <__udivdi3+0x46>
  801e36:	66 90                	xchg   %ax,%ax
  801e38:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e3c:	89 f9                	mov    %edi,%ecx
  801e3e:	d3 e2                	shl    %cl,%edx
  801e40:	39 c2                	cmp    %eax,%edx
  801e42:	73 e9                	jae    801e2d <__udivdi3+0xe5>
  801e44:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e47:	31 ff                	xor    %edi,%edi
  801e49:	e9 40 ff ff ff       	jmp    801d8e <__udivdi3+0x46>
  801e4e:	66 90                	xchg   %ax,%ax
  801e50:	31 c0                	xor    %eax,%eax
  801e52:	e9 37 ff ff ff       	jmp    801d8e <__udivdi3+0x46>
  801e57:	90                   	nop

00801e58 <__umoddi3>:
  801e58:	55                   	push   %ebp
  801e59:	57                   	push   %edi
  801e5a:	56                   	push   %esi
  801e5b:	53                   	push   %ebx
  801e5c:	83 ec 1c             	sub    $0x1c,%esp
  801e5f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e63:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e6b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e73:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e77:	89 f3                	mov    %esi,%ebx
  801e79:	89 fa                	mov    %edi,%edx
  801e7b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e7f:	89 34 24             	mov    %esi,(%esp)
  801e82:	85 c0                	test   %eax,%eax
  801e84:	75 1a                	jne    801ea0 <__umoddi3+0x48>
  801e86:	39 f7                	cmp    %esi,%edi
  801e88:	0f 86 a2 00 00 00    	jbe    801f30 <__umoddi3+0xd8>
  801e8e:	89 c8                	mov    %ecx,%eax
  801e90:	89 f2                	mov    %esi,%edx
  801e92:	f7 f7                	div    %edi
  801e94:	89 d0                	mov    %edx,%eax
  801e96:	31 d2                	xor    %edx,%edx
  801e98:	83 c4 1c             	add    $0x1c,%esp
  801e9b:	5b                   	pop    %ebx
  801e9c:	5e                   	pop    %esi
  801e9d:	5f                   	pop    %edi
  801e9e:	5d                   	pop    %ebp
  801e9f:	c3                   	ret    
  801ea0:	39 f0                	cmp    %esi,%eax
  801ea2:	0f 87 ac 00 00 00    	ja     801f54 <__umoddi3+0xfc>
  801ea8:	0f bd e8             	bsr    %eax,%ebp
  801eab:	83 f5 1f             	xor    $0x1f,%ebp
  801eae:	0f 84 ac 00 00 00    	je     801f60 <__umoddi3+0x108>
  801eb4:	bf 20 00 00 00       	mov    $0x20,%edi
  801eb9:	29 ef                	sub    %ebp,%edi
  801ebb:	89 fe                	mov    %edi,%esi
  801ebd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ec1:	89 e9                	mov    %ebp,%ecx
  801ec3:	d3 e0                	shl    %cl,%eax
  801ec5:	89 d7                	mov    %edx,%edi
  801ec7:	89 f1                	mov    %esi,%ecx
  801ec9:	d3 ef                	shr    %cl,%edi
  801ecb:	09 c7                	or     %eax,%edi
  801ecd:	89 e9                	mov    %ebp,%ecx
  801ecf:	d3 e2                	shl    %cl,%edx
  801ed1:	89 14 24             	mov    %edx,(%esp)
  801ed4:	89 d8                	mov    %ebx,%eax
  801ed6:	d3 e0                	shl    %cl,%eax
  801ed8:	89 c2                	mov    %eax,%edx
  801eda:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ede:	d3 e0                	shl    %cl,%eax
  801ee0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ee4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ee8:	89 f1                	mov    %esi,%ecx
  801eea:	d3 e8                	shr    %cl,%eax
  801eec:	09 d0                	or     %edx,%eax
  801eee:	d3 eb                	shr    %cl,%ebx
  801ef0:	89 da                	mov    %ebx,%edx
  801ef2:	f7 f7                	div    %edi
  801ef4:	89 d3                	mov    %edx,%ebx
  801ef6:	f7 24 24             	mull   (%esp)
  801ef9:	89 c6                	mov    %eax,%esi
  801efb:	89 d1                	mov    %edx,%ecx
  801efd:	39 d3                	cmp    %edx,%ebx
  801eff:	0f 82 87 00 00 00    	jb     801f8c <__umoddi3+0x134>
  801f05:	0f 84 91 00 00 00    	je     801f9c <__umoddi3+0x144>
  801f0b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f0f:	29 f2                	sub    %esi,%edx
  801f11:	19 cb                	sbb    %ecx,%ebx
  801f13:	89 d8                	mov    %ebx,%eax
  801f15:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f19:	d3 e0                	shl    %cl,%eax
  801f1b:	89 e9                	mov    %ebp,%ecx
  801f1d:	d3 ea                	shr    %cl,%edx
  801f1f:	09 d0                	or     %edx,%eax
  801f21:	89 e9                	mov    %ebp,%ecx
  801f23:	d3 eb                	shr    %cl,%ebx
  801f25:	89 da                	mov    %ebx,%edx
  801f27:	83 c4 1c             	add    $0x1c,%esp
  801f2a:	5b                   	pop    %ebx
  801f2b:	5e                   	pop    %esi
  801f2c:	5f                   	pop    %edi
  801f2d:	5d                   	pop    %ebp
  801f2e:	c3                   	ret    
  801f2f:	90                   	nop
  801f30:	89 fd                	mov    %edi,%ebp
  801f32:	85 ff                	test   %edi,%edi
  801f34:	75 0b                	jne    801f41 <__umoddi3+0xe9>
  801f36:	b8 01 00 00 00       	mov    $0x1,%eax
  801f3b:	31 d2                	xor    %edx,%edx
  801f3d:	f7 f7                	div    %edi
  801f3f:	89 c5                	mov    %eax,%ebp
  801f41:	89 f0                	mov    %esi,%eax
  801f43:	31 d2                	xor    %edx,%edx
  801f45:	f7 f5                	div    %ebp
  801f47:	89 c8                	mov    %ecx,%eax
  801f49:	f7 f5                	div    %ebp
  801f4b:	89 d0                	mov    %edx,%eax
  801f4d:	e9 44 ff ff ff       	jmp    801e96 <__umoddi3+0x3e>
  801f52:	66 90                	xchg   %ax,%ax
  801f54:	89 c8                	mov    %ecx,%eax
  801f56:	89 f2                	mov    %esi,%edx
  801f58:	83 c4 1c             	add    $0x1c,%esp
  801f5b:	5b                   	pop    %ebx
  801f5c:	5e                   	pop    %esi
  801f5d:	5f                   	pop    %edi
  801f5e:	5d                   	pop    %ebp
  801f5f:	c3                   	ret    
  801f60:	3b 04 24             	cmp    (%esp),%eax
  801f63:	72 06                	jb     801f6b <__umoddi3+0x113>
  801f65:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f69:	77 0f                	ja     801f7a <__umoddi3+0x122>
  801f6b:	89 f2                	mov    %esi,%edx
  801f6d:	29 f9                	sub    %edi,%ecx
  801f6f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f73:	89 14 24             	mov    %edx,(%esp)
  801f76:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f7a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f7e:	8b 14 24             	mov    (%esp),%edx
  801f81:	83 c4 1c             	add    $0x1c,%esp
  801f84:	5b                   	pop    %ebx
  801f85:	5e                   	pop    %esi
  801f86:	5f                   	pop    %edi
  801f87:	5d                   	pop    %ebp
  801f88:	c3                   	ret    
  801f89:	8d 76 00             	lea    0x0(%esi),%esi
  801f8c:	2b 04 24             	sub    (%esp),%eax
  801f8f:	19 fa                	sbb    %edi,%edx
  801f91:	89 d1                	mov    %edx,%ecx
  801f93:	89 c6                	mov    %eax,%esi
  801f95:	e9 71 ff ff ff       	jmp    801f0b <__umoddi3+0xb3>
  801f9a:	66 90                	xchg   %ax,%ax
  801f9c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fa0:	72 ea                	jb     801f8c <__umoddi3+0x134>
  801fa2:	89 d9                	mov    %ebx,%ecx
  801fa4:	e9 62 ff ff ff       	jmp    801f0b <__umoddi3+0xb3>
