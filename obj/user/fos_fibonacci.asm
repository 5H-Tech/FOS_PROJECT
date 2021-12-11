
obj/user/fos_fibonacci:     file format elf32-i386


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
  800031:	e8 ab 00 00 00       	call   8000e1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int fibonacci(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 00 1c 80 00       	push   $0x801c00
  800057:	e8 1e 0a 00 00       	call   800a7a <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 70 0e 00 00       	call   800ee2 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = fibonacci(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <fibonacci>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 1e 1c 80 00       	push   $0x801c1e
  800097:	e8 8b 02 00 00       	call   800327 <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <fibonacci>:


int fibonacci(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	53                   	push   %ebx
  8000a6:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  8000a9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ad:	7f 07                	jg     8000b6 <fibonacci+0x14>
		return 1 ;
  8000af:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b4:	eb 26                	jmp    8000dc <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  8000b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b9:	48                   	dec    %eax
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	50                   	push   %eax
  8000be:	e8 df ff ff ff       	call   8000a2 <fibonacci>
  8000c3:	83 c4 10             	add    $0x10,%esp
  8000c6:	89 c3                	mov    %eax,%ebx
  8000c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8000cb:	83 e8 02             	sub    $0x2,%eax
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	50                   	push   %eax
  8000d2:	e8 cb ff ff ff       	call   8000a2 <fibonacci>
  8000d7:	83 c4 10             	add    $0x10,%esp
  8000da:	01 d8                	add    %ebx,%eax
}
  8000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000df:	c9                   	leave  
  8000e0:	c3                   	ret    

008000e1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000e1:	55                   	push   %ebp
  8000e2:	89 e5                	mov    %esp,%ebp
  8000e4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e7:	e8 3f 12 00 00       	call   80132b <sys_getenvindex>
  8000ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	c1 e0 03             	shl    $0x3,%eax
  8000f7:	01 d0                	add    %edx,%eax
  8000f9:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800100:	01 c8                	add    %ecx,%eax
  800102:	01 c0                	add    %eax,%eax
  800104:	01 d0                	add    %edx,%eax
  800106:	01 c0                	add    %eax,%eax
  800108:	01 d0                	add    %edx,%eax
  80010a:	89 c2                	mov    %eax,%edx
  80010c:	c1 e2 05             	shl    $0x5,%edx
  80010f:	29 c2                	sub    %eax,%edx
  800111:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800118:	89 c2                	mov    %eax,%edx
  80011a:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800120:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800125:	a1 20 30 80 00       	mov    0x803020,%eax
  80012a:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800130:	84 c0                	test   %al,%al
  800132:	74 0f                	je     800143 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800134:	a1 20 30 80 00       	mov    0x803020,%eax
  800139:	05 40 3c 01 00       	add    $0x13c40,%eax
  80013e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800143:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800147:	7e 0a                	jle    800153 <libmain+0x72>
		binaryname = argv[0];
  800149:	8b 45 0c             	mov    0xc(%ebp),%eax
  80014c:	8b 00                	mov    (%eax),%eax
  80014e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	ff 75 0c             	pushl  0xc(%ebp)
  800159:	ff 75 08             	pushl  0x8(%ebp)
  80015c:	e8 d7 fe ff ff       	call   800038 <_main>
  800161:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800164:	e8 5d 13 00 00       	call   8014c6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800169:	83 ec 0c             	sub    $0xc,%esp
  80016c:	68 4c 1c 80 00       	push   $0x801c4c
  800171:	e8 84 01 00 00       	call   8002fa <cprintf>
  800176:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800179:	a1 20 30 80 00       	mov    0x803020,%eax
  80017e:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800184:	a1 20 30 80 00       	mov    0x803020,%eax
  800189:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80018f:	83 ec 04             	sub    $0x4,%esp
  800192:	52                   	push   %edx
  800193:	50                   	push   %eax
  800194:	68 74 1c 80 00       	push   $0x801c74
  800199:	e8 5c 01 00 00       	call   8002fa <cprintf>
  80019e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a6:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b1:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001b7:	83 ec 04             	sub    $0x4,%esp
  8001ba:	52                   	push   %edx
  8001bb:	50                   	push   %eax
  8001bc:	68 9c 1c 80 00       	push   $0x801c9c
  8001c1:	e8 34 01 00 00       	call   8002fa <cprintf>
  8001c6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ce:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001d4:	83 ec 08             	sub    $0x8,%esp
  8001d7:	50                   	push   %eax
  8001d8:	68 dd 1c 80 00       	push   $0x801cdd
  8001dd:	e8 18 01 00 00       	call   8002fa <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 4c 1c 80 00       	push   $0x801c4c
  8001ed:	e8 08 01 00 00       	call   8002fa <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001f5:	e8 e6 12 00 00       	call   8014e0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001fa:	e8 19 00 00 00       	call   800218 <exit>
}
  8001ff:	90                   	nop
  800200:	c9                   	leave  
  800201:	c3                   	ret    

00800202 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800202:	55                   	push   %ebp
  800203:	89 e5                	mov    %esp,%ebp
  800205:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800208:	83 ec 0c             	sub    $0xc,%esp
  80020b:	6a 00                	push   $0x0
  80020d:	e8 e5 10 00 00       	call   8012f7 <sys_env_destroy>
  800212:	83 c4 10             	add    $0x10,%esp
}
  800215:	90                   	nop
  800216:	c9                   	leave  
  800217:	c3                   	ret    

00800218 <exit>:

void
exit(void)
{
  800218:	55                   	push   %ebp
  800219:	89 e5                	mov    %esp,%ebp
  80021b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80021e:	e8 3a 11 00 00       	call   80135d <sys_env_exit>
}
  800223:	90                   	nop
  800224:	c9                   	leave  
  800225:	c3                   	ret    

00800226 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800226:	55                   	push   %ebp
  800227:	89 e5                	mov    %esp,%ebp
  800229:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80022c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	8d 48 01             	lea    0x1(%eax),%ecx
  800234:	8b 55 0c             	mov    0xc(%ebp),%edx
  800237:	89 0a                	mov    %ecx,(%edx)
  800239:	8b 55 08             	mov    0x8(%ebp),%edx
  80023c:	88 d1                	mov    %dl,%cl
  80023e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800241:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800245:	8b 45 0c             	mov    0xc(%ebp),%eax
  800248:	8b 00                	mov    (%eax),%eax
  80024a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80024f:	75 2c                	jne    80027d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800251:	a0 24 30 80 00       	mov    0x803024,%al
  800256:	0f b6 c0             	movzbl %al,%eax
  800259:	8b 55 0c             	mov    0xc(%ebp),%edx
  80025c:	8b 12                	mov    (%edx),%edx
  80025e:	89 d1                	mov    %edx,%ecx
  800260:	8b 55 0c             	mov    0xc(%ebp),%edx
  800263:	83 c2 08             	add    $0x8,%edx
  800266:	83 ec 04             	sub    $0x4,%esp
  800269:	50                   	push   %eax
  80026a:	51                   	push   %ecx
  80026b:	52                   	push   %edx
  80026c:	e8 44 10 00 00       	call   8012b5 <sys_cputs>
  800271:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800274:	8b 45 0c             	mov    0xc(%ebp),%eax
  800277:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80027d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800280:	8b 40 04             	mov    0x4(%eax),%eax
  800283:	8d 50 01             	lea    0x1(%eax),%edx
  800286:	8b 45 0c             	mov    0xc(%ebp),%eax
  800289:	89 50 04             	mov    %edx,0x4(%eax)
}
  80028c:	90                   	nop
  80028d:	c9                   	leave  
  80028e:	c3                   	ret    

0080028f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80028f:	55                   	push   %ebp
  800290:	89 e5                	mov    %esp,%ebp
  800292:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800298:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80029f:	00 00 00 
	b.cnt = 0;
  8002a2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002a9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002ac:	ff 75 0c             	pushl  0xc(%ebp)
  8002af:	ff 75 08             	pushl  0x8(%ebp)
  8002b2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b8:	50                   	push   %eax
  8002b9:	68 26 02 80 00       	push   $0x800226
  8002be:	e8 11 02 00 00       	call   8004d4 <vprintfmt>
  8002c3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002c6:	a0 24 30 80 00       	mov    0x803024,%al
  8002cb:	0f b6 c0             	movzbl %al,%eax
  8002ce:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002d4:	83 ec 04             	sub    $0x4,%esp
  8002d7:	50                   	push   %eax
  8002d8:	52                   	push   %edx
  8002d9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002df:	83 c0 08             	add    $0x8,%eax
  8002e2:	50                   	push   %eax
  8002e3:	e8 cd 0f 00 00       	call   8012b5 <sys_cputs>
  8002e8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002eb:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002f2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002f8:	c9                   	leave  
  8002f9:	c3                   	ret    

008002fa <cprintf>:

int cprintf(const char *fmt, ...) {
  8002fa:	55                   	push   %ebp
  8002fb:	89 e5                	mov    %esp,%ebp
  8002fd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800300:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800307:	8d 45 0c             	lea    0xc(%ebp),%eax
  80030a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80030d:	8b 45 08             	mov    0x8(%ebp),%eax
  800310:	83 ec 08             	sub    $0x8,%esp
  800313:	ff 75 f4             	pushl  -0xc(%ebp)
  800316:	50                   	push   %eax
  800317:	e8 73 ff ff ff       	call   80028f <vcprintf>
  80031c:	83 c4 10             	add    $0x10,%esp
  80031f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800322:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800325:	c9                   	leave  
  800326:	c3                   	ret    

00800327 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800327:	55                   	push   %ebp
  800328:	89 e5                	mov    %esp,%ebp
  80032a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80032d:	e8 94 11 00 00       	call   8014c6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800332:	8d 45 0c             	lea    0xc(%ebp),%eax
  800335:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800338:	8b 45 08             	mov    0x8(%ebp),%eax
  80033b:	83 ec 08             	sub    $0x8,%esp
  80033e:	ff 75 f4             	pushl  -0xc(%ebp)
  800341:	50                   	push   %eax
  800342:	e8 48 ff ff ff       	call   80028f <vcprintf>
  800347:	83 c4 10             	add    $0x10,%esp
  80034a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80034d:	e8 8e 11 00 00       	call   8014e0 <sys_enable_interrupt>
	return cnt;
  800352:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800355:	c9                   	leave  
  800356:	c3                   	ret    

00800357 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800357:	55                   	push   %ebp
  800358:	89 e5                	mov    %esp,%ebp
  80035a:	53                   	push   %ebx
  80035b:	83 ec 14             	sub    $0x14,%esp
  80035e:	8b 45 10             	mov    0x10(%ebp),%eax
  800361:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800364:	8b 45 14             	mov    0x14(%ebp),%eax
  800367:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80036a:	8b 45 18             	mov    0x18(%ebp),%eax
  80036d:	ba 00 00 00 00       	mov    $0x0,%edx
  800372:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800375:	77 55                	ja     8003cc <printnum+0x75>
  800377:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80037a:	72 05                	jb     800381 <printnum+0x2a>
  80037c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80037f:	77 4b                	ja     8003cc <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800381:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800384:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800387:	8b 45 18             	mov    0x18(%ebp),%eax
  80038a:	ba 00 00 00 00       	mov    $0x0,%edx
  80038f:	52                   	push   %edx
  800390:	50                   	push   %eax
  800391:	ff 75 f4             	pushl  -0xc(%ebp)
  800394:	ff 75 f0             	pushl  -0x10(%ebp)
  800397:	e8 ec 15 00 00       	call   801988 <__udivdi3>
  80039c:	83 c4 10             	add    $0x10,%esp
  80039f:	83 ec 04             	sub    $0x4,%esp
  8003a2:	ff 75 20             	pushl  0x20(%ebp)
  8003a5:	53                   	push   %ebx
  8003a6:	ff 75 18             	pushl  0x18(%ebp)
  8003a9:	52                   	push   %edx
  8003aa:	50                   	push   %eax
  8003ab:	ff 75 0c             	pushl  0xc(%ebp)
  8003ae:	ff 75 08             	pushl  0x8(%ebp)
  8003b1:	e8 a1 ff ff ff       	call   800357 <printnum>
  8003b6:	83 c4 20             	add    $0x20,%esp
  8003b9:	eb 1a                	jmp    8003d5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003bb:	83 ec 08             	sub    $0x8,%esp
  8003be:	ff 75 0c             	pushl  0xc(%ebp)
  8003c1:	ff 75 20             	pushl  0x20(%ebp)
  8003c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c7:	ff d0                	call   *%eax
  8003c9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003cc:	ff 4d 1c             	decl   0x1c(%ebp)
  8003cf:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003d3:	7f e6                	jg     8003bb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003d5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003d8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003e3:	53                   	push   %ebx
  8003e4:	51                   	push   %ecx
  8003e5:	52                   	push   %edx
  8003e6:	50                   	push   %eax
  8003e7:	e8 ac 16 00 00       	call   801a98 <__umoddi3>
  8003ec:	83 c4 10             	add    $0x10,%esp
  8003ef:	05 14 1f 80 00       	add    $0x801f14,%eax
  8003f4:	8a 00                	mov    (%eax),%al
  8003f6:	0f be c0             	movsbl %al,%eax
  8003f9:	83 ec 08             	sub    $0x8,%esp
  8003fc:	ff 75 0c             	pushl  0xc(%ebp)
  8003ff:	50                   	push   %eax
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	ff d0                	call   *%eax
  800405:	83 c4 10             	add    $0x10,%esp
}
  800408:	90                   	nop
  800409:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80040c:	c9                   	leave  
  80040d:	c3                   	ret    

0080040e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80040e:	55                   	push   %ebp
  80040f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800411:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800415:	7e 1c                	jle    800433 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	8d 50 08             	lea    0x8(%eax),%edx
  80041f:	8b 45 08             	mov    0x8(%ebp),%eax
  800422:	89 10                	mov    %edx,(%eax)
  800424:	8b 45 08             	mov    0x8(%ebp),%eax
  800427:	8b 00                	mov    (%eax),%eax
  800429:	83 e8 08             	sub    $0x8,%eax
  80042c:	8b 50 04             	mov    0x4(%eax),%edx
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	eb 40                	jmp    800473 <getuint+0x65>
	else if (lflag)
  800433:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800437:	74 1e                	je     800457 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	8d 50 04             	lea    0x4(%eax),%edx
  800441:	8b 45 08             	mov    0x8(%ebp),%eax
  800444:	89 10                	mov    %edx,(%eax)
  800446:	8b 45 08             	mov    0x8(%ebp),%eax
  800449:	8b 00                	mov    (%eax),%eax
  80044b:	83 e8 04             	sub    $0x4,%eax
  80044e:	8b 00                	mov    (%eax),%eax
  800450:	ba 00 00 00 00       	mov    $0x0,%edx
  800455:	eb 1c                	jmp    800473 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	8d 50 04             	lea    0x4(%eax),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	89 10                	mov    %edx,(%eax)
  800464:	8b 45 08             	mov    0x8(%ebp),%eax
  800467:	8b 00                	mov    (%eax),%eax
  800469:	83 e8 04             	sub    $0x4,%eax
  80046c:	8b 00                	mov    (%eax),%eax
  80046e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800473:	5d                   	pop    %ebp
  800474:	c3                   	ret    

00800475 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800475:	55                   	push   %ebp
  800476:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800478:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80047c:	7e 1c                	jle    80049a <getint+0x25>
		return va_arg(*ap, long long);
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	8d 50 08             	lea    0x8(%eax),%edx
  800486:	8b 45 08             	mov    0x8(%ebp),%eax
  800489:	89 10                	mov    %edx,(%eax)
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	83 e8 08             	sub    $0x8,%eax
  800493:	8b 50 04             	mov    0x4(%eax),%edx
  800496:	8b 00                	mov    (%eax),%eax
  800498:	eb 38                	jmp    8004d2 <getint+0x5d>
	else if (lflag)
  80049a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80049e:	74 1a                	je     8004ba <getint+0x45>
		return va_arg(*ap, long);
  8004a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a3:	8b 00                	mov    (%eax),%eax
  8004a5:	8d 50 04             	lea    0x4(%eax),%edx
  8004a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ab:	89 10                	mov    %edx,(%eax)
  8004ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b0:	8b 00                	mov    (%eax),%eax
  8004b2:	83 e8 04             	sub    $0x4,%eax
  8004b5:	8b 00                	mov    (%eax),%eax
  8004b7:	99                   	cltd   
  8004b8:	eb 18                	jmp    8004d2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	8b 00                	mov    (%eax),%eax
  8004bf:	8d 50 04             	lea    0x4(%eax),%edx
  8004c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c5:	89 10                	mov    %edx,(%eax)
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	8b 00                	mov    (%eax),%eax
  8004cc:	83 e8 04             	sub    $0x4,%eax
  8004cf:	8b 00                	mov    (%eax),%eax
  8004d1:	99                   	cltd   
}
  8004d2:	5d                   	pop    %ebp
  8004d3:	c3                   	ret    

008004d4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004d4:	55                   	push   %ebp
  8004d5:	89 e5                	mov    %esp,%ebp
  8004d7:	56                   	push   %esi
  8004d8:	53                   	push   %ebx
  8004d9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004dc:	eb 17                	jmp    8004f5 <vprintfmt+0x21>
			if (ch == '\0')
  8004de:	85 db                	test   %ebx,%ebx
  8004e0:	0f 84 af 03 00 00    	je     800895 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004e6:	83 ec 08             	sub    $0x8,%esp
  8004e9:	ff 75 0c             	pushl  0xc(%ebp)
  8004ec:	53                   	push   %ebx
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	ff d0                	call   *%eax
  8004f2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f8:	8d 50 01             	lea    0x1(%eax),%edx
  8004fb:	89 55 10             	mov    %edx,0x10(%ebp)
  8004fe:	8a 00                	mov    (%eax),%al
  800500:	0f b6 d8             	movzbl %al,%ebx
  800503:	83 fb 25             	cmp    $0x25,%ebx
  800506:	75 d6                	jne    8004de <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800508:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80050c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800513:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80051a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800521:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800528:	8b 45 10             	mov    0x10(%ebp),%eax
  80052b:	8d 50 01             	lea    0x1(%eax),%edx
  80052e:	89 55 10             	mov    %edx,0x10(%ebp)
  800531:	8a 00                	mov    (%eax),%al
  800533:	0f b6 d8             	movzbl %al,%ebx
  800536:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800539:	83 f8 55             	cmp    $0x55,%eax
  80053c:	0f 87 2b 03 00 00    	ja     80086d <vprintfmt+0x399>
  800542:	8b 04 85 38 1f 80 00 	mov    0x801f38(,%eax,4),%eax
  800549:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80054b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80054f:	eb d7                	jmp    800528 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800551:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800555:	eb d1                	jmp    800528 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800557:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80055e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800561:	89 d0                	mov    %edx,%eax
  800563:	c1 e0 02             	shl    $0x2,%eax
  800566:	01 d0                	add    %edx,%eax
  800568:	01 c0                	add    %eax,%eax
  80056a:	01 d8                	add    %ebx,%eax
  80056c:	83 e8 30             	sub    $0x30,%eax
  80056f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800572:	8b 45 10             	mov    0x10(%ebp),%eax
  800575:	8a 00                	mov    (%eax),%al
  800577:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80057a:	83 fb 2f             	cmp    $0x2f,%ebx
  80057d:	7e 3e                	jle    8005bd <vprintfmt+0xe9>
  80057f:	83 fb 39             	cmp    $0x39,%ebx
  800582:	7f 39                	jg     8005bd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800584:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800587:	eb d5                	jmp    80055e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800589:	8b 45 14             	mov    0x14(%ebp),%eax
  80058c:	83 c0 04             	add    $0x4,%eax
  80058f:	89 45 14             	mov    %eax,0x14(%ebp)
  800592:	8b 45 14             	mov    0x14(%ebp),%eax
  800595:	83 e8 04             	sub    $0x4,%eax
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80059d:	eb 1f                	jmp    8005be <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80059f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005a3:	79 83                	jns    800528 <vprintfmt+0x54>
				width = 0;
  8005a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005ac:	e9 77 ff ff ff       	jmp    800528 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005b1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005b8:	e9 6b ff ff ff       	jmp    800528 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005bd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005be:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c2:	0f 89 60 ff ff ff    	jns    800528 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ce:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005d5:	e9 4e ff ff ff       	jmp    800528 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005dd:	e9 46 ff ff ff       	jmp    800528 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e5:	83 c0 04             	add    $0x4,%eax
  8005e8:	89 45 14             	mov    %eax,0x14(%ebp)
  8005eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ee:	83 e8 04             	sub    $0x4,%eax
  8005f1:	8b 00                	mov    (%eax),%eax
  8005f3:	83 ec 08             	sub    $0x8,%esp
  8005f6:	ff 75 0c             	pushl  0xc(%ebp)
  8005f9:	50                   	push   %eax
  8005fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fd:	ff d0                	call   *%eax
  8005ff:	83 c4 10             	add    $0x10,%esp
			break;
  800602:	e9 89 02 00 00       	jmp    800890 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800607:	8b 45 14             	mov    0x14(%ebp),%eax
  80060a:	83 c0 04             	add    $0x4,%eax
  80060d:	89 45 14             	mov    %eax,0x14(%ebp)
  800610:	8b 45 14             	mov    0x14(%ebp),%eax
  800613:	83 e8 04             	sub    $0x4,%eax
  800616:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800618:	85 db                	test   %ebx,%ebx
  80061a:	79 02                	jns    80061e <vprintfmt+0x14a>
				err = -err;
  80061c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80061e:	83 fb 64             	cmp    $0x64,%ebx
  800621:	7f 0b                	jg     80062e <vprintfmt+0x15a>
  800623:	8b 34 9d 80 1d 80 00 	mov    0x801d80(,%ebx,4),%esi
  80062a:	85 f6                	test   %esi,%esi
  80062c:	75 19                	jne    800647 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80062e:	53                   	push   %ebx
  80062f:	68 25 1f 80 00       	push   $0x801f25
  800634:	ff 75 0c             	pushl  0xc(%ebp)
  800637:	ff 75 08             	pushl  0x8(%ebp)
  80063a:	e8 5e 02 00 00       	call   80089d <printfmt>
  80063f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800642:	e9 49 02 00 00       	jmp    800890 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800647:	56                   	push   %esi
  800648:	68 2e 1f 80 00       	push   $0x801f2e
  80064d:	ff 75 0c             	pushl  0xc(%ebp)
  800650:	ff 75 08             	pushl  0x8(%ebp)
  800653:	e8 45 02 00 00       	call   80089d <printfmt>
  800658:	83 c4 10             	add    $0x10,%esp
			break;
  80065b:	e9 30 02 00 00       	jmp    800890 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800660:	8b 45 14             	mov    0x14(%ebp),%eax
  800663:	83 c0 04             	add    $0x4,%eax
  800666:	89 45 14             	mov    %eax,0x14(%ebp)
  800669:	8b 45 14             	mov    0x14(%ebp),%eax
  80066c:	83 e8 04             	sub    $0x4,%eax
  80066f:	8b 30                	mov    (%eax),%esi
  800671:	85 f6                	test   %esi,%esi
  800673:	75 05                	jne    80067a <vprintfmt+0x1a6>
				p = "(null)";
  800675:	be 31 1f 80 00       	mov    $0x801f31,%esi
			if (width > 0 && padc != '-')
  80067a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80067e:	7e 6d                	jle    8006ed <vprintfmt+0x219>
  800680:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800684:	74 67                	je     8006ed <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800686:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800689:	83 ec 08             	sub    $0x8,%esp
  80068c:	50                   	push   %eax
  80068d:	56                   	push   %esi
  80068e:	e8 12 05 00 00       	call   800ba5 <strnlen>
  800693:	83 c4 10             	add    $0x10,%esp
  800696:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800699:	eb 16                	jmp    8006b1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80069b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80069f:	83 ec 08             	sub    $0x8,%esp
  8006a2:	ff 75 0c             	pushl  0xc(%ebp)
  8006a5:	50                   	push   %eax
  8006a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a9:	ff d0                	call   *%eax
  8006ab:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006ae:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b5:	7f e4                	jg     80069b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b7:	eb 34                	jmp    8006ed <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006b9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006bd:	74 1c                	je     8006db <vprintfmt+0x207>
  8006bf:	83 fb 1f             	cmp    $0x1f,%ebx
  8006c2:	7e 05                	jle    8006c9 <vprintfmt+0x1f5>
  8006c4:	83 fb 7e             	cmp    $0x7e,%ebx
  8006c7:	7e 12                	jle    8006db <vprintfmt+0x207>
					putch('?', putdat);
  8006c9:	83 ec 08             	sub    $0x8,%esp
  8006cc:	ff 75 0c             	pushl  0xc(%ebp)
  8006cf:	6a 3f                	push   $0x3f
  8006d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d4:	ff d0                	call   *%eax
  8006d6:	83 c4 10             	add    $0x10,%esp
  8006d9:	eb 0f                	jmp    8006ea <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006db:	83 ec 08             	sub    $0x8,%esp
  8006de:	ff 75 0c             	pushl  0xc(%ebp)
  8006e1:	53                   	push   %ebx
  8006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e5:	ff d0                	call   *%eax
  8006e7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ea:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ed:	89 f0                	mov    %esi,%eax
  8006ef:	8d 70 01             	lea    0x1(%eax),%esi
  8006f2:	8a 00                	mov    (%eax),%al
  8006f4:	0f be d8             	movsbl %al,%ebx
  8006f7:	85 db                	test   %ebx,%ebx
  8006f9:	74 24                	je     80071f <vprintfmt+0x24b>
  8006fb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ff:	78 b8                	js     8006b9 <vprintfmt+0x1e5>
  800701:	ff 4d e0             	decl   -0x20(%ebp)
  800704:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800708:	79 af                	jns    8006b9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80070a:	eb 13                	jmp    80071f <vprintfmt+0x24b>
				putch(' ', putdat);
  80070c:	83 ec 08             	sub    $0x8,%esp
  80070f:	ff 75 0c             	pushl  0xc(%ebp)
  800712:	6a 20                	push   $0x20
  800714:	8b 45 08             	mov    0x8(%ebp),%eax
  800717:	ff d0                	call   *%eax
  800719:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80071c:	ff 4d e4             	decl   -0x1c(%ebp)
  80071f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800723:	7f e7                	jg     80070c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800725:	e9 66 01 00 00       	jmp    800890 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80072a:	83 ec 08             	sub    $0x8,%esp
  80072d:	ff 75 e8             	pushl  -0x18(%ebp)
  800730:	8d 45 14             	lea    0x14(%ebp),%eax
  800733:	50                   	push   %eax
  800734:	e8 3c fd ff ff       	call   800475 <getint>
  800739:	83 c4 10             	add    $0x10,%esp
  80073c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80073f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800742:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800745:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800748:	85 d2                	test   %edx,%edx
  80074a:	79 23                	jns    80076f <vprintfmt+0x29b>
				putch('-', putdat);
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 0c             	pushl  0xc(%ebp)
  800752:	6a 2d                	push   $0x2d
  800754:	8b 45 08             	mov    0x8(%ebp),%eax
  800757:	ff d0                	call   *%eax
  800759:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80075c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80075f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800762:	f7 d8                	neg    %eax
  800764:	83 d2 00             	adc    $0x0,%edx
  800767:	f7 da                	neg    %edx
  800769:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80076f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800776:	e9 bc 00 00 00       	jmp    800837 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80077b:	83 ec 08             	sub    $0x8,%esp
  80077e:	ff 75 e8             	pushl  -0x18(%ebp)
  800781:	8d 45 14             	lea    0x14(%ebp),%eax
  800784:	50                   	push   %eax
  800785:	e8 84 fc ff ff       	call   80040e <getuint>
  80078a:	83 c4 10             	add    $0x10,%esp
  80078d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800790:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800793:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80079a:	e9 98 00 00 00       	jmp    800837 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	6a 58                	push   $0x58
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	ff d0                	call   *%eax
  8007ac:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	ff 75 0c             	pushl  0xc(%ebp)
  8007b5:	6a 58                	push   $0x58
  8007b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ba:	ff d0                	call   *%eax
  8007bc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	ff 75 0c             	pushl  0xc(%ebp)
  8007c5:	6a 58                	push   $0x58
  8007c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ca:	ff d0                	call   *%eax
  8007cc:	83 c4 10             	add    $0x10,%esp
			break;
  8007cf:	e9 bc 00 00 00       	jmp    800890 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007d4:	83 ec 08             	sub    $0x8,%esp
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	6a 30                	push   $0x30
  8007dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007df:	ff d0                	call   *%eax
  8007e1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007e4:	83 ec 08             	sub    $0x8,%esp
  8007e7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ea:	6a 78                	push   $0x78
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	ff d0                	call   *%eax
  8007f1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f7:	83 c0 04             	add    $0x4,%eax
  8007fa:	89 45 14             	mov    %eax,0x14(%ebp)
  8007fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800800:	83 e8 04             	sub    $0x4,%eax
  800803:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800805:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800808:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80080f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800816:	eb 1f                	jmp    800837 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800818:	83 ec 08             	sub    $0x8,%esp
  80081b:	ff 75 e8             	pushl  -0x18(%ebp)
  80081e:	8d 45 14             	lea    0x14(%ebp),%eax
  800821:	50                   	push   %eax
  800822:	e8 e7 fb ff ff       	call   80040e <getuint>
  800827:	83 c4 10             	add    $0x10,%esp
  80082a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80082d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800830:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800837:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80083b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80083e:	83 ec 04             	sub    $0x4,%esp
  800841:	52                   	push   %edx
  800842:	ff 75 e4             	pushl  -0x1c(%ebp)
  800845:	50                   	push   %eax
  800846:	ff 75 f4             	pushl  -0xc(%ebp)
  800849:	ff 75 f0             	pushl  -0x10(%ebp)
  80084c:	ff 75 0c             	pushl  0xc(%ebp)
  80084f:	ff 75 08             	pushl  0x8(%ebp)
  800852:	e8 00 fb ff ff       	call   800357 <printnum>
  800857:	83 c4 20             	add    $0x20,%esp
			break;
  80085a:	eb 34                	jmp    800890 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80085c:	83 ec 08             	sub    $0x8,%esp
  80085f:	ff 75 0c             	pushl  0xc(%ebp)
  800862:	53                   	push   %ebx
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	ff d0                	call   *%eax
  800868:	83 c4 10             	add    $0x10,%esp
			break;
  80086b:	eb 23                	jmp    800890 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80086d:	83 ec 08             	sub    $0x8,%esp
  800870:	ff 75 0c             	pushl  0xc(%ebp)
  800873:	6a 25                	push   $0x25
  800875:	8b 45 08             	mov    0x8(%ebp),%eax
  800878:	ff d0                	call   *%eax
  80087a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80087d:	ff 4d 10             	decl   0x10(%ebp)
  800880:	eb 03                	jmp    800885 <vprintfmt+0x3b1>
  800882:	ff 4d 10             	decl   0x10(%ebp)
  800885:	8b 45 10             	mov    0x10(%ebp),%eax
  800888:	48                   	dec    %eax
  800889:	8a 00                	mov    (%eax),%al
  80088b:	3c 25                	cmp    $0x25,%al
  80088d:	75 f3                	jne    800882 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80088f:	90                   	nop
		}
	}
  800890:	e9 47 fc ff ff       	jmp    8004dc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800895:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800896:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800899:	5b                   	pop    %ebx
  80089a:	5e                   	pop    %esi
  80089b:	5d                   	pop    %ebp
  80089c:	c3                   	ret    

0080089d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80089d:	55                   	push   %ebp
  80089e:	89 e5                	mov    %esp,%ebp
  8008a0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008a3:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a6:	83 c0 04             	add    $0x4,%eax
  8008a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8008af:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b2:	50                   	push   %eax
  8008b3:	ff 75 0c             	pushl  0xc(%ebp)
  8008b6:	ff 75 08             	pushl  0x8(%ebp)
  8008b9:	e8 16 fc ff ff       	call   8004d4 <vprintfmt>
  8008be:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008c1:	90                   	nop
  8008c2:	c9                   	leave  
  8008c3:	c3                   	ret    

008008c4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008c4:	55                   	push   %ebp
  8008c5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ca:	8b 40 08             	mov    0x8(%eax),%eax
  8008cd:	8d 50 01             	lea    0x1(%eax),%edx
  8008d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d9:	8b 10                	mov    (%eax),%edx
  8008db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008de:	8b 40 04             	mov    0x4(%eax),%eax
  8008e1:	39 c2                	cmp    %eax,%edx
  8008e3:	73 12                	jae    8008f7 <sprintputch+0x33>
		*b->buf++ = ch;
  8008e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e8:	8b 00                	mov    (%eax),%eax
  8008ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f0:	89 0a                	mov    %ecx,(%edx)
  8008f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f5:	88 10                	mov    %dl,(%eax)
}
  8008f7:	90                   	nop
  8008f8:	5d                   	pop    %ebp
  8008f9:	c3                   	ret    

008008fa <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008fa:	55                   	push   %ebp
  8008fb:	89 e5                	mov    %esp,%ebp
  8008fd:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800900:	8b 45 08             	mov    0x8(%ebp),%eax
  800903:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800906:	8b 45 0c             	mov    0xc(%ebp),%eax
  800909:	8d 50 ff             	lea    -0x1(%eax),%edx
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	01 d0                	add    %edx,%eax
  800911:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800914:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80091b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80091f:	74 06                	je     800927 <vsnprintf+0x2d>
  800921:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800925:	7f 07                	jg     80092e <vsnprintf+0x34>
		return -E_INVAL;
  800927:	b8 03 00 00 00       	mov    $0x3,%eax
  80092c:	eb 20                	jmp    80094e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80092e:	ff 75 14             	pushl  0x14(%ebp)
  800931:	ff 75 10             	pushl  0x10(%ebp)
  800934:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800937:	50                   	push   %eax
  800938:	68 c4 08 80 00       	push   $0x8008c4
  80093d:	e8 92 fb ff ff       	call   8004d4 <vprintfmt>
  800942:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800945:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800948:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80094b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80094e:	c9                   	leave  
  80094f:	c3                   	ret    

00800950 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800950:	55                   	push   %ebp
  800951:	89 e5                	mov    %esp,%ebp
  800953:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800956:	8d 45 10             	lea    0x10(%ebp),%eax
  800959:	83 c0 04             	add    $0x4,%eax
  80095c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80095f:	8b 45 10             	mov    0x10(%ebp),%eax
  800962:	ff 75 f4             	pushl  -0xc(%ebp)
  800965:	50                   	push   %eax
  800966:	ff 75 0c             	pushl  0xc(%ebp)
  800969:	ff 75 08             	pushl  0x8(%ebp)
  80096c:	e8 89 ff ff ff       	call   8008fa <vsnprintf>
  800971:	83 c4 10             	add    $0x10,%esp
  800974:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800977:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80097a:	c9                   	leave  
  80097b:	c3                   	ret    

0080097c <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80097c:	55                   	push   %ebp
  80097d:	89 e5                	mov    %esp,%ebp
  80097f:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800982:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800986:	74 13                	je     80099b <readline+0x1f>
		cprintf("%s", prompt);
  800988:	83 ec 08             	sub    $0x8,%esp
  80098b:	ff 75 08             	pushl  0x8(%ebp)
  80098e:	68 90 20 80 00       	push   $0x802090
  800993:	e8 62 f9 ff ff       	call   8002fa <cprintf>
  800998:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80099b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8009a2:	83 ec 0c             	sub    $0xc,%esp
  8009a5:	6a 00                	push   $0x0
  8009a7:	e8 d1 0f 00 00       	call   80197d <iscons>
  8009ac:	83 c4 10             	add    $0x10,%esp
  8009af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8009b2:	e8 78 0f 00 00       	call   80192f <getchar>
  8009b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8009ba:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009be:	79 22                	jns    8009e2 <readline+0x66>
			if (c != -E_EOF)
  8009c0:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8009c4:	0f 84 ad 00 00 00    	je     800a77 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8009ca:	83 ec 08             	sub    $0x8,%esp
  8009cd:	ff 75 ec             	pushl  -0x14(%ebp)
  8009d0:	68 93 20 80 00       	push   $0x802093
  8009d5:	e8 20 f9 ff ff       	call   8002fa <cprintf>
  8009da:	83 c4 10             	add    $0x10,%esp
			return;
  8009dd:	e9 95 00 00 00       	jmp    800a77 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009e2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009e6:	7e 34                	jle    800a1c <readline+0xa0>
  8009e8:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009ef:	7f 2b                	jg     800a1c <readline+0xa0>
			if (echoing)
  8009f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009f5:	74 0e                	je     800a05 <readline+0x89>
				cputchar(c);
  8009f7:	83 ec 0c             	sub    $0xc,%esp
  8009fa:	ff 75 ec             	pushl  -0x14(%ebp)
  8009fd:	e8 e5 0e 00 00       	call   8018e7 <cputchar>
  800a02:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a08:	8d 50 01             	lea    0x1(%eax),%edx
  800a0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800a0e:	89 c2                	mov    %eax,%edx
  800a10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a13:	01 d0                	add    %edx,%eax
  800a15:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a18:	88 10                	mov    %dl,(%eax)
  800a1a:	eb 56                	jmp    800a72 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800a1c:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800a20:	75 1f                	jne    800a41 <readline+0xc5>
  800a22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a26:	7e 19                	jle    800a41 <readline+0xc5>
			if (echoing)
  800a28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a2c:	74 0e                	je     800a3c <readline+0xc0>
				cputchar(c);
  800a2e:	83 ec 0c             	sub    $0xc,%esp
  800a31:	ff 75 ec             	pushl  -0x14(%ebp)
  800a34:	e8 ae 0e 00 00       	call   8018e7 <cputchar>
  800a39:	83 c4 10             	add    $0x10,%esp

			i--;
  800a3c:	ff 4d f4             	decl   -0xc(%ebp)
  800a3f:	eb 31                	jmp    800a72 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a41:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a45:	74 0a                	je     800a51 <readline+0xd5>
  800a47:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a4b:	0f 85 61 ff ff ff    	jne    8009b2 <readline+0x36>
			if (echoing)
  800a51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a55:	74 0e                	je     800a65 <readline+0xe9>
				cputchar(c);
  800a57:	83 ec 0c             	sub    $0xc,%esp
  800a5a:	ff 75 ec             	pushl  -0x14(%ebp)
  800a5d:	e8 85 0e 00 00       	call   8018e7 <cputchar>
  800a62:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6b:	01 d0                	add    %edx,%eax
  800a6d:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a70:	eb 06                	jmp    800a78 <readline+0xfc>
		}
	}
  800a72:	e9 3b ff ff ff       	jmp    8009b2 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a77:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a78:	c9                   	leave  
  800a79:	c3                   	ret    

00800a7a <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a7a:	55                   	push   %ebp
  800a7b:	89 e5                	mov    %esp,%ebp
  800a7d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a80:	e8 41 0a 00 00       	call   8014c6 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a85:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a89:	74 13                	je     800a9e <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 08             	pushl  0x8(%ebp)
  800a91:	68 90 20 80 00       	push   $0x802090
  800a96:	e8 5f f8 ff ff       	call   8002fa <cprintf>
  800a9b:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800aa5:	83 ec 0c             	sub    $0xc,%esp
  800aa8:	6a 00                	push   $0x0
  800aaa:	e8 ce 0e 00 00       	call   80197d <iscons>
  800aaf:	83 c4 10             	add    $0x10,%esp
  800ab2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800ab5:	e8 75 0e 00 00       	call   80192f <getchar>
  800aba:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800abd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ac1:	79 23                	jns    800ae6 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800ac3:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800ac7:	74 13                	je     800adc <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 ec             	pushl  -0x14(%ebp)
  800acf:	68 93 20 80 00       	push   $0x802093
  800ad4:	e8 21 f8 ff ff       	call   8002fa <cprintf>
  800ad9:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800adc:	e8 ff 09 00 00       	call   8014e0 <sys_enable_interrupt>
			return;
  800ae1:	e9 9a 00 00 00       	jmp    800b80 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ae6:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aea:	7e 34                	jle    800b20 <atomic_readline+0xa6>
  800aec:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800af3:	7f 2b                	jg     800b20 <atomic_readline+0xa6>
			if (echoing)
  800af5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800af9:	74 0e                	je     800b09 <atomic_readline+0x8f>
				cputchar(c);
  800afb:	83 ec 0c             	sub    $0xc,%esp
  800afe:	ff 75 ec             	pushl  -0x14(%ebp)
  800b01:	e8 e1 0d 00 00       	call   8018e7 <cputchar>
  800b06:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b0c:	8d 50 01             	lea    0x1(%eax),%edx
  800b0f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b12:	89 c2                	mov    %eax,%edx
  800b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b17:	01 d0                	add    %edx,%eax
  800b19:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b1c:	88 10                	mov    %dl,(%eax)
  800b1e:	eb 5b                	jmp    800b7b <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800b20:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800b24:	75 1f                	jne    800b45 <atomic_readline+0xcb>
  800b26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b2a:	7e 19                	jle    800b45 <atomic_readline+0xcb>
			if (echoing)
  800b2c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b30:	74 0e                	je     800b40 <atomic_readline+0xc6>
				cputchar(c);
  800b32:	83 ec 0c             	sub    $0xc,%esp
  800b35:	ff 75 ec             	pushl  -0x14(%ebp)
  800b38:	e8 aa 0d 00 00       	call   8018e7 <cputchar>
  800b3d:	83 c4 10             	add    $0x10,%esp
			i--;
  800b40:	ff 4d f4             	decl   -0xc(%ebp)
  800b43:	eb 36                	jmp    800b7b <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b45:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b49:	74 0a                	je     800b55 <atomic_readline+0xdb>
  800b4b:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b4f:	0f 85 60 ff ff ff    	jne    800ab5 <atomic_readline+0x3b>
			if (echoing)
  800b55:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b59:	74 0e                	je     800b69 <atomic_readline+0xef>
				cputchar(c);
  800b5b:	83 ec 0c             	sub    $0xc,%esp
  800b5e:	ff 75 ec             	pushl  -0x14(%ebp)
  800b61:	e8 81 0d 00 00       	call   8018e7 <cputchar>
  800b66:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6f:	01 d0                	add    %edx,%eax
  800b71:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b74:	e8 67 09 00 00       	call   8014e0 <sys_enable_interrupt>
			return;
  800b79:	eb 05                	jmp    800b80 <atomic_readline+0x106>
		}
	}
  800b7b:	e9 35 ff ff ff       	jmp    800ab5 <atomic_readline+0x3b>
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8f:	eb 06                	jmp    800b97 <strlen+0x15>
		n++;
  800b91:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b94:	ff 45 08             	incl   0x8(%ebp)
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8a 00                	mov    (%eax),%al
  800b9c:	84 c0                	test   %al,%al
  800b9e:	75 f1                	jne    800b91 <strlen+0xf>
		n++;
	return n;
  800ba0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba3:	c9                   	leave  
  800ba4:	c3                   	ret    

00800ba5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ba5:	55                   	push   %ebp
  800ba6:	89 e5                	mov    %esp,%ebp
  800ba8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb2:	eb 09                	jmp    800bbd <strnlen+0x18>
		n++;
  800bb4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb7:	ff 45 08             	incl   0x8(%ebp)
  800bba:	ff 4d 0c             	decl   0xc(%ebp)
  800bbd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc1:	74 09                	je     800bcc <strnlen+0x27>
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	84 c0                	test   %al,%al
  800bca:	75 e8                	jne    800bb4 <strnlen+0xf>
		n++;
	return n;
  800bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bdd:	90                   	nop
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	8d 50 01             	lea    0x1(%eax),%edx
  800be4:	89 55 08             	mov    %edx,0x8(%ebp)
  800be7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bea:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bed:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bf0:	8a 12                	mov    (%edx),%dl
  800bf2:	88 10                	mov    %dl,(%eax)
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	84 c0                	test   %al,%al
  800bf8:	75 e4                	jne    800bde <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfd:	c9                   	leave  
  800bfe:	c3                   	ret    

00800bff <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bff:	55                   	push   %ebp
  800c00:	89 e5                	mov    %esp,%ebp
  800c02:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c12:	eb 1f                	jmp    800c33 <strncpy+0x34>
		*dst++ = *src;
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
  800c17:	8d 50 01             	lea    0x1(%eax),%edx
  800c1a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c20:	8a 12                	mov    (%edx),%dl
  800c22:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	84 c0                	test   %al,%al
  800c2b:	74 03                	je     800c30 <strncpy+0x31>
			src++;
  800c2d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c30:	ff 45 fc             	incl   -0x4(%ebp)
  800c33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c36:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c39:	72 d9                	jb     800c14 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c3e:	c9                   	leave  
  800c3f:	c3                   	ret    

00800c40 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c40:	55                   	push   %ebp
  800c41:	89 e5                	mov    %esp,%ebp
  800c43:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c50:	74 30                	je     800c82 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c52:	eb 16                	jmp    800c6a <strlcpy+0x2a>
			*dst++ = *src++;
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	8d 50 01             	lea    0x1(%eax),%edx
  800c5a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c60:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c63:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c66:	8a 12                	mov    (%edx),%dl
  800c68:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c6a:	ff 4d 10             	decl   0x10(%ebp)
  800c6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c71:	74 09                	je     800c7c <strlcpy+0x3c>
  800c73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c76:	8a 00                	mov    (%eax),%al
  800c78:	84 c0                	test   %al,%al
  800c7a:	75 d8                	jne    800c54 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c82:	8b 55 08             	mov    0x8(%ebp),%edx
  800c85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c88:	29 c2                	sub    %eax,%edx
  800c8a:	89 d0                	mov    %edx,%eax
}
  800c8c:	c9                   	leave  
  800c8d:	c3                   	ret    

00800c8e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c91:	eb 06                	jmp    800c99 <strcmp+0xb>
		p++, q++;
  800c93:	ff 45 08             	incl   0x8(%ebp)
  800c96:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	84 c0                	test   %al,%al
  800ca0:	74 0e                	je     800cb0 <strcmp+0x22>
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8a 10                	mov    (%eax),%dl
  800ca7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	38 c2                	cmp    %al,%dl
  800cae:	74 e3                	je     800c93 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	8a 00                	mov    (%eax),%al
  800cb5:	0f b6 d0             	movzbl %al,%edx
  800cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	0f b6 c0             	movzbl %al,%eax
  800cc0:	29 c2                	sub    %eax,%edx
  800cc2:	89 d0                	mov    %edx,%eax
}
  800cc4:	5d                   	pop    %ebp
  800cc5:	c3                   	ret    

00800cc6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cc6:	55                   	push   %ebp
  800cc7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cc9:	eb 09                	jmp    800cd4 <strncmp+0xe>
		n--, p++, q++;
  800ccb:	ff 4d 10             	decl   0x10(%ebp)
  800cce:	ff 45 08             	incl   0x8(%ebp)
  800cd1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd8:	74 17                	je     800cf1 <strncmp+0x2b>
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	84 c0                	test   %al,%al
  800ce1:	74 0e                	je     800cf1 <strncmp+0x2b>
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8a 10                	mov    (%eax),%dl
  800ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ceb:	8a 00                	mov    (%eax),%al
  800ced:	38 c2                	cmp    %al,%dl
  800cef:	74 da                	je     800ccb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cf1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf5:	75 07                	jne    800cfe <strncmp+0x38>
		return 0;
  800cf7:	b8 00 00 00 00       	mov    $0x0,%eax
  800cfc:	eb 14                	jmp    800d12 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	0f b6 d0             	movzbl %al,%edx
  800d06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f b6 c0             	movzbl %al,%eax
  800d0e:	29 c2                	sub    %eax,%edx
  800d10:	89 d0                	mov    %edx,%eax
}
  800d12:	5d                   	pop    %ebp
  800d13:	c3                   	ret    

00800d14 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d14:	55                   	push   %ebp
  800d15:	89 e5                	mov    %esp,%ebp
  800d17:	83 ec 04             	sub    $0x4,%esp
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d20:	eb 12                	jmp    800d34 <strchr+0x20>
		if (*s == c)
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8a 00                	mov    (%eax),%al
  800d27:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d2a:	75 05                	jne    800d31 <strchr+0x1d>
			return (char *) s;
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	eb 11                	jmp    800d42 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d31:	ff 45 08             	incl   0x8(%ebp)
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	8a 00                	mov    (%eax),%al
  800d39:	84 c0                	test   %al,%al
  800d3b:	75 e5                	jne    800d22 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d42:	c9                   	leave  
  800d43:	c3                   	ret    

00800d44 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d44:	55                   	push   %ebp
  800d45:	89 e5                	mov    %esp,%ebp
  800d47:	83 ec 04             	sub    $0x4,%esp
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d50:	eb 0d                	jmp    800d5f <strfind+0x1b>
		if (*s == c)
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d5a:	74 0e                	je     800d6a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d5c:	ff 45 08             	incl   0x8(%ebp)
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 ea                	jne    800d52 <strfind+0xe>
  800d68:	eb 01                	jmp    800d6b <strfind+0x27>
		if (*s == c)
			break;
  800d6a:	90                   	nop
	return (char *) s;
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6e:	c9                   	leave  
  800d6f:	c3                   	ret    

00800d70 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d82:	eb 0e                	jmp    800d92 <memset+0x22>
		*p++ = c;
  800d84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d87:	8d 50 01             	lea    0x1(%eax),%edx
  800d8a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d90:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d92:	ff 4d f8             	decl   -0x8(%ebp)
  800d95:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d99:	79 e9                	jns    800d84 <memset+0x14>
		*p++ = c;

	return v;
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9e:	c9                   	leave  
  800d9f:	c3                   	ret    

00800da0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800da0:	55                   	push   %ebp
  800da1:	89 e5                	mov    %esp,%ebp
  800da3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800db2:	eb 16                	jmp    800dca <memcpy+0x2a>
		*d++ = *s++;
  800db4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db7:	8d 50 01             	lea    0x1(%eax),%edx
  800dba:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dbd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dc6:	8a 12                	mov    (%edx),%dl
  800dc8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dca:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd3:	85 c0                	test   %eax,%eax
  800dd5:	75 dd                	jne    800db4 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
  800ddf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800de2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df4:	73 50                	jae    800e46 <memmove+0x6a>
  800df6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfc:	01 d0                	add    %edx,%eax
  800dfe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e01:	76 43                	jbe    800e46 <memmove+0x6a>
		s += n;
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e09:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e0f:	eb 10                	jmp    800e21 <memmove+0x45>
			*--d = *--s;
  800e11:	ff 4d f8             	decl   -0x8(%ebp)
  800e14:	ff 4d fc             	decl   -0x4(%ebp)
  800e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1a:	8a 10                	mov    (%eax),%dl
  800e1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e21:	8b 45 10             	mov    0x10(%ebp),%eax
  800e24:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e27:	89 55 10             	mov    %edx,0x10(%ebp)
  800e2a:	85 c0                	test   %eax,%eax
  800e2c:	75 e3                	jne    800e11 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e2e:	eb 23                	jmp    800e53 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e33:	8d 50 01             	lea    0x1(%eax),%edx
  800e36:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e42:	8a 12                	mov    (%edx),%dl
  800e44:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e46:	8b 45 10             	mov    0x10(%ebp),%eax
  800e49:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4f:	85 c0                	test   %eax,%eax
  800e51:	75 dd                	jne    800e30 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e56:	c9                   	leave  
  800e57:	c3                   	ret    

00800e58 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e58:	55                   	push   %ebp
  800e59:	89 e5                	mov    %esp,%ebp
  800e5b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e67:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e6a:	eb 2a                	jmp    800e96 <memcmp+0x3e>
		if (*s1 != *s2)
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6f:	8a 10                	mov    (%eax),%dl
  800e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	38 c2                	cmp    %al,%dl
  800e78:	74 16                	je     800e90 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7d:	8a 00                	mov    (%eax),%al
  800e7f:	0f b6 d0             	movzbl %al,%edx
  800e82:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	0f b6 c0             	movzbl %al,%eax
  800e8a:	29 c2                	sub    %eax,%edx
  800e8c:	89 d0                	mov    %edx,%eax
  800e8e:	eb 18                	jmp    800ea8 <memcmp+0x50>
		s1++, s2++;
  800e90:	ff 45 fc             	incl   -0x4(%ebp)
  800e93:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e96:	8b 45 10             	mov    0x10(%ebp),%eax
  800e99:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e9c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9f:	85 c0                	test   %eax,%eax
  800ea1:	75 c9                	jne    800e6c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ea3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea8:	c9                   	leave  
  800ea9:	c3                   	ret    

00800eaa <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eaa:	55                   	push   %ebp
  800eab:	89 e5                	mov    %esp,%ebp
  800ead:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eb0:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb6:	01 d0                	add    %edx,%eax
  800eb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ebb:	eb 15                	jmp    800ed2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	0f b6 d0             	movzbl %al,%edx
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	0f b6 c0             	movzbl %al,%eax
  800ecb:	39 c2                	cmp    %eax,%edx
  800ecd:	74 0d                	je     800edc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ecf:	ff 45 08             	incl   0x8(%ebp)
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ed8:	72 e3                	jb     800ebd <memfind+0x13>
  800eda:	eb 01                	jmp    800edd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800edc:	90                   	nop
	return (void *) s;
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee0:	c9                   	leave  
  800ee1:	c3                   	ret    

00800ee2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ee2:	55                   	push   %ebp
  800ee3:	89 e5                	mov    %esp,%ebp
  800ee5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ee8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef6:	eb 03                	jmp    800efb <strtol+0x19>
		s++;
  800ef8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	3c 20                	cmp    $0x20,%al
  800f02:	74 f4                	je     800ef8 <strtol+0x16>
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	3c 09                	cmp    $0x9,%al
  800f0b:	74 eb                	je     800ef8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	3c 2b                	cmp    $0x2b,%al
  800f14:	75 05                	jne    800f1b <strtol+0x39>
		s++;
  800f16:	ff 45 08             	incl   0x8(%ebp)
  800f19:	eb 13                	jmp    800f2e <strtol+0x4c>
	else if (*s == '-')
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	3c 2d                	cmp    $0x2d,%al
  800f22:	75 0a                	jne    800f2e <strtol+0x4c>
		s++, neg = 1;
  800f24:	ff 45 08             	incl   0x8(%ebp)
  800f27:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f32:	74 06                	je     800f3a <strtol+0x58>
  800f34:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f38:	75 20                	jne    800f5a <strtol+0x78>
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 30                	cmp    $0x30,%al
  800f41:	75 17                	jne    800f5a <strtol+0x78>
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	40                   	inc    %eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	3c 78                	cmp    $0x78,%al
  800f4b:	75 0d                	jne    800f5a <strtol+0x78>
		s += 2, base = 16;
  800f4d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f51:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f58:	eb 28                	jmp    800f82 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5e:	75 15                	jne    800f75 <strtol+0x93>
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	3c 30                	cmp    $0x30,%al
  800f67:	75 0c                	jne    800f75 <strtol+0x93>
		s++, base = 8;
  800f69:	ff 45 08             	incl   0x8(%ebp)
  800f6c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f73:	eb 0d                	jmp    800f82 <strtol+0xa0>
	else if (base == 0)
  800f75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f79:	75 07                	jne    800f82 <strtol+0xa0>
		base = 10;
  800f7b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	3c 2f                	cmp    $0x2f,%al
  800f89:	7e 19                	jle    800fa4 <strtol+0xc2>
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	3c 39                	cmp    $0x39,%al
  800f92:	7f 10                	jg     800fa4 <strtol+0xc2>
			dig = *s - '0';
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	0f be c0             	movsbl %al,%eax
  800f9c:	83 e8 30             	sub    $0x30,%eax
  800f9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa2:	eb 42                	jmp    800fe6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	3c 60                	cmp    $0x60,%al
  800fab:	7e 19                	jle    800fc6 <strtol+0xe4>
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	8a 00                	mov    (%eax),%al
  800fb2:	3c 7a                	cmp    $0x7a,%al
  800fb4:	7f 10                	jg     800fc6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	0f be c0             	movsbl %al,%eax
  800fbe:	83 e8 57             	sub    $0x57,%eax
  800fc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fc4:	eb 20                	jmp    800fe6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	8a 00                	mov    (%eax),%al
  800fcb:	3c 40                	cmp    $0x40,%al
  800fcd:	7e 39                	jle    801008 <strtol+0x126>
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	3c 5a                	cmp    $0x5a,%al
  800fd6:	7f 30                	jg     801008 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	0f be c0             	movsbl %al,%eax
  800fe0:	83 e8 37             	sub    $0x37,%eax
  800fe3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fe6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fec:	7d 19                	jge    801007 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fee:	ff 45 08             	incl   0x8(%ebp)
  800ff1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff4:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ff8:	89 c2                	mov    %eax,%edx
  800ffa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffd:	01 d0                	add    %edx,%eax
  800fff:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801002:	e9 7b ff ff ff       	jmp    800f82 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801007:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801008:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100c:	74 08                	je     801016 <strtol+0x134>
		*endptr = (char *) s;
  80100e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801011:	8b 55 08             	mov    0x8(%ebp),%edx
  801014:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801016:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80101a:	74 07                	je     801023 <strtol+0x141>
  80101c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101f:	f7 d8                	neg    %eax
  801021:	eb 03                	jmp    801026 <strtol+0x144>
  801023:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <ltostr>:

void
ltostr(long value, char *str)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
  80102b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80102e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801035:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80103c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801040:	79 13                	jns    801055 <ltostr+0x2d>
	{
		neg = 1;
  801042:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80104f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801052:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80105d:	99                   	cltd   
  80105e:	f7 f9                	idiv   %ecx
  801060:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801063:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801066:	8d 50 01             	lea    0x1(%eax),%edx
  801069:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106c:	89 c2                	mov    %eax,%edx
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	01 d0                	add    %edx,%eax
  801073:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801076:	83 c2 30             	add    $0x30,%edx
  801079:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80107b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80107e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801083:	f7 e9                	imul   %ecx
  801085:	c1 fa 02             	sar    $0x2,%edx
  801088:	89 c8                	mov    %ecx,%eax
  80108a:	c1 f8 1f             	sar    $0x1f,%eax
  80108d:	29 c2                	sub    %eax,%edx
  80108f:	89 d0                	mov    %edx,%eax
  801091:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801094:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801097:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80109c:	f7 e9                	imul   %ecx
  80109e:	c1 fa 02             	sar    $0x2,%edx
  8010a1:	89 c8                	mov    %ecx,%eax
  8010a3:	c1 f8 1f             	sar    $0x1f,%eax
  8010a6:	29 c2                	sub    %eax,%edx
  8010a8:	89 d0                	mov    %edx,%eax
  8010aa:	c1 e0 02             	shl    $0x2,%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	01 c0                	add    %eax,%eax
  8010b1:	29 c1                	sub    %eax,%ecx
  8010b3:	89 ca                	mov    %ecx,%edx
  8010b5:	85 d2                	test   %edx,%edx
  8010b7:	75 9c                	jne    801055 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c3:	48                   	dec    %eax
  8010c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010cb:	74 3d                	je     80110a <ltostr+0xe2>
		start = 1 ;
  8010cd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010d4:	eb 34                	jmp    80110a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dc:	01 d0                	add    %edx,%eax
  8010de:	8a 00                	mov    (%eax),%al
  8010e0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	01 c2                	add    %eax,%edx
  8010eb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	01 c8                	add    %ecx,%eax
  8010f3:	8a 00                	mov    (%eax),%al
  8010f5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010f7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fd:	01 c2                	add    %eax,%edx
  8010ff:	8a 45 eb             	mov    -0x15(%ebp),%al
  801102:	88 02                	mov    %al,(%edx)
		start++ ;
  801104:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801107:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80110a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80110d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801110:	7c c4                	jl     8010d6 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801112:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801115:	8b 45 0c             	mov    0xc(%ebp),%eax
  801118:	01 d0                	add    %edx,%eax
  80111a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80111d:	90                   	nop
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
  801123:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801126:	ff 75 08             	pushl  0x8(%ebp)
  801129:	e8 54 fa ff ff       	call   800b82 <strlen>
  80112e:	83 c4 04             	add    $0x4,%esp
  801131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801134:	ff 75 0c             	pushl  0xc(%ebp)
  801137:	e8 46 fa ff ff       	call   800b82 <strlen>
  80113c:	83 c4 04             	add    $0x4,%esp
  80113f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801142:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801149:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801150:	eb 17                	jmp    801169 <strcconcat+0x49>
		final[s] = str1[s] ;
  801152:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801155:	8b 45 10             	mov    0x10(%ebp),%eax
  801158:	01 c2                	add    %eax,%edx
  80115a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	01 c8                	add    %ecx,%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801166:	ff 45 fc             	incl   -0x4(%ebp)
  801169:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80116f:	7c e1                	jl     801152 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801171:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801178:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80117f:	eb 1f                	jmp    8011a0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801181:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801184:	8d 50 01             	lea    0x1(%eax),%edx
  801187:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80118a:	89 c2                	mov    %eax,%edx
  80118c:	8b 45 10             	mov    0x10(%ebp),%eax
  80118f:	01 c2                	add    %eax,%edx
  801191:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801194:	8b 45 0c             	mov    0xc(%ebp),%eax
  801197:	01 c8                	add    %ecx,%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80119d:	ff 45 f8             	incl   -0x8(%ebp)
  8011a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a6:	7c d9                	jl     801181 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ae:	01 d0                	add    %edx,%eax
  8011b0:	c6 00 00             	movb   $0x0,(%eax)
}
  8011b3:	90                   	nop
  8011b4:	c9                   	leave  
  8011b5:	c3                   	ret    

008011b6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011b6:	55                   	push   %ebp
  8011b7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c5:	8b 00                	mov    (%eax),%eax
  8011c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d1:	01 d0                	add    %edx,%eax
  8011d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d9:	eb 0c                	jmp    8011e7 <strsplit+0x31>
			*string++ = 0;
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8d 50 01             	lea    0x1(%eax),%edx
  8011e1:	89 55 08             	mov    %edx,0x8(%ebp)
  8011e4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	84 c0                	test   %al,%al
  8011ee:	74 18                	je     801208 <strsplit+0x52>
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	8a 00                	mov    (%eax),%al
  8011f5:	0f be c0             	movsbl %al,%eax
  8011f8:	50                   	push   %eax
  8011f9:	ff 75 0c             	pushl  0xc(%ebp)
  8011fc:	e8 13 fb ff ff       	call   800d14 <strchr>
  801201:	83 c4 08             	add    $0x8,%esp
  801204:	85 c0                	test   %eax,%eax
  801206:	75 d3                	jne    8011db <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	84 c0                	test   %al,%al
  80120f:	74 5a                	je     80126b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801211:	8b 45 14             	mov    0x14(%ebp),%eax
  801214:	8b 00                	mov    (%eax),%eax
  801216:	83 f8 0f             	cmp    $0xf,%eax
  801219:	75 07                	jne    801222 <strsplit+0x6c>
		{
			return 0;
  80121b:	b8 00 00 00 00       	mov    $0x0,%eax
  801220:	eb 66                	jmp    801288 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801222:	8b 45 14             	mov    0x14(%ebp),%eax
  801225:	8b 00                	mov    (%eax),%eax
  801227:	8d 48 01             	lea    0x1(%eax),%ecx
  80122a:	8b 55 14             	mov    0x14(%ebp),%edx
  80122d:	89 0a                	mov    %ecx,(%edx)
  80122f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801236:	8b 45 10             	mov    0x10(%ebp),%eax
  801239:	01 c2                	add    %eax,%edx
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801240:	eb 03                	jmp    801245 <strsplit+0x8f>
			string++;
  801242:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	8a 00                	mov    (%eax),%al
  80124a:	84 c0                	test   %al,%al
  80124c:	74 8b                	je     8011d9 <strsplit+0x23>
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	0f be c0             	movsbl %al,%eax
  801256:	50                   	push   %eax
  801257:	ff 75 0c             	pushl  0xc(%ebp)
  80125a:	e8 b5 fa ff ff       	call   800d14 <strchr>
  80125f:	83 c4 08             	add    $0x8,%esp
  801262:	85 c0                	test   %eax,%eax
  801264:	74 dc                	je     801242 <strsplit+0x8c>
			string++;
	}
  801266:	e9 6e ff ff ff       	jmp    8011d9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80126b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80126c:	8b 45 14             	mov    0x14(%ebp),%eax
  80126f:	8b 00                	mov    (%eax),%eax
  801271:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801278:	8b 45 10             	mov    0x10(%ebp),%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801283:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
  80128d:	57                   	push   %edi
  80128e:	56                   	push   %esi
  80128f:	53                   	push   %ebx
  801290:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	8b 55 0c             	mov    0xc(%ebp),%edx
  801299:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80129c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80129f:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012a2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012a5:	cd 30                	int    $0x30
  8012a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012ad:	83 c4 10             	add    $0x10,%esp
  8012b0:	5b                   	pop    %ebx
  8012b1:	5e                   	pop    %esi
  8012b2:	5f                   	pop    %edi
  8012b3:	5d                   	pop    %ebp
  8012b4:	c3                   	ret    

008012b5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	83 ec 04             	sub    $0x4,%esp
  8012bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8012be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012c1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	6a 00                	push   $0x0
  8012ca:	6a 00                	push   $0x0
  8012cc:	52                   	push   %edx
  8012cd:	ff 75 0c             	pushl  0xc(%ebp)
  8012d0:	50                   	push   %eax
  8012d1:	6a 00                	push   $0x0
  8012d3:	e8 b2 ff ff ff       	call   80128a <syscall>
  8012d8:	83 c4 18             	add    $0x18,%esp
}
  8012db:	90                   	nop
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <sys_cgetc>:

int
sys_cgetc(void)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 01                	push   $0x1
  8012ed:	e8 98 ff ff ff       	call   80128a <syscall>
  8012f2:	83 c4 18             	add    $0x18,%esp
}
  8012f5:	c9                   	leave  
  8012f6:	c3                   	ret    

008012f7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012f7:	55                   	push   %ebp
  8012f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	50                   	push   %eax
  801306:	6a 05                	push   $0x5
  801308:	e8 7d ff ff ff       	call   80128a <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 02                	push   $0x2
  801321:	e8 64 ff ff ff       	call   80128a <syscall>
  801326:	83 c4 18             	add    $0x18,%esp
}
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 03                	push   $0x3
  80133a:	e8 4b ff ff ff       	call   80128a <syscall>
  80133f:	83 c4 18             	add    $0x18,%esp
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 04                	push   $0x4
  801353:	e8 32 ff ff ff       	call   80128a <syscall>
  801358:	83 c4 18             	add    $0x18,%esp
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <sys_env_exit>:


void sys_env_exit(void)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 06                	push   $0x6
  80136c:	e8 19 ff ff ff       	call   80128a <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	90                   	nop
  801375:	c9                   	leave  
  801376:	c3                   	ret    

00801377 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801377:	55                   	push   %ebp
  801378:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80137a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	52                   	push   %edx
  801387:	50                   	push   %eax
  801388:	6a 07                	push   $0x7
  80138a:	e8 fb fe ff ff       	call   80128a <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
  801397:	56                   	push   %esi
  801398:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801399:	8b 75 18             	mov    0x18(%ebp),%esi
  80139c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80139f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	56                   	push   %esi
  8013a9:	53                   	push   %ebx
  8013aa:	51                   	push   %ecx
  8013ab:	52                   	push   %edx
  8013ac:	50                   	push   %eax
  8013ad:	6a 08                	push   $0x8
  8013af:	e8 d6 fe ff ff       	call   80128a <syscall>
  8013b4:	83 c4 18             	add    $0x18,%esp
}
  8013b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013ba:	5b                   	pop    %ebx
  8013bb:	5e                   	pop    %esi
  8013bc:	5d                   	pop    %ebp
  8013bd:	c3                   	ret    

008013be <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	52                   	push   %edx
  8013ce:	50                   	push   %eax
  8013cf:	6a 09                	push   $0x9
  8013d1:	e8 b4 fe ff ff       	call   80128a <syscall>
  8013d6:	83 c4 18             	add    $0x18,%esp
}
  8013d9:	c9                   	leave  
  8013da:	c3                   	ret    

008013db <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013db:	55                   	push   %ebp
  8013dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	ff 75 0c             	pushl  0xc(%ebp)
  8013e7:	ff 75 08             	pushl  0x8(%ebp)
  8013ea:	6a 0a                	push   $0xa
  8013ec:	e8 99 fe ff ff       	call   80128a <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 0b                	push   $0xb
  801405:	e8 80 fe ff ff       	call   80128a <syscall>
  80140a:	83 c4 18             	add    $0x18,%esp
}
  80140d:	c9                   	leave  
  80140e:	c3                   	ret    

0080140f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80140f:	55                   	push   %ebp
  801410:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 0c                	push   $0xc
  80141e:	e8 67 fe ff ff       	call   80128a <syscall>
  801423:	83 c4 18             	add    $0x18,%esp
}
  801426:	c9                   	leave  
  801427:	c3                   	ret    

00801428 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801428:	55                   	push   %ebp
  801429:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 0d                	push   $0xd
  801437:	e8 4e fe ff ff       	call   80128a <syscall>
  80143c:	83 c4 18             	add    $0x18,%esp
}
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	ff 75 0c             	pushl  0xc(%ebp)
  80144d:	ff 75 08             	pushl  0x8(%ebp)
  801450:	6a 11                	push   $0x11
  801452:	e8 33 fe ff ff       	call   80128a <syscall>
  801457:	83 c4 18             	add    $0x18,%esp
	return;
  80145a:	90                   	nop
}
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	ff 75 0c             	pushl  0xc(%ebp)
  801469:	ff 75 08             	pushl  0x8(%ebp)
  80146c:	6a 12                	push   $0x12
  80146e:	e8 17 fe ff ff       	call   80128a <syscall>
  801473:	83 c4 18             	add    $0x18,%esp
	return ;
  801476:	90                   	nop
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 0e                	push   $0xe
  801488:	e8 fd fd ff ff       	call   80128a <syscall>
  80148d:	83 c4 18             	add    $0x18,%esp
}
  801490:	c9                   	leave  
  801491:	c3                   	ret    

00801492 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	ff 75 08             	pushl  0x8(%ebp)
  8014a0:	6a 0f                	push   $0xf
  8014a2:	e8 e3 fd ff ff       	call   80128a <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
}
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 10                	push   $0x10
  8014bb:	e8 ca fd ff ff       	call   80128a <syscall>
  8014c0:	83 c4 18             	add    $0x18,%esp
}
  8014c3:	90                   	nop
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 14                	push   $0x14
  8014d5:	e8 b0 fd ff ff       	call   80128a <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
}
  8014dd:	90                   	nop
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 15                	push   $0x15
  8014ef:	e8 96 fd ff ff       	call   80128a <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
}
  8014f7:	90                   	nop
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_cputc>:


void
sys_cputc(const char c)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
  8014fd:	83 ec 04             	sub    $0x4,%esp
  801500:	8b 45 08             	mov    0x8(%ebp),%eax
  801503:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801506:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	50                   	push   %eax
  801513:	6a 16                	push   $0x16
  801515:	e8 70 fd ff ff       	call   80128a <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
}
  80151d:	90                   	nop
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 17                	push   $0x17
  80152f:	e8 56 fd ff ff       	call   80128a <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	90                   	nop
  801538:	c9                   	leave  
  801539:	c3                   	ret    

0080153a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	ff 75 0c             	pushl  0xc(%ebp)
  801549:	50                   	push   %eax
  80154a:	6a 18                	push   $0x18
  80154c:	e8 39 fd ff ff       	call   80128a <syscall>
  801551:	83 c4 18             	add    $0x18,%esp
}
  801554:	c9                   	leave  
  801555:	c3                   	ret    

00801556 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801556:	55                   	push   %ebp
  801557:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801559:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	52                   	push   %edx
  801566:	50                   	push   %eax
  801567:	6a 1b                	push   $0x1b
  801569:	e8 1c fd ff ff       	call   80128a <syscall>
  80156e:	83 c4 18             	add    $0x18,%esp
}
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801576:	8b 55 0c             	mov    0xc(%ebp),%edx
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	52                   	push   %edx
  801583:	50                   	push   %eax
  801584:	6a 19                	push   $0x19
  801586:	e8 ff fc ff ff       	call   80128a <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
}
  80158e:	90                   	nop
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801594:	8b 55 0c             	mov    0xc(%ebp),%edx
  801597:	8b 45 08             	mov    0x8(%ebp),%eax
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	52                   	push   %edx
  8015a1:	50                   	push   %eax
  8015a2:	6a 1a                	push   $0x1a
  8015a4:	e8 e1 fc ff ff       	call   80128a <syscall>
  8015a9:	83 c4 18             	add    $0x18,%esp
}
  8015ac:	90                   	nop
  8015ad:	c9                   	leave  
  8015ae:	c3                   	ret    

008015af <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015af:	55                   	push   %ebp
  8015b0:	89 e5                	mov    %esp,%ebp
  8015b2:	83 ec 04             	sub    $0x4,%esp
  8015b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015bb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015be:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	6a 00                	push   $0x0
  8015c7:	51                   	push   %ecx
  8015c8:	52                   	push   %edx
  8015c9:	ff 75 0c             	pushl  0xc(%ebp)
  8015cc:	50                   	push   %eax
  8015cd:	6a 1c                	push   $0x1c
  8015cf:	e8 b6 fc ff ff       	call   80128a <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	52                   	push   %edx
  8015e9:	50                   	push   %eax
  8015ea:	6a 1d                	push   $0x1d
  8015ec:	e8 99 fc ff ff       	call   80128a <syscall>
  8015f1:	83 c4 18             	add    $0x18,%esp
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	51                   	push   %ecx
  801607:	52                   	push   %edx
  801608:	50                   	push   %eax
  801609:	6a 1e                	push   $0x1e
  80160b:	e8 7a fc ff ff       	call   80128a <syscall>
  801610:	83 c4 18             	add    $0x18,%esp
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801618:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	52                   	push   %edx
  801625:	50                   	push   %eax
  801626:	6a 1f                	push   $0x1f
  801628:	e8 5d fc ff ff       	call   80128a <syscall>
  80162d:	83 c4 18             	add    $0x18,%esp
}
  801630:	c9                   	leave  
  801631:	c3                   	ret    

00801632 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 20                	push   $0x20
  801641:	e8 44 fc ff ff       	call   80128a <syscall>
  801646:	83 c4 18             	add    $0x18,%esp
}
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	6a 00                	push   $0x0
  801653:	ff 75 14             	pushl  0x14(%ebp)
  801656:	ff 75 10             	pushl  0x10(%ebp)
  801659:	ff 75 0c             	pushl  0xc(%ebp)
  80165c:	50                   	push   %eax
  80165d:	6a 21                	push   $0x21
  80165f:	e8 26 fc ff ff       	call   80128a <syscall>
  801664:	83 c4 18             	add    $0x18,%esp
}
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	50                   	push   %eax
  801678:	6a 22                	push   $0x22
  80167a:	e8 0b fc ff ff       	call   80128a <syscall>
  80167f:	83 c4 18             	add    $0x18,%esp
}
  801682:	90                   	nop
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801688:	8b 45 08             	mov    0x8(%ebp),%eax
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	50                   	push   %eax
  801694:	6a 23                	push   $0x23
  801696:	e8 ef fb ff ff       	call   80128a <syscall>
  80169b:	83 c4 18             	add    $0x18,%esp
}
  80169e:	90                   	nop
  80169f:	c9                   	leave  
  8016a0:	c3                   	ret    

008016a1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016a1:	55                   	push   %ebp
  8016a2:	89 e5                	mov    %esp,%ebp
  8016a4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016a7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016aa:	8d 50 04             	lea    0x4(%eax),%edx
  8016ad:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	52                   	push   %edx
  8016b7:	50                   	push   %eax
  8016b8:	6a 24                	push   $0x24
  8016ba:	e8 cb fb ff ff       	call   80128a <syscall>
  8016bf:	83 c4 18             	add    $0x18,%esp
	return result;
  8016c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016cb:	89 01                	mov    %eax,(%ecx)
  8016cd:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	c9                   	leave  
  8016d4:	c2 04 00             	ret    $0x4

008016d7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	ff 75 10             	pushl  0x10(%ebp)
  8016e1:	ff 75 0c             	pushl  0xc(%ebp)
  8016e4:	ff 75 08             	pushl  0x8(%ebp)
  8016e7:	6a 13                	push   $0x13
  8016e9:	e8 9c fb ff ff       	call   80128a <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f1:	90                   	nop
}
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 25                	push   $0x25
  801703:	e8 82 fb ff ff       	call   80128a <syscall>
  801708:	83 c4 18             	add    $0x18,%esp
}
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
  801710:	83 ec 04             	sub    $0x4,%esp
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801719:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	50                   	push   %eax
  801726:	6a 26                	push   $0x26
  801728:	e8 5d fb ff ff       	call   80128a <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
	return ;
  801730:	90                   	nop
}
  801731:	c9                   	leave  
  801732:	c3                   	ret    

00801733 <rsttst>:
void rsttst()
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 28                	push   $0x28
  801742:	e8 43 fb ff ff       	call   80128a <syscall>
  801747:	83 c4 18             	add    $0x18,%esp
	return ;
  80174a:	90                   	nop
}
  80174b:	c9                   	leave  
  80174c:	c3                   	ret    

0080174d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
  801750:	83 ec 04             	sub    $0x4,%esp
  801753:	8b 45 14             	mov    0x14(%ebp),%eax
  801756:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801759:	8b 55 18             	mov    0x18(%ebp),%edx
  80175c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801760:	52                   	push   %edx
  801761:	50                   	push   %eax
  801762:	ff 75 10             	pushl  0x10(%ebp)
  801765:	ff 75 0c             	pushl  0xc(%ebp)
  801768:	ff 75 08             	pushl  0x8(%ebp)
  80176b:	6a 27                	push   $0x27
  80176d:	e8 18 fb ff ff       	call   80128a <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
	return ;
  801775:	90                   	nop
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <chktst>:
void chktst(uint32 n)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	ff 75 08             	pushl  0x8(%ebp)
  801786:	6a 29                	push   $0x29
  801788:	e8 fd fa ff ff       	call   80128a <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
	return ;
  801790:	90                   	nop
}
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <inctst>:

void inctst()
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 2a                	push   $0x2a
  8017a2:	e8 e3 fa ff ff       	call   80128a <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017aa:	90                   	nop
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <gettst>:
uint32 gettst()
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 2b                	push   $0x2b
  8017bc:	e8 c9 fa ff ff       	call   80128a <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 2c                	push   $0x2c
  8017d8:	e8 ad fa ff ff       	call   80128a <syscall>
  8017dd:	83 c4 18             	add    $0x18,%esp
  8017e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017e3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017e7:	75 07                	jne    8017f0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ee:	eb 05                	jmp    8017f5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f5:	c9                   	leave  
  8017f6:	c3                   	ret    

008017f7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017f7:	55                   	push   %ebp
  8017f8:	89 e5                	mov    %esp,%ebp
  8017fa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 2c                	push   $0x2c
  801809:	e8 7c fa ff ff       	call   80128a <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
  801811:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801814:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801818:	75 07                	jne    801821 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80181a:	b8 01 00 00 00       	mov    $0x1,%eax
  80181f:	eb 05                	jmp    801826 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801821:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
  80182b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 2c                	push   $0x2c
  80183a:	e8 4b fa ff ff       	call   80128a <syscall>
  80183f:	83 c4 18             	add    $0x18,%esp
  801842:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801845:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801849:	75 07                	jne    801852 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80184b:	b8 01 00 00 00       	mov    $0x1,%eax
  801850:	eb 05                	jmp    801857 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801852:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801857:	c9                   	leave  
  801858:	c3                   	ret    

00801859 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
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
  80186b:	e8 1a fa ff ff       	call   80128a <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
  801873:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801876:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80187a:	75 07                	jne    801883 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80187c:	b8 01 00 00 00       	mov    $0x1,%eax
  801881:	eb 05                	jmp    801888 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801883:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	ff 75 08             	pushl  0x8(%ebp)
  801898:	6a 2d                	push   $0x2d
  80189a:	e8 eb f9 ff ff       	call   80128a <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a2:	90                   	nop
}
  8018a3:	c9                   	leave  
  8018a4:	c3                   	ret    

008018a5 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
  8018a8:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018a9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b5:	6a 00                	push   $0x0
  8018b7:	53                   	push   %ebx
  8018b8:	51                   	push   %ecx
  8018b9:	52                   	push   %edx
  8018ba:	50                   	push   %eax
  8018bb:	6a 2e                	push   $0x2e
  8018bd:	e8 c8 f9 ff ff       	call   80128a <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
}
  8018c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	52                   	push   %edx
  8018da:	50                   	push   %eax
  8018db:	6a 2f                	push   $0x2f
  8018dd:	e8 a8 f9 ff ff       	call   80128a <syscall>
  8018e2:	83 c4 18             	add    $0x18,%esp
}
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
  8018ea:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8018ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f0:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8018f3:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018f7:	83 ec 0c             	sub    $0xc,%esp
  8018fa:	50                   	push   %eax
  8018fb:	e8 fa fb ff ff       	call   8014fa <sys_cputc>
  801900:	83 c4 10             	add    $0x10,%esp
}
  801903:	90                   	nop
  801904:	c9                   	leave  
  801905:	c3                   	ret    

00801906 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  801906:	55                   	push   %ebp
  801907:	89 e5                	mov    %esp,%ebp
  801909:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80190c:	e8 b5 fb ff ff       	call   8014c6 <sys_disable_interrupt>
	char c = ch;
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801917:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80191b:	83 ec 0c             	sub    $0xc,%esp
  80191e:	50                   	push   %eax
  80191f:	e8 d6 fb ff ff       	call   8014fa <sys_cputc>
  801924:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801927:	e8 b4 fb ff ff       	call   8014e0 <sys_enable_interrupt>
}
  80192c:	90                   	nop
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <getchar>:

int
getchar(void)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
  801932:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801935:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80193c:	eb 08                	jmp    801946 <getchar+0x17>
	{
		c = sys_cgetc();
  80193e:	e8 9b f9 ff ff       	call   8012de <sys_cgetc>
  801943:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801946:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80194a:	74 f2                	je     80193e <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80194c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80194f:	c9                   	leave  
  801950:	c3                   	ret    

00801951 <atomic_getchar>:

int
atomic_getchar(void)
{
  801951:	55                   	push   %ebp
  801952:	89 e5                	mov    %esp,%ebp
  801954:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801957:	e8 6a fb ff ff       	call   8014c6 <sys_disable_interrupt>
	int c=0;
  80195c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801963:	eb 08                	jmp    80196d <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801965:	e8 74 f9 ff ff       	call   8012de <sys_cgetc>
  80196a:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80196d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801971:	74 f2                	je     801965 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801973:	e8 68 fb ff ff       	call   8014e0 <sys_enable_interrupt>
	return c;
  801978:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <iscons>:

int iscons(int fdnum)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801980:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801985:	5d                   	pop    %ebp
  801986:	c3                   	ret    
  801987:	90                   	nop

00801988 <__udivdi3>:
  801988:	55                   	push   %ebp
  801989:	57                   	push   %edi
  80198a:	56                   	push   %esi
  80198b:	53                   	push   %ebx
  80198c:	83 ec 1c             	sub    $0x1c,%esp
  80198f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801993:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801997:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80199b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80199f:	89 ca                	mov    %ecx,%edx
  8019a1:	89 f8                	mov    %edi,%eax
  8019a3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019a7:	85 f6                	test   %esi,%esi
  8019a9:	75 2d                	jne    8019d8 <__udivdi3+0x50>
  8019ab:	39 cf                	cmp    %ecx,%edi
  8019ad:	77 65                	ja     801a14 <__udivdi3+0x8c>
  8019af:	89 fd                	mov    %edi,%ebp
  8019b1:	85 ff                	test   %edi,%edi
  8019b3:	75 0b                	jne    8019c0 <__udivdi3+0x38>
  8019b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ba:	31 d2                	xor    %edx,%edx
  8019bc:	f7 f7                	div    %edi
  8019be:	89 c5                	mov    %eax,%ebp
  8019c0:	31 d2                	xor    %edx,%edx
  8019c2:	89 c8                	mov    %ecx,%eax
  8019c4:	f7 f5                	div    %ebp
  8019c6:	89 c1                	mov    %eax,%ecx
  8019c8:	89 d8                	mov    %ebx,%eax
  8019ca:	f7 f5                	div    %ebp
  8019cc:	89 cf                	mov    %ecx,%edi
  8019ce:	89 fa                	mov    %edi,%edx
  8019d0:	83 c4 1c             	add    $0x1c,%esp
  8019d3:	5b                   	pop    %ebx
  8019d4:	5e                   	pop    %esi
  8019d5:	5f                   	pop    %edi
  8019d6:	5d                   	pop    %ebp
  8019d7:	c3                   	ret    
  8019d8:	39 ce                	cmp    %ecx,%esi
  8019da:	77 28                	ja     801a04 <__udivdi3+0x7c>
  8019dc:	0f bd fe             	bsr    %esi,%edi
  8019df:	83 f7 1f             	xor    $0x1f,%edi
  8019e2:	75 40                	jne    801a24 <__udivdi3+0x9c>
  8019e4:	39 ce                	cmp    %ecx,%esi
  8019e6:	72 0a                	jb     8019f2 <__udivdi3+0x6a>
  8019e8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019ec:	0f 87 9e 00 00 00    	ja     801a90 <__udivdi3+0x108>
  8019f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f7:	89 fa                	mov    %edi,%edx
  8019f9:	83 c4 1c             	add    $0x1c,%esp
  8019fc:	5b                   	pop    %ebx
  8019fd:	5e                   	pop    %esi
  8019fe:	5f                   	pop    %edi
  8019ff:	5d                   	pop    %ebp
  801a00:	c3                   	ret    
  801a01:	8d 76 00             	lea    0x0(%esi),%esi
  801a04:	31 ff                	xor    %edi,%edi
  801a06:	31 c0                	xor    %eax,%eax
  801a08:	89 fa                	mov    %edi,%edx
  801a0a:	83 c4 1c             	add    $0x1c,%esp
  801a0d:	5b                   	pop    %ebx
  801a0e:	5e                   	pop    %esi
  801a0f:	5f                   	pop    %edi
  801a10:	5d                   	pop    %ebp
  801a11:	c3                   	ret    
  801a12:	66 90                	xchg   %ax,%ax
  801a14:	89 d8                	mov    %ebx,%eax
  801a16:	f7 f7                	div    %edi
  801a18:	31 ff                	xor    %edi,%edi
  801a1a:	89 fa                	mov    %edi,%edx
  801a1c:	83 c4 1c             	add    $0x1c,%esp
  801a1f:	5b                   	pop    %ebx
  801a20:	5e                   	pop    %esi
  801a21:	5f                   	pop    %edi
  801a22:	5d                   	pop    %ebp
  801a23:	c3                   	ret    
  801a24:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a29:	89 eb                	mov    %ebp,%ebx
  801a2b:	29 fb                	sub    %edi,%ebx
  801a2d:	89 f9                	mov    %edi,%ecx
  801a2f:	d3 e6                	shl    %cl,%esi
  801a31:	89 c5                	mov    %eax,%ebp
  801a33:	88 d9                	mov    %bl,%cl
  801a35:	d3 ed                	shr    %cl,%ebp
  801a37:	89 e9                	mov    %ebp,%ecx
  801a39:	09 f1                	or     %esi,%ecx
  801a3b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a3f:	89 f9                	mov    %edi,%ecx
  801a41:	d3 e0                	shl    %cl,%eax
  801a43:	89 c5                	mov    %eax,%ebp
  801a45:	89 d6                	mov    %edx,%esi
  801a47:	88 d9                	mov    %bl,%cl
  801a49:	d3 ee                	shr    %cl,%esi
  801a4b:	89 f9                	mov    %edi,%ecx
  801a4d:	d3 e2                	shl    %cl,%edx
  801a4f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a53:	88 d9                	mov    %bl,%cl
  801a55:	d3 e8                	shr    %cl,%eax
  801a57:	09 c2                	or     %eax,%edx
  801a59:	89 d0                	mov    %edx,%eax
  801a5b:	89 f2                	mov    %esi,%edx
  801a5d:	f7 74 24 0c          	divl   0xc(%esp)
  801a61:	89 d6                	mov    %edx,%esi
  801a63:	89 c3                	mov    %eax,%ebx
  801a65:	f7 e5                	mul    %ebp
  801a67:	39 d6                	cmp    %edx,%esi
  801a69:	72 19                	jb     801a84 <__udivdi3+0xfc>
  801a6b:	74 0b                	je     801a78 <__udivdi3+0xf0>
  801a6d:	89 d8                	mov    %ebx,%eax
  801a6f:	31 ff                	xor    %edi,%edi
  801a71:	e9 58 ff ff ff       	jmp    8019ce <__udivdi3+0x46>
  801a76:	66 90                	xchg   %ax,%ax
  801a78:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a7c:	89 f9                	mov    %edi,%ecx
  801a7e:	d3 e2                	shl    %cl,%edx
  801a80:	39 c2                	cmp    %eax,%edx
  801a82:	73 e9                	jae    801a6d <__udivdi3+0xe5>
  801a84:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a87:	31 ff                	xor    %edi,%edi
  801a89:	e9 40 ff ff ff       	jmp    8019ce <__udivdi3+0x46>
  801a8e:	66 90                	xchg   %ax,%ax
  801a90:	31 c0                	xor    %eax,%eax
  801a92:	e9 37 ff ff ff       	jmp    8019ce <__udivdi3+0x46>
  801a97:	90                   	nop

00801a98 <__umoddi3>:
  801a98:	55                   	push   %ebp
  801a99:	57                   	push   %edi
  801a9a:	56                   	push   %esi
  801a9b:	53                   	push   %ebx
  801a9c:	83 ec 1c             	sub    $0x1c,%esp
  801a9f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801aa3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801aa7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801aaf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ab3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ab7:	89 f3                	mov    %esi,%ebx
  801ab9:	89 fa                	mov    %edi,%edx
  801abb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801abf:	89 34 24             	mov    %esi,(%esp)
  801ac2:	85 c0                	test   %eax,%eax
  801ac4:	75 1a                	jne    801ae0 <__umoddi3+0x48>
  801ac6:	39 f7                	cmp    %esi,%edi
  801ac8:	0f 86 a2 00 00 00    	jbe    801b70 <__umoddi3+0xd8>
  801ace:	89 c8                	mov    %ecx,%eax
  801ad0:	89 f2                	mov    %esi,%edx
  801ad2:	f7 f7                	div    %edi
  801ad4:	89 d0                	mov    %edx,%eax
  801ad6:	31 d2                	xor    %edx,%edx
  801ad8:	83 c4 1c             	add    $0x1c,%esp
  801adb:	5b                   	pop    %ebx
  801adc:	5e                   	pop    %esi
  801add:	5f                   	pop    %edi
  801ade:	5d                   	pop    %ebp
  801adf:	c3                   	ret    
  801ae0:	39 f0                	cmp    %esi,%eax
  801ae2:	0f 87 ac 00 00 00    	ja     801b94 <__umoddi3+0xfc>
  801ae8:	0f bd e8             	bsr    %eax,%ebp
  801aeb:	83 f5 1f             	xor    $0x1f,%ebp
  801aee:	0f 84 ac 00 00 00    	je     801ba0 <__umoddi3+0x108>
  801af4:	bf 20 00 00 00       	mov    $0x20,%edi
  801af9:	29 ef                	sub    %ebp,%edi
  801afb:	89 fe                	mov    %edi,%esi
  801afd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b01:	89 e9                	mov    %ebp,%ecx
  801b03:	d3 e0                	shl    %cl,%eax
  801b05:	89 d7                	mov    %edx,%edi
  801b07:	89 f1                	mov    %esi,%ecx
  801b09:	d3 ef                	shr    %cl,%edi
  801b0b:	09 c7                	or     %eax,%edi
  801b0d:	89 e9                	mov    %ebp,%ecx
  801b0f:	d3 e2                	shl    %cl,%edx
  801b11:	89 14 24             	mov    %edx,(%esp)
  801b14:	89 d8                	mov    %ebx,%eax
  801b16:	d3 e0                	shl    %cl,%eax
  801b18:	89 c2                	mov    %eax,%edx
  801b1a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1e:	d3 e0                	shl    %cl,%eax
  801b20:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b24:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b28:	89 f1                	mov    %esi,%ecx
  801b2a:	d3 e8                	shr    %cl,%eax
  801b2c:	09 d0                	or     %edx,%eax
  801b2e:	d3 eb                	shr    %cl,%ebx
  801b30:	89 da                	mov    %ebx,%edx
  801b32:	f7 f7                	div    %edi
  801b34:	89 d3                	mov    %edx,%ebx
  801b36:	f7 24 24             	mull   (%esp)
  801b39:	89 c6                	mov    %eax,%esi
  801b3b:	89 d1                	mov    %edx,%ecx
  801b3d:	39 d3                	cmp    %edx,%ebx
  801b3f:	0f 82 87 00 00 00    	jb     801bcc <__umoddi3+0x134>
  801b45:	0f 84 91 00 00 00    	je     801bdc <__umoddi3+0x144>
  801b4b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b4f:	29 f2                	sub    %esi,%edx
  801b51:	19 cb                	sbb    %ecx,%ebx
  801b53:	89 d8                	mov    %ebx,%eax
  801b55:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b59:	d3 e0                	shl    %cl,%eax
  801b5b:	89 e9                	mov    %ebp,%ecx
  801b5d:	d3 ea                	shr    %cl,%edx
  801b5f:	09 d0                	or     %edx,%eax
  801b61:	89 e9                	mov    %ebp,%ecx
  801b63:	d3 eb                	shr    %cl,%ebx
  801b65:	89 da                	mov    %ebx,%edx
  801b67:	83 c4 1c             	add    $0x1c,%esp
  801b6a:	5b                   	pop    %ebx
  801b6b:	5e                   	pop    %esi
  801b6c:	5f                   	pop    %edi
  801b6d:	5d                   	pop    %ebp
  801b6e:	c3                   	ret    
  801b6f:	90                   	nop
  801b70:	89 fd                	mov    %edi,%ebp
  801b72:	85 ff                	test   %edi,%edi
  801b74:	75 0b                	jne    801b81 <__umoddi3+0xe9>
  801b76:	b8 01 00 00 00       	mov    $0x1,%eax
  801b7b:	31 d2                	xor    %edx,%edx
  801b7d:	f7 f7                	div    %edi
  801b7f:	89 c5                	mov    %eax,%ebp
  801b81:	89 f0                	mov    %esi,%eax
  801b83:	31 d2                	xor    %edx,%edx
  801b85:	f7 f5                	div    %ebp
  801b87:	89 c8                	mov    %ecx,%eax
  801b89:	f7 f5                	div    %ebp
  801b8b:	89 d0                	mov    %edx,%eax
  801b8d:	e9 44 ff ff ff       	jmp    801ad6 <__umoddi3+0x3e>
  801b92:	66 90                	xchg   %ax,%ax
  801b94:	89 c8                	mov    %ecx,%eax
  801b96:	89 f2                	mov    %esi,%edx
  801b98:	83 c4 1c             	add    $0x1c,%esp
  801b9b:	5b                   	pop    %ebx
  801b9c:	5e                   	pop    %esi
  801b9d:	5f                   	pop    %edi
  801b9e:	5d                   	pop    %ebp
  801b9f:	c3                   	ret    
  801ba0:	3b 04 24             	cmp    (%esp),%eax
  801ba3:	72 06                	jb     801bab <__umoddi3+0x113>
  801ba5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ba9:	77 0f                	ja     801bba <__umoddi3+0x122>
  801bab:	89 f2                	mov    %esi,%edx
  801bad:	29 f9                	sub    %edi,%ecx
  801baf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bb3:	89 14 24             	mov    %edx,(%esp)
  801bb6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bba:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bbe:	8b 14 24             	mov    (%esp),%edx
  801bc1:	83 c4 1c             	add    $0x1c,%esp
  801bc4:	5b                   	pop    %ebx
  801bc5:	5e                   	pop    %esi
  801bc6:	5f                   	pop    %edi
  801bc7:	5d                   	pop    %ebp
  801bc8:	c3                   	ret    
  801bc9:	8d 76 00             	lea    0x0(%esi),%esi
  801bcc:	2b 04 24             	sub    (%esp),%eax
  801bcf:	19 fa                	sbb    %edi,%edx
  801bd1:	89 d1                	mov    %edx,%ecx
  801bd3:	89 c6                	mov    %eax,%esi
  801bd5:	e9 71 ff ff ff       	jmp    801b4b <__umoddi3+0xb3>
  801bda:	66 90                	xchg   %ax,%ax
  801bdc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801be0:	72 ea                	jb     801bcc <__umoddi3+0x134>
  801be2:	89 d9                	mov    %ebx,%ecx
  801be4:	e9 62 ff ff ff       	jmp    801b4b <__umoddi3+0xb3>
