
obj/user/ef_fos_add:     file format elf32-i386


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
  800031:	e8 60 00 00 00       	call   800096 <libmain>
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

	int i1=0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	i1 = strtol("1", NULL, 10);
  80004c:	83 ec 04             	sub    $0x4,%esp
  80004f:	6a 0a                	push   $0xa
  800051:	6a 00                	push   $0x0
  800053:	68 00 19 80 00       	push   $0x801900
  800058:	e8 34 0c 00 00       	call   800c91 <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	i2 = strtol("2", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 02 19 80 00       	push   $0x801902
  80006f:	e8 1d 0c 00 00       	call   800c91 <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  80007a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 04 19 80 00       	push   $0x801904
  80008b:	e8 4c 02 00 00       	call   8002dc <atomic_cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
	//cprintf("number 1 + number 2 = \n");

	return;
  800093:	90                   	nop
}
  800094:	c9                   	leave  
  800095:	c3                   	ret    

00800096 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800096:	55                   	push   %ebp
  800097:	89 e5                	mov    %esp,%ebp
  800099:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80009c:	e8 39 10 00 00       	call   8010da <sys_getenvindex>
  8000a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a7:	89 d0                	mov    %edx,%eax
  8000a9:	c1 e0 03             	shl    $0x3,%eax
  8000ac:	01 d0                	add    %edx,%eax
  8000ae:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000b5:	01 c8                	add    %ecx,%eax
  8000b7:	01 c0                	add    %eax,%eax
  8000b9:	01 d0                	add    %edx,%eax
  8000bb:	01 c0                	add    %eax,%eax
  8000bd:	01 d0                	add    %edx,%eax
  8000bf:	89 c2                	mov    %eax,%edx
  8000c1:	c1 e2 05             	shl    $0x5,%edx
  8000c4:	29 c2                	sub    %eax,%edx
  8000c6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000cd:	89 c2                	mov    %eax,%edx
  8000cf:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000d5:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000da:	a1 20 20 80 00       	mov    0x802020,%eax
  8000df:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8000e5:	84 c0                	test   %al,%al
  8000e7:	74 0f                	je     8000f8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8000e9:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ee:	05 40 3c 01 00       	add    $0x13c40,%eax
  8000f3:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000f8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000fc:	7e 0a                	jle    800108 <libmain+0x72>
		binaryname = argv[0];
  8000fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800101:	8b 00                	mov    (%eax),%eax
  800103:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800108:	83 ec 08             	sub    $0x8,%esp
  80010b:	ff 75 0c             	pushl  0xc(%ebp)
  80010e:	ff 75 08             	pushl  0x8(%ebp)
  800111:	e8 22 ff ff ff       	call   800038 <_main>
  800116:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800119:	e8 57 11 00 00       	call   801275 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80011e:	83 ec 0c             	sub    $0xc,%esp
  800121:	68 38 19 80 00       	push   $0x801938
  800126:	e8 84 01 00 00       	call   8002af <cprintf>
  80012b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80012e:	a1 20 20 80 00       	mov    0x802020,%eax
  800133:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800139:	a1 20 20 80 00       	mov    0x802020,%eax
  80013e:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800144:	83 ec 04             	sub    $0x4,%esp
  800147:	52                   	push   %edx
  800148:	50                   	push   %eax
  800149:	68 60 19 80 00       	push   $0x801960
  80014e:	e8 5c 01 00 00       	call   8002af <cprintf>
  800153:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800156:	a1 20 20 80 00       	mov    0x802020,%eax
  80015b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800161:	a1 20 20 80 00       	mov    0x802020,%eax
  800166:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	52                   	push   %edx
  800170:	50                   	push   %eax
  800171:	68 88 19 80 00       	push   $0x801988
  800176:	e8 34 01 00 00       	call   8002af <cprintf>
  80017b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80017e:	a1 20 20 80 00       	mov    0x802020,%eax
  800183:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800189:	83 ec 08             	sub    $0x8,%esp
  80018c:	50                   	push   %eax
  80018d:	68 c9 19 80 00       	push   $0x8019c9
  800192:	e8 18 01 00 00       	call   8002af <cprintf>
  800197:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80019a:	83 ec 0c             	sub    $0xc,%esp
  80019d:	68 38 19 80 00       	push   $0x801938
  8001a2:	e8 08 01 00 00       	call   8002af <cprintf>
  8001a7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001aa:	e8 e0 10 00 00       	call   80128f <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001af:	e8 19 00 00 00       	call   8001cd <exit>
}
  8001b4:	90                   	nop
  8001b5:	c9                   	leave  
  8001b6:	c3                   	ret    

008001b7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001b7:	55                   	push   %ebp
  8001b8:	89 e5                	mov    %esp,%ebp
  8001ba:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001bd:	83 ec 0c             	sub    $0xc,%esp
  8001c0:	6a 00                	push   $0x0
  8001c2:	e8 df 0e 00 00       	call   8010a6 <sys_env_destroy>
  8001c7:	83 c4 10             	add    $0x10,%esp
}
  8001ca:	90                   	nop
  8001cb:	c9                   	leave  
  8001cc:	c3                   	ret    

008001cd <exit>:

void
exit(void)
{
  8001cd:	55                   	push   %ebp
  8001ce:	89 e5                	mov    %esp,%ebp
  8001d0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001d3:	e8 34 0f 00 00       	call   80110c <sys_env_exit>
}
  8001d8:	90                   	nop
  8001d9:	c9                   	leave  
  8001da:	c3                   	ret    

008001db <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001db:	55                   	push   %ebp
  8001dc:	89 e5                	mov    %esp,%ebp
  8001de:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e4:	8b 00                	mov    (%eax),%eax
  8001e6:	8d 48 01             	lea    0x1(%eax),%ecx
  8001e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ec:	89 0a                	mov    %ecx,(%edx)
  8001ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8001f1:	88 d1                	mov    %dl,%cl
  8001f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fd:	8b 00                	mov    (%eax),%eax
  8001ff:	3d ff 00 00 00       	cmp    $0xff,%eax
  800204:	75 2c                	jne    800232 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800206:	a0 24 20 80 00       	mov    0x802024,%al
  80020b:	0f b6 c0             	movzbl %al,%eax
  80020e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800211:	8b 12                	mov    (%edx),%edx
  800213:	89 d1                	mov    %edx,%ecx
  800215:	8b 55 0c             	mov    0xc(%ebp),%edx
  800218:	83 c2 08             	add    $0x8,%edx
  80021b:	83 ec 04             	sub    $0x4,%esp
  80021e:	50                   	push   %eax
  80021f:	51                   	push   %ecx
  800220:	52                   	push   %edx
  800221:	e8 3e 0e 00 00       	call   801064 <sys_cputs>
  800226:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800229:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800232:	8b 45 0c             	mov    0xc(%ebp),%eax
  800235:	8b 40 04             	mov    0x4(%eax),%eax
  800238:	8d 50 01             	lea    0x1(%eax),%edx
  80023b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800241:	90                   	nop
  800242:	c9                   	leave  
  800243:	c3                   	ret    

00800244 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800244:	55                   	push   %ebp
  800245:	89 e5                	mov    %esp,%ebp
  800247:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80024d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800254:	00 00 00 
	b.cnt = 0;
  800257:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80025e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800261:	ff 75 0c             	pushl  0xc(%ebp)
  800264:	ff 75 08             	pushl  0x8(%ebp)
  800267:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80026d:	50                   	push   %eax
  80026e:	68 db 01 80 00       	push   $0x8001db
  800273:	e8 11 02 00 00       	call   800489 <vprintfmt>
  800278:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80027b:	a0 24 20 80 00       	mov    0x802024,%al
  800280:	0f b6 c0             	movzbl %al,%eax
  800283:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800289:	83 ec 04             	sub    $0x4,%esp
  80028c:	50                   	push   %eax
  80028d:	52                   	push   %edx
  80028e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800294:	83 c0 08             	add    $0x8,%eax
  800297:	50                   	push   %eax
  800298:	e8 c7 0d 00 00       	call   801064 <sys_cputs>
  80029d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002a0:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002a7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002ad:	c9                   	leave  
  8002ae:	c3                   	ret    

008002af <cprintf>:

int cprintf(const char *fmt, ...) {
  8002af:	55                   	push   %ebp
  8002b0:	89 e5                	mov    %esp,%ebp
  8002b2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002b5:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002bc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c5:	83 ec 08             	sub    $0x8,%esp
  8002c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002cb:	50                   	push   %eax
  8002cc:	e8 73 ff ff ff       	call   800244 <vcprintf>
  8002d1:	83 c4 10             	add    $0x10,%esp
  8002d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002da:	c9                   	leave  
  8002db:	c3                   	ret    

008002dc <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002dc:	55                   	push   %ebp
  8002dd:	89 e5                	mov    %esp,%ebp
  8002df:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002e2:	e8 8e 0f 00 00       	call   801275 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002e7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f0:	83 ec 08             	sub    $0x8,%esp
  8002f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f6:	50                   	push   %eax
  8002f7:	e8 48 ff ff ff       	call   800244 <vcprintf>
  8002fc:	83 c4 10             	add    $0x10,%esp
  8002ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800302:	e8 88 0f 00 00       	call   80128f <sys_enable_interrupt>
	return cnt;
  800307:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80030a:	c9                   	leave  
  80030b:	c3                   	ret    

0080030c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80030c:	55                   	push   %ebp
  80030d:	89 e5                	mov    %esp,%ebp
  80030f:	53                   	push   %ebx
  800310:	83 ec 14             	sub    $0x14,%esp
  800313:	8b 45 10             	mov    0x10(%ebp),%eax
  800316:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800319:	8b 45 14             	mov    0x14(%ebp),%eax
  80031c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80031f:	8b 45 18             	mov    0x18(%ebp),%eax
  800322:	ba 00 00 00 00       	mov    $0x0,%edx
  800327:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032a:	77 55                	ja     800381 <printnum+0x75>
  80032c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032f:	72 05                	jb     800336 <printnum+0x2a>
  800331:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800334:	77 4b                	ja     800381 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800336:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800339:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80033c:	8b 45 18             	mov    0x18(%ebp),%eax
  80033f:	ba 00 00 00 00       	mov    $0x0,%edx
  800344:	52                   	push   %edx
  800345:	50                   	push   %eax
  800346:	ff 75 f4             	pushl  -0xc(%ebp)
  800349:	ff 75 f0             	pushl  -0x10(%ebp)
  80034c:	e8 47 13 00 00       	call   801698 <__udivdi3>
  800351:	83 c4 10             	add    $0x10,%esp
  800354:	83 ec 04             	sub    $0x4,%esp
  800357:	ff 75 20             	pushl  0x20(%ebp)
  80035a:	53                   	push   %ebx
  80035b:	ff 75 18             	pushl  0x18(%ebp)
  80035e:	52                   	push   %edx
  80035f:	50                   	push   %eax
  800360:	ff 75 0c             	pushl  0xc(%ebp)
  800363:	ff 75 08             	pushl  0x8(%ebp)
  800366:	e8 a1 ff ff ff       	call   80030c <printnum>
  80036b:	83 c4 20             	add    $0x20,%esp
  80036e:	eb 1a                	jmp    80038a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800370:	83 ec 08             	sub    $0x8,%esp
  800373:	ff 75 0c             	pushl  0xc(%ebp)
  800376:	ff 75 20             	pushl  0x20(%ebp)
  800379:	8b 45 08             	mov    0x8(%ebp),%eax
  80037c:	ff d0                	call   *%eax
  80037e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800381:	ff 4d 1c             	decl   0x1c(%ebp)
  800384:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800388:	7f e6                	jg     800370 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80038a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80038d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800392:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800395:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800398:	53                   	push   %ebx
  800399:	51                   	push   %ecx
  80039a:	52                   	push   %edx
  80039b:	50                   	push   %eax
  80039c:	e8 07 14 00 00       	call   8017a8 <__umoddi3>
  8003a1:	83 c4 10             	add    $0x10,%esp
  8003a4:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  8003a9:	8a 00                	mov    (%eax),%al
  8003ab:	0f be c0             	movsbl %al,%eax
  8003ae:	83 ec 08             	sub    $0x8,%esp
  8003b1:	ff 75 0c             	pushl  0xc(%ebp)
  8003b4:	50                   	push   %eax
  8003b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b8:	ff d0                	call   *%eax
  8003ba:	83 c4 10             	add    $0x10,%esp
}
  8003bd:	90                   	nop
  8003be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c1:	c9                   	leave  
  8003c2:	c3                   	ret    

008003c3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003c3:	55                   	push   %ebp
  8003c4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ca:	7e 1c                	jle    8003e8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cf:	8b 00                	mov    (%eax),%eax
  8003d1:	8d 50 08             	lea    0x8(%eax),%edx
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	89 10                	mov    %edx,(%eax)
  8003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dc:	8b 00                	mov    (%eax),%eax
  8003de:	83 e8 08             	sub    $0x8,%eax
  8003e1:	8b 50 04             	mov    0x4(%eax),%edx
  8003e4:	8b 00                	mov    (%eax),%eax
  8003e6:	eb 40                	jmp    800428 <getuint+0x65>
	else if (lflag)
  8003e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003ec:	74 1e                	je     80040c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	8d 50 04             	lea    0x4(%eax),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	89 10                	mov    %edx,(%eax)
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	8b 00                	mov    (%eax),%eax
  800400:	83 e8 04             	sub    $0x4,%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	ba 00 00 00 00       	mov    $0x0,%edx
  80040a:	eb 1c                	jmp    800428 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	8d 50 04             	lea    0x4(%eax),%edx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	89 10                	mov    %edx,(%eax)
  800419:	8b 45 08             	mov    0x8(%ebp),%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	83 e8 04             	sub    $0x4,%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800428:	5d                   	pop    %ebp
  800429:	c3                   	ret    

0080042a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80042d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800431:	7e 1c                	jle    80044f <getint+0x25>
		return va_arg(*ap, long long);
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
  800436:	8b 00                	mov    (%eax),%eax
  800438:	8d 50 08             	lea    0x8(%eax),%edx
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	89 10                	mov    %edx,(%eax)
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	83 e8 08             	sub    $0x8,%eax
  800448:	8b 50 04             	mov    0x4(%eax),%edx
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	eb 38                	jmp    800487 <getint+0x5d>
	else if (lflag)
  80044f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800453:	74 1a                	je     80046f <getint+0x45>
		return va_arg(*ap, long);
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	8d 50 04             	lea    0x4(%eax),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	89 10                	mov    %edx,(%eax)
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	8b 00                	mov    (%eax),%eax
  800467:	83 e8 04             	sub    $0x4,%eax
  80046a:	8b 00                	mov    (%eax),%eax
  80046c:	99                   	cltd   
  80046d:	eb 18                	jmp    800487 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	8d 50 04             	lea    0x4(%eax),%edx
  800477:	8b 45 08             	mov    0x8(%ebp),%eax
  80047a:	89 10                	mov    %edx,(%eax)
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	8b 00                	mov    (%eax),%eax
  800481:	83 e8 04             	sub    $0x4,%eax
  800484:	8b 00                	mov    (%eax),%eax
  800486:	99                   	cltd   
}
  800487:	5d                   	pop    %ebp
  800488:	c3                   	ret    

00800489 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800489:	55                   	push   %ebp
  80048a:	89 e5                	mov    %esp,%ebp
  80048c:	56                   	push   %esi
  80048d:	53                   	push   %ebx
  80048e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800491:	eb 17                	jmp    8004aa <vprintfmt+0x21>
			if (ch == '\0')
  800493:	85 db                	test   %ebx,%ebx
  800495:	0f 84 af 03 00 00    	je     80084a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80049b:	83 ec 08             	sub    $0x8,%esp
  80049e:	ff 75 0c             	pushl  0xc(%ebp)
  8004a1:	53                   	push   %ebx
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	ff d0                	call   *%eax
  8004a7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ad:	8d 50 01             	lea    0x1(%eax),%edx
  8004b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b3:	8a 00                	mov    (%eax),%al
  8004b5:	0f b6 d8             	movzbl %al,%ebx
  8004b8:	83 fb 25             	cmp    $0x25,%ebx
  8004bb:	75 d6                	jne    800493 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004bd:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004c1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004c8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004cf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004d6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e0:	8d 50 01             	lea    0x1(%eax),%edx
  8004e3:	89 55 10             	mov    %edx,0x10(%ebp)
  8004e6:	8a 00                	mov    (%eax),%al
  8004e8:	0f b6 d8             	movzbl %al,%ebx
  8004eb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ee:	83 f8 55             	cmp    $0x55,%eax
  8004f1:	0f 87 2b 03 00 00    	ja     800822 <vprintfmt+0x399>
  8004f7:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004fe:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800500:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800504:	eb d7                	jmp    8004dd <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800506:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80050a:	eb d1                	jmp    8004dd <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800513:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800516:	89 d0                	mov    %edx,%eax
  800518:	c1 e0 02             	shl    $0x2,%eax
  80051b:	01 d0                	add    %edx,%eax
  80051d:	01 c0                	add    %eax,%eax
  80051f:	01 d8                	add    %ebx,%eax
  800521:	83 e8 30             	sub    $0x30,%eax
  800524:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800527:	8b 45 10             	mov    0x10(%ebp),%eax
  80052a:	8a 00                	mov    (%eax),%al
  80052c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80052f:	83 fb 2f             	cmp    $0x2f,%ebx
  800532:	7e 3e                	jle    800572 <vprintfmt+0xe9>
  800534:	83 fb 39             	cmp    $0x39,%ebx
  800537:	7f 39                	jg     800572 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800539:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80053c:	eb d5                	jmp    800513 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80053e:	8b 45 14             	mov    0x14(%ebp),%eax
  800541:	83 c0 04             	add    $0x4,%eax
  800544:	89 45 14             	mov    %eax,0x14(%ebp)
  800547:	8b 45 14             	mov    0x14(%ebp),%eax
  80054a:	83 e8 04             	sub    $0x4,%eax
  80054d:	8b 00                	mov    (%eax),%eax
  80054f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800552:	eb 1f                	jmp    800573 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800554:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800558:	79 83                	jns    8004dd <vprintfmt+0x54>
				width = 0;
  80055a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800561:	e9 77 ff ff ff       	jmp    8004dd <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800566:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80056d:	e9 6b ff ff ff       	jmp    8004dd <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800572:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800573:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800577:	0f 89 60 ff ff ff    	jns    8004dd <vprintfmt+0x54>
				width = precision, precision = -1;
  80057d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800580:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800583:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80058a:	e9 4e ff ff ff       	jmp    8004dd <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80058f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800592:	e9 46 ff ff ff       	jmp    8004dd <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800597:	8b 45 14             	mov    0x14(%ebp),%eax
  80059a:	83 c0 04             	add    $0x4,%eax
  80059d:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a3:	83 e8 04             	sub    $0x4,%eax
  8005a6:	8b 00                	mov    (%eax),%eax
  8005a8:	83 ec 08             	sub    $0x8,%esp
  8005ab:	ff 75 0c             	pushl  0xc(%ebp)
  8005ae:	50                   	push   %eax
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	ff d0                	call   *%eax
  8005b4:	83 c4 10             	add    $0x10,%esp
			break;
  8005b7:	e9 89 02 00 00       	jmp    800845 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bf:	83 c0 04             	add    $0x4,%eax
  8005c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c8:	83 e8 04             	sub    $0x4,%eax
  8005cb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005cd:	85 db                	test   %ebx,%ebx
  8005cf:	79 02                	jns    8005d3 <vprintfmt+0x14a>
				err = -err;
  8005d1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005d3:	83 fb 64             	cmp    $0x64,%ebx
  8005d6:	7f 0b                	jg     8005e3 <vprintfmt+0x15a>
  8005d8:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005df:	85 f6                	test   %esi,%esi
  8005e1:	75 19                	jne    8005fc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005e3:	53                   	push   %ebx
  8005e4:	68 05 1c 80 00       	push   $0x801c05
  8005e9:	ff 75 0c             	pushl  0xc(%ebp)
  8005ec:	ff 75 08             	pushl  0x8(%ebp)
  8005ef:	e8 5e 02 00 00       	call   800852 <printfmt>
  8005f4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005f7:	e9 49 02 00 00       	jmp    800845 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005fc:	56                   	push   %esi
  8005fd:	68 0e 1c 80 00       	push   $0x801c0e
  800602:	ff 75 0c             	pushl  0xc(%ebp)
  800605:	ff 75 08             	pushl  0x8(%ebp)
  800608:	e8 45 02 00 00       	call   800852 <printfmt>
  80060d:	83 c4 10             	add    $0x10,%esp
			break;
  800610:	e9 30 02 00 00       	jmp    800845 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800615:	8b 45 14             	mov    0x14(%ebp),%eax
  800618:	83 c0 04             	add    $0x4,%eax
  80061b:	89 45 14             	mov    %eax,0x14(%ebp)
  80061e:	8b 45 14             	mov    0x14(%ebp),%eax
  800621:	83 e8 04             	sub    $0x4,%eax
  800624:	8b 30                	mov    (%eax),%esi
  800626:	85 f6                	test   %esi,%esi
  800628:	75 05                	jne    80062f <vprintfmt+0x1a6>
				p = "(null)";
  80062a:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  80062f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800633:	7e 6d                	jle    8006a2 <vprintfmt+0x219>
  800635:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800639:	74 67                	je     8006a2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80063b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063e:	83 ec 08             	sub    $0x8,%esp
  800641:	50                   	push   %eax
  800642:	56                   	push   %esi
  800643:	e8 0c 03 00 00       	call   800954 <strnlen>
  800648:	83 c4 10             	add    $0x10,%esp
  80064b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80064e:	eb 16                	jmp    800666 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800650:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	50                   	push   %eax
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	ff d0                	call   *%eax
  800660:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800663:	ff 4d e4             	decl   -0x1c(%ebp)
  800666:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066a:	7f e4                	jg     800650 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80066c:	eb 34                	jmp    8006a2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80066e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800672:	74 1c                	je     800690 <vprintfmt+0x207>
  800674:	83 fb 1f             	cmp    $0x1f,%ebx
  800677:	7e 05                	jle    80067e <vprintfmt+0x1f5>
  800679:	83 fb 7e             	cmp    $0x7e,%ebx
  80067c:	7e 12                	jle    800690 <vprintfmt+0x207>
					putch('?', putdat);
  80067e:	83 ec 08             	sub    $0x8,%esp
  800681:	ff 75 0c             	pushl  0xc(%ebp)
  800684:	6a 3f                	push   $0x3f
  800686:	8b 45 08             	mov    0x8(%ebp),%eax
  800689:	ff d0                	call   *%eax
  80068b:	83 c4 10             	add    $0x10,%esp
  80068e:	eb 0f                	jmp    80069f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800690:	83 ec 08             	sub    $0x8,%esp
  800693:	ff 75 0c             	pushl  0xc(%ebp)
  800696:	53                   	push   %ebx
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	ff d0                	call   *%eax
  80069c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80069f:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a2:	89 f0                	mov    %esi,%eax
  8006a4:	8d 70 01             	lea    0x1(%eax),%esi
  8006a7:	8a 00                	mov    (%eax),%al
  8006a9:	0f be d8             	movsbl %al,%ebx
  8006ac:	85 db                	test   %ebx,%ebx
  8006ae:	74 24                	je     8006d4 <vprintfmt+0x24b>
  8006b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b4:	78 b8                	js     80066e <vprintfmt+0x1e5>
  8006b6:	ff 4d e0             	decl   -0x20(%ebp)
  8006b9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006bd:	79 af                	jns    80066e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006bf:	eb 13                	jmp    8006d4 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006c1:	83 ec 08             	sub    $0x8,%esp
  8006c4:	ff 75 0c             	pushl  0xc(%ebp)
  8006c7:	6a 20                	push   $0x20
  8006c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cc:	ff d0                	call   *%eax
  8006ce:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d8:	7f e7                	jg     8006c1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006da:	e9 66 01 00 00       	jmp    800845 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e5:	8d 45 14             	lea    0x14(%ebp),%eax
  8006e8:	50                   	push   %eax
  8006e9:	e8 3c fd ff ff       	call   80042a <getint>
  8006ee:	83 c4 10             	add    $0x10,%esp
  8006f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006fd:	85 d2                	test   %edx,%edx
  8006ff:	79 23                	jns    800724 <vprintfmt+0x29b>
				putch('-', putdat);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	6a 2d                	push   $0x2d
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	ff d0                	call   *%eax
  80070e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800711:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800714:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800717:	f7 d8                	neg    %eax
  800719:	83 d2 00             	adc    $0x0,%edx
  80071c:	f7 da                	neg    %edx
  80071e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800721:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800724:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072b:	e9 bc 00 00 00       	jmp    8007ec <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800730:	83 ec 08             	sub    $0x8,%esp
  800733:	ff 75 e8             	pushl  -0x18(%ebp)
  800736:	8d 45 14             	lea    0x14(%ebp),%eax
  800739:	50                   	push   %eax
  80073a:	e8 84 fc ff ff       	call   8003c3 <getuint>
  80073f:	83 c4 10             	add    $0x10,%esp
  800742:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800745:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800748:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80074f:	e9 98 00 00 00       	jmp    8007ec <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	6a 58                	push   $0x58
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	ff d0                	call   *%eax
  800761:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800764:	83 ec 08             	sub    $0x8,%esp
  800767:	ff 75 0c             	pushl  0xc(%ebp)
  80076a:	6a 58                	push   $0x58
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	ff d0                	call   *%eax
  800771:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	ff 75 0c             	pushl  0xc(%ebp)
  80077a:	6a 58                	push   $0x58
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	ff d0                	call   *%eax
  800781:	83 c4 10             	add    $0x10,%esp
			break;
  800784:	e9 bc 00 00 00       	jmp    800845 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	6a 30                	push   $0x30
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	ff d0                	call   *%eax
  800796:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800799:	83 ec 08             	sub    $0x8,%esp
  80079c:	ff 75 0c             	pushl  0xc(%ebp)
  80079f:	6a 78                	push   $0x78
  8007a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a4:	ff d0                	call   *%eax
  8007a6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ac:	83 c0 04             	add    $0x4,%eax
  8007af:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b5:	83 e8 04             	sub    $0x4,%eax
  8007b8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007c4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007cb:	eb 1f                	jmp    8007ec <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007cd:	83 ec 08             	sub    $0x8,%esp
  8007d0:	ff 75 e8             	pushl  -0x18(%ebp)
  8007d3:	8d 45 14             	lea    0x14(%ebp),%eax
  8007d6:	50                   	push   %eax
  8007d7:	e8 e7 fb ff ff       	call   8003c3 <getuint>
  8007dc:	83 c4 10             	add    $0x10,%esp
  8007df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007e5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007ec:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007f3:	83 ec 04             	sub    $0x4,%esp
  8007f6:	52                   	push   %edx
  8007f7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007fa:	50                   	push   %eax
  8007fb:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fe:	ff 75 f0             	pushl  -0x10(%ebp)
  800801:	ff 75 0c             	pushl  0xc(%ebp)
  800804:	ff 75 08             	pushl  0x8(%ebp)
  800807:	e8 00 fb ff ff       	call   80030c <printnum>
  80080c:	83 c4 20             	add    $0x20,%esp
			break;
  80080f:	eb 34                	jmp    800845 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800811:	83 ec 08             	sub    $0x8,%esp
  800814:	ff 75 0c             	pushl  0xc(%ebp)
  800817:	53                   	push   %ebx
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	ff d0                	call   *%eax
  80081d:	83 c4 10             	add    $0x10,%esp
			break;
  800820:	eb 23                	jmp    800845 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800822:	83 ec 08             	sub    $0x8,%esp
  800825:	ff 75 0c             	pushl  0xc(%ebp)
  800828:	6a 25                	push   $0x25
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800832:	ff 4d 10             	decl   0x10(%ebp)
  800835:	eb 03                	jmp    80083a <vprintfmt+0x3b1>
  800837:	ff 4d 10             	decl   0x10(%ebp)
  80083a:	8b 45 10             	mov    0x10(%ebp),%eax
  80083d:	48                   	dec    %eax
  80083e:	8a 00                	mov    (%eax),%al
  800840:	3c 25                	cmp    $0x25,%al
  800842:	75 f3                	jne    800837 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800844:	90                   	nop
		}
	}
  800845:	e9 47 fc ff ff       	jmp    800491 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80084a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80084b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80084e:	5b                   	pop    %ebx
  80084f:	5e                   	pop    %esi
  800850:	5d                   	pop    %ebp
  800851:	c3                   	ret    

00800852 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800852:	55                   	push   %ebp
  800853:	89 e5                	mov    %esp,%ebp
  800855:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800858:	8d 45 10             	lea    0x10(%ebp),%eax
  80085b:	83 c0 04             	add    $0x4,%eax
  80085e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800861:	8b 45 10             	mov    0x10(%ebp),%eax
  800864:	ff 75 f4             	pushl  -0xc(%ebp)
  800867:	50                   	push   %eax
  800868:	ff 75 0c             	pushl  0xc(%ebp)
  80086b:	ff 75 08             	pushl  0x8(%ebp)
  80086e:	e8 16 fc ff ff       	call   800489 <vprintfmt>
  800873:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800876:	90                   	nop
  800877:	c9                   	leave  
  800878:	c3                   	ret    

00800879 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800879:	55                   	push   %ebp
  80087a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80087c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087f:	8b 40 08             	mov    0x8(%eax),%eax
  800882:	8d 50 01             	lea    0x1(%eax),%edx
  800885:	8b 45 0c             	mov    0xc(%ebp),%eax
  800888:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80088b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088e:	8b 10                	mov    (%eax),%edx
  800890:	8b 45 0c             	mov    0xc(%ebp),%eax
  800893:	8b 40 04             	mov    0x4(%eax),%eax
  800896:	39 c2                	cmp    %eax,%edx
  800898:	73 12                	jae    8008ac <sprintputch+0x33>
		*b->buf++ = ch;
  80089a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089d:	8b 00                	mov    (%eax),%eax
  80089f:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a5:	89 0a                	mov    %ecx,(%edx)
  8008a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8008aa:	88 10                	mov    %dl,(%eax)
}
  8008ac:	90                   	nop
  8008ad:	5d                   	pop    %ebp
  8008ae:	c3                   	ret    

008008af <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008af:	55                   	push   %ebp
  8008b0:	89 e5                	mov    %esp,%ebp
  8008b2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008be:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	01 d0                	add    %edx,%eax
  8008c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008d0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008d4:	74 06                	je     8008dc <vsnprintf+0x2d>
  8008d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008da:	7f 07                	jg     8008e3 <vsnprintf+0x34>
		return -E_INVAL;
  8008dc:	b8 03 00 00 00       	mov    $0x3,%eax
  8008e1:	eb 20                	jmp    800903 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008e3:	ff 75 14             	pushl  0x14(%ebp)
  8008e6:	ff 75 10             	pushl  0x10(%ebp)
  8008e9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008ec:	50                   	push   %eax
  8008ed:	68 79 08 80 00       	push   $0x800879
  8008f2:	e8 92 fb ff ff       	call   800489 <vprintfmt>
  8008f7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008fd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800900:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800903:	c9                   	leave  
  800904:	c3                   	ret    

00800905 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800905:	55                   	push   %ebp
  800906:	89 e5                	mov    %esp,%ebp
  800908:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80090b:	8d 45 10             	lea    0x10(%ebp),%eax
  80090e:	83 c0 04             	add    $0x4,%eax
  800911:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800914:	8b 45 10             	mov    0x10(%ebp),%eax
  800917:	ff 75 f4             	pushl  -0xc(%ebp)
  80091a:	50                   	push   %eax
  80091b:	ff 75 0c             	pushl  0xc(%ebp)
  80091e:	ff 75 08             	pushl  0x8(%ebp)
  800921:	e8 89 ff ff ff       	call   8008af <vsnprintf>
  800926:	83 c4 10             	add    $0x10,%esp
  800929:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80092c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80092f:	c9                   	leave  
  800930:	c3                   	ret    

00800931 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800931:	55                   	push   %ebp
  800932:	89 e5                	mov    %esp,%ebp
  800934:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800937:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80093e:	eb 06                	jmp    800946 <strlen+0x15>
		n++;
  800940:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800943:	ff 45 08             	incl   0x8(%ebp)
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	8a 00                	mov    (%eax),%al
  80094b:	84 c0                	test   %al,%al
  80094d:	75 f1                	jne    800940 <strlen+0xf>
		n++;
	return n;
  80094f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800952:	c9                   	leave  
  800953:	c3                   	ret    

00800954 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800954:	55                   	push   %ebp
  800955:	89 e5                	mov    %esp,%ebp
  800957:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80095a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800961:	eb 09                	jmp    80096c <strnlen+0x18>
		n++;
  800963:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800966:	ff 45 08             	incl   0x8(%ebp)
  800969:	ff 4d 0c             	decl   0xc(%ebp)
  80096c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800970:	74 09                	je     80097b <strnlen+0x27>
  800972:	8b 45 08             	mov    0x8(%ebp),%eax
  800975:	8a 00                	mov    (%eax),%al
  800977:	84 c0                	test   %al,%al
  800979:	75 e8                	jne    800963 <strnlen+0xf>
		n++;
	return n;
  80097b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097e:	c9                   	leave  
  80097f:	c3                   	ret    

00800980 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800980:	55                   	push   %ebp
  800981:	89 e5                	mov    %esp,%ebp
  800983:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80098c:	90                   	nop
  80098d:	8b 45 08             	mov    0x8(%ebp),%eax
  800990:	8d 50 01             	lea    0x1(%eax),%edx
  800993:	89 55 08             	mov    %edx,0x8(%ebp)
  800996:	8b 55 0c             	mov    0xc(%ebp),%edx
  800999:	8d 4a 01             	lea    0x1(%edx),%ecx
  80099c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80099f:	8a 12                	mov    (%edx),%dl
  8009a1:	88 10                	mov    %dl,(%eax)
  8009a3:	8a 00                	mov    (%eax),%al
  8009a5:	84 c0                	test   %al,%al
  8009a7:	75 e4                	jne    80098d <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ac:	c9                   	leave  
  8009ad:	c3                   	ret    

008009ae <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009ae:	55                   	push   %ebp
  8009af:	89 e5                	mov    %esp,%ebp
  8009b1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c1:	eb 1f                	jmp    8009e2 <strncpy+0x34>
		*dst++ = *src;
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	8d 50 01             	lea    0x1(%eax),%edx
  8009c9:	89 55 08             	mov    %edx,0x8(%ebp)
  8009cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cf:	8a 12                	mov    (%edx),%dl
  8009d1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d6:	8a 00                	mov    (%eax),%al
  8009d8:	84 c0                	test   %al,%al
  8009da:	74 03                	je     8009df <strncpy+0x31>
			src++;
  8009dc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009df:	ff 45 fc             	incl   -0x4(%ebp)
  8009e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009e5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009e8:	72 d9                	jb     8009c3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009ed:	c9                   	leave  
  8009ee:	c3                   	ret    

008009ef <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009ef:	55                   	push   %ebp
  8009f0:	89 e5                	mov    %esp,%ebp
  8009f2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ff:	74 30                	je     800a31 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a01:	eb 16                	jmp    800a19 <strlcpy+0x2a>
			*dst++ = *src++;
  800a03:	8b 45 08             	mov    0x8(%ebp),%eax
  800a06:	8d 50 01             	lea    0x1(%eax),%edx
  800a09:	89 55 08             	mov    %edx,0x8(%ebp)
  800a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a12:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a15:	8a 12                	mov    (%edx),%dl
  800a17:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a19:	ff 4d 10             	decl   0x10(%ebp)
  800a1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a20:	74 09                	je     800a2b <strlcpy+0x3c>
  800a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a25:	8a 00                	mov    (%eax),%al
  800a27:	84 c0                	test   %al,%al
  800a29:	75 d8                	jne    800a03 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a31:	8b 55 08             	mov    0x8(%ebp),%edx
  800a34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a37:	29 c2                	sub    %eax,%edx
  800a39:	89 d0                	mov    %edx,%eax
}
  800a3b:	c9                   	leave  
  800a3c:	c3                   	ret    

00800a3d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a3d:	55                   	push   %ebp
  800a3e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a40:	eb 06                	jmp    800a48 <strcmp+0xb>
		p++, q++;
  800a42:	ff 45 08             	incl   0x8(%ebp)
  800a45:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	8a 00                	mov    (%eax),%al
  800a4d:	84 c0                	test   %al,%al
  800a4f:	74 0e                	je     800a5f <strcmp+0x22>
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	8a 10                	mov    (%eax),%dl
  800a56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a59:	8a 00                	mov    (%eax),%al
  800a5b:	38 c2                	cmp    %al,%dl
  800a5d:	74 e3                	je     800a42 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	8a 00                	mov    (%eax),%al
  800a64:	0f b6 d0             	movzbl %al,%edx
  800a67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6a:	8a 00                	mov    (%eax),%al
  800a6c:	0f b6 c0             	movzbl %al,%eax
  800a6f:	29 c2                	sub    %eax,%edx
  800a71:	89 d0                	mov    %edx,%eax
}
  800a73:	5d                   	pop    %ebp
  800a74:	c3                   	ret    

00800a75 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a75:	55                   	push   %ebp
  800a76:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a78:	eb 09                	jmp    800a83 <strncmp+0xe>
		n--, p++, q++;
  800a7a:	ff 4d 10             	decl   0x10(%ebp)
  800a7d:	ff 45 08             	incl   0x8(%ebp)
  800a80:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a87:	74 17                	je     800aa0 <strncmp+0x2b>
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	8a 00                	mov    (%eax),%al
  800a8e:	84 c0                	test   %al,%al
  800a90:	74 0e                	je     800aa0 <strncmp+0x2b>
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	8a 10                	mov    (%eax),%dl
  800a97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9a:	8a 00                	mov    (%eax),%al
  800a9c:	38 c2                	cmp    %al,%dl
  800a9e:	74 da                	je     800a7a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aa0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa4:	75 07                	jne    800aad <strncmp+0x38>
		return 0;
  800aa6:	b8 00 00 00 00       	mov    $0x0,%eax
  800aab:	eb 14                	jmp    800ac1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	8a 00                	mov    (%eax),%al
  800ab2:	0f b6 d0             	movzbl %al,%edx
  800ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab8:	8a 00                	mov    (%eax),%al
  800aba:	0f b6 c0             	movzbl %al,%eax
  800abd:	29 c2                	sub    %eax,%edx
  800abf:	89 d0                	mov    %edx,%eax
}
  800ac1:	5d                   	pop    %ebp
  800ac2:	c3                   	ret    

00800ac3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ac3:	55                   	push   %ebp
  800ac4:	89 e5                	mov    %esp,%ebp
  800ac6:	83 ec 04             	sub    $0x4,%esp
  800ac9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800acf:	eb 12                	jmp    800ae3 <strchr+0x20>
		if (*s == c)
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	8a 00                	mov    (%eax),%al
  800ad6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad9:	75 05                	jne    800ae0 <strchr+0x1d>
			return (char *) s;
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	eb 11                	jmp    800af1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ae0:	ff 45 08             	incl   0x8(%ebp)
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8a 00                	mov    (%eax),%al
  800ae8:	84 c0                	test   %al,%al
  800aea:	75 e5                	jne    800ad1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800aec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800af1:	c9                   	leave  
  800af2:	c3                   	ret    

00800af3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
  800af6:	83 ec 04             	sub    $0x4,%esp
  800af9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aff:	eb 0d                	jmp    800b0e <strfind+0x1b>
		if (*s == c)
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	8a 00                	mov    (%eax),%al
  800b06:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b09:	74 0e                	je     800b19 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b0b:	ff 45 08             	incl   0x8(%ebp)
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	8a 00                	mov    (%eax),%al
  800b13:	84 c0                	test   %al,%al
  800b15:	75 ea                	jne    800b01 <strfind+0xe>
  800b17:	eb 01                	jmp    800b1a <strfind+0x27>
		if (*s == c)
			break;
  800b19:	90                   	nop
	return (char *) s;
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1d:	c9                   	leave  
  800b1e:	c3                   	ret    

00800b1f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b31:	eb 0e                	jmp    800b41 <memset+0x22>
		*p++ = c;
  800b33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b36:	8d 50 01             	lea    0x1(%eax),%edx
  800b39:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b3f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b41:	ff 4d f8             	decl   -0x8(%ebp)
  800b44:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b48:	79 e9                	jns    800b33 <memset+0x14>
		*p++ = c;

	return v;
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b4d:	c9                   	leave  
  800b4e:	c3                   	ret    

00800b4f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
  800b52:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b58:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b61:	eb 16                	jmp    800b79 <memcpy+0x2a>
		*d++ = *s++;
  800b63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b66:	8d 50 01             	lea    0x1(%eax),%edx
  800b69:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b6f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b72:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b75:	8a 12                	mov    (%edx),%dl
  800b77:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b79:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b82:	85 c0                	test   %eax,%eax
  800b84:	75 dd                	jne    800b63 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b89:	c9                   	leave  
  800b8a:	c3                   	ret    

00800b8b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b8b:	55                   	push   %ebp
  800b8c:	89 e5                	mov    %esp,%ebp
  800b8e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ba3:	73 50                	jae    800bf5 <memmove+0x6a>
  800ba5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ba8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bab:	01 d0                	add    %edx,%eax
  800bad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bb0:	76 43                	jbe    800bf5 <memmove+0x6a>
		s += n;
  800bb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bbe:	eb 10                	jmp    800bd0 <memmove+0x45>
			*--d = *--s;
  800bc0:	ff 4d f8             	decl   -0x8(%ebp)
  800bc3:	ff 4d fc             	decl   -0x4(%ebp)
  800bc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc9:	8a 10                	mov    (%eax),%dl
  800bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bce:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd9:	85 c0                	test   %eax,%eax
  800bdb:	75 e3                	jne    800bc0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bdd:	eb 23                	jmp    800c02 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bdf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be2:	8d 50 01             	lea    0x1(%eax),%edx
  800be5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800be8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800beb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bf1:	8a 12                	mov    (%edx),%dl
  800bf3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bf5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bfe:	85 c0                	test   %eax,%eax
  800c00:	75 dd                	jne    800bdf <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c05:	c9                   	leave  
  800c06:	c3                   	ret    

00800c07 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c07:	55                   	push   %ebp
  800c08:	89 e5                	mov    %esp,%ebp
  800c0a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c16:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c19:	eb 2a                	jmp    800c45 <memcmp+0x3e>
		if (*s1 != *s2)
  800c1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c1e:	8a 10                	mov    (%eax),%dl
  800c20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c23:	8a 00                	mov    (%eax),%al
  800c25:	38 c2                	cmp    %al,%dl
  800c27:	74 16                	je     800c3f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2c:	8a 00                	mov    (%eax),%al
  800c2e:	0f b6 d0             	movzbl %al,%edx
  800c31:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c34:	8a 00                	mov    (%eax),%al
  800c36:	0f b6 c0             	movzbl %al,%eax
  800c39:	29 c2                	sub    %eax,%edx
  800c3b:	89 d0                	mov    %edx,%eax
  800c3d:	eb 18                	jmp    800c57 <memcmp+0x50>
		s1++, s2++;
  800c3f:	ff 45 fc             	incl   -0x4(%ebp)
  800c42:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c45:	8b 45 10             	mov    0x10(%ebp),%eax
  800c48:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c4b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4e:	85 c0                	test   %eax,%eax
  800c50:	75 c9                	jne    800c1b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c57:	c9                   	leave  
  800c58:	c3                   	ret    

00800c59 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c59:	55                   	push   %ebp
  800c5a:	89 e5                	mov    %esp,%ebp
  800c5c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c5f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c62:	8b 45 10             	mov    0x10(%ebp),%eax
  800c65:	01 d0                	add    %edx,%eax
  800c67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c6a:	eb 15                	jmp    800c81 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	8a 00                	mov    (%eax),%al
  800c71:	0f b6 d0             	movzbl %al,%edx
  800c74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c77:	0f b6 c0             	movzbl %al,%eax
  800c7a:	39 c2                	cmp    %eax,%edx
  800c7c:	74 0d                	je     800c8b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c7e:	ff 45 08             	incl   0x8(%ebp)
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c87:	72 e3                	jb     800c6c <memfind+0x13>
  800c89:	eb 01                	jmp    800c8c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c8b:	90                   	nop
	return (void *) s;
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c9e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca5:	eb 03                	jmp    800caa <strtol+0x19>
		s++;
  800ca7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	3c 20                	cmp    $0x20,%al
  800cb1:	74 f4                	je     800ca7 <strtol+0x16>
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	8a 00                	mov    (%eax),%al
  800cb8:	3c 09                	cmp    $0x9,%al
  800cba:	74 eb                	je     800ca7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	3c 2b                	cmp    $0x2b,%al
  800cc3:	75 05                	jne    800cca <strtol+0x39>
		s++;
  800cc5:	ff 45 08             	incl   0x8(%ebp)
  800cc8:	eb 13                	jmp    800cdd <strtol+0x4c>
	else if (*s == '-')
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8a 00                	mov    (%eax),%al
  800ccf:	3c 2d                	cmp    $0x2d,%al
  800cd1:	75 0a                	jne    800cdd <strtol+0x4c>
		s++, neg = 1;
  800cd3:	ff 45 08             	incl   0x8(%ebp)
  800cd6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cdd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce1:	74 06                	je     800ce9 <strtol+0x58>
  800ce3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ce7:	75 20                	jne    800d09 <strtol+0x78>
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	3c 30                	cmp    $0x30,%al
  800cf0:	75 17                	jne    800d09 <strtol+0x78>
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	40                   	inc    %eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	3c 78                	cmp    $0x78,%al
  800cfa:	75 0d                	jne    800d09 <strtol+0x78>
		s += 2, base = 16;
  800cfc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d00:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d07:	eb 28                	jmp    800d31 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0d:	75 15                	jne    800d24 <strtol+0x93>
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	3c 30                	cmp    $0x30,%al
  800d16:	75 0c                	jne    800d24 <strtol+0x93>
		s++, base = 8;
  800d18:	ff 45 08             	incl   0x8(%ebp)
  800d1b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d22:	eb 0d                	jmp    800d31 <strtol+0xa0>
	else if (base == 0)
  800d24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d28:	75 07                	jne    800d31 <strtol+0xa0>
		base = 10;
  800d2a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	3c 2f                	cmp    $0x2f,%al
  800d38:	7e 19                	jle    800d53 <strtol+0xc2>
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	3c 39                	cmp    $0x39,%al
  800d41:	7f 10                	jg     800d53 <strtol+0xc2>
			dig = *s - '0';
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	0f be c0             	movsbl %al,%eax
  800d4b:	83 e8 30             	sub    $0x30,%eax
  800d4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d51:	eb 42                	jmp    800d95 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	8a 00                	mov    (%eax),%al
  800d58:	3c 60                	cmp    $0x60,%al
  800d5a:	7e 19                	jle    800d75 <strtol+0xe4>
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	3c 7a                	cmp    $0x7a,%al
  800d63:	7f 10                	jg     800d75 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	0f be c0             	movsbl %al,%eax
  800d6d:	83 e8 57             	sub    $0x57,%eax
  800d70:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d73:	eb 20                	jmp    800d95 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	3c 40                	cmp    $0x40,%al
  800d7c:	7e 39                	jle    800db7 <strtol+0x126>
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	3c 5a                	cmp    $0x5a,%al
  800d85:	7f 30                	jg     800db7 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	0f be c0             	movsbl %al,%eax
  800d8f:	83 e8 37             	sub    $0x37,%eax
  800d92:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d95:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d98:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d9b:	7d 19                	jge    800db6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d9d:	ff 45 08             	incl   0x8(%ebp)
  800da0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da3:	0f af 45 10          	imul   0x10(%ebp),%eax
  800da7:	89 c2                	mov    %eax,%edx
  800da9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dac:	01 d0                	add    %edx,%eax
  800dae:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800db1:	e9 7b ff ff ff       	jmp    800d31 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800db6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800db7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dbb:	74 08                	je     800dc5 <strtol+0x134>
		*endptr = (char *) s;
  800dbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc0:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dc5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dc9:	74 07                	je     800dd2 <strtol+0x141>
  800dcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dce:	f7 d8                	neg    %eax
  800dd0:	eb 03                	jmp    800dd5 <strtol+0x144>
  800dd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dd5:	c9                   	leave  
  800dd6:	c3                   	ret    

00800dd7 <ltostr>:

void
ltostr(long value, char *str)
{
  800dd7:	55                   	push   %ebp
  800dd8:	89 e5                	mov    %esp,%ebp
  800dda:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ddd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800de4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800deb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800def:	79 13                	jns    800e04 <ltostr+0x2d>
	{
		neg = 1;
  800df1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800df8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dfe:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e01:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
  800e07:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e0c:	99                   	cltd   
  800e0d:	f7 f9                	idiv   %ecx
  800e0f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e12:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e15:	8d 50 01             	lea    0x1(%eax),%edx
  800e18:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e1b:	89 c2                	mov    %eax,%edx
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	01 d0                	add    %edx,%eax
  800e22:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e25:	83 c2 30             	add    $0x30,%edx
  800e28:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e2a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e2d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e32:	f7 e9                	imul   %ecx
  800e34:	c1 fa 02             	sar    $0x2,%edx
  800e37:	89 c8                	mov    %ecx,%eax
  800e39:	c1 f8 1f             	sar    $0x1f,%eax
  800e3c:	29 c2                	sub    %eax,%edx
  800e3e:	89 d0                	mov    %edx,%eax
  800e40:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e43:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e46:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e4b:	f7 e9                	imul   %ecx
  800e4d:	c1 fa 02             	sar    $0x2,%edx
  800e50:	89 c8                	mov    %ecx,%eax
  800e52:	c1 f8 1f             	sar    $0x1f,%eax
  800e55:	29 c2                	sub    %eax,%edx
  800e57:	89 d0                	mov    %edx,%eax
  800e59:	c1 e0 02             	shl    $0x2,%eax
  800e5c:	01 d0                	add    %edx,%eax
  800e5e:	01 c0                	add    %eax,%eax
  800e60:	29 c1                	sub    %eax,%ecx
  800e62:	89 ca                	mov    %ecx,%edx
  800e64:	85 d2                	test   %edx,%edx
  800e66:	75 9c                	jne    800e04 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e6f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e72:	48                   	dec    %eax
  800e73:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e76:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e7a:	74 3d                	je     800eb9 <ltostr+0xe2>
		start = 1 ;
  800e7c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e83:	eb 34                	jmp    800eb9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e85:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8b:	01 d0                	add    %edx,%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e92:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	01 c2                	add    %eax,%edx
  800e9a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea0:	01 c8                	add    %ecx,%eax
  800ea2:	8a 00                	mov    (%eax),%al
  800ea4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ea6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eac:	01 c2                	add    %eax,%edx
  800eae:	8a 45 eb             	mov    -0x15(%ebp),%al
  800eb1:	88 02                	mov    %al,(%edx)
		start++ ;
  800eb3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800eb6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ebc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ebf:	7c c4                	jl     800e85 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ec1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ec4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec7:	01 d0                	add    %edx,%eax
  800ec9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ecc:	90                   	nop
  800ecd:	c9                   	leave  
  800ece:	c3                   	ret    

00800ecf <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ecf:	55                   	push   %ebp
  800ed0:	89 e5                	mov    %esp,%ebp
  800ed2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ed5:	ff 75 08             	pushl  0x8(%ebp)
  800ed8:	e8 54 fa ff ff       	call   800931 <strlen>
  800edd:	83 c4 04             	add    $0x4,%esp
  800ee0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ee3:	ff 75 0c             	pushl  0xc(%ebp)
  800ee6:	e8 46 fa ff ff       	call   800931 <strlen>
  800eeb:	83 c4 04             	add    $0x4,%esp
  800eee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ef1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ef8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eff:	eb 17                	jmp    800f18 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f01:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f04:	8b 45 10             	mov    0x10(%ebp),%eax
  800f07:	01 c2                	add    %eax,%edx
  800f09:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	01 c8                	add    %ecx,%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f15:	ff 45 fc             	incl   -0x4(%ebp)
  800f18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f1e:	7c e1                	jl     800f01 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f20:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f27:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f2e:	eb 1f                	jmp    800f4f <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f33:	8d 50 01             	lea    0x1(%eax),%edx
  800f36:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f39:	89 c2                	mov    %eax,%edx
  800f3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3e:	01 c2                	add    %eax,%edx
  800f40:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f46:	01 c8                	add    %ecx,%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f4c:	ff 45 f8             	incl   -0x8(%ebp)
  800f4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f52:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f55:	7c d9                	jl     800f30 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f57:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5d:	01 d0                	add    %edx,%eax
  800f5f:	c6 00 00             	movb   $0x0,(%eax)
}
  800f62:	90                   	nop
  800f63:	c9                   	leave  
  800f64:	c3                   	ret    

00800f65 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f65:	55                   	push   %ebp
  800f66:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f68:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f71:	8b 45 14             	mov    0x14(%ebp),%eax
  800f74:	8b 00                	mov    (%eax),%eax
  800f76:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f80:	01 d0                	add    %edx,%eax
  800f82:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f88:	eb 0c                	jmp    800f96 <strsplit+0x31>
			*string++ = 0;
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8d 50 01             	lea    0x1(%eax),%edx
  800f90:	89 55 08             	mov    %edx,0x8(%ebp)
  800f93:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	84 c0                	test   %al,%al
  800f9d:	74 18                	je     800fb7 <strsplit+0x52>
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	0f be c0             	movsbl %al,%eax
  800fa7:	50                   	push   %eax
  800fa8:	ff 75 0c             	pushl  0xc(%ebp)
  800fab:	e8 13 fb ff ff       	call   800ac3 <strchr>
  800fb0:	83 c4 08             	add    $0x8,%esp
  800fb3:	85 c0                	test   %eax,%eax
  800fb5:	75 d3                	jne    800f8a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	84 c0                	test   %al,%al
  800fbe:	74 5a                	je     80101a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fc0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc3:	8b 00                	mov    (%eax),%eax
  800fc5:	83 f8 0f             	cmp    $0xf,%eax
  800fc8:	75 07                	jne    800fd1 <strsplit+0x6c>
		{
			return 0;
  800fca:	b8 00 00 00 00       	mov    $0x0,%eax
  800fcf:	eb 66                	jmp    801037 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd4:	8b 00                	mov    (%eax),%eax
  800fd6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd9:	8b 55 14             	mov    0x14(%ebp),%edx
  800fdc:	89 0a                	mov    %ecx,(%edx)
  800fde:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe8:	01 c2                	add    %eax,%edx
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fef:	eb 03                	jmp    800ff4 <strsplit+0x8f>
			string++;
  800ff1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	8a 00                	mov    (%eax),%al
  800ff9:	84 c0                	test   %al,%al
  800ffb:	74 8b                	je     800f88 <strsplit+0x23>
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	0f be c0             	movsbl %al,%eax
  801005:	50                   	push   %eax
  801006:	ff 75 0c             	pushl  0xc(%ebp)
  801009:	e8 b5 fa ff ff       	call   800ac3 <strchr>
  80100e:	83 c4 08             	add    $0x8,%esp
  801011:	85 c0                	test   %eax,%eax
  801013:	74 dc                	je     800ff1 <strsplit+0x8c>
			string++;
	}
  801015:	e9 6e ff ff ff       	jmp    800f88 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80101a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80101b:	8b 45 14             	mov    0x14(%ebp),%eax
  80101e:	8b 00                	mov    (%eax),%eax
  801020:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801027:	8b 45 10             	mov    0x10(%ebp),%eax
  80102a:	01 d0                	add    %edx,%eax
  80102c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801032:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801037:	c9                   	leave  
  801038:	c3                   	ret    

00801039 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801039:	55                   	push   %ebp
  80103a:	89 e5                	mov    %esp,%ebp
  80103c:	57                   	push   %edi
  80103d:	56                   	push   %esi
  80103e:	53                   	push   %ebx
  80103f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	8b 55 0c             	mov    0xc(%ebp),%edx
  801048:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80104b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80104e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801051:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801054:	cd 30                	int    $0x30
  801056:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801059:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80105c:	83 c4 10             	add    $0x10,%esp
  80105f:	5b                   	pop    %ebx
  801060:	5e                   	pop    %esi
  801061:	5f                   	pop    %edi
  801062:	5d                   	pop    %ebp
  801063:	c3                   	ret    

00801064 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801064:	55                   	push   %ebp
  801065:	89 e5                	mov    %esp,%ebp
  801067:	83 ec 04             	sub    $0x4,%esp
  80106a:	8b 45 10             	mov    0x10(%ebp),%eax
  80106d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801070:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	52                   	push   %edx
  80107c:	ff 75 0c             	pushl  0xc(%ebp)
  80107f:	50                   	push   %eax
  801080:	6a 00                	push   $0x0
  801082:	e8 b2 ff ff ff       	call   801039 <syscall>
  801087:	83 c4 18             	add    $0x18,%esp
}
  80108a:	90                   	nop
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <sys_cgetc>:

int
sys_cgetc(void)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 01                	push   $0x1
  80109c:	e8 98 ff ff ff       	call   801039 <syscall>
  8010a1:	83 c4 18             	add    $0x18,%esp
}
  8010a4:	c9                   	leave  
  8010a5:	c3                   	ret    

008010a6 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010a6:	55                   	push   %ebp
  8010a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	50                   	push   %eax
  8010b5:	6a 05                	push   $0x5
  8010b7:	e8 7d ff ff ff       	call   801039 <syscall>
  8010bc:	83 c4 18             	add    $0x18,%esp
}
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 00                	push   $0x0
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 02                	push   $0x2
  8010d0:	e8 64 ff ff ff       	call   801039 <syscall>
  8010d5:	83 c4 18             	add    $0x18,%esp
}
  8010d8:	c9                   	leave  
  8010d9:	c3                   	ret    

008010da <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010da:	55                   	push   %ebp
  8010db:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 00                	push   $0x0
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 00                	push   $0x0
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 03                	push   $0x3
  8010e9:	e8 4b ff ff ff       	call   801039 <syscall>
  8010ee:	83 c4 18             	add    $0x18,%esp
}
  8010f1:	c9                   	leave  
  8010f2:	c3                   	ret    

008010f3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 00                	push   $0x0
  8010fa:	6a 00                	push   $0x0
  8010fc:	6a 00                	push   $0x0
  8010fe:	6a 00                	push   $0x0
  801100:	6a 04                	push   $0x4
  801102:	e8 32 ff ff ff       	call   801039 <syscall>
  801107:	83 c4 18             	add    $0x18,%esp
}
  80110a:	c9                   	leave  
  80110b:	c3                   	ret    

0080110c <sys_env_exit>:


void sys_env_exit(void)
{
  80110c:	55                   	push   %ebp
  80110d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80110f:	6a 00                	push   $0x0
  801111:	6a 00                	push   $0x0
  801113:	6a 00                	push   $0x0
  801115:	6a 00                	push   $0x0
  801117:	6a 00                	push   $0x0
  801119:	6a 06                	push   $0x6
  80111b:	e8 19 ff ff ff       	call   801039 <syscall>
  801120:	83 c4 18             	add    $0x18,%esp
}
  801123:	90                   	nop
  801124:	c9                   	leave  
  801125:	c3                   	ret    

00801126 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801126:	55                   	push   %ebp
  801127:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801129:	8b 55 0c             	mov    0xc(%ebp),%edx
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	6a 00                	push   $0x0
  801131:	6a 00                	push   $0x0
  801133:	6a 00                	push   $0x0
  801135:	52                   	push   %edx
  801136:	50                   	push   %eax
  801137:	6a 07                	push   $0x7
  801139:	e8 fb fe ff ff       	call   801039 <syscall>
  80113e:	83 c4 18             	add    $0x18,%esp
}
  801141:	c9                   	leave  
  801142:	c3                   	ret    

00801143 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
  801146:	56                   	push   %esi
  801147:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801148:	8b 75 18             	mov    0x18(%ebp),%esi
  80114b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80114e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801151:	8b 55 0c             	mov    0xc(%ebp),%edx
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	56                   	push   %esi
  801158:	53                   	push   %ebx
  801159:	51                   	push   %ecx
  80115a:	52                   	push   %edx
  80115b:	50                   	push   %eax
  80115c:	6a 08                	push   $0x8
  80115e:	e8 d6 fe ff ff       	call   801039 <syscall>
  801163:	83 c4 18             	add    $0x18,%esp
}
  801166:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801169:	5b                   	pop    %ebx
  80116a:	5e                   	pop    %esi
  80116b:	5d                   	pop    %ebp
  80116c:	c3                   	ret    

0080116d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801170:	8b 55 0c             	mov    0xc(%ebp),%edx
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	52                   	push   %edx
  80117d:	50                   	push   %eax
  80117e:	6a 09                	push   $0x9
  801180:	e8 b4 fe ff ff       	call   801039 <syscall>
  801185:	83 c4 18             	add    $0x18,%esp
}
  801188:	c9                   	leave  
  801189:	c3                   	ret    

0080118a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80118a:	55                   	push   %ebp
  80118b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	ff 75 0c             	pushl  0xc(%ebp)
  801196:	ff 75 08             	pushl  0x8(%ebp)
  801199:	6a 0a                	push   $0xa
  80119b:	e8 99 fe ff ff       	call   801039 <syscall>
  8011a0:	83 c4 18             	add    $0x18,%esp
}
  8011a3:	c9                   	leave  
  8011a4:	c3                   	ret    

008011a5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011a5:	55                   	push   %ebp
  8011a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 0b                	push   $0xb
  8011b4:	e8 80 fe ff ff       	call   801039 <syscall>
  8011b9:	83 c4 18             	add    $0x18,%esp
}
  8011bc:	c9                   	leave  
  8011bd:	c3                   	ret    

008011be <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011be:	55                   	push   %ebp
  8011bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 0c                	push   $0xc
  8011cd:	e8 67 fe ff ff       	call   801039 <syscall>
  8011d2:	83 c4 18             	add    $0x18,%esp
}
  8011d5:	c9                   	leave  
  8011d6:	c3                   	ret    

008011d7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011d7:	55                   	push   %ebp
  8011d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 0d                	push   $0xd
  8011e6:	e8 4e fe ff ff       	call   801039 <syscall>
  8011eb:	83 c4 18             	add    $0x18,%esp
}
  8011ee:	c9                   	leave  
  8011ef:	c3                   	ret    

008011f0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011f0:	55                   	push   %ebp
  8011f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 00                	push   $0x0
  8011f7:	6a 00                	push   $0x0
  8011f9:	ff 75 0c             	pushl  0xc(%ebp)
  8011fc:	ff 75 08             	pushl  0x8(%ebp)
  8011ff:	6a 11                	push   $0x11
  801201:	e8 33 fe ff ff       	call   801039 <syscall>
  801206:	83 c4 18             	add    $0x18,%esp
	return;
  801209:	90                   	nop
}
  80120a:	c9                   	leave  
  80120b:	c3                   	ret    

0080120c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80120c:	55                   	push   %ebp
  80120d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80120f:	6a 00                	push   $0x0
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	ff 75 0c             	pushl  0xc(%ebp)
  801218:	ff 75 08             	pushl  0x8(%ebp)
  80121b:	6a 12                	push   $0x12
  80121d:	e8 17 fe ff ff       	call   801039 <syscall>
  801222:	83 c4 18             	add    $0x18,%esp
	return ;
  801225:	90                   	nop
}
  801226:	c9                   	leave  
  801227:	c3                   	ret    

00801228 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801228:	55                   	push   %ebp
  801229:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 0e                	push   $0xe
  801237:	e8 fd fd ff ff       	call   801039 <syscall>
  80123c:	83 c4 18             	add    $0x18,%esp
}
  80123f:	c9                   	leave  
  801240:	c3                   	ret    

00801241 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801241:	55                   	push   %ebp
  801242:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801244:	6a 00                	push   $0x0
  801246:	6a 00                	push   $0x0
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	ff 75 08             	pushl  0x8(%ebp)
  80124f:	6a 0f                	push   $0xf
  801251:	e8 e3 fd ff ff       	call   801039 <syscall>
  801256:	83 c4 18             	add    $0x18,%esp
}
  801259:	c9                   	leave  
  80125a:	c3                   	ret    

0080125b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 10                	push   $0x10
  80126a:	e8 ca fd ff ff       	call   801039 <syscall>
  80126f:	83 c4 18             	add    $0x18,%esp
}
  801272:	90                   	nop
  801273:	c9                   	leave  
  801274:	c3                   	ret    

00801275 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801275:	55                   	push   %ebp
  801276:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801278:	6a 00                	push   $0x0
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 14                	push   $0x14
  801284:	e8 b0 fd ff ff       	call   801039 <syscall>
  801289:	83 c4 18             	add    $0x18,%esp
}
  80128c:	90                   	nop
  80128d:	c9                   	leave  
  80128e:	c3                   	ret    

0080128f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801292:	6a 00                	push   $0x0
  801294:	6a 00                	push   $0x0
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 15                	push   $0x15
  80129e:	e8 96 fd ff ff       	call   801039 <syscall>
  8012a3:	83 c4 18             	add    $0x18,%esp
}
  8012a6:	90                   	nop
  8012a7:	c9                   	leave  
  8012a8:	c3                   	ret    

008012a9 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012a9:	55                   	push   %ebp
  8012aa:	89 e5                	mov    %esp,%ebp
  8012ac:	83 ec 04             	sub    $0x4,%esp
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012b5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	50                   	push   %eax
  8012c2:	6a 16                	push   $0x16
  8012c4:	e8 70 fd ff ff       	call   801039 <syscall>
  8012c9:	83 c4 18             	add    $0x18,%esp
}
  8012cc:	90                   	nop
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 17                	push   $0x17
  8012de:	e8 56 fd ff ff       	call   801039 <syscall>
  8012e3:	83 c4 18             	add    $0x18,%esp
}
  8012e6:	90                   	nop
  8012e7:	c9                   	leave  
  8012e8:	c3                   	ret    

008012e9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	ff 75 0c             	pushl  0xc(%ebp)
  8012f8:	50                   	push   %eax
  8012f9:	6a 18                	push   $0x18
  8012fb:	e8 39 fd ff ff       	call   801039 <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801308:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	52                   	push   %edx
  801315:	50                   	push   %eax
  801316:	6a 1b                	push   $0x1b
  801318:	e8 1c fd ff ff       	call   801039 <syscall>
  80131d:	83 c4 18             	add    $0x18,%esp
}
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801325:	8b 55 0c             	mov    0xc(%ebp),%edx
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	52                   	push   %edx
  801332:	50                   	push   %eax
  801333:	6a 19                	push   $0x19
  801335:	e8 ff fc ff ff       	call   801039 <syscall>
  80133a:	83 c4 18             	add    $0x18,%esp
}
  80133d:	90                   	nop
  80133e:	c9                   	leave  
  80133f:	c3                   	ret    

00801340 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801343:	8b 55 0c             	mov    0xc(%ebp),%edx
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	52                   	push   %edx
  801350:	50                   	push   %eax
  801351:	6a 1a                	push   $0x1a
  801353:	e8 e1 fc ff ff       	call   801039 <syscall>
  801358:	83 c4 18             	add    $0x18,%esp
}
  80135b:	90                   	nop
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
  801361:	83 ec 04             	sub    $0x4,%esp
  801364:	8b 45 10             	mov    0x10(%ebp),%eax
  801367:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80136a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80136d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	6a 00                	push   $0x0
  801376:	51                   	push   %ecx
  801377:	52                   	push   %edx
  801378:	ff 75 0c             	pushl  0xc(%ebp)
  80137b:	50                   	push   %eax
  80137c:	6a 1c                	push   $0x1c
  80137e:	e8 b6 fc ff ff       	call   801039 <syscall>
  801383:	83 c4 18             	add    $0x18,%esp
}
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80138b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	6a 00                	push   $0x0
  801397:	52                   	push   %edx
  801398:	50                   	push   %eax
  801399:	6a 1d                	push   $0x1d
  80139b:	e8 99 fc ff ff       	call   801039 <syscall>
  8013a0:	83 c4 18             	add    $0x18,%esp
}
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	51                   	push   %ecx
  8013b6:	52                   	push   %edx
  8013b7:	50                   	push   %eax
  8013b8:	6a 1e                	push   $0x1e
  8013ba:	e8 7a fc ff ff       	call   801039 <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	52                   	push   %edx
  8013d4:	50                   	push   %eax
  8013d5:	6a 1f                	push   $0x1f
  8013d7:	e8 5d fc ff ff       	call   801039 <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
}
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 20                	push   $0x20
  8013f0:	e8 44 fc ff ff       	call   801039 <syscall>
  8013f5:	83 c4 18             	add    $0x18,%esp
}
  8013f8:	c9                   	leave  
  8013f9:	c3                   	ret    

008013fa <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013fa:	55                   	push   %ebp
  8013fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	6a 00                	push   $0x0
  801402:	ff 75 14             	pushl  0x14(%ebp)
  801405:	ff 75 10             	pushl  0x10(%ebp)
  801408:	ff 75 0c             	pushl  0xc(%ebp)
  80140b:	50                   	push   %eax
  80140c:	6a 21                	push   $0x21
  80140e:	e8 26 fc ff ff       	call   801039 <syscall>
  801413:	83 c4 18             	add    $0x18,%esp
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	50                   	push   %eax
  801427:	6a 22                	push   $0x22
  801429:	e8 0b fc ff ff       	call   801039 <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
}
  801431:	90                   	nop
  801432:	c9                   	leave  
  801433:	c3                   	ret    

00801434 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801434:	55                   	push   %ebp
  801435:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	50                   	push   %eax
  801443:	6a 23                	push   $0x23
  801445:	e8 ef fb ff ff       	call   801039 <syscall>
  80144a:	83 c4 18             	add    $0x18,%esp
}
  80144d:	90                   	nop
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
  801453:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801456:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801459:	8d 50 04             	lea    0x4(%eax),%edx
  80145c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	52                   	push   %edx
  801466:	50                   	push   %eax
  801467:	6a 24                	push   $0x24
  801469:	e8 cb fb ff ff       	call   801039 <syscall>
  80146e:	83 c4 18             	add    $0x18,%esp
	return result;
  801471:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801474:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801477:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147a:	89 01                	mov    %eax,(%ecx)
  80147c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	c9                   	leave  
  801483:	c2 04 00             	ret    $0x4

00801486 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801486:	55                   	push   %ebp
  801487:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	ff 75 10             	pushl  0x10(%ebp)
  801490:	ff 75 0c             	pushl  0xc(%ebp)
  801493:	ff 75 08             	pushl  0x8(%ebp)
  801496:	6a 13                	push   $0x13
  801498:	e8 9c fb ff ff       	call   801039 <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a0:	90                   	nop
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 25                	push   $0x25
  8014b2:	e8 82 fb ff ff       	call   801039 <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
  8014bf:	83 ec 04             	sub    $0x4,%esp
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014c8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	50                   	push   %eax
  8014d5:	6a 26                	push   $0x26
  8014d7:	e8 5d fb ff ff       	call   801039 <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8014df:	90                   	nop
}
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <rsttst>:
void rsttst()
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 28                	push   $0x28
  8014f1:	e8 43 fb ff ff       	call   801039 <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f9:	90                   	nop
}
  8014fa:	c9                   	leave  
  8014fb:	c3                   	ret    

008014fc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014fc:	55                   	push   %ebp
  8014fd:	89 e5                	mov    %esp,%ebp
  8014ff:	83 ec 04             	sub    $0x4,%esp
  801502:	8b 45 14             	mov    0x14(%ebp),%eax
  801505:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801508:	8b 55 18             	mov    0x18(%ebp),%edx
  80150b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80150f:	52                   	push   %edx
  801510:	50                   	push   %eax
  801511:	ff 75 10             	pushl  0x10(%ebp)
  801514:	ff 75 0c             	pushl  0xc(%ebp)
  801517:	ff 75 08             	pushl  0x8(%ebp)
  80151a:	6a 27                	push   $0x27
  80151c:	e8 18 fb ff ff       	call   801039 <syscall>
  801521:	83 c4 18             	add    $0x18,%esp
	return ;
  801524:	90                   	nop
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <chktst>:
void chktst(uint32 n)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	ff 75 08             	pushl  0x8(%ebp)
  801535:	6a 29                	push   $0x29
  801537:	e8 fd fa ff ff       	call   801039 <syscall>
  80153c:	83 c4 18             	add    $0x18,%esp
	return ;
  80153f:	90                   	nop
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <inctst>:

void inctst()
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 2a                	push   $0x2a
  801551:	e8 e3 fa ff ff       	call   801039 <syscall>
  801556:	83 c4 18             	add    $0x18,%esp
	return ;
  801559:	90                   	nop
}
  80155a:	c9                   	leave  
  80155b:	c3                   	ret    

0080155c <gettst>:
uint32 gettst()
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 2b                	push   $0x2b
  80156b:	e8 c9 fa ff ff       	call   801039 <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
  801578:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 2c                	push   $0x2c
  801587:	e8 ad fa ff ff       	call   801039 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
  80158f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801592:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801596:	75 07                	jne    80159f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801598:	b8 01 00 00 00       	mov    $0x1,%eax
  80159d:	eb 05                	jmp    8015a4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80159f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
  8015a9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 2c                	push   $0x2c
  8015b8:	e8 7c fa ff ff       	call   801039 <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
  8015c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015c3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015c7:	75 07                	jne    8015d0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ce:	eb 05                	jmp    8015d5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
  8015da:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 2c                	push   $0x2c
  8015e9:	e8 4b fa ff ff       	call   801039 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
  8015f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015f4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015f8:	75 07                	jne    801601 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ff:	eb 05                	jmp    801606 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801601:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
  80160b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 2c                	push   $0x2c
  80161a:	e8 1a fa ff ff       	call   801039 <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
  801622:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801625:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801629:	75 07                	jne    801632 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80162b:	b8 01 00 00 00       	mov    $0x1,%eax
  801630:	eb 05                	jmp    801637 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801632:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	ff 75 08             	pushl  0x8(%ebp)
  801647:	6a 2d                	push   $0x2d
  801649:	e8 eb f9 ff ff       	call   801039 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
	return ;
  801651:	90                   	nop
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
  801657:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801658:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80165b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80165e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	6a 00                	push   $0x0
  801666:	53                   	push   %ebx
  801667:	51                   	push   %ecx
  801668:	52                   	push   %edx
  801669:	50                   	push   %eax
  80166a:	6a 2e                	push   $0x2e
  80166c:	e8 c8 f9 ff ff       	call   801039 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801677:	c9                   	leave  
  801678:	c3                   	ret    

00801679 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801679:	55                   	push   %ebp
  80167a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80167c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	52                   	push   %edx
  801689:	50                   	push   %eax
  80168a:	6a 2f                	push   $0x2f
  80168c:	e8 a8 f9 ff ff       	call   801039 <syscall>
  801691:	83 c4 18             	add    $0x18,%esp
}
  801694:	c9                   	leave  
  801695:	c3                   	ret    
  801696:	66 90                	xchg   %ax,%ax

00801698 <__udivdi3>:
  801698:	55                   	push   %ebp
  801699:	57                   	push   %edi
  80169a:	56                   	push   %esi
  80169b:	53                   	push   %ebx
  80169c:	83 ec 1c             	sub    $0x1c,%esp
  80169f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016af:	89 ca                	mov    %ecx,%edx
  8016b1:	89 f8                	mov    %edi,%eax
  8016b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016b7:	85 f6                	test   %esi,%esi
  8016b9:	75 2d                	jne    8016e8 <__udivdi3+0x50>
  8016bb:	39 cf                	cmp    %ecx,%edi
  8016bd:	77 65                	ja     801724 <__udivdi3+0x8c>
  8016bf:	89 fd                	mov    %edi,%ebp
  8016c1:	85 ff                	test   %edi,%edi
  8016c3:	75 0b                	jne    8016d0 <__udivdi3+0x38>
  8016c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ca:	31 d2                	xor    %edx,%edx
  8016cc:	f7 f7                	div    %edi
  8016ce:	89 c5                	mov    %eax,%ebp
  8016d0:	31 d2                	xor    %edx,%edx
  8016d2:	89 c8                	mov    %ecx,%eax
  8016d4:	f7 f5                	div    %ebp
  8016d6:	89 c1                	mov    %eax,%ecx
  8016d8:	89 d8                	mov    %ebx,%eax
  8016da:	f7 f5                	div    %ebp
  8016dc:	89 cf                	mov    %ecx,%edi
  8016de:	89 fa                	mov    %edi,%edx
  8016e0:	83 c4 1c             	add    $0x1c,%esp
  8016e3:	5b                   	pop    %ebx
  8016e4:	5e                   	pop    %esi
  8016e5:	5f                   	pop    %edi
  8016e6:	5d                   	pop    %ebp
  8016e7:	c3                   	ret    
  8016e8:	39 ce                	cmp    %ecx,%esi
  8016ea:	77 28                	ja     801714 <__udivdi3+0x7c>
  8016ec:	0f bd fe             	bsr    %esi,%edi
  8016ef:	83 f7 1f             	xor    $0x1f,%edi
  8016f2:	75 40                	jne    801734 <__udivdi3+0x9c>
  8016f4:	39 ce                	cmp    %ecx,%esi
  8016f6:	72 0a                	jb     801702 <__udivdi3+0x6a>
  8016f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016fc:	0f 87 9e 00 00 00    	ja     8017a0 <__udivdi3+0x108>
  801702:	b8 01 00 00 00       	mov    $0x1,%eax
  801707:	89 fa                	mov    %edi,%edx
  801709:	83 c4 1c             	add    $0x1c,%esp
  80170c:	5b                   	pop    %ebx
  80170d:	5e                   	pop    %esi
  80170e:	5f                   	pop    %edi
  80170f:	5d                   	pop    %ebp
  801710:	c3                   	ret    
  801711:	8d 76 00             	lea    0x0(%esi),%esi
  801714:	31 ff                	xor    %edi,%edi
  801716:	31 c0                	xor    %eax,%eax
  801718:	89 fa                	mov    %edi,%edx
  80171a:	83 c4 1c             	add    $0x1c,%esp
  80171d:	5b                   	pop    %ebx
  80171e:	5e                   	pop    %esi
  80171f:	5f                   	pop    %edi
  801720:	5d                   	pop    %ebp
  801721:	c3                   	ret    
  801722:	66 90                	xchg   %ax,%ax
  801724:	89 d8                	mov    %ebx,%eax
  801726:	f7 f7                	div    %edi
  801728:	31 ff                	xor    %edi,%edi
  80172a:	89 fa                	mov    %edi,%edx
  80172c:	83 c4 1c             	add    $0x1c,%esp
  80172f:	5b                   	pop    %ebx
  801730:	5e                   	pop    %esi
  801731:	5f                   	pop    %edi
  801732:	5d                   	pop    %ebp
  801733:	c3                   	ret    
  801734:	bd 20 00 00 00       	mov    $0x20,%ebp
  801739:	89 eb                	mov    %ebp,%ebx
  80173b:	29 fb                	sub    %edi,%ebx
  80173d:	89 f9                	mov    %edi,%ecx
  80173f:	d3 e6                	shl    %cl,%esi
  801741:	89 c5                	mov    %eax,%ebp
  801743:	88 d9                	mov    %bl,%cl
  801745:	d3 ed                	shr    %cl,%ebp
  801747:	89 e9                	mov    %ebp,%ecx
  801749:	09 f1                	or     %esi,%ecx
  80174b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80174f:	89 f9                	mov    %edi,%ecx
  801751:	d3 e0                	shl    %cl,%eax
  801753:	89 c5                	mov    %eax,%ebp
  801755:	89 d6                	mov    %edx,%esi
  801757:	88 d9                	mov    %bl,%cl
  801759:	d3 ee                	shr    %cl,%esi
  80175b:	89 f9                	mov    %edi,%ecx
  80175d:	d3 e2                	shl    %cl,%edx
  80175f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 e8                	shr    %cl,%eax
  801767:	09 c2                	or     %eax,%edx
  801769:	89 d0                	mov    %edx,%eax
  80176b:	89 f2                	mov    %esi,%edx
  80176d:	f7 74 24 0c          	divl   0xc(%esp)
  801771:	89 d6                	mov    %edx,%esi
  801773:	89 c3                	mov    %eax,%ebx
  801775:	f7 e5                	mul    %ebp
  801777:	39 d6                	cmp    %edx,%esi
  801779:	72 19                	jb     801794 <__udivdi3+0xfc>
  80177b:	74 0b                	je     801788 <__udivdi3+0xf0>
  80177d:	89 d8                	mov    %ebx,%eax
  80177f:	31 ff                	xor    %edi,%edi
  801781:	e9 58 ff ff ff       	jmp    8016de <__udivdi3+0x46>
  801786:	66 90                	xchg   %ax,%ax
  801788:	8b 54 24 08          	mov    0x8(%esp),%edx
  80178c:	89 f9                	mov    %edi,%ecx
  80178e:	d3 e2                	shl    %cl,%edx
  801790:	39 c2                	cmp    %eax,%edx
  801792:	73 e9                	jae    80177d <__udivdi3+0xe5>
  801794:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801797:	31 ff                	xor    %edi,%edi
  801799:	e9 40 ff ff ff       	jmp    8016de <__udivdi3+0x46>
  80179e:	66 90                	xchg   %ax,%ax
  8017a0:	31 c0                	xor    %eax,%eax
  8017a2:	e9 37 ff ff ff       	jmp    8016de <__udivdi3+0x46>
  8017a7:	90                   	nop

008017a8 <__umoddi3>:
  8017a8:	55                   	push   %ebp
  8017a9:	57                   	push   %edi
  8017aa:	56                   	push   %esi
  8017ab:	53                   	push   %ebx
  8017ac:	83 ec 1c             	sub    $0x1c,%esp
  8017af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017c7:	89 f3                	mov    %esi,%ebx
  8017c9:	89 fa                	mov    %edi,%edx
  8017cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017cf:	89 34 24             	mov    %esi,(%esp)
  8017d2:	85 c0                	test   %eax,%eax
  8017d4:	75 1a                	jne    8017f0 <__umoddi3+0x48>
  8017d6:	39 f7                	cmp    %esi,%edi
  8017d8:	0f 86 a2 00 00 00    	jbe    801880 <__umoddi3+0xd8>
  8017de:	89 c8                	mov    %ecx,%eax
  8017e0:	89 f2                	mov    %esi,%edx
  8017e2:	f7 f7                	div    %edi
  8017e4:	89 d0                	mov    %edx,%eax
  8017e6:	31 d2                	xor    %edx,%edx
  8017e8:	83 c4 1c             	add    $0x1c,%esp
  8017eb:	5b                   	pop    %ebx
  8017ec:	5e                   	pop    %esi
  8017ed:	5f                   	pop    %edi
  8017ee:	5d                   	pop    %ebp
  8017ef:	c3                   	ret    
  8017f0:	39 f0                	cmp    %esi,%eax
  8017f2:	0f 87 ac 00 00 00    	ja     8018a4 <__umoddi3+0xfc>
  8017f8:	0f bd e8             	bsr    %eax,%ebp
  8017fb:	83 f5 1f             	xor    $0x1f,%ebp
  8017fe:	0f 84 ac 00 00 00    	je     8018b0 <__umoddi3+0x108>
  801804:	bf 20 00 00 00       	mov    $0x20,%edi
  801809:	29 ef                	sub    %ebp,%edi
  80180b:	89 fe                	mov    %edi,%esi
  80180d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801811:	89 e9                	mov    %ebp,%ecx
  801813:	d3 e0                	shl    %cl,%eax
  801815:	89 d7                	mov    %edx,%edi
  801817:	89 f1                	mov    %esi,%ecx
  801819:	d3 ef                	shr    %cl,%edi
  80181b:	09 c7                	or     %eax,%edi
  80181d:	89 e9                	mov    %ebp,%ecx
  80181f:	d3 e2                	shl    %cl,%edx
  801821:	89 14 24             	mov    %edx,(%esp)
  801824:	89 d8                	mov    %ebx,%eax
  801826:	d3 e0                	shl    %cl,%eax
  801828:	89 c2                	mov    %eax,%edx
  80182a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80182e:	d3 e0                	shl    %cl,%eax
  801830:	89 44 24 04          	mov    %eax,0x4(%esp)
  801834:	8b 44 24 08          	mov    0x8(%esp),%eax
  801838:	89 f1                	mov    %esi,%ecx
  80183a:	d3 e8                	shr    %cl,%eax
  80183c:	09 d0                	or     %edx,%eax
  80183e:	d3 eb                	shr    %cl,%ebx
  801840:	89 da                	mov    %ebx,%edx
  801842:	f7 f7                	div    %edi
  801844:	89 d3                	mov    %edx,%ebx
  801846:	f7 24 24             	mull   (%esp)
  801849:	89 c6                	mov    %eax,%esi
  80184b:	89 d1                	mov    %edx,%ecx
  80184d:	39 d3                	cmp    %edx,%ebx
  80184f:	0f 82 87 00 00 00    	jb     8018dc <__umoddi3+0x134>
  801855:	0f 84 91 00 00 00    	je     8018ec <__umoddi3+0x144>
  80185b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80185f:	29 f2                	sub    %esi,%edx
  801861:	19 cb                	sbb    %ecx,%ebx
  801863:	89 d8                	mov    %ebx,%eax
  801865:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801869:	d3 e0                	shl    %cl,%eax
  80186b:	89 e9                	mov    %ebp,%ecx
  80186d:	d3 ea                	shr    %cl,%edx
  80186f:	09 d0                	or     %edx,%eax
  801871:	89 e9                	mov    %ebp,%ecx
  801873:	d3 eb                	shr    %cl,%ebx
  801875:	89 da                	mov    %ebx,%edx
  801877:	83 c4 1c             	add    $0x1c,%esp
  80187a:	5b                   	pop    %ebx
  80187b:	5e                   	pop    %esi
  80187c:	5f                   	pop    %edi
  80187d:	5d                   	pop    %ebp
  80187e:	c3                   	ret    
  80187f:	90                   	nop
  801880:	89 fd                	mov    %edi,%ebp
  801882:	85 ff                	test   %edi,%edi
  801884:	75 0b                	jne    801891 <__umoddi3+0xe9>
  801886:	b8 01 00 00 00       	mov    $0x1,%eax
  80188b:	31 d2                	xor    %edx,%edx
  80188d:	f7 f7                	div    %edi
  80188f:	89 c5                	mov    %eax,%ebp
  801891:	89 f0                	mov    %esi,%eax
  801893:	31 d2                	xor    %edx,%edx
  801895:	f7 f5                	div    %ebp
  801897:	89 c8                	mov    %ecx,%eax
  801899:	f7 f5                	div    %ebp
  80189b:	89 d0                	mov    %edx,%eax
  80189d:	e9 44 ff ff ff       	jmp    8017e6 <__umoddi3+0x3e>
  8018a2:	66 90                	xchg   %ax,%ax
  8018a4:	89 c8                	mov    %ecx,%eax
  8018a6:	89 f2                	mov    %esi,%edx
  8018a8:	83 c4 1c             	add    $0x1c,%esp
  8018ab:	5b                   	pop    %ebx
  8018ac:	5e                   	pop    %esi
  8018ad:	5f                   	pop    %edi
  8018ae:	5d                   	pop    %ebp
  8018af:	c3                   	ret    
  8018b0:	3b 04 24             	cmp    (%esp),%eax
  8018b3:	72 06                	jb     8018bb <__umoddi3+0x113>
  8018b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018b9:	77 0f                	ja     8018ca <__umoddi3+0x122>
  8018bb:	89 f2                	mov    %esi,%edx
  8018bd:	29 f9                	sub    %edi,%ecx
  8018bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018c3:	89 14 24             	mov    %edx,(%esp)
  8018c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018ce:	8b 14 24             	mov    (%esp),%edx
  8018d1:	83 c4 1c             	add    $0x1c,%esp
  8018d4:	5b                   	pop    %ebx
  8018d5:	5e                   	pop    %esi
  8018d6:	5f                   	pop    %edi
  8018d7:	5d                   	pop    %ebp
  8018d8:	c3                   	ret    
  8018d9:	8d 76 00             	lea    0x0(%esi),%esi
  8018dc:	2b 04 24             	sub    (%esp),%eax
  8018df:	19 fa                	sbb    %edi,%edx
  8018e1:	89 d1                	mov    %edx,%ecx
  8018e3:	89 c6                	mov    %eax,%esi
  8018e5:	e9 71 ff ff ff       	jmp    80185b <__umoddi3+0xb3>
  8018ea:	66 90                	xchg   %ax,%ax
  8018ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018f0:	72 ea                	jb     8018dc <__umoddi3+0x134>
  8018f2:	89 d9                	mov    %ebx,%ecx
  8018f4:	e9 62 ff ff ff       	jmp    80185b <__umoddi3+0xb3>
