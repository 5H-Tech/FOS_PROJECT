
obj/user/concurrent_start:     file format elf32-i386


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
  800031:	e8 eb 00 00 00       	call   800121 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	char *str ;
	sys_createSharedObject("cnc1", 512, 1, (void*) &str);
  80003e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800041:	50                   	push   %eax
  800042:	6a 01                	push   $0x1
  800044:	68 00 02 00 00       	push   $0x200
  800049:	68 60 1b 80 00       	push   $0x801b60
  80004e:	e8 64 15 00 00       	call   8015b7 <sys_createSharedObject>
  800053:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("cnc1", 1);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	6a 01                	push   $0x1
  80005b:	68 60 1b 80 00       	push   $0x801b60
  800060:	e8 dd 14 00 00       	call   801542 <sys_createSemaphore>
  800065:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	68 65 1b 80 00       	push   $0x801b65
  800072:	e8 cb 14 00 00       	call   801542 <sys_createSemaphore>
  800077:	83 c4 10             	add    $0x10,%esp

	uint32 id1, id2;
	id2 = sys_create_env("qs2", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80007a:	a1 20 30 80 00       	mov    0x803020,%eax
  80007f:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800085:	a1 20 30 80 00       	mov    0x803020,%eax
  80008a:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800090:	89 c1                	mov    %eax,%ecx
  800092:	a1 20 30 80 00       	mov    0x803020,%eax
  800097:	8b 40 74             	mov    0x74(%eax),%eax
  80009a:	52                   	push   %edx
  80009b:	51                   	push   %ecx
  80009c:	50                   	push   %eax
  80009d:	68 6d 1b 80 00       	push   $0x801b6d
  8000a2:	e8 ac 15 00 00       	call   801653 <sys_create_env>
  8000a7:	83 c4 10             	add    $0x10,%esp
  8000aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	id1 = sys_create_env("qs1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000bd:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000c3:	89 c1                	mov    %eax,%ecx
  8000c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ca:	8b 40 74             	mov    0x74(%eax),%eax
  8000cd:	52                   	push   %edx
  8000ce:	51                   	push   %ecx
  8000cf:	50                   	push   %eax
  8000d0:	68 71 1b 80 00       	push   $0x801b71
  8000d5:	e8 79 15 00 00       	call   801653 <sys_create_env>
  8000da:	83 c4 10             	add    $0x10,%esp
  8000dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (id1 == E_ENV_CREATION_ERROR || id2 == E_ENV_CREATION_ERROR)
  8000e0:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  8000e4:	74 06                	je     8000ec <_main+0xb4>
  8000e6:	83 7d f4 ef          	cmpl   $0xffffffef,-0xc(%ebp)
  8000ea:	75 14                	jne    800100 <_main+0xc8>
		panic("NO AVAILABLE ENVs...");
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 75 1b 80 00       	push   $0x801b75
  8000f4:	6a 11                	push   $0x11
  8000f6:	68 8a 1b 80 00       	push   $0x801b8a
  8000fb:	e8 66 01 00 00       	call   800266 <_panic>

	sys_run_env(id2);
  800100:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 65 15 00 00       	call   801671 <sys_run_env>
  80010c:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id1);
  80010f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	50                   	push   %eax
  800116:	e8 56 15 00 00       	call   801671 <sys_run_env>
  80011b:	83 c4 10             	add    $0x10,%esp

	return;
  80011e:	90                   	nop
}
  80011f:	c9                   	leave  
  800120:	c3                   	ret    

00800121 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800121:	55                   	push   %ebp
  800122:	89 e5                	mov    %esp,%ebp
  800124:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800127:	e8 07 12 00 00       	call   801333 <sys_getenvindex>
  80012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80012f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800132:	89 d0                	mov    %edx,%eax
  800134:	c1 e0 03             	shl    $0x3,%eax
  800137:	01 d0                	add    %edx,%eax
  800139:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800140:	01 c8                	add    %ecx,%eax
  800142:	01 c0                	add    %eax,%eax
  800144:	01 d0                	add    %edx,%eax
  800146:	01 c0                	add    %eax,%eax
  800148:	01 d0                	add    %edx,%eax
  80014a:	89 c2                	mov    %eax,%edx
  80014c:	c1 e2 05             	shl    $0x5,%edx
  80014f:	29 c2                	sub    %eax,%edx
  800151:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800158:	89 c2                	mov    %eax,%edx
  80015a:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800160:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800165:	a1 20 30 80 00       	mov    0x803020,%eax
  80016a:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800170:	84 c0                	test   %al,%al
  800172:	74 0f                	je     800183 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	05 40 3c 01 00       	add    $0x13c40,%eax
  80017e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800183:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800187:	7e 0a                	jle    800193 <libmain+0x72>
		binaryname = argv[0];
  800189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018c:	8b 00                	mov    (%eax),%eax
  80018e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800193:	83 ec 08             	sub    $0x8,%esp
  800196:	ff 75 0c             	pushl  0xc(%ebp)
  800199:	ff 75 08             	pushl  0x8(%ebp)
  80019c:	e8 97 fe ff ff       	call   800038 <_main>
  8001a1:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a4:	e8 25 13 00 00       	call   8014ce <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a9:	83 ec 0c             	sub    $0xc,%esp
  8001ac:	68 bc 1b 80 00       	push   $0x801bbc
  8001b1:	e8 52 03 00 00       	call   800508 <cprintf>
  8001b6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001be:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c9:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	52                   	push   %edx
  8001d3:	50                   	push   %eax
  8001d4:	68 e4 1b 80 00       	push   $0x801be4
  8001d9:	e8 2a 03 00 00       	call   800508 <cprintf>
  8001de:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e6:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f1:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001f7:	83 ec 04             	sub    $0x4,%esp
  8001fa:	52                   	push   %edx
  8001fb:	50                   	push   %eax
  8001fc:	68 0c 1c 80 00       	push   $0x801c0c
  800201:	e8 02 03 00 00       	call   800508 <cprintf>
  800206:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800209:	a1 20 30 80 00       	mov    0x803020,%eax
  80020e:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800214:	83 ec 08             	sub    $0x8,%esp
  800217:	50                   	push   %eax
  800218:	68 4d 1c 80 00       	push   $0x801c4d
  80021d:	e8 e6 02 00 00       	call   800508 <cprintf>
  800222:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800225:	83 ec 0c             	sub    $0xc,%esp
  800228:	68 bc 1b 80 00       	push   $0x801bbc
  80022d:	e8 d6 02 00 00       	call   800508 <cprintf>
  800232:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800235:	e8 ae 12 00 00       	call   8014e8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80023a:	e8 19 00 00 00       	call   800258 <exit>
}
  80023f:	90                   	nop
  800240:	c9                   	leave  
  800241:	c3                   	ret    

00800242 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800242:	55                   	push   %ebp
  800243:	89 e5                	mov    %esp,%ebp
  800245:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	6a 00                	push   $0x0
  80024d:	e8 ad 10 00 00       	call   8012ff <sys_env_destroy>
  800252:	83 c4 10             	add    $0x10,%esp
}
  800255:	90                   	nop
  800256:	c9                   	leave  
  800257:	c3                   	ret    

00800258 <exit>:

void
exit(void)
{
  800258:	55                   	push   %ebp
  800259:	89 e5                	mov    %esp,%ebp
  80025b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80025e:	e8 02 11 00 00       	call   801365 <sys_env_exit>
}
  800263:	90                   	nop
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80026c:	8d 45 10             	lea    0x10(%ebp),%eax
  80026f:	83 c0 04             	add    $0x4,%eax
  800272:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800275:	a1 18 31 80 00       	mov    0x803118,%eax
  80027a:	85 c0                	test   %eax,%eax
  80027c:	74 16                	je     800294 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80027e:	a1 18 31 80 00       	mov    0x803118,%eax
  800283:	83 ec 08             	sub    $0x8,%esp
  800286:	50                   	push   %eax
  800287:	68 64 1c 80 00       	push   $0x801c64
  80028c:	e8 77 02 00 00       	call   800508 <cprintf>
  800291:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800294:	a1 00 30 80 00       	mov    0x803000,%eax
  800299:	ff 75 0c             	pushl  0xc(%ebp)
  80029c:	ff 75 08             	pushl  0x8(%ebp)
  80029f:	50                   	push   %eax
  8002a0:	68 69 1c 80 00       	push   $0x801c69
  8002a5:	e8 5e 02 00 00       	call   800508 <cprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b0:	83 ec 08             	sub    $0x8,%esp
  8002b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b6:	50                   	push   %eax
  8002b7:	e8 e1 01 00 00       	call   80049d <vcprintf>
  8002bc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002bf:	83 ec 08             	sub    $0x8,%esp
  8002c2:	6a 00                	push   $0x0
  8002c4:	68 85 1c 80 00       	push   $0x801c85
  8002c9:	e8 cf 01 00 00       	call   80049d <vcprintf>
  8002ce:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002d1:	e8 82 ff ff ff       	call   800258 <exit>

	// should not return here
	while (1) ;
  8002d6:	eb fe                	jmp    8002d6 <_panic+0x70>

008002d8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002d8:	55                   	push   %ebp
  8002d9:	89 e5                	mov    %esp,%ebp
  8002db:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002de:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e3:	8b 50 74             	mov    0x74(%eax),%edx
  8002e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002e9:	39 c2                	cmp    %eax,%edx
  8002eb:	74 14                	je     800301 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002ed:	83 ec 04             	sub    $0x4,%esp
  8002f0:	68 88 1c 80 00       	push   $0x801c88
  8002f5:	6a 26                	push   $0x26
  8002f7:	68 d4 1c 80 00       	push   $0x801cd4
  8002fc:	e8 65 ff ff ff       	call   800266 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800301:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800308:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80030f:	e9 b6 00 00 00       	jmp    8003ca <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800314:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800317:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80031e:	8b 45 08             	mov    0x8(%ebp),%eax
  800321:	01 d0                	add    %edx,%eax
  800323:	8b 00                	mov    (%eax),%eax
  800325:	85 c0                	test   %eax,%eax
  800327:	75 08                	jne    800331 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800329:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80032c:	e9 96 00 00 00       	jmp    8003c7 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800331:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800338:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80033f:	eb 5d                	jmp    80039e <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800341:	a1 20 30 80 00       	mov    0x803020,%eax
  800346:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80034c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80034f:	c1 e2 04             	shl    $0x4,%edx
  800352:	01 d0                	add    %edx,%eax
  800354:	8a 40 04             	mov    0x4(%eax),%al
  800357:	84 c0                	test   %al,%al
  800359:	75 40                	jne    80039b <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80035b:	a1 20 30 80 00       	mov    0x803020,%eax
  800360:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800366:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800369:	c1 e2 04             	shl    $0x4,%edx
  80036c:	01 d0                	add    %edx,%eax
  80036e:	8b 00                	mov    (%eax),%eax
  800370:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800373:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800376:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80037b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80037d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800380:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c8                	add    %ecx,%eax
  80038c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80038e:	39 c2                	cmp    %eax,%edx
  800390:	75 09                	jne    80039b <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800392:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800399:	eb 12                	jmp    8003ad <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80039b:	ff 45 e8             	incl   -0x18(%ebp)
  80039e:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a3:	8b 50 74             	mov    0x74(%eax),%edx
  8003a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a9:	39 c2                	cmp    %eax,%edx
  8003ab:	77 94                	ja     800341 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003b1:	75 14                	jne    8003c7 <CheckWSWithoutLastIndex+0xef>
			panic(
  8003b3:	83 ec 04             	sub    $0x4,%esp
  8003b6:	68 e0 1c 80 00       	push   $0x801ce0
  8003bb:	6a 3a                	push   $0x3a
  8003bd:	68 d4 1c 80 00       	push   $0x801cd4
  8003c2:	e8 9f fe ff ff       	call   800266 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003c7:	ff 45 f0             	incl   -0x10(%ebp)
  8003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003d0:	0f 8c 3e ff ff ff    	jl     800314 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003dd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003e4:	eb 20                	jmp    800406 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003eb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003f4:	c1 e2 04             	shl    $0x4,%edx
  8003f7:	01 d0                	add    %edx,%eax
  8003f9:	8a 40 04             	mov    0x4(%eax),%al
  8003fc:	3c 01                	cmp    $0x1,%al
  8003fe:	75 03                	jne    800403 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800400:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800403:	ff 45 e0             	incl   -0x20(%ebp)
  800406:	a1 20 30 80 00       	mov    0x803020,%eax
  80040b:	8b 50 74             	mov    0x74(%eax),%edx
  80040e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800411:	39 c2                	cmp    %eax,%edx
  800413:	77 d1                	ja     8003e6 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800415:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800418:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80041b:	74 14                	je     800431 <CheckWSWithoutLastIndex+0x159>
		panic(
  80041d:	83 ec 04             	sub    $0x4,%esp
  800420:	68 34 1d 80 00       	push   $0x801d34
  800425:	6a 44                	push   $0x44
  800427:	68 d4 1c 80 00       	push   $0x801cd4
  80042c:	e8 35 fe ff ff       	call   800266 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800431:	90                   	nop
  800432:	c9                   	leave  
  800433:	c3                   	ret    

00800434 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800434:	55                   	push   %ebp
  800435:	89 e5                	mov    %esp,%ebp
  800437:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80043a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	8d 48 01             	lea    0x1(%eax),%ecx
  800442:	8b 55 0c             	mov    0xc(%ebp),%edx
  800445:	89 0a                	mov    %ecx,(%edx)
  800447:	8b 55 08             	mov    0x8(%ebp),%edx
  80044a:	88 d1                	mov    %dl,%cl
  80044c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80044f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800453:	8b 45 0c             	mov    0xc(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	3d ff 00 00 00       	cmp    $0xff,%eax
  80045d:	75 2c                	jne    80048b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80045f:	a0 24 30 80 00       	mov    0x803024,%al
  800464:	0f b6 c0             	movzbl %al,%eax
  800467:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046a:	8b 12                	mov    (%edx),%edx
  80046c:	89 d1                	mov    %edx,%ecx
  80046e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800471:	83 c2 08             	add    $0x8,%edx
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	50                   	push   %eax
  800478:	51                   	push   %ecx
  800479:	52                   	push   %edx
  80047a:	e8 3e 0e 00 00       	call   8012bd <sys_cputs>
  80047f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800482:	8b 45 0c             	mov    0xc(%ebp),%eax
  800485:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048e:	8b 40 04             	mov    0x4(%eax),%eax
  800491:	8d 50 01             	lea    0x1(%eax),%edx
  800494:	8b 45 0c             	mov    0xc(%ebp),%eax
  800497:	89 50 04             	mov    %edx,0x4(%eax)
}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004a6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004ad:	00 00 00 
	b.cnt = 0;
  8004b0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004b7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004ba:	ff 75 0c             	pushl  0xc(%ebp)
  8004bd:	ff 75 08             	pushl  0x8(%ebp)
  8004c0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004c6:	50                   	push   %eax
  8004c7:	68 34 04 80 00       	push   $0x800434
  8004cc:	e8 11 02 00 00       	call   8006e2 <vprintfmt>
  8004d1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004d4:	a0 24 30 80 00       	mov    0x803024,%al
  8004d9:	0f b6 c0             	movzbl %al,%eax
  8004dc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	50                   	push   %eax
  8004e6:	52                   	push   %edx
  8004e7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004ed:	83 c0 08             	add    $0x8,%eax
  8004f0:	50                   	push   %eax
  8004f1:	e8 c7 0d 00 00       	call   8012bd <sys_cputs>
  8004f6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004f9:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800500:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800506:	c9                   	leave  
  800507:	c3                   	ret    

00800508 <cprintf>:

int cprintf(const char *fmt, ...) {
  800508:	55                   	push   %ebp
  800509:	89 e5                	mov    %esp,%ebp
  80050b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80050e:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800515:	8d 45 0c             	lea    0xc(%ebp),%eax
  800518:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	83 ec 08             	sub    $0x8,%esp
  800521:	ff 75 f4             	pushl  -0xc(%ebp)
  800524:	50                   	push   %eax
  800525:	e8 73 ff ff ff       	call   80049d <vcprintf>
  80052a:	83 c4 10             	add    $0x10,%esp
  80052d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800530:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800533:	c9                   	leave  
  800534:	c3                   	ret    

00800535 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800535:	55                   	push   %ebp
  800536:	89 e5                	mov    %esp,%ebp
  800538:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80053b:	e8 8e 0f 00 00       	call   8014ce <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800540:	8d 45 0c             	lea    0xc(%ebp),%eax
  800543:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800546:	8b 45 08             	mov    0x8(%ebp),%eax
  800549:	83 ec 08             	sub    $0x8,%esp
  80054c:	ff 75 f4             	pushl  -0xc(%ebp)
  80054f:	50                   	push   %eax
  800550:	e8 48 ff ff ff       	call   80049d <vcprintf>
  800555:	83 c4 10             	add    $0x10,%esp
  800558:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80055b:	e8 88 0f 00 00       	call   8014e8 <sys_enable_interrupt>
	return cnt;
  800560:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800563:	c9                   	leave  
  800564:	c3                   	ret    

00800565 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800565:	55                   	push   %ebp
  800566:	89 e5                	mov    %esp,%ebp
  800568:	53                   	push   %ebx
  800569:	83 ec 14             	sub    $0x14,%esp
  80056c:	8b 45 10             	mov    0x10(%ebp),%eax
  80056f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800572:	8b 45 14             	mov    0x14(%ebp),%eax
  800575:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800578:	8b 45 18             	mov    0x18(%ebp),%eax
  80057b:	ba 00 00 00 00       	mov    $0x0,%edx
  800580:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800583:	77 55                	ja     8005da <printnum+0x75>
  800585:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800588:	72 05                	jb     80058f <printnum+0x2a>
  80058a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80058d:	77 4b                	ja     8005da <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80058f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800592:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800595:	8b 45 18             	mov    0x18(%ebp),%eax
  800598:	ba 00 00 00 00       	mov    $0x0,%edx
  80059d:	52                   	push   %edx
  80059e:	50                   	push   %eax
  80059f:	ff 75 f4             	pushl  -0xc(%ebp)
  8005a2:	ff 75 f0             	pushl  -0x10(%ebp)
  8005a5:	e8 46 13 00 00       	call   8018f0 <__udivdi3>
  8005aa:	83 c4 10             	add    $0x10,%esp
  8005ad:	83 ec 04             	sub    $0x4,%esp
  8005b0:	ff 75 20             	pushl  0x20(%ebp)
  8005b3:	53                   	push   %ebx
  8005b4:	ff 75 18             	pushl  0x18(%ebp)
  8005b7:	52                   	push   %edx
  8005b8:	50                   	push   %eax
  8005b9:	ff 75 0c             	pushl  0xc(%ebp)
  8005bc:	ff 75 08             	pushl  0x8(%ebp)
  8005bf:	e8 a1 ff ff ff       	call   800565 <printnum>
  8005c4:	83 c4 20             	add    $0x20,%esp
  8005c7:	eb 1a                	jmp    8005e3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005c9:	83 ec 08             	sub    $0x8,%esp
  8005cc:	ff 75 0c             	pushl  0xc(%ebp)
  8005cf:	ff 75 20             	pushl  0x20(%ebp)
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	ff d0                	call   *%eax
  8005d7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005da:	ff 4d 1c             	decl   0x1c(%ebp)
  8005dd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005e1:	7f e6                	jg     8005c9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005e3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005e6:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005f1:	53                   	push   %ebx
  8005f2:	51                   	push   %ecx
  8005f3:	52                   	push   %edx
  8005f4:	50                   	push   %eax
  8005f5:	e8 06 14 00 00       	call   801a00 <__umoddi3>
  8005fa:	83 c4 10             	add    $0x10,%esp
  8005fd:	05 94 1f 80 00       	add    $0x801f94,%eax
  800602:	8a 00                	mov    (%eax),%al
  800604:	0f be c0             	movsbl %al,%eax
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	50                   	push   %eax
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	ff d0                	call   *%eax
  800613:	83 c4 10             	add    $0x10,%esp
}
  800616:	90                   	nop
  800617:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80061a:	c9                   	leave  
  80061b:	c3                   	ret    

0080061c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80061c:	55                   	push   %ebp
  80061d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80061f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800623:	7e 1c                	jle    800641 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	8d 50 08             	lea    0x8(%eax),%edx
  80062d:	8b 45 08             	mov    0x8(%ebp),%eax
  800630:	89 10                	mov    %edx,(%eax)
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	8b 00                	mov    (%eax),%eax
  800637:	83 e8 08             	sub    $0x8,%eax
  80063a:	8b 50 04             	mov    0x4(%eax),%edx
  80063d:	8b 00                	mov    (%eax),%eax
  80063f:	eb 40                	jmp    800681 <getuint+0x65>
	else if (lflag)
  800641:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800645:	74 1e                	je     800665 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	8d 50 04             	lea    0x4(%eax),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	89 10                	mov    %edx,(%eax)
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	83 e8 04             	sub    $0x4,%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	ba 00 00 00 00       	mov    $0x0,%edx
  800663:	eb 1c                	jmp    800681 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	8b 00                	mov    (%eax),%eax
  80066a:	8d 50 04             	lea    0x4(%eax),%edx
  80066d:	8b 45 08             	mov    0x8(%ebp),%eax
  800670:	89 10                	mov    %edx,(%eax)
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8b 00                	mov    (%eax),%eax
  800677:	83 e8 04             	sub    $0x4,%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800681:	5d                   	pop    %ebp
  800682:	c3                   	ret    

00800683 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800686:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80068a:	7e 1c                	jle    8006a8 <getint+0x25>
		return va_arg(*ap, long long);
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	8d 50 08             	lea    0x8(%eax),%edx
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	89 10                	mov    %edx,(%eax)
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	83 e8 08             	sub    $0x8,%eax
  8006a1:	8b 50 04             	mov    0x4(%eax),%edx
  8006a4:	8b 00                	mov    (%eax),%eax
  8006a6:	eb 38                	jmp    8006e0 <getint+0x5d>
	else if (lflag)
  8006a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ac:	74 1a                	je     8006c8 <getint+0x45>
		return va_arg(*ap, long);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	8d 50 04             	lea    0x4(%eax),%edx
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	89 10                	mov    %edx,(%eax)
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	83 e8 04             	sub    $0x4,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	99                   	cltd   
  8006c6:	eb 18                	jmp    8006e0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	8b 00                	mov    (%eax),%eax
  8006cd:	8d 50 04             	lea    0x4(%eax),%edx
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	89 10                	mov    %edx,(%eax)
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	8b 00                	mov    (%eax),%eax
  8006da:	83 e8 04             	sub    $0x4,%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	99                   	cltd   
}
  8006e0:	5d                   	pop    %ebp
  8006e1:	c3                   	ret    

008006e2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006e2:	55                   	push   %ebp
  8006e3:	89 e5                	mov    %esp,%ebp
  8006e5:	56                   	push   %esi
  8006e6:	53                   	push   %ebx
  8006e7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ea:	eb 17                	jmp    800703 <vprintfmt+0x21>
			if (ch == '\0')
  8006ec:	85 db                	test   %ebx,%ebx
  8006ee:	0f 84 af 03 00 00    	je     800aa3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	ff 75 0c             	pushl  0xc(%ebp)
  8006fa:	53                   	push   %ebx
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	ff d0                	call   *%eax
  800700:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800703:	8b 45 10             	mov    0x10(%ebp),%eax
  800706:	8d 50 01             	lea    0x1(%eax),%edx
  800709:	89 55 10             	mov    %edx,0x10(%ebp)
  80070c:	8a 00                	mov    (%eax),%al
  80070e:	0f b6 d8             	movzbl %al,%ebx
  800711:	83 fb 25             	cmp    $0x25,%ebx
  800714:	75 d6                	jne    8006ec <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800716:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80071a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800721:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800728:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80072f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800736:	8b 45 10             	mov    0x10(%ebp),%eax
  800739:	8d 50 01             	lea    0x1(%eax),%edx
  80073c:	89 55 10             	mov    %edx,0x10(%ebp)
  80073f:	8a 00                	mov    (%eax),%al
  800741:	0f b6 d8             	movzbl %al,%ebx
  800744:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800747:	83 f8 55             	cmp    $0x55,%eax
  80074a:	0f 87 2b 03 00 00    	ja     800a7b <vprintfmt+0x399>
  800750:	8b 04 85 b8 1f 80 00 	mov    0x801fb8(,%eax,4),%eax
  800757:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800759:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80075d:	eb d7                	jmp    800736 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80075f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800763:	eb d1                	jmp    800736 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800765:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80076c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80076f:	89 d0                	mov    %edx,%eax
  800771:	c1 e0 02             	shl    $0x2,%eax
  800774:	01 d0                	add    %edx,%eax
  800776:	01 c0                	add    %eax,%eax
  800778:	01 d8                	add    %ebx,%eax
  80077a:	83 e8 30             	sub    $0x30,%eax
  80077d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800780:	8b 45 10             	mov    0x10(%ebp),%eax
  800783:	8a 00                	mov    (%eax),%al
  800785:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800788:	83 fb 2f             	cmp    $0x2f,%ebx
  80078b:	7e 3e                	jle    8007cb <vprintfmt+0xe9>
  80078d:	83 fb 39             	cmp    $0x39,%ebx
  800790:	7f 39                	jg     8007cb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800792:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800795:	eb d5                	jmp    80076c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800797:	8b 45 14             	mov    0x14(%ebp),%eax
  80079a:	83 c0 04             	add    $0x4,%eax
  80079d:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a3:	83 e8 04             	sub    $0x4,%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007ab:	eb 1f                	jmp    8007cc <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b1:	79 83                	jns    800736 <vprintfmt+0x54>
				width = 0;
  8007b3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007ba:	e9 77 ff ff ff       	jmp    800736 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007bf:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007c6:	e9 6b ff ff ff       	jmp    800736 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007cb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d0:	0f 89 60 ff ff ff    	jns    800736 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007dc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007e3:	e9 4e ff ff ff       	jmp    800736 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007e8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007eb:	e9 46 ff ff ff       	jmp    800736 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f3:	83 c0 04             	add    $0x4,%eax
  8007f6:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007fc:	83 e8 04             	sub    $0x4,%eax
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 0c             	pushl  0xc(%ebp)
  800807:	50                   	push   %eax
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	ff d0                	call   *%eax
  80080d:	83 c4 10             	add    $0x10,%esp
			break;
  800810:	e9 89 02 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800815:	8b 45 14             	mov    0x14(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 14             	mov    %eax,0x14(%ebp)
  80081e:	8b 45 14             	mov    0x14(%ebp),%eax
  800821:	83 e8 04             	sub    $0x4,%eax
  800824:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800826:	85 db                	test   %ebx,%ebx
  800828:	79 02                	jns    80082c <vprintfmt+0x14a>
				err = -err;
  80082a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80082c:	83 fb 64             	cmp    $0x64,%ebx
  80082f:	7f 0b                	jg     80083c <vprintfmt+0x15a>
  800831:	8b 34 9d 00 1e 80 00 	mov    0x801e00(,%ebx,4),%esi
  800838:	85 f6                	test   %esi,%esi
  80083a:	75 19                	jne    800855 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80083c:	53                   	push   %ebx
  80083d:	68 a5 1f 80 00       	push   $0x801fa5
  800842:	ff 75 0c             	pushl  0xc(%ebp)
  800845:	ff 75 08             	pushl  0x8(%ebp)
  800848:	e8 5e 02 00 00       	call   800aab <printfmt>
  80084d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800850:	e9 49 02 00 00       	jmp    800a9e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800855:	56                   	push   %esi
  800856:	68 ae 1f 80 00       	push   $0x801fae
  80085b:	ff 75 0c             	pushl  0xc(%ebp)
  80085e:	ff 75 08             	pushl  0x8(%ebp)
  800861:	e8 45 02 00 00       	call   800aab <printfmt>
  800866:	83 c4 10             	add    $0x10,%esp
			break;
  800869:	e9 30 02 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80086e:	8b 45 14             	mov    0x14(%ebp),%eax
  800871:	83 c0 04             	add    $0x4,%eax
  800874:	89 45 14             	mov    %eax,0x14(%ebp)
  800877:	8b 45 14             	mov    0x14(%ebp),%eax
  80087a:	83 e8 04             	sub    $0x4,%eax
  80087d:	8b 30                	mov    (%eax),%esi
  80087f:	85 f6                	test   %esi,%esi
  800881:	75 05                	jne    800888 <vprintfmt+0x1a6>
				p = "(null)";
  800883:	be b1 1f 80 00       	mov    $0x801fb1,%esi
			if (width > 0 && padc != '-')
  800888:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088c:	7e 6d                	jle    8008fb <vprintfmt+0x219>
  80088e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800892:	74 67                	je     8008fb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800894:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800897:	83 ec 08             	sub    $0x8,%esp
  80089a:	50                   	push   %eax
  80089b:	56                   	push   %esi
  80089c:	e8 0c 03 00 00       	call   800bad <strnlen>
  8008a1:	83 c4 10             	add    $0x10,%esp
  8008a4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008a7:	eb 16                	jmp    8008bf <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008a9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008ad:	83 ec 08             	sub    $0x8,%esp
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	50                   	push   %eax
  8008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b7:	ff d0                	call   *%eax
  8008b9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008bc:	ff 4d e4             	decl   -0x1c(%ebp)
  8008bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c3:	7f e4                	jg     8008a9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008c5:	eb 34                	jmp    8008fb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008c7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008cb:	74 1c                	je     8008e9 <vprintfmt+0x207>
  8008cd:	83 fb 1f             	cmp    $0x1f,%ebx
  8008d0:	7e 05                	jle    8008d7 <vprintfmt+0x1f5>
  8008d2:	83 fb 7e             	cmp    $0x7e,%ebx
  8008d5:	7e 12                	jle    8008e9 <vprintfmt+0x207>
					putch('?', putdat);
  8008d7:	83 ec 08             	sub    $0x8,%esp
  8008da:	ff 75 0c             	pushl  0xc(%ebp)
  8008dd:	6a 3f                	push   $0x3f
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	ff d0                	call   *%eax
  8008e4:	83 c4 10             	add    $0x10,%esp
  8008e7:	eb 0f                	jmp    8008f8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008e9:	83 ec 08             	sub    $0x8,%esp
  8008ec:	ff 75 0c             	pushl  0xc(%ebp)
  8008ef:	53                   	push   %ebx
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	ff d0                	call   *%eax
  8008f5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f8:	ff 4d e4             	decl   -0x1c(%ebp)
  8008fb:	89 f0                	mov    %esi,%eax
  8008fd:	8d 70 01             	lea    0x1(%eax),%esi
  800900:	8a 00                	mov    (%eax),%al
  800902:	0f be d8             	movsbl %al,%ebx
  800905:	85 db                	test   %ebx,%ebx
  800907:	74 24                	je     80092d <vprintfmt+0x24b>
  800909:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80090d:	78 b8                	js     8008c7 <vprintfmt+0x1e5>
  80090f:	ff 4d e0             	decl   -0x20(%ebp)
  800912:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800916:	79 af                	jns    8008c7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800918:	eb 13                	jmp    80092d <vprintfmt+0x24b>
				putch(' ', putdat);
  80091a:	83 ec 08             	sub    $0x8,%esp
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	6a 20                	push   $0x20
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	ff d0                	call   *%eax
  800927:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80092a:	ff 4d e4             	decl   -0x1c(%ebp)
  80092d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800931:	7f e7                	jg     80091a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800933:	e9 66 01 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 e8             	pushl  -0x18(%ebp)
  80093e:	8d 45 14             	lea    0x14(%ebp),%eax
  800941:	50                   	push   %eax
  800942:	e8 3c fd ff ff       	call   800683 <getint>
  800947:	83 c4 10             	add    $0x10,%esp
  80094a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800950:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800953:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800956:	85 d2                	test   %edx,%edx
  800958:	79 23                	jns    80097d <vprintfmt+0x29b>
				putch('-', putdat);
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 0c             	pushl  0xc(%ebp)
  800960:	6a 2d                	push   $0x2d
  800962:	8b 45 08             	mov    0x8(%ebp),%eax
  800965:	ff d0                	call   *%eax
  800967:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80096a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80096d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800970:	f7 d8                	neg    %eax
  800972:	83 d2 00             	adc    $0x0,%edx
  800975:	f7 da                	neg    %edx
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80097d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800984:	e9 bc 00 00 00       	jmp    800a45 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800989:	83 ec 08             	sub    $0x8,%esp
  80098c:	ff 75 e8             	pushl  -0x18(%ebp)
  80098f:	8d 45 14             	lea    0x14(%ebp),%eax
  800992:	50                   	push   %eax
  800993:	e8 84 fc ff ff       	call   80061c <getuint>
  800998:	83 c4 10             	add    $0x10,%esp
  80099b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009a1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a8:	e9 98 00 00 00       	jmp    800a45 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009ad:	83 ec 08             	sub    $0x8,%esp
  8009b0:	ff 75 0c             	pushl  0xc(%ebp)
  8009b3:	6a 58                	push   $0x58
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	ff d0                	call   *%eax
  8009ba:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009bd:	83 ec 08             	sub    $0x8,%esp
  8009c0:	ff 75 0c             	pushl  0xc(%ebp)
  8009c3:	6a 58                	push   $0x58
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	ff d0                	call   *%eax
  8009ca:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 0c             	pushl  0xc(%ebp)
  8009d3:	6a 58                	push   $0x58
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	ff d0                	call   *%eax
  8009da:	83 c4 10             	add    $0x10,%esp
			break;
  8009dd:	e9 bc 00 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009e2:	83 ec 08             	sub    $0x8,%esp
  8009e5:	ff 75 0c             	pushl  0xc(%ebp)
  8009e8:	6a 30                	push   $0x30
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	ff d0                	call   *%eax
  8009ef:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009f2:	83 ec 08             	sub    $0x8,%esp
  8009f5:	ff 75 0c             	pushl  0xc(%ebp)
  8009f8:	6a 78                	push   $0x78
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	ff d0                	call   *%eax
  8009ff:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a02:	8b 45 14             	mov    0x14(%ebp),%eax
  800a05:	83 c0 04             	add    $0x4,%eax
  800a08:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0e:	83 e8 04             	sub    $0x4,%eax
  800a11:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a1d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a24:	eb 1f                	jmp    800a45 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a26:	83 ec 08             	sub    $0x8,%esp
  800a29:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a2f:	50                   	push   %eax
  800a30:	e8 e7 fb ff ff       	call   80061c <getuint>
  800a35:	83 c4 10             	add    $0x10,%esp
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a3e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a45:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a49:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a4c:	83 ec 04             	sub    $0x4,%esp
  800a4f:	52                   	push   %edx
  800a50:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a53:	50                   	push   %eax
  800a54:	ff 75 f4             	pushl  -0xc(%ebp)
  800a57:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	ff 75 08             	pushl  0x8(%ebp)
  800a60:	e8 00 fb ff ff       	call   800565 <printnum>
  800a65:	83 c4 20             	add    $0x20,%esp
			break;
  800a68:	eb 34                	jmp    800a9e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a6a:	83 ec 08             	sub    $0x8,%esp
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	53                   	push   %ebx
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	ff d0                	call   *%eax
  800a76:	83 c4 10             	add    $0x10,%esp
			break;
  800a79:	eb 23                	jmp    800a9e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a7b:	83 ec 08             	sub    $0x8,%esp
  800a7e:	ff 75 0c             	pushl  0xc(%ebp)
  800a81:	6a 25                	push   $0x25
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	ff d0                	call   *%eax
  800a88:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a8b:	ff 4d 10             	decl   0x10(%ebp)
  800a8e:	eb 03                	jmp    800a93 <vprintfmt+0x3b1>
  800a90:	ff 4d 10             	decl   0x10(%ebp)
  800a93:	8b 45 10             	mov    0x10(%ebp),%eax
  800a96:	48                   	dec    %eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	3c 25                	cmp    $0x25,%al
  800a9b:	75 f3                	jne    800a90 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a9d:	90                   	nop
		}
	}
  800a9e:	e9 47 fc ff ff       	jmp    8006ea <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800aa3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800aa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aa7:	5b                   	pop    %ebx
  800aa8:	5e                   	pop    %esi
  800aa9:	5d                   	pop    %ebp
  800aaa:	c3                   	ret    

00800aab <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aab:	55                   	push   %ebp
  800aac:	89 e5                	mov    %esp,%ebp
  800aae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ab1:	8d 45 10             	lea    0x10(%ebp),%eax
  800ab4:	83 c0 04             	add    $0x4,%eax
  800ab7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aba:	8b 45 10             	mov    0x10(%ebp),%eax
  800abd:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac0:	50                   	push   %eax
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	ff 75 08             	pushl  0x8(%ebp)
  800ac7:	e8 16 fc ff ff       	call   8006e2 <vprintfmt>
  800acc:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800acf:	90                   	nop
  800ad0:	c9                   	leave  
  800ad1:	c3                   	ret    

00800ad2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ad2:	55                   	push   %ebp
  800ad3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad8:	8b 40 08             	mov    0x8(%eax),%eax
  800adb:	8d 50 01             	lea    0x1(%eax),%edx
  800ade:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ae4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae7:	8b 10                	mov    (%eax),%edx
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8b 40 04             	mov    0x4(%eax),%eax
  800aef:	39 c2                	cmp    %eax,%edx
  800af1:	73 12                	jae    800b05 <sprintputch+0x33>
		*b->buf++ = ch;
  800af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	8d 48 01             	lea    0x1(%eax),%ecx
  800afb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afe:	89 0a                	mov    %ecx,(%edx)
  800b00:	8b 55 08             	mov    0x8(%ebp),%edx
  800b03:	88 10                	mov    %dl,(%eax)
}
  800b05:	90                   	nop
  800b06:	5d                   	pop    %ebp
  800b07:	c3                   	ret    

00800b08 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b08:	55                   	push   %ebp
  800b09:	89 e5                	mov    %esp,%ebp
  800b0b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b17:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	01 d0                	add    %edx,%eax
  800b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b29:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b2d:	74 06                	je     800b35 <vsnprintf+0x2d>
  800b2f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b33:	7f 07                	jg     800b3c <vsnprintf+0x34>
		return -E_INVAL;
  800b35:	b8 03 00 00 00       	mov    $0x3,%eax
  800b3a:	eb 20                	jmp    800b5c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b3c:	ff 75 14             	pushl  0x14(%ebp)
  800b3f:	ff 75 10             	pushl  0x10(%ebp)
  800b42:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b45:	50                   	push   %eax
  800b46:	68 d2 0a 80 00       	push   $0x800ad2
  800b4b:	e8 92 fb ff ff       	call   8006e2 <vprintfmt>
  800b50:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b56:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b5c:	c9                   	leave  
  800b5d:	c3                   	ret    

00800b5e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b64:	8d 45 10             	lea    0x10(%ebp),%eax
  800b67:	83 c0 04             	add    $0x4,%eax
  800b6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b70:	ff 75 f4             	pushl  -0xc(%ebp)
  800b73:	50                   	push   %eax
  800b74:	ff 75 0c             	pushl  0xc(%ebp)
  800b77:	ff 75 08             	pushl  0x8(%ebp)
  800b7a:	e8 89 ff ff ff       	call   800b08 <vsnprintf>
  800b7f:	83 c4 10             	add    $0x10,%esp
  800b82:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b88:	c9                   	leave  
  800b89:	c3                   	ret    

00800b8a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b8a:	55                   	push   %ebp
  800b8b:	89 e5                	mov    %esp,%ebp
  800b8d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b97:	eb 06                	jmp    800b9f <strlen+0x15>
		n++;
  800b99:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b9c:	ff 45 08             	incl   0x8(%ebp)
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	8a 00                	mov    (%eax),%al
  800ba4:	84 c0                	test   %al,%al
  800ba6:	75 f1                	jne    800b99 <strlen+0xf>
		n++;
	return n;
  800ba8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bab:	c9                   	leave  
  800bac:	c3                   	ret    

00800bad <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bba:	eb 09                	jmp    800bc5 <strnlen+0x18>
		n++;
  800bbc:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bbf:	ff 45 08             	incl   0x8(%ebp)
  800bc2:	ff 4d 0c             	decl   0xc(%ebp)
  800bc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc9:	74 09                	je     800bd4 <strnlen+0x27>
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	84 c0                	test   %al,%al
  800bd2:	75 e8                	jne    800bbc <strnlen+0xf>
		n++;
	return n;
  800bd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd7:	c9                   	leave  
  800bd8:	c3                   	ret    

00800bd9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bd9:	55                   	push   %ebp
  800bda:	89 e5                	mov    %esp,%ebp
  800bdc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800be5:	90                   	nop
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	8d 50 01             	lea    0x1(%eax),%edx
  800bec:	89 55 08             	mov    %edx,0x8(%ebp)
  800bef:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bf8:	8a 12                	mov    (%edx),%dl
  800bfa:	88 10                	mov    %dl,(%eax)
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	84 c0                	test   %al,%al
  800c00:	75 e4                	jne    800be6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c02:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c05:	c9                   	leave  
  800c06:	c3                   	ret    

00800c07 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c07:	55                   	push   %ebp
  800c08:	89 e5                	mov    %esp,%ebp
  800c0a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c1a:	eb 1f                	jmp    800c3b <strncpy+0x34>
		*dst++ = *src;
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	8d 50 01             	lea    0x1(%eax),%edx
  800c22:	89 55 08             	mov    %edx,0x8(%ebp)
  800c25:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c28:	8a 12                	mov    (%edx),%dl
  800c2a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	84 c0                	test   %al,%al
  800c33:	74 03                	je     800c38 <strncpy+0x31>
			src++;
  800c35:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c38:	ff 45 fc             	incl   -0x4(%ebp)
  800c3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c41:	72 d9                	jb     800c1c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c43:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c46:	c9                   	leave  
  800c47:	c3                   	ret    

00800c48 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c48:	55                   	push   %ebp
  800c49:	89 e5                	mov    %esp,%ebp
  800c4b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c58:	74 30                	je     800c8a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c5a:	eb 16                	jmp    800c72 <strlcpy+0x2a>
			*dst++ = *src++;
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	8d 50 01             	lea    0x1(%eax),%edx
  800c62:	89 55 08             	mov    %edx,0x8(%ebp)
  800c65:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c68:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c6b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c6e:	8a 12                	mov    (%edx),%dl
  800c70:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c72:	ff 4d 10             	decl   0x10(%ebp)
  800c75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c79:	74 09                	je     800c84 <strlcpy+0x3c>
  800c7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	84 c0                	test   %al,%al
  800c82:	75 d8                	jne    800c5c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c8a:	8b 55 08             	mov    0x8(%ebp),%edx
  800c8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c90:	29 c2                	sub    %eax,%edx
  800c92:	89 d0                	mov    %edx,%eax
}
  800c94:	c9                   	leave  
  800c95:	c3                   	ret    

00800c96 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c99:	eb 06                	jmp    800ca1 <strcmp+0xb>
		p++, q++;
  800c9b:	ff 45 08             	incl   0x8(%ebp)
  800c9e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	84 c0                	test   %al,%al
  800ca8:	74 0e                	je     800cb8 <strcmp+0x22>
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 10                	mov    (%eax),%dl
  800caf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	38 c2                	cmp    %al,%dl
  800cb6:	74 e3                	je     800c9b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	0f b6 d0             	movzbl %al,%edx
  800cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	0f b6 c0             	movzbl %al,%eax
  800cc8:	29 c2                	sub    %eax,%edx
  800cca:	89 d0                	mov    %edx,%eax
}
  800ccc:	5d                   	pop    %ebp
  800ccd:	c3                   	ret    

00800cce <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cce:	55                   	push   %ebp
  800ccf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cd1:	eb 09                	jmp    800cdc <strncmp+0xe>
		n--, p++, q++;
  800cd3:	ff 4d 10             	decl   0x10(%ebp)
  800cd6:	ff 45 08             	incl   0x8(%ebp)
  800cd9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cdc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce0:	74 17                	je     800cf9 <strncmp+0x2b>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	84 c0                	test   %al,%al
  800ce9:	74 0e                	je     800cf9 <strncmp+0x2b>
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8a 10                	mov    (%eax),%dl
  800cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf3:	8a 00                	mov    (%eax),%al
  800cf5:	38 c2                	cmp    %al,%dl
  800cf7:	74 da                	je     800cd3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cf9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cfd:	75 07                	jne    800d06 <strncmp+0x38>
		return 0;
  800cff:	b8 00 00 00 00       	mov    $0x0,%eax
  800d04:	eb 14                	jmp    800d1a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f b6 d0             	movzbl %al,%edx
  800d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	0f b6 c0             	movzbl %al,%eax
  800d16:	29 c2                	sub    %eax,%edx
  800d18:	89 d0                	mov    %edx,%eax
}
  800d1a:	5d                   	pop    %ebp
  800d1b:	c3                   	ret    

00800d1c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d1c:	55                   	push   %ebp
  800d1d:	89 e5                	mov    %esp,%ebp
  800d1f:	83 ec 04             	sub    $0x4,%esp
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d28:	eb 12                	jmp    800d3c <strchr+0x20>
		if (*s == c)
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d32:	75 05                	jne    800d39 <strchr+0x1d>
			return (char *) s;
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	eb 11                	jmp    800d4a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d39:	ff 45 08             	incl   0x8(%ebp)
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	84 c0                	test   %al,%al
  800d43:	75 e5                	jne    800d2a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d4a:	c9                   	leave  
  800d4b:	c3                   	ret    

00800d4c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d4c:	55                   	push   %ebp
  800d4d:	89 e5                	mov    %esp,%ebp
  800d4f:	83 ec 04             	sub    $0x4,%esp
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d58:	eb 0d                	jmp    800d67 <strfind+0x1b>
		if (*s == c)
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5d:	8a 00                	mov    (%eax),%al
  800d5f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d62:	74 0e                	je     800d72 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d64:	ff 45 08             	incl   0x8(%ebp)
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	84 c0                	test   %al,%al
  800d6e:	75 ea                	jne    800d5a <strfind+0xe>
  800d70:	eb 01                	jmp    800d73 <strfind+0x27>
		if (*s == c)
			break;
  800d72:	90                   	nop
	return (char *) s;
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d76:	c9                   	leave  
  800d77:	c3                   	ret    

00800d78 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d84:	8b 45 10             	mov    0x10(%ebp),%eax
  800d87:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d8a:	eb 0e                	jmp    800d9a <memset+0x22>
		*p++ = c;
  800d8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8f:	8d 50 01             	lea    0x1(%eax),%edx
  800d92:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d95:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d98:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d9a:	ff 4d f8             	decl   -0x8(%ebp)
  800d9d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800da1:	79 e9                	jns    800d8c <memset+0x14>
		*p++ = c;

	return v;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da6:	c9                   	leave  
  800da7:	c3                   	ret    

00800da8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800da8:	55                   	push   %ebp
  800da9:	89 e5                	mov    %esp,%ebp
  800dab:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dba:	eb 16                	jmp    800dd2 <memcpy+0x2a>
		*d++ = *s++;
  800dbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbf:	8d 50 01             	lea    0x1(%eax),%edx
  800dc2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dcb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dce:	8a 12                	mov    (%edx),%dl
  800dd0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ddb:	85 c0                	test   %eax,%eax
  800ddd:	75 dd                	jne    800dbc <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de2:	c9                   	leave  
  800de3:	c3                   	ret    

00800de4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ded:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800df6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dfc:	73 50                	jae    800e4e <memmove+0x6a>
  800dfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e01:	8b 45 10             	mov    0x10(%ebp),%eax
  800e04:	01 d0                	add    %edx,%eax
  800e06:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e09:	76 43                	jbe    800e4e <memmove+0x6a>
		s += n;
  800e0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e11:	8b 45 10             	mov    0x10(%ebp),%eax
  800e14:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e17:	eb 10                	jmp    800e29 <memmove+0x45>
			*--d = *--s;
  800e19:	ff 4d f8             	decl   -0x8(%ebp)
  800e1c:	ff 4d fc             	decl   -0x4(%ebp)
  800e1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e22:	8a 10                	mov    (%eax),%dl
  800e24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e27:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e29:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e2f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e32:	85 c0                	test   %eax,%eax
  800e34:	75 e3                	jne    800e19 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e36:	eb 23                	jmp    800e5b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3b:	8d 50 01             	lea    0x1(%eax),%edx
  800e3e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e44:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e47:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e4a:	8a 12                	mov    (%edx),%dl
  800e4c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e54:	89 55 10             	mov    %edx,0x10(%ebp)
  800e57:	85 c0                	test   %eax,%eax
  800e59:	75 dd                	jne    800e38 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e5e:	c9                   	leave  
  800e5f:	c3                   	ret    

00800e60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e60:	55                   	push   %ebp
  800e61:	89 e5                	mov    %esp,%ebp
  800e63:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e72:	eb 2a                	jmp    800e9e <memcmp+0x3e>
		if (*s1 != *s2)
  800e74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e77:	8a 10                	mov    (%eax),%dl
  800e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	38 c2                	cmp    %al,%dl
  800e80:	74 16                	je     800e98 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	0f b6 d0             	movzbl %al,%edx
  800e8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f b6 c0             	movzbl %al,%eax
  800e92:	29 c2                	sub    %eax,%edx
  800e94:	89 d0                	mov    %edx,%eax
  800e96:	eb 18                	jmp    800eb0 <memcmp+0x50>
		s1++, s2++;
  800e98:	ff 45 fc             	incl   -0x4(%ebp)
  800e9b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea4:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea7:	85 c0                	test   %eax,%eax
  800ea9:	75 c9                	jne    800e74 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eb8:	8b 55 08             	mov    0x8(%ebp),%edx
  800ebb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebe:	01 d0                	add    %edx,%eax
  800ec0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ec3:	eb 15                	jmp    800eda <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	0f b6 d0             	movzbl %al,%edx
  800ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed0:	0f b6 c0             	movzbl %al,%eax
  800ed3:	39 c2                	cmp    %eax,%edx
  800ed5:	74 0d                	je     800ee4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ed7:	ff 45 08             	incl   0x8(%ebp)
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ee0:	72 e3                	jb     800ec5 <memfind+0x13>
  800ee2:	eb 01                	jmp    800ee5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ee4:	90                   	nop
	return (void *) s;
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee8:	c9                   	leave  
  800ee9:	c3                   	ret    

00800eea <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eea:	55                   	push   %ebp
  800eeb:	89 e5                	mov    %esp,%ebp
  800eed:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ef0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ef7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800efe:	eb 03                	jmp    800f03 <strtol+0x19>
		s++;
  800f00:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f03:	8b 45 08             	mov    0x8(%ebp),%eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	3c 20                	cmp    $0x20,%al
  800f0a:	74 f4                	je     800f00 <strtol+0x16>
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	3c 09                	cmp    $0x9,%al
  800f13:	74 eb                	je     800f00 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	3c 2b                	cmp    $0x2b,%al
  800f1c:	75 05                	jne    800f23 <strtol+0x39>
		s++;
  800f1e:	ff 45 08             	incl   0x8(%ebp)
  800f21:	eb 13                	jmp    800f36 <strtol+0x4c>
	else if (*s == '-')
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	3c 2d                	cmp    $0x2d,%al
  800f2a:	75 0a                	jne    800f36 <strtol+0x4c>
		s++, neg = 1;
  800f2c:	ff 45 08             	incl   0x8(%ebp)
  800f2f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3a:	74 06                	je     800f42 <strtol+0x58>
  800f3c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f40:	75 20                	jne    800f62 <strtol+0x78>
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	3c 30                	cmp    $0x30,%al
  800f49:	75 17                	jne    800f62 <strtol+0x78>
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	40                   	inc    %eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	3c 78                	cmp    $0x78,%al
  800f53:	75 0d                	jne    800f62 <strtol+0x78>
		s += 2, base = 16;
  800f55:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f59:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f60:	eb 28                	jmp    800f8a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f66:	75 15                	jne    800f7d <strtol+0x93>
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	3c 30                	cmp    $0x30,%al
  800f6f:	75 0c                	jne    800f7d <strtol+0x93>
		s++, base = 8;
  800f71:	ff 45 08             	incl   0x8(%ebp)
  800f74:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f7b:	eb 0d                	jmp    800f8a <strtol+0xa0>
	else if (base == 0)
  800f7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f81:	75 07                	jne    800f8a <strtol+0xa0>
		base = 10;
  800f83:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 2f                	cmp    $0x2f,%al
  800f91:	7e 19                	jle    800fac <strtol+0xc2>
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	3c 39                	cmp    $0x39,%al
  800f9a:	7f 10                	jg     800fac <strtol+0xc2>
			dig = *s - '0';
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	0f be c0             	movsbl %al,%eax
  800fa4:	83 e8 30             	sub    $0x30,%eax
  800fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800faa:	eb 42                	jmp    800fee <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 60                	cmp    $0x60,%al
  800fb3:	7e 19                	jle    800fce <strtol+0xe4>
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 7a                	cmp    $0x7a,%al
  800fbc:	7f 10                	jg     800fce <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	0f be c0             	movsbl %al,%eax
  800fc6:	83 e8 57             	sub    $0x57,%eax
  800fc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcc:	eb 20                	jmp    800fee <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	3c 40                	cmp    $0x40,%al
  800fd5:	7e 39                	jle    801010 <strtol+0x126>
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 5a                	cmp    $0x5a,%al
  800fde:	7f 30                	jg     801010 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f be c0             	movsbl %al,%eax
  800fe8:	83 e8 37             	sub    $0x37,%eax
  800feb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ff4:	7d 19                	jge    80100f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ff6:	ff 45 08             	incl   0x8(%ebp)
  800ff9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffc:	0f af 45 10          	imul   0x10(%ebp),%eax
  801000:	89 c2                	mov    %eax,%edx
  801002:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801005:	01 d0                	add    %edx,%eax
  801007:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80100a:	e9 7b ff ff ff       	jmp    800f8a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80100f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801010:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801014:	74 08                	je     80101e <strtol+0x134>
		*endptr = (char *) s;
  801016:	8b 45 0c             	mov    0xc(%ebp),%eax
  801019:	8b 55 08             	mov    0x8(%ebp),%edx
  80101c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80101e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801022:	74 07                	je     80102b <strtol+0x141>
  801024:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801027:	f7 d8                	neg    %eax
  801029:	eb 03                	jmp    80102e <strtol+0x144>
  80102b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80102e:	c9                   	leave  
  80102f:	c3                   	ret    

00801030 <ltostr>:

void
ltostr(long value, char *str)
{
  801030:	55                   	push   %ebp
  801031:	89 e5                	mov    %esp,%ebp
  801033:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801036:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80103d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801044:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801048:	79 13                	jns    80105d <ltostr+0x2d>
	{
		neg = 1;
  80104a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801057:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80105a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801065:	99                   	cltd   
  801066:	f7 f9                	idiv   %ecx
  801068:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80106b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106e:	8d 50 01             	lea    0x1(%eax),%edx
  801071:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801074:	89 c2                	mov    %eax,%edx
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	01 d0                	add    %edx,%eax
  80107b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80107e:	83 c2 30             	add    $0x30,%edx
  801081:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801083:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801086:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80108b:	f7 e9                	imul   %ecx
  80108d:	c1 fa 02             	sar    $0x2,%edx
  801090:	89 c8                	mov    %ecx,%eax
  801092:	c1 f8 1f             	sar    $0x1f,%eax
  801095:	29 c2                	sub    %eax,%edx
  801097:	89 d0                	mov    %edx,%eax
  801099:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80109c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80109f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010a4:	f7 e9                	imul   %ecx
  8010a6:	c1 fa 02             	sar    $0x2,%edx
  8010a9:	89 c8                	mov    %ecx,%eax
  8010ab:	c1 f8 1f             	sar    $0x1f,%eax
  8010ae:	29 c2                	sub    %eax,%edx
  8010b0:	89 d0                	mov    %edx,%eax
  8010b2:	c1 e0 02             	shl    $0x2,%eax
  8010b5:	01 d0                	add    %edx,%eax
  8010b7:	01 c0                	add    %eax,%eax
  8010b9:	29 c1                	sub    %eax,%ecx
  8010bb:	89 ca                	mov    %ecx,%edx
  8010bd:	85 d2                	test   %edx,%edx
  8010bf:	75 9c                	jne    80105d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010cb:	48                   	dec    %eax
  8010cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010d3:	74 3d                	je     801112 <ltostr+0xe2>
		start = 1 ;
  8010d5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010dc:	eb 34                	jmp    801112 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e4:	01 d0                	add    %edx,%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	01 c2                	add    %eax,%edx
  8010f3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f9:	01 c8                	add    %ecx,%eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801102:	8b 45 0c             	mov    0xc(%ebp),%eax
  801105:	01 c2                	add    %eax,%edx
  801107:	8a 45 eb             	mov    -0x15(%ebp),%al
  80110a:	88 02                	mov    %al,(%edx)
		start++ ;
  80110c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80110f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801112:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801115:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801118:	7c c4                	jl     8010de <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80111a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80111d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801120:	01 d0                	add    %edx,%eax
  801122:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801125:	90                   	nop
  801126:	c9                   	leave  
  801127:	c3                   	ret    

00801128 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
  80112b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80112e:	ff 75 08             	pushl  0x8(%ebp)
  801131:	e8 54 fa ff ff       	call   800b8a <strlen>
  801136:	83 c4 04             	add    $0x4,%esp
  801139:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80113c:	ff 75 0c             	pushl  0xc(%ebp)
  80113f:	e8 46 fa ff ff       	call   800b8a <strlen>
  801144:	83 c4 04             	add    $0x4,%esp
  801147:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80114a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801151:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801158:	eb 17                	jmp    801171 <strcconcat+0x49>
		final[s] = str1[s] ;
  80115a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80115d:	8b 45 10             	mov    0x10(%ebp),%eax
  801160:	01 c2                	add    %eax,%edx
  801162:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	01 c8                	add    %ecx,%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80116e:	ff 45 fc             	incl   -0x4(%ebp)
  801171:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801174:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801177:	7c e1                	jl     80115a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801179:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801180:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801187:	eb 1f                	jmp    8011a8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801189:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118c:	8d 50 01             	lea    0x1(%eax),%edx
  80118f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801192:	89 c2                	mov    %eax,%edx
  801194:	8b 45 10             	mov    0x10(%ebp),%eax
  801197:	01 c2                	add    %eax,%edx
  801199:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	01 c8                	add    %ecx,%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011a5:	ff 45 f8             	incl   -0x8(%ebp)
  8011a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ae:	7c d9                	jl     801189 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	c6 00 00             	movb   $0x0,(%eax)
}
  8011bb:	90                   	nop
  8011bc:	c9                   	leave  
  8011bd:	c3                   	ret    

008011be <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011be:	55                   	push   %ebp
  8011bf:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cd:	8b 00                	mov    (%eax),%eax
  8011cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d9:	01 d0                	add    %edx,%eax
  8011db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e1:	eb 0c                	jmp    8011ef <strsplit+0x31>
			*string++ = 0;
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8d 50 01             	lea    0x1(%eax),%edx
  8011e9:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ec:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	84 c0                	test   %al,%al
  8011f6:	74 18                	je     801210 <strsplit+0x52>
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	0f be c0             	movsbl %al,%eax
  801200:	50                   	push   %eax
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	e8 13 fb ff ff       	call   800d1c <strchr>
  801209:	83 c4 08             	add    $0x8,%esp
  80120c:	85 c0                	test   %eax,%eax
  80120e:	75 d3                	jne    8011e3 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	84 c0                	test   %al,%al
  801217:	74 5a                	je     801273 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801219:	8b 45 14             	mov    0x14(%ebp),%eax
  80121c:	8b 00                	mov    (%eax),%eax
  80121e:	83 f8 0f             	cmp    $0xf,%eax
  801221:	75 07                	jne    80122a <strsplit+0x6c>
		{
			return 0;
  801223:	b8 00 00 00 00       	mov    $0x0,%eax
  801228:	eb 66                	jmp    801290 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80122a:	8b 45 14             	mov    0x14(%ebp),%eax
  80122d:	8b 00                	mov    (%eax),%eax
  80122f:	8d 48 01             	lea    0x1(%eax),%ecx
  801232:	8b 55 14             	mov    0x14(%ebp),%edx
  801235:	89 0a                	mov    %ecx,(%edx)
  801237:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80123e:	8b 45 10             	mov    0x10(%ebp),%eax
  801241:	01 c2                	add    %eax,%edx
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801248:	eb 03                	jmp    80124d <strsplit+0x8f>
			string++;
  80124a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	84 c0                	test   %al,%al
  801254:	74 8b                	je     8011e1 <strsplit+0x23>
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	0f be c0             	movsbl %al,%eax
  80125e:	50                   	push   %eax
  80125f:	ff 75 0c             	pushl  0xc(%ebp)
  801262:	e8 b5 fa ff ff       	call   800d1c <strchr>
  801267:	83 c4 08             	add    $0x8,%esp
  80126a:	85 c0                	test   %eax,%eax
  80126c:	74 dc                	je     80124a <strsplit+0x8c>
			string++;
	}
  80126e:	e9 6e ff ff ff       	jmp    8011e1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801273:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801274:	8b 45 14             	mov    0x14(%ebp),%eax
  801277:	8b 00                	mov    (%eax),%eax
  801279:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801280:	8b 45 10             	mov    0x10(%ebp),%eax
  801283:	01 d0                	add    %edx,%eax
  801285:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80128b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
  801295:	57                   	push   %edi
  801296:	56                   	push   %esi
  801297:	53                   	push   %ebx
  801298:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012a7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012aa:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012ad:	cd 30                	int    $0x30
  8012af:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b5:	83 c4 10             	add    $0x10,%esp
  8012b8:	5b                   	pop    %ebx
  8012b9:	5e                   	pop    %esi
  8012ba:	5f                   	pop    %edi
  8012bb:	5d                   	pop    %ebp
  8012bc:	c3                   	ret    

008012bd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012bd:	55                   	push   %ebp
  8012be:	89 e5                	mov    %esp,%ebp
  8012c0:	83 ec 04             	sub    $0x4,%esp
  8012c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012c9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	52                   	push   %edx
  8012d5:	ff 75 0c             	pushl  0xc(%ebp)
  8012d8:	50                   	push   %eax
  8012d9:	6a 00                	push   $0x0
  8012db:	e8 b2 ff ff ff       	call   801292 <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	90                   	nop
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 01                	push   $0x1
  8012f5:	e8 98 ff ff ff       	call   801292 <syscall>
  8012fa:	83 c4 18             	add    $0x18,%esp
}
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	50                   	push   %eax
  80130e:	6a 05                	push   $0x5
  801310:	e8 7d ff ff ff       	call   801292 <syscall>
  801315:	83 c4 18             	add    $0x18,%esp
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 02                	push   $0x2
  801329:	e8 64 ff ff ff       	call   801292 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 03                	push   $0x3
  801342:	e8 4b ff ff ff       	call   801292 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	c9                   	leave  
  80134b:	c3                   	ret    

0080134c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 04                	push   $0x4
  80135b:	e8 32 ff ff ff       	call   801292 <syscall>
  801360:	83 c4 18             	add    $0x18,%esp
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <sys_env_exit>:


void sys_env_exit(void)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 06                	push   $0x6
  801374:	e8 19 ff ff ff       	call   801292 <syscall>
  801379:	83 c4 18             	add    $0x18,%esp
}
  80137c:	90                   	nop
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	52                   	push   %edx
  80138f:	50                   	push   %eax
  801390:	6a 07                	push   $0x7
  801392:	e8 fb fe ff ff       	call   801292 <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
  80139f:	56                   	push   %esi
  8013a0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013a1:	8b 75 18             	mov    0x18(%ebp),%esi
  8013a4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	56                   	push   %esi
  8013b1:	53                   	push   %ebx
  8013b2:	51                   	push   %ecx
  8013b3:	52                   	push   %edx
  8013b4:	50                   	push   %eax
  8013b5:	6a 08                	push   $0x8
  8013b7:	e8 d6 fe ff ff       	call   801292 <syscall>
  8013bc:	83 c4 18             	add    $0x18,%esp
}
  8013bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013c2:	5b                   	pop    %ebx
  8013c3:	5e                   	pop    %esi
  8013c4:	5d                   	pop    %ebp
  8013c5:	c3                   	ret    

008013c6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	52                   	push   %edx
  8013d6:	50                   	push   %eax
  8013d7:	6a 09                	push   $0x9
  8013d9:	e8 b4 fe ff ff       	call   801292 <syscall>
  8013de:	83 c4 18             	add    $0x18,%esp
}
  8013e1:	c9                   	leave  
  8013e2:	c3                   	ret    

008013e3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013e3:	55                   	push   %ebp
  8013e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	ff 75 0c             	pushl  0xc(%ebp)
  8013ef:	ff 75 08             	pushl  0x8(%ebp)
  8013f2:	6a 0a                	push   $0xa
  8013f4:	e8 99 fe ff ff       	call   801292 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 0b                	push   $0xb
  80140d:	e8 80 fe ff ff       	call   801292 <syscall>
  801412:	83 c4 18             	add    $0x18,%esp
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 0c                	push   $0xc
  801426:	e8 67 fe ff ff       	call   801292 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 0d                	push   $0xd
  80143f:	e8 4e fe ff ff       	call   801292 <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	ff 75 0c             	pushl  0xc(%ebp)
  801455:	ff 75 08             	pushl  0x8(%ebp)
  801458:	6a 11                	push   $0x11
  80145a:	e8 33 fe ff ff       	call   801292 <syscall>
  80145f:	83 c4 18             	add    $0x18,%esp
	return;
  801462:	90                   	nop
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	ff 75 0c             	pushl  0xc(%ebp)
  801471:	ff 75 08             	pushl  0x8(%ebp)
  801474:	6a 12                	push   $0x12
  801476:	e8 17 fe ff ff       	call   801292 <syscall>
  80147b:	83 c4 18             	add    $0x18,%esp
	return ;
  80147e:	90                   	nop
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 0e                	push   $0xe
  801490:	e8 fd fd ff ff       	call   801292 <syscall>
  801495:	83 c4 18             	add    $0x18,%esp
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	ff 75 08             	pushl  0x8(%ebp)
  8014a8:	6a 0f                	push   $0xf
  8014aa:	e8 e3 fd ff ff       	call   801292 <syscall>
  8014af:	83 c4 18             	add    $0x18,%esp
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 10                	push   $0x10
  8014c3:	e8 ca fd ff ff       	call   801292 <syscall>
  8014c8:	83 c4 18             	add    $0x18,%esp
}
  8014cb:	90                   	nop
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 14                	push   $0x14
  8014dd:	e8 b0 fd ff ff       	call   801292 <syscall>
  8014e2:	83 c4 18             	add    $0x18,%esp
}
  8014e5:	90                   	nop
  8014e6:	c9                   	leave  
  8014e7:	c3                   	ret    

008014e8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014e8:	55                   	push   %ebp
  8014e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 15                	push   $0x15
  8014f7:	e8 96 fd ff ff       	call   801292 <syscall>
  8014fc:	83 c4 18             	add    $0x18,%esp
}
  8014ff:	90                   	nop
  801500:	c9                   	leave  
  801501:	c3                   	ret    

00801502 <sys_cputc>:


void
sys_cputc(const char c)
{
  801502:	55                   	push   %ebp
  801503:	89 e5                	mov    %esp,%ebp
  801505:	83 ec 04             	sub    $0x4,%esp
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
  80150b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80150e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	50                   	push   %eax
  80151b:	6a 16                	push   $0x16
  80151d:	e8 70 fd ff ff       	call   801292 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	90                   	nop
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 17                	push   $0x17
  801537:	e8 56 fd ff ff       	call   801292 <syscall>
  80153c:	83 c4 18             	add    $0x18,%esp
}
  80153f:	90                   	nop
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	ff 75 0c             	pushl  0xc(%ebp)
  801551:	50                   	push   %eax
  801552:	6a 18                	push   $0x18
  801554:	e8 39 fd ff ff       	call   801292 <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801561:	8b 55 0c             	mov    0xc(%ebp),%edx
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	52                   	push   %edx
  80156e:	50                   	push   %eax
  80156f:	6a 1b                	push   $0x1b
  801571:	e8 1c fd ff ff       	call   801292 <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80157e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	52                   	push   %edx
  80158b:	50                   	push   %eax
  80158c:	6a 19                	push   $0x19
  80158e:	e8 ff fc ff ff       	call   801292 <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
}
  801596:	90                   	nop
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80159c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	52                   	push   %edx
  8015a9:	50                   	push   %eax
  8015aa:	6a 1a                	push   $0x1a
  8015ac:	e8 e1 fc ff ff       	call   801292 <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	90                   	nop
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 04             	sub    $0x4,%esp
  8015bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015c3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015c6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	6a 00                	push   $0x0
  8015cf:	51                   	push   %ecx
  8015d0:	52                   	push   %edx
  8015d1:	ff 75 0c             	pushl  0xc(%ebp)
  8015d4:	50                   	push   %eax
  8015d5:	6a 1c                	push   $0x1c
  8015d7:	e8 b6 fc ff ff       	call   801292 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	52                   	push   %edx
  8015f1:	50                   	push   %eax
  8015f2:	6a 1d                	push   $0x1d
  8015f4:	e8 99 fc ff ff       	call   801292 <syscall>
  8015f9:	83 c4 18             	add    $0x18,%esp
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801601:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801604:	8b 55 0c             	mov    0xc(%ebp),%edx
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	51                   	push   %ecx
  80160f:	52                   	push   %edx
  801610:	50                   	push   %eax
  801611:	6a 1e                	push   $0x1e
  801613:	e8 7a fc ff ff       	call   801292 <syscall>
  801618:	83 c4 18             	add    $0x18,%esp
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    

0080161d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801620:	8b 55 0c             	mov    0xc(%ebp),%edx
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	52                   	push   %edx
  80162d:	50                   	push   %eax
  80162e:	6a 1f                	push   $0x1f
  801630:	e8 5d fc ff ff       	call   801292 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 20                	push   $0x20
  801649:	e8 44 fc ff ff       	call   801292 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	c9                   	leave  
  801652:	c3                   	ret    

00801653 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	6a 00                	push   $0x0
  80165b:	ff 75 14             	pushl  0x14(%ebp)
  80165e:	ff 75 10             	pushl  0x10(%ebp)
  801661:	ff 75 0c             	pushl  0xc(%ebp)
  801664:	50                   	push   %eax
  801665:	6a 21                	push   $0x21
  801667:	e8 26 fc ff ff       	call   801292 <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	50                   	push   %eax
  801680:	6a 22                	push   $0x22
  801682:	e8 0b fc ff ff       	call   801292 <syscall>
  801687:	83 c4 18             	add    $0x18,%esp
}
  80168a:	90                   	nop
  80168b:	c9                   	leave  
  80168c:	c3                   	ret    

0080168d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80168d:	55                   	push   %ebp
  80168e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	50                   	push   %eax
  80169c:	6a 23                	push   $0x23
  80169e:	e8 ef fb ff ff       	call   801292 <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	90                   	nop
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
  8016ac:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016af:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b2:	8d 50 04             	lea    0x4(%eax),%edx
  8016b5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	52                   	push   %edx
  8016bf:	50                   	push   %eax
  8016c0:	6a 24                	push   $0x24
  8016c2:	e8 cb fb ff ff       	call   801292 <syscall>
  8016c7:	83 c4 18             	add    $0x18,%esp
	return result;
  8016ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d3:	89 01                	mov    %eax,(%ecx)
  8016d5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	c9                   	leave  
  8016dc:	c2 04 00             	ret    $0x4

008016df <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016df:	55                   	push   %ebp
  8016e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	ff 75 10             	pushl  0x10(%ebp)
  8016e9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ec:	ff 75 08             	pushl  0x8(%ebp)
  8016ef:	6a 13                	push   $0x13
  8016f1:	e8 9c fb ff ff       	call   801292 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f9:	90                   	nop
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_rcr2>:
uint32 sys_rcr2()
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 25                	push   $0x25
  80170b:	e8 82 fb ff ff       	call   801292 <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
}
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
  801718:	83 ec 04             	sub    $0x4,%esp
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801721:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	50                   	push   %eax
  80172e:	6a 26                	push   $0x26
  801730:	e8 5d fb ff ff       	call   801292 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
	return ;
  801738:	90                   	nop
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <rsttst>:
void rsttst()
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 28                	push   $0x28
  80174a:	e8 43 fb ff ff       	call   801292 <syscall>
  80174f:	83 c4 18             	add    $0x18,%esp
	return ;
  801752:	90                   	nop
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
  801758:	83 ec 04             	sub    $0x4,%esp
  80175b:	8b 45 14             	mov    0x14(%ebp),%eax
  80175e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801761:	8b 55 18             	mov    0x18(%ebp),%edx
  801764:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801768:	52                   	push   %edx
  801769:	50                   	push   %eax
  80176a:	ff 75 10             	pushl  0x10(%ebp)
  80176d:	ff 75 0c             	pushl  0xc(%ebp)
  801770:	ff 75 08             	pushl  0x8(%ebp)
  801773:	6a 27                	push   $0x27
  801775:	e8 18 fb ff ff       	call   801292 <syscall>
  80177a:	83 c4 18             	add    $0x18,%esp
	return ;
  80177d:	90                   	nop
}
  80177e:	c9                   	leave  
  80177f:	c3                   	ret    

00801780 <chktst>:
void chktst(uint32 n)
{
  801780:	55                   	push   %ebp
  801781:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	ff 75 08             	pushl  0x8(%ebp)
  80178e:	6a 29                	push   $0x29
  801790:	e8 fd fa ff ff       	call   801292 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
	return ;
  801798:	90                   	nop
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <inctst>:

void inctst()
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 2a                	push   $0x2a
  8017aa:	e8 e3 fa ff ff       	call   801292 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b2:	90                   	nop
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <gettst>:
uint32 gettst()
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 2b                	push   $0x2b
  8017c4:	e8 c9 fa ff ff       	call   801292 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	c9                   	leave  
  8017cd:	c3                   	ret    

008017ce <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017ce:	55                   	push   %ebp
  8017cf:	89 e5                	mov    %esp,%ebp
  8017d1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 2c                	push   $0x2c
  8017e0:	e8 ad fa ff ff       	call   801292 <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
  8017e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017eb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017ef:	75 07                	jne    8017f8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f6:	eb 05                	jmp    8017fd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
  801802:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 2c                	push   $0x2c
  801811:	e8 7c fa ff ff       	call   801292 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
  801819:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80181c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801820:	75 07                	jne    801829 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801822:	b8 01 00 00 00       	mov    $0x1,%eax
  801827:	eb 05                	jmp    80182e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801829:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 2c                	push   $0x2c
  801842:	e8 4b fa ff ff       	call   801292 <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
  80184a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80184d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801851:	75 07                	jne    80185a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801853:	b8 01 00 00 00       	mov    $0x1,%eax
  801858:	eb 05                	jmp    80185f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80185a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
  801864:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 2c                	push   $0x2c
  801873:	e8 1a fa ff ff       	call   801292 <syscall>
  801878:	83 c4 18             	add    $0x18,%esp
  80187b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80187e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801882:	75 07                	jne    80188b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801884:	b8 01 00 00 00       	mov    $0x1,%eax
  801889:	eb 05                	jmp    801890 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80188b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	ff 75 08             	pushl  0x8(%ebp)
  8018a0:	6a 2d                	push   $0x2d
  8018a2:	e8 eb f9 ff ff       	call   801292 <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018aa:	90                   	nop
}
  8018ab:	c9                   	leave  
  8018ac:	c3                   	ret    

008018ad <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
  8018b0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018b1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bd:	6a 00                	push   $0x0
  8018bf:	53                   	push   %ebx
  8018c0:	51                   	push   %ecx
  8018c1:	52                   	push   %edx
  8018c2:	50                   	push   %eax
  8018c3:	6a 2e                	push   $0x2e
  8018c5:	e8 c8 f9 ff ff       	call   801292 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018d0:	c9                   	leave  
  8018d1:	c3                   	ret    

008018d2 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018d2:	55                   	push   %ebp
  8018d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	52                   	push   %edx
  8018e2:	50                   	push   %eax
  8018e3:	6a 2f                	push   $0x2f
  8018e5:	e8 a8 f9 ff ff       	call   801292 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    
  8018ef:	90                   	nop

008018f0 <__udivdi3>:
  8018f0:	55                   	push   %ebp
  8018f1:	57                   	push   %edi
  8018f2:	56                   	push   %esi
  8018f3:	53                   	push   %ebx
  8018f4:	83 ec 1c             	sub    $0x1c,%esp
  8018f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8018fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8018ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801903:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801907:	89 ca                	mov    %ecx,%edx
  801909:	89 f8                	mov    %edi,%eax
  80190b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80190f:	85 f6                	test   %esi,%esi
  801911:	75 2d                	jne    801940 <__udivdi3+0x50>
  801913:	39 cf                	cmp    %ecx,%edi
  801915:	77 65                	ja     80197c <__udivdi3+0x8c>
  801917:	89 fd                	mov    %edi,%ebp
  801919:	85 ff                	test   %edi,%edi
  80191b:	75 0b                	jne    801928 <__udivdi3+0x38>
  80191d:	b8 01 00 00 00       	mov    $0x1,%eax
  801922:	31 d2                	xor    %edx,%edx
  801924:	f7 f7                	div    %edi
  801926:	89 c5                	mov    %eax,%ebp
  801928:	31 d2                	xor    %edx,%edx
  80192a:	89 c8                	mov    %ecx,%eax
  80192c:	f7 f5                	div    %ebp
  80192e:	89 c1                	mov    %eax,%ecx
  801930:	89 d8                	mov    %ebx,%eax
  801932:	f7 f5                	div    %ebp
  801934:	89 cf                	mov    %ecx,%edi
  801936:	89 fa                	mov    %edi,%edx
  801938:	83 c4 1c             	add    $0x1c,%esp
  80193b:	5b                   	pop    %ebx
  80193c:	5e                   	pop    %esi
  80193d:	5f                   	pop    %edi
  80193e:	5d                   	pop    %ebp
  80193f:	c3                   	ret    
  801940:	39 ce                	cmp    %ecx,%esi
  801942:	77 28                	ja     80196c <__udivdi3+0x7c>
  801944:	0f bd fe             	bsr    %esi,%edi
  801947:	83 f7 1f             	xor    $0x1f,%edi
  80194a:	75 40                	jne    80198c <__udivdi3+0x9c>
  80194c:	39 ce                	cmp    %ecx,%esi
  80194e:	72 0a                	jb     80195a <__udivdi3+0x6a>
  801950:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801954:	0f 87 9e 00 00 00    	ja     8019f8 <__udivdi3+0x108>
  80195a:	b8 01 00 00 00       	mov    $0x1,%eax
  80195f:	89 fa                	mov    %edi,%edx
  801961:	83 c4 1c             	add    $0x1c,%esp
  801964:	5b                   	pop    %ebx
  801965:	5e                   	pop    %esi
  801966:	5f                   	pop    %edi
  801967:	5d                   	pop    %ebp
  801968:	c3                   	ret    
  801969:	8d 76 00             	lea    0x0(%esi),%esi
  80196c:	31 ff                	xor    %edi,%edi
  80196e:	31 c0                	xor    %eax,%eax
  801970:	89 fa                	mov    %edi,%edx
  801972:	83 c4 1c             	add    $0x1c,%esp
  801975:	5b                   	pop    %ebx
  801976:	5e                   	pop    %esi
  801977:	5f                   	pop    %edi
  801978:	5d                   	pop    %ebp
  801979:	c3                   	ret    
  80197a:	66 90                	xchg   %ax,%ax
  80197c:	89 d8                	mov    %ebx,%eax
  80197e:	f7 f7                	div    %edi
  801980:	31 ff                	xor    %edi,%edi
  801982:	89 fa                	mov    %edi,%edx
  801984:	83 c4 1c             	add    $0x1c,%esp
  801987:	5b                   	pop    %ebx
  801988:	5e                   	pop    %esi
  801989:	5f                   	pop    %edi
  80198a:	5d                   	pop    %ebp
  80198b:	c3                   	ret    
  80198c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801991:	89 eb                	mov    %ebp,%ebx
  801993:	29 fb                	sub    %edi,%ebx
  801995:	89 f9                	mov    %edi,%ecx
  801997:	d3 e6                	shl    %cl,%esi
  801999:	89 c5                	mov    %eax,%ebp
  80199b:	88 d9                	mov    %bl,%cl
  80199d:	d3 ed                	shr    %cl,%ebp
  80199f:	89 e9                	mov    %ebp,%ecx
  8019a1:	09 f1                	or     %esi,%ecx
  8019a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019a7:	89 f9                	mov    %edi,%ecx
  8019a9:	d3 e0                	shl    %cl,%eax
  8019ab:	89 c5                	mov    %eax,%ebp
  8019ad:	89 d6                	mov    %edx,%esi
  8019af:	88 d9                	mov    %bl,%cl
  8019b1:	d3 ee                	shr    %cl,%esi
  8019b3:	89 f9                	mov    %edi,%ecx
  8019b5:	d3 e2                	shl    %cl,%edx
  8019b7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019bb:	88 d9                	mov    %bl,%cl
  8019bd:	d3 e8                	shr    %cl,%eax
  8019bf:	09 c2                	or     %eax,%edx
  8019c1:	89 d0                	mov    %edx,%eax
  8019c3:	89 f2                	mov    %esi,%edx
  8019c5:	f7 74 24 0c          	divl   0xc(%esp)
  8019c9:	89 d6                	mov    %edx,%esi
  8019cb:	89 c3                	mov    %eax,%ebx
  8019cd:	f7 e5                	mul    %ebp
  8019cf:	39 d6                	cmp    %edx,%esi
  8019d1:	72 19                	jb     8019ec <__udivdi3+0xfc>
  8019d3:	74 0b                	je     8019e0 <__udivdi3+0xf0>
  8019d5:	89 d8                	mov    %ebx,%eax
  8019d7:	31 ff                	xor    %edi,%edi
  8019d9:	e9 58 ff ff ff       	jmp    801936 <__udivdi3+0x46>
  8019de:	66 90                	xchg   %ax,%ax
  8019e0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8019e4:	89 f9                	mov    %edi,%ecx
  8019e6:	d3 e2                	shl    %cl,%edx
  8019e8:	39 c2                	cmp    %eax,%edx
  8019ea:	73 e9                	jae    8019d5 <__udivdi3+0xe5>
  8019ec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8019ef:	31 ff                	xor    %edi,%edi
  8019f1:	e9 40 ff ff ff       	jmp    801936 <__udivdi3+0x46>
  8019f6:	66 90                	xchg   %ax,%ax
  8019f8:	31 c0                	xor    %eax,%eax
  8019fa:	e9 37 ff ff ff       	jmp    801936 <__udivdi3+0x46>
  8019ff:	90                   	nop

00801a00 <__umoddi3>:
  801a00:	55                   	push   %ebp
  801a01:	57                   	push   %edi
  801a02:	56                   	push   %esi
  801a03:	53                   	push   %ebx
  801a04:	83 ec 1c             	sub    $0x1c,%esp
  801a07:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a0b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a0f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a13:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a17:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a1b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a1f:	89 f3                	mov    %esi,%ebx
  801a21:	89 fa                	mov    %edi,%edx
  801a23:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a27:	89 34 24             	mov    %esi,(%esp)
  801a2a:	85 c0                	test   %eax,%eax
  801a2c:	75 1a                	jne    801a48 <__umoddi3+0x48>
  801a2e:	39 f7                	cmp    %esi,%edi
  801a30:	0f 86 a2 00 00 00    	jbe    801ad8 <__umoddi3+0xd8>
  801a36:	89 c8                	mov    %ecx,%eax
  801a38:	89 f2                	mov    %esi,%edx
  801a3a:	f7 f7                	div    %edi
  801a3c:	89 d0                	mov    %edx,%eax
  801a3e:	31 d2                	xor    %edx,%edx
  801a40:	83 c4 1c             	add    $0x1c,%esp
  801a43:	5b                   	pop    %ebx
  801a44:	5e                   	pop    %esi
  801a45:	5f                   	pop    %edi
  801a46:	5d                   	pop    %ebp
  801a47:	c3                   	ret    
  801a48:	39 f0                	cmp    %esi,%eax
  801a4a:	0f 87 ac 00 00 00    	ja     801afc <__umoddi3+0xfc>
  801a50:	0f bd e8             	bsr    %eax,%ebp
  801a53:	83 f5 1f             	xor    $0x1f,%ebp
  801a56:	0f 84 ac 00 00 00    	je     801b08 <__umoddi3+0x108>
  801a5c:	bf 20 00 00 00       	mov    $0x20,%edi
  801a61:	29 ef                	sub    %ebp,%edi
  801a63:	89 fe                	mov    %edi,%esi
  801a65:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a69:	89 e9                	mov    %ebp,%ecx
  801a6b:	d3 e0                	shl    %cl,%eax
  801a6d:	89 d7                	mov    %edx,%edi
  801a6f:	89 f1                	mov    %esi,%ecx
  801a71:	d3 ef                	shr    %cl,%edi
  801a73:	09 c7                	or     %eax,%edi
  801a75:	89 e9                	mov    %ebp,%ecx
  801a77:	d3 e2                	shl    %cl,%edx
  801a79:	89 14 24             	mov    %edx,(%esp)
  801a7c:	89 d8                	mov    %ebx,%eax
  801a7e:	d3 e0                	shl    %cl,%eax
  801a80:	89 c2                	mov    %eax,%edx
  801a82:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a86:	d3 e0                	shl    %cl,%eax
  801a88:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a8c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a90:	89 f1                	mov    %esi,%ecx
  801a92:	d3 e8                	shr    %cl,%eax
  801a94:	09 d0                	or     %edx,%eax
  801a96:	d3 eb                	shr    %cl,%ebx
  801a98:	89 da                	mov    %ebx,%edx
  801a9a:	f7 f7                	div    %edi
  801a9c:	89 d3                	mov    %edx,%ebx
  801a9e:	f7 24 24             	mull   (%esp)
  801aa1:	89 c6                	mov    %eax,%esi
  801aa3:	89 d1                	mov    %edx,%ecx
  801aa5:	39 d3                	cmp    %edx,%ebx
  801aa7:	0f 82 87 00 00 00    	jb     801b34 <__umoddi3+0x134>
  801aad:	0f 84 91 00 00 00    	je     801b44 <__umoddi3+0x144>
  801ab3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ab7:	29 f2                	sub    %esi,%edx
  801ab9:	19 cb                	sbb    %ecx,%ebx
  801abb:	89 d8                	mov    %ebx,%eax
  801abd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ac1:	d3 e0                	shl    %cl,%eax
  801ac3:	89 e9                	mov    %ebp,%ecx
  801ac5:	d3 ea                	shr    %cl,%edx
  801ac7:	09 d0                	or     %edx,%eax
  801ac9:	89 e9                	mov    %ebp,%ecx
  801acb:	d3 eb                	shr    %cl,%ebx
  801acd:	89 da                	mov    %ebx,%edx
  801acf:	83 c4 1c             	add    $0x1c,%esp
  801ad2:	5b                   	pop    %ebx
  801ad3:	5e                   	pop    %esi
  801ad4:	5f                   	pop    %edi
  801ad5:	5d                   	pop    %ebp
  801ad6:	c3                   	ret    
  801ad7:	90                   	nop
  801ad8:	89 fd                	mov    %edi,%ebp
  801ada:	85 ff                	test   %edi,%edi
  801adc:	75 0b                	jne    801ae9 <__umoddi3+0xe9>
  801ade:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae3:	31 d2                	xor    %edx,%edx
  801ae5:	f7 f7                	div    %edi
  801ae7:	89 c5                	mov    %eax,%ebp
  801ae9:	89 f0                	mov    %esi,%eax
  801aeb:	31 d2                	xor    %edx,%edx
  801aed:	f7 f5                	div    %ebp
  801aef:	89 c8                	mov    %ecx,%eax
  801af1:	f7 f5                	div    %ebp
  801af3:	89 d0                	mov    %edx,%eax
  801af5:	e9 44 ff ff ff       	jmp    801a3e <__umoddi3+0x3e>
  801afa:	66 90                	xchg   %ax,%ax
  801afc:	89 c8                	mov    %ecx,%eax
  801afe:	89 f2                	mov    %esi,%edx
  801b00:	83 c4 1c             	add    $0x1c,%esp
  801b03:	5b                   	pop    %ebx
  801b04:	5e                   	pop    %esi
  801b05:	5f                   	pop    %edi
  801b06:	5d                   	pop    %ebp
  801b07:	c3                   	ret    
  801b08:	3b 04 24             	cmp    (%esp),%eax
  801b0b:	72 06                	jb     801b13 <__umoddi3+0x113>
  801b0d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b11:	77 0f                	ja     801b22 <__umoddi3+0x122>
  801b13:	89 f2                	mov    %esi,%edx
  801b15:	29 f9                	sub    %edi,%ecx
  801b17:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b1b:	89 14 24             	mov    %edx,(%esp)
  801b1e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b22:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b26:	8b 14 24             	mov    (%esp),%edx
  801b29:	83 c4 1c             	add    $0x1c,%esp
  801b2c:	5b                   	pop    %ebx
  801b2d:	5e                   	pop    %esi
  801b2e:	5f                   	pop    %edi
  801b2f:	5d                   	pop    %ebp
  801b30:	c3                   	ret    
  801b31:	8d 76 00             	lea    0x0(%esi),%esi
  801b34:	2b 04 24             	sub    (%esp),%eax
  801b37:	19 fa                	sbb    %edi,%edx
  801b39:	89 d1                	mov    %edx,%ecx
  801b3b:	89 c6                	mov    %eax,%esi
  801b3d:	e9 71 ff ff ff       	jmp    801ab3 <__umoddi3+0xb3>
  801b42:	66 90                	xchg   %ax,%ax
  801b44:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b48:	72 ea                	jb     801b34 <__umoddi3+0x134>
  801b4a:	89 d9                	mov    %ebx,%ecx
  801b4c:	e9 62 ff ff ff       	jmp    801ab3 <__umoddi3+0xb3>
