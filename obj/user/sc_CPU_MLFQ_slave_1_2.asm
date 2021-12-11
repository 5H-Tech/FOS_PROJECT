
obj/user/sc_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 3d 00 00 00       	call   800073 <libmain>
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
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(int i = 0; i < 5; i++)
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004c:	eb 09                	jmp    800057 <_main+0x1f>
		sum+=i;
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	01 45 f4             	add    %eax,-0xc(%ebp)
_main(void)
{
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
	for(int i = 0; i < 5; i++)
  800054:	ff 45 f0             	incl   -0x10(%ebp)
  800057:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80005b:	7e f1                	jle    80004e <_main+0x16>
		sum+=i;

	//int x = busy_wait(RAND(500000, 1000000));
	int x = busy_wait(100000);
  80005d:	83 ec 0c             	sub    $0xc,%esp
  800060:	68 a0 86 01 00       	push   $0x186a0
  800065:	e8 9e 16 00 00       	call   801708 <busy_wait>
  80006a:	83 c4 10             	add    $0x10,%esp
  80006d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//env_sleep(10);
}
  800070:	90                   	nop
  800071:	c9                   	leave  
  800072:	c3                   	ret    

00800073 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800073:	55                   	push   %ebp
  800074:	89 e5                	mov    %esp,%ebp
  800076:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800079:	e8 39 10 00 00       	call   8010b7 <sys_getenvindex>
  80007e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800081:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800084:	89 d0                	mov    %edx,%eax
  800086:	c1 e0 03             	shl    $0x3,%eax
  800089:	01 d0                	add    %edx,%eax
  80008b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800092:	01 c8                	add    %ecx,%eax
  800094:	01 c0                	add    %eax,%eax
  800096:	01 d0                	add    %edx,%eax
  800098:	01 c0                	add    %eax,%eax
  80009a:	01 d0                	add    %edx,%eax
  80009c:	89 c2                	mov    %eax,%edx
  80009e:	c1 e2 05             	shl    $0x5,%edx
  8000a1:	29 c2                	sub    %eax,%edx
  8000a3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000aa:	89 c2                	mov    %eax,%edx
  8000ac:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000b2:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000b7:	a1 20 20 80 00       	mov    0x802020,%eax
  8000bc:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8000c2:	84 c0                	test   %al,%al
  8000c4:	74 0f                	je     8000d5 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8000c6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000cb:	05 40 3c 01 00       	add    $0x13c40,%eax
  8000d0:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000d9:	7e 0a                	jle    8000e5 <libmain+0x72>
		binaryname = argv[0];
  8000db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000de:	8b 00                	mov    (%eax),%eax
  8000e0:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000e5:	83 ec 08             	sub    $0x8,%esp
  8000e8:	ff 75 0c             	pushl  0xc(%ebp)
  8000eb:	ff 75 08             	pushl  0x8(%ebp)
  8000ee:	e8 45 ff ff ff       	call   800038 <_main>
  8000f3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000f6:	e8 57 11 00 00       	call   801252 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 b8 19 80 00       	push   $0x8019b8
  800103:	e8 84 01 00 00       	call   80028c <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80010b:	a1 20 20 80 00       	mov    0x802020,%eax
  800110:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800116:	a1 20 20 80 00       	mov    0x802020,%eax
  80011b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800121:	83 ec 04             	sub    $0x4,%esp
  800124:	52                   	push   %edx
  800125:	50                   	push   %eax
  800126:	68 e0 19 80 00       	push   $0x8019e0
  80012b:	e8 5c 01 00 00       	call   80028c <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800133:	a1 20 20 80 00       	mov    0x802020,%eax
  800138:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80013e:	a1 20 20 80 00       	mov    0x802020,%eax
  800143:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800149:	83 ec 04             	sub    $0x4,%esp
  80014c:	52                   	push   %edx
  80014d:	50                   	push   %eax
  80014e:	68 08 1a 80 00       	push   $0x801a08
  800153:	e8 34 01 00 00       	call   80028c <cprintf>
  800158:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80015b:	a1 20 20 80 00       	mov    0x802020,%eax
  800160:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800166:	83 ec 08             	sub    $0x8,%esp
  800169:	50                   	push   %eax
  80016a:	68 49 1a 80 00       	push   $0x801a49
  80016f:	e8 18 01 00 00       	call   80028c <cprintf>
  800174:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800177:	83 ec 0c             	sub    $0xc,%esp
  80017a:	68 b8 19 80 00       	push   $0x8019b8
  80017f:	e8 08 01 00 00       	call   80028c <cprintf>
  800184:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800187:	e8 e0 10 00 00       	call   80126c <sys_enable_interrupt>

	// exit gracefully
	exit();
  80018c:	e8 19 00 00 00       	call   8001aa <exit>
}
  800191:	90                   	nop
  800192:	c9                   	leave  
  800193:	c3                   	ret    

00800194 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800194:	55                   	push   %ebp
  800195:	89 e5                	mov    %esp,%ebp
  800197:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80019a:	83 ec 0c             	sub    $0xc,%esp
  80019d:	6a 00                	push   $0x0
  80019f:	e8 df 0e 00 00       	call   801083 <sys_env_destroy>
  8001a4:	83 c4 10             	add    $0x10,%esp
}
  8001a7:	90                   	nop
  8001a8:	c9                   	leave  
  8001a9:	c3                   	ret    

008001aa <exit>:

void
exit(void)
{
  8001aa:	55                   	push   %ebp
  8001ab:	89 e5                	mov    %esp,%ebp
  8001ad:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001b0:	e8 34 0f 00 00       	call   8010e9 <sys_env_exit>
}
  8001b5:	90                   	nop
  8001b6:	c9                   	leave  
  8001b7:	c3                   	ret    

008001b8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001b8:	55                   	push   %ebp
  8001b9:	89 e5                	mov    %esp,%ebp
  8001bb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c1:	8b 00                	mov    (%eax),%eax
  8001c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8001c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c9:	89 0a                	mov    %ecx,(%edx)
  8001cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8001ce:	88 d1                	mov    %dl,%cl
  8001d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001da:	8b 00                	mov    (%eax),%eax
  8001dc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001e1:	75 2c                	jne    80020f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001e3:	a0 24 20 80 00       	mov    0x802024,%al
  8001e8:	0f b6 c0             	movzbl %al,%eax
  8001eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ee:	8b 12                	mov    (%edx),%edx
  8001f0:	89 d1                	mov    %edx,%ecx
  8001f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f5:	83 c2 08             	add    $0x8,%edx
  8001f8:	83 ec 04             	sub    $0x4,%esp
  8001fb:	50                   	push   %eax
  8001fc:	51                   	push   %ecx
  8001fd:	52                   	push   %edx
  8001fe:	e8 3e 0e 00 00       	call   801041 <sys_cputs>
  800203:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800206:	8b 45 0c             	mov    0xc(%ebp),%eax
  800209:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80020f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800212:	8b 40 04             	mov    0x4(%eax),%eax
  800215:	8d 50 01             	lea    0x1(%eax),%edx
  800218:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80021e:	90                   	nop
  80021f:	c9                   	leave  
  800220:	c3                   	ret    

00800221 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800221:	55                   	push   %ebp
  800222:	89 e5                	mov    %esp,%ebp
  800224:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80022a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800231:	00 00 00 
	b.cnt = 0;
  800234:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80023b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80023e:	ff 75 0c             	pushl  0xc(%ebp)
  800241:	ff 75 08             	pushl  0x8(%ebp)
  800244:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80024a:	50                   	push   %eax
  80024b:	68 b8 01 80 00       	push   $0x8001b8
  800250:	e8 11 02 00 00       	call   800466 <vprintfmt>
  800255:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800258:	a0 24 20 80 00       	mov    0x802024,%al
  80025d:	0f b6 c0             	movzbl %al,%eax
  800260:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800266:	83 ec 04             	sub    $0x4,%esp
  800269:	50                   	push   %eax
  80026a:	52                   	push   %edx
  80026b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800271:	83 c0 08             	add    $0x8,%eax
  800274:	50                   	push   %eax
  800275:	e8 c7 0d 00 00       	call   801041 <sys_cputs>
  80027a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80027d:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800284:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80028a:	c9                   	leave  
  80028b:	c3                   	ret    

0080028c <cprintf>:

int cprintf(const char *fmt, ...) {
  80028c:	55                   	push   %ebp
  80028d:	89 e5                	mov    %esp,%ebp
  80028f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800292:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800299:	8d 45 0c             	lea    0xc(%ebp),%eax
  80029c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80029f:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a2:	83 ec 08             	sub    $0x8,%esp
  8002a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8002a8:	50                   	push   %eax
  8002a9:	e8 73 ff ff ff       	call   800221 <vcprintf>
  8002ae:	83 c4 10             	add    $0x10,%esp
  8002b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002b7:	c9                   	leave  
  8002b8:	c3                   	ret    

008002b9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002b9:	55                   	push   %ebp
  8002ba:	89 e5                	mov    %esp,%ebp
  8002bc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002bf:	e8 8e 0f 00 00       	call   801252 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8002cd:	83 ec 08             	sub    $0x8,%esp
  8002d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d3:	50                   	push   %eax
  8002d4:	e8 48 ff ff ff       	call   800221 <vcprintf>
  8002d9:	83 c4 10             	add    $0x10,%esp
  8002dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002df:	e8 88 0f 00 00       	call   80126c <sys_enable_interrupt>
	return cnt;
  8002e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e7:	c9                   	leave  
  8002e8:	c3                   	ret    

008002e9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002e9:	55                   	push   %ebp
  8002ea:	89 e5                	mov    %esp,%ebp
  8002ec:	53                   	push   %ebx
  8002ed:	83 ec 14             	sub    $0x14,%esp
  8002f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8002f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8002ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800304:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800307:	77 55                	ja     80035e <printnum+0x75>
  800309:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80030c:	72 05                	jb     800313 <printnum+0x2a>
  80030e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800311:	77 4b                	ja     80035e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800313:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800316:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800319:	8b 45 18             	mov    0x18(%ebp),%eax
  80031c:	ba 00 00 00 00       	mov    $0x0,%edx
  800321:	52                   	push   %edx
  800322:	50                   	push   %eax
  800323:	ff 75 f4             	pushl  -0xc(%ebp)
  800326:	ff 75 f0             	pushl  -0x10(%ebp)
  800329:	e8 fa 13 00 00       	call   801728 <__udivdi3>
  80032e:	83 c4 10             	add    $0x10,%esp
  800331:	83 ec 04             	sub    $0x4,%esp
  800334:	ff 75 20             	pushl  0x20(%ebp)
  800337:	53                   	push   %ebx
  800338:	ff 75 18             	pushl  0x18(%ebp)
  80033b:	52                   	push   %edx
  80033c:	50                   	push   %eax
  80033d:	ff 75 0c             	pushl  0xc(%ebp)
  800340:	ff 75 08             	pushl  0x8(%ebp)
  800343:	e8 a1 ff ff ff       	call   8002e9 <printnum>
  800348:	83 c4 20             	add    $0x20,%esp
  80034b:	eb 1a                	jmp    800367 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80034d:	83 ec 08             	sub    $0x8,%esp
  800350:	ff 75 0c             	pushl  0xc(%ebp)
  800353:	ff 75 20             	pushl  0x20(%ebp)
  800356:	8b 45 08             	mov    0x8(%ebp),%eax
  800359:	ff d0                	call   *%eax
  80035b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80035e:	ff 4d 1c             	decl   0x1c(%ebp)
  800361:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800365:	7f e6                	jg     80034d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800367:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80036a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80036f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800372:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800375:	53                   	push   %ebx
  800376:	51                   	push   %ecx
  800377:	52                   	push   %edx
  800378:	50                   	push   %eax
  800379:	e8 ba 14 00 00       	call   801838 <__umoddi3>
  80037e:	83 c4 10             	add    $0x10,%esp
  800381:	05 74 1c 80 00       	add    $0x801c74,%eax
  800386:	8a 00                	mov    (%eax),%al
  800388:	0f be c0             	movsbl %al,%eax
  80038b:	83 ec 08             	sub    $0x8,%esp
  80038e:	ff 75 0c             	pushl  0xc(%ebp)
  800391:	50                   	push   %eax
  800392:	8b 45 08             	mov    0x8(%ebp),%eax
  800395:	ff d0                	call   *%eax
  800397:	83 c4 10             	add    $0x10,%esp
}
  80039a:	90                   	nop
  80039b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80039e:	c9                   	leave  
  80039f:	c3                   	ret    

008003a0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003a0:	55                   	push   %ebp
  8003a1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003a3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003a7:	7e 1c                	jle    8003c5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	8b 00                	mov    (%eax),%eax
  8003ae:	8d 50 08             	lea    0x8(%eax),%edx
  8003b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b4:	89 10                	mov    %edx,(%eax)
  8003b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b9:	8b 00                	mov    (%eax),%eax
  8003bb:	83 e8 08             	sub    $0x8,%eax
  8003be:	8b 50 04             	mov    0x4(%eax),%edx
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	eb 40                	jmp    800405 <getuint+0x65>
	else if (lflag)
  8003c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003c9:	74 1e                	je     8003e9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	8d 50 04             	lea    0x4(%eax),%edx
  8003d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d6:	89 10                	mov    %edx,(%eax)
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	8b 00                	mov    (%eax),%eax
  8003dd:	83 e8 04             	sub    $0x4,%eax
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8003e7:	eb 1c                	jmp    800405 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	8d 50 04             	lea    0x4(%eax),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	89 10                	mov    %edx,(%eax)
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	83 e8 04             	sub    $0x4,%eax
  8003fe:	8b 00                	mov    (%eax),%eax
  800400:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800405:	5d                   	pop    %ebp
  800406:	c3                   	ret    

00800407 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800407:	55                   	push   %ebp
  800408:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80040a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80040e:	7e 1c                	jle    80042c <getint+0x25>
		return va_arg(*ap, long long);
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	8d 50 08             	lea    0x8(%eax),%edx
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	89 10                	mov    %edx,(%eax)
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	83 e8 08             	sub    $0x8,%eax
  800425:	8b 50 04             	mov    0x4(%eax),%edx
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	eb 38                	jmp    800464 <getint+0x5d>
	else if (lflag)
  80042c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800430:	74 1a                	je     80044c <getint+0x45>
		return va_arg(*ap, long);
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	8d 50 04             	lea    0x4(%eax),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	89 10                	mov    %edx,(%eax)
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	83 e8 04             	sub    $0x4,%eax
  800447:	8b 00                	mov    (%eax),%eax
  800449:	99                   	cltd   
  80044a:	eb 18                	jmp    800464 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	8d 50 04             	lea    0x4(%eax),%edx
  800454:	8b 45 08             	mov    0x8(%ebp),%eax
  800457:	89 10                	mov    %edx,(%eax)
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	83 e8 04             	sub    $0x4,%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	99                   	cltd   
}
  800464:	5d                   	pop    %ebp
  800465:	c3                   	ret    

00800466 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800466:	55                   	push   %ebp
  800467:	89 e5                	mov    %esp,%ebp
  800469:	56                   	push   %esi
  80046a:	53                   	push   %ebx
  80046b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80046e:	eb 17                	jmp    800487 <vprintfmt+0x21>
			if (ch == '\0')
  800470:	85 db                	test   %ebx,%ebx
  800472:	0f 84 af 03 00 00    	je     800827 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800478:	83 ec 08             	sub    $0x8,%esp
  80047b:	ff 75 0c             	pushl  0xc(%ebp)
  80047e:	53                   	push   %ebx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	ff d0                	call   *%eax
  800484:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800487:	8b 45 10             	mov    0x10(%ebp),%eax
  80048a:	8d 50 01             	lea    0x1(%eax),%edx
  80048d:	89 55 10             	mov    %edx,0x10(%ebp)
  800490:	8a 00                	mov    (%eax),%al
  800492:	0f b6 d8             	movzbl %al,%ebx
  800495:	83 fb 25             	cmp    $0x25,%ebx
  800498:	75 d6                	jne    800470 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80049a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80049e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004a5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004ac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004b3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bd:	8d 50 01             	lea    0x1(%eax),%edx
  8004c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c3:	8a 00                	mov    (%eax),%al
  8004c5:	0f b6 d8             	movzbl %al,%ebx
  8004c8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004cb:	83 f8 55             	cmp    $0x55,%eax
  8004ce:	0f 87 2b 03 00 00    	ja     8007ff <vprintfmt+0x399>
  8004d4:	8b 04 85 98 1c 80 00 	mov    0x801c98(,%eax,4),%eax
  8004db:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004dd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004e1:	eb d7                	jmp    8004ba <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004e3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004e7:	eb d1                	jmp    8004ba <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004e9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004f0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004f3:	89 d0                	mov    %edx,%eax
  8004f5:	c1 e0 02             	shl    $0x2,%eax
  8004f8:	01 d0                	add    %edx,%eax
  8004fa:	01 c0                	add    %eax,%eax
  8004fc:	01 d8                	add    %ebx,%eax
  8004fe:	83 e8 30             	sub    $0x30,%eax
  800501:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800504:	8b 45 10             	mov    0x10(%ebp),%eax
  800507:	8a 00                	mov    (%eax),%al
  800509:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80050c:	83 fb 2f             	cmp    $0x2f,%ebx
  80050f:	7e 3e                	jle    80054f <vprintfmt+0xe9>
  800511:	83 fb 39             	cmp    $0x39,%ebx
  800514:	7f 39                	jg     80054f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800516:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800519:	eb d5                	jmp    8004f0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	83 c0 04             	add    $0x4,%eax
  800521:	89 45 14             	mov    %eax,0x14(%ebp)
  800524:	8b 45 14             	mov    0x14(%ebp),%eax
  800527:	83 e8 04             	sub    $0x4,%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80052f:	eb 1f                	jmp    800550 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800531:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800535:	79 83                	jns    8004ba <vprintfmt+0x54>
				width = 0;
  800537:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80053e:	e9 77 ff ff ff       	jmp    8004ba <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800543:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80054a:	e9 6b ff ff ff       	jmp    8004ba <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80054f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800550:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800554:	0f 89 60 ff ff ff    	jns    8004ba <vprintfmt+0x54>
				width = precision, precision = -1;
  80055a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80055d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800560:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800567:	e9 4e ff ff ff       	jmp    8004ba <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80056c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80056f:	e9 46 ff ff ff       	jmp    8004ba <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800574:	8b 45 14             	mov    0x14(%ebp),%eax
  800577:	83 c0 04             	add    $0x4,%eax
  80057a:	89 45 14             	mov    %eax,0x14(%ebp)
  80057d:	8b 45 14             	mov    0x14(%ebp),%eax
  800580:	83 e8 04             	sub    $0x4,%eax
  800583:	8b 00                	mov    (%eax),%eax
  800585:	83 ec 08             	sub    $0x8,%esp
  800588:	ff 75 0c             	pushl  0xc(%ebp)
  80058b:	50                   	push   %eax
  80058c:	8b 45 08             	mov    0x8(%ebp),%eax
  80058f:	ff d0                	call   *%eax
  800591:	83 c4 10             	add    $0x10,%esp
			break;
  800594:	e9 89 02 00 00       	jmp    800822 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800599:	8b 45 14             	mov    0x14(%ebp),%eax
  80059c:	83 c0 04             	add    $0x4,%eax
  80059f:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a5:	83 e8 04             	sub    $0x4,%eax
  8005a8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005aa:	85 db                	test   %ebx,%ebx
  8005ac:	79 02                	jns    8005b0 <vprintfmt+0x14a>
				err = -err;
  8005ae:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005b0:	83 fb 64             	cmp    $0x64,%ebx
  8005b3:	7f 0b                	jg     8005c0 <vprintfmt+0x15a>
  8005b5:	8b 34 9d e0 1a 80 00 	mov    0x801ae0(,%ebx,4),%esi
  8005bc:	85 f6                	test   %esi,%esi
  8005be:	75 19                	jne    8005d9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005c0:	53                   	push   %ebx
  8005c1:	68 85 1c 80 00       	push   $0x801c85
  8005c6:	ff 75 0c             	pushl  0xc(%ebp)
  8005c9:	ff 75 08             	pushl  0x8(%ebp)
  8005cc:	e8 5e 02 00 00       	call   80082f <printfmt>
  8005d1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005d4:	e9 49 02 00 00       	jmp    800822 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005d9:	56                   	push   %esi
  8005da:	68 8e 1c 80 00       	push   $0x801c8e
  8005df:	ff 75 0c             	pushl  0xc(%ebp)
  8005e2:	ff 75 08             	pushl  0x8(%ebp)
  8005e5:	e8 45 02 00 00       	call   80082f <printfmt>
  8005ea:	83 c4 10             	add    $0x10,%esp
			break;
  8005ed:	e9 30 02 00 00       	jmp    800822 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f5:	83 c0 04             	add    $0x4,%eax
  8005f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8005fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005fe:	83 e8 04             	sub    $0x4,%eax
  800601:	8b 30                	mov    (%eax),%esi
  800603:	85 f6                	test   %esi,%esi
  800605:	75 05                	jne    80060c <vprintfmt+0x1a6>
				p = "(null)";
  800607:	be 91 1c 80 00       	mov    $0x801c91,%esi
			if (width > 0 && padc != '-')
  80060c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800610:	7e 6d                	jle    80067f <vprintfmt+0x219>
  800612:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800616:	74 67                	je     80067f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800618:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061b:	83 ec 08             	sub    $0x8,%esp
  80061e:	50                   	push   %eax
  80061f:	56                   	push   %esi
  800620:	e8 0c 03 00 00       	call   800931 <strnlen>
  800625:	83 c4 10             	add    $0x10,%esp
  800628:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80062b:	eb 16                	jmp    800643 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80062d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800631:	83 ec 08             	sub    $0x8,%esp
  800634:	ff 75 0c             	pushl  0xc(%ebp)
  800637:	50                   	push   %eax
  800638:	8b 45 08             	mov    0x8(%ebp),%eax
  80063b:	ff d0                	call   *%eax
  80063d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800640:	ff 4d e4             	decl   -0x1c(%ebp)
  800643:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800647:	7f e4                	jg     80062d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800649:	eb 34                	jmp    80067f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80064b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80064f:	74 1c                	je     80066d <vprintfmt+0x207>
  800651:	83 fb 1f             	cmp    $0x1f,%ebx
  800654:	7e 05                	jle    80065b <vprintfmt+0x1f5>
  800656:	83 fb 7e             	cmp    $0x7e,%ebx
  800659:	7e 12                	jle    80066d <vprintfmt+0x207>
					putch('?', putdat);
  80065b:	83 ec 08             	sub    $0x8,%esp
  80065e:	ff 75 0c             	pushl  0xc(%ebp)
  800661:	6a 3f                	push   $0x3f
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	ff d0                	call   *%eax
  800668:	83 c4 10             	add    $0x10,%esp
  80066b:	eb 0f                	jmp    80067c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80066d:	83 ec 08             	sub    $0x8,%esp
  800670:	ff 75 0c             	pushl  0xc(%ebp)
  800673:	53                   	push   %ebx
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	ff d0                	call   *%eax
  800679:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80067c:	ff 4d e4             	decl   -0x1c(%ebp)
  80067f:	89 f0                	mov    %esi,%eax
  800681:	8d 70 01             	lea    0x1(%eax),%esi
  800684:	8a 00                	mov    (%eax),%al
  800686:	0f be d8             	movsbl %al,%ebx
  800689:	85 db                	test   %ebx,%ebx
  80068b:	74 24                	je     8006b1 <vprintfmt+0x24b>
  80068d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800691:	78 b8                	js     80064b <vprintfmt+0x1e5>
  800693:	ff 4d e0             	decl   -0x20(%ebp)
  800696:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80069a:	79 af                	jns    80064b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80069c:	eb 13                	jmp    8006b1 <vprintfmt+0x24b>
				putch(' ', putdat);
  80069e:	83 ec 08             	sub    $0x8,%esp
  8006a1:	ff 75 0c             	pushl  0xc(%ebp)
  8006a4:	6a 20                	push   $0x20
  8006a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a9:	ff d0                	call   *%eax
  8006ab:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ae:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b5:	7f e7                	jg     80069e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006b7:	e9 66 01 00 00       	jmp    800822 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006bc:	83 ec 08             	sub    $0x8,%esp
  8006bf:	ff 75 e8             	pushl  -0x18(%ebp)
  8006c2:	8d 45 14             	lea    0x14(%ebp),%eax
  8006c5:	50                   	push   %eax
  8006c6:	e8 3c fd ff ff       	call   800407 <getint>
  8006cb:	83 c4 10             	add    $0x10,%esp
  8006ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006da:	85 d2                	test   %edx,%edx
  8006dc:	79 23                	jns    800701 <vprintfmt+0x29b>
				putch('-', putdat);
  8006de:	83 ec 08             	sub    $0x8,%esp
  8006e1:	ff 75 0c             	pushl  0xc(%ebp)
  8006e4:	6a 2d                	push   $0x2d
  8006e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e9:	ff d0                	call   *%eax
  8006eb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f4:	f7 d8                	neg    %eax
  8006f6:	83 d2 00             	adc    $0x0,%edx
  8006f9:	f7 da                	neg    %edx
  8006fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800701:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800708:	e9 bc 00 00 00       	jmp    8007c9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80070d:	83 ec 08             	sub    $0x8,%esp
  800710:	ff 75 e8             	pushl  -0x18(%ebp)
  800713:	8d 45 14             	lea    0x14(%ebp),%eax
  800716:	50                   	push   %eax
  800717:	e8 84 fc ff ff       	call   8003a0 <getuint>
  80071c:	83 c4 10             	add    $0x10,%esp
  80071f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800722:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800725:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072c:	e9 98 00 00 00       	jmp    8007c9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	6a 58                	push   $0x58
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	ff d0                	call   *%eax
  80073e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800741:	83 ec 08             	sub    $0x8,%esp
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	6a 58                	push   $0x58
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	ff d0                	call   *%eax
  80074e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800751:	83 ec 08             	sub    $0x8,%esp
  800754:	ff 75 0c             	pushl  0xc(%ebp)
  800757:	6a 58                	push   $0x58
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	ff d0                	call   *%eax
  80075e:	83 c4 10             	add    $0x10,%esp
			break;
  800761:	e9 bc 00 00 00       	jmp    800822 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800766:	83 ec 08             	sub    $0x8,%esp
  800769:	ff 75 0c             	pushl  0xc(%ebp)
  80076c:	6a 30                	push   $0x30
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	ff d0                	call   *%eax
  800773:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	ff 75 0c             	pushl  0xc(%ebp)
  80077c:	6a 78                	push   $0x78
  80077e:	8b 45 08             	mov    0x8(%ebp),%eax
  800781:	ff d0                	call   *%eax
  800783:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800786:	8b 45 14             	mov    0x14(%ebp),%eax
  800789:	83 c0 04             	add    $0x4,%eax
  80078c:	89 45 14             	mov    %eax,0x14(%ebp)
  80078f:	8b 45 14             	mov    0x14(%ebp),%eax
  800792:	83 e8 04             	sub    $0x4,%eax
  800795:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800797:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007a1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007a8:	eb 1f                	jmp    8007c9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007aa:	83 ec 08             	sub    $0x8,%esp
  8007ad:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b0:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b3:	50                   	push   %eax
  8007b4:	e8 e7 fb ff ff       	call   8003a0 <getuint>
  8007b9:	83 c4 10             	add    $0x10,%esp
  8007bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007c2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007c9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d0:	83 ec 04             	sub    $0x4,%esp
  8007d3:	52                   	push   %edx
  8007d4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007d7:	50                   	push   %eax
  8007d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8007db:	ff 75 f0             	pushl  -0x10(%ebp)
  8007de:	ff 75 0c             	pushl  0xc(%ebp)
  8007e1:	ff 75 08             	pushl  0x8(%ebp)
  8007e4:	e8 00 fb ff ff       	call   8002e9 <printnum>
  8007e9:	83 c4 20             	add    $0x20,%esp
			break;
  8007ec:	eb 34                	jmp    800822 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007ee:	83 ec 08             	sub    $0x8,%esp
  8007f1:	ff 75 0c             	pushl  0xc(%ebp)
  8007f4:	53                   	push   %ebx
  8007f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f8:	ff d0                	call   *%eax
  8007fa:	83 c4 10             	add    $0x10,%esp
			break;
  8007fd:	eb 23                	jmp    800822 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007ff:	83 ec 08             	sub    $0x8,%esp
  800802:	ff 75 0c             	pushl  0xc(%ebp)
  800805:	6a 25                	push   $0x25
  800807:	8b 45 08             	mov    0x8(%ebp),%eax
  80080a:	ff d0                	call   *%eax
  80080c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80080f:	ff 4d 10             	decl   0x10(%ebp)
  800812:	eb 03                	jmp    800817 <vprintfmt+0x3b1>
  800814:	ff 4d 10             	decl   0x10(%ebp)
  800817:	8b 45 10             	mov    0x10(%ebp),%eax
  80081a:	48                   	dec    %eax
  80081b:	8a 00                	mov    (%eax),%al
  80081d:	3c 25                	cmp    $0x25,%al
  80081f:	75 f3                	jne    800814 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800821:	90                   	nop
		}
	}
  800822:	e9 47 fc ff ff       	jmp    80046e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800827:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800828:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80082b:	5b                   	pop    %ebx
  80082c:	5e                   	pop    %esi
  80082d:	5d                   	pop    %ebp
  80082e:	c3                   	ret    

0080082f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80082f:	55                   	push   %ebp
  800830:	89 e5                	mov    %esp,%ebp
  800832:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800835:	8d 45 10             	lea    0x10(%ebp),%eax
  800838:	83 c0 04             	add    $0x4,%eax
  80083b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80083e:	8b 45 10             	mov    0x10(%ebp),%eax
  800841:	ff 75 f4             	pushl  -0xc(%ebp)
  800844:	50                   	push   %eax
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	ff 75 08             	pushl  0x8(%ebp)
  80084b:	e8 16 fc ff ff       	call   800466 <vprintfmt>
  800850:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800853:	90                   	nop
  800854:	c9                   	leave  
  800855:	c3                   	ret    

00800856 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800856:	55                   	push   %ebp
  800857:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800859:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085c:	8b 40 08             	mov    0x8(%eax),%eax
  80085f:	8d 50 01             	lea    0x1(%eax),%edx
  800862:	8b 45 0c             	mov    0xc(%ebp),%eax
  800865:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800868:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086b:	8b 10                	mov    (%eax),%edx
  80086d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800870:	8b 40 04             	mov    0x4(%eax),%eax
  800873:	39 c2                	cmp    %eax,%edx
  800875:	73 12                	jae    800889 <sprintputch+0x33>
		*b->buf++ = ch;
  800877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	8d 48 01             	lea    0x1(%eax),%ecx
  80087f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800882:	89 0a                	mov    %ecx,(%edx)
  800884:	8b 55 08             	mov    0x8(%ebp),%edx
  800887:	88 10                	mov    %dl,(%eax)
}
  800889:	90                   	nop
  80088a:	5d                   	pop    %ebp
  80088b:	c3                   	ret    

0080088c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80088c:	55                   	push   %ebp
  80088d:	89 e5                	mov    %esp,%ebp
  80088f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	01 d0                	add    %edx,%eax
  8008a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008b1:	74 06                	je     8008b9 <vsnprintf+0x2d>
  8008b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b7:	7f 07                	jg     8008c0 <vsnprintf+0x34>
		return -E_INVAL;
  8008b9:	b8 03 00 00 00       	mov    $0x3,%eax
  8008be:	eb 20                	jmp    8008e0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008c0:	ff 75 14             	pushl  0x14(%ebp)
  8008c3:	ff 75 10             	pushl  0x10(%ebp)
  8008c6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008c9:	50                   	push   %eax
  8008ca:	68 56 08 80 00       	push   $0x800856
  8008cf:	e8 92 fb ff ff       	call   800466 <vprintfmt>
  8008d4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008da:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008e0:	c9                   	leave  
  8008e1:	c3                   	ret    

008008e2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008e2:	55                   	push   %ebp
  8008e3:	89 e5                	mov    %esp,%ebp
  8008e5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008e8:	8d 45 10             	lea    0x10(%ebp),%eax
  8008eb:	83 c0 04             	add    $0x4,%eax
  8008ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f7:	50                   	push   %eax
  8008f8:	ff 75 0c             	pushl  0xc(%ebp)
  8008fb:	ff 75 08             	pushl  0x8(%ebp)
  8008fe:	e8 89 ff ff ff       	call   80088c <vsnprintf>
  800903:	83 c4 10             	add    $0x10,%esp
  800906:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800909:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80090c:	c9                   	leave  
  80090d:	c3                   	ret    

0080090e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80090e:	55                   	push   %ebp
  80090f:	89 e5                	mov    %esp,%ebp
  800911:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800914:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80091b:	eb 06                	jmp    800923 <strlen+0x15>
		n++;
  80091d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800920:	ff 45 08             	incl   0x8(%ebp)
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	8a 00                	mov    (%eax),%al
  800928:	84 c0                	test   %al,%al
  80092a:	75 f1                	jne    80091d <strlen+0xf>
		n++;
	return n;
  80092c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80092f:	c9                   	leave  
  800930:	c3                   	ret    

00800931 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800931:	55                   	push   %ebp
  800932:	89 e5                	mov    %esp,%ebp
  800934:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800937:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80093e:	eb 09                	jmp    800949 <strnlen+0x18>
		n++;
  800940:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800943:	ff 45 08             	incl   0x8(%ebp)
  800946:	ff 4d 0c             	decl   0xc(%ebp)
  800949:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80094d:	74 09                	je     800958 <strnlen+0x27>
  80094f:	8b 45 08             	mov    0x8(%ebp),%eax
  800952:	8a 00                	mov    (%eax),%al
  800954:	84 c0                	test   %al,%al
  800956:	75 e8                	jne    800940 <strnlen+0xf>
		n++;
	return n;
  800958:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80095b:	c9                   	leave  
  80095c:	c3                   	ret    

0080095d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80095d:	55                   	push   %ebp
  80095e:	89 e5                	mov    %esp,%ebp
  800960:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800969:	90                   	nop
  80096a:	8b 45 08             	mov    0x8(%ebp),%eax
  80096d:	8d 50 01             	lea    0x1(%eax),%edx
  800970:	89 55 08             	mov    %edx,0x8(%ebp)
  800973:	8b 55 0c             	mov    0xc(%ebp),%edx
  800976:	8d 4a 01             	lea    0x1(%edx),%ecx
  800979:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80097c:	8a 12                	mov    (%edx),%dl
  80097e:	88 10                	mov    %dl,(%eax)
  800980:	8a 00                	mov    (%eax),%al
  800982:	84 c0                	test   %al,%al
  800984:	75 e4                	jne    80096a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800986:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800989:	c9                   	leave  
  80098a:	c3                   	ret    

0080098b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80098b:	55                   	push   %ebp
  80098c:	89 e5                	mov    %esp,%ebp
  80098e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800997:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80099e:	eb 1f                	jmp    8009bf <strncpy+0x34>
		*dst++ = *src;
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	8d 50 01             	lea    0x1(%eax),%edx
  8009a6:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ac:	8a 12                	mov    (%edx),%dl
  8009ae:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b3:	8a 00                	mov    (%eax),%al
  8009b5:	84 c0                	test   %al,%al
  8009b7:	74 03                	je     8009bc <strncpy+0x31>
			src++;
  8009b9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009bc:	ff 45 fc             	incl   -0x4(%ebp)
  8009bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009c2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009c5:	72 d9                	jb     8009a0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009ca:	c9                   	leave  
  8009cb:	c3                   	ret    

008009cc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009cc:	55                   	push   %ebp
  8009cd:	89 e5                	mov    %esp,%ebp
  8009cf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009dc:	74 30                	je     800a0e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009de:	eb 16                	jmp    8009f6 <strlcpy+0x2a>
			*dst++ = *src++;
  8009e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e3:	8d 50 01             	lea    0x1(%eax),%edx
  8009e6:	89 55 08             	mov    %edx,0x8(%ebp)
  8009e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ec:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ef:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009f2:	8a 12                	mov    (%edx),%dl
  8009f4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009f6:	ff 4d 10             	decl   0x10(%ebp)
  8009f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009fd:	74 09                	je     800a08 <strlcpy+0x3c>
  8009ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a02:	8a 00                	mov    (%eax),%al
  800a04:	84 c0                	test   %al,%al
  800a06:	75 d8                	jne    8009e0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a08:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a0e:	8b 55 08             	mov    0x8(%ebp),%edx
  800a11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a14:	29 c2                	sub    %eax,%edx
  800a16:	89 d0                	mov    %edx,%eax
}
  800a18:	c9                   	leave  
  800a19:	c3                   	ret    

00800a1a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a1d:	eb 06                	jmp    800a25 <strcmp+0xb>
		p++, q++;
  800a1f:	ff 45 08             	incl   0x8(%ebp)
  800a22:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a25:	8b 45 08             	mov    0x8(%ebp),%eax
  800a28:	8a 00                	mov    (%eax),%al
  800a2a:	84 c0                	test   %al,%al
  800a2c:	74 0e                	je     800a3c <strcmp+0x22>
  800a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a31:	8a 10                	mov    (%eax),%dl
  800a33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a36:	8a 00                	mov    (%eax),%al
  800a38:	38 c2                	cmp    %al,%dl
  800a3a:	74 e3                	je     800a1f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	8a 00                	mov    (%eax),%al
  800a41:	0f b6 d0             	movzbl %al,%edx
  800a44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a47:	8a 00                	mov    (%eax),%al
  800a49:	0f b6 c0             	movzbl %al,%eax
  800a4c:	29 c2                	sub    %eax,%edx
  800a4e:	89 d0                	mov    %edx,%eax
}
  800a50:	5d                   	pop    %ebp
  800a51:	c3                   	ret    

00800a52 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a52:	55                   	push   %ebp
  800a53:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a55:	eb 09                	jmp    800a60 <strncmp+0xe>
		n--, p++, q++;
  800a57:	ff 4d 10             	decl   0x10(%ebp)
  800a5a:	ff 45 08             	incl   0x8(%ebp)
  800a5d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a64:	74 17                	je     800a7d <strncmp+0x2b>
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	8a 00                	mov    (%eax),%al
  800a6b:	84 c0                	test   %al,%al
  800a6d:	74 0e                	je     800a7d <strncmp+0x2b>
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	8a 10                	mov    (%eax),%dl
  800a74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a77:	8a 00                	mov    (%eax),%al
  800a79:	38 c2                	cmp    %al,%dl
  800a7b:	74 da                	je     800a57 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a81:	75 07                	jne    800a8a <strncmp+0x38>
		return 0;
  800a83:	b8 00 00 00 00       	mov    $0x0,%eax
  800a88:	eb 14                	jmp    800a9e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	8a 00                	mov    (%eax),%al
  800a8f:	0f b6 d0             	movzbl %al,%edx
  800a92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a95:	8a 00                	mov    (%eax),%al
  800a97:	0f b6 c0             	movzbl %al,%eax
  800a9a:	29 c2                	sub    %eax,%edx
  800a9c:	89 d0                	mov    %edx,%eax
}
  800a9e:	5d                   	pop    %ebp
  800a9f:	c3                   	ret    

00800aa0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aa0:	55                   	push   %ebp
  800aa1:	89 e5                	mov    %esp,%ebp
  800aa3:	83 ec 04             	sub    $0x4,%esp
  800aa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aac:	eb 12                	jmp    800ac0 <strchr+0x20>
		if (*s == c)
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	8a 00                	mov    (%eax),%al
  800ab3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ab6:	75 05                	jne    800abd <strchr+0x1d>
			return (char *) s;
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	eb 11                	jmp    800ace <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800abd:	ff 45 08             	incl   0x8(%ebp)
  800ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac3:	8a 00                	mov    (%eax),%al
  800ac5:	84 c0                	test   %al,%al
  800ac7:	75 e5                	jne    800aae <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ac9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 04             	sub    $0x4,%esp
  800ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800adc:	eb 0d                	jmp    800aeb <strfind+0x1b>
		if (*s == c)
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	8a 00                	mov    (%eax),%al
  800ae3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ae6:	74 0e                	je     800af6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ae8:	ff 45 08             	incl   0x8(%ebp)
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	8a 00                	mov    (%eax),%al
  800af0:	84 c0                	test   %al,%al
  800af2:	75 ea                	jne    800ade <strfind+0xe>
  800af4:	eb 01                	jmp    800af7 <strfind+0x27>
		if (*s == c)
			break;
  800af6:	90                   	nop
	return (char *) s;
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800afa:	c9                   	leave  
  800afb:	c3                   	ret    

00800afc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800afc:	55                   	push   %ebp
  800afd:	89 e5                	mov    %esp,%ebp
  800aff:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b08:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b0e:	eb 0e                	jmp    800b1e <memset+0x22>
		*p++ = c;
  800b10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b13:	8d 50 01             	lea    0x1(%eax),%edx
  800b16:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b1c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b1e:	ff 4d f8             	decl   -0x8(%ebp)
  800b21:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b25:	79 e9                	jns    800b10 <memset+0x14>
		*p++ = c;

	return v;
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2a:	c9                   	leave  
  800b2b:	c3                   	ret    

00800b2c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
  800b2f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b3e:	eb 16                	jmp    800b56 <memcpy+0x2a>
		*d++ = *s++;
  800b40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b43:	8d 50 01             	lea    0x1(%eax),%edx
  800b46:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b49:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b4c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b4f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b52:	8a 12                	mov    (%edx),%dl
  800b54:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b56:	8b 45 10             	mov    0x10(%ebp),%eax
  800b59:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b5c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b5f:	85 c0                	test   %eax,%eax
  800b61:	75 dd                	jne    800b40 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b66:	c9                   	leave  
  800b67:	c3                   	ret    

00800b68 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b68:	55                   	push   %ebp
  800b69:	89 e5                	mov    %esp,%ebp
  800b6b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b7d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b80:	73 50                	jae    800bd2 <memmove+0x6a>
  800b82:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b85:	8b 45 10             	mov    0x10(%ebp),%eax
  800b88:	01 d0                	add    %edx,%eax
  800b8a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b8d:	76 43                	jbe    800bd2 <memmove+0x6a>
		s += n;
  800b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b92:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b95:	8b 45 10             	mov    0x10(%ebp),%eax
  800b98:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b9b:	eb 10                	jmp    800bad <memmove+0x45>
			*--d = *--s;
  800b9d:	ff 4d f8             	decl   -0x8(%ebp)
  800ba0:	ff 4d fc             	decl   -0x4(%ebp)
  800ba3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba6:	8a 10                	mov    (%eax),%dl
  800ba8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bab:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bad:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb3:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb6:	85 c0                	test   %eax,%eax
  800bb8:	75 e3                	jne    800b9d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bba:	eb 23                	jmp    800bdf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bbf:	8d 50 01             	lea    0x1(%eax),%edx
  800bc2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bcb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bce:	8a 12                	mov    (%edx),%dl
  800bd0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bdb:	85 c0                	test   %eax,%eax
  800bdd:	75 dd                	jne    800bbc <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be2:	c9                   	leave  
  800be3:	c3                   	ret    

00800be4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800be4:	55                   	push   %ebp
  800be5:	89 e5                	mov    %esp,%ebp
  800be7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bea:	8b 45 08             	mov    0x8(%ebp),%eax
  800bed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bf6:	eb 2a                	jmp    800c22 <memcmp+0x3e>
		if (*s1 != *s2)
  800bf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfb:	8a 10                	mov    (%eax),%dl
  800bfd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c00:	8a 00                	mov    (%eax),%al
  800c02:	38 c2                	cmp    %al,%dl
  800c04:	74 16                	je     800c1c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c09:	8a 00                	mov    (%eax),%al
  800c0b:	0f b6 d0             	movzbl %al,%edx
  800c0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c11:	8a 00                	mov    (%eax),%al
  800c13:	0f b6 c0             	movzbl %al,%eax
  800c16:	29 c2                	sub    %eax,%edx
  800c18:	89 d0                	mov    %edx,%eax
  800c1a:	eb 18                	jmp    800c34 <memcmp+0x50>
		s1++, s2++;
  800c1c:	ff 45 fc             	incl   -0x4(%ebp)
  800c1f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c22:	8b 45 10             	mov    0x10(%ebp),%eax
  800c25:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c28:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2b:	85 c0                	test   %eax,%eax
  800c2d:	75 c9                	jne    800bf8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c34:	c9                   	leave  
  800c35:	c3                   	ret    

00800c36 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c36:	55                   	push   %ebp
  800c37:	89 e5                	mov    %esp,%ebp
  800c39:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c3c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c42:	01 d0                	add    %edx,%eax
  800c44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c47:	eb 15                	jmp    800c5e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c49:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4c:	8a 00                	mov    (%eax),%al
  800c4e:	0f b6 d0             	movzbl %al,%edx
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	0f b6 c0             	movzbl %al,%eax
  800c57:	39 c2                	cmp    %eax,%edx
  800c59:	74 0d                	je     800c68 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c5b:	ff 45 08             	incl   0x8(%ebp)
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c64:	72 e3                	jb     800c49 <memfind+0x13>
  800c66:	eb 01                	jmp    800c69 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c68:	90                   	nop
	return (void *) s;
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c7b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c82:	eb 03                	jmp    800c87 <strtol+0x19>
		s++;
  800c84:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	3c 20                	cmp    $0x20,%al
  800c8e:	74 f4                	je     800c84 <strtol+0x16>
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	3c 09                	cmp    $0x9,%al
  800c97:	74 eb                	je     800c84 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	3c 2b                	cmp    $0x2b,%al
  800ca0:	75 05                	jne    800ca7 <strtol+0x39>
		s++;
  800ca2:	ff 45 08             	incl   0x8(%ebp)
  800ca5:	eb 13                	jmp    800cba <strtol+0x4c>
	else if (*s == '-')
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	3c 2d                	cmp    $0x2d,%al
  800cae:	75 0a                	jne    800cba <strtol+0x4c>
		s++, neg = 1;
  800cb0:	ff 45 08             	incl   0x8(%ebp)
  800cb3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbe:	74 06                	je     800cc6 <strtol+0x58>
  800cc0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cc4:	75 20                	jne    800ce6 <strtol+0x78>
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	3c 30                	cmp    $0x30,%al
  800ccd:	75 17                	jne    800ce6 <strtol+0x78>
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	40                   	inc    %eax
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	3c 78                	cmp    $0x78,%al
  800cd7:	75 0d                	jne    800ce6 <strtol+0x78>
		s += 2, base = 16;
  800cd9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cdd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ce4:	eb 28                	jmp    800d0e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ce6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cea:	75 15                	jne    800d01 <strtol+0x93>
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	8a 00                	mov    (%eax),%al
  800cf1:	3c 30                	cmp    $0x30,%al
  800cf3:	75 0c                	jne    800d01 <strtol+0x93>
		s++, base = 8;
  800cf5:	ff 45 08             	incl   0x8(%ebp)
  800cf8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cff:	eb 0d                	jmp    800d0e <strtol+0xa0>
	else if (base == 0)
  800d01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d05:	75 07                	jne    800d0e <strtol+0xa0>
		base = 10;
  800d07:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	3c 2f                	cmp    $0x2f,%al
  800d15:	7e 19                	jle    800d30 <strtol+0xc2>
  800d17:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1a:	8a 00                	mov    (%eax),%al
  800d1c:	3c 39                	cmp    $0x39,%al
  800d1e:	7f 10                	jg     800d30 <strtol+0xc2>
			dig = *s - '0';
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	0f be c0             	movsbl %al,%eax
  800d28:	83 e8 30             	sub    $0x30,%eax
  800d2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d2e:	eb 42                	jmp    800d72 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	8a 00                	mov    (%eax),%al
  800d35:	3c 60                	cmp    $0x60,%al
  800d37:	7e 19                	jle    800d52 <strtol+0xe4>
  800d39:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3c:	8a 00                	mov    (%eax),%al
  800d3e:	3c 7a                	cmp    $0x7a,%al
  800d40:	7f 10                	jg     800d52 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	0f be c0             	movsbl %al,%eax
  800d4a:	83 e8 57             	sub    $0x57,%eax
  800d4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d50:	eb 20                	jmp    800d72 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	3c 40                	cmp    $0x40,%al
  800d59:	7e 39                	jle    800d94 <strtol+0x126>
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	3c 5a                	cmp    $0x5a,%al
  800d62:	7f 30                	jg     800d94 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	8a 00                	mov    (%eax),%al
  800d69:	0f be c0             	movsbl %al,%eax
  800d6c:	83 e8 37             	sub    $0x37,%eax
  800d6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d72:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d75:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d78:	7d 19                	jge    800d93 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d7a:	ff 45 08             	incl   0x8(%ebp)
  800d7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d80:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d84:	89 c2                	mov    %eax,%edx
  800d86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d89:	01 d0                	add    %edx,%eax
  800d8b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d8e:	e9 7b ff ff ff       	jmp    800d0e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d93:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d94:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d98:	74 08                	je     800da2 <strtol+0x134>
		*endptr = (char *) s;
  800d9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9d:	8b 55 08             	mov    0x8(%ebp),%edx
  800da0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800da2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800da6:	74 07                	je     800daf <strtol+0x141>
  800da8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dab:	f7 d8                	neg    %eax
  800dad:	eb 03                	jmp    800db2 <strtol+0x144>
  800daf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db2:	c9                   	leave  
  800db3:	c3                   	ret    

00800db4 <ltostr>:

void
ltostr(long value, char *str)
{
  800db4:	55                   	push   %ebp
  800db5:	89 e5                	mov    %esp,%ebp
  800db7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dc1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dc8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dcc:	79 13                	jns    800de1 <ltostr+0x2d>
	{
		neg = 1;
  800dce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ddb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dde:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800de9:	99                   	cltd   
  800dea:	f7 f9                	idiv   %ecx
  800dec:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800def:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df2:	8d 50 01             	lea    0x1(%eax),%edx
  800df5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df8:	89 c2                	mov    %eax,%edx
  800dfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfd:	01 d0                	add    %edx,%eax
  800dff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e02:	83 c2 30             	add    $0x30,%edx
  800e05:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e07:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e0a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e0f:	f7 e9                	imul   %ecx
  800e11:	c1 fa 02             	sar    $0x2,%edx
  800e14:	89 c8                	mov    %ecx,%eax
  800e16:	c1 f8 1f             	sar    $0x1f,%eax
  800e19:	29 c2                	sub    %eax,%edx
  800e1b:	89 d0                	mov    %edx,%eax
  800e1d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e20:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e23:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e28:	f7 e9                	imul   %ecx
  800e2a:	c1 fa 02             	sar    $0x2,%edx
  800e2d:	89 c8                	mov    %ecx,%eax
  800e2f:	c1 f8 1f             	sar    $0x1f,%eax
  800e32:	29 c2                	sub    %eax,%edx
  800e34:	89 d0                	mov    %edx,%eax
  800e36:	c1 e0 02             	shl    $0x2,%eax
  800e39:	01 d0                	add    %edx,%eax
  800e3b:	01 c0                	add    %eax,%eax
  800e3d:	29 c1                	sub    %eax,%ecx
  800e3f:	89 ca                	mov    %ecx,%edx
  800e41:	85 d2                	test   %edx,%edx
  800e43:	75 9c                	jne    800de1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e4c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4f:	48                   	dec    %eax
  800e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e53:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e57:	74 3d                	je     800e96 <ltostr+0xe2>
		start = 1 ;
  800e59:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e60:	eb 34                	jmp    800e96 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e62:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e68:	01 d0                	add    %edx,%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e75:	01 c2                	add    %eax,%edx
  800e77:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	01 c8                	add    %ecx,%eax
  800e7f:	8a 00                	mov    (%eax),%al
  800e81:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e83:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e89:	01 c2                	add    %eax,%edx
  800e8b:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e8e:	88 02                	mov    %al,(%edx)
		start++ ;
  800e90:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e93:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e96:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e99:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e9c:	7c c4                	jl     800e62 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e9e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ea1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea4:	01 d0                	add    %edx,%eax
  800ea6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ea9:	90                   	nop
  800eaa:	c9                   	leave  
  800eab:	c3                   	ret    

00800eac <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eac:	55                   	push   %ebp
  800ead:	89 e5                	mov    %esp,%ebp
  800eaf:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eb2:	ff 75 08             	pushl  0x8(%ebp)
  800eb5:	e8 54 fa ff ff       	call   80090e <strlen>
  800eba:	83 c4 04             	add    $0x4,%esp
  800ebd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	e8 46 fa ff ff       	call   80090e <strlen>
  800ec8:	83 c4 04             	add    $0x4,%esp
  800ecb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ece:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ed5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800edc:	eb 17                	jmp    800ef5 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ede:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee4:	01 c2                	add    %eax,%edx
  800ee6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eec:	01 c8                	add    %ecx,%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ef2:	ff 45 fc             	incl   -0x4(%ebp)
  800ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800efb:	7c e1                	jl     800ede <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800efd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f04:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f0b:	eb 1f                	jmp    800f2c <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f10:	8d 50 01             	lea    0x1(%eax),%edx
  800f13:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f16:	89 c2                	mov    %eax,%edx
  800f18:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1b:	01 c2                	add    %eax,%edx
  800f1d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	01 c8                	add    %ecx,%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f29:	ff 45 f8             	incl   -0x8(%ebp)
  800f2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f32:	7c d9                	jl     800f0d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f34:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f37:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3a:	01 d0                	add    %edx,%eax
  800f3c:	c6 00 00             	movb   $0x0,(%eax)
}
  800f3f:	90                   	nop
  800f40:	c9                   	leave  
  800f41:	c3                   	ret    

00800f42 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f42:	55                   	push   %ebp
  800f43:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f45:	8b 45 14             	mov    0x14(%ebp),%eax
  800f48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f51:	8b 00                	mov    (%eax),%eax
  800f53:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5d:	01 d0                	add    %edx,%eax
  800f5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f65:	eb 0c                	jmp    800f73 <strsplit+0x31>
			*string++ = 0;
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8d 50 01             	lea    0x1(%eax),%edx
  800f6d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f70:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	84 c0                	test   %al,%al
  800f7a:	74 18                	je     800f94 <strsplit+0x52>
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	0f be c0             	movsbl %al,%eax
  800f84:	50                   	push   %eax
  800f85:	ff 75 0c             	pushl  0xc(%ebp)
  800f88:	e8 13 fb ff ff       	call   800aa0 <strchr>
  800f8d:	83 c4 08             	add    $0x8,%esp
  800f90:	85 c0                	test   %eax,%eax
  800f92:	75 d3                	jne    800f67 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	84 c0                	test   %al,%al
  800f9b:	74 5a                	je     800ff7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa0:	8b 00                	mov    (%eax),%eax
  800fa2:	83 f8 0f             	cmp    $0xf,%eax
  800fa5:	75 07                	jne    800fae <strsplit+0x6c>
		{
			return 0;
  800fa7:	b8 00 00 00 00       	mov    $0x0,%eax
  800fac:	eb 66                	jmp    801014 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fae:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb1:	8b 00                	mov    (%eax),%eax
  800fb3:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb6:	8b 55 14             	mov    0x14(%ebp),%edx
  800fb9:	89 0a                	mov    %ecx,(%edx)
  800fbb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc5:	01 c2                	add    %eax,%edx
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fcc:	eb 03                	jmp    800fd1 <strsplit+0x8f>
			string++;
  800fce:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	84 c0                	test   %al,%al
  800fd8:	74 8b                	je     800f65 <strsplit+0x23>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	0f be c0             	movsbl %al,%eax
  800fe2:	50                   	push   %eax
  800fe3:	ff 75 0c             	pushl  0xc(%ebp)
  800fe6:	e8 b5 fa ff ff       	call   800aa0 <strchr>
  800feb:	83 c4 08             	add    $0x8,%esp
  800fee:	85 c0                	test   %eax,%eax
  800ff0:	74 dc                	je     800fce <strsplit+0x8c>
			string++;
	}
  800ff2:	e9 6e ff ff ff       	jmp    800f65 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800ff7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800ff8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffb:	8b 00                	mov    (%eax),%eax
  800ffd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801004:	8b 45 10             	mov    0x10(%ebp),%eax
  801007:	01 d0                	add    %edx,%eax
  801009:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80100f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801014:	c9                   	leave  
  801015:	c3                   	ret    

00801016 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801016:	55                   	push   %ebp
  801017:	89 e5                	mov    %esp,%ebp
  801019:	57                   	push   %edi
  80101a:	56                   	push   %esi
  80101b:	53                   	push   %ebx
  80101c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8b 55 0c             	mov    0xc(%ebp),%edx
  801025:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801028:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80102b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80102e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801031:	cd 30                	int    $0x30
  801033:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801036:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801039:	83 c4 10             	add    $0x10,%esp
  80103c:	5b                   	pop    %ebx
  80103d:	5e                   	pop    %esi
  80103e:	5f                   	pop    %edi
  80103f:	5d                   	pop    %ebp
  801040:	c3                   	ret    

00801041 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801041:	55                   	push   %ebp
  801042:	89 e5                	mov    %esp,%ebp
  801044:	83 ec 04             	sub    $0x4,%esp
  801047:	8b 45 10             	mov    0x10(%ebp),%eax
  80104a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80104d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	6a 00                	push   $0x0
  801056:	6a 00                	push   $0x0
  801058:	52                   	push   %edx
  801059:	ff 75 0c             	pushl  0xc(%ebp)
  80105c:	50                   	push   %eax
  80105d:	6a 00                	push   $0x0
  80105f:	e8 b2 ff ff ff       	call   801016 <syscall>
  801064:	83 c4 18             	add    $0x18,%esp
}
  801067:	90                   	nop
  801068:	c9                   	leave  
  801069:	c3                   	ret    

0080106a <sys_cgetc>:

int
sys_cgetc(void)
{
  80106a:	55                   	push   %ebp
  80106b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80106d:	6a 00                	push   $0x0
  80106f:	6a 00                	push   $0x0
  801071:	6a 00                	push   $0x0
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	6a 01                	push   $0x1
  801079:	e8 98 ff ff ff       	call   801016 <syscall>
  80107e:	83 c4 18             	add    $0x18,%esp
}
  801081:	c9                   	leave  
  801082:	c3                   	ret    

00801083 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801083:	55                   	push   %ebp
  801084:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	50                   	push   %eax
  801092:	6a 05                	push   $0x5
  801094:	e8 7d ff ff ff       	call   801016 <syscall>
  801099:	83 c4 18             	add    $0x18,%esp
}
  80109c:	c9                   	leave  
  80109d:	c3                   	ret    

0080109e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80109e:	55                   	push   %ebp
  80109f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 02                	push   $0x2
  8010ad:	e8 64 ff ff ff       	call   801016 <syscall>
  8010b2:	83 c4 18             	add    $0x18,%esp
}
  8010b5:	c9                   	leave  
  8010b6:	c3                   	ret    

008010b7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010b7:	55                   	push   %ebp
  8010b8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ba:	6a 00                	push   $0x0
  8010bc:	6a 00                	push   $0x0
  8010be:	6a 00                	push   $0x0
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 03                	push   $0x3
  8010c6:	e8 4b ff ff ff       	call   801016 <syscall>
  8010cb:	83 c4 18             	add    $0x18,%esp
}
  8010ce:	c9                   	leave  
  8010cf:	c3                   	ret    

008010d0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010d3:	6a 00                	push   $0x0
  8010d5:	6a 00                	push   $0x0
  8010d7:	6a 00                	push   $0x0
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 04                	push   $0x4
  8010df:	e8 32 ff ff ff       	call   801016 <syscall>
  8010e4:	83 c4 18             	add    $0x18,%esp
}
  8010e7:	c9                   	leave  
  8010e8:	c3                   	ret    

008010e9 <sys_env_exit>:


void sys_env_exit(void)
{
  8010e9:	55                   	push   %ebp
  8010ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 06                	push   $0x6
  8010f8:	e8 19 ff ff ff       	call   801016 <syscall>
  8010fd:	83 c4 18             	add    $0x18,%esp
}
  801100:	90                   	nop
  801101:	c9                   	leave  
  801102:	c3                   	ret    

00801103 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801103:	55                   	push   %ebp
  801104:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801106:	8b 55 0c             	mov    0xc(%ebp),%edx
  801109:	8b 45 08             	mov    0x8(%ebp),%eax
  80110c:	6a 00                	push   $0x0
  80110e:	6a 00                	push   $0x0
  801110:	6a 00                	push   $0x0
  801112:	52                   	push   %edx
  801113:	50                   	push   %eax
  801114:	6a 07                	push   $0x7
  801116:	e8 fb fe ff ff       	call   801016 <syscall>
  80111b:	83 c4 18             	add    $0x18,%esp
}
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
  801123:	56                   	push   %esi
  801124:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801125:	8b 75 18             	mov    0x18(%ebp),%esi
  801128:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80112b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80112e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	56                   	push   %esi
  801135:	53                   	push   %ebx
  801136:	51                   	push   %ecx
  801137:	52                   	push   %edx
  801138:	50                   	push   %eax
  801139:	6a 08                	push   $0x8
  80113b:	e8 d6 fe ff ff       	call   801016 <syscall>
  801140:	83 c4 18             	add    $0x18,%esp
}
  801143:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801146:	5b                   	pop    %ebx
  801147:	5e                   	pop    %esi
  801148:	5d                   	pop    %ebp
  801149:	c3                   	ret    

0080114a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80114a:	55                   	push   %ebp
  80114b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80114d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	6a 00                	push   $0x0
  801155:	6a 00                	push   $0x0
  801157:	6a 00                	push   $0x0
  801159:	52                   	push   %edx
  80115a:	50                   	push   %eax
  80115b:	6a 09                	push   $0x9
  80115d:	e8 b4 fe ff ff       	call   801016 <syscall>
  801162:	83 c4 18             	add    $0x18,%esp
}
  801165:	c9                   	leave  
  801166:	c3                   	ret    

00801167 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801167:	55                   	push   %ebp
  801168:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80116a:	6a 00                	push   $0x0
  80116c:	6a 00                	push   $0x0
  80116e:	6a 00                	push   $0x0
  801170:	ff 75 0c             	pushl  0xc(%ebp)
  801173:	ff 75 08             	pushl  0x8(%ebp)
  801176:	6a 0a                	push   $0xa
  801178:	e8 99 fe ff ff       	call   801016 <syscall>
  80117d:	83 c4 18             	add    $0x18,%esp
}
  801180:	c9                   	leave  
  801181:	c3                   	ret    

00801182 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	6a 00                	push   $0x0
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 0b                	push   $0xb
  801191:	e8 80 fe ff ff       	call   801016 <syscall>
  801196:	83 c4 18             	add    $0x18,%esp
}
  801199:	c9                   	leave  
  80119a:	c3                   	ret    

0080119b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80119b:	55                   	push   %ebp
  80119c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 00                	push   $0x0
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 0c                	push   $0xc
  8011aa:	e8 67 fe ff ff       	call   801016 <syscall>
  8011af:	83 c4 18             	add    $0x18,%esp
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 0d                	push   $0xd
  8011c3:	e8 4e fe ff ff       	call   801016 <syscall>
  8011c8:	83 c4 18             	add    $0x18,%esp
}
  8011cb:	c9                   	leave  
  8011cc:	c3                   	ret    

008011cd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011cd:	55                   	push   %ebp
  8011ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	ff 75 0c             	pushl  0xc(%ebp)
  8011d9:	ff 75 08             	pushl  0x8(%ebp)
  8011dc:	6a 11                	push   $0x11
  8011de:	e8 33 fe ff ff       	call   801016 <syscall>
  8011e3:	83 c4 18             	add    $0x18,%esp
	return;
  8011e6:	90                   	nop
}
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	ff 75 0c             	pushl  0xc(%ebp)
  8011f5:	ff 75 08             	pushl  0x8(%ebp)
  8011f8:	6a 12                	push   $0x12
  8011fa:	e8 17 fe ff ff       	call   801016 <syscall>
  8011ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801202:	90                   	nop
}
  801203:	c9                   	leave  
  801204:	c3                   	ret    

00801205 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801205:	55                   	push   %ebp
  801206:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 0e                	push   $0xe
  801214:	e8 fd fd ff ff       	call   801016 <syscall>
  801219:	83 c4 18             	add    $0x18,%esp
}
  80121c:	c9                   	leave  
  80121d:	c3                   	ret    

0080121e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	6a 00                	push   $0x0
  801229:	ff 75 08             	pushl  0x8(%ebp)
  80122c:	6a 0f                	push   $0xf
  80122e:	e8 e3 fd ff ff       	call   801016 <syscall>
  801233:	83 c4 18             	add    $0x18,%esp
}
  801236:	c9                   	leave  
  801237:	c3                   	ret    

00801238 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801238:	55                   	push   %ebp
  801239:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 10                	push   $0x10
  801247:	e8 ca fd ff ff       	call   801016 <syscall>
  80124c:	83 c4 18             	add    $0x18,%esp
}
  80124f:	90                   	nop
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 14                	push   $0x14
  801261:	e8 b0 fd ff ff       	call   801016 <syscall>
  801266:	83 c4 18             	add    $0x18,%esp
}
  801269:	90                   	nop
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 15                	push   $0x15
  80127b:	e8 96 fd ff ff       	call   801016 <syscall>
  801280:	83 c4 18             	add    $0x18,%esp
}
  801283:	90                   	nop
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <sys_cputc>:


void
sys_cputc(const char c)
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
  801289:	83 ec 04             	sub    $0x4,%esp
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801292:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	50                   	push   %eax
  80129f:	6a 16                	push   $0x16
  8012a1:	e8 70 fd ff ff       	call   801016 <syscall>
  8012a6:	83 c4 18             	add    $0x18,%esp
}
  8012a9:	90                   	nop
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 17                	push   $0x17
  8012bb:	e8 56 fd ff ff       	call   801016 <syscall>
  8012c0:	83 c4 18             	add    $0x18,%esp
}
  8012c3:	90                   	nop
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	ff 75 0c             	pushl  0xc(%ebp)
  8012d5:	50                   	push   %eax
  8012d6:	6a 18                	push   $0x18
  8012d8:	e8 39 fd ff ff       	call   801016 <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	c9                   	leave  
  8012e1:	c3                   	ret    

008012e2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	52                   	push   %edx
  8012f2:	50                   	push   %eax
  8012f3:	6a 1b                	push   $0x1b
  8012f5:	e8 1c fd ff ff       	call   801016 <syscall>
  8012fa:	83 c4 18             	add    $0x18,%esp
}
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801302:	8b 55 0c             	mov    0xc(%ebp),%edx
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	52                   	push   %edx
  80130f:	50                   	push   %eax
  801310:	6a 19                	push   $0x19
  801312:	e8 ff fc ff ff       	call   801016 <syscall>
  801317:	83 c4 18             	add    $0x18,%esp
}
  80131a:	90                   	nop
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801320:	8b 55 0c             	mov    0xc(%ebp),%edx
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	52                   	push   %edx
  80132d:	50                   	push   %eax
  80132e:	6a 1a                	push   $0x1a
  801330:	e8 e1 fc ff ff       	call   801016 <syscall>
  801335:	83 c4 18             	add    $0x18,%esp
}
  801338:	90                   	nop
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	83 ec 04             	sub    $0x4,%esp
  801341:	8b 45 10             	mov    0x10(%ebp),%eax
  801344:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801347:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80134a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	6a 00                	push   $0x0
  801353:	51                   	push   %ecx
  801354:	52                   	push   %edx
  801355:	ff 75 0c             	pushl  0xc(%ebp)
  801358:	50                   	push   %eax
  801359:	6a 1c                	push   $0x1c
  80135b:	e8 b6 fc ff ff       	call   801016 <syscall>
  801360:	83 c4 18             	add    $0x18,%esp
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801368:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	52                   	push   %edx
  801375:	50                   	push   %eax
  801376:	6a 1d                	push   $0x1d
  801378:	e8 99 fc ff ff       	call   801016 <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801385:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801388:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	51                   	push   %ecx
  801393:	52                   	push   %edx
  801394:	50                   	push   %eax
  801395:	6a 1e                	push   $0x1e
  801397:	e8 7a fc ff ff       	call   801016 <syscall>
  80139c:	83 c4 18             	add    $0x18,%esp
}
  80139f:	c9                   	leave  
  8013a0:	c3                   	ret    

008013a1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013a1:	55                   	push   %ebp
  8013a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	52                   	push   %edx
  8013b1:	50                   	push   %eax
  8013b2:	6a 1f                	push   $0x1f
  8013b4:	e8 5d fc ff ff       	call   801016 <syscall>
  8013b9:	83 c4 18             	add    $0x18,%esp
}
  8013bc:	c9                   	leave  
  8013bd:	c3                   	ret    

008013be <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 20                	push   $0x20
  8013cd:	e8 44 fc ff ff       	call   801016 <syscall>
  8013d2:	83 c4 18             	add    $0x18,%esp
}
  8013d5:	c9                   	leave  
  8013d6:	c3                   	ret    

008013d7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	6a 00                	push   $0x0
  8013df:	ff 75 14             	pushl  0x14(%ebp)
  8013e2:	ff 75 10             	pushl  0x10(%ebp)
  8013e5:	ff 75 0c             	pushl  0xc(%ebp)
  8013e8:	50                   	push   %eax
  8013e9:	6a 21                	push   $0x21
  8013eb:	e8 26 fc ff ff       	call   801016 <syscall>
  8013f0:	83 c4 18             	add    $0x18,%esp
}
  8013f3:	c9                   	leave  
  8013f4:	c3                   	ret    

008013f5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013f5:	55                   	push   %ebp
  8013f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	50                   	push   %eax
  801404:	6a 22                	push   $0x22
  801406:	e8 0b fc ff ff       	call   801016 <syscall>
  80140b:	83 c4 18             	add    $0x18,%esp
}
  80140e:	90                   	nop
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	50                   	push   %eax
  801420:	6a 23                	push   $0x23
  801422:	e8 ef fb ff ff       	call   801016 <syscall>
  801427:	83 c4 18             	add    $0x18,%esp
}
  80142a:	90                   	nop
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
  801430:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801433:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801436:	8d 50 04             	lea    0x4(%eax),%edx
  801439:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	52                   	push   %edx
  801443:	50                   	push   %eax
  801444:	6a 24                	push   $0x24
  801446:	e8 cb fb ff ff       	call   801016 <syscall>
  80144b:	83 c4 18             	add    $0x18,%esp
	return result;
  80144e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801451:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801454:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801457:	89 01                	mov    %eax,(%ecx)
  801459:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	c9                   	leave  
  801460:	c2 04 00             	ret    $0x4

00801463 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	ff 75 10             	pushl  0x10(%ebp)
  80146d:	ff 75 0c             	pushl  0xc(%ebp)
  801470:	ff 75 08             	pushl  0x8(%ebp)
  801473:	6a 13                	push   $0x13
  801475:	e8 9c fb ff ff       	call   801016 <syscall>
  80147a:	83 c4 18             	add    $0x18,%esp
	return ;
  80147d:	90                   	nop
}
  80147e:	c9                   	leave  
  80147f:	c3                   	ret    

00801480 <sys_rcr2>:
uint32 sys_rcr2()
{
  801480:	55                   	push   %ebp
  801481:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 25                	push   $0x25
  80148f:	e8 82 fb ff ff       	call   801016 <syscall>
  801494:	83 c4 18             	add    $0x18,%esp
}
  801497:	c9                   	leave  
  801498:	c3                   	ret    

00801499 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801499:	55                   	push   %ebp
  80149a:	89 e5                	mov    %esp,%ebp
  80149c:	83 ec 04             	sub    $0x4,%esp
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014a5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	50                   	push   %eax
  8014b2:	6a 26                	push   $0x26
  8014b4:	e8 5d fb ff ff       	call   801016 <syscall>
  8014b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014bc:	90                   	nop
}
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <rsttst>:
void rsttst()
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 28                	push   $0x28
  8014ce:	e8 43 fb ff ff       	call   801016 <syscall>
  8014d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d6:	90                   	nop
}
  8014d7:	c9                   	leave  
  8014d8:	c3                   	ret    

008014d9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014d9:	55                   	push   %ebp
  8014da:	89 e5                	mov    %esp,%ebp
  8014dc:	83 ec 04             	sub    $0x4,%esp
  8014df:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014e5:	8b 55 18             	mov    0x18(%ebp),%edx
  8014e8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ec:	52                   	push   %edx
  8014ed:	50                   	push   %eax
  8014ee:	ff 75 10             	pushl  0x10(%ebp)
  8014f1:	ff 75 0c             	pushl  0xc(%ebp)
  8014f4:	ff 75 08             	pushl  0x8(%ebp)
  8014f7:	6a 27                	push   $0x27
  8014f9:	e8 18 fb ff ff       	call   801016 <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801501:	90                   	nop
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <chktst>:
void chktst(uint32 n)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	ff 75 08             	pushl  0x8(%ebp)
  801512:	6a 29                	push   $0x29
  801514:	e8 fd fa ff ff       	call   801016 <syscall>
  801519:	83 c4 18             	add    $0x18,%esp
	return ;
  80151c:	90                   	nop
}
  80151d:	c9                   	leave  
  80151e:	c3                   	ret    

0080151f <inctst>:

void inctst()
{
  80151f:	55                   	push   %ebp
  801520:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 2a                	push   $0x2a
  80152e:	e8 e3 fa ff ff       	call   801016 <syscall>
  801533:	83 c4 18             	add    $0x18,%esp
	return ;
  801536:	90                   	nop
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <gettst>:
uint32 gettst()
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 2b                	push   $0x2b
  801548:	e8 c9 fa ff ff       	call   801016 <syscall>
  80154d:	83 c4 18             	add    $0x18,%esp
}
  801550:	c9                   	leave  
  801551:	c3                   	ret    

00801552 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801552:	55                   	push   %ebp
  801553:	89 e5                	mov    %esp,%ebp
  801555:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 2c                	push   $0x2c
  801564:	e8 ad fa ff ff       	call   801016 <syscall>
  801569:	83 c4 18             	add    $0x18,%esp
  80156c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80156f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801573:	75 07                	jne    80157c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801575:	b8 01 00 00 00       	mov    $0x1,%eax
  80157a:	eb 05                	jmp    801581 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80157c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
  801586:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 2c                	push   $0x2c
  801595:	e8 7c fa ff ff       	call   801016 <syscall>
  80159a:	83 c4 18             	add    $0x18,%esp
  80159d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015a0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015a4:	75 07                	jne    8015ad <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ab:	eb 05                	jmp    8015b2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b2:	c9                   	leave  
  8015b3:	c3                   	ret    

008015b4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
  8015b7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 2c                	push   $0x2c
  8015c6:	e8 4b fa ff ff       	call   801016 <syscall>
  8015cb:	83 c4 18             	add    $0x18,%esp
  8015ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015d1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015d5:	75 07                	jne    8015de <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015d7:	b8 01 00 00 00       	mov    $0x1,%eax
  8015dc:	eb 05                	jmp    8015e3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015de:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
  8015e8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 2c                	push   $0x2c
  8015f7:	e8 1a fa ff ff       	call   801016 <syscall>
  8015fc:	83 c4 18             	add    $0x18,%esp
  8015ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801602:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801606:	75 07                	jne    80160f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801608:	b8 01 00 00 00       	mov    $0x1,%eax
  80160d:	eb 05                	jmp    801614 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80160f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801614:	c9                   	leave  
  801615:	c3                   	ret    

00801616 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801616:	55                   	push   %ebp
  801617:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	ff 75 08             	pushl  0x8(%ebp)
  801624:	6a 2d                	push   $0x2d
  801626:	e8 eb f9 ff ff       	call   801016 <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
	return ;
  80162e:	90                   	nop
}
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
  801634:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801635:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801638:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80163b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	6a 00                	push   $0x0
  801643:	53                   	push   %ebx
  801644:	51                   	push   %ecx
  801645:	52                   	push   %edx
  801646:	50                   	push   %eax
  801647:	6a 2e                	push   $0x2e
  801649:	e8 c8 f9 ff ff       	call   801016 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801659:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165c:	8b 45 08             	mov    0x8(%ebp),%eax
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	52                   	push   %edx
  801666:	50                   	push   %eax
  801667:	6a 2f                	push   $0x2f
  801669:	e8 a8 f9 ff ff       	call   801016 <syscall>
  80166e:	83 c4 18             	add    $0x18,%esp
}
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
  801676:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801679:	8b 55 08             	mov    0x8(%ebp),%edx
  80167c:	89 d0                	mov    %edx,%eax
  80167e:	c1 e0 02             	shl    $0x2,%eax
  801681:	01 d0                	add    %edx,%eax
  801683:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80168a:	01 d0                	add    %edx,%eax
  80168c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801693:	01 d0                	add    %edx,%eax
  801695:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80169c:	01 d0                	add    %edx,%eax
  80169e:	c1 e0 04             	shl    $0x4,%eax
  8016a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016ab:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016ae:	83 ec 0c             	sub    $0xc,%esp
  8016b1:	50                   	push   %eax
  8016b2:	e8 76 fd ff ff       	call   80142d <sys_get_virtual_time>
  8016b7:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8016ba:	eb 41                	jmp    8016fd <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8016bc:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8016bf:	83 ec 0c             	sub    $0xc,%esp
  8016c2:	50                   	push   %eax
  8016c3:	e8 65 fd ff ff       	call   80142d <sys_get_virtual_time>
  8016c8:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8016cb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8016ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016d1:	29 c2                	sub    %eax,%edx
  8016d3:	89 d0                	mov    %edx,%eax
  8016d5:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8016d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8016db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016de:	89 d1                	mov    %edx,%ecx
  8016e0:	29 c1                	sub    %eax,%ecx
  8016e2:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8016e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016e8:	39 c2                	cmp    %eax,%edx
  8016ea:	0f 97 c0             	seta   %al
  8016ed:	0f b6 c0             	movzbl %al,%eax
  8016f0:	29 c1                	sub    %eax,%ecx
  8016f2:	89 c8                	mov    %ecx,%eax
  8016f4:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8016f7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801700:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801703:	72 b7                	jb     8016bc <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801705:	90                   	nop
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
  80170b:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80170e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801715:	eb 03                	jmp    80171a <busy_wait+0x12>
  801717:	ff 45 fc             	incl   -0x4(%ebp)
  80171a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80171d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801720:	72 f5                	jb     801717 <busy_wait+0xf>
	return i;
  801722:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    
  801727:	90                   	nop

00801728 <__udivdi3>:
  801728:	55                   	push   %ebp
  801729:	57                   	push   %edi
  80172a:	56                   	push   %esi
  80172b:	53                   	push   %ebx
  80172c:	83 ec 1c             	sub    $0x1c,%esp
  80172f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801733:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801737:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80173b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80173f:	89 ca                	mov    %ecx,%edx
  801741:	89 f8                	mov    %edi,%eax
  801743:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801747:	85 f6                	test   %esi,%esi
  801749:	75 2d                	jne    801778 <__udivdi3+0x50>
  80174b:	39 cf                	cmp    %ecx,%edi
  80174d:	77 65                	ja     8017b4 <__udivdi3+0x8c>
  80174f:	89 fd                	mov    %edi,%ebp
  801751:	85 ff                	test   %edi,%edi
  801753:	75 0b                	jne    801760 <__udivdi3+0x38>
  801755:	b8 01 00 00 00       	mov    $0x1,%eax
  80175a:	31 d2                	xor    %edx,%edx
  80175c:	f7 f7                	div    %edi
  80175e:	89 c5                	mov    %eax,%ebp
  801760:	31 d2                	xor    %edx,%edx
  801762:	89 c8                	mov    %ecx,%eax
  801764:	f7 f5                	div    %ebp
  801766:	89 c1                	mov    %eax,%ecx
  801768:	89 d8                	mov    %ebx,%eax
  80176a:	f7 f5                	div    %ebp
  80176c:	89 cf                	mov    %ecx,%edi
  80176e:	89 fa                	mov    %edi,%edx
  801770:	83 c4 1c             	add    $0x1c,%esp
  801773:	5b                   	pop    %ebx
  801774:	5e                   	pop    %esi
  801775:	5f                   	pop    %edi
  801776:	5d                   	pop    %ebp
  801777:	c3                   	ret    
  801778:	39 ce                	cmp    %ecx,%esi
  80177a:	77 28                	ja     8017a4 <__udivdi3+0x7c>
  80177c:	0f bd fe             	bsr    %esi,%edi
  80177f:	83 f7 1f             	xor    $0x1f,%edi
  801782:	75 40                	jne    8017c4 <__udivdi3+0x9c>
  801784:	39 ce                	cmp    %ecx,%esi
  801786:	72 0a                	jb     801792 <__udivdi3+0x6a>
  801788:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80178c:	0f 87 9e 00 00 00    	ja     801830 <__udivdi3+0x108>
  801792:	b8 01 00 00 00       	mov    $0x1,%eax
  801797:	89 fa                	mov    %edi,%edx
  801799:	83 c4 1c             	add    $0x1c,%esp
  80179c:	5b                   	pop    %ebx
  80179d:	5e                   	pop    %esi
  80179e:	5f                   	pop    %edi
  80179f:	5d                   	pop    %ebp
  8017a0:	c3                   	ret    
  8017a1:	8d 76 00             	lea    0x0(%esi),%esi
  8017a4:	31 ff                	xor    %edi,%edi
  8017a6:	31 c0                	xor    %eax,%eax
  8017a8:	89 fa                	mov    %edi,%edx
  8017aa:	83 c4 1c             	add    $0x1c,%esp
  8017ad:	5b                   	pop    %ebx
  8017ae:	5e                   	pop    %esi
  8017af:	5f                   	pop    %edi
  8017b0:	5d                   	pop    %ebp
  8017b1:	c3                   	ret    
  8017b2:	66 90                	xchg   %ax,%ax
  8017b4:	89 d8                	mov    %ebx,%eax
  8017b6:	f7 f7                	div    %edi
  8017b8:	31 ff                	xor    %edi,%edi
  8017ba:	89 fa                	mov    %edi,%edx
  8017bc:	83 c4 1c             	add    $0x1c,%esp
  8017bf:	5b                   	pop    %ebx
  8017c0:	5e                   	pop    %esi
  8017c1:	5f                   	pop    %edi
  8017c2:	5d                   	pop    %ebp
  8017c3:	c3                   	ret    
  8017c4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017c9:	89 eb                	mov    %ebp,%ebx
  8017cb:	29 fb                	sub    %edi,%ebx
  8017cd:	89 f9                	mov    %edi,%ecx
  8017cf:	d3 e6                	shl    %cl,%esi
  8017d1:	89 c5                	mov    %eax,%ebp
  8017d3:	88 d9                	mov    %bl,%cl
  8017d5:	d3 ed                	shr    %cl,%ebp
  8017d7:	89 e9                	mov    %ebp,%ecx
  8017d9:	09 f1                	or     %esi,%ecx
  8017db:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017df:	89 f9                	mov    %edi,%ecx
  8017e1:	d3 e0                	shl    %cl,%eax
  8017e3:	89 c5                	mov    %eax,%ebp
  8017e5:	89 d6                	mov    %edx,%esi
  8017e7:	88 d9                	mov    %bl,%cl
  8017e9:	d3 ee                	shr    %cl,%esi
  8017eb:	89 f9                	mov    %edi,%ecx
  8017ed:	d3 e2                	shl    %cl,%edx
  8017ef:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017f3:	88 d9                	mov    %bl,%cl
  8017f5:	d3 e8                	shr    %cl,%eax
  8017f7:	09 c2                	or     %eax,%edx
  8017f9:	89 d0                	mov    %edx,%eax
  8017fb:	89 f2                	mov    %esi,%edx
  8017fd:	f7 74 24 0c          	divl   0xc(%esp)
  801801:	89 d6                	mov    %edx,%esi
  801803:	89 c3                	mov    %eax,%ebx
  801805:	f7 e5                	mul    %ebp
  801807:	39 d6                	cmp    %edx,%esi
  801809:	72 19                	jb     801824 <__udivdi3+0xfc>
  80180b:	74 0b                	je     801818 <__udivdi3+0xf0>
  80180d:	89 d8                	mov    %ebx,%eax
  80180f:	31 ff                	xor    %edi,%edi
  801811:	e9 58 ff ff ff       	jmp    80176e <__udivdi3+0x46>
  801816:	66 90                	xchg   %ax,%ax
  801818:	8b 54 24 08          	mov    0x8(%esp),%edx
  80181c:	89 f9                	mov    %edi,%ecx
  80181e:	d3 e2                	shl    %cl,%edx
  801820:	39 c2                	cmp    %eax,%edx
  801822:	73 e9                	jae    80180d <__udivdi3+0xe5>
  801824:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801827:	31 ff                	xor    %edi,%edi
  801829:	e9 40 ff ff ff       	jmp    80176e <__udivdi3+0x46>
  80182e:	66 90                	xchg   %ax,%ax
  801830:	31 c0                	xor    %eax,%eax
  801832:	e9 37 ff ff ff       	jmp    80176e <__udivdi3+0x46>
  801837:	90                   	nop

00801838 <__umoddi3>:
  801838:	55                   	push   %ebp
  801839:	57                   	push   %edi
  80183a:	56                   	push   %esi
  80183b:	53                   	push   %ebx
  80183c:	83 ec 1c             	sub    $0x1c,%esp
  80183f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801843:	8b 74 24 34          	mov    0x34(%esp),%esi
  801847:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80184b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80184f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801853:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801857:	89 f3                	mov    %esi,%ebx
  801859:	89 fa                	mov    %edi,%edx
  80185b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80185f:	89 34 24             	mov    %esi,(%esp)
  801862:	85 c0                	test   %eax,%eax
  801864:	75 1a                	jne    801880 <__umoddi3+0x48>
  801866:	39 f7                	cmp    %esi,%edi
  801868:	0f 86 a2 00 00 00    	jbe    801910 <__umoddi3+0xd8>
  80186e:	89 c8                	mov    %ecx,%eax
  801870:	89 f2                	mov    %esi,%edx
  801872:	f7 f7                	div    %edi
  801874:	89 d0                	mov    %edx,%eax
  801876:	31 d2                	xor    %edx,%edx
  801878:	83 c4 1c             	add    $0x1c,%esp
  80187b:	5b                   	pop    %ebx
  80187c:	5e                   	pop    %esi
  80187d:	5f                   	pop    %edi
  80187e:	5d                   	pop    %ebp
  80187f:	c3                   	ret    
  801880:	39 f0                	cmp    %esi,%eax
  801882:	0f 87 ac 00 00 00    	ja     801934 <__umoddi3+0xfc>
  801888:	0f bd e8             	bsr    %eax,%ebp
  80188b:	83 f5 1f             	xor    $0x1f,%ebp
  80188e:	0f 84 ac 00 00 00    	je     801940 <__umoddi3+0x108>
  801894:	bf 20 00 00 00       	mov    $0x20,%edi
  801899:	29 ef                	sub    %ebp,%edi
  80189b:	89 fe                	mov    %edi,%esi
  80189d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018a1:	89 e9                	mov    %ebp,%ecx
  8018a3:	d3 e0                	shl    %cl,%eax
  8018a5:	89 d7                	mov    %edx,%edi
  8018a7:	89 f1                	mov    %esi,%ecx
  8018a9:	d3 ef                	shr    %cl,%edi
  8018ab:	09 c7                	or     %eax,%edi
  8018ad:	89 e9                	mov    %ebp,%ecx
  8018af:	d3 e2                	shl    %cl,%edx
  8018b1:	89 14 24             	mov    %edx,(%esp)
  8018b4:	89 d8                	mov    %ebx,%eax
  8018b6:	d3 e0                	shl    %cl,%eax
  8018b8:	89 c2                	mov    %eax,%edx
  8018ba:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018be:	d3 e0                	shl    %cl,%eax
  8018c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018c4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018c8:	89 f1                	mov    %esi,%ecx
  8018ca:	d3 e8                	shr    %cl,%eax
  8018cc:	09 d0                	or     %edx,%eax
  8018ce:	d3 eb                	shr    %cl,%ebx
  8018d0:	89 da                	mov    %ebx,%edx
  8018d2:	f7 f7                	div    %edi
  8018d4:	89 d3                	mov    %edx,%ebx
  8018d6:	f7 24 24             	mull   (%esp)
  8018d9:	89 c6                	mov    %eax,%esi
  8018db:	89 d1                	mov    %edx,%ecx
  8018dd:	39 d3                	cmp    %edx,%ebx
  8018df:	0f 82 87 00 00 00    	jb     80196c <__umoddi3+0x134>
  8018e5:	0f 84 91 00 00 00    	je     80197c <__umoddi3+0x144>
  8018eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018ef:	29 f2                	sub    %esi,%edx
  8018f1:	19 cb                	sbb    %ecx,%ebx
  8018f3:	89 d8                	mov    %ebx,%eax
  8018f5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018f9:	d3 e0                	shl    %cl,%eax
  8018fb:	89 e9                	mov    %ebp,%ecx
  8018fd:	d3 ea                	shr    %cl,%edx
  8018ff:	09 d0                	or     %edx,%eax
  801901:	89 e9                	mov    %ebp,%ecx
  801903:	d3 eb                	shr    %cl,%ebx
  801905:	89 da                	mov    %ebx,%edx
  801907:	83 c4 1c             	add    $0x1c,%esp
  80190a:	5b                   	pop    %ebx
  80190b:	5e                   	pop    %esi
  80190c:	5f                   	pop    %edi
  80190d:	5d                   	pop    %ebp
  80190e:	c3                   	ret    
  80190f:	90                   	nop
  801910:	89 fd                	mov    %edi,%ebp
  801912:	85 ff                	test   %edi,%edi
  801914:	75 0b                	jne    801921 <__umoddi3+0xe9>
  801916:	b8 01 00 00 00       	mov    $0x1,%eax
  80191b:	31 d2                	xor    %edx,%edx
  80191d:	f7 f7                	div    %edi
  80191f:	89 c5                	mov    %eax,%ebp
  801921:	89 f0                	mov    %esi,%eax
  801923:	31 d2                	xor    %edx,%edx
  801925:	f7 f5                	div    %ebp
  801927:	89 c8                	mov    %ecx,%eax
  801929:	f7 f5                	div    %ebp
  80192b:	89 d0                	mov    %edx,%eax
  80192d:	e9 44 ff ff ff       	jmp    801876 <__umoddi3+0x3e>
  801932:	66 90                	xchg   %ax,%ax
  801934:	89 c8                	mov    %ecx,%eax
  801936:	89 f2                	mov    %esi,%edx
  801938:	83 c4 1c             	add    $0x1c,%esp
  80193b:	5b                   	pop    %ebx
  80193c:	5e                   	pop    %esi
  80193d:	5f                   	pop    %edi
  80193e:	5d                   	pop    %ebp
  80193f:	c3                   	ret    
  801940:	3b 04 24             	cmp    (%esp),%eax
  801943:	72 06                	jb     80194b <__umoddi3+0x113>
  801945:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801949:	77 0f                	ja     80195a <__umoddi3+0x122>
  80194b:	89 f2                	mov    %esi,%edx
  80194d:	29 f9                	sub    %edi,%ecx
  80194f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801953:	89 14 24             	mov    %edx,(%esp)
  801956:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80195a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80195e:	8b 14 24             	mov    (%esp),%edx
  801961:	83 c4 1c             	add    $0x1c,%esp
  801964:	5b                   	pop    %ebx
  801965:	5e                   	pop    %esi
  801966:	5f                   	pop    %edi
  801967:	5d                   	pop    %ebp
  801968:	c3                   	ret    
  801969:	8d 76 00             	lea    0x0(%esi),%esi
  80196c:	2b 04 24             	sub    (%esp),%eax
  80196f:	19 fa                	sbb    %edi,%edx
  801971:	89 d1                	mov    %edx,%ecx
  801973:	89 c6                	mov    %eax,%esi
  801975:	e9 71 ff ff ff       	jmp    8018eb <__umoddi3+0xb3>
  80197a:	66 90                	xchg   %ax,%ax
  80197c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801980:	72 ea                	jb     80196c <__umoddi3+0x134>
  801982:	89 d9                	mov    %ebx,%ecx
  801984:	e9 62 ff ff ff       	jmp    8018eb <__umoddi3+0xb3>
