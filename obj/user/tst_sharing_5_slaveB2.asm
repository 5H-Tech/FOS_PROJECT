
obj/user/tst_sharing_5_slaveB2:     file format elf32-i386


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
  800031:	e8 38 01 00 00       	call   80016e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
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
  800086:	68 a0 20 80 00       	push   $0x8020a0
  80008b:	6a 12                	push   $0x12
  80008d:	68 bc 20 80 00       	push   $0x8020bc
  800092:	e8 1c 02 00 00       	call   8002b3 <_panic>
	}
	uint32 *z;
	z = sget(sys_getparentenvid(),"z");
  800097:	e8 2f 17 00 00       	call   8017cb <sys_getparentenvid>
  80009c:	83 ec 08             	sub    $0x8,%esp
  80009f:	68 d9 20 80 00       	push   $0x8020d9
  8000a4:	50                   	push   %eax
  8000a5:	e8 b9 15 00 00       	call   801663 <sget>
  8000aa:	83 c4 10             	add    $0x10,%esp
  8000ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("Slave B2 env used z (getSharedObject)\n");
  8000b0:	83 ec 0c             	sub    $0xc,%esp
  8000b3:	68 dc 20 80 00       	push   $0x8020dc
  8000b8:	e8 98 04 00 00       	call   800555 <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp

	cprintf("Slave B2 please be patient ...\n");
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	68 04 21 80 00       	push   $0x802104
  8000c8:	e8 88 04 00 00       	call   800555 <cprintf>
  8000cd:	83 c4 10             	add    $0x10,%esp

	env_sleep(9000);
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 28 23 00 00       	push   $0x2328
  8000d8:	e8 91 1c 00 00       	call   801d6e <env_sleep>
  8000dd:	83 c4 10             	add    $0x10,%esp
	int freeFrames = sys_calculate_free_frames() ;
  8000e0:	e8 98 17 00 00       	call   80187d <sys_calculate_free_frames>
  8000e5:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sfree(z);
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ee:	e8 8d 15 00 00       	call   801680 <sfree>
  8000f3:	83 c4 10             	add    $0x10,%esp
	cprintf("Slave B2 env removed z\n");
  8000f6:	83 ec 0c             	sub    $0xc,%esp
  8000f9:	68 24 21 80 00       	push   $0x802124
  8000fe:	e8 52 04 00 00       	call   800555 <cprintf>
  800103:	83 c4 10             	add    $0x10,%esp

	if ((sys_calculate_free_frames() - freeFrames) !=  4) panic("wrong free: frames removed not equal 4 !, correct frames to be removed are 4:\nfrom the env: 1 table + 1 frame for z\nframes_storage of z: should be cleared now\n");
  800106:	e8 72 17 00 00       	call   80187d <sys_calculate_free_frames>
  80010b:	89 c2                	mov    %eax,%edx
  80010d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800110:	29 c2                	sub    %eax,%edx
  800112:	89 d0                	mov    %edx,%eax
  800114:	83 f8 04             	cmp    $0x4,%eax
  800117:	74 14                	je     80012d <_main+0xf5>
  800119:	83 ec 04             	sub    $0x4,%esp
  80011c:	68 3c 21 80 00       	push   $0x80213c
  800121:	6a 20                	push   $0x20
  800123:	68 bc 20 80 00       	push   $0x8020bc
  800128:	e8 86 01 00 00       	call   8002b3 <_panic>

	//to ensure that the other environments completed successfully
	if (gettst()!=2) panic("test failed");
  80012d:	e8 02 1b 00 00       	call   801c34 <gettst>
  800132:	83 f8 02             	cmp    $0x2,%eax
  800135:	74 14                	je     80014b <_main+0x113>
  800137:	83 ec 04             	sub    $0x4,%esp
  80013a:	68 dc 21 80 00       	push   $0x8021dc
  80013f:	6a 23                	push   $0x23
  800141:	68 bc 20 80 00       	push   $0x8020bc
  800146:	e8 68 01 00 00       	call   8002b3 <_panic>

	cprintf("Step B completed successfully!!\n\n\n");
  80014b:	83 ec 0c             	sub    $0xc,%esp
  80014e:	68 e8 21 80 00       	push   $0x8021e8
  800153:	e8 fd 03 00 00       	call   800555 <cprintf>
  800158:	83 c4 10             	add    $0x10,%esp
	cprintf("Congratulations!! Test of freeSharedObjects [5] completed successfully!!\n\n\n");
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	68 0c 22 80 00       	push   $0x80220c
  800163:	e8 ed 03 00 00       	call   800555 <cprintf>
  800168:	83 c4 10             	add    $0x10,%esp

	return;
  80016b:	90                   	nop
}
  80016c:	c9                   	leave  
  80016d:	c3                   	ret    

0080016e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80016e:	55                   	push   %ebp
  80016f:	89 e5                	mov    %esp,%ebp
  800171:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800174:	e8 39 16 00 00       	call   8017b2 <sys_getenvindex>
  800179:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80017c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80017f:	89 d0                	mov    %edx,%eax
  800181:	c1 e0 03             	shl    $0x3,%eax
  800184:	01 d0                	add    %edx,%eax
  800186:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80018d:	01 c8                	add    %ecx,%eax
  80018f:	01 c0                	add    %eax,%eax
  800191:	01 d0                	add    %edx,%eax
  800193:	01 c0                	add    %eax,%eax
  800195:	01 d0                	add    %edx,%eax
  800197:	89 c2                	mov    %eax,%edx
  800199:	c1 e2 05             	shl    $0x5,%edx
  80019c:	29 c2                	sub    %eax,%edx
  80019e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001a5:	89 c2                	mov    %eax,%edx
  8001a7:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001ad:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b7:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001bd:	84 c0                	test   %al,%al
  8001bf:	74 0f                	je     8001d0 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c6:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001cb:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001d0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001d4:	7e 0a                	jle    8001e0 <libmain+0x72>
		binaryname = argv[0];
  8001d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d9:	8b 00                	mov    (%eax),%eax
  8001db:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001e0:	83 ec 08             	sub    $0x8,%esp
  8001e3:	ff 75 0c             	pushl  0xc(%ebp)
  8001e6:	ff 75 08             	pushl  0x8(%ebp)
  8001e9:	e8 4a fe ff ff       	call   800038 <_main>
  8001ee:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001f1:	e8 57 17 00 00       	call   80194d <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001f6:	83 ec 0c             	sub    $0xc,%esp
  8001f9:	68 70 22 80 00       	push   $0x802270
  8001fe:	e8 52 03 00 00       	call   800555 <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800206:	a1 20 30 80 00       	mov    0x803020,%eax
  80020b:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80021c:	83 ec 04             	sub    $0x4,%esp
  80021f:	52                   	push   %edx
  800220:	50                   	push   %eax
  800221:	68 98 22 80 00       	push   $0x802298
  800226:	e8 2a 03 00 00       	call   800555 <cprintf>
  80022b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800239:	a1 20 30 80 00       	mov    0x803020,%eax
  80023e:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800244:	83 ec 04             	sub    $0x4,%esp
  800247:	52                   	push   %edx
  800248:	50                   	push   %eax
  800249:	68 c0 22 80 00       	push   $0x8022c0
  80024e:	e8 02 03 00 00       	call   800555 <cprintf>
  800253:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800256:	a1 20 30 80 00       	mov    0x803020,%eax
  80025b:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800261:	83 ec 08             	sub    $0x8,%esp
  800264:	50                   	push   %eax
  800265:	68 01 23 80 00       	push   $0x802301
  80026a:	e8 e6 02 00 00       	call   800555 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 70 22 80 00       	push   $0x802270
  80027a:	e8 d6 02 00 00       	call   800555 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800282:	e8 e0 16 00 00       	call   801967 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800287:	e8 19 00 00 00       	call   8002a5 <exit>
}
  80028c:	90                   	nop
  80028d:	c9                   	leave  
  80028e:	c3                   	ret    

0080028f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80028f:	55                   	push   %ebp
  800290:	89 e5                	mov    %esp,%ebp
  800292:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800295:	83 ec 0c             	sub    $0xc,%esp
  800298:	6a 00                	push   $0x0
  80029a:	e8 df 14 00 00       	call   80177e <sys_env_destroy>
  80029f:	83 c4 10             	add    $0x10,%esp
}
  8002a2:	90                   	nop
  8002a3:	c9                   	leave  
  8002a4:	c3                   	ret    

008002a5 <exit>:

void
exit(void)
{
  8002a5:	55                   	push   %ebp
  8002a6:	89 e5                	mov    %esp,%ebp
  8002a8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002ab:	e8 34 15 00 00       	call   8017e4 <sys_env_exit>
}
  8002b0:	90                   	nop
  8002b1:	c9                   	leave  
  8002b2:	c3                   	ret    

008002b3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002b3:	55                   	push   %ebp
  8002b4:	89 e5                	mov    %esp,%ebp
  8002b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002b9:	8d 45 10             	lea    0x10(%ebp),%eax
  8002bc:	83 c0 04             	add    $0x4,%eax
  8002bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002c2:	a1 18 31 80 00       	mov    0x803118,%eax
  8002c7:	85 c0                	test   %eax,%eax
  8002c9:	74 16                	je     8002e1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002cb:	a1 18 31 80 00       	mov    0x803118,%eax
  8002d0:	83 ec 08             	sub    $0x8,%esp
  8002d3:	50                   	push   %eax
  8002d4:	68 18 23 80 00       	push   $0x802318
  8002d9:	e8 77 02 00 00       	call   800555 <cprintf>
  8002de:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002e1:	a1 00 30 80 00       	mov    0x803000,%eax
  8002e6:	ff 75 0c             	pushl  0xc(%ebp)
  8002e9:	ff 75 08             	pushl  0x8(%ebp)
  8002ec:	50                   	push   %eax
  8002ed:	68 1d 23 80 00       	push   $0x80231d
  8002f2:	e8 5e 02 00 00       	call   800555 <cprintf>
  8002f7:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8002fd:	83 ec 08             	sub    $0x8,%esp
  800300:	ff 75 f4             	pushl  -0xc(%ebp)
  800303:	50                   	push   %eax
  800304:	e8 e1 01 00 00       	call   8004ea <vcprintf>
  800309:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80030c:	83 ec 08             	sub    $0x8,%esp
  80030f:	6a 00                	push   $0x0
  800311:	68 39 23 80 00       	push   $0x802339
  800316:	e8 cf 01 00 00       	call   8004ea <vcprintf>
  80031b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80031e:	e8 82 ff ff ff       	call   8002a5 <exit>

	// should not return here
	while (1) ;
  800323:	eb fe                	jmp    800323 <_panic+0x70>

00800325 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800325:	55                   	push   %ebp
  800326:	89 e5                	mov    %esp,%ebp
  800328:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80032b:	a1 20 30 80 00       	mov    0x803020,%eax
  800330:	8b 50 74             	mov    0x74(%eax),%edx
  800333:	8b 45 0c             	mov    0xc(%ebp),%eax
  800336:	39 c2                	cmp    %eax,%edx
  800338:	74 14                	je     80034e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80033a:	83 ec 04             	sub    $0x4,%esp
  80033d:	68 3c 23 80 00       	push   $0x80233c
  800342:	6a 26                	push   $0x26
  800344:	68 88 23 80 00       	push   $0x802388
  800349:	e8 65 ff ff ff       	call   8002b3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80034e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800355:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80035c:	e9 b6 00 00 00       	jmp    800417 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800364:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036b:	8b 45 08             	mov    0x8(%ebp),%eax
  80036e:	01 d0                	add    %edx,%eax
  800370:	8b 00                	mov    (%eax),%eax
  800372:	85 c0                	test   %eax,%eax
  800374:	75 08                	jne    80037e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800376:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800379:	e9 96 00 00 00       	jmp    800414 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80037e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800385:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80038c:	eb 5d                	jmp    8003eb <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80038e:	a1 20 30 80 00       	mov    0x803020,%eax
  800393:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800399:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80039c:	c1 e2 04             	shl    $0x4,%edx
  80039f:	01 d0                	add    %edx,%eax
  8003a1:	8a 40 04             	mov    0x4(%eax),%al
  8003a4:	84 c0                	test   %al,%al
  8003a6:	75 40                	jne    8003e8 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ad:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003b3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003b6:	c1 e2 04             	shl    $0x4,%edx
  8003b9:	01 d0                	add    %edx,%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	01 c8                	add    %ecx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	75 09                	jne    8003e8 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003df:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003e6:	eb 12                	jmp    8003fa <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003e8:	ff 45 e8             	incl   -0x18(%ebp)
  8003eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f0:	8b 50 74             	mov    0x74(%eax),%edx
  8003f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003f6:	39 c2                	cmp    %eax,%edx
  8003f8:	77 94                	ja     80038e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003fe:	75 14                	jne    800414 <CheckWSWithoutLastIndex+0xef>
			panic(
  800400:	83 ec 04             	sub    $0x4,%esp
  800403:	68 94 23 80 00       	push   $0x802394
  800408:	6a 3a                	push   $0x3a
  80040a:	68 88 23 80 00       	push   $0x802388
  80040f:	e8 9f fe ff ff       	call   8002b3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800414:	ff 45 f0             	incl   -0x10(%ebp)
  800417:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041d:	0f 8c 3e ff ff ff    	jl     800361 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800423:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80042a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800431:	eb 20                	jmp    800453 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800433:	a1 20 30 80 00       	mov    0x803020,%eax
  800438:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80043e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800441:	c1 e2 04             	shl    $0x4,%edx
  800444:	01 d0                	add    %edx,%eax
  800446:	8a 40 04             	mov    0x4(%eax),%al
  800449:	3c 01                	cmp    $0x1,%al
  80044b:	75 03                	jne    800450 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80044d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800450:	ff 45 e0             	incl   -0x20(%ebp)
  800453:	a1 20 30 80 00       	mov    0x803020,%eax
  800458:	8b 50 74             	mov    0x74(%eax),%edx
  80045b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80045e:	39 c2                	cmp    %eax,%edx
  800460:	77 d1                	ja     800433 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800462:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800465:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800468:	74 14                	je     80047e <CheckWSWithoutLastIndex+0x159>
		panic(
  80046a:	83 ec 04             	sub    $0x4,%esp
  80046d:	68 e8 23 80 00       	push   $0x8023e8
  800472:	6a 44                	push   $0x44
  800474:	68 88 23 80 00       	push   $0x802388
  800479:	e8 35 fe ff ff       	call   8002b3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80047e:	90                   	nop
  80047f:	c9                   	leave  
  800480:	c3                   	ret    

00800481 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800481:	55                   	push   %ebp
  800482:	89 e5                	mov    %esp,%ebp
  800484:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048a:	8b 00                	mov    (%eax),%eax
  80048c:	8d 48 01             	lea    0x1(%eax),%ecx
  80048f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800492:	89 0a                	mov    %ecx,(%edx)
  800494:	8b 55 08             	mov    0x8(%ebp),%edx
  800497:	88 d1                	mov    %dl,%cl
  800499:	8b 55 0c             	mov    0xc(%ebp),%edx
  80049c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a3:	8b 00                	mov    (%eax),%eax
  8004a5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004aa:	75 2c                	jne    8004d8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004ac:	a0 24 30 80 00       	mov    0x803024,%al
  8004b1:	0f b6 c0             	movzbl %al,%eax
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 12                	mov    (%edx),%edx
  8004b9:	89 d1                	mov    %edx,%ecx
  8004bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004be:	83 c2 08             	add    $0x8,%edx
  8004c1:	83 ec 04             	sub    $0x4,%esp
  8004c4:	50                   	push   %eax
  8004c5:	51                   	push   %ecx
  8004c6:	52                   	push   %edx
  8004c7:	e8 70 12 00 00       	call   80173c <sys_cputs>
  8004cc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004db:	8b 40 04             	mov    0x4(%eax),%eax
  8004de:	8d 50 01             	lea    0x1(%eax),%edx
  8004e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004e7:	90                   	nop
  8004e8:	c9                   	leave  
  8004e9:	c3                   	ret    

008004ea <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004ea:	55                   	push   %ebp
  8004eb:	89 e5                	mov    %esp,%ebp
  8004ed:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004f3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004fa:	00 00 00 
	b.cnt = 0;
  8004fd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800504:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800507:	ff 75 0c             	pushl  0xc(%ebp)
  80050a:	ff 75 08             	pushl  0x8(%ebp)
  80050d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800513:	50                   	push   %eax
  800514:	68 81 04 80 00       	push   $0x800481
  800519:	e8 11 02 00 00       	call   80072f <vprintfmt>
  80051e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800521:	a0 24 30 80 00       	mov    0x803024,%al
  800526:	0f b6 c0             	movzbl %al,%eax
  800529:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80052f:	83 ec 04             	sub    $0x4,%esp
  800532:	50                   	push   %eax
  800533:	52                   	push   %edx
  800534:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80053a:	83 c0 08             	add    $0x8,%eax
  80053d:	50                   	push   %eax
  80053e:	e8 f9 11 00 00       	call   80173c <sys_cputs>
  800543:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800546:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80054d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800553:	c9                   	leave  
  800554:	c3                   	ret    

00800555 <cprintf>:

int cprintf(const char *fmt, ...) {
  800555:	55                   	push   %ebp
  800556:	89 e5                	mov    %esp,%ebp
  800558:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80055b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800562:	8d 45 0c             	lea    0xc(%ebp),%eax
  800565:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 f4             	pushl  -0xc(%ebp)
  800571:	50                   	push   %eax
  800572:	e8 73 ff ff ff       	call   8004ea <vcprintf>
  800577:	83 c4 10             	add    $0x10,%esp
  80057a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80057d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800580:	c9                   	leave  
  800581:	c3                   	ret    

00800582 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800582:	55                   	push   %ebp
  800583:	89 e5                	mov    %esp,%ebp
  800585:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800588:	e8 c0 13 00 00       	call   80194d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80058d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800590:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800593:	8b 45 08             	mov    0x8(%ebp),%eax
  800596:	83 ec 08             	sub    $0x8,%esp
  800599:	ff 75 f4             	pushl  -0xc(%ebp)
  80059c:	50                   	push   %eax
  80059d:	e8 48 ff ff ff       	call   8004ea <vcprintf>
  8005a2:	83 c4 10             	add    $0x10,%esp
  8005a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005a8:	e8 ba 13 00 00       	call   801967 <sys_enable_interrupt>
	return cnt;
  8005ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005b0:	c9                   	leave  
  8005b1:	c3                   	ret    

008005b2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005b2:	55                   	push   %ebp
  8005b3:	89 e5                	mov    %esp,%ebp
  8005b5:	53                   	push   %ebx
  8005b6:	83 ec 14             	sub    $0x14,%esp
  8005b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005c5:	8b 45 18             	mov    0x18(%ebp),%eax
  8005c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8005cd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005d0:	77 55                	ja     800627 <printnum+0x75>
  8005d2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005d5:	72 05                	jb     8005dc <printnum+0x2a>
  8005d7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005da:	77 4b                	ja     800627 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005dc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005df:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005e2:	8b 45 18             	mov    0x18(%ebp),%eax
  8005e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ea:	52                   	push   %edx
  8005eb:	50                   	push   %eax
  8005ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8005ef:	ff 75 f0             	pushl  -0x10(%ebp)
  8005f2:	e8 2d 18 00 00       	call   801e24 <__udivdi3>
  8005f7:	83 c4 10             	add    $0x10,%esp
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	ff 75 20             	pushl  0x20(%ebp)
  800600:	53                   	push   %ebx
  800601:	ff 75 18             	pushl  0x18(%ebp)
  800604:	52                   	push   %edx
  800605:	50                   	push   %eax
  800606:	ff 75 0c             	pushl  0xc(%ebp)
  800609:	ff 75 08             	pushl  0x8(%ebp)
  80060c:	e8 a1 ff ff ff       	call   8005b2 <printnum>
  800611:	83 c4 20             	add    $0x20,%esp
  800614:	eb 1a                	jmp    800630 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800616:	83 ec 08             	sub    $0x8,%esp
  800619:	ff 75 0c             	pushl  0xc(%ebp)
  80061c:	ff 75 20             	pushl  0x20(%ebp)
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	ff d0                	call   *%eax
  800624:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800627:	ff 4d 1c             	decl   0x1c(%ebp)
  80062a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80062e:	7f e6                	jg     800616 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800630:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800633:	bb 00 00 00 00       	mov    $0x0,%ebx
  800638:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80063b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80063e:	53                   	push   %ebx
  80063f:	51                   	push   %ecx
  800640:	52                   	push   %edx
  800641:	50                   	push   %eax
  800642:	e8 ed 18 00 00       	call   801f34 <__umoddi3>
  800647:	83 c4 10             	add    $0x10,%esp
  80064a:	05 54 26 80 00       	add    $0x802654,%eax
  80064f:	8a 00                	mov    (%eax),%al
  800651:	0f be c0             	movsbl %al,%eax
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	50                   	push   %eax
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	ff d0                	call   *%eax
  800660:	83 c4 10             	add    $0x10,%esp
}
  800663:	90                   	nop
  800664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800667:	c9                   	leave  
  800668:	c3                   	ret    

00800669 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800669:	55                   	push   %ebp
  80066a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80066c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800670:	7e 1c                	jle    80068e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8b 00                	mov    (%eax),%eax
  800677:	8d 50 08             	lea    0x8(%eax),%edx
  80067a:	8b 45 08             	mov    0x8(%ebp),%eax
  80067d:	89 10                	mov    %edx,(%eax)
  80067f:	8b 45 08             	mov    0x8(%ebp),%eax
  800682:	8b 00                	mov    (%eax),%eax
  800684:	83 e8 08             	sub    $0x8,%eax
  800687:	8b 50 04             	mov    0x4(%eax),%edx
  80068a:	8b 00                	mov    (%eax),%eax
  80068c:	eb 40                	jmp    8006ce <getuint+0x65>
	else if (lflag)
  80068e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800692:	74 1e                	je     8006b2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	8b 00                	mov    (%eax),%eax
  800699:	8d 50 04             	lea    0x4(%eax),%edx
  80069c:	8b 45 08             	mov    0x8(%ebp),%eax
  80069f:	89 10                	mov    %edx,(%eax)
  8006a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a4:	8b 00                	mov    (%eax),%eax
  8006a6:	83 e8 04             	sub    $0x4,%eax
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	ba 00 00 00 00       	mov    $0x0,%edx
  8006b0:	eb 1c                	jmp    8006ce <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	8d 50 04             	lea    0x4(%eax),%edx
  8006ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bd:	89 10                	mov    %edx,(%eax)
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	8b 00                	mov    (%eax),%eax
  8006c4:	83 e8 04             	sub    $0x4,%eax
  8006c7:	8b 00                	mov    (%eax),%eax
  8006c9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006ce:	5d                   	pop    %ebp
  8006cf:	c3                   	ret    

008006d0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006d0:	55                   	push   %ebp
  8006d1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006d3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006d7:	7e 1c                	jle    8006f5 <getint+0x25>
		return va_arg(*ap, long long);
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	8d 50 08             	lea    0x8(%eax),%edx
  8006e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e4:	89 10                	mov    %edx,(%eax)
  8006e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e9:	8b 00                	mov    (%eax),%eax
  8006eb:	83 e8 08             	sub    $0x8,%eax
  8006ee:	8b 50 04             	mov    0x4(%eax),%edx
  8006f1:	8b 00                	mov    (%eax),%eax
  8006f3:	eb 38                	jmp    80072d <getint+0x5d>
	else if (lflag)
  8006f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006f9:	74 1a                	je     800715 <getint+0x45>
		return va_arg(*ap, long);
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	8b 00                	mov    (%eax),%eax
  800700:	8d 50 04             	lea    0x4(%eax),%edx
  800703:	8b 45 08             	mov    0x8(%ebp),%eax
  800706:	89 10                	mov    %edx,(%eax)
  800708:	8b 45 08             	mov    0x8(%ebp),%eax
  80070b:	8b 00                	mov    (%eax),%eax
  80070d:	83 e8 04             	sub    $0x4,%eax
  800710:	8b 00                	mov    (%eax),%eax
  800712:	99                   	cltd   
  800713:	eb 18                	jmp    80072d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	8d 50 04             	lea    0x4(%eax),%edx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	89 10                	mov    %edx,(%eax)
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	83 e8 04             	sub    $0x4,%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	99                   	cltd   
}
  80072d:	5d                   	pop    %ebp
  80072e:	c3                   	ret    

0080072f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80072f:	55                   	push   %ebp
  800730:	89 e5                	mov    %esp,%ebp
  800732:	56                   	push   %esi
  800733:	53                   	push   %ebx
  800734:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800737:	eb 17                	jmp    800750 <vprintfmt+0x21>
			if (ch == '\0')
  800739:	85 db                	test   %ebx,%ebx
  80073b:	0f 84 af 03 00 00    	je     800af0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800741:	83 ec 08             	sub    $0x8,%esp
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	53                   	push   %ebx
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	ff d0                	call   *%eax
  80074d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800750:	8b 45 10             	mov    0x10(%ebp),%eax
  800753:	8d 50 01             	lea    0x1(%eax),%edx
  800756:	89 55 10             	mov    %edx,0x10(%ebp)
  800759:	8a 00                	mov    (%eax),%al
  80075b:	0f b6 d8             	movzbl %al,%ebx
  80075e:	83 fb 25             	cmp    $0x25,%ebx
  800761:	75 d6                	jne    800739 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800763:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800767:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80076e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800775:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80077c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800783:	8b 45 10             	mov    0x10(%ebp),%eax
  800786:	8d 50 01             	lea    0x1(%eax),%edx
  800789:	89 55 10             	mov    %edx,0x10(%ebp)
  80078c:	8a 00                	mov    (%eax),%al
  80078e:	0f b6 d8             	movzbl %al,%ebx
  800791:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800794:	83 f8 55             	cmp    $0x55,%eax
  800797:	0f 87 2b 03 00 00    	ja     800ac8 <vprintfmt+0x399>
  80079d:	8b 04 85 78 26 80 00 	mov    0x802678(,%eax,4),%eax
  8007a4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007a6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007aa:	eb d7                	jmp    800783 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007ac:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007b0:	eb d1                	jmp    800783 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007bc:	89 d0                	mov    %edx,%eax
  8007be:	c1 e0 02             	shl    $0x2,%eax
  8007c1:	01 d0                	add    %edx,%eax
  8007c3:	01 c0                	add    %eax,%eax
  8007c5:	01 d8                	add    %ebx,%eax
  8007c7:	83 e8 30             	sub    $0x30,%eax
  8007ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d0:	8a 00                	mov    (%eax),%al
  8007d2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007d5:	83 fb 2f             	cmp    $0x2f,%ebx
  8007d8:	7e 3e                	jle    800818 <vprintfmt+0xe9>
  8007da:	83 fb 39             	cmp    $0x39,%ebx
  8007dd:	7f 39                	jg     800818 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007df:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007e2:	eb d5                	jmp    8007b9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e7:	83 c0 04             	add    $0x4,%eax
  8007ea:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f0:	83 e8 04             	sub    $0x4,%eax
  8007f3:	8b 00                	mov    (%eax),%eax
  8007f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007f8:	eb 1f                	jmp    800819 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007fe:	79 83                	jns    800783 <vprintfmt+0x54>
				width = 0;
  800800:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800807:	e9 77 ff ff ff       	jmp    800783 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80080c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800813:	e9 6b ff ff ff       	jmp    800783 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800818:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800819:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80081d:	0f 89 60 ff ff ff    	jns    800783 <vprintfmt+0x54>
				width = precision, precision = -1;
  800823:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800826:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800829:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800830:	e9 4e ff ff ff       	jmp    800783 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800835:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800838:	e9 46 ff ff ff       	jmp    800783 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80083d:	8b 45 14             	mov    0x14(%ebp),%eax
  800840:	83 c0 04             	add    $0x4,%eax
  800843:	89 45 14             	mov    %eax,0x14(%ebp)
  800846:	8b 45 14             	mov    0x14(%ebp),%eax
  800849:	83 e8 04             	sub    $0x4,%eax
  80084c:	8b 00                	mov    (%eax),%eax
  80084e:	83 ec 08             	sub    $0x8,%esp
  800851:	ff 75 0c             	pushl  0xc(%ebp)
  800854:	50                   	push   %eax
  800855:	8b 45 08             	mov    0x8(%ebp),%eax
  800858:	ff d0                	call   *%eax
  80085a:	83 c4 10             	add    $0x10,%esp
			break;
  80085d:	e9 89 02 00 00       	jmp    800aeb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800862:	8b 45 14             	mov    0x14(%ebp),%eax
  800865:	83 c0 04             	add    $0x4,%eax
  800868:	89 45 14             	mov    %eax,0x14(%ebp)
  80086b:	8b 45 14             	mov    0x14(%ebp),%eax
  80086e:	83 e8 04             	sub    $0x4,%eax
  800871:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800873:	85 db                	test   %ebx,%ebx
  800875:	79 02                	jns    800879 <vprintfmt+0x14a>
				err = -err;
  800877:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800879:	83 fb 64             	cmp    $0x64,%ebx
  80087c:	7f 0b                	jg     800889 <vprintfmt+0x15a>
  80087e:	8b 34 9d c0 24 80 00 	mov    0x8024c0(,%ebx,4),%esi
  800885:	85 f6                	test   %esi,%esi
  800887:	75 19                	jne    8008a2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800889:	53                   	push   %ebx
  80088a:	68 65 26 80 00       	push   $0x802665
  80088f:	ff 75 0c             	pushl  0xc(%ebp)
  800892:	ff 75 08             	pushl  0x8(%ebp)
  800895:	e8 5e 02 00 00       	call   800af8 <printfmt>
  80089a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80089d:	e9 49 02 00 00       	jmp    800aeb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008a2:	56                   	push   %esi
  8008a3:	68 6e 26 80 00       	push   $0x80266e
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	ff 75 08             	pushl  0x8(%ebp)
  8008ae:	e8 45 02 00 00       	call   800af8 <printfmt>
  8008b3:	83 c4 10             	add    $0x10,%esp
			break;
  8008b6:	e9 30 02 00 00       	jmp    800aeb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8008be:	83 c0 04             	add    $0x4,%eax
  8008c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c7:	83 e8 04             	sub    $0x4,%eax
  8008ca:	8b 30                	mov    (%eax),%esi
  8008cc:	85 f6                	test   %esi,%esi
  8008ce:	75 05                	jne    8008d5 <vprintfmt+0x1a6>
				p = "(null)";
  8008d0:	be 71 26 80 00       	mov    $0x802671,%esi
			if (width > 0 && padc != '-')
  8008d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d9:	7e 6d                	jle    800948 <vprintfmt+0x219>
  8008db:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008df:	74 67                	je     800948 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e4:	83 ec 08             	sub    $0x8,%esp
  8008e7:	50                   	push   %eax
  8008e8:	56                   	push   %esi
  8008e9:	e8 0c 03 00 00       	call   800bfa <strnlen>
  8008ee:	83 c4 10             	add    $0x10,%esp
  8008f1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008f4:	eb 16                	jmp    80090c <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008f6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	50                   	push   %eax
  800901:	8b 45 08             	mov    0x8(%ebp),%eax
  800904:	ff d0                	call   *%eax
  800906:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800909:	ff 4d e4             	decl   -0x1c(%ebp)
  80090c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800910:	7f e4                	jg     8008f6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800912:	eb 34                	jmp    800948 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800914:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800918:	74 1c                	je     800936 <vprintfmt+0x207>
  80091a:	83 fb 1f             	cmp    $0x1f,%ebx
  80091d:	7e 05                	jle    800924 <vprintfmt+0x1f5>
  80091f:	83 fb 7e             	cmp    $0x7e,%ebx
  800922:	7e 12                	jle    800936 <vprintfmt+0x207>
					putch('?', putdat);
  800924:	83 ec 08             	sub    $0x8,%esp
  800927:	ff 75 0c             	pushl  0xc(%ebp)
  80092a:	6a 3f                	push   $0x3f
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	ff d0                	call   *%eax
  800931:	83 c4 10             	add    $0x10,%esp
  800934:	eb 0f                	jmp    800945 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800936:	83 ec 08             	sub    $0x8,%esp
  800939:	ff 75 0c             	pushl  0xc(%ebp)
  80093c:	53                   	push   %ebx
  80093d:	8b 45 08             	mov    0x8(%ebp),%eax
  800940:	ff d0                	call   *%eax
  800942:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800945:	ff 4d e4             	decl   -0x1c(%ebp)
  800948:	89 f0                	mov    %esi,%eax
  80094a:	8d 70 01             	lea    0x1(%eax),%esi
  80094d:	8a 00                	mov    (%eax),%al
  80094f:	0f be d8             	movsbl %al,%ebx
  800952:	85 db                	test   %ebx,%ebx
  800954:	74 24                	je     80097a <vprintfmt+0x24b>
  800956:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80095a:	78 b8                	js     800914 <vprintfmt+0x1e5>
  80095c:	ff 4d e0             	decl   -0x20(%ebp)
  80095f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800963:	79 af                	jns    800914 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800965:	eb 13                	jmp    80097a <vprintfmt+0x24b>
				putch(' ', putdat);
  800967:	83 ec 08             	sub    $0x8,%esp
  80096a:	ff 75 0c             	pushl  0xc(%ebp)
  80096d:	6a 20                	push   $0x20
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	ff d0                	call   *%eax
  800974:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800977:	ff 4d e4             	decl   -0x1c(%ebp)
  80097a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80097e:	7f e7                	jg     800967 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800980:	e9 66 01 00 00       	jmp    800aeb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800985:	83 ec 08             	sub    $0x8,%esp
  800988:	ff 75 e8             	pushl  -0x18(%ebp)
  80098b:	8d 45 14             	lea    0x14(%ebp),%eax
  80098e:	50                   	push   %eax
  80098f:	e8 3c fd ff ff       	call   8006d0 <getint>
  800994:	83 c4 10             	add    $0x10,%esp
  800997:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80099d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009a3:	85 d2                	test   %edx,%edx
  8009a5:	79 23                	jns    8009ca <vprintfmt+0x29b>
				putch('-', putdat);
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	6a 2d                	push   $0x2d
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	ff d0                	call   *%eax
  8009b4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009bd:	f7 d8                	neg    %eax
  8009bf:	83 d2 00             	adc    $0x0,%edx
  8009c2:	f7 da                	neg    %edx
  8009c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009ca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009d1:	e9 bc 00 00 00       	jmp    800a92 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	ff 75 e8             	pushl  -0x18(%ebp)
  8009dc:	8d 45 14             	lea    0x14(%ebp),%eax
  8009df:	50                   	push   %eax
  8009e0:	e8 84 fc ff ff       	call   800669 <getuint>
  8009e5:	83 c4 10             	add    $0x10,%esp
  8009e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009ee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009f5:	e9 98 00 00 00       	jmp    800a92 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	ff 75 0c             	pushl  0xc(%ebp)
  800a00:	6a 58                	push   $0x58
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	ff d0                	call   *%eax
  800a07:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 0c             	pushl  0xc(%ebp)
  800a10:	6a 58                	push   $0x58
  800a12:	8b 45 08             	mov    0x8(%ebp),%eax
  800a15:	ff d0                	call   *%eax
  800a17:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a1a:	83 ec 08             	sub    $0x8,%esp
  800a1d:	ff 75 0c             	pushl  0xc(%ebp)
  800a20:	6a 58                	push   $0x58
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	ff d0                	call   *%eax
  800a27:	83 c4 10             	add    $0x10,%esp
			break;
  800a2a:	e9 bc 00 00 00       	jmp    800aeb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a2f:	83 ec 08             	sub    $0x8,%esp
  800a32:	ff 75 0c             	pushl  0xc(%ebp)
  800a35:	6a 30                	push   $0x30
  800a37:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3a:	ff d0                	call   *%eax
  800a3c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	6a 78                	push   $0x78
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	ff d0                	call   *%eax
  800a4c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a52:	83 c0 04             	add    $0x4,%eax
  800a55:	89 45 14             	mov    %eax,0x14(%ebp)
  800a58:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5b:	83 e8 04             	sub    $0x4,%eax
  800a5e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a6a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a71:	eb 1f                	jmp    800a92 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a73:	83 ec 08             	sub    $0x8,%esp
  800a76:	ff 75 e8             	pushl  -0x18(%ebp)
  800a79:	8d 45 14             	lea    0x14(%ebp),%eax
  800a7c:	50                   	push   %eax
  800a7d:	e8 e7 fb ff ff       	call   800669 <getuint>
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a88:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a8b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a92:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a99:	83 ec 04             	sub    $0x4,%esp
  800a9c:	52                   	push   %edx
  800a9d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800aa0:	50                   	push   %eax
  800aa1:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa4:	ff 75 f0             	pushl  -0x10(%ebp)
  800aa7:	ff 75 0c             	pushl  0xc(%ebp)
  800aaa:	ff 75 08             	pushl  0x8(%ebp)
  800aad:	e8 00 fb ff ff       	call   8005b2 <printnum>
  800ab2:	83 c4 20             	add    $0x20,%esp
			break;
  800ab5:	eb 34                	jmp    800aeb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ab7:	83 ec 08             	sub    $0x8,%esp
  800aba:	ff 75 0c             	pushl  0xc(%ebp)
  800abd:	53                   	push   %ebx
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	ff d0                	call   *%eax
  800ac3:	83 c4 10             	add    $0x10,%esp
			break;
  800ac6:	eb 23                	jmp    800aeb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ac8:	83 ec 08             	sub    $0x8,%esp
  800acb:	ff 75 0c             	pushl  0xc(%ebp)
  800ace:	6a 25                	push   $0x25
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	ff d0                	call   *%eax
  800ad5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ad8:	ff 4d 10             	decl   0x10(%ebp)
  800adb:	eb 03                	jmp    800ae0 <vprintfmt+0x3b1>
  800add:	ff 4d 10             	decl   0x10(%ebp)
  800ae0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae3:	48                   	dec    %eax
  800ae4:	8a 00                	mov    (%eax),%al
  800ae6:	3c 25                	cmp    $0x25,%al
  800ae8:	75 f3                	jne    800add <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800aea:	90                   	nop
		}
	}
  800aeb:	e9 47 fc ff ff       	jmp    800737 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800af0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800af1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800af4:	5b                   	pop    %ebx
  800af5:	5e                   	pop    %esi
  800af6:	5d                   	pop    %ebp
  800af7:	c3                   	ret    

00800af8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800af8:	55                   	push   %ebp
  800af9:	89 e5                	mov    %esp,%ebp
  800afb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800afe:	8d 45 10             	lea    0x10(%ebp),%eax
  800b01:	83 c0 04             	add    $0x4,%eax
  800b04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b07:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0a:	ff 75 f4             	pushl  -0xc(%ebp)
  800b0d:	50                   	push   %eax
  800b0e:	ff 75 0c             	pushl  0xc(%ebp)
  800b11:	ff 75 08             	pushl  0x8(%ebp)
  800b14:	e8 16 fc ff ff       	call   80072f <vprintfmt>
  800b19:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b1c:	90                   	nop
  800b1d:	c9                   	leave  
  800b1e:	c3                   	ret    

00800b1f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b25:	8b 40 08             	mov    0x8(%eax),%eax
  800b28:	8d 50 01             	lea    0x1(%eax),%edx
  800b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b34:	8b 10                	mov    (%eax),%edx
  800b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b39:	8b 40 04             	mov    0x4(%eax),%eax
  800b3c:	39 c2                	cmp    %eax,%edx
  800b3e:	73 12                	jae    800b52 <sprintputch+0x33>
		*b->buf++ = ch;
  800b40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b43:	8b 00                	mov    (%eax),%eax
  800b45:	8d 48 01             	lea    0x1(%eax),%ecx
  800b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4b:	89 0a                	mov    %ecx,(%edx)
  800b4d:	8b 55 08             	mov    0x8(%ebp),%edx
  800b50:	88 10                	mov    %dl,(%eax)
}
  800b52:	90                   	nop
  800b53:	5d                   	pop    %ebp
  800b54:	c3                   	ret    

00800b55 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b64:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	01 d0                	add    %edx,%eax
  800b6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b76:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b7a:	74 06                	je     800b82 <vsnprintf+0x2d>
  800b7c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b80:	7f 07                	jg     800b89 <vsnprintf+0x34>
		return -E_INVAL;
  800b82:	b8 03 00 00 00       	mov    $0x3,%eax
  800b87:	eb 20                	jmp    800ba9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b89:	ff 75 14             	pushl  0x14(%ebp)
  800b8c:	ff 75 10             	pushl  0x10(%ebp)
  800b8f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b92:	50                   	push   %eax
  800b93:	68 1f 0b 80 00       	push   $0x800b1f
  800b98:	e8 92 fb ff ff       	call   80072f <vprintfmt>
  800b9d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ba0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ba3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ba9:	c9                   	leave  
  800baa:	c3                   	ret    

00800bab <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bab:	55                   	push   %ebp
  800bac:	89 e5                	mov    %esp,%ebp
  800bae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bb1:	8d 45 10             	lea    0x10(%ebp),%eax
  800bb4:	83 c0 04             	add    $0x4,%eax
  800bb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bba:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc0:	50                   	push   %eax
  800bc1:	ff 75 0c             	pushl  0xc(%ebp)
  800bc4:	ff 75 08             	pushl  0x8(%ebp)
  800bc7:	e8 89 ff ff ff       	call   800b55 <vsnprintf>
  800bcc:	83 c4 10             	add    $0x10,%esp
  800bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd5:	c9                   	leave  
  800bd6:	c3                   	ret    

00800bd7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bd7:	55                   	push   %ebp
  800bd8:	89 e5                	mov    %esp,%ebp
  800bda:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bdd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be4:	eb 06                	jmp    800bec <strlen+0x15>
		n++;
  800be6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800be9:	ff 45 08             	incl   0x8(%ebp)
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	8a 00                	mov    (%eax),%al
  800bf1:	84 c0                	test   %al,%al
  800bf3:	75 f1                	jne    800be6 <strlen+0xf>
		n++;
	return n;
  800bf5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bf8:	c9                   	leave  
  800bf9:	c3                   	ret    

00800bfa <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
  800bfd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c00:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c07:	eb 09                	jmp    800c12 <strnlen+0x18>
		n++;
  800c09:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c0c:	ff 45 08             	incl   0x8(%ebp)
  800c0f:	ff 4d 0c             	decl   0xc(%ebp)
  800c12:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c16:	74 09                	je     800c21 <strnlen+0x27>
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	8a 00                	mov    (%eax),%al
  800c1d:	84 c0                	test   %al,%al
  800c1f:	75 e8                	jne    800c09 <strnlen+0xf>
		n++;
	return n;
  800c21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c24:	c9                   	leave  
  800c25:	c3                   	ret    

00800c26 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c32:	90                   	nop
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	8d 50 01             	lea    0x1(%eax),%edx
  800c39:	89 55 08             	mov    %edx,0x8(%ebp)
  800c3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c3f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c42:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c45:	8a 12                	mov    (%edx),%dl
  800c47:	88 10                	mov    %dl,(%eax)
  800c49:	8a 00                	mov    (%eax),%al
  800c4b:	84 c0                	test   %al,%al
  800c4d:	75 e4                	jne    800c33 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c52:	c9                   	leave  
  800c53:	c3                   	ret    

00800c54 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c54:	55                   	push   %ebp
  800c55:	89 e5                	mov    %esp,%ebp
  800c57:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c67:	eb 1f                	jmp    800c88 <strncpy+0x34>
		*dst++ = *src;
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	8d 50 01             	lea    0x1(%eax),%edx
  800c6f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c75:	8a 12                	mov    (%edx),%dl
  800c77:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	84 c0                	test   %al,%al
  800c80:	74 03                	je     800c85 <strncpy+0x31>
			src++;
  800c82:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c85:	ff 45 fc             	incl   -0x4(%ebp)
  800c88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c8b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c8e:	72 d9                	jb     800c69 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c90:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c93:	c9                   	leave  
  800c94:	c3                   	ret    

00800c95 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c95:	55                   	push   %ebp
  800c96:	89 e5                	mov    %esp,%ebp
  800c98:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ca1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca5:	74 30                	je     800cd7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ca7:	eb 16                	jmp    800cbf <strlcpy+0x2a>
			*dst++ = *src++;
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	8d 50 01             	lea    0x1(%eax),%edx
  800caf:	89 55 08             	mov    %edx,0x8(%ebp)
  800cb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cb8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cbb:	8a 12                	mov    (%edx),%dl
  800cbd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cbf:	ff 4d 10             	decl   0x10(%ebp)
  800cc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc6:	74 09                	je     800cd1 <strlcpy+0x3c>
  800cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	84 c0                	test   %al,%al
  800ccf:	75 d8                	jne    800ca9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cd7:	8b 55 08             	mov    0x8(%ebp),%edx
  800cda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cdd:	29 c2                	sub    %eax,%edx
  800cdf:	89 d0                	mov    %edx,%eax
}
  800ce1:	c9                   	leave  
  800ce2:	c3                   	ret    

00800ce3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ce3:	55                   	push   %ebp
  800ce4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ce6:	eb 06                	jmp    800cee <strcmp+0xb>
		p++, q++;
  800ce8:	ff 45 08             	incl   0x8(%ebp)
  800ceb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	84 c0                	test   %al,%al
  800cf5:	74 0e                	je     800d05 <strcmp+0x22>
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 10                	mov    (%eax),%dl
  800cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cff:	8a 00                	mov    (%eax),%al
  800d01:	38 c2                	cmp    %al,%dl
  800d03:	74 e3                	je     800ce8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	0f b6 d0             	movzbl %al,%edx
  800d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d10:	8a 00                	mov    (%eax),%al
  800d12:	0f b6 c0             	movzbl %al,%eax
  800d15:	29 c2                	sub    %eax,%edx
  800d17:	89 d0                	mov    %edx,%eax
}
  800d19:	5d                   	pop    %ebp
  800d1a:	c3                   	ret    

00800d1b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d1b:	55                   	push   %ebp
  800d1c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d1e:	eb 09                	jmp    800d29 <strncmp+0xe>
		n--, p++, q++;
  800d20:	ff 4d 10             	decl   0x10(%ebp)
  800d23:	ff 45 08             	incl   0x8(%ebp)
  800d26:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2d:	74 17                	je     800d46 <strncmp+0x2b>
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	84 c0                	test   %al,%al
  800d36:	74 0e                	je     800d46 <strncmp+0x2b>
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 10                	mov    (%eax),%dl
  800d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d40:	8a 00                	mov    (%eax),%al
  800d42:	38 c2                	cmp    %al,%dl
  800d44:	74 da                	je     800d20 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4a:	75 07                	jne    800d53 <strncmp+0x38>
		return 0;
  800d4c:	b8 00 00 00 00       	mov    $0x0,%eax
  800d51:	eb 14                	jmp    800d67 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	8a 00                	mov    (%eax),%al
  800d58:	0f b6 d0             	movzbl %al,%edx
  800d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	0f b6 c0             	movzbl %al,%eax
  800d63:	29 c2                	sub    %eax,%edx
  800d65:	89 d0                	mov    %edx,%eax
}
  800d67:	5d                   	pop    %ebp
  800d68:	c3                   	ret    

00800d69 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d69:	55                   	push   %ebp
  800d6a:	89 e5                	mov    %esp,%ebp
  800d6c:	83 ec 04             	sub    $0x4,%esp
  800d6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d72:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d75:	eb 12                	jmp    800d89 <strchr+0x20>
		if (*s == c)
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8a 00                	mov    (%eax),%al
  800d7c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d7f:	75 05                	jne    800d86 <strchr+0x1d>
			return (char *) s;
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	eb 11                	jmp    800d97 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d86:	ff 45 08             	incl   0x8(%ebp)
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	84 c0                	test   %al,%al
  800d90:	75 e5                	jne    800d77 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d97:	c9                   	leave  
  800d98:	c3                   	ret    

00800d99 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d99:	55                   	push   %ebp
  800d9a:	89 e5                	mov    %esp,%ebp
  800d9c:	83 ec 04             	sub    $0x4,%esp
  800d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800da5:	eb 0d                	jmp    800db4 <strfind+0x1b>
		if (*s == c)
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	8a 00                	mov    (%eax),%al
  800dac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800daf:	74 0e                	je     800dbf <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800db1:	ff 45 08             	incl   0x8(%ebp)
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8a 00                	mov    (%eax),%al
  800db9:	84 c0                	test   %al,%al
  800dbb:	75 ea                	jne    800da7 <strfind+0xe>
  800dbd:	eb 01                	jmp    800dc0 <strfind+0x27>
		if (*s == c)
			break;
  800dbf:	90                   	nop
	return (char *) s;
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc3:	c9                   	leave  
  800dc4:	c3                   	ret    

00800dc5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800dc5:	55                   	push   %ebp
  800dc6:	89 e5                	mov    %esp,%ebp
  800dc8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800dd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dd7:	eb 0e                	jmp    800de7 <memset+0x22>
		*p++ = c;
  800dd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ddc:	8d 50 01             	lea    0x1(%eax),%edx
  800ddf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800de2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800de5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800de7:	ff 4d f8             	decl   -0x8(%ebp)
  800dea:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dee:	79 e9                	jns    800dd9 <memset+0x14>
		*p++ = c;

	return v;
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800df3:	c9                   	leave  
  800df4:	c3                   	ret    

00800df5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800df5:	55                   	push   %ebp
  800df6:	89 e5                	mov    %esp,%ebp
  800df8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e07:	eb 16                	jmp    800e1f <memcpy+0x2a>
		*d++ = *s++;
  800e09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0c:	8d 50 01             	lea    0x1(%eax),%edx
  800e0f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e12:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e15:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e18:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e1b:	8a 12                	mov    (%edx),%dl
  800e1d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e22:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e25:	89 55 10             	mov    %edx,0x10(%ebp)
  800e28:	85 c0                	test   %eax,%eax
  800e2a:	75 dd                	jne    800e09 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e2f:	c9                   	leave  
  800e30:	c3                   	ret    

00800e31 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e31:	55                   	push   %ebp
  800e32:	89 e5                	mov    %esp,%ebp
  800e34:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e46:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e49:	73 50                	jae    800e9b <memmove+0x6a>
  800e4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e51:	01 d0                	add    %edx,%eax
  800e53:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e56:	76 43                	jbe    800e9b <memmove+0x6a>
		s += n;
  800e58:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e61:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e64:	eb 10                	jmp    800e76 <memmove+0x45>
			*--d = *--s;
  800e66:	ff 4d f8             	decl   -0x8(%ebp)
  800e69:	ff 4d fc             	decl   -0x4(%ebp)
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6f:	8a 10                	mov    (%eax),%dl
  800e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e74:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e76:	8b 45 10             	mov    0x10(%ebp),%eax
  800e79:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e7c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7f:	85 c0                	test   %eax,%eax
  800e81:	75 e3                	jne    800e66 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e83:	eb 23                	jmp    800ea8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e88:	8d 50 01             	lea    0x1(%eax),%edx
  800e8b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e8e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e94:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e97:	8a 12                	mov    (%edx),%dl
  800e99:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea4:	85 c0                	test   %eax,%eax
  800ea6:	75 dd                	jne    800e85 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eab:	c9                   	leave  
  800eac:	c3                   	ret    

00800ead <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ead:	55                   	push   %ebp
  800eae:	89 e5                	mov    %esp,%ebp
  800eb0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ebf:	eb 2a                	jmp    800eeb <memcmp+0x3e>
		if (*s1 != *s2)
  800ec1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec4:	8a 10                	mov    (%eax),%dl
  800ec6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec9:	8a 00                	mov    (%eax),%al
  800ecb:	38 c2                	cmp    %al,%dl
  800ecd:	74 16                	je     800ee5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ecf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed2:	8a 00                	mov    (%eax),%al
  800ed4:	0f b6 d0             	movzbl %al,%edx
  800ed7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	0f b6 c0             	movzbl %al,%eax
  800edf:	29 c2                	sub    %eax,%edx
  800ee1:	89 d0                	mov    %edx,%eax
  800ee3:	eb 18                	jmp    800efd <memcmp+0x50>
		s1++, s2++;
  800ee5:	ff 45 fc             	incl   -0x4(%ebp)
  800ee8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800eeb:	8b 45 10             	mov    0x10(%ebp),%eax
  800eee:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef4:	85 c0                	test   %eax,%eax
  800ef6:	75 c9                	jne    800ec1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ef8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
  800f02:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f05:	8b 55 08             	mov    0x8(%ebp),%edx
  800f08:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0b:	01 d0                	add    %edx,%eax
  800f0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f10:	eb 15                	jmp    800f27 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	0f b6 d0             	movzbl %al,%edx
  800f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1d:	0f b6 c0             	movzbl %al,%eax
  800f20:	39 c2                	cmp    %eax,%edx
  800f22:	74 0d                	je     800f31 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f24:	ff 45 08             	incl   0x8(%ebp)
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f2d:	72 e3                	jb     800f12 <memfind+0x13>
  800f2f:	eb 01                	jmp    800f32 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f31:	90                   	nop
	return (void *) s;
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f35:	c9                   	leave  
  800f36:	c3                   	ret    

00800f37 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f37:	55                   	push   %ebp
  800f38:	89 e5                	mov    %esp,%ebp
  800f3a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f44:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f4b:	eb 03                	jmp    800f50 <strtol+0x19>
		s++;
  800f4d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	3c 20                	cmp    $0x20,%al
  800f57:	74 f4                	je     800f4d <strtol+0x16>
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	3c 09                	cmp    $0x9,%al
  800f60:	74 eb                	je     800f4d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3c 2b                	cmp    $0x2b,%al
  800f69:	75 05                	jne    800f70 <strtol+0x39>
		s++;
  800f6b:	ff 45 08             	incl   0x8(%ebp)
  800f6e:	eb 13                	jmp    800f83 <strtol+0x4c>
	else if (*s == '-')
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	3c 2d                	cmp    $0x2d,%al
  800f77:	75 0a                	jne    800f83 <strtol+0x4c>
		s++, neg = 1;
  800f79:	ff 45 08             	incl   0x8(%ebp)
  800f7c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f87:	74 06                	je     800f8f <strtol+0x58>
  800f89:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f8d:	75 20                	jne    800faf <strtol+0x78>
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	3c 30                	cmp    $0x30,%al
  800f96:	75 17                	jne    800faf <strtol+0x78>
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	40                   	inc    %eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	3c 78                	cmp    $0x78,%al
  800fa0:	75 0d                	jne    800faf <strtol+0x78>
		s += 2, base = 16;
  800fa2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fa6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fad:	eb 28                	jmp    800fd7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800faf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb3:	75 15                	jne    800fca <strtol+0x93>
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 30                	cmp    $0x30,%al
  800fbc:	75 0c                	jne    800fca <strtol+0x93>
		s++, base = 8;
  800fbe:	ff 45 08             	incl   0x8(%ebp)
  800fc1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fc8:	eb 0d                	jmp    800fd7 <strtol+0xa0>
	else if (base == 0)
  800fca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fce:	75 07                	jne    800fd7 <strtol+0xa0>
		base = 10;
  800fd0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 2f                	cmp    $0x2f,%al
  800fde:	7e 19                	jle    800ff9 <strtol+0xc2>
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	3c 39                	cmp    $0x39,%al
  800fe7:	7f 10                	jg     800ff9 <strtol+0xc2>
			dig = *s - '0';
  800fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fec:	8a 00                	mov    (%eax),%al
  800fee:	0f be c0             	movsbl %al,%eax
  800ff1:	83 e8 30             	sub    $0x30,%eax
  800ff4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ff7:	eb 42                	jmp    80103b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 60                	cmp    $0x60,%al
  801000:	7e 19                	jle    80101b <strtol+0xe4>
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	3c 7a                	cmp    $0x7a,%al
  801009:	7f 10                	jg     80101b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	8a 00                	mov    (%eax),%al
  801010:	0f be c0             	movsbl %al,%eax
  801013:	83 e8 57             	sub    $0x57,%eax
  801016:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801019:	eb 20                	jmp    80103b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	3c 40                	cmp    $0x40,%al
  801022:	7e 39                	jle    80105d <strtol+0x126>
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8a 00                	mov    (%eax),%al
  801029:	3c 5a                	cmp    $0x5a,%al
  80102b:	7f 30                	jg     80105d <strtol+0x126>
			dig = *s - 'A' + 10;
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	0f be c0             	movsbl %al,%eax
  801035:	83 e8 37             	sub    $0x37,%eax
  801038:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80103b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80103e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801041:	7d 19                	jge    80105c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801043:	ff 45 08             	incl   0x8(%ebp)
  801046:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801049:	0f af 45 10          	imul   0x10(%ebp),%eax
  80104d:	89 c2                	mov    %eax,%edx
  80104f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801052:	01 d0                	add    %edx,%eax
  801054:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801057:	e9 7b ff ff ff       	jmp    800fd7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80105c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80105d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801061:	74 08                	je     80106b <strtol+0x134>
		*endptr = (char *) s;
  801063:	8b 45 0c             	mov    0xc(%ebp),%eax
  801066:	8b 55 08             	mov    0x8(%ebp),%edx
  801069:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80106b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80106f:	74 07                	je     801078 <strtol+0x141>
  801071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801074:	f7 d8                	neg    %eax
  801076:	eb 03                	jmp    80107b <strtol+0x144>
  801078:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <ltostr>:

void
ltostr(long value, char *str)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801083:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80108a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801091:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801095:	79 13                	jns    8010aa <ltostr+0x2d>
	{
		neg = 1;
  801097:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010a4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010a7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010b2:	99                   	cltd   
  8010b3:	f7 f9                	idiv   %ecx
  8010b5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010bb:	8d 50 01             	lea    0x1(%eax),%edx
  8010be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010c1:	89 c2                	mov    %eax,%edx
  8010c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c6:	01 d0                	add    %edx,%eax
  8010c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010cb:	83 c2 30             	add    $0x30,%edx
  8010ce:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010d3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010d8:	f7 e9                	imul   %ecx
  8010da:	c1 fa 02             	sar    $0x2,%edx
  8010dd:	89 c8                	mov    %ecx,%eax
  8010df:	c1 f8 1f             	sar    $0x1f,%eax
  8010e2:	29 c2                	sub    %eax,%edx
  8010e4:	89 d0                	mov    %edx,%eax
  8010e6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ec:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010f1:	f7 e9                	imul   %ecx
  8010f3:	c1 fa 02             	sar    $0x2,%edx
  8010f6:	89 c8                	mov    %ecx,%eax
  8010f8:	c1 f8 1f             	sar    $0x1f,%eax
  8010fb:	29 c2                	sub    %eax,%edx
  8010fd:	89 d0                	mov    %edx,%eax
  8010ff:	c1 e0 02             	shl    $0x2,%eax
  801102:	01 d0                	add    %edx,%eax
  801104:	01 c0                	add    %eax,%eax
  801106:	29 c1                	sub    %eax,%ecx
  801108:	89 ca                	mov    %ecx,%edx
  80110a:	85 d2                	test   %edx,%edx
  80110c:	75 9c                	jne    8010aa <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80110e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801115:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801118:	48                   	dec    %eax
  801119:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80111c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801120:	74 3d                	je     80115f <ltostr+0xe2>
		start = 1 ;
  801122:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801129:	eb 34                	jmp    80115f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80112b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80112e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801131:	01 d0                	add    %edx,%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801138:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	01 c2                	add    %eax,%edx
  801140:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801143:	8b 45 0c             	mov    0xc(%ebp),%eax
  801146:	01 c8                	add    %ecx,%eax
  801148:	8a 00                	mov    (%eax),%al
  80114a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80114c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80114f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801152:	01 c2                	add    %eax,%edx
  801154:	8a 45 eb             	mov    -0x15(%ebp),%al
  801157:	88 02                	mov    %al,(%edx)
		start++ ;
  801159:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80115c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80115f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801162:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801165:	7c c4                	jl     80112b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801167:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	01 d0                	add    %edx,%eax
  80116f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801172:	90                   	nop
  801173:	c9                   	leave  
  801174:	c3                   	ret    

00801175 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801175:	55                   	push   %ebp
  801176:	89 e5                	mov    %esp,%ebp
  801178:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80117b:	ff 75 08             	pushl  0x8(%ebp)
  80117e:	e8 54 fa ff ff       	call   800bd7 <strlen>
  801183:	83 c4 04             	add    $0x4,%esp
  801186:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801189:	ff 75 0c             	pushl  0xc(%ebp)
  80118c:	e8 46 fa ff ff       	call   800bd7 <strlen>
  801191:	83 c4 04             	add    $0x4,%esp
  801194:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801197:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80119e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011a5:	eb 17                	jmp    8011be <strcconcat+0x49>
		final[s] = str1[s] ;
  8011a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ad:	01 c2                	add    %eax,%edx
  8011af:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	01 c8                	add    %ecx,%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011bb:	ff 45 fc             	incl   -0x4(%ebp)
  8011be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011c4:	7c e1                	jl     8011a7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011cd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011d4:	eb 1f                	jmp    8011f5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d9:	8d 50 01             	lea    0x1(%eax),%edx
  8011dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011df:	89 c2                	mov    %eax,%edx
  8011e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e4:	01 c2                	add    %eax,%edx
  8011e6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ec:	01 c8                	add    %ecx,%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011f2:	ff 45 f8             	incl   -0x8(%ebp)
  8011f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011fb:	7c d9                	jl     8011d6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801200:	8b 45 10             	mov    0x10(%ebp),%eax
  801203:	01 d0                	add    %edx,%eax
  801205:	c6 00 00             	movb   $0x0,(%eax)
}
  801208:	90                   	nop
  801209:	c9                   	leave  
  80120a:	c3                   	ret    

0080120b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80120b:	55                   	push   %ebp
  80120c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80120e:	8b 45 14             	mov    0x14(%ebp),%eax
  801211:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801217:	8b 45 14             	mov    0x14(%ebp),%eax
  80121a:	8b 00                	mov    (%eax),%eax
  80121c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801223:	8b 45 10             	mov    0x10(%ebp),%eax
  801226:	01 d0                	add    %edx,%eax
  801228:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80122e:	eb 0c                	jmp    80123c <strsplit+0x31>
			*string++ = 0;
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	8d 50 01             	lea    0x1(%eax),%edx
  801236:	89 55 08             	mov    %edx,0x8(%ebp)
  801239:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	8a 00                	mov    (%eax),%al
  801241:	84 c0                	test   %al,%al
  801243:	74 18                	je     80125d <strsplit+0x52>
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	8a 00                	mov    (%eax),%al
  80124a:	0f be c0             	movsbl %al,%eax
  80124d:	50                   	push   %eax
  80124e:	ff 75 0c             	pushl  0xc(%ebp)
  801251:	e8 13 fb ff ff       	call   800d69 <strchr>
  801256:	83 c4 08             	add    $0x8,%esp
  801259:	85 c0                	test   %eax,%eax
  80125b:	75 d3                	jne    801230 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	84 c0                	test   %al,%al
  801264:	74 5a                	je     8012c0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801266:	8b 45 14             	mov    0x14(%ebp),%eax
  801269:	8b 00                	mov    (%eax),%eax
  80126b:	83 f8 0f             	cmp    $0xf,%eax
  80126e:	75 07                	jne    801277 <strsplit+0x6c>
		{
			return 0;
  801270:	b8 00 00 00 00       	mov    $0x0,%eax
  801275:	eb 66                	jmp    8012dd <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801277:	8b 45 14             	mov    0x14(%ebp),%eax
  80127a:	8b 00                	mov    (%eax),%eax
  80127c:	8d 48 01             	lea    0x1(%eax),%ecx
  80127f:	8b 55 14             	mov    0x14(%ebp),%edx
  801282:	89 0a                	mov    %ecx,(%edx)
  801284:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80128b:	8b 45 10             	mov    0x10(%ebp),%eax
  80128e:	01 c2                	add    %eax,%edx
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801295:	eb 03                	jmp    80129a <strsplit+0x8f>
			string++;
  801297:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	8a 00                	mov    (%eax),%al
  80129f:	84 c0                	test   %al,%al
  8012a1:	74 8b                	je     80122e <strsplit+0x23>
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	8a 00                	mov    (%eax),%al
  8012a8:	0f be c0             	movsbl %al,%eax
  8012ab:	50                   	push   %eax
  8012ac:	ff 75 0c             	pushl  0xc(%ebp)
  8012af:	e8 b5 fa ff ff       	call   800d69 <strchr>
  8012b4:	83 c4 08             	add    $0x8,%esp
  8012b7:	85 c0                	test   %eax,%eax
  8012b9:	74 dc                	je     801297 <strsplit+0x8c>
			string++;
	}
  8012bb:	e9 6e ff ff ff       	jmp    80122e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012c0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c4:	8b 00                	mov    (%eax),%eax
  8012c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012d8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
  8012e2:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  8012e5:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  8012ec:	76 0a                	jbe    8012f8 <malloc+0x19>
		return NULL;
  8012ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8012f3:	e9 ad 02 00 00       	jmp    8015a5 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	c1 e8 0c             	shr    $0xc,%eax
  8012fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	25 ff 0f 00 00       	and    $0xfff,%eax
  801309:	85 c0                	test   %eax,%eax
  80130b:	74 03                	je     801310 <malloc+0x31>
		num++;
  80130d:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801310:	a1 28 30 80 00       	mov    0x803028,%eax
  801315:	85 c0                	test   %eax,%eax
  801317:	75 71                	jne    80138a <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801319:	a1 04 30 80 00       	mov    0x803004,%eax
  80131e:	83 ec 08             	sub    $0x8,%esp
  801321:	ff 75 08             	pushl  0x8(%ebp)
  801324:	50                   	push   %eax
  801325:	e8 ba 05 00 00       	call   8018e4 <sys_allocateMem>
  80132a:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  80132d:	a1 04 30 80 00       	mov    0x803004,%eax
  801332:	89 45 c8             	mov    %eax,-0x38(%ebp)
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
  801351:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801358:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80135d:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801360:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801367:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80136c:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801373:	01 00 00 00 
		sizeofarray++;
  801377:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80137c:	40                   	inc    %eax
  80137d:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  801382:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801385:	e9 1b 02 00 00       	jmp    8015a5 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  80138a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801391:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801398:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  80139f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8013a6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8013ad:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8013b4:	eb 72                	jmp    801428 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8013b6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8013b9:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8013c0:	85 c0                	test   %eax,%eax
  8013c2:	75 12                	jne    8013d6 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8013c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8013c7:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8013ce:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  8013d1:	ff 45 dc             	incl   -0x24(%ebp)
  8013d4:	eb 4f                	jmp    801425 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  8013d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013d9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8013dc:	7d 39                	jge    801417 <malloc+0x138>
  8013de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013e4:	7c 31                	jl     801417 <malloc+0x138>
					{
						min=count;
  8013e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  8013ec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8013ef:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8013f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013f9:	c1 e2 0c             	shl    $0xc,%edx
  8013fc:	29 d0                	sub    %edx,%eax
  8013fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801401:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801404:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801407:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  80140a:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801411:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801414:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801417:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  80141e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801425:	ff 45 d4             	incl   -0x2c(%ebp)
  801428:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80142d:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801430:	7c 84                	jl     8013b6 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801432:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801436:	0f 85 e3 00 00 00    	jne    80151f <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  80143c:	83 ec 08             	sub    $0x8,%esp
  80143f:	ff 75 08             	pushl  0x8(%ebp)
  801442:	ff 75 e0             	pushl  -0x20(%ebp)
  801445:	e8 9a 04 00 00       	call   8018e4 <sys_allocateMem>
  80144a:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  80144d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801452:	40                   	inc    %eax
  801453:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  801458:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80145d:	48                   	dec    %eax
  80145e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801461:	eb 42                	jmp    8014a5 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801463:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801466:	48                   	dec    %eax
  801467:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  80146e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801471:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801478:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80147b:	48                   	dec    %eax
  80147c:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801483:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801486:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  80148d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801490:	48                   	dec    %eax
  801491:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801498:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80149b:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  8014a2:	ff 4d d0             	decl   -0x30(%ebp)
  8014a5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8014a8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8014ab:	7f b6                	jg     801463 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8014ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014b0:	40                   	inc    %eax
  8014b1:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8014b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014b7:	01 ca                	add    %ecx,%edx
  8014b9:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8014c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014c3:	8d 50 01             	lea    0x1(%eax),%edx
  8014c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014c9:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8014d0:	2b 45 f4             	sub    -0xc(%ebp),%eax
  8014d3:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  8014da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014dd:	40                   	inc    %eax
  8014de:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  8014e5:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  8014e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014ef:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  8014f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014f9:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8014fc:	eb 11                	jmp    80150f <malloc+0x230>
				{
					changed[index] = 1;
  8014fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801501:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801508:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  80150c:	ff 45 cc             	incl   -0x34(%ebp)
  80150f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801512:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801515:	7c e7                	jl     8014fe <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801517:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80151a:	e9 86 00 00 00       	jmp    8015a5 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  80151f:	a1 04 30 80 00       	mov    0x803004,%eax
  801524:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801529:	29 c2                	sub    %eax,%edx
  80152b:	89 d0                	mov    %edx,%eax
  80152d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801530:	73 07                	jae    801539 <malloc+0x25a>
						return NULL;
  801532:	b8 00 00 00 00       	mov    $0x0,%eax
  801537:	eb 6c                	jmp    8015a5 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801539:	a1 04 30 80 00       	mov    0x803004,%eax
  80153e:	83 ec 08             	sub    $0x8,%esp
  801541:	ff 75 08             	pushl  0x8(%ebp)
  801544:	50                   	push   %eax
  801545:	e8 9a 03 00 00       	call   8018e4 <sys_allocateMem>
  80154a:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  80154d:	a1 04 30 80 00       	mov    0x803004,%eax
  801552:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801555:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801558:	c1 e0 0c             	shl    $0xc,%eax
  80155b:	89 c2                	mov    %eax,%edx
  80155d:	a1 04 30 80 00       	mov    0x803004,%eax
  801562:	01 d0                	add    %edx,%eax
  801564:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801569:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80156e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801571:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801578:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80157d:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801580:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801587:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80158c:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801593:	01 00 00 00 
					sizeofarray++;
  801597:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80159c:	40                   	inc    %eax
  80159d:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  8015a2:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
  8015aa:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8015b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8015ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8015c1:	eb 30                	jmp    8015f3 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8015c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015c6:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8015cd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015d0:	75 1e                	jne    8015f0 <free+0x49>
  8015d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015d5:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8015dc:	83 f8 01             	cmp    $0x1,%eax
  8015df:	75 0f                	jne    8015f0 <free+0x49>
			is_found = 1;
  8015e1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8015e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8015ee:	eb 0d                	jmp    8015fd <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8015f0:	ff 45 ec             	incl   -0x14(%ebp)
  8015f3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015f8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8015fb:	7c c6                	jl     8015c3 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8015fd:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801601:	75 3a                	jne    80163d <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801603:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801606:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  80160d:	c1 e0 0c             	shl    $0xc,%eax
  801610:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801613:	83 ec 08             	sub    $0x8,%esp
  801616:	ff 75 e4             	pushl  -0x1c(%ebp)
  801619:	ff 75 e8             	pushl  -0x18(%ebp)
  80161c:	e8 a7 02 00 00       	call   8018c8 <sys_freeMem>
  801621:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801624:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801627:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  80162e:	00 00 00 00 
		changes++;
  801632:	a1 28 30 80 00       	mov    0x803028,%eax
  801637:	40                   	inc    %eax
  801638:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  80163d:	90                   	nop
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
  801643:	83 ec 18             	sub    $0x18,%esp
  801646:	8b 45 10             	mov    0x10(%ebp),%eax
  801649:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80164c:	83 ec 04             	sub    $0x4,%esp
  80164f:	68 d0 27 80 00       	push   $0x8027d0
  801654:	68 b6 00 00 00       	push   $0xb6
  801659:	68 f3 27 80 00       	push   $0x8027f3
  80165e:	e8 50 ec ff ff       	call   8002b3 <_panic>

00801663 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801669:	83 ec 04             	sub    $0x4,%esp
  80166c:	68 d0 27 80 00       	push   $0x8027d0
  801671:	68 bb 00 00 00       	push   $0xbb
  801676:	68 f3 27 80 00       	push   $0x8027f3
  80167b:	e8 33 ec ff ff       	call   8002b3 <_panic>

00801680 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
  801683:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801686:	83 ec 04             	sub    $0x4,%esp
  801689:	68 d0 27 80 00       	push   $0x8027d0
  80168e:	68 c0 00 00 00       	push   $0xc0
  801693:	68 f3 27 80 00       	push   $0x8027f3
  801698:	e8 16 ec ff ff       	call   8002b3 <_panic>

0080169d <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
  8016a0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016a3:	83 ec 04             	sub    $0x4,%esp
  8016a6:	68 d0 27 80 00       	push   $0x8027d0
  8016ab:	68 c4 00 00 00       	push   $0xc4
  8016b0:	68 f3 27 80 00       	push   $0x8027f3
  8016b5:	e8 f9 eb ff ff       	call   8002b3 <_panic>

008016ba <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
  8016bd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016c0:	83 ec 04             	sub    $0x4,%esp
  8016c3:	68 d0 27 80 00       	push   $0x8027d0
  8016c8:	68 c9 00 00 00       	push   $0xc9
  8016cd:	68 f3 27 80 00       	push   $0x8027f3
  8016d2:	e8 dc eb ff ff       	call   8002b3 <_panic>

008016d7 <shrink>:
}
void shrink(uint32 newSize) {
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
  8016da:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016dd:	83 ec 04             	sub    $0x4,%esp
  8016e0:	68 d0 27 80 00       	push   $0x8027d0
  8016e5:	68 cc 00 00 00       	push   $0xcc
  8016ea:	68 f3 27 80 00       	push   $0x8027f3
  8016ef:	e8 bf eb ff ff       	call   8002b3 <_panic>

008016f4 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
  8016f7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016fa:	83 ec 04             	sub    $0x4,%esp
  8016fd:	68 d0 27 80 00       	push   $0x8027d0
  801702:	68 d0 00 00 00       	push   $0xd0
  801707:	68 f3 27 80 00       	push   $0x8027f3
  80170c:	e8 a2 eb ff ff       	call   8002b3 <_panic>

00801711 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
  801714:	57                   	push   %edi
  801715:	56                   	push   %esi
  801716:	53                   	push   %ebx
  801717:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801720:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801723:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801726:	8b 7d 18             	mov    0x18(%ebp),%edi
  801729:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80172c:	cd 30                	int    $0x30
  80172e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801731:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801734:	83 c4 10             	add    $0x10,%esp
  801737:	5b                   	pop    %ebx
  801738:	5e                   	pop    %esi
  801739:	5f                   	pop    %edi
  80173a:	5d                   	pop    %ebp
  80173b:	c3                   	ret    

0080173c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
  80173f:	83 ec 04             	sub    $0x4,%esp
  801742:	8b 45 10             	mov    0x10(%ebp),%eax
  801745:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801748:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80174c:	8b 45 08             	mov    0x8(%ebp),%eax
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	52                   	push   %edx
  801754:	ff 75 0c             	pushl  0xc(%ebp)
  801757:	50                   	push   %eax
  801758:	6a 00                	push   $0x0
  80175a:	e8 b2 ff ff ff       	call   801711 <syscall>
  80175f:	83 c4 18             	add    $0x18,%esp
}
  801762:	90                   	nop
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <sys_cgetc>:

int
sys_cgetc(void)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 01                	push   $0x1
  801774:	e8 98 ff ff ff       	call   801711 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	50                   	push   %eax
  80178d:	6a 05                	push   $0x5
  80178f:	e8 7d ff ff ff       	call   801711 <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 02                	push   $0x2
  8017a8:	e8 64 ff ff ff       	call   801711 <syscall>
  8017ad:	83 c4 18             	add    $0x18,%esp
}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 03                	push   $0x3
  8017c1:	e8 4b ff ff ff       	call   801711 <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 04                	push   $0x4
  8017da:	e8 32 ff ff ff       	call   801711 <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <sys_env_exit>:


void sys_env_exit(void)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 06                	push   $0x6
  8017f3:	e8 19 ff ff ff       	call   801711 <syscall>
  8017f8:	83 c4 18             	add    $0x18,%esp
}
  8017fb:	90                   	nop
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801801:	8b 55 0c             	mov    0xc(%ebp),%edx
  801804:	8b 45 08             	mov    0x8(%ebp),%eax
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	52                   	push   %edx
  80180e:	50                   	push   %eax
  80180f:	6a 07                	push   $0x7
  801811:	e8 fb fe ff ff       	call   801711 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
}
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
  80181e:	56                   	push   %esi
  80181f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801820:	8b 75 18             	mov    0x18(%ebp),%esi
  801823:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801826:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801829:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	56                   	push   %esi
  801830:	53                   	push   %ebx
  801831:	51                   	push   %ecx
  801832:	52                   	push   %edx
  801833:	50                   	push   %eax
  801834:	6a 08                	push   $0x8
  801836:	e8 d6 fe ff ff       	call   801711 <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
}
  80183e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801841:	5b                   	pop    %ebx
  801842:	5e                   	pop    %esi
  801843:	5d                   	pop    %ebp
  801844:	c3                   	ret    

00801845 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801845:	55                   	push   %ebp
  801846:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801848:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184b:	8b 45 08             	mov    0x8(%ebp),%eax
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	52                   	push   %edx
  801855:	50                   	push   %eax
  801856:	6a 09                	push   $0x9
  801858:	e8 b4 fe ff ff       	call   801711 <syscall>
  80185d:	83 c4 18             	add    $0x18,%esp
}
  801860:	c9                   	leave  
  801861:	c3                   	ret    

00801862 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801862:	55                   	push   %ebp
  801863:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	ff 75 0c             	pushl  0xc(%ebp)
  80186e:	ff 75 08             	pushl  0x8(%ebp)
  801871:	6a 0a                	push   $0xa
  801873:	e8 99 fe ff ff       	call   801711 <syscall>
  801878:	83 c4 18             	add    $0x18,%esp
}
  80187b:	c9                   	leave  
  80187c:	c3                   	ret    

0080187d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80187d:	55                   	push   %ebp
  80187e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 0b                	push   $0xb
  80188c:	e8 80 fe ff ff       	call   801711 <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 0c                	push   $0xc
  8018a5:	e8 67 fe ff ff       	call   801711 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 0d                	push   $0xd
  8018be:	e8 4e fe ff ff       	call   801711 <syscall>
  8018c3:	83 c4 18             	add    $0x18,%esp
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	ff 75 0c             	pushl  0xc(%ebp)
  8018d4:	ff 75 08             	pushl  0x8(%ebp)
  8018d7:	6a 11                	push   $0x11
  8018d9:	e8 33 fe ff ff       	call   801711 <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
	return;
  8018e1:	90                   	nop
}
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	ff 75 0c             	pushl  0xc(%ebp)
  8018f0:	ff 75 08             	pushl  0x8(%ebp)
  8018f3:	6a 12                	push   $0x12
  8018f5:	e8 17 fe ff ff       	call   801711 <syscall>
  8018fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8018fd:	90                   	nop
}
  8018fe:	c9                   	leave  
  8018ff:	c3                   	ret    

00801900 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801900:	55                   	push   %ebp
  801901:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 0e                	push   $0xe
  80190f:	e8 fd fd ff ff       	call   801711 <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
}
  801917:	c9                   	leave  
  801918:	c3                   	ret    

00801919 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	ff 75 08             	pushl  0x8(%ebp)
  801927:	6a 0f                	push   $0xf
  801929:	e8 e3 fd ff ff       	call   801711 <syscall>
  80192e:	83 c4 18             	add    $0x18,%esp
}
  801931:	c9                   	leave  
  801932:	c3                   	ret    

00801933 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801933:	55                   	push   %ebp
  801934:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 10                	push   $0x10
  801942:	e8 ca fd ff ff       	call   801711 <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
}
  80194a:	90                   	nop
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 14                	push   $0x14
  80195c:	e8 b0 fd ff ff       	call   801711 <syscall>
  801961:	83 c4 18             	add    $0x18,%esp
}
  801964:	90                   	nop
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 15                	push   $0x15
  801976:	e8 96 fd ff ff       	call   801711 <syscall>
  80197b:	83 c4 18             	add    $0x18,%esp
}
  80197e:	90                   	nop
  80197f:	c9                   	leave  
  801980:	c3                   	ret    

00801981 <sys_cputc>:


void
sys_cputc(const char c)
{
  801981:	55                   	push   %ebp
  801982:	89 e5                	mov    %esp,%ebp
  801984:	83 ec 04             	sub    $0x4,%esp
  801987:	8b 45 08             	mov    0x8(%ebp),%eax
  80198a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80198d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	50                   	push   %eax
  80199a:	6a 16                	push   $0x16
  80199c:	e8 70 fd ff ff       	call   801711 <syscall>
  8019a1:	83 c4 18             	add    $0x18,%esp
}
  8019a4:	90                   	nop
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 17                	push   $0x17
  8019b6:	e8 56 fd ff ff       	call   801711 <syscall>
  8019bb:	83 c4 18             	add    $0x18,%esp
}
  8019be:	90                   	nop
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	ff 75 0c             	pushl  0xc(%ebp)
  8019d0:	50                   	push   %eax
  8019d1:	6a 18                	push   $0x18
  8019d3:	e8 39 fd ff ff       	call   801711 <syscall>
  8019d8:	83 c4 18             	add    $0x18,%esp
}
  8019db:	c9                   	leave  
  8019dc:	c3                   	ret    

008019dd <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	52                   	push   %edx
  8019ed:	50                   	push   %eax
  8019ee:	6a 1b                	push   $0x1b
  8019f0:	e8 1c fd ff ff       	call   801711 <syscall>
  8019f5:	83 c4 18             	add    $0x18,%esp
}
  8019f8:	c9                   	leave  
  8019f9:	c3                   	ret    

008019fa <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019fa:	55                   	push   %ebp
  8019fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a00:	8b 45 08             	mov    0x8(%ebp),%eax
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	52                   	push   %edx
  801a0a:	50                   	push   %eax
  801a0b:	6a 19                	push   $0x19
  801a0d:	e8 ff fc ff ff       	call   801711 <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
}
  801a15:	90                   	nop
  801a16:	c9                   	leave  
  801a17:	c3                   	ret    

00801a18 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a18:	55                   	push   %ebp
  801a19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	52                   	push   %edx
  801a28:	50                   	push   %eax
  801a29:	6a 1a                	push   $0x1a
  801a2b:	e8 e1 fc ff ff       	call   801711 <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
  801a39:	83 ec 04             	sub    $0x4,%esp
  801a3c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a3f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a42:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a45:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a49:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4c:	6a 00                	push   $0x0
  801a4e:	51                   	push   %ecx
  801a4f:	52                   	push   %edx
  801a50:	ff 75 0c             	pushl  0xc(%ebp)
  801a53:	50                   	push   %eax
  801a54:	6a 1c                	push   $0x1c
  801a56:	e8 b6 fc ff ff       	call   801711 <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
}
  801a5e:	c9                   	leave  
  801a5f:	c3                   	ret    

00801a60 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a63:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a66:	8b 45 08             	mov    0x8(%ebp),%eax
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	52                   	push   %edx
  801a70:	50                   	push   %eax
  801a71:	6a 1d                	push   $0x1d
  801a73:	e8 99 fc ff ff       	call   801711 <syscall>
  801a78:	83 c4 18             	add    $0x18,%esp
}
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a80:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a83:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a86:	8b 45 08             	mov    0x8(%ebp),%eax
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	51                   	push   %ecx
  801a8e:	52                   	push   %edx
  801a8f:	50                   	push   %eax
  801a90:	6a 1e                	push   $0x1e
  801a92:	e8 7a fc ff ff       	call   801711 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	52                   	push   %edx
  801aac:	50                   	push   %eax
  801aad:	6a 1f                	push   $0x1f
  801aaf:	e8 5d fc ff ff       	call   801711 <syscall>
  801ab4:	83 c4 18             	add    $0x18,%esp
}
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    

00801ab9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ab9:	55                   	push   %ebp
  801aba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 20                	push   $0x20
  801ac8:	e8 44 fc ff ff       	call   801711 <syscall>
  801acd:	83 c4 18             	add    $0x18,%esp
}
  801ad0:	c9                   	leave  
  801ad1:	c3                   	ret    

00801ad2 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ad2:	55                   	push   %ebp
  801ad3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad8:	6a 00                	push   $0x0
  801ada:	ff 75 14             	pushl  0x14(%ebp)
  801add:	ff 75 10             	pushl  0x10(%ebp)
  801ae0:	ff 75 0c             	pushl  0xc(%ebp)
  801ae3:	50                   	push   %eax
  801ae4:	6a 21                	push   $0x21
  801ae6:	e8 26 fc ff ff       	call   801711 <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
}
  801aee:	c9                   	leave  
  801aef:	c3                   	ret    

00801af0 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	50                   	push   %eax
  801aff:	6a 22                	push   $0x22
  801b01:	e8 0b fc ff ff       	call   801711 <syscall>
  801b06:	83 c4 18             	add    $0x18,%esp
}
  801b09:	90                   	nop
  801b0a:	c9                   	leave  
  801b0b:	c3                   	ret    

00801b0c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b0c:	55                   	push   %ebp
  801b0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	50                   	push   %eax
  801b1b:	6a 23                	push   $0x23
  801b1d:	e8 ef fb ff ff       	call   801711 <syscall>
  801b22:	83 c4 18             	add    $0x18,%esp
}
  801b25:	90                   	nop
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
  801b2b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b2e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b31:	8d 50 04             	lea    0x4(%eax),%edx
  801b34:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	52                   	push   %edx
  801b3e:	50                   	push   %eax
  801b3f:	6a 24                	push   $0x24
  801b41:	e8 cb fb ff ff       	call   801711 <syscall>
  801b46:	83 c4 18             	add    $0x18,%esp
	return result;
  801b49:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b4c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b4f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b52:	89 01                	mov    %eax,(%ecx)
  801b54:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	c9                   	leave  
  801b5b:	c2 04 00             	ret    $0x4

00801b5e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	ff 75 10             	pushl  0x10(%ebp)
  801b68:	ff 75 0c             	pushl  0xc(%ebp)
  801b6b:	ff 75 08             	pushl  0x8(%ebp)
  801b6e:	6a 13                	push   $0x13
  801b70:	e8 9c fb ff ff       	call   801711 <syscall>
  801b75:	83 c4 18             	add    $0x18,%esp
	return ;
  801b78:	90                   	nop
}
  801b79:	c9                   	leave  
  801b7a:	c3                   	ret    

00801b7b <sys_rcr2>:
uint32 sys_rcr2()
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 25                	push   $0x25
  801b8a:	e8 82 fb ff ff       	call   801711 <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	c9                   	leave  
  801b93:	c3                   	ret    

00801b94 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b94:	55                   	push   %ebp
  801b95:	89 e5                	mov    %esp,%ebp
  801b97:	83 ec 04             	sub    $0x4,%esp
  801b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ba0:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	50                   	push   %eax
  801bad:	6a 26                	push   $0x26
  801baf:	e8 5d fb ff ff       	call   801711 <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb7:	90                   	nop
}
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <rsttst>:
void rsttst()
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 28                	push   $0x28
  801bc9:	e8 43 fb ff ff       	call   801711 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd1:	90                   	nop
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	83 ec 04             	sub    $0x4,%esp
  801bda:	8b 45 14             	mov    0x14(%ebp),%eax
  801bdd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801be0:	8b 55 18             	mov    0x18(%ebp),%edx
  801be3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801be7:	52                   	push   %edx
  801be8:	50                   	push   %eax
  801be9:	ff 75 10             	pushl  0x10(%ebp)
  801bec:	ff 75 0c             	pushl  0xc(%ebp)
  801bef:	ff 75 08             	pushl  0x8(%ebp)
  801bf2:	6a 27                	push   $0x27
  801bf4:	e8 18 fb ff ff       	call   801711 <syscall>
  801bf9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bfc:	90                   	nop
}
  801bfd:	c9                   	leave  
  801bfe:	c3                   	ret    

00801bff <chktst>:
void chktst(uint32 n)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	ff 75 08             	pushl  0x8(%ebp)
  801c0d:	6a 29                	push   $0x29
  801c0f:	e8 fd fa ff ff       	call   801711 <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
	return ;
  801c17:	90                   	nop
}
  801c18:	c9                   	leave  
  801c19:	c3                   	ret    

00801c1a <inctst>:

void inctst()
{
  801c1a:	55                   	push   %ebp
  801c1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 2a                	push   $0x2a
  801c29:	e8 e3 fa ff ff       	call   801711 <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801c31:	90                   	nop
}
  801c32:	c9                   	leave  
  801c33:	c3                   	ret    

00801c34 <gettst>:
uint32 gettst()
{
  801c34:	55                   	push   %ebp
  801c35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 2b                	push   $0x2b
  801c43:	e8 c9 fa ff ff       	call   801711 <syscall>
  801c48:	83 c4 18             	add    $0x18,%esp
}
  801c4b:	c9                   	leave  
  801c4c:	c3                   	ret    

00801c4d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c4d:	55                   	push   %ebp
  801c4e:	89 e5                	mov    %esp,%ebp
  801c50:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 2c                	push   $0x2c
  801c5f:	e8 ad fa ff ff       	call   801711 <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
  801c67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c6a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c6e:	75 07                	jne    801c77 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c70:	b8 01 00 00 00       	mov    $0x1,%eax
  801c75:	eb 05                	jmp    801c7c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c77:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c7c:	c9                   	leave  
  801c7d:	c3                   	ret    

00801c7e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c7e:	55                   	push   %ebp
  801c7f:	89 e5                	mov    %esp,%ebp
  801c81:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 2c                	push   $0x2c
  801c90:	e8 7c fa ff ff       	call   801711 <syscall>
  801c95:	83 c4 18             	add    $0x18,%esp
  801c98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c9b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c9f:	75 07                	jne    801ca8 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ca1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca6:	eb 05                	jmp    801cad <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ca8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cad:	c9                   	leave  
  801cae:	c3                   	ret    

00801caf <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
  801cb2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 2c                	push   $0x2c
  801cc1:	e8 4b fa ff ff       	call   801711 <syscall>
  801cc6:	83 c4 18             	add    $0x18,%esp
  801cc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ccc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cd0:	75 07                	jne    801cd9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cd2:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd7:	eb 05                	jmp    801cde <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cde:	c9                   	leave  
  801cdf:	c3                   	ret    

00801ce0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
  801ce3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 2c                	push   $0x2c
  801cf2:	e8 1a fa ff ff       	call   801711 <syscall>
  801cf7:	83 c4 18             	add    $0x18,%esp
  801cfa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cfd:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d01:	75 07                	jne    801d0a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d03:	b8 01 00 00 00       	mov    $0x1,%eax
  801d08:	eb 05                	jmp    801d0f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d0f:	c9                   	leave  
  801d10:	c3                   	ret    

00801d11 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d11:	55                   	push   %ebp
  801d12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	ff 75 08             	pushl  0x8(%ebp)
  801d1f:	6a 2d                	push   $0x2d
  801d21:	e8 eb f9 ff ff       	call   801711 <syscall>
  801d26:	83 c4 18             	add    $0x18,%esp
	return ;
  801d29:	90                   	nop
}
  801d2a:	c9                   	leave  
  801d2b:	c3                   	ret    

00801d2c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d2c:	55                   	push   %ebp
  801d2d:	89 e5                	mov    %esp,%ebp
  801d2f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d30:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d33:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d36:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d39:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3c:	6a 00                	push   $0x0
  801d3e:	53                   	push   %ebx
  801d3f:	51                   	push   %ecx
  801d40:	52                   	push   %edx
  801d41:	50                   	push   %eax
  801d42:	6a 2e                	push   $0x2e
  801d44:	e8 c8 f9 ff ff       	call   801711 <syscall>
  801d49:	83 c4 18             	add    $0x18,%esp
}
  801d4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d57:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	52                   	push   %edx
  801d61:	50                   	push   %eax
  801d62:	6a 2f                	push   $0x2f
  801d64:	e8 a8 f9 ff ff       	call   801711 <syscall>
  801d69:	83 c4 18             	add    $0x18,%esp
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
  801d71:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801d74:	8b 55 08             	mov    0x8(%ebp),%edx
  801d77:	89 d0                	mov    %edx,%eax
  801d79:	c1 e0 02             	shl    $0x2,%eax
  801d7c:	01 d0                	add    %edx,%eax
  801d7e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d85:	01 d0                	add    %edx,%eax
  801d87:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d8e:	01 d0                	add    %edx,%eax
  801d90:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d97:	01 d0                	add    %edx,%eax
  801d99:	c1 e0 04             	shl    $0x4,%eax
  801d9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801d9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801da6:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801da9:	83 ec 0c             	sub    $0xc,%esp
  801dac:	50                   	push   %eax
  801dad:	e8 76 fd ff ff       	call   801b28 <sys_get_virtual_time>
  801db2:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801db5:	eb 41                	jmp    801df8 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801db7:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801dba:	83 ec 0c             	sub    $0xc,%esp
  801dbd:	50                   	push   %eax
  801dbe:	e8 65 fd ff ff       	call   801b28 <sys_get_virtual_time>
  801dc3:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801dc6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801dc9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801dcc:	29 c2                	sub    %eax,%edx
  801dce:	89 d0                	mov    %edx,%eax
  801dd0:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801dd3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801dd6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801dd9:	89 d1                	mov    %edx,%ecx
  801ddb:	29 c1                	sub    %eax,%ecx
  801ddd:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801de0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801de3:	39 c2                	cmp    %eax,%edx
  801de5:	0f 97 c0             	seta   %al
  801de8:	0f b6 c0             	movzbl %al,%eax
  801deb:	29 c1                	sub    %eax,%ecx
  801ded:	89 c8                	mov    %ecx,%eax
  801def:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801df2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dfb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dfe:	72 b7                	jb     801db7 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801e00:	90                   	nop
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
  801e06:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801e09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801e10:	eb 03                	jmp    801e15 <busy_wait+0x12>
  801e12:	ff 45 fc             	incl   -0x4(%ebp)
  801e15:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e18:	3b 45 08             	cmp    0x8(%ebp),%eax
  801e1b:	72 f5                	jb     801e12 <busy_wait+0xf>
	return i;
  801e1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801e20:	c9                   	leave  
  801e21:	c3                   	ret    
  801e22:	66 90                	xchg   %ax,%ax

00801e24 <__udivdi3>:
  801e24:	55                   	push   %ebp
  801e25:	57                   	push   %edi
  801e26:	56                   	push   %esi
  801e27:	53                   	push   %ebx
  801e28:	83 ec 1c             	sub    $0x1c,%esp
  801e2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e3b:	89 ca                	mov    %ecx,%edx
  801e3d:	89 f8                	mov    %edi,%eax
  801e3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e43:	85 f6                	test   %esi,%esi
  801e45:	75 2d                	jne    801e74 <__udivdi3+0x50>
  801e47:	39 cf                	cmp    %ecx,%edi
  801e49:	77 65                	ja     801eb0 <__udivdi3+0x8c>
  801e4b:	89 fd                	mov    %edi,%ebp
  801e4d:	85 ff                	test   %edi,%edi
  801e4f:	75 0b                	jne    801e5c <__udivdi3+0x38>
  801e51:	b8 01 00 00 00       	mov    $0x1,%eax
  801e56:	31 d2                	xor    %edx,%edx
  801e58:	f7 f7                	div    %edi
  801e5a:	89 c5                	mov    %eax,%ebp
  801e5c:	31 d2                	xor    %edx,%edx
  801e5e:	89 c8                	mov    %ecx,%eax
  801e60:	f7 f5                	div    %ebp
  801e62:	89 c1                	mov    %eax,%ecx
  801e64:	89 d8                	mov    %ebx,%eax
  801e66:	f7 f5                	div    %ebp
  801e68:	89 cf                	mov    %ecx,%edi
  801e6a:	89 fa                	mov    %edi,%edx
  801e6c:	83 c4 1c             	add    $0x1c,%esp
  801e6f:	5b                   	pop    %ebx
  801e70:	5e                   	pop    %esi
  801e71:	5f                   	pop    %edi
  801e72:	5d                   	pop    %ebp
  801e73:	c3                   	ret    
  801e74:	39 ce                	cmp    %ecx,%esi
  801e76:	77 28                	ja     801ea0 <__udivdi3+0x7c>
  801e78:	0f bd fe             	bsr    %esi,%edi
  801e7b:	83 f7 1f             	xor    $0x1f,%edi
  801e7e:	75 40                	jne    801ec0 <__udivdi3+0x9c>
  801e80:	39 ce                	cmp    %ecx,%esi
  801e82:	72 0a                	jb     801e8e <__udivdi3+0x6a>
  801e84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e88:	0f 87 9e 00 00 00    	ja     801f2c <__udivdi3+0x108>
  801e8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e93:	89 fa                	mov    %edi,%edx
  801e95:	83 c4 1c             	add    $0x1c,%esp
  801e98:	5b                   	pop    %ebx
  801e99:	5e                   	pop    %esi
  801e9a:	5f                   	pop    %edi
  801e9b:	5d                   	pop    %ebp
  801e9c:	c3                   	ret    
  801e9d:	8d 76 00             	lea    0x0(%esi),%esi
  801ea0:	31 ff                	xor    %edi,%edi
  801ea2:	31 c0                	xor    %eax,%eax
  801ea4:	89 fa                	mov    %edi,%edx
  801ea6:	83 c4 1c             	add    $0x1c,%esp
  801ea9:	5b                   	pop    %ebx
  801eaa:	5e                   	pop    %esi
  801eab:	5f                   	pop    %edi
  801eac:	5d                   	pop    %ebp
  801ead:	c3                   	ret    
  801eae:	66 90                	xchg   %ax,%ax
  801eb0:	89 d8                	mov    %ebx,%eax
  801eb2:	f7 f7                	div    %edi
  801eb4:	31 ff                	xor    %edi,%edi
  801eb6:	89 fa                	mov    %edi,%edx
  801eb8:	83 c4 1c             	add    $0x1c,%esp
  801ebb:	5b                   	pop    %ebx
  801ebc:	5e                   	pop    %esi
  801ebd:	5f                   	pop    %edi
  801ebe:	5d                   	pop    %ebp
  801ebf:	c3                   	ret    
  801ec0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ec5:	89 eb                	mov    %ebp,%ebx
  801ec7:	29 fb                	sub    %edi,%ebx
  801ec9:	89 f9                	mov    %edi,%ecx
  801ecb:	d3 e6                	shl    %cl,%esi
  801ecd:	89 c5                	mov    %eax,%ebp
  801ecf:	88 d9                	mov    %bl,%cl
  801ed1:	d3 ed                	shr    %cl,%ebp
  801ed3:	89 e9                	mov    %ebp,%ecx
  801ed5:	09 f1                	or     %esi,%ecx
  801ed7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801edb:	89 f9                	mov    %edi,%ecx
  801edd:	d3 e0                	shl    %cl,%eax
  801edf:	89 c5                	mov    %eax,%ebp
  801ee1:	89 d6                	mov    %edx,%esi
  801ee3:	88 d9                	mov    %bl,%cl
  801ee5:	d3 ee                	shr    %cl,%esi
  801ee7:	89 f9                	mov    %edi,%ecx
  801ee9:	d3 e2                	shl    %cl,%edx
  801eeb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eef:	88 d9                	mov    %bl,%cl
  801ef1:	d3 e8                	shr    %cl,%eax
  801ef3:	09 c2                	or     %eax,%edx
  801ef5:	89 d0                	mov    %edx,%eax
  801ef7:	89 f2                	mov    %esi,%edx
  801ef9:	f7 74 24 0c          	divl   0xc(%esp)
  801efd:	89 d6                	mov    %edx,%esi
  801eff:	89 c3                	mov    %eax,%ebx
  801f01:	f7 e5                	mul    %ebp
  801f03:	39 d6                	cmp    %edx,%esi
  801f05:	72 19                	jb     801f20 <__udivdi3+0xfc>
  801f07:	74 0b                	je     801f14 <__udivdi3+0xf0>
  801f09:	89 d8                	mov    %ebx,%eax
  801f0b:	31 ff                	xor    %edi,%edi
  801f0d:	e9 58 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f12:	66 90                	xchg   %ax,%ax
  801f14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f18:	89 f9                	mov    %edi,%ecx
  801f1a:	d3 e2                	shl    %cl,%edx
  801f1c:	39 c2                	cmp    %eax,%edx
  801f1e:	73 e9                	jae    801f09 <__udivdi3+0xe5>
  801f20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f23:	31 ff                	xor    %edi,%edi
  801f25:	e9 40 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f2a:	66 90                	xchg   %ax,%ax
  801f2c:	31 c0                	xor    %eax,%eax
  801f2e:	e9 37 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f33:	90                   	nop

00801f34 <__umoddi3>:
  801f34:	55                   	push   %ebp
  801f35:	57                   	push   %edi
  801f36:	56                   	push   %esi
  801f37:	53                   	push   %ebx
  801f38:	83 ec 1c             	sub    $0x1c,%esp
  801f3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f53:	89 f3                	mov    %esi,%ebx
  801f55:	89 fa                	mov    %edi,%edx
  801f57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f5b:	89 34 24             	mov    %esi,(%esp)
  801f5e:	85 c0                	test   %eax,%eax
  801f60:	75 1a                	jne    801f7c <__umoddi3+0x48>
  801f62:	39 f7                	cmp    %esi,%edi
  801f64:	0f 86 a2 00 00 00    	jbe    80200c <__umoddi3+0xd8>
  801f6a:	89 c8                	mov    %ecx,%eax
  801f6c:	89 f2                	mov    %esi,%edx
  801f6e:	f7 f7                	div    %edi
  801f70:	89 d0                	mov    %edx,%eax
  801f72:	31 d2                	xor    %edx,%edx
  801f74:	83 c4 1c             	add    $0x1c,%esp
  801f77:	5b                   	pop    %ebx
  801f78:	5e                   	pop    %esi
  801f79:	5f                   	pop    %edi
  801f7a:	5d                   	pop    %ebp
  801f7b:	c3                   	ret    
  801f7c:	39 f0                	cmp    %esi,%eax
  801f7e:	0f 87 ac 00 00 00    	ja     802030 <__umoddi3+0xfc>
  801f84:	0f bd e8             	bsr    %eax,%ebp
  801f87:	83 f5 1f             	xor    $0x1f,%ebp
  801f8a:	0f 84 ac 00 00 00    	je     80203c <__umoddi3+0x108>
  801f90:	bf 20 00 00 00       	mov    $0x20,%edi
  801f95:	29 ef                	sub    %ebp,%edi
  801f97:	89 fe                	mov    %edi,%esi
  801f99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f9d:	89 e9                	mov    %ebp,%ecx
  801f9f:	d3 e0                	shl    %cl,%eax
  801fa1:	89 d7                	mov    %edx,%edi
  801fa3:	89 f1                	mov    %esi,%ecx
  801fa5:	d3 ef                	shr    %cl,%edi
  801fa7:	09 c7                	or     %eax,%edi
  801fa9:	89 e9                	mov    %ebp,%ecx
  801fab:	d3 e2                	shl    %cl,%edx
  801fad:	89 14 24             	mov    %edx,(%esp)
  801fb0:	89 d8                	mov    %ebx,%eax
  801fb2:	d3 e0                	shl    %cl,%eax
  801fb4:	89 c2                	mov    %eax,%edx
  801fb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fba:	d3 e0                	shl    %cl,%eax
  801fbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fc0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fc4:	89 f1                	mov    %esi,%ecx
  801fc6:	d3 e8                	shr    %cl,%eax
  801fc8:	09 d0                	or     %edx,%eax
  801fca:	d3 eb                	shr    %cl,%ebx
  801fcc:	89 da                	mov    %ebx,%edx
  801fce:	f7 f7                	div    %edi
  801fd0:	89 d3                	mov    %edx,%ebx
  801fd2:	f7 24 24             	mull   (%esp)
  801fd5:	89 c6                	mov    %eax,%esi
  801fd7:	89 d1                	mov    %edx,%ecx
  801fd9:	39 d3                	cmp    %edx,%ebx
  801fdb:	0f 82 87 00 00 00    	jb     802068 <__umoddi3+0x134>
  801fe1:	0f 84 91 00 00 00    	je     802078 <__umoddi3+0x144>
  801fe7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801feb:	29 f2                	sub    %esi,%edx
  801fed:	19 cb                	sbb    %ecx,%ebx
  801fef:	89 d8                	mov    %ebx,%eax
  801ff1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ff5:	d3 e0                	shl    %cl,%eax
  801ff7:	89 e9                	mov    %ebp,%ecx
  801ff9:	d3 ea                	shr    %cl,%edx
  801ffb:	09 d0                	or     %edx,%eax
  801ffd:	89 e9                	mov    %ebp,%ecx
  801fff:	d3 eb                	shr    %cl,%ebx
  802001:	89 da                	mov    %ebx,%edx
  802003:	83 c4 1c             	add    $0x1c,%esp
  802006:	5b                   	pop    %ebx
  802007:	5e                   	pop    %esi
  802008:	5f                   	pop    %edi
  802009:	5d                   	pop    %ebp
  80200a:	c3                   	ret    
  80200b:	90                   	nop
  80200c:	89 fd                	mov    %edi,%ebp
  80200e:	85 ff                	test   %edi,%edi
  802010:	75 0b                	jne    80201d <__umoddi3+0xe9>
  802012:	b8 01 00 00 00       	mov    $0x1,%eax
  802017:	31 d2                	xor    %edx,%edx
  802019:	f7 f7                	div    %edi
  80201b:	89 c5                	mov    %eax,%ebp
  80201d:	89 f0                	mov    %esi,%eax
  80201f:	31 d2                	xor    %edx,%edx
  802021:	f7 f5                	div    %ebp
  802023:	89 c8                	mov    %ecx,%eax
  802025:	f7 f5                	div    %ebp
  802027:	89 d0                	mov    %edx,%eax
  802029:	e9 44 ff ff ff       	jmp    801f72 <__umoddi3+0x3e>
  80202e:	66 90                	xchg   %ax,%ax
  802030:	89 c8                	mov    %ecx,%eax
  802032:	89 f2                	mov    %esi,%edx
  802034:	83 c4 1c             	add    $0x1c,%esp
  802037:	5b                   	pop    %ebx
  802038:	5e                   	pop    %esi
  802039:	5f                   	pop    %edi
  80203a:	5d                   	pop    %ebp
  80203b:	c3                   	ret    
  80203c:	3b 04 24             	cmp    (%esp),%eax
  80203f:	72 06                	jb     802047 <__umoddi3+0x113>
  802041:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802045:	77 0f                	ja     802056 <__umoddi3+0x122>
  802047:	89 f2                	mov    %esi,%edx
  802049:	29 f9                	sub    %edi,%ecx
  80204b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80204f:	89 14 24             	mov    %edx,(%esp)
  802052:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802056:	8b 44 24 04          	mov    0x4(%esp),%eax
  80205a:	8b 14 24             	mov    (%esp),%edx
  80205d:	83 c4 1c             	add    $0x1c,%esp
  802060:	5b                   	pop    %ebx
  802061:	5e                   	pop    %esi
  802062:	5f                   	pop    %edi
  802063:	5d                   	pop    %ebp
  802064:	c3                   	ret    
  802065:	8d 76 00             	lea    0x0(%esi),%esi
  802068:	2b 04 24             	sub    (%esp),%eax
  80206b:	19 fa                	sbb    %edi,%edx
  80206d:	89 d1                	mov    %edx,%ecx
  80206f:	89 c6                	mov    %eax,%esi
  802071:	e9 71 ff ff ff       	jmp    801fe7 <__umoddi3+0xb3>
  802076:	66 90                	xchg   %ax,%ax
  802078:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80207c:	72 ea                	jb     802068 <__umoddi3+0x134>
  80207e:	89 d9                	mov    %ebx,%ecx
  802080:	e9 62 ff ff ff       	jmp    801fe7 <__umoddi3+0xb3>
