
obj/user/tst_page_replacement_stack:     file format elf32-i386


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
  800031:	e8 f9 00 00 00       	call   80012f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 14 a0 00 00    	sub    $0xa014,%esp
	char arr[PAGE_SIZE*10];

	uint32 kilo = 1024;
  800042:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	int freePages = sys_calculate_free_frames();
  800049:	e8 be 13 00 00       	call   80140c <sys_calculate_free_frames>
  80004e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800051:	e8 39 14 00 00       	call   80148f <sys_pf_calculate_allocated_pages>
  800056:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800059:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800060:	eb 15                	jmp    800077 <_main+0x3f>
		arr[i] = -1 ;
  800062:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  800068:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c6 00 ff             	movb   $0xff,(%eax)

	int freePages = sys_calculate_free_frames();
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800070:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800077:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80007e:	7e e2                	jle    800062 <_main+0x2a>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 80 1b 80 00       	push   $0x801b80
  800088:	e8 89 04 00 00       	call   800516 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800097:	eb 2c                	jmp    8000c5 <_main+0x8d>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");
  800099:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  80009f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	8a 00                	mov    (%eax),%al
  8000a6:	3c ff                	cmp    $0xff,%al
  8000a8:	74 14                	je     8000be <_main+0x86>
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	68 b8 1b 80 00       	push   $0x801bb8
  8000b2:	6a 1a                	push   $0x1a
  8000b4:	68 e8 1b 80 00       	push   $0x801be8
  8000b9:	e8 b6 01 00 00       	call   800274 <_panic>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000be:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8000c5:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8000cc:	7e cb                	jle    800099 <_main+0x61>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  9) panic("Unexpected extra/less pages have been added to page file");
  8000ce:	e8 bc 13 00 00       	call   80148f <sys_pf_calculate_allocated_pages>
  8000d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d6:	83 f8 09             	cmp    $0x9,%eax
  8000d9:	74 14                	je     8000ef <_main+0xb7>
  8000db:	83 ec 04             	sub    $0x4,%esp
  8000de:	68 0c 1c 80 00       	push   $0x801c0c
  8000e3:	6a 1c                	push   $0x1c
  8000e5:	68 e8 1b 80 00       	push   $0x801be8
  8000ea:	e8 85 01 00 00       	call   800274 <_panic>

		if( (freePages - (sys_calculate_free_frames() + sys_calculate_modified_frames())) != 0 ) panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8000ef:	e8 18 13 00 00       	call   80140c <sys_calculate_free_frames>
  8000f4:	89 c3                	mov    %eax,%ebx
  8000f6:	e8 2a 13 00 00       	call   801425 <sys_calculate_modified_frames>
  8000fb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	39 c2                	cmp    %eax,%edx
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 48 1c 80 00       	push   $0x801c48
  80010d:	6a 1e                	push   $0x1e
  80010f:	68 e8 1b 80 00       	push   $0x801be8
  800114:	e8 5b 01 00 00       	call   800274 <_panic>
	}

	cprintf("Congratulations: stack pages created, modified and read successfully!\n\n");
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	68 ac 1c 80 00       	push   $0x801cac
  800121:	e8 f0 03 00 00       	call   800516 <cprintf>
  800126:	83 c4 10             	add    $0x10,%esp


	return;
  800129:	90                   	nop
}
  80012a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800135:	e8 07 12 00 00       	call   801341 <sys_getenvindex>
  80013a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80013d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800140:	89 d0                	mov    %edx,%eax
  800142:	c1 e0 03             	shl    $0x3,%eax
  800145:	01 d0                	add    %edx,%eax
  800147:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80014e:	01 c8                	add    %ecx,%eax
  800150:	01 c0                	add    %eax,%eax
  800152:	01 d0                	add    %edx,%eax
  800154:	01 c0                	add    %eax,%eax
  800156:	01 d0                	add    %edx,%eax
  800158:	89 c2                	mov    %eax,%edx
  80015a:	c1 e2 05             	shl    $0x5,%edx
  80015d:	29 c2                	sub    %eax,%edx
  80015f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800166:	89 c2                	mov    %eax,%edx
  800168:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80016e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800173:	a1 20 30 80 00       	mov    0x803020,%eax
  800178:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80017e:	84 c0                	test   %al,%al
  800180:	74 0f                	je     800191 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	05 40 3c 01 00       	add    $0x13c40,%eax
  80018c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800191:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800195:	7e 0a                	jle    8001a1 <libmain+0x72>
		binaryname = argv[0];
  800197:	8b 45 0c             	mov    0xc(%ebp),%eax
  80019a:	8b 00                	mov    (%eax),%eax
  80019c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 0c             	pushl  0xc(%ebp)
  8001a7:	ff 75 08             	pushl  0x8(%ebp)
  8001aa:	e8 89 fe ff ff       	call   800038 <_main>
  8001af:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001b2:	e8 25 13 00 00       	call   8014dc <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b7:	83 ec 0c             	sub    $0xc,%esp
  8001ba:	68 0c 1d 80 00       	push   $0x801d0c
  8001bf:	e8 52 03 00 00       	call   800516 <cprintf>
  8001c4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001cc:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d7:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	52                   	push   %edx
  8001e1:	50                   	push   %eax
  8001e2:	68 34 1d 80 00       	push   $0x801d34
  8001e7:	e8 2a 03 00 00       	call   800516 <cprintf>
  8001ec:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f4:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ff:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800205:	83 ec 04             	sub    $0x4,%esp
  800208:	52                   	push   %edx
  800209:	50                   	push   %eax
  80020a:	68 5c 1d 80 00       	push   $0x801d5c
  80020f:	e8 02 03 00 00       	call   800516 <cprintf>
  800214:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800217:	a1 20 30 80 00       	mov    0x803020,%eax
  80021c:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800222:	83 ec 08             	sub    $0x8,%esp
  800225:	50                   	push   %eax
  800226:	68 9d 1d 80 00       	push   $0x801d9d
  80022b:	e8 e6 02 00 00       	call   800516 <cprintf>
  800230:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800233:	83 ec 0c             	sub    $0xc,%esp
  800236:	68 0c 1d 80 00       	push   $0x801d0c
  80023b:	e8 d6 02 00 00       	call   800516 <cprintf>
  800240:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800243:	e8 ae 12 00 00       	call   8014f6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800248:	e8 19 00 00 00       	call   800266 <exit>
}
  80024d:	90                   	nop
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800256:	83 ec 0c             	sub    $0xc,%esp
  800259:	6a 00                	push   $0x0
  80025b:	e8 ad 10 00 00       	call   80130d <sys_env_destroy>
  800260:	83 c4 10             	add    $0x10,%esp
}
  800263:	90                   	nop
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <exit>:

void
exit(void)
{
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80026c:	e8 02 11 00 00       	call   801373 <sys_env_exit>
}
  800271:	90                   	nop
  800272:	c9                   	leave  
  800273:	c3                   	ret    

00800274 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800274:	55                   	push   %ebp
  800275:	89 e5                	mov    %esp,%ebp
  800277:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80027a:	8d 45 10             	lea    0x10(%ebp),%eax
  80027d:	83 c0 04             	add    $0x4,%eax
  800280:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800283:	a1 18 31 80 00       	mov    0x803118,%eax
  800288:	85 c0                	test   %eax,%eax
  80028a:	74 16                	je     8002a2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80028c:	a1 18 31 80 00       	mov    0x803118,%eax
  800291:	83 ec 08             	sub    $0x8,%esp
  800294:	50                   	push   %eax
  800295:	68 b4 1d 80 00       	push   $0x801db4
  80029a:	e8 77 02 00 00       	call   800516 <cprintf>
  80029f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002a2:	a1 00 30 80 00       	mov    0x803000,%eax
  8002a7:	ff 75 0c             	pushl  0xc(%ebp)
  8002aa:	ff 75 08             	pushl  0x8(%ebp)
  8002ad:	50                   	push   %eax
  8002ae:	68 b9 1d 80 00       	push   $0x801db9
  8002b3:	e8 5e 02 00 00       	call   800516 <cprintf>
  8002b8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8002be:	83 ec 08             	sub    $0x8,%esp
  8002c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c4:	50                   	push   %eax
  8002c5:	e8 e1 01 00 00       	call   8004ab <vcprintf>
  8002ca:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002cd:	83 ec 08             	sub    $0x8,%esp
  8002d0:	6a 00                	push   $0x0
  8002d2:	68 d5 1d 80 00       	push   $0x801dd5
  8002d7:	e8 cf 01 00 00       	call   8004ab <vcprintf>
  8002dc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002df:	e8 82 ff ff ff       	call   800266 <exit>

	// should not return here
	while (1) ;
  8002e4:	eb fe                	jmp    8002e4 <_panic+0x70>

008002e6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002e6:	55                   	push   %ebp
  8002e7:	89 e5                	mov    %esp,%ebp
  8002e9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f1:	8b 50 74             	mov    0x74(%eax),%edx
  8002f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f7:	39 c2                	cmp    %eax,%edx
  8002f9:	74 14                	je     80030f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002fb:	83 ec 04             	sub    $0x4,%esp
  8002fe:	68 d8 1d 80 00       	push   $0x801dd8
  800303:	6a 26                	push   $0x26
  800305:	68 24 1e 80 00       	push   $0x801e24
  80030a:	e8 65 ff ff ff       	call   800274 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80030f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800316:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80031d:	e9 b6 00 00 00       	jmp    8003d8 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800322:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800325:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032c:	8b 45 08             	mov    0x8(%ebp),%eax
  80032f:	01 d0                	add    %edx,%eax
  800331:	8b 00                	mov    (%eax),%eax
  800333:	85 c0                	test   %eax,%eax
  800335:	75 08                	jne    80033f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800337:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80033a:	e9 96 00 00 00       	jmp    8003d5 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80033f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800346:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80034d:	eb 5d                	jmp    8003ac <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80034f:	a1 20 30 80 00       	mov    0x803020,%eax
  800354:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80035a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035d:	c1 e2 04             	shl    $0x4,%edx
  800360:	01 d0                	add    %edx,%eax
  800362:	8a 40 04             	mov    0x4(%eax),%al
  800365:	84 c0                	test   %al,%al
  800367:	75 40                	jne    8003a9 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800369:	a1 20 30 80 00       	mov    0x803020,%eax
  80036e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800374:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800377:	c1 e2 04             	shl    $0x4,%edx
  80037a:	01 d0                	add    %edx,%eax
  80037c:	8b 00                	mov    (%eax),%eax
  80037e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800381:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800384:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800389:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80038b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c8                	add    %ecx,%eax
  80039a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80039c:	39 c2                	cmp    %eax,%edx
  80039e:	75 09                	jne    8003a9 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003a0:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003a7:	eb 12                	jmp    8003bb <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a9:	ff 45 e8             	incl   -0x18(%ebp)
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 50 74             	mov    0x74(%eax),%edx
  8003b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003b7:	39 c2                	cmp    %eax,%edx
  8003b9:	77 94                	ja     80034f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003bf:	75 14                	jne    8003d5 <CheckWSWithoutLastIndex+0xef>
			panic(
  8003c1:	83 ec 04             	sub    $0x4,%esp
  8003c4:	68 30 1e 80 00       	push   $0x801e30
  8003c9:	6a 3a                	push   $0x3a
  8003cb:	68 24 1e 80 00       	push   $0x801e24
  8003d0:	e8 9f fe ff ff       	call   800274 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003d5:	ff 45 f0             	incl   -0x10(%ebp)
  8003d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003de:	0f 8c 3e ff ff ff    	jl     800322 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003eb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003f2:	eb 20                	jmp    800414 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800402:	c1 e2 04             	shl    $0x4,%edx
  800405:	01 d0                	add    %edx,%eax
  800407:	8a 40 04             	mov    0x4(%eax),%al
  80040a:	3c 01                	cmp    $0x1,%al
  80040c:	75 03                	jne    800411 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80040e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800411:	ff 45 e0             	incl   -0x20(%ebp)
  800414:	a1 20 30 80 00       	mov    0x803020,%eax
  800419:	8b 50 74             	mov    0x74(%eax),%edx
  80041c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80041f:	39 c2                	cmp    %eax,%edx
  800421:	77 d1                	ja     8003f4 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800426:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800429:	74 14                	je     80043f <CheckWSWithoutLastIndex+0x159>
		panic(
  80042b:	83 ec 04             	sub    $0x4,%esp
  80042e:	68 84 1e 80 00       	push   $0x801e84
  800433:	6a 44                	push   $0x44
  800435:	68 24 1e 80 00       	push   $0x801e24
  80043a:	e8 35 fe ff ff       	call   800274 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80043f:	90                   	nop
  800440:	c9                   	leave  
  800441:	c3                   	ret    

00800442 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800442:	55                   	push   %ebp
  800443:	89 e5                	mov    %esp,%ebp
  800445:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800448:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	8d 48 01             	lea    0x1(%eax),%ecx
  800450:	8b 55 0c             	mov    0xc(%ebp),%edx
  800453:	89 0a                	mov    %ecx,(%edx)
  800455:	8b 55 08             	mov    0x8(%ebp),%edx
  800458:	88 d1                	mov    %dl,%cl
  80045a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80045d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800461:	8b 45 0c             	mov    0xc(%ebp),%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	3d ff 00 00 00       	cmp    $0xff,%eax
  80046b:	75 2c                	jne    800499 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80046d:	a0 24 30 80 00       	mov    0x803024,%al
  800472:	0f b6 c0             	movzbl %al,%eax
  800475:	8b 55 0c             	mov    0xc(%ebp),%edx
  800478:	8b 12                	mov    (%edx),%edx
  80047a:	89 d1                	mov    %edx,%ecx
  80047c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80047f:	83 c2 08             	add    $0x8,%edx
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	50                   	push   %eax
  800486:	51                   	push   %ecx
  800487:	52                   	push   %edx
  800488:	e8 3e 0e 00 00       	call   8012cb <sys_cputs>
  80048d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800490:	8b 45 0c             	mov    0xc(%ebp),%eax
  800493:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049c:	8b 40 04             	mov    0x4(%eax),%eax
  80049f:	8d 50 01             	lea    0x1(%eax),%edx
  8004a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004a8:	90                   	nop
  8004a9:	c9                   	leave  
  8004aa:	c3                   	ret    

008004ab <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004ab:	55                   	push   %ebp
  8004ac:	89 e5                	mov    %esp,%ebp
  8004ae:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004b4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004bb:	00 00 00 
	b.cnt = 0;
  8004be:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004c5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004c8:	ff 75 0c             	pushl  0xc(%ebp)
  8004cb:	ff 75 08             	pushl  0x8(%ebp)
  8004ce:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004d4:	50                   	push   %eax
  8004d5:	68 42 04 80 00       	push   $0x800442
  8004da:	e8 11 02 00 00       	call   8006f0 <vprintfmt>
  8004df:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004e2:	a0 24 30 80 00       	mov    0x803024,%al
  8004e7:	0f b6 c0             	movzbl %al,%eax
  8004ea:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004f0:	83 ec 04             	sub    $0x4,%esp
  8004f3:	50                   	push   %eax
  8004f4:	52                   	push   %edx
  8004f5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004fb:	83 c0 08             	add    $0x8,%eax
  8004fe:	50                   	push   %eax
  8004ff:	e8 c7 0d 00 00       	call   8012cb <sys_cputs>
  800504:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800507:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80050e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800514:	c9                   	leave  
  800515:	c3                   	ret    

00800516 <cprintf>:

int cprintf(const char *fmt, ...) {
  800516:	55                   	push   %ebp
  800517:	89 e5                	mov    %esp,%ebp
  800519:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80051c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800523:	8d 45 0c             	lea    0xc(%ebp),%eax
  800526:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800529:	8b 45 08             	mov    0x8(%ebp),%eax
  80052c:	83 ec 08             	sub    $0x8,%esp
  80052f:	ff 75 f4             	pushl  -0xc(%ebp)
  800532:	50                   	push   %eax
  800533:	e8 73 ff ff ff       	call   8004ab <vcprintf>
  800538:	83 c4 10             	add    $0x10,%esp
  80053b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80053e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800541:	c9                   	leave  
  800542:	c3                   	ret    

00800543 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800543:	55                   	push   %ebp
  800544:	89 e5                	mov    %esp,%ebp
  800546:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800549:	e8 8e 0f 00 00       	call   8014dc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80054e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800551:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800554:	8b 45 08             	mov    0x8(%ebp),%eax
  800557:	83 ec 08             	sub    $0x8,%esp
  80055a:	ff 75 f4             	pushl  -0xc(%ebp)
  80055d:	50                   	push   %eax
  80055e:	e8 48 ff ff ff       	call   8004ab <vcprintf>
  800563:	83 c4 10             	add    $0x10,%esp
  800566:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800569:	e8 88 0f 00 00       	call   8014f6 <sys_enable_interrupt>
	return cnt;
  80056e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800571:	c9                   	leave  
  800572:	c3                   	ret    

00800573 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800573:	55                   	push   %ebp
  800574:	89 e5                	mov    %esp,%ebp
  800576:	53                   	push   %ebx
  800577:	83 ec 14             	sub    $0x14,%esp
  80057a:	8b 45 10             	mov    0x10(%ebp),%eax
  80057d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800580:	8b 45 14             	mov    0x14(%ebp),%eax
  800583:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800586:	8b 45 18             	mov    0x18(%ebp),%eax
  800589:	ba 00 00 00 00       	mov    $0x0,%edx
  80058e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800591:	77 55                	ja     8005e8 <printnum+0x75>
  800593:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800596:	72 05                	jb     80059d <printnum+0x2a>
  800598:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80059b:	77 4b                	ja     8005e8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80059d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005a0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005a3:	8b 45 18             	mov    0x18(%ebp),%eax
  8005a6:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ab:	52                   	push   %edx
  8005ac:	50                   	push   %eax
  8005ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b0:	ff 75 f0             	pushl  -0x10(%ebp)
  8005b3:	e8 48 13 00 00       	call   801900 <__udivdi3>
  8005b8:	83 c4 10             	add    $0x10,%esp
  8005bb:	83 ec 04             	sub    $0x4,%esp
  8005be:	ff 75 20             	pushl  0x20(%ebp)
  8005c1:	53                   	push   %ebx
  8005c2:	ff 75 18             	pushl  0x18(%ebp)
  8005c5:	52                   	push   %edx
  8005c6:	50                   	push   %eax
  8005c7:	ff 75 0c             	pushl  0xc(%ebp)
  8005ca:	ff 75 08             	pushl  0x8(%ebp)
  8005cd:	e8 a1 ff ff ff       	call   800573 <printnum>
  8005d2:	83 c4 20             	add    $0x20,%esp
  8005d5:	eb 1a                	jmp    8005f1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005d7:	83 ec 08             	sub    $0x8,%esp
  8005da:	ff 75 0c             	pushl  0xc(%ebp)
  8005dd:	ff 75 20             	pushl  0x20(%ebp)
  8005e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e3:	ff d0                	call   *%eax
  8005e5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005e8:	ff 4d 1c             	decl   0x1c(%ebp)
  8005eb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005ef:	7f e6                	jg     8005d7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005f1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005f4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ff:	53                   	push   %ebx
  800600:	51                   	push   %ecx
  800601:	52                   	push   %edx
  800602:	50                   	push   %eax
  800603:	e8 08 14 00 00       	call   801a10 <__umoddi3>
  800608:	83 c4 10             	add    $0x10,%esp
  80060b:	05 f4 20 80 00       	add    $0x8020f4,%eax
  800610:	8a 00                	mov    (%eax),%al
  800612:	0f be c0             	movsbl %al,%eax
  800615:	83 ec 08             	sub    $0x8,%esp
  800618:	ff 75 0c             	pushl  0xc(%ebp)
  80061b:	50                   	push   %eax
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	ff d0                	call   *%eax
  800621:	83 c4 10             	add    $0x10,%esp
}
  800624:	90                   	nop
  800625:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800628:	c9                   	leave  
  800629:	c3                   	ret    

0080062a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80062a:	55                   	push   %ebp
  80062b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80062d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800631:	7e 1c                	jle    80064f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800633:	8b 45 08             	mov    0x8(%ebp),%eax
  800636:	8b 00                	mov    (%eax),%eax
  800638:	8d 50 08             	lea    0x8(%eax),%edx
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	89 10                	mov    %edx,(%eax)
  800640:	8b 45 08             	mov    0x8(%ebp),%eax
  800643:	8b 00                	mov    (%eax),%eax
  800645:	83 e8 08             	sub    $0x8,%eax
  800648:	8b 50 04             	mov    0x4(%eax),%edx
  80064b:	8b 00                	mov    (%eax),%eax
  80064d:	eb 40                	jmp    80068f <getuint+0x65>
	else if (lflag)
  80064f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800653:	74 1e                	je     800673 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800655:	8b 45 08             	mov    0x8(%ebp),%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	8d 50 04             	lea    0x4(%eax),%edx
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	89 10                	mov    %edx,(%eax)
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8b 00                	mov    (%eax),%eax
  800667:	83 e8 04             	sub    $0x4,%eax
  80066a:	8b 00                	mov    (%eax),%eax
  80066c:	ba 00 00 00 00       	mov    $0x0,%edx
  800671:	eb 1c                	jmp    80068f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800673:	8b 45 08             	mov    0x8(%ebp),%eax
  800676:	8b 00                	mov    (%eax),%eax
  800678:	8d 50 04             	lea    0x4(%eax),%edx
  80067b:	8b 45 08             	mov    0x8(%ebp),%eax
  80067e:	89 10                	mov    %edx,(%eax)
  800680:	8b 45 08             	mov    0x8(%ebp),%eax
  800683:	8b 00                	mov    (%eax),%eax
  800685:	83 e8 04             	sub    $0x4,%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80068f:	5d                   	pop    %ebp
  800690:	c3                   	ret    

00800691 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800691:	55                   	push   %ebp
  800692:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800694:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800698:	7e 1c                	jle    8006b6 <getint+0x25>
		return va_arg(*ap, long long);
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8b 00                	mov    (%eax),%eax
  80069f:	8d 50 08             	lea    0x8(%eax),%edx
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	89 10                	mov    %edx,(%eax)
  8006a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006aa:	8b 00                	mov    (%eax),%eax
  8006ac:	83 e8 08             	sub    $0x8,%eax
  8006af:	8b 50 04             	mov    0x4(%eax),%edx
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	eb 38                	jmp    8006ee <getint+0x5d>
	else if (lflag)
  8006b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ba:	74 1a                	je     8006d6 <getint+0x45>
		return va_arg(*ap, long);
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	8b 00                	mov    (%eax),%eax
  8006c1:	8d 50 04             	lea    0x4(%eax),%edx
  8006c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c7:	89 10                	mov    %edx,(%eax)
  8006c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cc:	8b 00                	mov    (%eax),%eax
  8006ce:	83 e8 04             	sub    $0x4,%eax
  8006d1:	8b 00                	mov    (%eax),%eax
  8006d3:	99                   	cltd   
  8006d4:	eb 18                	jmp    8006ee <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	8b 00                	mov    (%eax),%eax
  8006db:	8d 50 04             	lea    0x4(%eax),%edx
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	89 10                	mov    %edx,(%eax)
  8006e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	83 e8 04             	sub    $0x4,%eax
  8006eb:	8b 00                	mov    (%eax),%eax
  8006ed:	99                   	cltd   
}
  8006ee:	5d                   	pop    %ebp
  8006ef:	c3                   	ret    

008006f0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006f0:	55                   	push   %ebp
  8006f1:	89 e5                	mov    %esp,%ebp
  8006f3:	56                   	push   %esi
  8006f4:	53                   	push   %ebx
  8006f5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006f8:	eb 17                	jmp    800711 <vprintfmt+0x21>
			if (ch == '\0')
  8006fa:	85 db                	test   %ebx,%ebx
  8006fc:	0f 84 af 03 00 00    	je     800ab1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	ff 75 0c             	pushl  0xc(%ebp)
  800708:	53                   	push   %ebx
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	ff d0                	call   *%eax
  80070e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800711:	8b 45 10             	mov    0x10(%ebp),%eax
  800714:	8d 50 01             	lea    0x1(%eax),%edx
  800717:	89 55 10             	mov    %edx,0x10(%ebp)
  80071a:	8a 00                	mov    (%eax),%al
  80071c:	0f b6 d8             	movzbl %al,%ebx
  80071f:	83 fb 25             	cmp    $0x25,%ebx
  800722:	75 d6                	jne    8006fa <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800724:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800728:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80072f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800736:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80073d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800744:	8b 45 10             	mov    0x10(%ebp),%eax
  800747:	8d 50 01             	lea    0x1(%eax),%edx
  80074a:	89 55 10             	mov    %edx,0x10(%ebp)
  80074d:	8a 00                	mov    (%eax),%al
  80074f:	0f b6 d8             	movzbl %al,%ebx
  800752:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800755:	83 f8 55             	cmp    $0x55,%eax
  800758:	0f 87 2b 03 00 00    	ja     800a89 <vprintfmt+0x399>
  80075e:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  800765:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800767:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80076b:	eb d7                	jmp    800744 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80076d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800771:	eb d1                	jmp    800744 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800773:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80077a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80077d:	89 d0                	mov    %edx,%eax
  80077f:	c1 e0 02             	shl    $0x2,%eax
  800782:	01 d0                	add    %edx,%eax
  800784:	01 c0                	add    %eax,%eax
  800786:	01 d8                	add    %ebx,%eax
  800788:	83 e8 30             	sub    $0x30,%eax
  80078b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80078e:	8b 45 10             	mov    0x10(%ebp),%eax
  800791:	8a 00                	mov    (%eax),%al
  800793:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800796:	83 fb 2f             	cmp    $0x2f,%ebx
  800799:	7e 3e                	jle    8007d9 <vprintfmt+0xe9>
  80079b:	83 fb 39             	cmp    $0x39,%ebx
  80079e:	7f 39                	jg     8007d9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007a0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007a3:	eb d5                	jmp    80077a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a8:	83 c0 04             	add    $0x4,%eax
  8007ab:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b1:	83 e8 04             	sub    $0x4,%eax
  8007b4:	8b 00                	mov    (%eax),%eax
  8007b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007b9:	eb 1f                	jmp    8007da <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007bb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007bf:	79 83                	jns    800744 <vprintfmt+0x54>
				width = 0;
  8007c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007c8:	e9 77 ff ff ff       	jmp    800744 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007cd:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007d4:	e9 6b ff ff ff       	jmp    800744 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007d9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007de:	0f 89 60 ff ff ff    	jns    800744 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007ea:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007f1:	e9 4e ff ff ff       	jmp    800744 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007f6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007f9:	e9 46 ff ff ff       	jmp    800744 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800801:	83 c0 04             	add    $0x4,%eax
  800804:	89 45 14             	mov    %eax,0x14(%ebp)
  800807:	8b 45 14             	mov    0x14(%ebp),%eax
  80080a:	83 e8 04             	sub    $0x4,%eax
  80080d:	8b 00                	mov    (%eax),%eax
  80080f:	83 ec 08             	sub    $0x8,%esp
  800812:	ff 75 0c             	pushl  0xc(%ebp)
  800815:	50                   	push   %eax
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	ff d0                	call   *%eax
  80081b:	83 c4 10             	add    $0x10,%esp
			break;
  80081e:	e9 89 02 00 00       	jmp    800aac <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800823:	8b 45 14             	mov    0x14(%ebp),%eax
  800826:	83 c0 04             	add    $0x4,%eax
  800829:	89 45 14             	mov    %eax,0x14(%ebp)
  80082c:	8b 45 14             	mov    0x14(%ebp),%eax
  80082f:	83 e8 04             	sub    $0x4,%eax
  800832:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800834:	85 db                	test   %ebx,%ebx
  800836:	79 02                	jns    80083a <vprintfmt+0x14a>
				err = -err;
  800838:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80083a:	83 fb 64             	cmp    $0x64,%ebx
  80083d:	7f 0b                	jg     80084a <vprintfmt+0x15a>
  80083f:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  800846:	85 f6                	test   %esi,%esi
  800848:	75 19                	jne    800863 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80084a:	53                   	push   %ebx
  80084b:	68 05 21 80 00       	push   $0x802105
  800850:	ff 75 0c             	pushl  0xc(%ebp)
  800853:	ff 75 08             	pushl  0x8(%ebp)
  800856:	e8 5e 02 00 00       	call   800ab9 <printfmt>
  80085b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80085e:	e9 49 02 00 00       	jmp    800aac <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800863:	56                   	push   %esi
  800864:	68 0e 21 80 00       	push   $0x80210e
  800869:	ff 75 0c             	pushl  0xc(%ebp)
  80086c:	ff 75 08             	pushl  0x8(%ebp)
  80086f:	e8 45 02 00 00       	call   800ab9 <printfmt>
  800874:	83 c4 10             	add    $0x10,%esp
			break;
  800877:	e9 30 02 00 00       	jmp    800aac <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80087c:	8b 45 14             	mov    0x14(%ebp),%eax
  80087f:	83 c0 04             	add    $0x4,%eax
  800882:	89 45 14             	mov    %eax,0x14(%ebp)
  800885:	8b 45 14             	mov    0x14(%ebp),%eax
  800888:	83 e8 04             	sub    $0x4,%eax
  80088b:	8b 30                	mov    (%eax),%esi
  80088d:	85 f6                	test   %esi,%esi
  80088f:	75 05                	jne    800896 <vprintfmt+0x1a6>
				p = "(null)";
  800891:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  800896:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80089a:	7e 6d                	jle    800909 <vprintfmt+0x219>
  80089c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008a0:	74 67                	je     800909 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a5:	83 ec 08             	sub    $0x8,%esp
  8008a8:	50                   	push   %eax
  8008a9:	56                   	push   %esi
  8008aa:	e8 0c 03 00 00       	call   800bbb <strnlen>
  8008af:	83 c4 10             	add    $0x10,%esp
  8008b2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008b5:	eb 16                	jmp    8008cd <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008b7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008bb:	83 ec 08             	sub    $0x8,%esp
  8008be:	ff 75 0c             	pushl  0xc(%ebp)
  8008c1:	50                   	push   %eax
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	ff d0                	call   *%eax
  8008c7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008ca:	ff 4d e4             	decl   -0x1c(%ebp)
  8008cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d1:	7f e4                	jg     8008b7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008d3:	eb 34                	jmp    800909 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008d5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008d9:	74 1c                	je     8008f7 <vprintfmt+0x207>
  8008db:	83 fb 1f             	cmp    $0x1f,%ebx
  8008de:	7e 05                	jle    8008e5 <vprintfmt+0x1f5>
  8008e0:	83 fb 7e             	cmp    $0x7e,%ebx
  8008e3:	7e 12                	jle    8008f7 <vprintfmt+0x207>
					putch('?', putdat);
  8008e5:	83 ec 08             	sub    $0x8,%esp
  8008e8:	ff 75 0c             	pushl  0xc(%ebp)
  8008eb:	6a 3f                	push   $0x3f
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	ff d0                	call   *%eax
  8008f2:	83 c4 10             	add    $0x10,%esp
  8008f5:	eb 0f                	jmp    800906 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	53                   	push   %ebx
  8008fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800901:	ff d0                	call   *%eax
  800903:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800906:	ff 4d e4             	decl   -0x1c(%ebp)
  800909:	89 f0                	mov    %esi,%eax
  80090b:	8d 70 01             	lea    0x1(%eax),%esi
  80090e:	8a 00                	mov    (%eax),%al
  800910:	0f be d8             	movsbl %al,%ebx
  800913:	85 db                	test   %ebx,%ebx
  800915:	74 24                	je     80093b <vprintfmt+0x24b>
  800917:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80091b:	78 b8                	js     8008d5 <vprintfmt+0x1e5>
  80091d:	ff 4d e0             	decl   -0x20(%ebp)
  800920:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800924:	79 af                	jns    8008d5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800926:	eb 13                	jmp    80093b <vprintfmt+0x24b>
				putch(' ', putdat);
  800928:	83 ec 08             	sub    $0x8,%esp
  80092b:	ff 75 0c             	pushl  0xc(%ebp)
  80092e:	6a 20                	push   $0x20
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	ff d0                	call   *%eax
  800935:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800938:	ff 4d e4             	decl   -0x1c(%ebp)
  80093b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80093f:	7f e7                	jg     800928 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800941:	e9 66 01 00 00       	jmp    800aac <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800946:	83 ec 08             	sub    $0x8,%esp
  800949:	ff 75 e8             	pushl  -0x18(%ebp)
  80094c:	8d 45 14             	lea    0x14(%ebp),%eax
  80094f:	50                   	push   %eax
  800950:	e8 3c fd ff ff       	call   800691 <getint>
  800955:	83 c4 10             	add    $0x10,%esp
  800958:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80095e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800961:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800964:	85 d2                	test   %edx,%edx
  800966:	79 23                	jns    80098b <vprintfmt+0x29b>
				putch('-', putdat);
  800968:	83 ec 08             	sub    $0x8,%esp
  80096b:	ff 75 0c             	pushl  0xc(%ebp)
  80096e:	6a 2d                	push   $0x2d
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	ff d0                	call   *%eax
  800975:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800978:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80097b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80097e:	f7 d8                	neg    %eax
  800980:	83 d2 00             	adc    $0x0,%edx
  800983:	f7 da                	neg    %edx
  800985:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800988:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80098b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800992:	e9 bc 00 00 00       	jmp    800a53 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800997:	83 ec 08             	sub    $0x8,%esp
  80099a:	ff 75 e8             	pushl  -0x18(%ebp)
  80099d:	8d 45 14             	lea    0x14(%ebp),%eax
  8009a0:	50                   	push   %eax
  8009a1:	e8 84 fc ff ff       	call   80062a <getuint>
  8009a6:	83 c4 10             	add    $0x10,%esp
  8009a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009af:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009b6:	e9 98 00 00 00       	jmp    800a53 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009bb:	83 ec 08             	sub    $0x8,%esp
  8009be:	ff 75 0c             	pushl  0xc(%ebp)
  8009c1:	6a 58                	push   $0x58
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	ff d0                	call   *%eax
  8009c8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	6a 58                	push   $0x58
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	ff d0                	call   *%eax
  8009d8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009db:	83 ec 08             	sub    $0x8,%esp
  8009de:	ff 75 0c             	pushl  0xc(%ebp)
  8009e1:	6a 58                	push   $0x58
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	ff d0                	call   *%eax
  8009e8:	83 c4 10             	add    $0x10,%esp
			break;
  8009eb:	e9 bc 00 00 00       	jmp    800aac <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009f0:	83 ec 08             	sub    $0x8,%esp
  8009f3:	ff 75 0c             	pushl  0xc(%ebp)
  8009f6:	6a 30                	push   $0x30
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	ff d0                	call   *%eax
  8009fd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a00:	83 ec 08             	sub    $0x8,%esp
  800a03:	ff 75 0c             	pushl  0xc(%ebp)
  800a06:	6a 78                	push   $0x78
  800a08:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0b:	ff d0                	call   *%eax
  800a0d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a10:	8b 45 14             	mov    0x14(%ebp),%eax
  800a13:	83 c0 04             	add    $0x4,%eax
  800a16:	89 45 14             	mov    %eax,0x14(%ebp)
  800a19:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1c:	83 e8 04             	sub    $0x4,%eax
  800a1f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a2b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a32:	eb 1f                	jmp    800a53 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 e8             	pushl  -0x18(%ebp)
  800a3a:	8d 45 14             	lea    0x14(%ebp),%eax
  800a3d:	50                   	push   %eax
  800a3e:	e8 e7 fb ff ff       	call   80062a <getuint>
  800a43:	83 c4 10             	add    $0x10,%esp
  800a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a49:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a4c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a53:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a57:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a5a:	83 ec 04             	sub    $0x4,%esp
  800a5d:	52                   	push   %edx
  800a5e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a61:	50                   	push   %eax
  800a62:	ff 75 f4             	pushl  -0xc(%ebp)
  800a65:	ff 75 f0             	pushl  -0x10(%ebp)
  800a68:	ff 75 0c             	pushl  0xc(%ebp)
  800a6b:	ff 75 08             	pushl  0x8(%ebp)
  800a6e:	e8 00 fb ff ff       	call   800573 <printnum>
  800a73:	83 c4 20             	add    $0x20,%esp
			break;
  800a76:	eb 34                	jmp    800aac <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a78:	83 ec 08             	sub    $0x8,%esp
  800a7b:	ff 75 0c             	pushl  0xc(%ebp)
  800a7e:	53                   	push   %ebx
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	ff d0                	call   *%eax
  800a84:	83 c4 10             	add    $0x10,%esp
			break;
  800a87:	eb 23                	jmp    800aac <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a89:	83 ec 08             	sub    $0x8,%esp
  800a8c:	ff 75 0c             	pushl  0xc(%ebp)
  800a8f:	6a 25                	push   $0x25
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	ff d0                	call   *%eax
  800a96:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a99:	ff 4d 10             	decl   0x10(%ebp)
  800a9c:	eb 03                	jmp    800aa1 <vprintfmt+0x3b1>
  800a9e:	ff 4d 10             	decl   0x10(%ebp)
  800aa1:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa4:	48                   	dec    %eax
  800aa5:	8a 00                	mov    (%eax),%al
  800aa7:	3c 25                	cmp    $0x25,%al
  800aa9:	75 f3                	jne    800a9e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800aab:	90                   	nop
		}
	}
  800aac:	e9 47 fc ff ff       	jmp    8006f8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ab1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ab2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ab5:	5b                   	pop    %ebx
  800ab6:	5e                   	pop    %esi
  800ab7:	5d                   	pop    %ebp
  800ab8:	c3                   	ret    

00800ab9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ab9:	55                   	push   %ebp
  800aba:	89 e5                	mov    %esp,%ebp
  800abc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800abf:	8d 45 10             	lea    0x10(%ebp),%eax
  800ac2:	83 c0 04             	add    $0x4,%eax
  800ac5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ac8:	8b 45 10             	mov    0x10(%ebp),%eax
  800acb:	ff 75 f4             	pushl  -0xc(%ebp)
  800ace:	50                   	push   %eax
  800acf:	ff 75 0c             	pushl  0xc(%ebp)
  800ad2:	ff 75 08             	pushl  0x8(%ebp)
  800ad5:	e8 16 fc ff ff       	call   8006f0 <vprintfmt>
  800ada:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800add:	90                   	nop
  800ade:	c9                   	leave  
  800adf:	c3                   	ret    

00800ae0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ae0:	55                   	push   %ebp
  800ae1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ae3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae6:	8b 40 08             	mov    0x8(%eax),%eax
  800ae9:	8d 50 01             	lea    0x1(%eax),%edx
  800aec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aef:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800af2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af5:	8b 10                	mov    (%eax),%edx
  800af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afa:	8b 40 04             	mov    0x4(%eax),%eax
  800afd:	39 c2                	cmp    %eax,%edx
  800aff:	73 12                	jae    800b13 <sprintputch+0x33>
		*b->buf++ = ch;
  800b01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b04:	8b 00                	mov    (%eax),%eax
  800b06:	8d 48 01             	lea    0x1(%eax),%ecx
  800b09:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0c:	89 0a                	mov    %ecx,(%edx)
  800b0e:	8b 55 08             	mov    0x8(%ebp),%edx
  800b11:	88 10                	mov    %dl,(%eax)
}
  800b13:	90                   	nop
  800b14:	5d                   	pop    %ebp
  800b15:	c3                   	ret    

00800b16 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b16:	55                   	push   %ebp
  800b17:	89 e5                	mov    %esp,%ebp
  800b19:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b25:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	01 d0                	add    %edx,%eax
  800b2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b37:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b3b:	74 06                	je     800b43 <vsnprintf+0x2d>
  800b3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b41:	7f 07                	jg     800b4a <vsnprintf+0x34>
		return -E_INVAL;
  800b43:	b8 03 00 00 00       	mov    $0x3,%eax
  800b48:	eb 20                	jmp    800b6a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b4a:	ff 75 14             	pushl  0x14(%ebp)
  800b4d:	ff 75 10             	pushl  0x10(%ebp)
  800b50:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b53:	50                   	push   %eax
  800b54:	68 e0 0a 80 00       	push   $0x800ae0
  800b59:	e8 92 fb ff ff       	call   8006f0 <vprintfmt>
  800b5e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b61:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b64:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b6a:	c9                   	leave  
  800b6b:	c3                   	ret    

00800b6c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b6c:	55                   	push   %ebp
  800b6d:	89 e5                	mov    %esp,%ebp
  800b6f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b72:	8d 45 10             	lea    0x10(%ebp),%eax
  800b75:	83 c0 04             	add    $0x4,%eax
  800b78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b81:	50                   	push   %eax
  800b82:	ff 75 0c             	pushl  0xc(%ebp)
  800b85:	ff 75 08             	pushl  0x8(%ebp)
  800b88:	e8 89 ff ff ff       	call   800b16 <vsnprintf>
  800b8d:	83 c4 10             	add    $0x10,%esp
  800b90:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b93:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b96:	c9                   	leave  
  800b97:	c3                   	ret    

00800b98 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b98:	55                   	push   %ebp
  800b99:	89 e5                	mov    %esp,%ebp
  800b9b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ba5:	eb 06                	jmp    800bad <strlen+0x15>
		n++;
  800ba7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800baa:	ff 45 08             	incl   0x8(%ebp)
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	8a 00                	mov    (%eax),%al
  800bb2:	84 c0                	test   %al,%al
  800bb4:	75 f1                	jne    800ba7 <strlen+0xf>
		n++;
	return n;
  800bb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb9:	c9                   	leave  
  800bba:	c3                   	ret    

00800bbb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bbb:	55                   	push   %ebp
  800bbc:	89 e5                	mov    %esp,%ebp
  800bbe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc8:	eb 09                	jmp    800bd3 <strnlen+0x18>
		n++;
  800bca:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bcd:	ff 45 08             	incl   0x8(%ebp)
  800bd0:	ff 4d 0c             	decl   0xc(%ebp)
  800bd3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd7:	74 09                	je     800be2 <strnlen+0x27>
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	84 c0                	test   %al,%al
  800be0:	75 e8                	jne    800bca <strnlen+0xf>
		n++;
	return n;
  800be2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bf3:	90                   	nop
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	8d 50 01             	lea    0x1(%eax),%edx
  800bfa:	89 55 08             	mov    %edx,0x8(%ebp)
  800bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c00:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c03:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c06:	8a 12                	mov    (%edx),%dl
  800c08:	88 10                	mov    %dl,(%eax)
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	84 c0                	test   %al,%al
  800c0e:	75 e4                	jne    800bf4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c10:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c13:	c9                   	leave  
  800c14:	c3                   	ret    

00800c15 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c15:	55                   	push   %ebp
  800c16:	89 e5                	mov    %esp,%ebp
  800c18:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c28:	eb 1f                	jmp    800c49 <strncpy+0x34>
		*dst++ = *src;
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	8d 50 01             	lea    0x1(%eax),%edx
  800c30:	89 55 08             	mov    %edx,0x8(%ebp)
  800c33:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c36:	8a 12                	mov    (%edx),%dl
  800c38:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3d:	8a 00                	mov    (%eax),%al
  800c3f:	84 c0                	test   %al,%al
  800c41:	74 03                	je     800c46 <strncpy+0x31>
			src++;
  800c43:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c46:	ff 45 fc             	incl   -0x4(%ebp)
  800c49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c4f:	72 d9                	jb     800c2a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c51:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c54:	c9                   	leave  
  800c55:	c3                   	ret    

00800c56 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
  800c59:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c66:	74 30                	je     800c98 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c68:	eb 16                	jmp    800c80 <strlcpy+0x2a>
			*dst++ = *src++;
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	8d 50 01             	lea    0x1(%eax),%edx
  800c70:	89 55 08             	mov    %edx,0x8(%ebp)
  800c73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c76:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c79:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c7c:	8a 12                	mov    (%edx),%dl
  800c7e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c80:	ff 4d 10             	decl   0x10(%ebp)
  800c83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c87:	74 09                	je     800c92 <strlcpy+0x3c>
  800c89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8c:	8a 00                	mov    (%eax),%al
  800c8e:	84 c0                	test   %al,%al
  800c90:	75 d8                	jne    800c6a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c98:	8b 55 08             	mov    0x8(%ebp),%edx
  800c9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9e:	29 c2                	sub    %eax,%edx
  800ca0:	89 d0                	mov    %edx,%eax
}
  800ca2:	c9                   	leave  
  800ca3:	c3                   	ret    

00800ca4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ca4:	55                   	push   %ebp
  800ca5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ca7:	eb 06                	jmp    800caf <strcmp+0xb>
		p++, q++;
  800ca9:	ff 45 08             	incl   0x8(%ebp)
  800cac:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	84 c0                	test   %al,%al
  800cb6:	74 0e                	je     800cc6 <strcmp+0x22>
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8a 10                	mov    (%eax),%dl
  800cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	38 c2                	cmp    %al,%dl
  800cc4:	74 e3                	je     800ca9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	0f b6 d0             	movzbl %al,%edx
  800cce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd1:	8a 00                	mov    (%eax),%al
  800cd3:	0f b6 c0             	movzbl %al,%eax
  800cd6:	29 c2                	sub    %eax,%edx
  800cd8:	89 d0                	mov    %edx,%eax
}
  800cda:	5d                   	pop    %ebp
  800cdb:	c3                   	ret    

00800cdc <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cdc:	55                   	push   %ebp
  800cdd:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cdf:	eb 09                	jmp    800cea <strncmp+0xe>
		n--, p++, q++;
  800ce1:	ff 4d 10             	decl   0x10(%ebp)
  800ce4:	ff 45 08             	incl   0x8(%ebp)
  800ce7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cee:	74 17                	je     800d07 <strncmp+0x2b>
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8a 00                	mov    (%eax),%al
  800cf5:	84 c0                	test   %al,%al
  800cf7:	74 0e                	je     800d07 <strncmp+0x2b>
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	8a 10                	mov    (%eax),%dl
  800cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	38 c2                	cmp    %al,%dl
  800d05:	74 da                	je     800ce1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0b:	75 07                	jne    800d14 <strncmp+0x38>
		return 0;
  800d0d:	b8 00 00 00 00       	mov    $0x0,%eax
  800d12:	eb 14                	jmp    800d28 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	0f b6 d0             	movzbl %al,%edx
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	0f b6 c0             	movzbl %al,%eax
  800d24:	29 c2                	sub    %eax,%edx
  800d26:	89 d0                	mov    %edx,%eax
}
  800d28:	5d                   	pop    %ebp
  800d29:	c3                   	ret    

00800d2a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d2a:	55                   	push   %ebp
  800d2b:	89 e5                	mov    %esp,%ebp
  800d2d:	83 ec 04             	sub    $0x4,%esp
  800d30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d33:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d36:	eb 12                	jmp    800d4a <strchr+0x20>
		if (*s == c)
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 00                	mov    (%eax),%al
  800d3d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d40:	75 05                	jne    800d47 <strchr+0x1d>
			return (char *) s;
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	eb 11                	jmp    800d58 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d47:	ff 45 08             	incl   0x8(%ebp)
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	84 c0                	test   %al,%al
  800d51:	75 e5                	jne    800d38 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d58:	c9                   	leave  
  800d59:	c3                   	ret    

00800d5a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d5a:	55                   	push   %ebp
  800d5b:	89 e5                	mov    %esp,%ebp
  800d5d:	83 ec 04             	sub    $0x4,%esp
  800d60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d63:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d66:	eb 0d                	jmp    800d75 <strfind+0x1b>
		if (*s == c)
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d70:	74 0e                	je     800d80 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d72:	ff 45 08             	incl   0x8(%ebp)
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	84 c0                	test   %al,%al
  800d7c:	75 ea                	jne    800d68 <strfind+0xe>
  800d7e:	eb 01                	jmp    800d81 <strfind+0x27>
		if (*s == c)
			break;
  800d80:	90                   	nop
	return (char *) s;
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d84:	c9                   	leave  
  800d85:	c3                   	ret    

00800d86 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d86:	55                   	push   %ebp
  800d87:	89 e5                	mov    %esp,%ebp
  800d89:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d92:	8b 45 10             	mov    0x10(%ebp),%eax
  800d95:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d98:	eb 0e                	jmp    800da8 <memset+0x22>
		*p++ = c;
  800d9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d9d:	8d 50 01             	lea    0x1(%eax),%edx
  800da0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800da3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800da8:	ff 4d f8             	decl   -0x8(%ebp)
  800dab:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800daf:	79 e9                	jns    800d9a <memset+0x14>
		*p++ = c;

	return v;
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db4:	c9                   	leave  
  800db5:	c3                   	ret    

00800db6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800db6:	55                   	push   %ebp
  800db7:	89 e5                	mov    %esp,%ebp
  800db9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dc8:	eb 16                	jmp    800de0 <memcpy+0x2a>
		*d++ = *s++;
  800dca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dcd:	8d 50 01             	lea    0x1(%eax),%edx
  800dd0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ddc:	8a 12                	mov    (%edx),%dl
  800dde:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800de0:	8b 45 10             	mov    0x10(%ebp),%eax
  800de3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de6:	89 55 10             	mov    %edx,0x10(%ebp)
  800de9:	85 c0                	test   %eax,%eax
  800deb:	75 dd                	jne    800dca <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800df0:	c9                   	leave  
  800df1:	c3                   	ret    

00800df2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800df2:	55                   	push   %ebp
  800df3:	89 e5                	mov    %esp,%ebp
  800df5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800df8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800e01:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e07:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e0a:	73 50                	jae    800e5c <memmove+0x6a>
  800e0c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e12:	01 d0                	add    %edx,%eax
  800e14:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e17:	76 43                	jbe    800e5c <memmove+0x6a>
		s += n;
  800e19:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e22:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e25:	eb 10                	jmp    800e37 <memmove+0x45>
			*--d = *--s;
  800e27:	ff 4d f8             	decl   -0x8(%ebp)
  800e2a:	ff 4d fc             	decl   -0x4(%ebp)
  800e2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e30:	8a 10                	mov    (%eax),%dl
  800e32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e35:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e37:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e40:	85 c0                	test   %eax,%eax
  800e42:	75 e3                	jne    800e27 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e44:	eb 23                	jmp    800e69 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	8d 50 01             	lea    0x1(%eax),%edx
  800e4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e4f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e52:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e55:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e58:	8a 12                	mov    (%edx),%dl
  800e5a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e62:	89 55 10             	mov    %edx,0x10(%ebp)
  800e65:	85 c0                	test   %eax,%eax
  800e67:	75 dd                	jne    800e46 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6c:	c9                   	leave  
  800e6d:	c3                   	ret    

00800e6e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e6e:	55                   	push   %ebp
  800e6f:	89 e5                	mov    %esp,%ebp
  800e71:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e80:	eb 2a                	jmp    800eac <memcmp+0x3e>
		if (*s1 != *s2)
  800e82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e85:	8a 10                	mov    (%eax),%dl
  800e87:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8a:	8a 00                	mov    (%eax),%al
  800e8c:	38 c2                	cmp    %al,%dl
  800e8e:	74 16                	je     800ea6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e93:	8a 00                	mov    (%eax),%al
  800e95:	0f b6 d0             	movzbl %al,%edx
  800e98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	0f b6 c0             	movzbl %al,%eax
  800ea0:	29 c2                	sub    %eax,%edx
  800ea2:	89 d0                	mov    %edx,%eax
  800ea4:	eb 18                	jmp    800ebe <memcmp+0x50>
		s1++, s2++;
  800ea6:	ff 45 fc             	incl   -0x4(%ebp)
  800ea9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800eac:	8b 45 10             	mov    0x10(%ebp),%eax
  800eaf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb2:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb5:	85 c0                	test   %eax,%eax
  800eb7:	75 c9                	jne    800e82 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eb9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebe:	c9                   	leave  
  800ebf:	c3                   	ret    

00800ec0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ec0:	55                   	push   %ebp
  800ec1:	89 e5                	mov    %esp,%ebp
  800ec3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ec6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecc:	01 d0                	add    %edx,%eax
  800ece:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ed1:	eb 15                	jmp    800ee8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed6:	8a 00                	mov    (%eax),%al
  800ed8:	0f b6 d0             	movzbl %al,%edx
  800edb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ede:	0f b6 c0             	movzbl %al,%eax
  800ee1:	39 c2                	cmp    %eax,%edx
  800ee3:	74 0d                	je     800ef2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ee5:	ff 45 08             	incl   0x8(%ebp)
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eee:	72 e3                	jb     800ed3 <memfind+0x13>
  800ef0:	eb 01                	jmp    800ef3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ef2:	90                   	nop
	return (void *) s;
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef6:	c9                   	leave  
  800ef7:	c3                   	ret    

00800ef8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ef8:	55                   	push   %ebp
  800ef9:	89 e5                	mov    %esp,%ebp
  800efb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800efe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f05:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f0c:	eb 03                	jmp    800f11 <strtol+0x19>
		s++;
  800f0e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	3c 20                	cmp    $0x20,%al
  800f18:	74 f4                	je     800f0e <strtol+0x16>
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	3c 09                	cmp    $0x9,%al
  800f21:	74 eb                	je     800f0e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	3c 2b                	cmp    $0x2b,%al
  800f2a:	75 05                	jne    800f31 <strtol+0x39>
		s++;
  800f2c:	ff 45 08             	incl   0x8(%ebp)
  800f2f:	eb 13                	jmp    800f44 <strtol+0x4c>
	else if (*s == '-')
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	3c 2d                	cmp    $0x2d,%al
  800f38:	75 0a                	jne    800f44 <strtol+0x4c>
		s++, neg = 1;
  800f3a:	ff 45 08             	incl   0x8(%ebp)
  800f3d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f48:	74 06                	je     800f50 <strtol+0x58>
  800f4a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f4e:	75 20                	jne    800f70 <strtol+0x78>
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	3c 30                	cmp    $0x30,%al
  800f57:	75 17                	jne    800f70 <strtol+0x78>
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	40                   	inc    %eax
  800f5d:	8a 00                	mov    (%eax),%al
  800f5f:	3c 78                	cmp    $0x78,%al
  800f61:	75 0d                	jne    800f70 <strtol+0x78>
		s += 2, base = 16;
  800f63:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f67:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f6e:	eb 28                	jmp    800f98 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f74:	75 15                	jne    800f8b <strtol+0x93>
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	3c 30                	cmp    $0x30,%al
  800f7d:	75 0c                	jne    800f8b <strtol+0x93>
		s++, base = 8;
  800f7f:	ff 45 08             	incl   0x8(%ebp)
  800f82:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f89:	eb 0d                	jmp    800f98 <strtol+0xa0>
	else if (base == 0)
  800f8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8f:	75 07                	jne    800f98 <strtol+0xa0>
		base = 10;
  800f91:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	3c 2f                	cmp    $0x2f,%al
  800f9f:	7e 19                	jle    800fba <strtol+0xc2>
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	3c 39                	cmp    $0x39,%al
  800fa8:	7f 10                	jg     800fba <strtol+0xc2>
			dig = *s - '0';
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	8a 00                	mov    (%eax),%al
  800faf:	0f be c0             	movsbl %al,%eax
  800fb2:	83 e8 30             	sub    $0x30,%eax
  800fb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb8:	eb 42                	jmp    800ffc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	3c 60                	cmp    $0x60,%al
  800fc1:	7e 19                	jle    800fdc <strtol+0xe4>
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	3c 7a                	cmp    $0x7a,%al
  800fca:	7f 10                	jg     800fdc <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	0f be c0             	movsbl %al,%eax
  800fd4:	83 e8 57             	sub    $0x57,%eax
  800fd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fda:	eb 20                	jmp    800ffc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	3c 40                	cmp    $0x40,%al
  800fe3:	7e 39                	jle    80101e <strtol+0x126>
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	3c 5a                	cmp    $0x5a,%al
  800fec:	7f 30                	jg     80101e <strtol+0x126>
			dig = *s - 'A' + 10;
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff1:	8a 00                	mov    (%eax),%al
  800ff3:	0f be c0             	movsbl %al,%eax
  800ff6:	83 e8 37             	sub    $0x37,%eax
  800ff9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ffc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fff:	3b 45 10             	cmp    0x10(%ebp),%eax
  801002:	7d 19                	jge    80101d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801004:	ff 45 08             	incl   0x8(%ebp)
  801007:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80100e:	89 c2                	mov    %eax,%edx
  801010:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801013:	01 d0                	add    %edx,%eax
  801015:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801018:	e9 7b ff ff ff       	jmp    800f98 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80101d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80101e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801022:	74 08                	je     80102c <strtol+0x134>
		*endptr = (char *) s;
  801024:	8b 45 0c             	mov    0xc(%ebp),%eax
  801027:	8b 55 08             	mov    0x8(%ebp),%edx
  80102a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80102c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801030:	74 07                	je     801039 <strtol+0x141>
  801032:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801035:	f7 d8                	neg    %eax
  801037:	eb 03                	jmp    80103c <strtol+0x144>
  801039:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <ltostr>:

void
ltostr(long value, char *str)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
  801041:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801044:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80104b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801052:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801056:	79 13                	jns    80106b <ltostr+0x2d>
	{
		neg = 1;
  801058:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80105f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801062:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801065:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801068:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801073:	99                   	cltd   
  801074:	f7 f9                	idiv   %ecx
  801076:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801079:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107c:	8d 50 01             	lea    0x1(%eax),%edx
  80107f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801082:	89 c2                	mov    %eax,%edx
  801084:	8b 45 0c             	mov    0xc(%ebp),%eax
  801087:	01 d0                	add    %edx,%eax
  801089:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80108c:	83 c2 30             	add    $0x30,%edx
  80108f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801091:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801094:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801099:	f7 e9                	imul   %ecx
  80109b:	c1 fa 02             	sar    $0x2,%edx
  80109e:	89 c8                	mov    %ecx,%eax
  8010a0:	c1 f8 1f             	sar    $0x1f,%eax
  8010a3:	29 c2                	sub    %eax,%edx
  8010a5:	89 d0                	mov    %edx,%eax
  8010a7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ad:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010b2:	f7 e9                	imul   %ecx
  8010b4:	c1 fa 02             	sar    $0x2,%edx
  8010b7:	89 c8                	mov    %ecx,%eax
  8010b9:	c1 f8 1f             	sar    $0x1f,%eax
  8010bc:	29 c2                	sub    %eax,%edx
  8010be:	89 d0                	mov    %edx,%eax
  8010c0:	c1 e0 02             	shl    $0x2,%eax
  8010c3:	01 d0                	add    %edx,%eax
  8010c5:	01 c0                	add    %eax,%eax
  8010c7:	29 c1                	sub    %eax,%ecx
  8010c9:	89 ca                	mov    %ecx,%edx
  8010cb:	85 d2                	test   %edx,%edx
  8010cd:	75 9c                	jne    80106b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d9:	48                   	dec    %eax
  8010da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010e1:	74 3d                	je     801120 <ltostr+0xe2>
		start = 1 ;
  8010e3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010ea:	eb 34                	jmp    801120 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f2:	01 d0                	add    %edx,%eax
  8010f4:	8a 00                	mov    (%eax),%al
  8010f6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ff:	01 c2                	add    %eax,%edx
  801101:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	01 c8                	add    %ecx,%eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80110d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801110:	8b 45 0c             	mov    0xc(%ebp),%eax
  801113:	01 c2                	add    %eax,%edx
  801115:	8a 45 eb             	mov    -0x15(%ebp),%al
  801118:	88 02                	mov    %al,(%edx)
		start++ ;
  80111a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80111d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801120:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801123:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801126:	7c c4                	jl     8010ec <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801128:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	01 d0                	add    %edx,%eax
  801130:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801133:	90                   	nop
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
  801139:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80113c:	ff 75 08             	pushl  0x8(%ebp)
  80113f:	e8 54 fa ff ff       	call   800b98 <strlen>
  801144:	83 c4 04             	add    $0x4,%esp
  801147:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80114a:	ff 75 0c             	pushl  0xc(%ebp)
  80114d:	e8 46 fa ff ff       	call   800b98 <strlen>
  801152:	83 c4 04             	add    $0x4,%esp
  801155:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801158:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80115f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801166:	eb 17                	jmp    80117f <strcconcat+0x49>
		final[s] = str1[s] ;
  801168:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116b:	8b 45 10             	mov    0x10(%ebp),%eax
  80116e:	01 c2                	add    %eax,%edx
  801170:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	01 c8                	add    %ecx,%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80117c:	ff 45 fc             	incl   -0x4(%ebp)
  80117f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801182:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801185:	7c e1                	jl     801168 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801187:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80118e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801195:	eb 1f                	jmp    8011b6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801197:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119a:	8d 50 01             	lea    0x1(%eax),%edx
  80119d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011a0:	89 c2                	mov    %eax,%edx
  8011a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a5:	01 c2                	add    %eax,%edx
  8011a7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ad:	01 c8                	add    %ecx,%eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011b3:	ff 45 f8             	incl   -0x8(%ebp)
  8011b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011bc:	7c d9                	jl     801197 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c4:	01 d0                	add    %edx,%eax
  8011c6:	c6 00 00             	movb   $0x0,(%eax)
}
  8011c9:	90                   	nop
  8011ca:	c9                   	leave  
  8011cb:	c3                   	ret    

008011cc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011cc:	55                   	push   %ebp
  8011cd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011db:	8b 00                	mov    (%eax),%eax
  8011dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e7:	01 d0                	add    %edx,%eax
  8011e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ef:	eb 0c                	jmp    8011fd <strsplit+0x31>
			*string++ = 0;
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	8d 50 01             	lea    0x1(%eax),%edx
  8011f7:	89 55 08             	mov    %edx,0x8(%ebp)
  8011fa:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801200:	8a 00                	mov    (%eax),%al
  801202:	84 c0                	test   %al,%al
  801204:	74 18                	je     80121e <strsplit+0x52>
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	0f be c0             	movsbl %al,%eax
  80120e:	50                   	push   %eax
  80120f:	ff 75 0c             	pushl  0xc(%ebp)
  801212:	e8 13 fb ff ff       	call   800d2a <strchr>
  801217:	83 c4 08             	add    $0x8,%esp
  80121a:	85 c0                	test   %eax,%eax
  80121c:	75 d3                	jne    8011f1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80121e:	8b 45 08             	mov    0x8(%ebp),%eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	84 c0                	test   %al,%al
  801225:	74 5a                	je     801281 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801227:	8b 45 14             	mov    0x14(%ebp),%eax
  80122a:	8b 00                	mov    (%eax),%eax
  80122c:	83 f8 0f             	cmp    $0xf,%eax
  80122f:	75 07                	jne    801238 <strsplit+0x6c>
		{
			return 0;
  801231:	b8 00 00 00 00       	mov    $0x0,%eax
  801236:	eb 66                	jmp    80129e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801238:	8b 45 14             	mov    0x14(%ebp),%eax
  80123b:	8b 00                	mov    (%eax),%eax
  80123d:	8d 48 01             	lea    0x1(%eax),%ecx
  801240:	8b 55 14             	mov    0x14(%ebp),%edx
  801243:	89 0a                	mov    %ecx,(%edx)
  801245:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80124c:	8b 45 10             	mov    0x10(%ebp),%eax
  80124f:	01 c2                	add    %eax,%edx
  801251:	8b 45 08             	mov    0x8(%ebp),%eax
  801254:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801256:	eb 03                	jmp    80125b <strsplit+0x8f>
			string++;
  801258:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
  80125e:	8a 00                	mov    (%eax),%al
  801260:	84 c0                	test   %al,%al
  801262:	74 8b                	je     8011ef <strsplit+0x23>
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	8a 00                	mov    (%eax),%al
  801269:	0f be c0             	movsbl %al,%eax
  80126c:	50                   	push   %eax
  80126d:	ff 75 0c             	pushl  0xc(%ebp)
  801270:	e8 b5 fa ff ff       	call   800d2a <strchr>
  801275:	83 c4 08             	add    $0x8,%esp
  801278:	85 c0                	test   %eax,%eax
  80127a:	74 dc                	je     801258 <strsplit+0x8c>
			string++;
	}
  80127c:	e9 6e ff ff ff       	jmp    8011ef <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801281:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801282:	8b 45 14             	mov    0x14(%ebp),%eax
  801285:	8b 00                	mov    (%eax),%eax
  801287:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80128e:	8b 45 10             	mov    0x10(%ebp),%eax
  801291:	01 d0                	add    %edx,%eax
  801293:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801299:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	57                   	push   %edi
  8012a4:	56                   	push   %esi
  8012a5:	53                   	push   %ebx
  8012a6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012b5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012b8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012bb:	cd 30                	int    $0x30
  8012bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012c3:	83 c4 10             	add    $0x10,%esp
  8012c6:	5b                   	pop    %ebx
  8012c7:	5e                   	pop    %esi
  8012c8:	5f                   	pop    %edi
  8012c9:	5d                   	pop    %ebp
  8012ca:	c3                   	ret    

008012cb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012cb:	55                   	push   %ebp
  8012cc:	89 e5                	mov    %esp,%ebp
  8012ce:	83 ec 04             	sub    $0x4,%esp
  8012d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012d7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	52                   	push   %edx
  8012e3:	ff 75 0c             	pushl  0xc(%ebp)
  8012e6:	50                   	push   %eax
  8012e7:	6a 00                	push   $0x0
  8012e9:	e8 b2 ff ff ff       	call   8012a0 <syscall>
  8012ee:	83 c4 18             	add    $0x18,%esp
}
  8012f1:	90                   	nop
  8012f2:	c9                   	leave  
  8012f3:	c3                   	ret    

008012f4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012f4:	55                   	push   %ebp
  8012f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 01                	push   $0x1
  801303:	e8 98 ff ff ff       	call   8012a0 <syscall>
  801308:	83 c4 18             	add    $0x18,%esp
}
  80130b:	c9                   	leave  
  80130c:	c3                   	ret    

0080130d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80130d:	55                   	push   %ebp
  80130e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	50                   	push   %eax
  80131c:	6a 05                	push   $0x5
  80131e:	e8 7d ff ff ff       	call   8012a0 <syscall>
  801323:	83 c4 18             	add    $0x18,%esp
}
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	6a 02                	push   $0x2
  801337:	e8 64 ff ff ff       	call   8012a0 <syscall>
  80133c:	83 c4 18             	add    $0x18,%esp
}
  80133f:	c9                   	leave  
  801340:	c3                   	ret    

00801341 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801341:	55                   	push   %ebp
  801342:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 03                	push   $0x3
  801350:	e8 4b ff ff ff       	call   8012a0 <syscall>
  801355:	83 c4 18             	add    $0x18,%esp
}
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 04                	push   $0x4
  801369:	e8 32 ff ff ff       	call   8012a0 <syscall>
  80136e:	83 c4 18             	add    $0x18,%esp
}
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <sys_env_exit>:


void sys_env_exit(void)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 06                	push   $0x6
  801382:	e8 19 ff ff ff       	call   8012a0 <syscall>
  801387:	83 c4 18             	add    $0x18,%esp
}
  80138a:	90                   	nop
  80138b:	c9                   	leave  
  80138c:	c3                   	ret    

0080138d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80138d:	55                   	push   %ebp
  80138e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801390:	8b 55 0c             	mov    0xc(%ebp),%edx
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	52                   	push   %edx
  80139d:	50                   	push   %eax
  80139e:	6a 07                	push   $0x7
  8013a0:	e8 fb fe ff ff       	call   8012a0 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
  8013ad:	56                   	push   %esi
  8013ae:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013af:	8b 75 18             	mov    0x18(%ebp),%esi
  8013b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	56                   	push   %esi
  8013bf:	53                   	push   %ebx
  8013c0:	51                   	push   %ecx
  8013c1:	52                   	push   %edx
  8013c2:	50                   	push   %eax
  8013c3:	6a 08                	push   $0x8
  8013c5:	e8 d6 fe ff ff       	call   8012a0 <syscall>
  8013ca:	83 c4 18             	add    $0x18,%esp
}
  8013cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013d0:	5b                   	pop    %ebx
  8013d1:	5e                   	pop    %esi
  8013d2:	5d                   	pop    %ebp
  8013d3:	c3                   	ret    

008013d4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013d4:	55                   	push   %ebp
  8013d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	52                   	push   %edx
  8013e4:	50                   	push   %eax
  8013e5:	6a 09                	push   $0x9
  8013e7:	e8 b4 fe ff ff       	call   8012a0 <syscall>
  8013ec:	83 c4 18             	add    $0x18,%esp
}
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	ff 75 0c             	pushl  0xc(%ebp)
  8013fd:	ff 75 08             	pushl  0x8(%ebp)
  801400:	6a 0a                	push   $0xa
  801402:	e8 99 fe ff ff       	call   8012a0 <syscall>
  801407:	83 c4 18             	add    $0x18,%esp
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 0b                	push   $0xb
  80141b:	e8 80 fe ff ff       	call   8012a0 <syscall>
  801420:	83 c4 18             	add    $0x18,%esp
}
  801423:	c9                   	leave  
  801424:	c3                   	ret    

00801425 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 0c                	push   $0xc
  801434:	e8 67 fe ff ff       	call   8012a0 <syscall>
  801439:	83 c4 18             	add    $0x18,%esp
}
  80143c:	c9                   	leave  
  80143d:	c3                   	ret    

0080143e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 0d                	push   $0xd
  80144d:	e8 4e fe ff ff       	call   8012a0 <syscall>
  801452:	83 c4 18             	add    $0x18,%esp
}
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	ff 75 0c             	pushl  0xc(%ebp)
  801463:	ff 75 08             	pushl  0x8(%ebp)
  801466:	6a 11                	push   $0x11
  801468:	e8 33 fe ff ff       	call   8012a0 <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
	return;
  801470:	90                   	nop
}
  801471:	c9                   	leave  
  801472:	c3                   	ret    

00801473 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	ff 75 0c             	pushl  0xc(%ebp)
  80147f:	ff 75 08             	pushl  0x8(%ebp)
  801482:	6a 12                	push   $0x12
  801484:	e8 17 fe ff ff       	call   8012a0 <syscall>
  801489:	83 c4 18             	add    $0x18,%esp
	return ;
  80148c:	90                   	nop
}
  80148d:	c9                   	leave  
  80148e:	c3                   	ret    

0080148f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80148f:	55                   	push   %ebp
  801490:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 0e                	push   $0xe
  80149e:	e8 fd fd ff ff       	call   8012a0 <syscall>
  8014a3:	83 c4 18             	add    $0x18,%esp
}
  8014a6:	c9                   	leave  
  8014a7:	c3                   	ret    

008014a8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	ff 75 08             	pushl  0x8(%ebp)
  8014b6:	6a 0f                	push   $0xf
  8014b8:	e8 e3 fd ff ff       	call   8012a0 <syscall>
  8014bd:	83 c4 18             	add    $0x18,%esp
}
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 10                	push   $0x10
  8014d1:	e8 ca fd ff ff       	call   8012a0 <syscall>
  8014d6:	83 c4 18             	add    $0x18,%esp
}
  8014d9:	90                   	nop
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 14                	push   $0x14
  8014eb:	e8 b0 fd ff ff       	call   8012a0 <syscall>
  8014f0:	83 c4 18             	add    $0x18,%esp
}
  8014f3:	90                   	nop
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 15                	push   $0x15
  801505:	e8 96 fd ff ff       	call   8012a0 <syscall>
  80150a:	83 c4 18             	add    $0x18,%esp
}
  80150d:	90                   	nop
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <sys_cputc>:


void
sys_cputc(const char c)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
  801513:	83 ec 04             	sub    $0x4,%esp
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80151c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	50                   	push   %eax
  801529:	6a 16                	push   $0x16
  80152b:	e8 70 fd ff ff       	call   8012a0 <syscall>
  801530:	83 c4 18             	add    $0x18,%esp
}
  801533:	90                   	nop
  801534:	c9                   	leave  
  801535:	c3                   	ret    

00801536 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801536:	55                   	push   %ebp
  801537:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 17                	push   $0x17
  801545:	e8 56 fd ff ff       	call   8012a0 <syscall>
  80154a:	83 c4 18             	add    $0x18,%esp
}
  80154d:	90                   	nop
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801553:	8b 45 08             	mov    0x8(%ebp),%eax
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	ff 75 0c             	pushl  0xc(%ebp)
  80155f:	50                   	push   %eax
  801560:	6a 18                	push   $0x18
  801562:	e8 39 fd ff ff       	call   8012a0 <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80156f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801572:	8b 45 08             	mov    0x8(%ebp),%eax
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	52                   	push   %edx
  80157c:	50                   	push   %eax
  80157d:	6a 1b                	push   $0x1b
  80157f:	e8 1c fd ff ff       	call   8012a0 <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80158c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	52                   	push   %edx
  801599:	50                   	push   %eax
  80159a:	6a 19                	push   $0x19
  80159c:	e8 ff fc ff ff       	call   8012a0 <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
}
  8015a4:	90                   	nop
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	52                   	push   %edx
  8015b7:	50                   	push   %eax
  8015b8:	6a 1a                	push   $0x1a
  8015ba:	e8 e1 fc ff ff       	call   8012a0 <syscall>
  8015bf:	83 c4 18             	add    $0x18,%esp
}
  8015c2:	90                   	nop
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 04             	sub    $0x4,%esp
  8015cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015d1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015d4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	6a 00                	push   $0x0
  8015dd:	51                   	push   %ecx
  8015de:	52                   	push   %edx
  8015df:	ff 75 0c             	pushl  0xc(%ebp)
  8015e2:	50                   	push   %eax
  8015e3:	6a 1c                	push   $0x1c
  8015e5:	e8 b6 fc ff ff       	call   8012a0 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	52                   	push   %edx
  8015ff:	50                   	push   %eax
  801600:	6a 1d                	push   $0x1d
  801602:	e8 99 fc ff ff       	call   8012a0 <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80160f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801612:	8b 55 0c             	mov    0xc(%ebp),%edx
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	51                   	push   %ecx
  80161d:	52                   	push   %edx
  80161e:	50                   	push   %eax
  80161f:	6a 1e                	push   $0x1e
  801621:	e8 7a fc ff ff       	call   8012a0 <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80162e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	52                   	push   %edx
  80163b:	50                   	push   %eax
  80163c:	6a 1f                	push   $0x1f
  80163e:	e8 5d fc ff ff       	call   8012a0 <syscall>
  801643:	83 c4 18             	add    $0x18,%esp
}
  801646:	c9                   	leave  
  801647:	c3                   	ret    

00801648 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801648:	55                   	push   %ebp
  801649:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	6a 20                	push   $0x20
  801657:	e8 44 fc ff ff       	call   8012a0 <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	6a 00                	push   $0x0
  801669:	ff 75 14             	pushl  0x14(%ebp)
  80166c:	ff 75 10             	pushl  0x10(%ebp)
  80166f:	ff 75 0c             	pushl  0xc(%ebp)
  801672:	50                   	push   %eax
  801673:	6a 21                	push   $0x21
  801675:	e8 26 fc ff ff       	call   8012a0 <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
}
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	50                   	push   %eax
  80168e:	6a 22                	push   $0x22
  801690:	e8 0b fc ff ff       	call   8012a0 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
}
  801698:	90                   	nop
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	50                   	push   %eax
  8016aa:	6a 23                	push   $0x23
  8016ac:	e8 ef fb ff ff       	call   8012a0 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	90                   	nop
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
  8016ba:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016bd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016c0:	8d 50 04             	lea    0x4(%eax),%edx
  8016c3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	52                   	push   %edx
  8016cd:	50                   	push   %eax
  8016ce:	6a 24                	push   $0x24
  8016d0:	e8 cb fb ff ff       	call   8012a0 <syscall>
  8016d5:	83 c4 18             	add    $0x18,%esp
	return result;
  8016d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016db:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016e1:	89 01                	mov    %eax,(%ecx)
  8016e3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	c9                   	leave  
  8016ea:	c2 04 00             	ret    $0x4

008016ed <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	ff 75 10             	pushl  0x10(%ebp)
  8016f7:	ff 75 0c             	pushl  0xc(%ebp)
  8016fa:	ff 75 08             	pushl  0x8(%ebp)
  8016fd:	6a 13                	push   $0x13
  8016ff:	e8 9c fb ff ff       	call   8012a0 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
	return ;
  801707:	90                   	nop
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_rcr2>:
uint32 sys_rcr2()
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 25                	push   $0x25
  801719:	e8 82 fb ff ff       	call   8012a0 <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
  801726:	83 ec 04             	sub    $0x4,%esp
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80172f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	50                   	push   %eax
  80173c:	6a 26                	push   $0x26
  80173e:	e8 5d fb ff ff       	call   8012a0 <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
	return ;
  801746:	90                   	nop
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <rsttst>:
void rsttst()
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 28                	push   $0x28
  801758:	e8 43 fb ff ff       	call   8012a0 <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
	return ;
  801760:	90                   	nop
}
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
  801766:	83 ec 04             	sub    $0x4,%esp
  801769:	8b 45 14             	mov    0x14(%ebp),%eax
  80176c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80176f:	8b 55 18             	mov    0x18(%ebp),%edx
  801772:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801776:	52                   	push   %edx
  801777:	50                   	push   %eax
  801778:	ff 75 10             	pushl  0x10(%ebp)
  80177b:	ff 75 0c             	pushl  0xc(%ebp)
  80177e:	ff 75 08             	pushl  0x8(%ebp)
  801781:	6a 27                	push   $0x27
  801783:	e8 18 fb ff ff       	call   8012a0 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
	return ;
  80178b:	90                   	nop
}
  80178c:	c9                   	leave  
  80178d:	c3                   	ret    

0080178e <chktst>:
void chktst(uint32 n)
{
  80178e:	55                   	push   %ebp
  80178f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	ff 75 08             	pushl  0x8(%ebp)
  80179c:	6a 29                	push   $0x29
  80179e:	e8 fd fa ff ff       	call   8012a0 <syscall>
  8017a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a6:	90                   	nop
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <inctst>:

void inctst()
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 2a                	push   $0x2a
  8017b8:	e8 e3 fa ff ff       	call   8012a0 <syscall>
  8017bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c0:	90                   	nop
}
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    

008017c3 <gettst>:
uint32 gettst()
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 2b                	push   $0x2b
  8017d2:	e8 c9 fa ff ff       	call   8012a0 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
  8017df:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 2c                	push   $0x2c
  8017ee:	e8 ad fa ff ff       	call   8012a0 <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
  8017f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017f9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017fd:	75 07                	jne    801806 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017ff:	b8 01 00 00 00       	mov    $0x1,%eax
  801804:	eb 05                	jmp    80180b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801806:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
  801810:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 2c                	push   $0x2c
  80181f:	e8 7c fa ff ff       	call   8012a0 <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
  801827:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80182a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80182e:	75 07                	jne    801837 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801830:	b8 01 00 00 00       	mov    $0x1,%eax
  801835:	eb 05                	jmp    80183c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801837:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
  801841:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 2c                	push   $0x2c
  801850:	e8 4b fa ff ff       	call   8012a0 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
  801858:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80185b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80185f:	75 07                	jne    801868 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801861:	b8 01 00 00 00       	mov    $0x1,%eax
  801866:	eb 05                	jmp    80186d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801868:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80186d:	c9                   	leave  
  80186e:	c3                   	ret    

0080186f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80186f:	55                   	push   %ebp
  801870:	89 e5                	mov    %esp,%ebp
  801872:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 2c                	push   $0x2c
  801881:	e8 1a fa ff ff       	call   8012a0 <syscall>
  801886:	83 c4 18             	add    $0x18,%esp
  801889:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80188c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801890:	75 07                	jne    801899 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801892:	b8 01 00 00 00       	mov    $0x1,%eax
  801897:	eb 05                	jmp    80189e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801899:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	ff 75 08             	pushl  0x8(%ebp)
  8018ae:	6a 2d                	push   $0x2d
  8018b0:	e8 eb f9 ff ff       	call   8012a0 <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b8:	90                   	nop
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
  8018be:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018bf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	6a 00                	push   $0x0
  8018cd:	53                   	push   %ebx
  8018ce:	51                   	push   %ecx
  8018cf:	52                   	push   %edx
  8018d0:	50                   	push   %eax
  8018d1:	6a 2e                	push   $0x2e
  8018d3:	e8 c8 f9 ff ff       	call   8012a0 <syscall>
  8018d8:	83 c4 18             	add    $0x18,%esp
}
  8018db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	52                   	push   %edx
  8018f0:	50                   	push   %eax
  8018f1:	6a 2f                	push   $0x2f
  8018f3:	e8 a8 f9 ff ff       	call   8012a0 <syscall>
  8018f8:	83 c4 18             	add    $0x18,%esp
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    
  8018fd:	66 90                	xchg   %ax,%ax
  8018ff:	90                   	nop

00801900 <__udivdi3>:
  801900:	55                   	push   %ebp
  801901:	57                   	push   %edi
  801902:	56                   	push   %esi
  801903:	53                   	push   %ebx
  801904:	83 ec 1c             	sub    $0x1c,%esp
  801907:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80190b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80190f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801913:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801917:	89 ca                	mov    %ecx,%edx
  801919:	89 f8                	mov    %edi,%eax
  80191b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80191f:	85 f6                	test   %esi,%esi
  801921:	75 2d                	jne    801950 <__udivdi3+0x50>
  801923:	39 cf                	cmp    %ecx,%edi
  801925:	77 65                	ja     80198c <__udivdi3+0x8c>
  801927:	89 fd                	mov    %edi,%ebp
  801929:	85 ff                	test   %edi,%edi
  80192b:	75 0b                	jne    801938 <__udivdi3+0x38>
  80192d:	b8 01 00 00 00       	mov    $0x1,%eax
  801932:	31 d2                	xor    %edx,%edx
  801934:	f7 f7                	div    %edi
  801936:	89 c5                	mov    %eax,%ebp
  801938:	31 d2                	xor    %edx,%edx
  80193a:	89 c8                	mov    %ecx,%eax
  80193c:	f7 f5                	div    %ebp
  80193e:	89 c1                	mov    %eax,%ecx
  801940:	89 d8                	mov    %ebx,%eax
  801942:	f7 f5                	div    %ebp
  801944:	89 cf                	mov    %ecx,%edi
  801946:	89 fa                	mov    %edi,%edx
  801948:	83 c4 1c             	add    $0x1c,%esp
  80194b:	5b                   	pop    %ebx
  80194c:	5e                   	pop    %esi
  80194d:	5f                   	pop    %edi
  80194e:	5d                   	pop    %ebp
  80194f:	c3                   	ret    
  801950:	39 ce                	cmp    %ecx,%esi
  801952:	77 28                	ja     80197c <__udivdi3+0x7c>
  801954:	0f bd fe             	bsr    %esi,%edi
  801957:	83 f7 1f             	xor    $0x1f,%edi
  80195a:	75 40                	jne    80199c <__udivdi3+0x9c>
  80195c:	39 ce                	cmp    %ecx,%esi
  80195e:	72 0a                	jb     80196a <__udivdi3+0x6a>
  801960:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801964:	0f 87 9e 00 00 00    	ja     801a08 <__udivdi3+0x108>
  80196a:	b8 01 00 00 00       	mov    $0x1,%eax
  80196f:	89 fa                	mov    %edi,%edx
  801971:	83 c4 1c             	add    $0x1c,%esp
  801974:	5b                   	pop    %ebx
  801975:	5e                   	pop    %esi
  801976:	5f                   	pop    %edi
  801977:	5d                   	pop    %ebp
  801978:	c3                   	ret    
  801979:	8d 76 00             	lea    0x0(%esi),%esi
  80197c:	31 ff                	xor    %edi,%edi
  80197e:	31 c0                	xor    %eax,%eax
  801980:	89 fa                	mov    %edi,%edx
  801982:	83 c4 1c             	add    $0x1c,%esp
  801985:	5b                   	pop    %ebx
  801986:	5e                   	pop    %esi
  801987:	5f                   	pop    %edi
  801988:	5d                   	pop    %ebp
  801989:	c3                   	ret    
  80198a:	66 90                	xchg   %ax,%ax
  80198c:	89 d8                	mov    %ebx,%eax
  80198e:	f7 f7                	div    %edi
  801990:	31 ff                	xor    %edi,%edi
  801992:	89 fa                	mov    %edi,%edx
  801994:	83 c4 1c             	add    $0x1c,%esp
  801997:	5b                   	pop    %ebx
  801998:	5e                   	pop    %esi
  801999:	5f                   	pop    %edi
  80199a:	5d                   	pop    %ebp
  80199b:	c3                   	ret    
  80199c:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019a1:	89 eb                	mov    %ebp,%ebx
  8019a3:	29 fb                	sub    %edi,%ebx
  8019a5:	89 f9                	mov    %edi,%ecx
  8019a7:	d3 e6                	shl    %cl,%esi
  8019a9:	89 c5                	mov    %eax,%ebp
  8019ab:	88 d9                	mov    %bl,%cl
  8019ad:	d3 ed                	shr    %cl,%ebp
  8019af:	89 e9                	mov    %ebp,%ecx
  8019b1:	09 f1                	or     %esi,%ecx
  8019b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019b7:	89 f9                	mov    %edi,%ecx
  8019b9:	d3 e0                	shl    %cl,%eax
  8019bb:	89 c5                	mov    %eax,%ebp
  8019bd:	89 d6                	mov    %edx,%esi
  8019bf:	88 d9                	mov    %bl,%cl
  8019c1:	d3 ee                	shr    %cl,%esi
  8019c3:	89 f9                	mov    %edi,%ecx
  8019c5:	d3 e2                	shl    %cl,%edx
  8019c7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019cb:	88 d9                	mov    %bl,%cl
  8019cd:	d3 e8                	shr    %cl,%eax
  8019cf:	09 c2                	or     %eax,%edx
  8019d1:	89 d0                	mov    %edx,%eax
  8019d3:	89 f2                	mov    %esi,%edx
  8019d5:	f7 74 24 0c          	divl   0xc(%esp)
  8019d9:	89 d6                	mov    %edx,%esi
  8019db:	89 c3                	mov    %eax,%ebx
  8019dd:	f7 e5                	mul    %ebp
  8019df:	39 d6                	cmp    %edx,%esi
  8019e1:	72 19                	jb     8019fc <__udivdi3+0xfc>
  8019e3:	74 0b                	je     8019f0 <__udivdi3+0xf0>
  8019e5:	89 d8                	mov    %ebx,%eax
  8019e7:	31 ff                	xor    %edi,%edi
  8019e9:	e9 58 ff ff ff       	jmp    801946 <__udivdi3+0x46>
  8019ee:	66 90                	xchg   %ax,%ax
  8019f0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8019f4:	89 f9                	mov    %edi,%ecx
  8019f6:	d3 e2                	shl    %cl,%edx
  8019f8:	39 c2                	cmp    %eax,%edx
  8019fa:	73 e9                	jae    8019e5 <__udivdi3+0xe5>
  8019fc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8019ff:	31 ff                	xor    %edi,%edi
  801a01:	e9 40 ff ff ff       	jmp    801946 <__udivdi3+0x46>
  801a06:	66 90                	xchg   %ax,%ax
  801a08:	31 c0                	xor    %eax,%eax
  801a0a:	e9 37 ff ff ff       	jmp    801946 <__udivdi3+0x46>
  801a0f:	90                   	nop

00801a10 <__umoddi3>:
  801a10:	55                   	push   %ebp
  801a11:	57                   	push   %edi
  801a12:	56                   	push   %esi
  801a13:	53                   	push   %ebx
  801a14:	83 ec 1c             	sub    $0x1c,%esp
  801a17:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a1b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a23:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a27:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a2b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a2f:	89 f3                	mov    %esi,%ebx
  801a31:	89 fa                	mov    %edi,%edx
  801a33:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a37:	89 34 24             	mov    %esi,(%esp)
  801a3a:	85 c0                	test   %eax,%eax
  801a3c:	75 1a                	jne    801a58 <__umoddi3+0x48>
  801a3e:	39 f7                	cmp    %esi,%edi
  801a40:	0f 86 a2 00 00 00    	jbe    801ae8 <__umoddi3+0xd8>
  801a46:	89 c8                	mov    %ecx,%eax
  801a48:	89 f2                	mov    %esi,%edx
  801a4a:	f7 f7                	div    %edi
  801a4c:	89 d0                	mov    %edx,%eax
  801a4e:	31 d2                	xor    %edx,%edx
  801a50:	83 c4 1c             	add    $0x1c,%esp
  801a53:	5b                   	pop    %ebx
  801a54:	5e                   	pop    %esi
  801a55:	5f                   	pop    %edi
  801a56:	5d                   	pop    %ebp
  801a57:	c3                   	ret    
  801a58:	39 f0                	cmp    %esi,%eax
  801a5a:	0f 87 ac 00 00 00    	ja     801b0c <__umoddi3+0xfc>
  801a60:	0f bd e8             	bsr    %eax,%ebp
  801a63:	83 f5 1f             	xor    $0x1f,%ebp
  801a66:	0f 84 ac 00 00 00    	je     801b18 <__umoddi3+0x108>
  801a6c:	bf 20 00 00 00       	mov    $0x20,%edi
  801a71:	29 ef                	sub    %ebp,%edi
  801a73:	89 fe                	mov    %edi,%esi
  801a75:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a79:	89 e9                	mov    %ebp,%ecx
  801a7b:	d3 e0                	shl    %cl,%eax
  801a7d:	89 d7                	mov    %edx,%edi
  801a7f:	89 f1                	mov    %esi,%ecx
  801a81:	d3 ef                	shr    %cl,%edi
  801a83:	09 c7                	or     %eax,%edi
  801a85:	89 e9                	mov    %ebp,%ecx
  801a87:	d3 e2                	shl    %cl,%edx
  801a89:	89 14 24             	mov    %edx,(%esp)
  801a8c:	89 d8                	mov    %ebx,%eax
  801a8e:	d3 e0                	shl    %cl,%eax
  801a90:	89 c2                	mov    %eax,%edx
  801a92:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a96:	d3 e0                	shl    %cl,%eax
  801a98:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a9c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa0:	89 f1                	mov    %esi,%ecx
  801aa2:	d3 e8                	shr    %cl,%eax
  801aa4:	09 d0                	or     %edx,%eax
  801aa6:	d3 eb                	shr    %cl,%ebx
  801aa8:	89 da                	mov    %ebx,%edx
  801aaa:	f7 f7                	div    %edi
  801aac:	89 d3                	mov    %edx,%ebx
  801aae:	f7 24 24             	mull   (%esp)
  801ab1:	89 c6                	mov    %eax,%esi
  801ab3:	89 d1                	mov    %edx,%ecx
  801ab5:	39 d3                	cmp    %edx,%ebx
  801ab7:	0f 82 87 00 00 00    	jb     801b44 <__umoddi3+0x134>
  801abd:	0f 84 91 00 00 00    	je     801b54 <__umoddi3+0x144>
  801ac3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ac7:	29 f2                	sub    %esi,%edx
  801ac9:	19 cb                	sbb    %ecx,%ebx
  801acb:	89 d8                	mov    %ebx,%eax
  801acd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ad1:	d3 e0                	shl    %cl,%eax
  801ad3:	89 e9                	mov    %ebp,%ecx
  801ad5:	d3 ea                	shr    %cl,%edx
  801ad7:	09 d0                	or     %edx,%eax
  801ad9:	89 e9                	mov    %ebp,%ecx
  801adb:	d3 eb                	shr    %cl,%ebx
  801add:	89 da                	mov    %ebx,%edx
  801adf:	83 c4 1c             	add    $0x1c,%esp
  801ae2:	5b                   	pop    %ebx
  801ae3:	5e                   	pop    %esi
  801ae4:	5f                   	pop    %edi
  801ae5:	5d                   	pop    %ebp
  801ae6:	c3                   	ret    
  801ae7:	90                   	nop
  801ae8:	89 fd                	mov    %edi,%ebp
  801aea:	85 ff                	test   %edi,%edi
  801aec:	75 0b                	jne    801af9 <__umoddi3+0xe9>
  801aee:	b8 01 00 00 00       	mov    $0x1,%eax
  801af3:	31 d2                	xor    %edx,%edx
  801af5:	f7 f7                	div    %edi
  801af7:	89 c5                	mov    %eax,%ebp
  801af9:	89 f0                	mov    %esi,%eax
  801afb:	31 d2                	xor    %edx,%edx
  801afd:	f7 f5                	div    %ebp
  801aff:	89 c8                	mov    %ecx,%eax
  801b01:	f7 f5                	div    %ebp
  801b03:	89 d0                	mov    %edx,%eax
  801b05:	e9 44 ff ff ff       	jmp    801a4e <__umoddi3+0x3e>
  801b0a:	66 90                	xchg   %ax,%ax
  801b0c:	89 c8                	mov    %ecx,%eax
  801b0e:	89 f2                	mov    %esi,%edx
  801b10:	83 c4 1c             	add    $0x1c,%esp
  801b13:	5b                   	pop    %ebx
  801b14:	5e                   	pop    %esi
  801b15:	5f                   	pop    %edi
  801b16:	5d                   	pop    %ebp
  801b17:	c3                   	ret    
  801b18:	3b 04 24             	cmp    (%esp),%eax
  801b1b:	72 06                	jb     801b23 <__umoddi3+0x113>
  801b1d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b21:	77 0f                	ja     801b32 <__umoddi3+0x122>
  801b23:	89 f2                	mov    %esi,%edx
  801b25:	29 f9                	sub    %edi,%ecx
  801b27:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b2b:	89 14 24             	mov    %edx,(%esp)
  801b2e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b32:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b36:	8b 14 24             	mov    (%esp),%edx
  801b39:	83 c4 1c             	add    $0x1c,%esp
  801b3c:	5b                   	pop    %ebx
  801b3d:	5e                   	pop    %esi
  801b3e:	5f                   	pop    %edi
  801b3f:	5d                   	pop    %ebp
  801b40:	c3                   	ret    
  801b41:	8d 76 00             	lea    0x0(%esi),%esi
  801b44:	2b 04 24             	sub    (%esp),%eax
  801b47:	19 fa                	sbb    %edi,%edx
  801b49:	89 d1                	mov    %edx,%ecx
  801b4b:	89 c6                	mov    %eax,%esi
  801b4d:	e9 71 ff ff ff       	jmp    801ac3 <__umoddi3+0xb3>
  801b52:	66 90                	xchg   %ax,%ax
  801b54:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b58:	72 ea                	jb     801b44 <__umoddi3+0x134>
  801b5a:	89 d9                	mov    %ebx,%ecx
  801b5c:	e9 62 ff ff ff       	jmp    801ac3 <__umoddi3+0xb3>
