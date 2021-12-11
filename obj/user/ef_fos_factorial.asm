
obj/user/ef_fos_factorial:     file format elf32-i386


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
  800031:	e8 6c 00 00 00       	call   8000a2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int factorial(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	//atomic_readline("Please enter a number:", buff1);
	i1 = 10;
  800048:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)

	int res = factorial(i1) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 1f 00 00 00       	call   800079 <factorial>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	ff 75 f0             	pushl  -0x10(%ebp)
  800066:	ff 75 f4             	pushl  -0xc(%ebp)
  800069:	68 20 19 80 00       	push   $0x801920
  80006e:	e8 75 02 00 00       	call   8002e8 <atomic_cprintf>
  800073:	83 c4 10             	add    $0x10,%esp

	return;
  800076:	90                   	nop
}
  800077:	c9                   	leave  
  800078:	c3                   	ret    

00800079 <factorial>:


int factorial(int n)
{
  800079:	55                   	push   %ebp
  80007a:	89 e5                	mov    %esp,%ebp
  80007c:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  80007f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800083:	7f 07                	jg     80008c <factorial+0x13>
		return 1 ;
  800085:	b8 01 00 00 00       	mov    $0x1,%eax
  80008a:	eb 14                	jmp    8000a0 <factorial+0x27>
	return n * factorial(n-1) ;
  80008c:	8b 45 08             	mov    0x8(%ebp),%eax
  80008f:	48                   	dec    %eax
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	50                   	push   %eax
  800094:	e8 e0 ff ff ff       	call   800079 <factorial>
  800099:	83 c4 10             	add    $0x10,%esp
  80009c:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000a8:	e8 39 10 00 00       	call   8010e6 <sys_getenvindex>
  8000ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000b3:	89 d0                	mov    %edx,%eax
  8000b5:	c1 e0 03             	shl    $0x3,%eax
  8000b8:	01 d0                	add    %edx,%eax
  8000ba:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000c1:	01 c8                	add    %ecx,%eax
  8000c3:	01 c0                	add    %eax,%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	01 c0                	add    %eax,%eax
  8000c9:	01 d0                	add    %edx,%eax
  8000cb:	89 c2                	mov    %eax,%edx
  8000cd:	c1 e2 05             	shl    $0x5,%edx
  8000d0:	29 c2                	sub    %eax,%edx
  8000d2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000d9:	89 c2                	mov    %eax,%edx
  8000db:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000e1:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000e6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000eb:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8000f1:	84 c0                	test   %al,%al
  8000f3:	74 0f                	je     800104 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8000f5:	a1 20 20 80 00       	mov    0x802020,%eax
  8000fa:	05 40 3c 01 00       	add    $0x13c40,%eax
  8000ff:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800104:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800108:	7e 0a                	jle    800114 <libmain+0x72>
		binaryname = argv[0];
  80010a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80010d:	8b 00                	mov    (%eax),%eax
  80010f:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800114:	83 ec 08             	sub    $0x8,%esp
  800117:	ff 75 0c             	pushl  0xc(%ebp)
  80011a:	ff 75 08             	pushl  0x8(%ebp)
  80011d:	e8 16 ff ff ff       	call   800038 <_main>
  800122:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800125:	e8 57 11 00 00       	call   801281 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80012a:	83 ec 0c             	sub    $0xc,%esp
  80012d:	68 4c 19 80 00       	push   $0x80194c
  800132:	e8 84 01 00 00       	call   8002bb <cprintf>
  800137:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80013a:	a1 20 20 80 00       	mov    0x802020,%eax
  80013f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800145:	a1 20 20 80 00       	mov    0x802020,%eax
  80014a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800150:	83 ec 04             	sub    $0x4,%esp
  800153:	52                   	push   %edx
  800154:	50                   	push   %eax
  800155:	68 74 19 80 00       	push   $0x801974
  80015a:	e8 5c 01 00 00       	call   8002bb <cprintf>
  80015f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800162:	a1 20 20 80 00       	mov    0x802020,%eax
  800167:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80016d:	a1 20 20 80 00       	mov    0x802020,%eax
  800172:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800178:	83 ec 04             	sub    $0x4,%esp
  80017b:	52                   	push   %edx
  80017c:	50                   	push   %eax
  80017d:	68 9c 19 80 00       	push   $0x80199c
  800182:	e8 34 01 00 00       	call   8002bb <cprintf>
  800187:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80018a:	a1 20 20 80 00       	mov    0x802020,%eax
  80018f:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800195:	83 ec 08             	sub    $0x8,%esp
  800198:	50                   	push   %eax
  800199:	68 dd 19 80 00       	push   $0x8019dd
  80019e:	e8 18 01 00 00       	call   8002bb <cprintf>
  8001a3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001a6:	83 ec 0c             	sub    $0xc,%esp
  8001a9:	68 4c 19 80 00       	push   $0x80194c
  8001ae:	e8 08 01 00 00       	call   8002bb <cprintf>
  8001b3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001b6:	e8 e0 10 00 00       	call   80129b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001bb:	e8 19 00 00 00       	call   8001d9 <exit>
}
  8001c0:	90                   	nop
  8001c1:	c9                   	leave  
  8001c2:	c3                   	ret    

008001c3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c3:	55                   	push   %ebp
  8001c4:	89 e5                	mov    %esp,%ebp
  8001c6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001c9:	83 ec 0c             	sub    $0xc,%esp
  8001cc:	6a 00                	push   $0x0
  8001ce:	e8 df 0e 00 00       	call   8010b2 <sys_env_destroy>
  8001d3:	83 c4 10             	add    $0x10,%esp
}
  8001d6:	90                   	nop
  8001d7:	c9                   	leave  
  8001d8:	c3                   	ret    

008001d9 <exit>:

void
exit(void)
{
  8001d9:	55                   	push   %ebp
  8001da:	89 e5                	mov    %esp,%ebp
  8001dc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001df:	e8 34 0f 00 00       	call   801118 <sys_env_exit>
}
  8001e4:	90                   	nop
  8001e5:	c9                   	leave  
  8001e6:	c3                   	ret    

008001e7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001e7:	55                   	push   %ebp
  8001e8:	89 e5                	mov    %esp,%ebp
  8001ea:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f0:	8b 00                	mov    (%eax),%eax
  8001f2:	8d 48 01             	lea    0x1(%eax),%ecx
  8001f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f8:	89 0a                	mov    %ecx,(%edx)
  8001fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8001fd:	88 d1                	mov    %dl,%cl
  8001ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800202:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800206:	8b 45 0c             	mov    0xc(%ebp),%eax
  800209:	8b 00                	mov    (%eax),%eax
  80020b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800210:	75 2c                	jne    80023e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800212:	a0 24 20 80 00       	mov    0x802024,%al
  800217:	0f b6 c0             	movzbl %al,%eax
  80021a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021d:	8b 12                	mov    (%edx),%edx
  80021f:	89 d1                	mov    %edx,%ecx
  800221:	8b 55 0c             	mov    0xc(%ebp),%edx
  800224:	83 c2 08             	add    $0x8,%edx
  800227:	83 ec 04             	sub    $0x4,%esp
  80022a:	50                   	push   %eax
  80022b:	51                   	push   %ecx
  80022c:	52                   	push   %edx
  80022d:	e8 3e 0e 00 00       	call   801070 <sys_cputs>
  800232:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800235:	8b 45 0c             	mov    0xc(%ebp),%eax
  800238:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80023e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800241:	8b 40 04             	mov    0x4(%eax),%eax
  800244:	8d 50 01             	lea    0x1(%eax),%edx
  800247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80024d:	90                   	nop
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800259:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800260:	00 00 00 
	b.cnt = 0;
  800263:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80026a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80026d:	ff 75 0c             	pushl  0xc(%ebp)
  800270:	ff 75 08             	pushl  0x8(%ebp)
  800273:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800279:	50                   	push   %eax
  80027a:	68 e7 01 80 00       	push   $0x8001e7
  80027f:	e8 11 02 00 00       	call   800495 <vprintfmt>
  800284:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800287:	a0 24 20 80 00       	mov    0x802024,%al
  80028c:	0f b6 c0             	movzbl %al,%eax
  80028f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800295:	83 ec 04             	sub    $0x4,%esp
  800298:	50                   	push   %eax
  800299:	52                   	push   %edx
  80029a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a0:	83 c0 08             	add    $0x8,%eax
  8002a3:	50                   	push   %eax
  8002a4:	e8 c7 0d 00 00       	call   801070 <sys_cputs>
  8002a9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ac:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002b3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002b9:	c9                   	leave  
  8002ba:	c3                   	ret    

008002bb <cprintf>:

int cprintf(const char *fmt, ...) {
  8002bb:	55                   	push   %ebp
  8002bc:	89 e5                	mov    %esp,%ebp
  8002be:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002c1:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002c8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d1:	83 ec 08             	sub    $0x8,%esp
  8002d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d7:	50                   	push   %eax
  8002d8:	e8 73 ff ff ff       	call   800250 <vcprintf>
  8002dd:	83 c4 10             	add    $0x10,%esp
  8002e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e6:	c9                   	leave  
  8002e7:	c3                   	ret    

008002e8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002e8:	55                   	push   %ebp
  8002e9:	89 e5                	mov    %esp,%ebp
  8002eb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ee:	e8 8e 0f 00 00       	call   801281 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002f3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002fc:	83 ec 08             	sub    $0x8,%esp
  8002ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800302:	50                   	push   %eax
  800303:	e8 48 ff ff ff       	call   800250 <vcprintf>
  800308:	83 c4 10             	add    $0x10,%esp
  80030b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80030e:	e8 88 0f 00 00       	call   80129b <sys_enable_interrupt>
	return cnt;
  800313:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800316:	c9                   	leave  
  800317:	c3                   	ret    

00800318 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800318:	55                   	push   %ebp
  800319:	89 e5                	mov    %esp,%ebp
  80031b:	53                   	push   %ebx
  80031c:	83 ec 14             	sub    $0x14,%esp
  80031f:	8b 45 10             	mov    0x10(%ebp),%eax
  800322:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800325:	8b 45 14             	mov    0x14(%ebp),%eax
  800328:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80032b:	8b 45 18             	mov    0x18(%ebp),%eax
  80032e:	ba 00 00 00 00       	mov    $0x0,%edx
  800333:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800336:	77 55                	ja     80038d <printnum+0x75>
  800338:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033b:	72 05                	jb     800342 <printnum+0x2a>
  80033d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800340:	77 4b                	ja     80038d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800342:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800345:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800348:	8b 45 18             	mov    0x18(%ebp),%eax
  80034b:	ba 00 00 00 00       	mov    $0x0,%edx
  800350:	52                   	push   %edx
  800351:	50                   	push   %eax
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	ff 75 f0             	pushl  -0x10(%ebp)
  800358:	e8 47 13 00 00       	call   8016a4 <__udivdi3>
  80035d:	83 c4 10             	add    $0x10,%esp
  800360:	83 ec 04             	sub    $0x4,%esp
  800363:	ff 75 20             	pushl  0x20(%ebp)
  800366:	53                   	push   %ebx
  800367:	ff 75 18             	pushl  0x18(%ebp)
  80036a:	52                   	push   %edx
  80036b:	50                   	push   %eax
  80036c:	ff 75 0c             	pushl  0xc(%ebp)
  80036f:	ff 75 08             	pushl  0x8(%ebp)
  800372:	e8 a1 ff ff ff       	call   800318 <printnum>
  800377:	83 c4 20             	add    $0x20,%esp
  80037a:	eb 1a                	jmp    800396 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80037c:	83 ec 08             	sub    $0x8,%esp
  80037f:	ff 75 0c             	pushl  0xc(%ebp)
  800382:	ff 75 20             	pushl  0x20(%ebp)
  800385:	8b 45 08             	mov    0x8(%ebp),%eax
  800388:	ff d0                	call   *%eax
  80038a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80038d:	ff 4d 1c             	decl   0x1c(%ebp)
  800390:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800394:	7f e6                	jg     80037c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800396:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800399:	bb 00 00 00 00       	mov    $0x0,%ebx
  80039e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a4:	53                   	push   %ebx
  8003a5:	51                   	push   %ecx
  8003a6:	52                   	push   %edx
  8003a7:	50                   	push   %eax
  8003a8:	e8 07 14 00 00       	call   8017b4 <__umoddi3>
  8003ad:	83 c4 10             	add    $0x10,%esp
  8003b0:	05 14 1c 80 00       	add    $0x801c14,%eax
  8003b5:	8a 00                	mov    (%eax),%al
  8003b7:	0f be c0             	movsbl %al,%eax
  8003ba:	83 ec 08             	sub    $0x8,%esp
  8003bd:	ff 75 0c             	pushl  0xc(%ebp)
  8003c0:	50                   	push   %eax
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	ff d0                	call   *%eax
  8003c6:	83 c4 10             	add    $0x10,%esp
}
  8003c9:	90                   	nop
  8003ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003cd:	c9                   	leave  
  8003ce:	c3                   	ret    

008003cf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003cf:	55                   	push   %ebp
  8003d0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d6:	7e 1c                	jle    8003f4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	8b 00                	mov    (%eax),%eax
  8003dd:	8d 50 08             	lea    0x8(%eax),%edx
  8003e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e3:	89 10                	mov    %edx,(%eax)
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	83 e8 08             	sub    $0x8,%eax
  8003ed:	8b 50 04             	mov    0x4(%eax),%edx
  8003f0:	8b 00                	mov    (%eax),%eax
  8003f2:	eb 40                	jmp    800434 <getuint+0x65>
	else if (lflag)
  8003f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f8:	74 1e                	je     800418 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	8b 00                	mov    (%eax),%eax
  8003ff:	8d 50 04             	lea    0x4(%eax),%edx
  800402:	8b 45 08             	mov    0x8(%ebp),%eax
  800405:	89 10                	mov    %edx,(%eax)
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	83 e8 04             	sub    $0x4,%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	ba 00 00 00 00       	mov    $0x0,%edx
  800416:	eb 1c                	jmp    800434 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	8d 50 04             	lea    0x4(%eax),%edx
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	89 10                	mov    %edx,(%eax)
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	83 e8 04             	sub    $0x4,%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800434:	5d                   	pop    %ebp
  800435:	c3                   	ret    

00800436 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800436:	55                   	push   %ebp
  800437:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800439:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80043d:	7e 1c                	jle    80045b <getint+0x25>
		return va_arg(*ap, long long);
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	8d 50 08             	lea    0x8(%eax),%edx
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	89 10                	mov    %edx,(%eax)
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	83 e8 08             	sub    $0x8,%eax
  800454:	8b 50 04             	mov    0x4(%eax),%edx
  800457:	8b 00                	mov    (%eax),%eax
  800459:	eb 38                	jmp    800493 <getint+0x5d>
	else if (lflag)
  80045b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80045f:	74 1a                	je     80047b <getint+0x45>
		return va_arg(*ap, long);
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	8d 50 04             	lea    0x4(%eax),%edx
  800469:	8b 45 08             	mov    0x8(%ebp),%eax
  80046c:	89 10                	mov    %edx,(%eax)
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	8b 00                	mov    (%eax),%eax
  800473:	83 e8 04             	sub    $0x4,%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	99                   	cltd   
  800479:	eb 18                	jmp    800493 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	8b 00                	mov    (%eax),%eax
  800480:	8d 50 04             	lea    0x4(%eax),%edx
  800483:	8b 45 08             	mov    0x8(%ebp),%eax
  800486:	89 10                	mov    %edx,(%eax)
  800488:	8b 45 08             	mov    0x8(%ebp),%eax
  80048b:	8b 00                	mov    (%eax),%eax
  80048d:	83 e8 04             	sub    $0x4,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	99                   	cltd   
}
  800493:	5d                   	pop    %ebp
  800494:	c3                   	ret    

00800495 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800495:	55                   	push   %ebp
  800496:	89 e5                	mov    %esp,%ebp
  800498:	56                   	push   %esi
  800499:	53                   	push   %ebx
  80049a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80049d:	eb 17                	jmp    8004b6 <vprintfmt+0x21>
			if (ch == '\0')
  80049f:	85 db                	test   %ebx,%ebx
  8004a1:	0f 84 af 03 00 00    	je     800856 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	ff 75 0c             	pushl  0xc(%ebp)
  8004ad:	53                   	push   %ebx
  8004ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b1:	ff d0                	call   *%eax
  8004b3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b9:	8d 50 01             	lea    0x1(%eax),%edx
  8004bc:	89 55 10             	mov    %edx,0x10(%ebp)
  8004bf:	8a 00                	mov    (%eax),%al
  8004c1:	0f b6 d8             	movzbl %al,%ebx
  8004c4:	83 fb 25             	cmp    $0x25,%ebx
  8004c7:	75 d6                	jne    80049f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004c9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004cd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004d4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004e2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ec:	8d 50 01             	lea    0x1(%eax),%edx
  8004ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f2:	8a 00                	mov    (%eax),%al
  8004f4:	0f b6 d8             	movzbl %al,%ebx
  8004f7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004fa:	83 f8 55             	cmp    $0x55,%eax
  8004fd:	0f 87 2b 03 00 00    	ja     80082e <vprintfmt+0x399>
  800503:	8b 04 85 38 1c 80 00 	mov    0x801c38(,%eax,4),%eax
  80050a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80050c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800510:	eb d7                	jmp    8004e9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800512:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800516:	eb d1                	jmp    8004e9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800518:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80051f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800522:	89 d0                	mov    %edx,%eax
  800524:	c1 e0 02             	shl    $0x2,%eax
  800527:	01 d0                	add    %edx,%eax
  800529:	01 c0                	add    %eax,%eax
  80052b:	01 d8                	add    %ebx,%eax
  80052d:	83 e8 30             	sub    $0x30,%eax
  800530:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800533:	8b 45 10             	mov    0x10(%ebp),%eax
  800536:	8a 00                	mov    (%eax),%al
  800538:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80053b:	83 fb 2f             	cmp    $0x2f,%ebx
  80053e:	7e 3e                	jle    80057e <vprintfmt+0xe9>
  800540:	83 fb 39             	cmp    $0x39,%ebx
  800543:	7f 39                	jg     80057e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800545:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800548:	eb d5                	jmp    80051f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80054a:	8b 45 14             	mov    0x14(%ebp),%eax
  80054d:	83 c0 04             	add    $0x4,%eax
  800550:	89 45 14             	mov    %eax,0x14(%ebp)
  800553:	8b 45 14             	mov    0x14(%ebp),%eax
  800556:	83 e8 04             	sub    $0x4,%eax
  800559:	8b 00                	mov    (%eax),%eax
  80055b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80055e:	eb 1f                	jmp    80057f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800560:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800564:	79 83                	jns    8004e9 <vprintfmt+0x54>
				width = 0;
  800566:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80056d:	e9 77 ff ff ff       	jmp    8004e9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800572:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800579:	e9 6b ff ff ff       	jmp    8004e9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80057e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80057f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800583:	0f 89 60 ff ff ff    	jns    8004e9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800589:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80058c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80058f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800596:	e9 4e ff ff ff       	jmp    8004e9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80059b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80059e:	e9 46 ff ff ff       	jmp    8004e9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	83 c0 04             	add    $0x4,%eax
  8005a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 e8 04             	sub    $0x4,%eax
  8005b2:	8b 00                	mov    (%eax),%eax
  8005b4:	83 ec 08             	sub    $0x8,%esp
  8005b7:	ff 75 0c             	pushl  0xc(%ebp)
  8005ba:	50                   	push   %eax
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	ff d0                	call   *%eax
  8005c0:	83 c4 10             	add    $0x10,%esp
			break;
  8005c3:	e9 89 02 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cb:	83 c0 04             	add    $0x4,%eax
  8005ce:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d4:	83 e8 04             	sub    $0x4,%eax
  8005d7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005d9:	85 db                	test   %ebx,%ebx
  8005db:	79 02                	jns    8005df <vprintfmt+0x14a>
				err = -err;
  8005dd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005df:	83 fb 64             	cmp    $0x64,%ebx
  8005e2:	7f 0b                	jg     8005ef <vprintfmt+0x15a>
  8005e4:	8b 34 9d 80 1a 80 00 	mov    0x801a80(,%ebx,4),%esi
  8005eb:	85 f6                	test   %esi,%esi
  8005ed:	75 19                	jne    800608 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ef:	53                   	push   %ebx
  8005f0:	68 25 1c 80 00       	push   $0x801c25
  8005f5:	ff 75 0c             	pushl  0xc(%ebp)
  8005f8:	ff 75 08             	pushl  0x8(%ebp)
  8005fb:	e8 5e 02 00 00       	call   80085e <printfmt>
  800600:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800603:	e9 49 02 00 00       	jmp    800851 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800608:	56                   	push   %esi
  800609:	68 2e 1c 80 00       	push   $0x801c2e
  80060e:	ff 75 0c             	pushl  0xc(%ebp)
  800611:	ff 75 08             	pushl  0x8(%ebp)
  800614:	e8 45 02 00 00       	call   80085e <printfmt>
  800619:	83 c4 10             	add    $0x10,%esp
			break;
  80061c:	e9 30 02 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800621:	8b 45 14             	mov    0x14(%ebp),%eax
  800624:	83 c0 04             	add    $0x4,%eax
  800627:	89 45 14             	mov    %eax,0x14(%ebp)
  80062a:	8b 45 14             	mov    0x14(%ebp),%eax
  80062d:	83 e8 04             	sub    $0x4,%eax
  800630:	8b 30                	mov    (%eax),%esi
  800632:	85 f6                	test   %esi,%esi
  800634:	75 05                	jne    80063b <vprintfmt+0x1a6>
				p = "(null)";
  800636:	be 31 1c 80 00       	mov    $0x801c31,%esi
			if (width > 0 && padc != '-')
  80063b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063f:	7e 6d                	jle    8006ae <vprintfmt+0x219>
  800641:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800645:	74 67                	je     8006ae <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800647:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80064a:	83 ec 08             	sub    $0x8,%esp
  80064d:	50                   	push   %eax
  80064e:	56                   	push   %esi
  80064f:	e8 0c 03 00 00       	call   800960 <strnlen>
  800654:	83 c4 10             	add    $0x10,%esp
  800657:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80065a:	eb 16                	jmp    800672 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80065c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	ff 75 0c             	pushl  0xc(%ebp)
  800666:	50                   	push   %eax
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	ff d0                	call   *%eax
  80066c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80066f:	ff 4d e4             	decl   -0x1c(%ebp)
  800672:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800676:	7f e4                	jg     80065c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800678:	eb 34                	jmp    8006ae <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80067a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80067e:	74 1c                	je     80069c <vprintfmt+0x207>
  800680:	83 fb 1f             	cmp    $0x1f,%ebx
  800683:	7e 05                	jle    80068a <vprintfmt+0x1f5>
  800685:	83 fb 7e             	cmp    $0x7e,%ebx
  800688:	7e 12                	jle    80069c <vprintfmt+0x207>
					putch('?', putdat);
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	ff 75 0c             	pushl  0xc(%ebp)
  800690:	6a 3f                	push   $0x3f
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	ff d0                	call   *%eax
  800697:	83 c4 10             	add    $0x10,%esp
  80069a:	eb 0f                	jmp    8006ab <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80069c:	83 ec 08             	sub    $0x8,%esp
  80069f:	ff 75 0c             	pushl  0xc(%ebp)
  8006a2:	53                   	push   %ebx
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	ff d0                	call   *%eax
  8006a8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ab:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ae:	89 f0                	mov    %esi,%eax
  8006b0:	8d 70 01             	lea    0x1(%eax),%esi
  8006b3:	8a 00                	mov    (%eax),%al
  8006b5:	0f be d8             	movsbl %al,%ebx
  8006b8:	85 db                	test   %ebx,%ebx
  8006ba:	74 24                	je     8006e0 <vprintfmt+0x24b>
  8006bc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c0:	78 b8                	js     80067a <vprintfmt+0x1e5>
  8006c2:	ff 4d e0             	decl   -0x20(%ebp)
  8006c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c9:	79 af                	jns    80067a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006cb:	eb 13                	jmp    8006e0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	ff 75 0c             	pushl  0xc(%ebp)
  8006d3:	6a 20                	push   $0x20
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	ff d0                	call   *%eax
  8006da:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006dd:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e4:	7f e7                	jg     8006cd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006e6:	e9 66 01 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f1:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f4:	50                   	push   %eax
  8006f5:	e8 3c fd ff ff       	call   800436 <getint>
  8006fa:	83 c4 10             	add    $0x10,%esp
  8006fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800700:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800703:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800706:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800709:	85 d2                	test   %edx,%edx
  80070b:	79 23                	jns    800730 <vprintfmt+0x29b>
				putch('-', putdat);
  80070d:	83 ec 08             	sub    $0x8,%esp
  800710:	ff 75 0c             	pushl  0xc(%ebp)
  800713:	6a 2d                	push   $0x2d
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	ff d0                	call   *%eax
  80071a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80071d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800720:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800723:	f7 d8                	neg    %eax
  800725:	83 d2 00             	adc    $0x0,%edx
  800728:	f7 da                	neg    %edx
  80072a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80072d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800730:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800737:	e9 bc 00 00 00       	jmp    8007f8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	ff 75 e8             	pushl  -0x18(%ebp)
  800742:	8d 45 14             	lea    0x14(%ebp),%eax
  800745:	50                   	push   %eax
  800746:	e8 84 fc ff ff       	call   8003cf <getuint>
  80074b:	83 c4 10             	add    $0x10,%esp
  80074e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800751:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800754:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80075b:	e9 98 00 00 00       	jmp    8007f8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	ff 75 0c             	pushl  0xc(%ebp)
  800766:	6a 58                	push   $0x58
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	ff d0                	call   *%eax
  80076d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	6a 58                	push   $0x58
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	ff d0                	call   *%eax
  80077d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 0c             	pushl  0xc(%ebp)
  800786:	6a 58                	push   $0x58
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	ff d0                	call   *%eax
  80078d:	83 c4 10             	add    $0x10,%esp
			break;
  800790:	e9 bc 00 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800795:	83 ec 08             	sub    $0x8,%esp
  800798:	ff 75 0c             	pushl  0xc(%ebp)
  80079b:	6a 30                	push   $0x30
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	ff d0                	call   *%eax
  8007a2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 0c             	pushl  0xc(%ebp)
  8007ab:	6a 78                	push   $0x78
  8007ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b0:	ff d0                	call   *%eax
  8007b2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b8:	83 c0 04             	add    $0x4,%eax
  8007bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8007be:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c1:	83 e8 04             	sub    $0x4,%eax
  8007c4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007d7:	eb 1f                	jmp    8007f8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007d9:	83 ec 08             	sub    $0x8,%esp
  8007dc:	ff 75 e8             	pushl  -0x18(%ebp)
  8007df:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e2:	50                   	push   %eax
  8007e3:	e8 e7 fb ff ff       	call   8003cf <getuint>
  8007e8:	83 c4 10             	add    $0x10,%esp
  8007eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007f8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007ff:	83 ec 04             	sub    $0x4,%esp
  800802:	52                   	push   %edx
  800803:	ff 75 e4             	pushl  -0x1c(%ebp)
  800806:	50                   	push   %eax
  800807:	ff 75 f4             	pushl  -0xc(%ebp)
  80080a:	ff 75 f0             	pushl  -0x10(%ebp)
  80080d:	ff 75 0c             	pushl  0xc(%ebp)
  800810:	ff 75 08             	pushl  0x8(%ebp)
  800813:	e8 00 fb ff ff       	call   800318 <printnum>
  800818:	83 c4 20             	add    $0x20,%esp
			break;
  80081b:	eb 34                	jmp    800851 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	ff 75 0c             	pushl  0xc(%ebp)
  800823:	53                   	push   %ebx
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	ff d0                	call   *%eax
  800829:	83 c4 10             	add    $0x10,%esp
			break;
  80082c:	eb 23                	jmp    800851 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	ff 75 0c             	pushl  0xc(%ebp)
  800834:	6a 25                	push   $0x25
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	ff d0                	call   *%eax
  80083b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80083e:	ff 4d 10             	decl   0x10(%ebp)
  800841:	eb 03                	jmp    800846 <vprintfmt+0x3b1>
  800843:	ff 4d 10             	decl   0x10(%ebp)
  800846:	8b 45 10             	mov    0x10(%ebp),%eax
  800849:	48                   	dec    %eax
  80084a:	8a 00                	mov    (%eax),%al
  80084c:	3c 25                	cmp    $0x25,%al
  80084e:	75 f3                	jne    800843 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800850:	90                   	nop
		}
	}
  800851:	e9 47 fc ff ff       	jmp    80049d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800856:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800857:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80085a:	5b                   	pop    %ebx
  80085b:	5e                   	pop    %esi
  80085c:	5d                   	pop    %ebp
  80085d:	c3                   	ret    

0080085e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80085e:	55                   	push   %ebp
  80085f:	89 e5                	mov    %esp,%ebp
  800861:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800864:	8d 45 10             	lea    0x10(%ebp),%eax
  800867:	83 c0 04             	add    $0x4,%eax
  80086a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80086d:	8b 45 10             	mov    0x10(%ebp),%eax
  800870:	ff 75 f4             	pushl  -0xc(%ebp)
  800873:	50                   	push   %eax
  800874:	ff 75 0c             	pushl  0xc(%ebp)
  800877:	ff 75 08             	pushl  0x8(%ebp)
  80087a:	e8 16 fc ff ff       	call   800495 <vprintfmt>
  80087f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800882:	90                   	nop
  800883:	c9                   	leave  
  800884:	c3                   	ret    

00800885 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800885:	55                   	push   %ebp
  800886:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088b:	8b 40 08             	mov    0x8(%eax),%eax
  80088e:	8d 50 01             	lea    0x1(%eax),%edx
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800897:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089a:	8b 10                	mov    (%eax),%edx
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	8b 40 04             	mov    0x4(%eax),%eax
  8008a2:	39 c2                	cmp    %eax,%edx
  8008a4:	73 12                	jae    8008b8 <sprintputch+0x33>
		*b->buf++ = ch;
  8008a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a9:	8b 00                	mov    (%eax),%eax
  8008ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b1:	89 0a                	mov    %ecx,(%edx)
  8008b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b6:	88 10                	mov    %dl,(%eax)
}
  8008b8:	90                   	nop
  8008b9:	5d                   	pop    %ebp
  8008ba:	c3                   	ret    

008008bb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008bb:	55                   	push   %ebp
  8008bc:	89 e5                	mov    %esp,%ebp
  8008be:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	01 d0                	add    %edx,%eax
  8008d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e0:	74 06                	je     8008e8 <vsnprintf+0x2d>
  8008e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e6:	7f 07                	jg     8008ef <vsnprintf+0x34>
		return -E_INVAL;
  8008e8:	b8 03 00 00 00       	mov    $0x3,%eax
  8008ed:	eb 20                	jmp    80090f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ef:	ff 75 14             	pushl  0x14(%ebp)
  8008f2:	ff 75 10             	pushl  0x10(%ebp)
  8008f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008f8:	50                   	push   %eax
  8008f9:	68 85 08 80 00       	push   $0x800885
  8008fe:	e8 92 fb ff ff       	call   800495 <vprintfmt>
  800903:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800906:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800909:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80090c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80090f:	c9                   	leave  
  800910:	c3                   	ret    

00800911 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800911:	55                   	push   %ebp
  800912:	89 e5                	mov    %esp,%ebp
  800914:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800917:	8d 45 10             	lea    0x10(%ebp),%eax
  80091a:	83 c0 04             	add    $0x4,%eax
  80091d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800920:	8b 45 10             	mov    0x10(%ebp),%eax
  800923:	ff 75 f4             	pushl  -0xc(%ebp)
  800926:	50                   	push   %eax
  800927:	ff 75 0c             	pushl  0xc(%ebp)
  80092a:	ff 75 08             	pushl  0x8(%ebp)
  80092d:	e8 89 ff ff ff       	call   8008bb <vsnprintf>
  800932:	83 c4 10             	add    $0x10,%esp
  800935:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800938:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80093b:	c9                   	leave  
  80093c:	c3                   	ret    

0080093d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80093d:	55                   	push   %ebp
  80093e:	89 e5                	mov    %esp,%ebp
  800940:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800943:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80094a:	eb 06                	jmp    800952 <strlen+0x15>
		n++;
  80094c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80094f:	ff 45 08             	incl   0x8(%ebp)
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	8a 00                	mov    (%eax),%al
  800957:	84 c0                	test   %al,%al
  800959:	75 f1                	jne    80094c <strlen+0xf>
		n++;
	return n;
  80095b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80095e:	c9                   	leave  
  80095f:	c3                   	ret    

00800960 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800960:	55                   	push   %ebp
  800961:	89 e5                	mov    %esp,%ebp
  800963:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800966:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80096d:	eb 09                	jmp    800978 <strnlen+0x18>
		n++;
  80096f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800972:	ff 45 08             	incl   0x8(%ebp)
  800975:	ff 4d 0c             	decl   0xc(%ebp)
  800978:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80097c:	74 09                	je     800987 <strnlen+0x27>
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	8a 00                	mov    (%eax),%al
  800983:	84 c0                	test   %al,%al
  800985:	75 e8                	jne    80096f <strnlen+0xf>
		n++;
	return n;
  800987:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80098a:	c9                   	leave  
  80098b:	c3                   	ret    

0080098c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80098c:	55                   	push   %ebp
  80098d:	89 e5                	mov    %esp,%ebp
  80098f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800992:	8b 45 08             	mov    0x8(%ebp),%eax
  800995:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800998:	90                   	nop
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	8d 50 01             	lea    0x1(%eax),%edx
  80099f:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009ab:	8a 12                	mov    (%edx),%dl
  8009ad:	88 10                	mov    %dl,(%eax)
  8009af:	8a 00                	mov    (%eax),%al
  8009b1:	84 c0                	test   %al,%al
  8009b3:	75 e4                	jne    800999 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009b8:	c9                   	leave  
  8009b9:	c3                   	ret    

008009ba <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009ba:	55                   	push   %ebp
  8009bb:	89 e5                	mov    %esp,%ebp
  8009bd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009cd:	eb 1f                	jmp    8009ee <strncpy+0x34>
		*dst++ = *src;
  8009cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d2:	8d 50 01             	lea    0x1(%eax),%edx
  8009d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009db:	8a 12                	mov    (%edx),%dl
  8009dd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e2:	8a 00                	mov    (%eax),%al
  8009e4:	84 c0                	test   %al,%al
  8009e6:	74 03                	je     8009eb <strncpy+0x31>
			src++;
  8009e8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009eb:	ff 45 fc             	incl   -0x4(%ebp)
  8009ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009f1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009f4:	72 d9                	jb     8009cf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009f9:	c9                   	leave  
  8009fa:	c3                   	ret    

008009fb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009fb:	55                   	push   %ebp
  8009fc:	89 e5                	mov    %esp,%ebp
  8009fe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a0b:	74 30                	je     800a3d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a0d:	eb 16                	jmp    800a25 <strlcpy+0x2a>
			*dst++ = *src++;
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	8d 50 01             	lea    0x1(%eax),%edx
  800a15:	89 55 08             	mov    %edx,0x8(%ebp)
  800a18:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a1e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a21:	8a 12                	mov    (%edx),%dl
  800a23:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a25:	ff 4d 10             	decl   0x10(%ebp)
  800a28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a2c:	74 09                	je     800a37 <strlcpy+0x3c>
  800a2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a31:	8a 00                	mov    (%eax),%al
  800a33:	84 c0                	test   %al,%al
  800a35:	75 d8                	jne    800a0f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a37:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a3d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a40:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a43:	29 c2                	sub    %eax,%edx
  800a45:	89 d0                	mov    %edx,%eax
}
  800a47:	c9                   	leave  
  800a48:	c3                   	ret    

00800a49 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a49:	55                   	push   %ebp
  800a4a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a4c:	eb 06                	jmp    800a54 <strcmp+0xb>
		p++, q++;
  800a4e:	ff 45 08             	incl   0x8(%ebp)
  800a51:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a54:	8b 45 08             	mov    0x8(%ebp),%eax
  800a57:	8a 00                	mov    (%eax),%al
  800a59:	84 c0                	test   %al,%al
  800a5b:	74 0e                	je     800a6b <strcmp+0x22>
  800a5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a60:	8a 10                	mov    (%eax),%dl
  800a62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a65:	8a 00                	mov    (%eax),%al
  800a67:	38 c2                	cmp    %al,%dl
  800a69:	74 e3                	je     800a4e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	8a 00                	mov    (%eax),%al
  800a70:	0f b6 d0             	movzbl %al,%edx
  800a73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a76:	8a 00                	mov    (%eax),%al
  800a78:	0f b6 c0             	movzbl %al,%eax
  800a7b:	29 c2                	sub    %eax,%edx
  800a7d:	89 d0                	mov    %edx,%eax
}
  800a7f:	5d                   	pop    %ebp
  800a80:	c3                   	ret    

00800a81 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a81:	55                   	push   %ebp
  800a82:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a84:	eb 09                	jmp    800a8f <strncmp+0xe>
		n--, p++, q++;
  800a86:	ff 4d 10             	decl   0x10(%ebp)
  800a89:	ff 45 08             	incl   0x8(%ebp)
  800a8c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a93:	74 17                	je     800aac <strncmp+0x2b>
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	8a 00                	mov    (%eax),%al
  800a9a:	84 c0                	test   %al,%al
  800a9c:	74 0e                	je     800aac <strncmp+0x2b>
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	8a 10                	mov    (%eax),%dl
  800aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa6:	8a 00                	mov    (%eax),%al
  800aa8:	38 c2                	cmp    %al,%dl
  800aaa:	74 da                	je     800a86 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab0:	75 07                	jne    800ab9 <strncmp+0x38>
		return 0;
  800ab2:	b8 00 00 00 00       	mov    $0x0,%eax
  800ab7:	eb 14                	jmp    800acd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	0f b6 d0             	movzbl %al,%edx
  800ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac4:	8a 00                	mov    (%eax),%al
  800ac6:	0f b6 c0             	movzbl %al,%eax
  800ac9:	29 c2                	sub    %eax,%edx
  800acb:	89 d0                	mov    %edx,%eax
}
  800acd:	5d                   	pop    %ebp
  800ace:	c3                   	ret    

00800acf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800acf:	55                   	push   %ebp
  800ad0:	89 e5                	mov    %esp,%ebp
  800ad2:	83 ec 04             	sub    $0x4,%esp
  800ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800adb:	eb 12                	jmp    800aef <strchr+0x20>
		if (*s == c)
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	8a 00                	mov    (%eax),%al
  800ae2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ae5:	75 05                	jne    800aec <strchr+0x1d>
			return (char *) s;
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	eb 11                	jmp    800afd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aec:	ff 45 08             	incl   0x8(%ebp)
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	8a 00                	mov    (%eax),%al
  800af4:	84 c0                	test   %al,%al
  800af6:	75 e5                	jne    800add <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800af8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800afd:	c9                   	leave  
  800afe:	c3                   	ret    

00800aff <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aff:	55                   	push   %ebp
  800b00:	89 e5                	mov    %esp,%ebp
  800b02:	83 ec 04             	sub    $0x4,%esp
  800b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b08:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b0b:	eb 0d                	jmp    800b1a <strfind+0x1b>
		if (*s == c)
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	8a 00                	mov    (%eax),%al
  800b12:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b15:	74 0e                	je     800b25 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b17:	ff 45 08             	incl   0x8(%ebp)
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8a 00                	mov    (%eax),%al
  800b1f:	84 c0                	test   %al,%al
  800b21:	75 ea                	jne    800b0d <strfind+0xe>
  800b23:	eb 01                	jmp    800b26 <strfind+0x27>
		if (*s == c)
			break;
  800b25:	90                   	nop
	return (char *) s;
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b29:	c9                   	leave  
  800b2a:	c3                   	ret    

00800b2b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b2b:	55                   	push   %ebp
  800b2c:	89 e5                	mov    %esp,%ebp
  800b2e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b37:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b3d:	eb 0e                	jmp    800b4d <memset+0x22>
		*p++ = c;
  800b3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b42:	8d 50 01             	lea    0x1(%eax),%edx
  800b45:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b4d:	ff 4d f8             	decl   -0x8(%ebp)
  800b50:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b54:	79 e9                	jns    800b3f <memset+0x14>
		*p++ = c;

	return v;
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b59:	c9                   	leave  
  800b5a:	c3                   	ret    

00800b5b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b5b:	55                   	push   %ebp
  800b5c:	89 e5                	mov    %esp,%ebp
  800b5e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b64:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b6d:	eb 16                	jmp    800b85 <memcpy+0x2a>
		*d++ = *s++;
  800b6f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b72:	8d 50 01             	lea    0x1(%eax),%edx
  800b75:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b78:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b7b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b7e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b81:	8a 12                	mov    (%edx),%dl
  800b83:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b85:	8b 45 10             	mov    0x10(%ebp),%eax
  800b88:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b8b:	89 55 10             	mov    %edx,0x10(%ebp)
  800b8e:	85 c0                	test   %eax,%eax
  800b90:	75 dd                	jne    800b6f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b95:	c9                   	leave  
  800b96:	c3                   	ret    

00800b97 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b97:	55                   	push   %ebp
  800b98:	89 e5                	mov    %esp,%ebp
  800b9a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ba9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800baf:	73 50                	jae    800c01 <memmove+0x6a>
  800bb1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb7:	01 d0                	add    %edx,%eax
  800bb9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bbc:	76 43                	jbe    800c01 <memmove+0x6a>
		s += n;
  800bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bca:	eb 10                	jmp    800bdc <memmove+0x45>
			*--d = *--s;
  800bcc:	ff 4d f8             	decl   -0x8(%ebp)
  800bcf:	ff 4d fc             	decl   -0x4(%ebp)
  800bd2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd5:	8a 10                	mov    (%eax),%dl
  800bd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bda:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be2:	89 55 10             	mov    %edx,0x10(%ebp)
  800be5:	85 c0                	test   %eax,%eax
  800be7:	75 e3                	jne    800bcc <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800be9:	eb 23                	jmp    800c0e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800beb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bee:	8d 50 01             	lea    0x1(%eax),%edx
  800bf1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bf4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bfa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bfd:	8a 12                	mov    (%edx),%dl
  800bff:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c01:	8b 45 10             	mov    0x10(%ebp),%eax
  800c04:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c07:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0a:	85 c0                	test   %eax,%eax
  800c0c:	75 dd                	jne    800beb <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c11:	c9                   	leave  
  800c12:	c3                   	ret    

00800c13 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c13:	55                   	push   %ebp
  800c14:	89 e5                	mov    %esp,%ebp
  800c16:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c22:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c25:	eb 2a                	jmp    800c51 <memcmp+0x3e>
		if (*s1 != *s2)
  800c27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2a:	8a 10                	mov    (%eax),%dl
  800c2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	38 c2                	cmp    %al,%dl
  800c33:	74 16                	je     800c4b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f b6 d0             	movzbl %al,%edx
  800c3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c40:	8a 00                	mov    (%eax),%al
  800c42:	0f b6 c0             	movzbl %al,%eax
  800c45:	29 c2                	sub    %eax,%edx
  800c47:	89 d0                	mov    %edx,%eax
  800c49:	eb 18                	jmp    800c63 <memcmp+0x50>
		s1++, s2++;
  800c4b:	ff 45 fc             	incl   -0x4(%ebp)
  800c4e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c51:	8b 45 10             	mov    0x10(%ebp),%eax
  800c54:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c57:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5a:	85 c0                	test   %eax,%eax
  800c5c:	75 c9                	jne    800c27 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c63:	c9                   	leave  
  800c64:	c3                   	ret    

00800c65 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c65:	55                   	push   %ebp
  800c66:	89 e5                	mov    %esp,%ebp
  800c68:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c6b:	8b 55 08             	mov    0x8(%ebp),%edx
  800c6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c71:	01 d0                	add    %edx,%eax
  800c73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c76:	eb 15                	jmp    800c8d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	8a 00                	mov    (%eax),%al
  800c7d:	0f b6 d0             	movzbl %al,%edx
  800c80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c83:	0f b6 c0             	movzbl %al,%eax
  800c86:	39 c2                	cmp    %eax,%edx
  800c88:	74 0d                	je     800c97 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c8a:	ff 45 08             	incl   0x8(%ebp)
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c93:	72 e3                	jb     800c78 <memfind+0x13>
  800c95:	eb 01                	jmp    800c98 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c97:	90                   	nop
	return (void *) s;
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c9b:	c9                   	leave  
  800c9c:	c3                   	ret    

00800c9d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c9d:	55                   	push   %ebp
  800c9e:	89 e5                	mov    %esp,%ebp
  800ca0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ca3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800caa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cb1:	eb 03                	jmp    800cb6 <strtol+0x19>
		s++;
  800cb3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	3c 20                	cmp    $0x20,%al
  800cbd:	74 f4                	je     800cb3 <strtol+0x16>
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	3c 09                	cmp    $0x9,%al
  800cc6:	74 eb                	je     800cb3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	3c 2b                	cmp    $0x2b,%al
  800ccf:	75 05                	jne    800cd6 <strtol+0x39>
		s++;
  800cd1:	ff 45 08             	incl   0x8(%ebp)
  800cd4:	eb 13                	jmp    800ce9 <strtol+0x4c>
	else if (*s == '-')
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	8a 00                	mov    (%eax),%al
  800cdb:	3c 2d                	cmp    $0x2d,%al
  800cdd:	75 0a                	jne    800ce9 <strtol+0x4c>
		s++, neg = 1;
  800cdf:	ff 45 08             	incl   0x8(%ebp)
  800ce2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ce9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ced:	74 06                	je     800cf5 <strtol+0x58>
  800cef:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cf3:	75 20                	jne    800d15 <strtol+0x78>
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	3c 30                	cmp    $0x30,%al
  800cfc:	75 17                	jne    800d15 <strtol+0x78>
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	40                   	inc    %eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	3c 78                	cmp    $0x78,%al
  800d06:	75 0d                	jne    800d15 <strtol+0x78>
		s += 2, base = 16;
  800d08:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d0c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d13:	eb 28                	jmp    800d3d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d19:	75 15                	jne    800d30 <strtol+0x93>
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	8a 00                	mov    (%eax),%al
  800d20:	3c 30                	cmp    $0x30,%al
  800d22:	75 0c                	jne    800d30 <strtol+0x93>
		s++, base = 8;
  800d24:	ff 45 08             	incl   0x8(%ebp)
  800d27:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d2e:	eb 0d                	jmp    800d3d <strtol+0xa0>
	else if (base == 0)
  800d30:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d34:	75 07                	jne    800d3d <strtol+0xa0>
		base = 10;
  800d36:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	8a 00                	mov    (%eax),%al
  800d42:	3c 2f                	cmp    $0x2f,%al
  800d44:	7e 19                	jle    800d5f <strtol+0xc2>
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	8a 00                	mov    (%eax),%al
  800d4b:	3c 39                	cmp    $0x39,%al
  800d4d:	7f 10                	jg     800d5f <strtol+0xc2>
			dig = *s - '0';
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	0f be c0             	movsbl %al,%eax
  800d57:	83 e8 30             	sub    $0x30,%eax
  800d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d5d:	eb 42                	jmp    800da1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	3c 60                	cmp    $0x60,%al
  800d66:	7e 19                	jle    800d81 <strtol+0xe4>
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	3c 7a                	cmp    $0x7a,%al
  800d6f:	7f 10                	jg     800d81 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	0f be c0             	movsbl %al,%eax
  800d79:	83 e8 57             	sub    $0x57,%eax
  800d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d7f:	eb 20                	jmp    800da1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	3c 40                	cmp    $0x40,%al
  800d88:	7e 39                	jle    800dc3 <strtol+0x126>
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8a 00                	mov    (%eax),%al
  800d8f:	3c 5a                	cmp    $0x5a,%al
  800d91:	7f 30                	jg     800dc3 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	0f be c0             	movsbl %al,%eax
  800d9b:	83 e8 37             	sub    $0x37,%eax
  800d9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800da1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da4:	3b 45 10             	cmp    0x10(%ebp),%eax
  800da7:	7d 19                	jge    800dc2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800da9:	ff 45 08             	incl   0x8(%ebp)
  800dac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800daf:	0f af 45 10          	imul   0x10(%ebp),%eax
  800db3:	89 c2                	mov    %eax,%edx
  800db5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800db8:	01 d0                	add    %edx,%eax
  800dba:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dbd:	e9 7b ff ff ff       	jmp    800d3d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dc2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dc3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dc7:	74 08                	je     800dd1 <strtol+0x134>
		*endptr = (char *) s;
  800dc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcc:	8b 55 08             	mov    0x8(%ebp),%edx
  800dcf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dd5:	74 07                	je     800dde <strtol+0x141>
  800dd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dda:	f7 d8                	neg    %eax
  800ddc:	eb 03                	jmp    800de1 <strtol+0x144>
  800dde:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800de1:	c9                   	leave  
  800de2:	c3                   	ret    

00800de3 <ltostr>:

void
ltostr(long value, char *str)
{
  800de3:	55                   	push   %ebp
  800de4:	89 e5                	mov    %esp,%ebp
  800de6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800de9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800df0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800df7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dfb:	79 13                	jns    800e10 <ltostr+0x2d>
	{
		neg = 1;
  800dfd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e07:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e0a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e0d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e18:	99                   	cltd   
  800e19:	f7 f9                	idiv   %ecx
  800e1b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e21:	8d 50 01             	lea    0x1(%eax),%edx
  800e24:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e27:	89 c2                	mov    %eax,%edx
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	01 d0                	add    %edx,%eax
  800e2e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e31:	83 c2 30             	add    $0x30,%edx
  800e34:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e39:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e3e:	f7 e9                	imul   %ecx
  800e40:	c1 fa 02             	sar    $0x2,%edx
  800e43:	89 c8                	mov    %ecx,%eax
  800e45:	c1 f8 1f             	sar    $0x1f,%eax
  800e48:	29 c2                	sub    %eax,%edx
  800e4a:	89 d0                	mov    %edx,%eax
  800e4c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e52:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e57:	f7 e9                	imul   %ecx
  800e59:	c1 fa 02             	sar    $0x2,%edx
  800e5c:	89 c8                	mov    %ecx,%eax
  800e5e:	c1 f8 1f             	sar    $0x1f,%eax
  800e61:	29 c2                	sub    %eax,%edx
  800e63:	89 d0                	mov    %edx,%eax
  800e65:	c1 e0 02             	shl    $0x2,%eax
  800e68:	01 d0                	add    %edx,%eax
  800e6a:	01 c0                	add    %eax,%eax
  800e6c:	29 c1                	sub    %eax,%ecx
  800e6e:	89 ca                	mov    %ecx,%edx
  800e70:	85 d2                	test   %edx,%edx
  800e72:	75 9c                	jne    800e10 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7e:	48                   	dec    %eax
  800e7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e82:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e86:	74 3d                	je     800ec5 <ltostr+0xe2>
		start = 1 ;
  800e88:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e8f:	eb 34                	jmp    800ec5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e97:	01 d0                	add    %edx,%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea4:	01 c2                	add    %eax,%edx
  800ea6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eac:	01 c8                	add    %ecx,%eax
  800eae:	8a 00                	mov    (%eax),%al
  800eb0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800eb2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb8:	01 c2                	add    %eax,%edx
  800eba:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ebd:	88 02                	mov    %al,(%edx)
		start++ ;
  800ebf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ec2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ec5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ec8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ecb:	7c c4                	jl     800e91 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ecd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ed0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed3:	01 d0                	add    %edx,%eax
  800ed5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ed8:	90                   	nop
  800ed9:	c9                   	leave  
  800eda:	c3                   	ret    

00800edb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800edb:	55                   	push   %ebp
  800edc:	89 e5                	mov    %esp,%ebp
  800ede:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ee1:	ff 75 08             	pushl  0x8(%ebp)
  800ee4:	e8 54 fa ff ff       	call   80093d <strlen>
  800ee9:	83 c4 04             	add    $0x4,%esp
  800eec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eef:	ff 75 0c             	pushl  0xc(%ebp)
  800ef2:	e8 46 fa ff ff       	call   80093d <strlen>
  800ef7:	83 c4 04             	add    $0x4,%esp
  800efa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800efd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f0b:	eb 17                	jmp    800f24 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f10:	8b 45 10             	mov    0x10(%ebp),%eax
  800f13:	01 c2                	add    %eax,%edx
  800f15:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	01 c8                	add    %ecx,%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f21:	ff 45 fc             	incl   -0x4(%ebp)
  800f24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f27:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f2a:	7c e1                	jl     800f0d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f2c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f33:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f3a:	eb 1f                	jmp    800f5b <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f3f:	8d 50 01             	lea    0x1(%eax),%edx
  800f42:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f45:	89 c2                	mov    %eax,%edx
  800f47:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4a:	01 c2                	add    %eax,%edx
  800f4c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f52:	01 c8                	add    %ecx,%eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f58:	ff 45 f8             	incl   -0x8(%ebp)
  800f5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f5e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f61:	7c d9                	jl     800f3c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f63:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f66:	8b 45 10             	mov    0x10(%ebp),%eax
  800f69:	01 d0                	add    %edx,%eax
  800f6b:	c6 00 00             	movb   $0x0,(%eax)
}
  800f6e:	90                   	nop
  800f6f:	c9                   	leave  
  800f70:	c3                   	ret    

00800f71 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f71:	55                   	push   %ebp
  800f72:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f74:	8b 45 14             	mov    0x14(%ebp),%eax
  800f77:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f80:	8b 00                	mov    (%eax),%eax
  800f82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f89:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8c:	01 d0                	add    %edx,%eax
  800f8e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f94:	eb 0c                	jmp    800fa2 <strsplit+0x31>
			*string++ = 0;
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8d 50 01             	lea    0x1(%eax),%edx
  800f9c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f9f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	8a 00                	mov    (%eax),%al
  800fa7:	84 c0                	test   %al,%al
  800fa9:	74 18                	je     800fc3 <strsplit+0x52>
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	0f be c0             	movsbl %al,%eax
  800fb3:	50                   	push   %eax
  800fb4:	ff 75 0c             	pushl  0xc(%ebp)
  800fb7:	e8 13 fb ff ff       	call   800acf <strchr>
  800fbc:	83 c4 08             	add    $0x8,%esp
  800fbf:	85 c0                	test   %eax,%eax
  800fc1:	75 d3                	jne    800f96 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	84 c0                	test   %al,%al
  800fca:	74 5a                	je     801026 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fcc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcf:	8b 00                	mov    (%eax),%eax
  800fd1:	83 f8 0f             	cmp    $0xf,%eax
  800fd4:	75 07                	jne    800fdd <strsplit+0x6c>
		{
			return 0;
  800fd6:	b8 00 00 00 00       	mov    $0x0,%eax
  800fdb:	eb 66                	jmp    801043 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe0:	8b 00                	mov    (%eax),%eax
  800fe2:	8d 48 01             	lea    0x1(%eax),%ecx
  800fe5:	8b 55 14             	mov    0x14(%ebp),%edx
  800fe8:	89 0a                	mov    %ecx,(%edx)
  800fea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff4:	01 c2                	add    %eax,%edx
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ffb:	eb 03                	jmp    801000 <strsplit+0x8f>
			string++;
  800ffd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801000:	8b 45 08             	mov    0x8(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	84 c0                	test   %al,%al
  801007:	74 8b                	je     800f94 <strsplit+0x23>
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	8a 00                	mov    (%eax),%al
  80100e:	0f be c0             	movsbl %al,%eax
  801011:	50                   	push   %eax
  801012:	ff 75 0c             	pushl  0xc(%ebp)
  801015:	e8 b5 fa ff ff       	call   800acf <strchr>
  80101a:	83 c4 08             	add    $0x8,%esp
  80101d:	85 c0                	test   %eax,%eax
  80101f:	74 dc                	je     800ffd <strsplit+0x8c>
			string++;
	}
  801021:	e9 6e ff ff ff       	jmp    800f94 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801026:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801027:	8b 45 14             	mov    0x14(%ebp),%eax
  80102a:	8b 00                	mov    (%eax),%eax
  80102c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801033:	8b 45 10             	mov    0x10(%ebp),%eax
  801036:	01 d0                	add    %edx,%eax
  801038:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80103e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801043:	c9                   	leave  
  801044:	c3                   	ret    

00801045 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801045:	55                   	push   %ebp
  801046:	89 e5                	mov    %esp,%ebp
  801048:	57                   	push   %edi
  801049:	56                   	push   %esi
  80104a:	53                   	push   %ebx
  80104b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	8b 55 0c             	mov    0xc(%ebp),%edx
  801054:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801057:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80105a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80105d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801060:	cd 30                	int    $0x30
  801062:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801065:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801068:	83 c4 10             	add    $0x10,%esp
  80106b:	5b                   	pop    %ebx
  80106c:	5e                   	pop    %esi
  80106d:	5f                   	pop    %edi
  80106e:	5d                   	pop    %ebp
  80106f:	c3                   	ret    

00801070 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
  801073:	83 ec 04             	sub    $0x4,%esp
  801076:	8b 45 10             	mov    0x10(%ebp),%eax
  801079:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80107c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	6a 00                	push   $0x0
  801085:	6a 00                	push   $0x0
  801087:	52                   	push   %edx
  801088:	ff 75 0c             	pushl  0xc(%ebp)
  80108b:	50                   	push   %eax
  80108c:	6a 00                	push   $0x0
  80108e:	e8 b2 ff ff ff       	call   801045 <syscall>
  801093:	83 c4 18             	add    $0x18,%esp
}
  801096:	90                   	nop
  801097:	c9                   	leave  
  801098:	c3                   	ret    

00801099 <sys_cgetc>:

int
sys_cgetc(void)
{
  801099:	55                   	push   %ebp
  80109a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80109c:	6a 00                	push   $0x0
  80109e:	6a 00                	push   $0x0
  8010a0:	6a 00                	push   $0x0
  8010a2:	6a 00                	push   $0x0
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 01                	push   $0x1
  8010a8:	e8 98 ff ff ff       	call   801045 <syscall>
  8010ad:	83 c4 18             	add    $0x18,%esp
}
  8010b0:	c9                   	leave  
  8010b1:	c3                   	ret    

008010b2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 00                	push   $0x0
  8010bc:	6a 00                	push   $0x0
  8010be:	6a 00                	push   $0x0
  8010c0:	50                   	push   %eax
  8010c1:	6a 05                	push   $0x5
  8010c3:	e8 7d ff ff ff       	call   801045 <syscall>
  8010c8:	83 c4 18             	add    $0x18,%esp
}
  8010cb:	c9                   	leave  
  8010cc:	c3                   	ret    

008010cd <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010cd:	55                   	push   %ebp
  8010ce:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010d0:	6a 00                	push   $0x0
  8010d2:	6a 00                	push   $0x0
  8010d4:	6a 00                	push   $0x0
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 02                	push   $0x2
  8010dc:	e8 64 ff ff ff       	call   801045 <syscall>
  8010e1:	83 c4 18             	add    $0x18,%esp
}
  8010e4:	c9                   	leave  
  8010e5:	c3                   	ret    

008010e6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010e6:	55                   	push   %ebp
  8010e7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010e9:	6a 00                	push   $0x0
  8010eb:	6a 00                	push   $0x0
  8010ed:	6a 00                	push   $0x0
  8010ef:	6a 00                	push   $0x0
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 03                	push   $0x3
  8010f5:	e8 4b ff ff ff       	call   801045 <syscall>
  8010fa:	83 c4 18             	add    $0x18,%esp
}
  8010fd:	c9                   	leave  
  8010fe:	c3                   	ret    

008010ff <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010ff:	55                   	push   %ebp
  801100:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801102:	6a 00                	push   $0x0
  801104:	6a 00                	push   $0x0
  801106:	6a 00                	push   $0x0
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 04                	push   $0x4
  80110e:	e8 32 ff ff ff       	call   801045 <syscall>
  801113:	83 c4 18             	add    $0x18,%esp
}
  801116:	c9                   	leave  
  801117:	c3                   	ret    

00801118 <sys_env_exit>:


void sys_env_exit(void)
{
  801118:	55                   	push   %ebp
  801119:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	6a 00                	push   $0x0
  801121:	6a 00                	push   $0x0
  801123:	6a 00                	push   $0x0
  801125:	6a 06                	push   $0x6
  801127:	e8 19 ff ff ff       	call   801045 <syscall>
  80112c:	83 c4 18             	add    $0x18,%esp
}
  80112f:	90                   	nop
  801130:	c9                   	leave  
  801131:	c3                   	ret    

00801132 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801132:	55                   	push   %ebp
  801133:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801135:	8b 55 0c             	mov    0xc(%ebp),%edx
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	6a 00                	push   $0x0
  80113d:	6a 00                	push   $0x0
  80113f:	6a 00                	push   $0x0
  801141:	52                   	push   %edx
  801142:	50                   	push   %eax
  801143:	6a 07                	push   $0x7
  801145:	e8 fb fe ff ff       	call   801045 <syscall>
  80114a:	83 c4 18             	add    $0x18,%esp
}
  80114d:	c9                   	leave  
  80114e:	c3                   	ret    

0080114f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
  801152:	56                   	push   %esi
  801153:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801154:	8b 75 18             	mov    0x18(%ebp),%esi
  801157:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80115a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80115d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801160:	8b 45 08             	mov    0x8(%ebp),%eax
  801163:	56                   	push   %esi
  801164:	53                   	push   %ebx
  801165:	51                   	push   %ecx
  801166:	52                   	push   %edx
  801167:	50                   	push   %eax
  801168:	6a 08                	push   $0x8
  80116a:	e8 d6 fe ff ff       	call   801045 <syscall>
  80116f:	83 c4 18             	add    $0x18,%esp
}
  801172:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801175:	5b                   	pop    %ebx
  801176:	5e                   	pop    %esi
  801177:	5d                   	pop    %ebp
  801178:	c3                   	ret    

00801179 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801179:	55                   	push   %ebp
  80117a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80117c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	6a 00                	push   $0x0
  801184:	6a 00                	push   $0x0
  801186:	6a 00                	push   $0x0
  801188:	52                   	push   %edx
  801189:	50                   	push   %eax
  80118a:	6a 09                	push   $0x9
  80118c:	e8 b4 fe ff ff       	call   801045 <syscall>
  801191:	83 c4 18             	add    $0x18,%esp
}
  801194:	c9                   	leave  
  801195:	c3                   	ret    

00801196 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801196:	55                   	push   %ebp
  801197:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801199:	6a 00                	push   $0x0
  80119b:	6a 00                	push   $0x0
  80119d:	6a 00                	push   $0x0
  80119f:	ff 75 0c             	pushl  0xc(%ebp)
  8011a2:	ff 75 08             	pushl  0x8(%ebp)
  8011a5:	6a 0a                	push   $0xa
  8011a7:	e8 99 fe ff ff       	call   801045 <syscall>
  8011ac:	83 c4 18             	add    $0x18,%esp
}
  8011af:	c9                   	leave  
  8011b0:	c3                   	ret    

008011b1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011b4:	6a 00                	push   $0x0
  8011b6:	6a 00                	push   $0x0
  8011b8:	6a 00                	push   $0x0
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 0b                	push   $0xb
  8011c0:	e8 80 fe ff ff       	call   801045 <syscall>
  8011c5:	83 c4 18             	add    $0x18,%esp
}
  8011c8:	c9                   	leave  
  8011c9:	c3                   	ret    

008011ca <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011ca:	55                   	push   %ebp
  8011cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011cd:	6a 00                	push   $0x0
  8011cf:	6a 00                	push   $0x0
  8011d1:	6a 00                	push   $0x0
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 0c                	push   $0xc
  8011d9:	e8 67 fe ff ff       	call   801045 <syscall>
  8011de:	83 c4 18             	add    $0x18,%esp
}
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011e6:	6a 00                	push   $0x0
  8011e8:	6a 00                	push   $0x0
  8011ea:	6a 00                	push   $0x0
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 0d                	push   $0xd
  8011f2:	e8 4e fe ff ff       	call   801045 <syscall>
  8011f7:	83 c4 18             	add    $0x18,%esp
}
  8011fa:	c9                   	leave  
  8011fb:	c3                   	ret    

008011fc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011fc:	55                   	push   %ebp
  8011fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	ff 75 0c             	pushl  0xc(%ebp)
  801208:	ff 75 08             	pushl  0x8(%ebp)
  80120b:	6a 11                	push   $0x11
  80120d:	e8 33 fe ff ff       	call   801045 <syscall>
  801212:	83 c4 18             	add    $0x18,%esp
	return;
  801215:	90                   	nop
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	ff 75 0c             	pushl  0xc(%ebp)
  801224:	ff 75 08             	pushl  0x8(%ebp)
  801227:	6a 12                	push   $0x12
  801229:	e8 17 fe ff ff       	call   801045 <syscall>
  80122e:	83 c4 18             	add    $0x18,%esp
	return ;
  801231:	90                   	nop
}
  801232:	c9                   	leave  
  801233:	c3                   	ret    

00801234 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801234:	55                   	push   %ebp
  801235:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 0e                	push   $0xe
  801243:	e8 fd fd ff ff       	call   801045 <syscall>
  801248:	83 c4 18             	add    $0x18,%esp
}
  80124b:	c9                   	leave  
  80124c:	c3                   	ret    

0080124d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80124d:	55                   	push   %ebp
  80124e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 00                	push   $0x0
  801256:	6a 00                	push   $0x0
  801258:	ff 75 08             	pushl  0x8(%ebp)
  80125b:	6a 0f                	push   $0xf
  80125d:	e8 e3 fd ff ff       	call   801045 <syscall>
  801262:	83 c4 18             	add    $0x18,%esp
}
  801265:	c9                   	leave  
  801266:	c3                   	ret    

00801267 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801267:	55                   	push   %ebp
  801268:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	6a 00                	push   $0x0
  801274:	6a 10                	push   $0x10
  801276:	e8 ca fd ff ff       	call   801045 <syscall>
  80127b:	83 c4 18             	add    $0x18,%esp
}
  80127e:	90                   	nop
  80127f:	c9                   	leave  
  801280:	c3                   	ret    

00801281 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801281:	55                   	push   %ebp
  801282:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 14                	push   $0x14
  801290:	e8 b0 fd ff ff       	call   801045 <syscall>
  801295:	83 c4 18             	add    $0x18,%esp
}
  801298:	90                   	nop
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 15                	push   $0x15
  8012aa:	e8 96 fd ff ff       	call   801045 <syscall>
  8012af:	83 c4 18             	add    $0x18,%esp
}
  8012b2:	90                   	nop
  8012b3:	c9                   	leave  
  8012b4:	c3                   	ret    

008012b5 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	83 ec 04             	sub    $0x4,%esp
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012c1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	50                   	push   %eax
  8012ce:	6a 16                	push   $0x16
  8012d0:	e8 70 fd ff ff       	call   801045 <syscall>
  8012d5:	83 c4 18             	add    $0x18,%esp
}
  8012d8:	90                   	nop
  8012d9:	c9                   	leave  
  8012da:	c3                   	ret    

008012db <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012db:	55                   	push   %ebp
  8012dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 17                	push   $0x17
  8012ea:	e8 56 fd ff ff       	call   801045 <syscall>
  8012ef:	83 c4 18             	add    $0x18,%esp
}
  8012f2:	90                   	nop
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	ff 75 0c             	pushl  0xc(%ebp)
  801304:	50                   	push   %eax
  801305:	6a 18                	push   $0x18
  801307:	e8 39 fd ff ff       	call   801045 <syscall>
  80130c:	83 c4 18             	add    $0x18,%esp
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801314:	8b 55 0c             	mov    0xc(%ebp),%edx
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	52                   	push   %edx
  801321:	50                   	push   %eax
  801322:	6a 1b                	push   $0x1b
  801324:	e8 1c fd ff ff       	call   801045 <syscall>
  801329:	83 c4 18             	add    $0x18,%esp
}
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801331:	8b 55 0c             	mov    0xc(%ebp),%edx
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	52                   	push   %edx
  80133e:	50                   	push   %eax
  80133f:	6a 19                	push   $0x19
  801341:	e8 ff fc ff ff       	call   801045 <syscall>
  801346:	83 c4 18             	add    $0x18,%esp
}
  801349:	90                   	nop
  80134a:	c9                   	leave  
  80134b:	c3                   	ret    

0080134c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80134f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 00                	push   $0x0
  80135b:	52                   	push   %edx
  80135c:	50                   	push   %eax
  80135d:	6a 1a                	push   $0x1a
  80135f:	e8 e1 fc ff ff       	call   801045 <syscall>
  801364:	83 c4 18             	add    $0x18,%esp
}
  801367:	90                   	nop
  801368:	c9                   	leave  
  801369:	c3                   	ret    

0080136a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80136a:	55                   	push   %ebp
  80136b:	89 e5                	mov    %esp,%ebp
  80136d:	83 ec 04             	sub    $0x4,%esp
  801370:	8b 45 10             	mov    0x10(%ebp),%eax
  801373:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801376:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801379:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	6a 00                	push   $0x0
  801382:	51                   	push   %ecx
  801383:	52                   	push   %edx
  801384:	ff 75 0c             	pushl  0xc(%ebp)
  801387:	50                   	push   %eax
  801388:	6a 1c                	push   $0x1c
  80138a:	e8 b6 fc ff ff       	call   801045 <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801397:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	52                   	push   %edx
  8013a4:	50                   	push   %eax
  8013a5:	6a 1d                	push   $0x1d
  8013a7:	e8 99 fc ff ff       	call   801045 <syscall>
  8013ac:	83 c4 18             	add    $0x18,%esp
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	51                   	push   %ecx
  8013c2:	52                   	push   %edx
  8013c3:	50                   	push   %eax
  8013c4:	6a 1e                	push   $0x1e
  8013c6:	e8 7a fc ff ff       	call   801045 <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	52                   	push   %edx
  8013e0:	50                   	push   %eax
  8013e1:	6a 1f                	push   $0x1f
  8013e3:	e8 5d fc ff ff       	call   801045 <syscall>
  8013e8:	83 c4 18             	add    $0x18,%esp
}
  8013eb:	c9                   	leave  
  8013ec:	c3                   	ret    

008013ed <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 20                	push   $0x20
  8013fc:	e8 44 fc ff ff       	call   801045 <syscall>
  801401:	83 c4 18             	add    $0x18,%esp
}
  801404:	c9                   	leave  
  801405:	c3                   	ret    

00801406 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801406:	55                   	push   %ebp
  801407:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	6a 00                	push   $0x0
  80140e:	ff 75 14             	pushl  0x14(%ebp)
  801411:	ff 75 10             	pushl  0x10(%ebp)
  801414:	ff 75 0c             	pushl  0xc(%ebp)
  801417:	50                   	push   %eax
  801418:	6a 21                	push   $0x21
  80141a:	e8 26 fc ff ff       	call   801045 <syscall>
  80141f:	83 c4 18             	add    $0x18,%esp
}
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	50                   	push   %eax
  801433:	6a 22                	push   $0x22
  801435:	e8 0b fc ff ff       	call   801045 <syscall>
  80143a:	83 c4 18             	add    $0x18,%esp
}
  80143d:	90                   	nop
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	50                   	push   %eax
  80144f:	6a 23                	push   $0x23
  801451:	e8 ef fb ff ff       	call   801045 <syscall>
  801456:	83 c4 18             	add    $0x18,%esp
}
  801459:	90                   	nop
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
  80145f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801462:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801465:	8d 50 04             	lea    0x4(%eax),%edx
  801468:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	52                   	push   %edx
  801472:	50                   	push   %eax
  801473:	6a 24                	push   $0x24
  801475:	e8 cb fb ff ff       	call   801045 <syscall>
  80147a:	83 c4 18             	add    $0x18,%esp
	return result;
  80147d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801480:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801483:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801486:	89 01                	mov    %eax,(%ecx)
  801488:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	c9                   	leave  
  80148f:	c2 04 00             	ret    $0x4

00801492 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	ff 75 10             	pushl  0x10(%ebp)
  80149c:	ff 75 0c             	pushl  0xc(%ebp)
  80149f:	ff 75 08             	pushl  0x8(%ebp)
  8014a2:	6a 13                	push   $0x13
  8014a4:	e8 9c fb ff ff       	call   801045 <syscall>
  8014a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ac:	90                   	nop
}
  8014ad:	c9                   	leave  
  8014ae:	c3                   	ret    

008014af <sys_rcr2>:
uint32 sys_rcr2()
{
  8014af:	55                   	push   %ebp
  8014b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 25                	push   $0x25
  8014be:	e8 82 fb ff ff       	call   801045 <syscall>
  8014c3:	83 c4 18             	add    $0x18,%esp
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 04             	sub    $0x4,%esp
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014d4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	50                   	push   %eax
  8014e1:	6a 26                	push   $0x26
  8014e3:	e8 5d fb ff ff       	call   801045 <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014eb:	90                   	nop
}
  8014ec:	c9                   	leave  
  8014ed:	c3                   	ret    

008014ee <rsttst>:
void rsttst()
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 28                	push   $0x28
  8014fd:	e8 43 fb ff ff       	call   801045 <syscall>
  801502:	83 c4 18             	add    $0x18,%esp
	return ;
  801505:	90                   	nop
}
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
  80150b:	83 ec 04             	sub    $0x4,%esp
  80150e:	8b 45 14             	mov    0x14(%ebp),%eax
  801511:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801514:	8b 55 18             	mov    0x18(%ebp),%edx
  801517:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80151b:	52                   	push   %edx
  80151c:	50                   	push   %eax
  80151d:	ff 75 10             	pushl  0x10(%ebp)
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	ff 75 08             	pushl  0x8(%ebp)
  801526:	6a 27                	push   $0x27
  801528:	e8 18 fb ff ff       	call   801045 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
	return ;
  801530:	90                   	nop
}
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <chktst>:
void chktst(uint32 n)
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	ff 75 08             	pushl  0x8(%ebp)
  801541:	6a 29                	push   $0x29
  801543:	e8 fd fa ff ff       	call   801045 <syscall>
  801548:	83 c4 18             	add    $0x18,%esp
	return ;
  80154b:	90                   	nop
}
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <inctst>:

void inctst()
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 2a                	push   $0x2a
  80155d:	e8 e3 fa ff ff       	call   801045 <syscall>
  801562:	83 c4 18             	add    $0x18,%esp
	return ;
  801565:	90                   	nop
}
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <gettst>:
uint32 gettst()
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 2b                	push   $0x2b
  801577:	e8 c9 fa ff ff       	call   801045 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 2c                	push   $0x2c
  801593:	e8 ad fa ff ff       	call   801045 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
  80159b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80159e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015a2:	75 07                	jne    8015ab <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015a4:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a9:	eb 05                	jmp    8015b0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
  8015b5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 2c                	push   $0x2c
  8015c4:	e8 7c fa ff ff       	call   801045 <syscall>
  8015c9:	83 c4 18             	add    $0x18,%esp
  8015cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015cf:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015d3:	75 07                	jne    8015dc <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015da:	eb 05                	jmp    8015e1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 2c                	push   $0x2c
  8015f5:	e8 4b fa ff ff       	call   801045 <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
  8015fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801600:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801604:	75 07                	jne    80160d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801606:	b8 01 00 00 00       	mov    $0x1,%eax
  80160b:	eb 05                	jmp    801612 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80160d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801612:	c9                   	leave  
  801613:	c3                   	ret    

00801614 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
  801617:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 2c                	push   $0x2c
  801626:	e8 1a fa ff ff       	call   801045 <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
  80162e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801631:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801635:	75 07                	jne    80163e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801637:	b8 01 00 00 00       	mov    $0x1,%eax
  80163c:	eb 05                	jmp    801643 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80163e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	ff 75 08             	pushl  0x8(%ebp)
  801653:	6a 2d                	push   $0x2d
  801655:	e8 eb f9 ff ff       	call   801045 <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
	return ;
  80165d:	90                   	nop
}
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
  801663:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801664:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801667:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80166a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	6a 00                	push   $0x0
  801672:	53                   	push   %ebx
  801673:	51                   	push   %ecx
  801674:	52                   	push   %edx
  801675:	50                   	push   %eax
  801676:	6a 2e                	push   $0x2e
  801678:	e8 c8 f9 ff ff       	call   801045 <syscall>
  80167d:	83 c4 18             	add    $0x18,%esp
}
  801680:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801688:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	52                   	push   %edx
  801695:	50                   	push   %eax
  801696:	6a 2f                	push   $0x2f
  801698:	e8 a8 f9 ff ff       	call   801045 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    
  8016a2:	66 90                	xchg   %ax,%ax

008016a4 <__udivdi3>:
  8016a4:	55                   	push   %ebp
  8016a5:	57                   	push   %edi
  8016a6:	56                   	push   %esi
  8016a7:	53                   	push   %ebx
  8016a8:	83 ec 1c             	sub    $0x1c,%esp
  8016ab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016af:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016bb:	89 ca                	mov    %ecx,%edx
  8016bd:	89 f8                	mov    %edi,%eax
  8016bf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016c3:	85 f6                	test   %esi,%esi
  8016c5:	75 2d                	jne    8016f4 <__udivdi3+0x50>
  8016c7:	39 cf                	cmp    %ecx,%edi
  8016c9:	77 65                	ja     801730 <__udivdi3+0x8c>
  8016cb:	89 fd                	mov    %edi,%ebp
  8016cd:	85 ff                	test   %edi,%edi
  8016cf:	75 0b                	jne    8016dc <__udivdi3+0x38>
  8016d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d6:	31 d2                	xor    %edx,%edx
  8016d8:	f7 f7                	div    %edi
  8016da:	89 c5                	mov    %eax,%ebp
  8016dc:	31 d2                	xor    %edx,%edx
  8016de:	89 c8                	mov    %ecx,%eax
  8016e0:	f7 f5                	div    %ebp
  8016e2:	89 c1                	mov    %eax,%ecx
  8016e4:	89 d8                	mov    %ebx,%eax
  8016e6:	f7 f5                	div    %ebp
  8016e8:	89 cf                	mov    %ecx,%edi
  8016ea:	89 fa                	mov    %edi,%edx
  8016ec:	83 c4 1c             	add    $0x1c,%esp
  8016ef:	5b                   	pop    %ebx
  8016f0:	5e                   	pop    %esi
  8016f1:	5f                   	pop    %edi
  8016f2:	5d                   	pop    %ebp
  8016f3:	c3                   	ret    
  8016f4:	39 ce                	cmp    %ecx,%esi
  8016f6:	77 28                	ja     801720 <__udivdi3+0x7c>
  8016f8:	0f bd fe             	bsr    %esi,%edi
  8016fb:	83 f7 1f             	xor    $0x1f,%edi
  8016fe:	75 40                	jne    801740 <__udivdi3+0x9c>
  801700:	39 ce                	cmp    %ecx,%esi
  801702:	72 0a                	jb     80170e <__udivdi3+0x6a>
  801704:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801708:	0f 87 9e 00 00 00    	ja     8017ac <__udivdi3+0x108>
  80170e:	b8 01 00 00 00       	mov    $0x1,%eax
  801713:	89 fa                	mov    %edi,%edx
  801715:	83 c4 1c             	add    $0x1c,%esp
  801718:	5b                   	pop    %ebx
  801719:	5e                   	pop    %esi
  80171a:	5f                   	pop    %edi
  80171b:	5d                   	pop    %ebp
  80171c:	c3                   	ret    
  80171d:	8d 76 00             	lea    0x0(%esi),%esi
  801720:	31 ff                	xor    %edi,%edi
  801722:	31 c0                	xor    %eax,%eax
  801724:	89 fa                	mov    %edi,%edx
  801726:	83 c4 1c             	add    $0x1c,%esp
  801729:	5b                   	pop    %ebx
  80172a:	5e                   	pop    %esi
  80172b:	5f                   	pop    %edi
  80172c:	5d                   	pop    %ebp
  80172d:	c3                   	ret    
  80172e:	66 90                	xchg   %ax,%ax
  801730:	89 d8                	mov    %ebx,%eax
  801732:	f7 f7                	div    %edi
  801734:	31 ff                	xor    %edi,%edi
  801736:	89 fa                	mov    %edi,%edx
  801738:	83 c4 1c             	add    $0x1c,%esp
  80173b:	5b                   	pop    %ebx
  80173c:	5e                   	pop    %esi
  80173d:	5f                   	pop    %edi
  80173e:	5d                   	pop    %ebp
  80173f:	c3                   	ret    
  801740:	bd 20 00 00 00       	mov    $0x20,%ebp
  801745:	89 eb                	mov    %ebp,%ebx
  801747:	29 fb                	sub    %edi,%ebx
  801749:	89 f9                	mov    %edi,%ecx
  80174b:	d3 e6                	shl    %cl,%esi
  80174d:	89 c5                	mov    %eax,%ebp
  80174f:	88 d9                	mov    %bl,%cl
  801751:	d3 ed                	shr    %cl,%ebp
  801753:	89 e9                	mov    %ebp,%ecx
  801755:	09 f1                	or     %esi,%ecx
  801757:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80175b:	89 f9                	mov    %edi,%ecx
  80175d:	d3 e0                	shl    %cl,%eax
  80175f:	89 c5                	mov    %eax,%ebp
  801761:	89 d6                	mov    %edx,%esi
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 ee                	shr    %cl,%esi
  801767:	89 f9                	mov    %edi,%ecx
  801769:	d3 e2                	shl    %cl,%edx
  80176b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80176f:	88 d9                	mov    %bl,%cl
  801771:	d3 e8                	shr    %cl,%eax
  801773:	09 c2                	or     %eax,%edx
  801775:	89 d0                	mov    %edx,%eax
  801777:	89 f2                	mov    %esi,%edx
  801779:	f7 74 24 0c          	divl   0xc(%esp)
  80177d:	89 d6                	mov    %edx,%esi
  80177f:	89 c3                	mov    %eax,%ebx
  801781:	f7 e5                	mul    %ebp
  801783:	39 d6                	cmp    %edx,%esi
  801785:	72 19                	jb     8017a0 <__udivdi3+0xfc>
  801787:	74 0b                	je     801794 <__udivdi3+0xf0>
  801789:	89 d8                	mov    %ebx,%eax
  80178b:	31 ff                	xor    %edi,%edi
  80178d:	e9 58 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  801792:	66 90                	xchg   %ax,%ax
  801794:	8b 54 24 08          	mov    0x8(%esp),%edx
  801798:	89 f9                	mov    %edi,%ecx
  80179a:	d3 e2                	shl    %cl,%edx
  80179c:	39 c2                	cmp    %eax,%edx
  80179e:	73 e9                	jae    801789 <__udivdi3+0xe5>
  8017a0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017a3:	31 ff                	xor    %edi,%edi
  8017a5:	e9 40 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  8017aa:	66 90                	xchg   %ax,%ax
  8017ac:	31 c0                	xor    %eax,%eax
  8017ae:	e9 37 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  8017b3:	90                   	nop

008017b4 <__umoddi3>:
  8017b4:	55                   	push   %ebp
  8017b5:	57                   	push   %edi
  8017b6:	56                   	push   %esi
  8017b7:	53                   	push   %ebx
  8017b8:	83 ec 1c             	sub    $0x1c,%esp
  8017bb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017bf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017c7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017cf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017d3:	89 f3                	mov    %esi,%ebx
  8017d5:	89 fa                	mov    %edi,%edx
  8017d7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017db:	89 34 24             	mov    %esi,(%esp)
  8017de:	85 c0                	test   %eax,%eax
  8017e0:	75 1a                	jne    8017fc <__umoddi3+0x48>
  8017e2:	39 f7                	cmp    %esi,%edi
  8017e4:	0f 86 a2 00 00 00    	jbe    80188c <__umoddi3+0xd8>
  8017ea:	89 c8                	mov    %ecx,%eax
  8017ec:	89 f2                	mov    %esi,%edx
  8017ee:	f7 f7                	div    %edi
  8017f0:	89 d0                	mov    %edx,%eax
  8017f2:	31 d2                	xor    %edx,%edx
  8017f4:	83 c4 1c             	add    $0x1c,%esp
  8017f7:	5b                   	pop    %ebx
  8017f8:	5e                   	pop    %esi
  8017f9:	5f                   	pop    %edi
  8017fa:	5d                   	pop    %ebp
  8017fb:	c3                   	ret    
  8017fc:	39 f0                	cmp    %esi,%eax
  8017fe:	0f 87 ac 00 00 00    	ja     8018b0 <__umoddi3+0xfc>
  801804:	0f bd e8             	bsr    %eax,%ebp
  801807:	83 f5 1f             	xor    $0x1f,%ebp
  80180a:	0f 84 ac 00 00 00    	je     8018bc <__umoddi3+0x108>
  801810:	bf 20 00 00 00       	mov    $0x20,%edi
  801815:	29 ef                	sub    %ebp,%edi
  801817:	89 fe                	mov    %edi,%esi
  801819:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80181d:	89 e9                	mov    %ebp,%ecx
  80181f:	d3 e0                	shl    %cl,%eax
  801821:	89 d7                	mov    %edx,%edi
  801823:	89 f1                	mov    %esi,%ecx
  801825:	d3 ef                	shr    %cl,%edi
  801827:	09 c7                	or     %eax,%edi
  801829:	89 e9                	mov    %ebp,%ecx
  80182b:	d3 e2                	shl    %cl,%edx
  80182d:	89 14 24             	mov    %edx,(%esp)
  801830:	89 d8                	mov    %ebx,%eax
  801832:	d3 e0                	shl    %cl,%eax
  801834:	89 c2                	mov    %eax,%edx
  801836:	8b 44 24 08          	mov    0x8(%esp),%eax
  80183a:	d3 e0                	shl    %cl,%eax
  80183c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801840:	8b 44 24 08          	mov    0x8(%esp),%eax
  801844:	89 f1                	mov    %esi,%ecx
  801846:	d3 e8                	shr    %cl,%eax
  801848:	09 d0                	or     %edx,%eax
  80184a:	d3 eb                	shr    %cl,%ebx
  80184c:	89 da                	mov    %ebx,%edx
  80184e:	f7 f7                	div    %edi
  801850:	89 d3                	mov    %edx,%ebx
  801852:	f7 24 24             	mull   (%esp)
  801855:	89 c6                	mov    %eax,%esi
  801857:	89 d1                	mov    %edx,%ecx
  801859:	39 d3                	cmp    %edx,%ebx
  80185b:	0f 82 87 00 00 00    	jb     8018e8 <__umoddi3+0x134>
  801861:	0f 84 91 00 00 00    	je     8018f8 <__umoddi3+0x144>
  801867:	8b 54 24 04          	mov    0x4(%esp),%edx
  80186b:	29 f2                	sub    %esi,%edx
  80186d:	19 cb                	sbb    %ecx,%ebx
  80186f:	89 d8                	mov    %ebx,%eax
  801871:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801875:	d3 e0                	shl    %cl,%eax
  801877:	89 e9                	mov    %ebp,%ecx
  801879:	d3 ea                	shr    %cl,%edx
  80187b:	09 d0                	or     %edx,%eax
  80187d:	89 e9                	mov    %ebp,%ecx
  80187f:	d3 eb                	shr    %cl,%ebx
  801881:	89 da                	mov    %ebx,%edx
  801883:	83 c4 1c             	add    $0x1c,%esp
  801886:	5b                   	pop    %ebx
  801887:	5e                   	pop    %esi
  801888:	5f                   	pop    %edi
  801889:	5d                   	pop    %ebp
  80188a:	c3                   	ret    
  80188b:	90                   	nop
  80188c:	89 fd                	mov    %edi,%ebp
  80188e:	85 ff                	test   %edi,%edi
  801890:	75 0b                	jne    80189d <__umoddi3+0xe9>
  801892:	b8 01 00 00 00       	mov    $0x1,%eax
  801897:	31 d2                	xor    %edx,%edx
  801899:	f7 f7                	div    %edi
  80189b:	89 c5                	mov    %eax,%ebp
  80189d:	89 f0                	mov    %esi,%eax
  80189f:	31 d2                	xor    %edx,%edx
  8018a1:	f7 f5                	div    %ebp
  8018a3:	89 c8                	mov    %ecx,%eax
  8018a5:	f7 f5                	div    %ebp
  8018a7:	89 d0                	mov    %edx,%eax
  8018a9:	e9 44 ff ff ff       	jmp    8017f2 <__umoddi3+0x3e>
  8018ae:	66 90                	xchg   %ax,%ax
  8018b0:	89 c8                	mov    %ecx,%eax
  8018b2:	89 f2                	mov    %esi,%edx
  8018b4:	83 c4 1c             	add    $0x1c,%esp
  8018b7:	5b                   	pop    %ebx
  8018b8:	5e                   	pop    %esi
  8018b9:	5f                   	pop    %edi
  8018ba:	5d                   	pop    %ebp
  8018bb:	c3                   	ret    
  8018bc:	3b 04 24             	cmp    (%esp),%eax
  8018bf:	72 06                	jb     8018c7 <__umoddi3+0x113>
  8018c1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018c5:	77 0f                	ja     8018d6 <__umoddi3+0x122>
  8018c7:	89 f2                	mov    %esi,%edx
  8018c9:	29 f9                	sub    %edi,%ecx
  8018cb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018cf:	89 14 24             	mov    %edx,(%esp)
  8018d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018d6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018da:	8b 14 24             	mov    (%esp),%edx
  8018dd:	83 c4 1c             	add    $0x1c,%esp
  8018e0:	5b                   	pop    %ebx
  8018e1:	5e                   	pop    %esi
  8018e2:	5f                   	pop    %edi
  8018e3:	5d                   	pop    %ebp
  8018e4:	c3                   	ret    
  8018e5:	8d 76 00             	lea    0x0(%esi),%esi
  8018e8:	2b 04 24             	sub    (%esp),%eax
  8018eb:	19 fa                	sbb    %edi,%edx
  8018ed:	89 d1                	mov    %edx,%ecx
  8018ef:	89 c6                	mov    %eax,%esi
  8018f1:	e9 71 ff ff ff       	jmp    801867 <__umoddi3+0xb3>
  8018f6:	66 90                	xchg   %ax,%ax
  8018f8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018fc:	72 ea                	jb     8018e8 <__umoddi3+0x134>
  8018fe:	89 d9                	mov    %ebx,%ecx
  801900:	e9 62 ff ff ff       	jmp    801867 <__umoddi3+0xb3>
