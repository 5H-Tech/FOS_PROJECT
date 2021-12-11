
obj/user/dummy_process:     file format elf32-i386


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
  800031:	e8 8d 00 00 00       	call   8000c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void high_complexity_function();

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	high_complexity_function() ;
  80003e:	e8 03 00 00 00       	call   800046 <high_complexity_function>
	return;
  800043:	90                   	nop
}
  800044:	c9                   	leave  
  800045:	c3                   	ret    

00800046 <high_complexity_function>:

void high_complexity_function()
{
  800046:	55                   	push   %ebp
  800047:	89 e5                	mov    %esp,%ebp
  800049:	83 ec 38             	sub    $0x38,%esp
	uint32 end1 = RAND(0, 5000);
  80004c:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	50                   	push   %eax
  800053:	e8 25 14 00 00       	call   80147d <sys_get_virtual_time>
  800058:	83 c4 0c             	add    $0xc,%esp
  80005b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80005e:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800063:	ba 00 00 00 00       	mov    $0x0,%edx
  800068:	f7 f1                	div    %ecx
  80006a:	89 55 e8             	mov    %edx,-0x18(%ebp)
	uint32 end2 = RAND(0, 5000);
  80006d:	8d 45 dc             	lea    -0x24(%ebp),%eax
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	50                   	push   %eax
  800074:	e8 04 14 00 00       	call   80147d <sys_get_virtual_time>
  800079:	83 c4 0c             	add    $0xc,%esp
  80007c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80007f:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800084:	ba 00 00 00 00       	mov    $0x0,%edx
  800089:	f7 f1                	div    %ecx
  80008b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int x = 10;
  80008e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
	for(int i = 0; i <= end1; i++)
  800095:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009c:	eb 1a                	jmp    8000b8 <high_complexity_function+0x72>
	{
		for(int i = 0; i <= end2; i++)
  80009e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8000a5:	eb 06                	jmp    8000ad <high_complexity_function+0x67>
		{
			{
				 x++;
  8000a7:	ff 45 f4             	incl   -0xc(%ebp)
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
	{
		for(int i = 0; i <= end2; i++)
  8000aa:	ff 45 ec             	incl   -0x14(%ebp)
  8000ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8000b3:	76 f2                	jbe    8000a7 <high_complexity_function+0x61>
void high_complexity_function()
{
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
  8000b5:	ff 45 f0             	incl   -0x10(%ebp)
  8000b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8000be:	76 de                	jbe    80009e <high_complexity_function+0x58>
			{
				 x++;
			}
		}
	}
}
  8000c0:	90                   	nop
  8000c1:	c9                   	leave  
  8000c2:	c3                   	ret    

008000c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c3:	55                   	push   %ebp
  8000c4:	89 e5                	mov    %esp,%ebp
  8000c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c9:	e8 39 10 00 00       	call   801107 <sys_getenvindex>
  8000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d4:	89 d0                	mov    %edx,%eax
  8000d6:	c1 e0 03             	shl    $0x3,%eax
  8000d9:	01 d0                	add    %edx,%eax
  8000db:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000e2:	01 c8                	add    %ecx,%eax
  8000e4:	01 c0                	add    %eax,%eax
  8000e6:	01 d0                	add    %edx,%eax
  8000e8:	01 c0                	add    %eax,%eax
  8000ea:	01 d0                	add    %edx,%eax
  8000ec:	89 c2                	mov    %eax,%edx
  8000ee:	c1 e2 05             	shl    $0x5,%edx
  8000f1:	29 c2                	sub    %eax,%edx
  8000f3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000fa:	89 c2                	mov    %eax,%edx
  8000fc:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800102:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800107:	a1 20 20 80 00       	mov    0x802020,%eax
  80010c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800112:	84 c0                	test   %al,%al
  800114:	74 0f                	je     800125 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800116:	a1 20 20 80 00       	mov    0x802020,%eax
  80011b:	05 40 3c 01 00       	add    $0x13c40,%eax
  800120:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800125:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800129:	7e 0a                	jle    800135 <libmain+0x72>
		binaryname = argv[0];
  80012b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012e:	8b 00                	mov    (%eax),%eax
  800130:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800135:	83 ec 08             	sub    $0x8,%esp
  800138:	ff 75 0c             	pushl  0xc(%ebp)
  80013b:	ff 75 08             	pushl  0x8(%ebp)
  80013e:	e8 f5 fe ff ff       	call   800038 <_main>
  800143:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800146:	e8 57 11 00 00       	call   8012a2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80014b:	83 ec 0c             	sub    $0xc,%esp
  80014e:	68 58 19 80 00       	push   $0x801958
  800153:	e8 84 01 00 00       	call   8002dc <cprintf>
  800158:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80015b:	a1 20 20 80 00       	mov    0x802020,%eax
  800160:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800166:	a1 20 20 80 00       	mov    0x802020,%eax
  80016b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	52                   	push   %edx
  800175:	50                   	push   %eax
  800176:	68 80 19 80 00       	push   $0x801980
  80017b:	e8 5c 01 00 00       	call   8002dc <cprintf>
  800180:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800183:	a1 20 20 80 00       	mov    0x802020,%eax
  800188:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80018e:	a1 20 20 80 00       	mov    0x802020,%eax
  800193:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	52                   	push   %edx
  80019d:	50                   	push   %eax
  80019e:	68 a8 19 80 00       	push   $0x8019a8
  8001a3:	e8 34 01 00 00       	call   8002dc <cprintf>
  8001a8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001ab:	a1 20 20 80 00       	mov    0x802020,%eax
  8001b0:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	50                   	push   %eax
  8001ba:	68 e9 19 80 00       	push   $0x8019e9
  8001bf:	e8 18 01 00 00       	call   8002dc <cprintf>
  8001c4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001c7:	83 ec 0c             	sub    $0xc,%esp
  8001ca:	68 58 19 80 00       	push   $0x801958
  8001cf:	e8 08 01 00 00       	call   8002dc <cprintf>
  8001d4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001d7:	e8 e0 10 00 00       	call   8012bc <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001dc:	e8 19 00 00 00       	call   8001fa <exit>
}
  8001e1:	90                   	nop
  8001e2:	c9                   	leave  
  8001e3:	c3                   	ret    

008001e4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001e4:	55                   	push   %ebp
  8001e5:	89 e5                	mov    %esp,%ebp
  8001e7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001ea:	83 ec 0c             	sub    $0xc,%esp
  8001ed:	6a 00                	push   $0x0
  8001ef:	e8 df 0e 00 00       	call   8010d3 <sys_env_destroy>
  8001f4:	83 c4 10             	add    $0x10,%esp
}
  8001f7:	90                   	nop
  8001f8:	c9                   	leave  
  8001f9:	c3                   	ret    

008001fa <exit>:

void
exit(void)
{
  8001fa:	55                   	push   %ebp
  8001fb:	89 e5                	mov    %esp,%ebp
  8001fd:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800200:	e8 34 0f 00 00       	call   801139 <sys_env_exit>
}
  800205:	90                   	nop
  800206:	c9                   	leave  
  800207:	c3                   	ret    

00800208 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800208:	55                   	push   %ebp
  800209:	89 e5                	mov    %esp,%ebp
  80020b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80020e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800211:	8b 00                	mov    (%eax),%eax
  800213:	8d 48 01             	lea    0x1(%eax),%ecx
  800216:	8b 55 0c             	mov    0xc(%ebp),%edx
  800219:	89 0a                	mov    %ecx,(%edx)
  80021b:	8b 55 08             	mov    0x8(%ebp),%edx
  80021e:	88 d1                	mov    %dl,%cl
  800220:	8b 55 0c             	mov    0xc(%ebp),%edx
  800223:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022a:	8b 00                	mov    (%eax),%eax
  80022c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800231:	75 2c                	jne    80025f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800233:	a0 24 20 80 00       	mov    0x802024,%al
  800238:	0f b6 c0             	movzbl %al,%eax
  80023b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023e:	8b 12                	mov    (%edx),%edx
  800240:	89 d1                	mov    %edx,%ecx
  800242:	8b 55 0c             	mov    0xc(%ebp),%edx
  800245:	83 c2 08             	add    $0x8,%edx
  800248:	83 ec 04             	sub    $0x4,%esp
  80024b:	50                   	push   %eax
  80024c:	51                   	push   %ecx
  80024d:	52                   	push   %edx
  80024e:	e8 3e 0e 00 00       	call   801091 <sys_cputs>
  800253:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800256:	8b 45 0c             	mov    0xc(%ebp),%eax
  800259:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80025f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800262:	8b 40 04             	mov    0x4(%eax),%eax
  800265:	8d 50 01             	lea    0x1(%eax),%edx
  800268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80026e:	90                   	nop
  80026f:	c9                   	leave  
  800270:	c3                   	ret    

00800271 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800271:	55                   	push   %ebp
  800272:	89 e5                	mov    %esp,%ebp
  800274:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80027a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800281:	00 00 00 
	b.cnt = 0;
  800284:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80028b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80028e:	ff 75 0c             	pushl  0xc(%ebp)
  800291:	ff 75 08             	pushl  0x8(%ebp)
  800294:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80029a:	50                   	push   %eax
  80029b:	68 08 02 80 00       	push   $0x800208
  8002a0:	e8 11 02 00 00       	call   8004b6 <vprintfmt>
  8002a5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002a8:	a0 24 20 80 00       	mov    0x802024,%al
  8002ad:	0f b6 c0             	movzbl %al,%eax
  8002b0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002b6:	83 ec 04             	sub    $0x4,%esp
  8002b9:	50                   	push   %eax
  8002ba:	52                   	push   %edx
  8002bb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002c1:	83 c0 08             	add    $0x8,%eax
  8002c4:	50                   	push   %eax
  8002c5:	e8 c7 0d 00 00       	call   801091 <sys_cputs>
  8002ca:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002cd:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002d4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002da:	c9                   	leave  
  8002db:	c3                   	ret    

008002dc <cprintf>:

int cprintf(const char *fmt, ...) {
  8002dc:	55                   	push   %ebp
  8002dd:	89 e5                	mov    %esp,%ebp
  8002df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002e2:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002e9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f2:	83 ec 08             	sub    $0x8,%esp
  8002f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f8:	50                   	push   %eax
  8002f9:	e8 73 ff ff ff       	call   800271 <vcprintf>
  8002fe:	83 c4 10             	add    $0x10,%esp
  800301:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800304:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800307:	c9                   	leave  
  800308:	c3                   	ret    

00800309 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800309:	55                   	push   %ebp
  80030a:	89 e5                	mov    %esp,%ebp
  80030c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80030f:	e8 8e 0f 00 00       	call   8012a2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800314:	8d 45 0c             	lea    0xc(%ebp),%eax
  800317:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80031a:	8b 45 08             	mov    0x8(%ebp),%eax
  80031d:	83 ec 08             	sub    $0x8,%esp
  800320:	ff 75 f4             	pushl  -0xc(%ebp)
  800323:	50                   	push   %eax
  800324:	e8 48 ff ff ff       	call   800271 <vcprintf>
  800329:	83 c4 10             	add    $0x10,%esp
  80032c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80032f:	e8 88 0f 00 00       	call   8012bc <sys_enable_interrupt>
	return cnt;
  800334:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800337:	c9                   	leave  
  800338:	c3                   	ret    

00800339 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800339:	55                   	push   %ebp
  80033a:	89 e5                	mov    %esp,%ebp
  80033c:	53                   	push   %ebx
  80033d:	83 ec 14             	sub    $0x14,%esp
  800340:	8b 45 10             	mov    0x10(%ebp),%eax
  800343:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800346:	8b 45 14             	mov    0x14(%ebp),%eax
  800349:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80034c:	8b 45 18             	mov    0x18(%ebp),%eax
  80034f:	ba 00 00 00 00       	mov    $0x0,%edx
  800354:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800357:	77 55                	ja     8003ae <printnum+0x75>
  800359:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80035c:	72 05                	jb     800363 <printnum+0x2a>
  80035e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800361:	77 4b                	ja     8003ae <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800363:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800366:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800369:	8b 45 18             	mov    0x18(%ebp),%eax
  80036c:	ba 00 00 00 00       	mov    $0x0,%edx
  800371:	52                   	push   %edx
  800372:	50                   	push   %eax
  800373:	ff 75 f4             	pushl  -0xc(%ebp)
  800376:	ff 75 f0             	pushl  -0x10(%ebp)
  800379:	e8 46 13 00 00       	call   8016c4 <__udivdi3>
  80037e:	83 c4 10             	add    $0x10,%esp
  800381:	83 ec 04             	sub    $0x4,%esp
  800384:	ff 75 20             	pushl  0x20(%ebp)
  800387:	53                   	push   %ebx
  800388:	ff 75 18             	pushl  0x18(%ebp)
  80038b:	52                   	push   %edx
  80038c:	50                   	push   %eax
  80038d:	ff 75 0c             	pushl  0xc(%ebp)
  800390:	ff 75 08             	pushl  0x8(%ebp)
  800393:	e8 a1 ff ff ff       	call   800339 <printnum>
  800398:	83 c4 20             	add    $0x20,%esp
  80039b:	eb 1a                	jmp    8003b7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80039d:	83 ec 08             	sub    $0x8,%esp
  8003a0:	ff 75 0c             	pushl  0xc(%ebp)
  8003a3:	ff 75 20             	pushl  0x20(%ebp)
  8003a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a9:	ff d0                	call   *%eax
  8003ab:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ae:	ff 4d 1c             	decl   0x1c(%ebp)
  8003b1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003b5:	7f e6                	jg     80039d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003b7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003ba:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003c5:	53                   	push   %ebx
  8003c6:	51                   	push   %ecx
  8003c7:	52                   	push   %edx
  8003c8:	50                   	push   %eax
  8003c9:	e8 06 14 00 00       	call   8017d4 <__umoddi3>
  8003ce:	83 c4 10             	add    $0x10,%esp
  8003d1:	05 14 1c 80 00       	add    $0x801c14,%eax
  8003d6:	8a 00                	mov    (%eax),%al
  8003d8:	0f be c0             	movsbl %al,%eax
  8003db:	83 ec 08             	sub    $0x8,%esp
  8003de:	ff 75 0c             	pushl  0xc(%ebp)
  8003e1:	50                   	push   %eax
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	ff d0                	call   *%eax
  8003e7:	83 c4 10             	add    $0x10,%esp
}
  8003ea:	90                   	nop
  8003eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003ee:	c9                   	leave  
  8003ef:	c3                   	ret    

008003f0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003f0:	55                   	push   %ebp
  8003f1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003f3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003f7:	7e 1c                	jle    800415 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	8d 50 08             	lea    0x8(%eax),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	89 10                	mov    %edx,(%eax)
  800406:	8b 45 08             	mov    0x8(%ebp),%eax
  800409:	8b 00                	mov    (%eax),%eax
  80040b:	83 e8 08             	sub    $0x8,%eax
  80040e:	8b 50 04             	mov    0x4(%eax),%edx
  800411:	8b 00                	mov    (%eax),%eax
  800413:	eb 40                	jmp    800455 <getuint+0x65>
	else if (lflag)
  800415:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800419:	74 1e                	je     800439 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80041b:	8b 45 08             	mov    0x8(%ebp),%eax
  80041e:	8b 00                	mov    (%eax),%eax
  800420:	8d 50 04             	lea    0x4(%eax),%edx
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	89 10                	mov    %edx,(%eax)
  800428:	8b 45 08             	mov    0x8(%ebp),%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	83 e8 04             	sub    $0x4,%eax
  800430:	8b 00                	mov    (%eax),%eax
  800432:	ba 00 00 00 00       	mov    $0x0,%edx
  800437:	eb 1c                	jmp    800455 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  800455:	5d                   	pop    %ebp
  800456:	c3                   	ret    

00800457 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800457:	55                   	push   %ebp
  800458:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80045a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80045e:	7e 1c                	jle    80047c <getint+0x25>
		return va_arg(*ap, long long);
  800460:	8b 45 08             	mov    0x8(%ebp),%eax
  800463:	8b 00                	mov    (%eax),%eax
  800465:	8d 50 08             	lea    0x8(%eax),%edx
  800468:	8b 45 08             	mov    0x8(%ebp),%eax
  80046b:	89 10                	mov    %edx,(%eax)
  80046d:	8b 45 08             	mov    0x8(%ebp),%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 e8 08             	sub    $0x8,%eax
  800475:	8b 50 04             	mov    0x4(%eax),%edx
  800478:	8b 00                	mov    (%eax),%eax
  80047a:	eb 38                	jmp    8004b4 <getint+0x5d>
	else if (lflag)
  80047c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800480:	74 1a                	je     80049c <getint+0x45>
		return va_arg(*ap, long);
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	8b 00                	mov    (%eax),%eax
  800487:	8d 50 04             	lea    0x4(%eax),%edx
  80048a:	8b 45 08             	mov    0x8(%ebp),%eax
  80048d:	89 10                	mov    %edx,(%eax)
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	83 e8 04             	sub    $0x4,%eax
  800497:	8b 00                	mov    (%eax),%eax
  800499:	99                   	cltd   
  80049a:	eb 18                	jmp    8004b4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80049c:	8b 45 08             	mov    0x8(%ebp),%eax
  80049f:	8b 00                	mov    (%eax),%eax
  8004a1:	8d 50 04             	lea    0x4(%eax),%edx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	89 10                	mov    %edx,(%eax)
  8004a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ac:	8b 00                	mov    (%eax),%eax
  8004ae:	83 e8 04             	sub    $0x4,%eax
  8004b1:	8b 00                	mov    (%eax),%eax
  8004b3:	99                   	cltd   
}
  8004b4:	5d                   	pop    %ebp
  8004b5:	c3                   	ret    

008004b6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004b6:	55                   	push   %ebp
  8004b7:	89 e5                	mov    %esp,%ebp
  8004b9:	56                   	push   %esi
  8004ba:	53                   	push   %ebx
  8004bb:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004be:	eb 17                	jmp    8004d7 <vprintfmt+0x21>
			if (ch == '\0')
  8004c0:	85 db                	test   %ebx,%ebx
  8004c2:	0f 84 af 03 00 00    	je     800877 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004c8:	83 ec 08             	sub    $0x8,%esp
  8004cb:	ff 75 0c             	pushl  0xc(%ebp)
  8004ce:	53                   	push   %ebx
  8004cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d2:	ff d0                	call   *%eax
  8004d4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004da:	8d 50 01             	lea    0x1(%eax),%edx
  8004dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8004e0:	8a 00                	mov    (%eax),%al
  8004e2:	0f b6 d8             	movzbl %al,%ebx
  8004e5:	83 fb 25             	cmp    $0x25,%ebx
  8004e8:	75 d6                	jne    8004c0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004ea:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004ee:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004f5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004fc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800503:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80050a:	8b 45 10             	mov    0x10(%ebp),%eax
  80050d:	8d 50 01             	lea    0x1(%eax),%edx
  800510:	89 55 10             	mov    %edx,0x10(%ebp)
  800513:	8a 00                	mov    (%eax),%al
  800515:	0f b6 d8             	movzbl %al,%ebx
  800518:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80051b:	83 f8 55             	cmp    $0x55,%eax
  80051e:	0f 87 2b 03 00 00    	ja     80084f <vprintfmt+0x399>
  800524:	8b 04 85 38 1c 80 00 	mov    0x801c38(,%eax,4),%eax
  80052b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80052d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800531:	eb d7                	jmp    80050a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800533:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800537:	eb d1                	jmp    80050a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800539:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800540:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800543:	89 d0                	mov    %edx,%eax
  800545:	c1 e0 02             	shl    $0x2,%eax
  800548:	01 d0                	add    %edx,%eax
  80054a:	01 c0                	add    %eax,%eax
  80054c:	01 d8                	add    %ebx,%eax
  80054e:	83 e8 30             	sub    $0x30,%eax
  800551:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800554:	8b 45 10             	mov    0x10(%ebp),%eax
  800557:	8a 00                	mov    (%eax),%al
  800559:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80055c:	83 fb 2f             	cmp    $0x2f,%ebx
  80055f:	7e 3e                	jle    80059f <vprintfmt+0xe9>
  800561:	83 fb 39             	cmp    $0x39,%ebx
  800564:	7f 39                	jg     80059f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800566:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800569:	eb d5                	jmp    800540 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80056b:	8b 45 14             	mov    0x14(%ebp),%eax
  80056e:	83 c0 04             	add    $0x4,%eax
  800571:	89 45 14             	mov    %eax,0x14(%ebp)
  800574:	8b 45 14             	mov    0x14(%ebp),%eax
  800577:	83 e8 04             	sub    $0x4,%eax
  80057a:	8b 00                	mov    (%eax),%eax
  80057c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80057f:	eb 1f                	jmp    8005a0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800581:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800585:	79 83                	jns    80050a <vprintfmt+0x54>
				width = 0;
  800587:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80058e:	e9 77 ff ff ff       	jmp    80050a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800593:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80059a:	e9 6b ff ff ff       	jmp    80050a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80059f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005a0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005a4:	0f 89 60 ff ff ff    	jns    80050a <vprintfmt+0x54>
				width = precision, precision = -1;
  8005aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005b0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005b7:	e9 4e ff ff ff       	jmp    80050a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005bc:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005bf:	e9 46 ff ff ff       	jmp    80050a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c7:	83 c0 04             	add    $0x4,%eax
  8005ca:	89 45 14             	mov    %eax,0x14(%ebp)
  8005cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d0:	83 e8 04             	sub    $0x4,%eax
  8005d3:	8b 00                	mov    (%eax),%eax
  8005d5:	83 ec 08             	sub    $0x8,%esp
  8005d8:	ff 75 0c             	pushl  0xc(%ebp)
  8005db:	50                   	push   %eax
  8005dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005df:	ff d0                	call   *%eax
  8005e1:	83 c4 10             	add    $0x10,%esp
			break;
  8005e4:	e9 89 02 00 00       	jmp    800872 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ec:	83 c0 04             	add    $0x4,%eax
  8005ef:	89 45 14             	mov    %eax,0x14(%ebp)
  8005f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f5:	83 e8 04             	sub    $0x4,%eax
  8005f8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005fa:	85 db                	test   %ebx,%ebx
  8005fc:	79 02                	jns    800600 <vprintfmt+0x14a>
				err = -err;
  8005fe:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800600:	83 fb 64             	cmp    $0x64,%ebx
  800603:	7f 0b                	jg     800610 <vprintfmt+0x15a>
  800605:	8b 34 9d 80 1a 80 00 	mov    0x801a80(,%ebx,4),%esi
  80060c:	85 f6                	test   %esi,%esi
  80060e:	75 19                	jne    800629 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800610:	53                   	push   %ebx
  800611:	68 25 1c 80 00       	push   $0x801c25
  800616:	ff 75 0c             	pushl  0xc(%ebp)
  800619:	ff 75 08             	pushl  0x8(%ebp)
  80061c:	e8 5e 02 00 00       	call   80087f <printfmt>
  800621:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800624:	e9 49 02 00 00       	jmp    800872 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800629:	56                   	push   %esi
  80062a:	68 2e 1c 80 00       	push   $0x801c2e
  80062f:	ff 75 0c             	pushl  0xc(%ebp)
  800632:	ff 75 08             	pushl  0x8(%ebp)
  800635:	e8 45 02 00 00       	call   80087f <printfmt>
  80063a:	83 c4 10             	add    $0x10,%esp
			break;
  80063d:	e9 30 02 00 00       	jmp    800872 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800642:	8b 45 14             	mov    0x14(%ebp),%eax
  800645:	83 c0 04             	add    $0x4,%eax
  800648:	89 45 14             	mov    %eax,0x14(%ebp)
  80064b:	8b 45 14             	mov    0x14(%ebp),%eax
  80064e:	83 e8 04             	sub    $0x4,%eax
  800651:	8b 30                	mov    (%eax),%esi
  800653:	85 f6                	test   %esi,%esi
  800655:	75 05                	jne    80065c <vprintfmt+0x1a6>
				p = "(null)";
  800657:	be 31 1c 80 00       	mov    $0x801c31,%esi
			if (width > 0 && padc != '-')
  80065c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800660:	7e 6d                	jle    8006cf <vprintfmt+0x219>
  800662:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800666:	74 67                	je     8006cf <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800668:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80066b:	83 ec 08             	sub    $0x8,%esp
  80066e:	50                   	push   %eax
  80066f:	56                   	push   %esi
  800670:	e8 0c 03 00 00       	call   800981 <strnlen>
  800675:	83 c4 10             	add    $0x10,%esp
  800678:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80067b:	eb 16                	jmp    800693 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80067d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800681:	83 ec 08             	sub    $0x8,%esp
  800684:	ff 75 0c             	pushl  0xc(%ebp)
  800687:	50                   	push   %eax
  800688:	8b 45 08             	mov    0x8(%ebp),%eax
  80068b:	ff d0                	call   *%eax
  80068d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800690:	ff 4d e4             	decl   -0x1c(%ebp)
  800693:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800697:	7f e4                	jg     80067d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800699:	eb 34                	jmp    8006cf <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80069b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80069f:	74 1c                	je     8006bd <vprintfmt+0x207>
  8006a1:	83 fb 1f             	cmp    $0x1f,%ebx
  8006a4:	7e 05                	jle    8006ab <vprintfmt+0x1f5>
  8006a6:	83 fb 7e             	cmp    $0x7e,%ebx
  8006a9:	7e 12                	jle    8006bd <vprintfmt+0x207>
					putch('?', putdat);
  8006ab:	83 ec 08             	sub    $0x8,%esp
  8006ae:	ff 75 0c             	pushl  0xc(%ebp)
  8006b1:	6a 3f                	push   $0x3f
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	ff d0                	call   *%eax
  8006b8:	83 c4 10             	add    $0x10,%esp
  8006bb:	eb 0f                	jmp    8006cc <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006bd:	83 ec 08             	sub    $0x8,%esp
  8006c0:	ff 75 0c             	pushl  0xc(%ebp)
  8006c3:	53                   	push   %ebx
  8006c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c7:	ff d0                	call   *%eax
  8006c9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006cc:	ff 4d e4             	decl   -0x1c(%ebp)
  8006cf:	89 f0                	mov    %esi,%eax
  8006d1:	8d 70 01             	lea    0x1(%eax),%esi
  8006d4:	8a 00                	mov    (%eax),%al
  8006d6:	0f be d8             	movsbl %al,%ebx
  8006d9:	85 db                	test   %ebx,%ebx
  8006db:	74 24                	je     800701 <vprintfmt+0x24b>
  8006dd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006e1:	78 b8                	js     80069b <vprintfmt+0x1e5>
  8006e3:	ff 4d e0             	decl   -0x20(%ebp)
  8006e6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ea:	79 af                	jns    80069b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ec:	eb 13                	jmp    800701 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006ee:	83 ec 08             	sub    $0x8,%esp
  8006f1:	ff 75 0c             	pushl  0xc(%ebp)
  8006f4:	6a 20                	push   $0x20
  8006f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f9:	ff d0                	call   *%eax
  8006fb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006fe:	ff 4d e4             	decl   -0x1c(%ebp)
  800701:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800705:	7f e7                	jg     8006ee <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800707:	e9 66 01 00 00       	jmp    800872 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80070c:	83 ec 08             	sub    $0x8,%esp
  80070f:	ff 75 e8             	pushl  -0x18(%ebp)
  800712:	8d 45 14             	lea    0x14(%ebp),%eax
  800715:	50                   	push   %eax
  800716:	e8 3c fd ff ff       	call   800457 <getint>
  80071b:	83 c4 10             	add    $0x10,%esp
  80071e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800721:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800724:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800727:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80072a:	85 d2                	test   %edx,%edx
  80072c:	79 23                	jns    800751 <vprintfmt+0x29b>
				putch('-', putdat);
  80072e:	83 ec 08             	sub    $0x8,%esp
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	6a 2d                	push   $0x2d
  800736:	8b 45 08             	mov    0x8(%ebp),%eax
  800739:	ff d0                	call   *%eax
  80073b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80073e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800741:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800744:	f7 d8                	neg    %eax
  800746:	83 d2 00             	adc    $0x0,%edx
  800749:	f7 da                	neg    %edx
  80074b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800751:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800758:	e9 bc 00 00 00       	jmp    800819 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80075d:	83 ec 08             	sub    $0x8,%esp
  800760:	ff 75 e8             	pushl  -0x18(%ebp)
  800763:	8d 45 14             	lea    0x14(%ebp),%eax
  800766:	50                   	push   %eax
  800767:	e8 84 fc ff ff       	call   8003f0 <getuint>
  80076c:	83 c4 10             	add    $0x10,%esp
  80076f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800772:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800775:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80077c:	e9 98 00 00 00       	jmp    800819 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	ff 75 0c             	pushl  0xc(%ebp)
  800787:	6a 58                	push   $0x58
  800789:	8b 45 08             	mov    0x8(%ebp),%eax
  80078c:	ff d0                	call   *%eax
  80078e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800791:	83 ec 08             	sub    $0x8,%esp
  800794:	ff 75 0c             	pushl  0xc(%ebp)
  800797:	6a 58                	push   $0x58
  800799:	8b 45 08             	mov    0x8(%ebp),%eax
  80079c:	ff d0                	call   *%eax
  80079e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 0c             	pushl  0xc(%ebp)
  8007a7:	6a 58                	push   $0x58
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	ff d0                	call   *%eax
  8007ae:	83 c4 10             	add    $0x10,%esp
			break;
  8007b1:	e9 bc 00 00 00       	jmp    800872 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007b6:	83 ec 08             	sub    $0x8,%esp
  8007b9:	ff 75 0c             	pushl  0xc(%ebp)
  8007bc:	6a 30                	push   $0x30
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	ff d0                	call   *%eax
  8007c3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007c6:	83 ec 08             	sub    $0x8,%esp
  8007c9:	ff 75 0c             	pushl  0xc(%ebp)
  8007cc:	6a 78                	push   $0x78
  8007ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d1:	ff d0                	call   *%eax
  8007d3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d9:	83 c0 04             	add    $0x4,%eax
  8007dc:	89 45 14             	mov    %eax,0x14(%ebp)
  8007df:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e2:	83 e8 04             	sub    $0x4,%eax
  8007e5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007f8:	eb 1f                	jmp    800819 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007fa:	83 ec 08             	sub    $0x8,%esp
  8007fd:	ff 75 e8             	pushl  -0x18(%ebp)
  800800:	8d 45 14             	lea    0x14(%ebp),%eax
  800803:	50                   	push   %eax
  800804:	e8 e7 fb ff ff       	call   8003f0 <getuint>
  800809:	83 c4 10             	add    $0x10,%esp
  80080c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800812:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800819:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80081d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800820:	83 ec 04             	sub    $0x4,%esp
  800823:	52                   	push   %edx
  800824:	ff 75 e4             	pushl  -0x1c(%ebp)
  800827:	50                   	push   %eax
  800828:	ff 75 f4             	pushl  -0xc(%ebp)
  80082b:	ff 75 f0             	pushl  -0x10(%ebp)
  80082e:	ff 75 0c             	pushl  0xc(%ebp)
  800831:	ff 75 08             	pushl  0x8(%ebp)
  800834:	e8 00 fb ff ff       	call   800339 <printnum>
  800839:	83 c4 20             	add    $0x20,%esp
			break;
  80083c:	eb 34                	jmp    800872 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80083e:	83 ec 08             	sub    $0x8,%esp
  800841:	ff 75 0c             	pushl  0xc(%ebp)
  800844:	53                   	push   %ebx
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	ff d0                	call   *%eax
  80084a:	83 c4 10             	add    $0x10,%esp
			break;
  80084d:	eb 23                	jmp    800872 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80084f:	83 ec 08             	sub    $0x8,%esp
  800852:	ff 75 0c             	pushl  0xc(%ebp)
  800855:	6a 25                	push   $0x25
  800857:	8b 45 08             	mov    0x8(%ebp),%eax
  80085a:	ff d0                	call   *%eax
  80085c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80085f:	ff 4d 10             	decl   0x10(%ebp)
  800862:	eb 03                	jmp    800867 <vprintfmt+0x3b1>
  800864:	ff 4d 10             	decl   0x10(%ebp)
  800867:	8b 45 10             	mov    0x10(%ebp),%eax
  80086a:	48                   	dec    %eax
  80086b:	8a 00                	mov    (%eax),%al
  80086d:	3c 25                	cmp    $0x25,%al
  80086f:	75 f3                	jne    800864 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800871:	90                   	nop
		}
	}
  800872:	e9 47 fc ff ff       	jmp    8004be <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800877:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800878:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80087b:	5b                   	pop    %ebx
  80087c:	5e                   	pop    %esi
  80087d:	5d                   	pop    %ebp
  80087e:	c3                   	ret    

0080087f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80087f:	55                   	push   %ebp
  800880:	89 e5                	mov    %esp,%ebp
  800882:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800885:	8d 45 10             	lea    0x10(%ebp),%eax
  800888:	83 c0 04             	add    $0x4,%eax
  80088b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80088e:	8b 45 10             	mov    0x10(%ebp),%eax
  800891:	ff 75 f4             	pushl  -0xc(%ebp)
  800894:	50                   	push   %eax
  800895:	ff 75 0c             	pushl  0xc(%ebp)
  800898:	ff 75 08             	pushl  0x8(%ebp)
  80089b:	e8 16 fc ff ff       	call   8004b6 <vprintfmt>
  8008a0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008a3:	90                   	nop
  8008a4:	c9                   	leave  
  8008a5:	c3                   	ret    

008008a6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008a6:	55                   	push   %ebp
  8008a7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ac:	8b 40 08             	mov    0x8(%eax),%eax
  8008af:	8d 50 01             	lea    0x1(%eax),%edx
  8008b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bb:	8b 10                	mov    (%eax),%edx
  8008bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c0:	8b 40 04             	mov    0x4(%eax),%eax
  8008c3:	39 c2                	cmp    %eax,%edx
  8008c5:	73 12                	jae    8008d9 <sprintputch+0x33>
		*b->buf++ = ch;
  8008c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ca:	8b 00                	mov    (%eax),%eax
  8008cc:	8d 48 01             	lea    0x1(%eax),%ecx
  8008cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d2:	89 0a                	mov    %ecx,(%edx)
  8008d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8008d7:	88 10                	mov    %dl,(%eax)
}
  8008d9:	90                   	nop
  8008da:	5d                   	pop    %ebp
  8008db:	c3                   	ret    

008008dc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f1:	01 d0                	add    %edx,%eax
  8008f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800901:	74 06                	je     800909 <vsnprintf+0x2d>
  800903:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800907:	7f 07                	jg     800910 <vsnprintf+0x34>
		return -E_INVAL;
  800909:	b8 03 00 00 00       	mov    $0x3,%eax
  80090e:	eb 20                	jmp    800930 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800910:	ff 75 14             	pushl  0x14(%ebp)
  800913:	ff 75 10             	pushl  0x10(%ebp)
  800916:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800919:	50                   	push   %eax
  80091a:	68 a6 08 80 00       	push   $0x8008a6
  80091f:	e8 92 fb ff ff       	call   8004b6 <vprintfmt>
  800924:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800927:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80092a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80092d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800930:	c9                   	leave  
  800931:	c3                   	ret    

00800932 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800932:	55                   	push   %ebp
  800933:	89 e5                	mov    %esp,%ebp
  800935:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800938:	8d 45 10             	lea    0x10(%ebp),%eax
  80093b:	83 c0 04             	add    $0x4,%eax
  80093e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800941:	8b 45 10             	mov    0x10(%ebp),%eax
  800944:	ff 75 f4             	pushl  -0xc(%ebp)
  800947:	50                   	push   %eax
  800948:	ff 75 0c             	pushl  0xc(%ebp)
  80094b:	ff 75 08             	pushl  0x8(%ebp)
  80094e:	e8 89 ff ff ff       	call   8008dc <vsnprintf>
  800953:	83 c4 10             	add    $0x10,%esp
  800956:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800959:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80095c:	c9                   	leave  
  80095d:	c3                   	ret    

0080095e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80095e:	55                   	push   %ebp
  80095f:	89 e5                	mov    %esp,%ebp
  800961:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800964:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80096b:	eb 06                	jmp    800973 <strlen+0x15>
		n++;
  80096d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800970:	ff 45 08             	incl   0x8(%ebp)
  800973:	8b 45 08             	mov    0x8(%ebp),%eax
  800976:	8a 00                	mov    (%eax),%al
  800978:	84 c0                	test   %al,%al
  80097a:	75 f1                	jne    80096d <strlen+0xf>
		n++;
	return n;
  80097c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097f:	c9                   	leave  
  800980:	c3                   	ret    

00800981 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800981:	55                   	push   %ebp
  800982:	89 e5                	mov    %esp,%ebp
  800984:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800987:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80098e:	eb 09                	jmp    800999 <strnlen+0x18>
		n++;
  800990:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800993:	ff 45 08             	incl   0x8(%ebp)
  800996:	ff 4d 0c             	decl   0xc(%ebp)
  800999:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80099d:	74 09                	je     8009a8 <strnlen+0x27>
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	8a 00                	mov    (%eax),%al
  8009a4:	84 c0                	test   %al,%al
  8009a6:	75 e8                	jne    800990 <strnlen+0xf>
		n++;
	return n;
  8009a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ab:	c9                   	leave  
  8009ac:	c3                   	ret    

008009ad <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
  8009b0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009b9:	90                   	nop
  8009ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bd:	8d 50 01             	lea    0x1(%eax),%edx
  8009c0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009c9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009cc:	8a 12                	mov    (%edx),%dl
  8009ce:	88 10                	mov    %dl,(%eax)
  8009d0:	8a 00                	mov    (%eax),%al
  8009d2:	84 c0                	test   %al,%al
  8009d4:	75 e4                	jne    8009ba <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ee:	eb 1f                	jmp    800a0f <strncpy+0x34>
		*dst++ = *src;
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	8d 50 01             	lea    0x1(%eax),%edx
  8009f6:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fc:	8a 12                	mov    (%edx),%dl
  8009fe:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a03:	8a 00                	mov    (%eax),%al
  800a05:	84 c0                	test   %al,%al
  800a07:	74 03                	je     800a0c <strncpy+0x31>
			src++;
  800a09:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a0c:	ff 45 fc             	incl   -0x4(%ebp)
  800a0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a12:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a15:	72 d9                	jb     8009f0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a17:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a1a:	c9                   	leave  
  800a1b:	c3                   	ret    

00800a1c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a1c:	55                   	push   %ebp
  800a1d:	89 e5                	mov    %esp,%ebp
  800a1f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a2c:	74 30                	je     800a5e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a2e:	eb 16                	jmp    800a46 <strlcpy+0x2a>
			*dst++ = *src++;
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	8d 50 01             	lea    0x1(%eax),%edx
  800a36:	89 55 08             	mov    %edx,0x8(%ebp)
  800a39:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a3f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a42:	8a 12                	mov    (%edx),%dl
  800a44:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a46:	ff 4d 10             	decl   0x10(%ebp)
  800a49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a4d:	74 09                	je     800a58 <strlcpy+0x3c>
  800a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a52:	8a 00                	mov    (%eax),%al
  800a54:	84 c0                	test   %al,%al
  800a56:	75 d8                	jne    800a30 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a5e:	8b 55 08             	mov    0x8(%ebp),%edx
  800a61:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a64:	29 c2                	sub    %eax,%edx
  800a66:	89 d0                	mov    %edx,%eax
}
  800a68:	c9                   	leave  
  800a69:	c3                   	ret    

00800a6a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a6a:	55                   	push   %ebp
  800a6b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a6d:	eb 06                	jmp    800a75 <strcmp+0xb>
		p++, q++;
  800a6f:	ff 45 08             	incl   0x8(%ebp)
  800a72:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	8a 00                	mov    (%eax),%al
  800a7a:	84 c0                	test   %al,%al
  800a7c:	74 0e                	je     800a8c <strcmp+0x22>
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	8a 10                	mov    (%eax),%dl
  800a83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	38 c2                	cmp    %al,%dl
  800a8a:	74 e3                	je     800a6f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	8a 00                	mov    (%eax),%al
  800a91:	0f b6 d0             	movzbl %al,%edx
  800a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	0f b6 c0             	movzbl %al,%eax
  800a9c:	29 c2                	sub    %eax,%edx
  800a9e:	89 d0                	mov    %edx,%eax
}
  800aa0:	5d                   	pop    %ebp
  800aa1:	c3                   	ret    

00800aa2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800aa2:	55                   	push   %ebp
  800aa3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800aa5:	eb 09                	jmp    800ab0 <strncmp+0xe>
		n--, p++, q++;
  800aa7:	ff 4d 10             	decl   0x10(%ebp)
  800aaa:	ff 45 08             	incl   0x8(%ebp)
  800aad:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ab0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab4:	74 17                	je     800acd <strncmp+0x2b>
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	84 c0                	test   %al,%al
  800abd:	74 0e                	je     800acd <strncmp+0x2b>
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	8a 10                	mov    (%eax),%dl
  800ac4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac7:	8a 00                	mov    (%eax),%al
  800ac9:	38 c2                	cmp    %al,%dl
  800acb:	74 da                	je     800aa7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800acd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ad1:	75 07                	jne    800ada <strncmp+0x38>
		return 0;
  800ad3:	b8 00 00 00 00       	mov    $0x0,%eax
  800ad8:	eb 14                	jmp    800aee <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8a 00                	mov    (%eax),%al
  800adf:	0f b6 d0             	movzbl %al,%edx
  800ae2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae5:	8a 00                	mov    (%eax),%al
  800ae7:	0f b6 c0             	movzbl %al,%eax
  800aea:	29 c2                	sub    %eax,%edx
  800aec:	89 d0                	mov    %edx,%eax
}
  800aee:	5d                   	pop    %ebp
  800aef:	c3                   	ret    

00800af0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800af0:	55                   	push   %ebp
  800af1:	89 e5                	mov    %esp,%ebp
  800af3:	83 ec 04             	sub    $0x4,%esp
  800af6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800afc:	eb 12                	jmp    800b10 <strchr+0x20>
		if (*s == c)
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8a 00                	mov    (%eax),%al
  800b03:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b06:	75 05                	jne    800b0d <strchr+0x1d>
			return (char *) s;
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	eb 11                	jmp    800b1e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b0d:	ff 45 08             	incl   0x8(%ebp)
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8a 00                	mov    (%eax),%al
  800b15:	84 c0                	test   %al,%al
  800b17:	75 e5                	jne    800afe <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b19:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b1e:	c9                   	leave  
  800b1f:	c3                   	ret    

00800b20 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b20:	55                   	push   %ebp
  800b21:	89 e5                	mov    %esp,%ebp
  800b23:	83 ec 04             	sub    $0x4,%esp
  800b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b29:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b2c:	eb 0d                	jmp    800b3b <strfind+0x1b>
		if (*s == c)
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8a 00                	mov    (%eax),%al
  800b33:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b36:	74 0e                	je     800b46 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b38:	ff 45 08             	incl   0x8(%ebp)
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	8a 00                	mov    (%eax),%al
  800b40:	84 c0                	test   %al,%al
  800b42:	75 ea                	jne    800b2e <strfind+0xe>
  800b44:	eb 01                	jmp    800b47 <strfind+0x27>
		if (*s == c)
			break;
  800b46:	90                   	nop
	return (char *) s;
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b4a:	c9                   	leave  
  800b4b:	c3                   	ret    

00800b4c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b4c:	55                   	push   %ebp
  800b4d:	89 e5                	mov    %esp,%ebp
  800b4f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b58:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b5e:	eb 0e                	jmp    800b6e <memset+0x22>
		*p++ = c;
  800b60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b63:	8d 50 01             	lea    0x1(%eax),%edx
  800b66:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b69:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b6c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b6e:	ff 4d f8             	decl   -0x8(%ebp)
  800b71:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b75:	79 e9                	jns    800b60 <memset+0x14>
		*p++ = c;

	return v;
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b7a:	c9                   	leave  
  800b7b:	c3                   	ret    

00800b7c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b7c:	55                   	push   %ebp
  800b7d:	89 e5                	mov    %esp,%ebp
  800b7f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b8e:	eb 16                	jmp    800ba6 <memcpy+0x2a>
		*d++ = *s++;
  800b90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b93:	8d 50 01             	lea    0x1(%eax),%edx
  800b96:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b9c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b9f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ba2:	8a 12                	mov    (%edx),%dl
  800ba4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ba6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bac:	89 55 10             	mov    %edx,0x10(%ebp)
  800baf:	85 c0                	test   %eax,%eax
  800bb1:	75 dd                	jne    800b90 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb6:	c9                   	leave  
  800bb7:	c3                   	ret    

00800bb8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bb8:	55                   	push   %ebp
  800bb9:	89 e5                	mov    %esp,%ebp
  800bbb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bcd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bd0:	73 50                	jae    800c22 <memmove+0x6a>
  800bd2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd8:	01 d0                	add    %edx,%eax
  800bda:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bdd:	76 43                	jbe    800c22 <memmove+0x6a>
		s += n;
  800bdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800be2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800be5:	8b 45 10             	mov    0x10(%ebp),%eax
  800be8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800beb:	eb 10                	jmp    800bfd <memmove+0x45>
			*--d = *--s;
  800bed:	ff 4d f8             	decl   -0x8(%ebp)
  800bf0:	ff 4d fc             	decl   -0x4(%ebp)
  800bf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf6:	8a 10                	mov    (%eax),%dl
  800bf8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bfb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800c00:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c03:	89 55 10             	mov    %edx,0x10(%ebp)
  800c06:	85 c0                	test   %eax,%eax
  800c08:	75 e3                	jne    800bed <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c0a:	eb 23                	jmp    800c2f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0f:	8d 50 01             	lea    0x1(%eax),%edx
  800c12:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c15:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c18:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c1b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c1e:	8a 12                	mov    (%edx),%dl
  800c20:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c22:	8b 45 10             	mov    0x10(%ebp),%eax
  800c25:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c28:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2b:	85 c0                	test   %eax,%eax
  800c2d:	75 dd                	jne    800c0c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c32:	c9                   	leave  
  800c33:	c3                   	ret    

00800c34 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c34:	55                   	push   %ebp
  800c35:	89 e5                	mov    %esp,%ebp
  800c37:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c43:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c46:	eb 2a                	jmp    800c72 <memcmp+0x3e>
		if (*s1 != *s2)
  800c48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4b:	8a 10                	mov    (%eax),%dl
  800c4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	38 c2                	cmp    %al,%dl
  800c54:	74 16                	je     800c6c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	0f b6 d0             	movzbl %al,%edx
  800c5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c61:	8a 00                	mov    (%eax),%al
  800c63:	0f b6 c0             	movzbl %al,%eax
  800c66:	29 c2                	sub    %eax,%edx
  800c68:	89 d0                	mov    %edx,%eax
  800c6a:	eb 18                	jmp    800c84 <memcmp+0x50>
		s1++, s2++;
  800c6c:	ff 45 fc             	incl   -0x4(%ebp)
  800c6f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c72:	8b 45 10             	mov    0x10(%ebp),%eax
  800c75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c78:	89 55 10             	mov    %edx,0x10(%ebp)
  800c7b:	85 c0                	test   %eax,%eax
  800c7d:	75 c9                	jne    800c48 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c84:	c9                   	leave  
  800c85:	c3                   	ret    

00800c86 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c86:	55                   	push   %ebp
  800c87:	89 e5                	mov    %esp,%ebp
  800c89:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c8c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c92:	01 d0                	add    %edx,%eax
  800c94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c97:	eb 15                	jmp    800cae <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	0f b6 d0             	movzbl %al,%edx
  800ca1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca4:	0f b6 c0             	movzbl %al,%eax
  800ca7:	39 c2                	cmp    %eax,%edx
  800ca9:	74 0d                	je     800cb8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cab:	ff 45 08             	incl   0x8(%ebp)
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cb4:	72 e3                	jb     800c99 <memfind+0x13>
  800cb6:	eb 01                	jmp    800cb9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cb8:	90                   	nop
	return (void *) s;
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cbc:	c9                   	leave  
  800cbd:	c3                   	ret    

00800cbe <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cbe:	55                   	push   %ebp
  800cbf:	89 e5                	mov    %esp,%ebp
  800cc1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ccb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cd2:	eb 03                	jmp    800cd7 <strtol+0x19>
		s++;
  800cd4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	3c 20                	cmp    $0x20,%al
  800cde:	74 f4                	je     800cd4 <strtol+0x16>
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	3c 09                	cmp    $0x9,%al
  800ce7:	74 eb                	je     800cd4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	3c 2b                	cmp    $0x2b,%al
  800cf0:	75 05                	jne    800cf7 <strtol+0x39>
		s++;
  800cf2:	ff 45 08             	incl   0x8(%ebp)
  800cf5:	eb 13                	jmp    800d0a <strtol+0x4c>
	else if (*s == '-')
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	3c 2d                	cmp    $0x2d,%al
  800cfe:	75 0a                	jne    800d0a <strtol+0x4c>
		s++, neg = 1;
  800d00:	ff 45 08             	incl   0x8(%ebp)
  800d03:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0e:	74 06                	je     800d16 <strtol+0x58>
  800d10:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d14:	75 20                	jne    800d36 <strtol+0x78>
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	3c 30                	cmp    $0x30,%al
  800d1d:	75 17                	jne    800d36 <strtol+0x78>
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	40                   	inc    %eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	3c 78                	cmp    $0x78,%al
  800d27:	75 0d                	jne    800d36 <strtol+0x78>
		s += 2, base = 16;
  800d29:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d2d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d34:	eb 28                	jmp    800d5e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3a:	75 15                	jne    800d51 <strtol+0x93>
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	3c 30                	cmp    $0x30,%al
  800d43:	75 0c                	jne    800d51 <strtol+0x93>
		s++, base = 8;
  800d45:	ff 45 08             	incl   0x8(%ebp)
  800d48:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d4f:	eb 0d                	jmp    800d5e <strtol+0xa0>
	else if (base == 0)
  800d51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d55:	75 07                	jne    800d5e <strtol+0xa0>
		base = 10;
  800d57:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	3c 2f                	cmp    $0x2f,%al
  800d65:	7e 19                	jle    800d80 <strtol+0xc2>
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	3c 39                	cmp    $0x39,%al
  800d6e:	7f 10                	jg     800d80 <strtol+0xc2>
			dig = *s - '0';
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	0f be c0             	movsbl %al,%eax
  800d78:	83 e8 30             	sub    $0x30,%eax
  800d7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d7e:	eb 42                	jmp    800dc2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	8a 00                	mov    (%eax),%al
  800d85:	3c 60                	cmp    $0x60,%al
  800d87:	7e 19                	jle    800da2 <strtol+0xe4>
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	3c 7a                	cmp    $0x7a,%al
  800d90:	7f 10                	jg     800da2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	0f be c0             	movsbl %al,%eax
  800d9a:	83 e8 57             	sub    $0x57,%eax
  800d9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800da0:	eb 20                	jmp    800dc2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	3c 40                	cmp    $0x40,%al
  800da9:	7e 39                	jle    800de4 <strtol+0x126>
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	8a 00                	mov    (%eax),%al
  800db0:	3c 5a                	cmp    $0x5a,%al
  800db2:	7f 30                	jg     800de4 <strtol+0x126>
			dig = *s - 'A' + 10;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8a 00                	mov    (%eax),%al
  800db9:	0f be c0             	movsbl %al,%eax
  800dbc:	83 e8 37             	sub    $0x37,%eax
  800dbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dc5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc8:	7d 19                	jge    800de3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dca:	ff 45 08             	incl   0x8(%ebp)
  800dcd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd0:	0f af 45 10          	imul   0x10(%ebp),%eax
  800dd4:	89 c2                	mov    %eax,%edx
  800dd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dd9:	01 d0                	add    %edx,%eax
  800ddb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dde:	e9 7b ff ff ff       	jmp    800d5e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800de3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800de4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800de8:	74 08                	je     800df2 <strtol+0x134>
		*endptr = (char *) s;
  800dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ded:	8b 55 08             	mov    0x8(%ebp),%edx
  800df0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800df2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800df6:	74 07                	je     800dff <strtol+0x141>
  800df8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfb:	f7 d8                	neg    %eax
  800dfd:	eb 03                	jmp    800e02 <strtol+0x144>
  800dff:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e02:	c9                   	leave  
  800e03:	c3                   	ret    

00800e04 <ltostr>:

void
ltostr(long value, char *str)
{
  800e04:	55                   	push   %ebp
  800e05:	89 e5                	mov    %esp,%ebp
  800e07:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e11:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e18:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e1c:	79 13                	jns    800e31 <ltostr+0x2d>
	{
		neg = 1;
  800e1e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e28:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e2b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e2e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e39:	99                   	cltd   
  800e3a:	f7 f9                	idiv   %ecx
  800e3c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e42:	8d 50 01             	lea    0x1(%eax),%edx
  800e45:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e48:	89 c2                	mov    %eax,%edx
  800e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4d:	01 d0                	add    %edx,%eax
  800e4f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e52:	83 c2 30             	add    $0x30,%edx
  800e55:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e57:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e5a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e5f:	f7 e9                	imul   %ecx
  800e61:	c1 fa 02             	sar    $0x2,%edx
  800e64:	89 c8                	mov    %ecx,%eax
  800e66:	c1 f8 1f             	sar    $0x1f,%eax
  800e69:	29 c2                	sub    %eax,%edx
  800e6b:	89 d0                	mov    %edx,%eax
  800e6d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e70:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e73:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e78:	f7 e9                	imul   %ecx
  800e7a:	c1 fa 02             	sar    $0x2,%edx
  800e7d:	89 c8                	mov    %ecx,%eax
  800e7f:	c1 f8 1f             	sar    $0x1f,%eax
  800e82:	29 c2                	sub    %eax,%edx
  800e84:	89 d0                	mov    %edx,%eax
  800e86:	c1 e0 02             	shl    $0x2,%eax
  800e89:	01 d0                	add    %edx,%eax
  800e8b:	01 c0                	add    %eax,%eax
  800e8d:	29 c1                	sub    %eax,%ecx
  800e8f:	89 ca                	mov    %ecx,%edx
  800e91:	85 d2                	test   %edx,%edx
  800e93:	75 9c                	jne    800e31 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9f:	48                   	dec    %eax
  800ea0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ea3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ea7:	74 3d                	je     800ee6 <ltostr+0xe2>
		start = 1 ;
  800ea9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800eb0:	eb 34                	jmp    800ee6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800eb2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb8:	01 d0                	add    %edx,%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800ebf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec5:	01 c2                	add    %eax,%edx
  800ec7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800eca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecd:	01 c8                	add    %ecx,%eax
  800ecf:	8a 00                	mov    (%eax),%al
  800ed1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ed3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed9:	01 c2                	add    %eax,%edx
  800edb:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ede:	88 02                	mov    %al,(%edx)
		start++ ;
  800ee0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ee3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ee9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eec:	7c c4                	jl     800eb2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800eee:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	01 d0                	add    %edx,%eax
  800ef6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ef9:	90                   	nop
  800efa:	c9                   	leave  
  800efb:	c3                   	ret    

00800efc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f02:	ff 75 08             	pushl  0x8(%ebp)
  800f05:	e8 54 fa ff ff       	call   80095e <strlen>
  800f0a:	83 c4 04             	add    $0x4,%esp
  800f0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f10:	ff 75 0c             	pushl  0xc(%ebp)
  800f13:	e8 46 fa ff ff       	call   80095e <strlen>
  800f18:	83 c4 04             	add    $0x4,%esp
  800f1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f1e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f2c:	eb 17                	jmp    800f45 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f31:	8b 45 10             	mov    0x10(%ebp),%eax
  800f34:	01 c2                	add    %eax,%edx
  800f36:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	01 c8                	add    %ecx,%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f42:	ff 45 fc             	incl   -0x4(%ebp)
  800f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f48:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f4b:	7c e1                	jl     800f2e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f4d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f54:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f5b:	eb 1f                	jmp    800f7c <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f60:	8d 50 01             	lea    0x1(%eax),%edx
  800f63:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f66:	89 c2                	mov    %eax,%edx
  800f68:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6b:	01 c2                	add    %eax,%edx
  800f6d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f73:	01 c8                	add    %ecx,%eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f79:	ff 45 f8             	incl   -0x8(%ebp)
  800f7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f82:	7c d9                	jl     800f5d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f87:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8a:	01 d0                	add    %edx,%eax
  800f8c:	c6 00 00             	movb   $0x0,(%eax)
}
  800f8f:	90                   	nop
  800f90:	c9                   	leave  
  800f91:	c3                   	ret    

00800f92 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f92:	55                   	push   %ebp
  800f93:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f95:	8b 45 14             	mov    0x14(%ebp),%eax
  800f98:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa1:	8b 00                	mov    (%eax),%eax
  800fa3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800faa:	8b 45 10             	mov    0x10(%ebp),%eax
  800fad:	01 d0                	add    %edx,%eax
  800faf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fb5:	eb 0c                	jmp    800fc3 <strsplit+0x31>
			*string++ = 0;
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8d 50 01             	lea    0x1(%eax),%edx
  800fbd:	89 55 08             	mov    %edx,0x8(%ebp)
  800fc0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	84 c0                	test   %al,%al
  800fca:	74 18                	je     800fe4 <strsplit+0x52>
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	0f be c0             	movsbl %al,%eax
  800fd4:	50                   	push   %eax
  800fd5:	ff 75 0c             	pushl  0xc(%ebp)
  800fd8:	e8 13 fb ff ff       	call   800af0 <strchr>
  800fdd:	83 c4 08             	add    $0x8,%esp
  800fe0:	85 c0                	test   %eax,%eax
  800fe2:	75 d3                	jne    800fb7 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	84 c0                	test   %al,%al
  800feb:	74 5a                	je     801047 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fed:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff0:	8b 00                	mov    (%eax),%eax
  800ff2:	83 f8 0f             	cmp    $0xf,%eax
  800ff5:	75 07                	jne    800ffe <strsplit+0x6c>
		{
			return 0;
  800ff7:	b8 00 00 00 00       	mov    $0x0,%eax
  800ffc:	eb 66                	jmp    801064 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800ffe:	8b 45 14             	mov    0x14(%ebp),%eax
  801001:	8b 00                	mov    (%eax),%eax
  801003:	8d 48 01             	lea    0x1(%eax),%ecx
  801006:	8b 55 14             	mov    0x14(%ebp),%edx
  801009:	89 0a                	mov    %ecx,(%edx)
  80100b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801012:	8b 45 10             	mov    0x10(%ebp),%eax
  801015:	01 c2                	add    %eax,%edx
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80101c:	eb 03                	jmp    801021 <strsplit+0x8f>
			string++;
  80101e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	84 c0                	test   %al,%al
  801028:	74 8b                	je     800fb5 <strsplit+0x23>
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	8a 00                	mov    (%eax),%al
  80102f:	0f be c0             	movsbl %al,%eax
  801032:	50                   	push   %eax
  801033:	ff 75 0c             	pushl  0xc(%ebp)
  801036:	e8 b5 fa ff ff       	call   800af0 <strchr>
  80103b:	83 c4 08             	add    $0x8,%esp
  80103e:	85 c0                	test   %eax,%eax
  801040:	74 dc                	je     80101e <strsplit+0x8c>
			string++;
	}
  801042:	e9 6e ff ff ff       	jmp    800fb5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801047:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801048:	8b 45 14             	mov    0x14(%ebp),%eax
  80104b:	8b 00                	mov    (%eax),%eax
  80104d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801054:	8b 45 10             	mov    0x10(%ebp),%eax
  801057:	01 d0                	add    %edx,%eax
  801059:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80105f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801064:	c9                   	leave  
  801065:	c3                   	ret    

00801066 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801066:	55                   	push   %ebp
  801067:	89 e5                	mov    %esp,%ebp
  801069:	57                   	push   %edi
  80106a:	56                   	push   %esi
  80106b:	53                   	push   %ebx
  80106c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80106f:	8b 45 08             	mov    0x8(%ebp),%eax
  801072:	8b 55 0c             	mov    0xc(%ebp),%edx
  801075:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801078:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80107b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80107e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801081:	cd 30                	int    $0x30
  801083:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801086:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801089:	83 c4 10             	add    $0x10,%esp
  80108c:	5b                   	pop    %ebx
  80108d:	5e                   	pop    %esi
  80108e:	5f                   	pop    %edi
  80108f:	5d                   	pop    %ebp
  801090:	c3                   	ret    

00801091 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
  801094:	83 ec 04             	sub    $0x4,%esp
  801097:	8b 45 10             	mov    0x10(%ebp),%eax
  80109a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80109d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 00                	push   $0x0
  8010a8:	52                   	push   %edx
  8010a9:	ff 75 0c             	pushl  0xc(%ebp)
  8010ac:	50                   	push   %eax
  8010ad:	6a 00                	push   $0x0
  8010af:	e8 b2 ff ff ff       	call   801066 <syscall>
  8010b4:	83 c4 18             	add    $0x18,%esp
}
  8010b7:	90                   	nop
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <sys_cgetc>:

int
sys_cgetc(void)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 00                	push   $0x0
  8010c7:	6a 01                	push   $0x1
  8010c9:	e8 98 ff ff ff       	call   801066 <syscall>
  8010ce:	83 c4 18             	add    $0x18,%esp
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 00                	push   $0x0
  8010e1:	50                   	push   %eax
  8010e2:	6a 05                	push   $0x5
  8010e4:	e8 7d ff ff ff       	call   801066 <syscall>
  8010e9:	83 c4 18             	add    $0x18,%esp
}
  8010ec:	c9                   	leave  
  8010ed:	c3                   	ret    

008010ee <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010ee:	55                   	push   %ebp
  8010ef:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 00                	push   $0x0
  8010f5:	6a 00                	push   $0x0
  8010f7:	6a 00                	push   $0x0
  8010f9:	6a 00                	push   $0x0
  8010fb:	6a 02                	push   $0x2
  8010fd:	e8 64 ff ff ff       	call   801066 <syscall>
  801102:	83 c4 18             	add    $0x18,%esp
}
  801105:	c9                   	leave  
  801106:	c3                   	ret    

00801107 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801107:	55                   	push   %ebp
  801108:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	6a 00                	push   $0x0
  801110:	6a 00                	push   $0x0
  801112:	6a 00                	push   $0x0
  801114:	6a 03                	push   $0x3
  801116:	e8 4b ff ff ff       	call   801066 <syscall>
  80111b:	83 c4 18             	add    $0x18,%esp
}
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801123:	6a 00                	push   $0x0
  801125:	6a 00                	push   $0x0
  801127:	6a 00                	push   $0x0
  801129:	6a 00                	push   $0x0
  80112b:	6a 00                	push   $0x0
  80112d:	6a 04                	push   $0x4
  80112f:	e8 32 ff ff ff       	call   801066 <syscall>
  801134:	83 c4 18             	add    $0x18,%esp
}
  801137:	c9                   	leave  
  801138:	c3                   	ret    

00801139 <sys_env_exit>:


void sys_env_exit(void)
{
  801139:	55                   	push   %ebp
  80113a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80113c:	6a 00                	push   $0x0
  80113e:	6a 00                	push   $0x0
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	6a 06                	push   $0x6
  801148:	e8 19 ff ff ff       	call   801066 <syscall>
  80114d:	83 c4 18             	add    $0x18,%esp
}
  801150:	90                   	nop
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801156:	8b 55 0c             	mov    0xc(%ebp),%edx
  801159:	8b 45 08             	mov    0x8(%ebp),%eax
  80115c:	6a 00                	push   $0x0
  80115e:	6a 00                	push   $0x0
  801160:	6a 00                	push   $0x0
  801162:	52                   	push   %edx
  801163:	50                   	push   %eax
  801164:	6a 07                	push   $0x7
  801166:	e8 fb fe ff ff       	call   801066 <syscall>
  80116b:	83 c4 18             	add    $0x18,%esp
}
  80116e:	c9                   	leave  
  80116f:	c3                   	ret    

00801170 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801170:	55                   	push   %ebp
  801171:	89 e5                	mov    %esp,%ebp
  801173:	56                   	push   %esi
  801174:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801175:	8b 75 18             	mov    0x18(%ebp),%esi
  801178:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80117b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80117e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	56                   	push   %esi
  801185:	53                   	push   %ebx
  801186:	51                   	push   %ecx
  801187:	52                   	push   %edx
  801188:	50                   	push   %eax
  801189:	6a 08                	push   $0x8
  80118b:	e8 d6 fe ff ff       	call   801066 <syscall>
  801190:	83 c4 18             	add    $0x18,%esp
}
  801193:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801196:	5b                   	pop    %ebx
  801197:	5e                   	pop    %esi
  801198:	5d                   	pop    %ebp
  801199:	c3                   	ret    

0080119a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80119a:	55                   	push   %ebp
  80119b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80119d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 00                	push   $0x0
  8011a9:	52                   	push   %edx
  8011aa:	50                   	push   %eax
  8011ab:	6a 09                	push   $0x9
  8011ad:	e8 b4 fe ff ff       	call   801066 <syscall>
  8011b2:	83 c4 18             	add    $0x18,%esp
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	ff 75 0c             	pushl  0xc(%ebp)
  8011c3:	ff 75 08             	pushl  0x8(%ebp)
  8011c6:	6a 0a                	push   $0xa
  8011c8:	e8 99 fe ff ff       	call   801066 <syscall>
  8011cd:	83 c4 18             	add    $0x18,%esp
}
  8011d0:	c9                   	leave  
  8011d1:	c3                   	ret    

008011d2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011d2:	55                   	push   %ebp
  8011d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 0b                	push   $0xb
  8011e1:	e8 80 fe ff ff       	call   801066 <syscall>
  8011e6:	83 c4 18             	add    $0x18,%esp
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 0c                	push   $0xc
  8011fa:	e8 67 fe ff ff       	call   801066 <syscall>
  8011ff:	83 c4 18             	add    $0x18,%esp
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801207:	6a 00                	push   $0x0
  801209:	6a 00                	push   $0x0
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	6a 0d                	push   $0xd
  801213:	e8 4e fe ff ff       	call   801066 <syscall>
  801218:	83 c4 18             	add    $0x18,%esp
}
  80121b:	c9                   	leave  
  80121c:	c3                   	ret    

0080121d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80121d:	55                   	push   %ebp
  80121e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	6a 00                	push   $0x0
  801226:	ff 75 0c             	pushl  0xc(%ebp)
  801229:	ff 75 08             	pushl  0x8(%ebp)
  80122c:	6a 11                	push   $0x11
  80122e:	e8 33 fe ff ff       	call   801066 <syscall>
  801233:	83 c4 18             	add    $0x18,%esp
	return;
  801236:	90                   	nop
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	ff 75 0c             	pushl  0xc(%ebp)
  801245:	ff 75 08             	pushl  0x8(%ebp)
  801248:	6a 12                	push   $0x12
  80124a:	e8 17 fe ff ff       	call   801066 <syscall>
  80124f:	83 c4 18             	add    $0x18,%esp
	return ;
  801252:	90                   	nop
}
  801253:	c9                   	leave  
  801254:	c3                   	ret    

00801255 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801255:	55                   	push   %ebp
  801256:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 0e                	push   $0xe
  801264:	e8 fd fd ff ff       	call   801066 <syscall>
  801269:	83 c4 18             	add    $0x18,%esp
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	ff 75 08             	pushl  0x8(%ebp)
  80127c:	6a 0f                	push   $0xf
  80127e:	e8 e3 fd ff ff       	call   801066 <syscall>
  801283:	83 c4 18             	add    $0x18,%esp
}
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 10                	push   $0x10
  801297:	e8 ca fd ff ff       	call   801066 <syscall>
  80129c:	83 c4 18             	add    $0x18,%esp
}
  80129f:	90                   	nop
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 14                	push   $0x14
  8012b1:	e8 b0 fd ff ff       	call   801066 <syscall>
  8012b6:	83 c4 18             	add    $0x18,%esp
}
  8012b9:	90                   	nop
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 15                	push   $0x15
  8012cb:	e8 96 fd ff ff       	call   801066 <syscall>
  8012d0:	83 c4 18             	add    $0x18,%esp
}
  8012d3:	90                   	nop
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
  8012d9:	83 ec 04             	sub    $0x4,%esp
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012e2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	50                   	push   %eax
  8012ef:	6a 16                	push   $0x16
  8012f1:	e8 70 fd ff ff       	call   801066 <syscall>
  8012f6:	83 c4 18             	add    $0x18,%esp
}
  8012f9:	90                   	nop
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 17                	push   $0x17
  80130b:	e8 56 fd ff ff       	call   801066 <syscall>
  801310:	83 c4 18             	add    $0x18,%esp
}
  801313:	90                   	nop
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	ff 75 0c             	pushl  0xc(%ebp)
  801325:	50                   	push   %eax
  801326:	6a 18                	push   $0x18
  801328:	e8 39 fd ff ff       	call   801066 <syscall>
  80132d:	83 c4 18             	add    $0x18,%esp
}
  801330:	c9                   	leave  
  801331:	c3                   	ret    

00801332 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801332:	55                   	push   %ebp
  801333:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801335:	8b 55 0c             	mov    0xc(%ebp),%edx
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	52                   	push   %edx
  801342:	50                   	push   %eax
  801343:	6a 1b                	push   $0x1b
  801345:	e8 1c fd ff ff       	call   801066 <syscall>
  80134a:	83 c4 18             	add    $0x18,%esp
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801352:	8b 55 0c             	mov    0xc(%ebp),%edx
  801355:	8b 45 08             	mov    0x8(%ebp),%eax
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	52                   	push   %edx
  80135f:	50                   	push   %eax
  801360:	6a 19                	push   $0x19
  801362:	e8 ff fc ff ff       	call   801066 <syscall>
  801367:	83 c4 18             	add    $0x18,%esp
}
  80136a:	90                   	nop
  80136b:	c9                   	leave  
  80136c:	c3                   	ret    

0080136d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80136d:	55                   	push   %ebp
  80136e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801370:	8b 55 0c             	mov    0xc(%ebp),%edx
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	52                   	push   %edx
  80137d:	50                   	push   %eax
  80137e:	6a 1a                	push   $0x1a
  801380:	e8 e1 fc ff ff       	call   801066 <syscall>
  801385:	83 c4 18             	add    $0x18,%esp
}
  801388:	90                   	nop
  801389:	c9                   	leave  
  80138a:	c3                   	ret    

0080138b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
  80138e:	83 ec 04             	sub    $0x4,%esp
  801391:	8b 45 10             	mov    0x10(%ebp),%eax
  801394:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801397:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80139a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	6a 00                	push   $0x0
  8013a3:	51                   	push   %ecx
  8013a4:	52                   	push   %edx
  8013a5:	ff 75 0c             	pushl  0xc(%ebp)
  8013a8:	50                   	push   %eax
  8013a9:	6a 1c                	push   $0x1c
  8013ab:	e8 b6 fc ff ff       	call   801066 <syscall>
  8013b0:	83 c4 18             	add    $0x18,%esp
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	52                   	push   %edx
  8013c5:	50                   	push   %eax
  8013c6:	6a 1d                	push   $0x1d
  8013c8:	e8 99 fc ff ff       	call   801066 <syscall>
  8013cd:	83 c4 18             	add    $0x18,%esp
}
  8013d0:	c9                   	leave  
  8013d1:	c3                   	ret    

008013d2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013d2:	55                   	push   %ebp
  8013d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	51                   	push   %ecx
  8013e3:	52                   	push   %edx
  8013e4:	50                   	push   %eax
  8013e5:	6a 1e                	push   $0x1e
  8013e7:	e8 7a fc ff ff       	call   801066 <syscall>
  8013ec:	83 c4 18             	add    $0x18,%esp
}
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	52                   	push   %edx
  801401:	50                   	push   %eax
  801402:	6a 1f                	push   $0x1f
  801404:	e8 5d fc ff ff       	call   801066 <syscall>
  801409:	83 c4 18             	add    $0x18,%esp
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 20                	push   $0x20
  80141d:	e8 44 fc ff ff       	call   801066 <syscall>
  801422:	83 c4 18             	add    $0x18,%esp
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	6a 00                	push   $0x0
  80142f:	ff 75 14             	pushl  0x14(%ebp)
  801432:	ff 75 10             	pushl  0x10(%ebp)
  801435:	ff 75 0c             	pushl  0xc(%ebp)
  801438:	50                   	push   %eax
  801439:	6a 21                	push   $0x21
  80143b:	e8 26 fc ff ff       	call   801066 <syscall>
  801440:	83 c4 18             	add    $0x18,%esp
}
  801443:	c9                   	leave  
  801444:	c3                   	ret    

00801445 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801445:	55                   	push   %ebp
  801446:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	50                   	push   %eax
  801454:	6a 22                	push   $0x22
  801456:	e8 0b fc ff ff       	call   801066 <syscall>
  80145b:	83 c4 18             	add    $0x18,%esp
}
  80145e:	90                   	nop
  80145f:	c9                   	leave  
  801460:	c3                   	ret    

00801461 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	50                   	push   %eax
  801470:	6a 23                	push   $0x23
  801472:	e8 ef fb ff ff       	call   801066 <syscall>
  801477:	83 c4 18             	add    $0x18,%esp
}
  80147a:	90                   	nop
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
  801480:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801483:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801486:	8d 50 04             	lea    0x4(%eax),%edx
  801489:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	52                   	push   %edx
  801493:	50                   	push   %eax
  801494:	6a 24                	push   $0x24
  801496:	e8 cb fb ff ff       	call   801066 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
	return result;
  80149e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a7:	89 01                	mov    %eax,(%ecx)
  8014a9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	c9                   	leave  
  8014b0:	c2 04 00             	ret    $0x4

008014b3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	ff 75 10             	pushl  0x10(%ebp)
  8014bd:	ff 75 0c             	pushl  0xc(%ebp)
  8014c0:	ff 75 08             	pushl  0x8(%ebp)
  8014c3:	6a 13                	push   $0x13
  8014c5:	e8 9c fb ff ff       	call   801066 <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8014cd:	90                   	nop
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 25                	push   $0x25
  8014df:	e8 82 fb ff ff       	call   801066 <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 04             	sub    $0x4,%esp
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014f5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	50                   	push   %eax
  801502:	6a 26                	push   $0x26
  801504:	e8 5d fb ff ff       	call   801066 <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
	return ;
  80150c:	90                   	nop
}
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <rsttst>:
void rsttst()
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 28                	push   $0x28
  80151e:	e8 43 fb ff ff       	call   801066 <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
	return ;
  801526:	90                   	nop
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 04             	sub    $0x4,%esp
  80152f:	8b 45 14             	mov    0x14(%ebp),%eax
  801532:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801535:	8b 55 18             	mov    0x18(%ebp),%edx
  801538:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80153c:	52                   	push   %edx
  80153d:	50                   	push   %eax
  80153e:	ff 75 10             	pushl  0x10(%ebp)
  801541:	ff 75 0c             	pushl  0xc(%ebp)
  801544:	ff 75 08             	pushl  0x8(%ebp)
  801547:	6a 27                	push   $0x27
  801549:	e8 18 fb ff ff       	call   801066 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
	return ;
  801551:	90                   	nop
}
  801552:	c9                   	leave  
  801553:	c3                   	ret    

00801554 <chktst>:
void chktst(uint32 n)
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	ff 75 08             	pushl  0x8(%ebp)
  801562:	6a 29                	push   $0x29
  801564:	e8 fd fa ff ff       	call   801066 <syscall>
  801569:	83 c4 18             	add    $0x18,%esp
	return ;
  80156c:	90                   	nop
}
  80156d:	c9                   	leave  
  80156e:	c3                   	ret    

0080156f <inctst>:

void inctst()
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 2a                	push   $0x2a
  80157e:	e8 e3 fa ff ff       	call   801066 <syscall>
  801583:	83 c4 18             	add    $0x18,%esp
	return ;
  801586:	90                   	nop
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <gettst>:
uint32 gettst()
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 2b                	push   $0x2b
  801598:	e8 c9 fa ff ff       	call   801066 <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
}
  8015a0:	c9                   	leave  
  8015a1:	c3                   	ret    

008015a2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015a2:	55                   	push   %ebp
  8015a3:	89 e5                	mov    %esp,%ebp
  8015a5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 2c                	push   $0x2c
  8015b4:	e8 ad fa ff ff       	call   801066 <syscall>
  8015b9:	83 c4 18             	add    $0x18,%esp
  8015bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015bf:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015c3:	75 07                	jne    8015cc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ca:	eb 05                	jmp    8015d1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
  8015d6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 2c                	push   $0x2c
  8015e5:	e8 7c fa ff ff       	call   801066 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
  8015ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015f0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015f4:	75 07                	jne    8015fd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8015fb:	eb 05                	jmp    801602 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801602:	c9                   	leave  
  801603:	c3                   	ret    

00801604 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801604:	55                   	push   %ebp
  801605:	89 e5                	mov    %esp,%ebp
  801607:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 2c                	push   $0x2c
  801616:	e8 4b fa ff ff       	call   801066 <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
  80161e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801621:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801625:	75 07                	jne    80162e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801627:	b8 01 00 00 00       	mov    $0x1,%eax
  80162c:	eb 05                	jmp    801633 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80162e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801633:	c9                   	leave  
  801634:	c3                   	ret    

00801635 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801635:	55                   	push   %ebp
  801636:	89 e5                	mov    %esp,%ebp
  801638:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 2c                	push   $0x2c
  801647:	e8 1a fa ff ff       	call   801066 <syscall>
  80164c:	83 c4 18             	add    $0x18,%esp
  80164f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801652:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801656:	75 07                	jne    80165f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801658:	b8 01 00 00 00       	mov    $0x1,%eax
  80165d:	eb 05                	jmp    801664 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80165f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	ff 75 08             	pushl  0x8(%ebp)
  801674:	6a 2d                	push   $0x2d
  801676:	e8 eb f9 ff ff       	call   801066 <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
	return ;
  80167e:	90                   	nop
}
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
  801684:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801685:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801688:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80168b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	6a 00                	push   $0x0
  801693:	53                   	push   %ebx
  801694:	51                   	push   %ecx
  801695:	52                   	push   %edx
  801696:	50                   	push   %eax
  801697:	6a 2e                	push   $0x2e
  801699:	e8 c8 f9 ff ff       	call   801066 <syscall>
  80169e:	83 c4 18             	add    $0x18,%esp
}
  8016a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8016a4:	c9                   	leave  
  8016a5:	c3                   	ret    

008016a6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8016a6:	55                   	push   %ebp
  8016a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8016a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	52                   	push   %edx
  8016b6:	50                   	push   %eax
  8016b7:	6a 2f                	push   $0x2f
  8016b9:	e8 a8 f9 ff ff       	call   801066 <syscall>
  8016be:	83 c4 18             	add    $0x18,%esp
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    
  8016c3:	90                   	nop

008016c4 <__udivdi3>:
  8016c4:	55                   	push   %ebp
  8016c5:	57                   	push   %edi
  8016c6:	56                   	push   %esi
  8016c7:	53                   	push   %ebx
  8016c8:	83 ec 1c             	sub    $0x1c,%esp
  8016cb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016cf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016d7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016db:	89 ca                	mov    %ecx,%edx
  8016dd:	89 f8                	mov    %edi,%eax
  8016df:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016e3:	85 f6                	test   %esi,%esi
  8016e5:	75 2d                	jne    801714 <__udivdi3+0x50>
  8016e7:	39 cf                	cmp    %ecx,%edi
  8016e9:	77 65                	ja     801750 <__udivdi3+0x8c>
  8016eb:	89 fd                	mov    %edi,%ebp
  8016ed:	85 ff                	test   %edi,%edi
  8016ef:	75 0b                	jne    8016fc <__udivdi3+0x38>
  8016f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8016f6:	31 d2                	xor    %edx,%edx
  8016f8:	f7 f7                	div    %edi
  8016fa:	89 c5                	mov    %eax,%ebp
  8016fc:	31 d2                	xor    %edx,%edx
  8016fe:	89 c8                	mov    %ecx,%eax
  801700:	f7 f5                	div    %ebp
  801702:	89 c1                	mov    %eax,%ecx
  801704:	89 d8                	mov    %ebx,%eax
  801706:	f7 f5                	div    %ebp
  801708:	89 cf                	mov    %ecx,%edi
  80170a:	89 fa                	mov    %edi,%edx
  80170c:	83 c4 1c             	add    $0x1c,%esp
  80170f:	5b                   	pop    %ebx
  801710:	5e                   	pop    %esi
  801711:	5f                   	pop    %edi
  801712:	5d                   	pop    %ebp
  801713:	c3                   	ret    
  801714:	39 ce                	cmp    %ecx,%esi
  801716:	77 28                	ja     801740 <__udivdi3+0x7c>
  801718:	0f bd fe             	bsr    %esi,%edi
  80171b:	83 f7 1f             	xor    $0x1f,%edi
  80171e:	75 40                	jne    801760 <__udivdi3+0x9c>
  801720:	39 ce                	cmp    %ecx,%esi
  801722:	72 0a                	jb     80172e <__udivdi3+0x6a>
  801724:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801728:	0f 87 9e 00 00 00    	ja     8017cc <__udivdi3+0x108>
  80172e:	b8 01 00 00 00       	mov    $0x1,%eax
  801733:	89 fa                	mov    %edi,%edx
  801735:	83 c4 1c             	add    $0x1c,%esp
  801738:	5b                   	pop    %ebx
  801739:	5e                   	pop    %esi
  80173a:	5f                   	pop    %edi
  80173b:	5d                   	pop    %ebp
  80173c:	c3                   	ret    
  80173d:	8d 76 00             	lea    0x0(%esi),%esi
  801740:	31 ff                	xor    %edi,%edi
  801742:	31 c0                	xor    %eax,%eax
  801744:	89 fa                	mov    %edi,%edx
  801746:	83 c4 1c             	add    $0x1c,%esp
  801749:	5b                   	pop    %ebx
  80174a:	5e                   	pop    %esi
  80174b:	5f                   	pop    %edi
  80174c:	5d                   	pop    %ebp
  80174d:	c3                   	ret    
  80174e:	66 90                	xchg   %ax,%ax
  801750:	89 d8                	mov    %ebx,%eax
  801752:	f7 f7                	div    %edi
  801754:	31 ff                	xor    %edi,%edi
  801756:	89 fa                	mov    %edi,%edx
  801758:	83 c4 1c             	add    $0x1c,%esp
  80175b:	5b                   	pop    %ebx
  80175c:	5e                   	pop    %esi
  80175d:	5f                   	pop    %edi
  80175e:	5d                   	pop    %ebp
  80175f:	c3                   	ret    
  801760:	bd 20 00 00 00       	mov    $0x20,%ebp
  801765:	89 eb                	mov    %ebp,%ebx
  801767:	29 fb                	sub    %edi,%ebx
  801769:	89 f9                	mov    %edi,%ecx
  80176b:	d3 e6                	shl    %cl,%esi
  80176d:	89 c5                	mov    %eax,%ebp
  80176f:	88 d9                	mov    %bl,%cl
  801771:	d3 ed                	shr    %cl,%ebp
  801773:	89 e9                	mov    %ebp,%ecx
  801775:	09 f1                	or     %esi,%ecx
  801777:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80177b:	89 f9                	mov    %edi,%ecx
  80177d:	d3 e0                	shl    %cl,%eax
  80177f:	89 c5                	mov    %eax,%ebp
  801781:	89 d6                	mov    %edx,%esi
  801783:	88 d9                	mov    %bl,%cl
  801785:	d3 ee                	shr    %cl,%esi
  801787:	89 f9                	mov    %edi,%ecx
  801789:	d3 e2                	shl    %cl,%edx
  80178b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80178f:	88 d9                	mov    %bl,%cl
  801791:	d3 e8                	shr    %cl,%eax
  801793:	09 c2                	or     %eax,%edx
  801795:	89 d0                	mov    %edx,%eax
  801797:	89 f2                	mov    %esi,%edx
  801799:	f7 74 24 0c          	divl   0xc(%esp)
  80179d:	89 d6                	mov    %edx,%esi
  80179f:	89 c3                	mov    %eax,%ebx
  8017a1:	f7 e5                	mul    %ebp
  8017a3:	39 d6                	cmp    %edx,%esi
  8017a5:	72 19                	jb     8017c0 <__udivdi3+0xfc>
  8017a7:	74 0b                	je     8017b4 <__udivdi3+0xf0>
  8017a9:	89 d8                	mov    %ebx,%eax
  8017ab:	31 ff                	xor    %edi,%edi
  8017ad:	e9 58 ff ff ff       	jmp    80170a <__udivdi3+0x46>
  8017b2:	66 90                	xchg   %ax,%ax
  8017b4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017b8:	89 f9                	mov    %edi,%ecx
  8017ba:	d3 e2                	shl    %cl,%edx
  8017bc:	39 c2                	cmp    %eax,%edx
  8017be:	73 e9                	jae    8017a9 <__udivdi3+0xe5>
  8017c0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017c3:	31 ff                	xor    %edi,%edi
  8017c5:	e9 40 ff ff ff       	jmp    80170a <__udivdi3+0x46>
  8017ca:	66 90                	xchg   %ax,%ax
  8017cc:	31 c0                	xor    %eax,%eax
  8017ce:	e9 37 ff ff ff       	jmp    80170a <__udivdi3+0x46>
  8017d3:	90                   	nop

008017d4 <__umoddi3>:
  8017d4:	55                   	push   %ebp
  8017d5:	57                   	push   %edi
  8017d6:	56                   	push   %esi
  8017d7:	53                   	push   %ebx
  8017d8:	83 ec 1c             	sub    $0x1c,%esp
  8017db:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017df:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017e7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017ef:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017f3:	89 f3                	mov    %esi,%ebx
  8017f5:	89 fa                	mov    %edi,%edx
  8017f7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017fb:	89 34 24             	mov    %esi,(%esp)
  8017fe:	85 c0                	test   %eax,%eax
  801800:	75 1a                	jne    80181c <__umoddi3+0x48>
  801802:	39 f7                	cmp    %esi,%edi
  801804:	0f 86 a2 00 00 00    	jbe    8018ac <__umoddi3+0xd8>
  80180a:	89 c8                	mov    %ecx,%eax
  80180c:	89 f2                	mov    %esi,%edx
  80180e:	f7 f7                	div    %edi
  801810:	89 d0                	mov    %edx,%eax
  801812:	31 d2                	xor    %edx,%edx
  801814:	83 c4 1c             	add    $0x1c,%esp
  801817:	5b                   	pop    %ebx
  801818:	5e                   	pop    %esi
  801819:	5f                   	pop    %edi
  80181a:	5d                   	pop    %ebp
  80181b:	c3                   	ret    
  80181c:	39 f0                	cmp    %esi,%eax
  80181e:	0f 87 ac 00 00 00    	ja     8018d0 <__umoddi3+0xfc>
  801824:	0f bd e8             	bsr    %eax,%ebp
  801827:	83 f5 1f             	xor    $0x1f,%ebp
  80182a:	0f 84 ac 00 00 00    	je     8018dc <__umoddi3+0x108>
  801830:	bf 20 00 00 00       	mov    $0x20,%edi
  801835:	29 ef                	sub    %ebp,%edi
  801837:	89 fe                	mov    %edi,%esi
  801839:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80183d:	89 e9                	mov    %ebp,%ecx
  80183f:	d3 e0                	shl    %cl,%eax
  801841:	89 d7                	mov    %edx,%edi
  801843:	89 f1                	mov    %esi,%ecx
  801845:	d3 ef                	shr    %cl,%edi
  801847:	09 c7                	or     %eax,%edi
  801849:	89 e9                	mov    %ebp,%ecx
  80184b:	d3 e2                	shl    %cl,%edx
  80184d:	89 14 24             	mov    %edx,(%esp)
  801850:	89 d8                	mov    %ebx,%eax
  801852:	d3 e0                	shl    %cl,%eax
  801854:	89 c2                	mov    %eax,%edx
  801856:	8b 44 24 08          	mov    0x8(%esp),%eax
  80185a:	d3 e0                	shl    %cl,%eax
  80185c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801860:	8b 44 24 08          	mov    0x8(%esp),%eax
  801864:	89 f1                	mov    %esi,%ecx
  801866:	d3 e8                	shr    %cl,%eax
  801868:	09 d0                	or     %edx,%eax
  80186a:	d3 eb                	shr    %cl,%ebx
  80186c:	89 da                	mov    %ebx,%edx
  80186e:	f7 f7                	div    %edi
  801870:	89 d3                	mov    %edx,%ebx
  801872:	f7 24 24             	mull   (%esp)
  801875:	89 c6                	mov    %eax,%esi
  801877:	89 d1                	mov    %edx,%ecx
  801879:	39 d3                	cmp    %edx,%ebx
  80187b:	0f 82 87 00 00 00    	jb     801908 <__umoddi3+0x134>
  801881:	0f 84 91 00 00 00    	je     801918 <__umoddi3+0x144>
  801887:	8b 54 24 04          	mov    0x4(%esp),%edx
  80188b:	29 f2                	sub    %esi,%edx
  80188d:	19 cb                	sbb    %ecx,%ebx
  80188f:	89 d8                	mov    %ebx,%eax
  801891:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801895:	d3 e0                	shl    %cl,%eax
  801897:	89 e9                	mov    %ebp,%ecx
  801899:	d3 ea                	shr    %cl,%edx
  80189b:	09 d0                	or     %edx,%eax
  80189d:	89 e9                	mov    %ebp,%ecx
  80189f:	d3 eb                	shr    %cl,%ebx
  8018a1:	89 da                	mov    %ebx,%edx
  8018a3:	83 c4 1c             	add    $0x1c,%esp
  8018a6:	5b                   	pop    %ebx
  8018a7:	5e                   	pop    %esi
  8018a8:	5f                   	pop    %edi
  8018a9:	5d                   	pop    %ebp
  8018aa:	c3                   	ret    
  8018ab:	90                   	nop
  8018ac:	89 fd                	mov    %edi,%ebp
  8018ae:	85 ff                	test   %edi,%edi
  8018b0:	75 0b                	jne    8018bd <__umoddi3+0xe9>
  8018b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b7:	31 d2                	xor    %edx,%edx
  8018b9:	f7 f7                	div    %edi
  8018bb:	89 c5                	mov    %eax,%ebp
  8018bd:	89 f0                	mov    %esi,%eax
  8018bf:	31 d2                	xor    %edx,%edx
  8018c1:	f7 f5                	div    %ebp
  8018c3:	89 c8                	mov    %ecx,%eax
  8018c5:	f7 f5                	div    %ebp
  8018c7:	89 d0                	mov    %edx,%eax
  8018c9:	e9 44 ff ff ff       	jmp    801812 <__umoddi3+0x3e>
  8018ce:	66 90                	xchg   %ax,%ax
  8018d0:	89 c8                	mov    %ecx,%eax
  8018d2:	89 f2                	mov    %esi,%edx
  8018d4:	83 c4 1c             	add    $0x1c,%esp
  8018d7:	5b                   	pop    %ebx
  8018d8:	5e                   	pop    %esi
  8018d9:	5f                   	pop    %edi
  8018da:	5d                   	pop    %ebp
  8018db:	c3                   	ret    
  8018dc:	3b 04 24             	cmp    (%esp),%eax
  8018df:	72 06                	jb     8018e7 <__umoddi3+0x113>
  8018e1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018e5:	77 0f                	ja     8018f6 <__umoddi3+0x122>
  8018e7:	89 f2                	mov    %esi,%edx
  8018e9:	29 f9                	sub    %edi,%ecx
  8018eb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018ef:	89 14 24             	mov    %edx,(%esp)
  8018f2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018f6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018fa:	8b 14 24             	mov    (%esp),%edx
  8018fd:	83 c4 1c             	add    $0x1c,%esp
  801900:	5b                   	pop    %ebx
  801901:	5e                   	pop    %esi
  801902:	5f                   	pop    %edi
  801903:	5d                   	pop    %ebp
  801904:	c3                   	ret    
  801905:	8d 76 00             	lea    0x0(%esi),%esi
  801908:	2b 04 24             	sub    (%esp),%eax
  80190b:	19 fa                	sbb    %edi,%edx
  80190d:	89 d1                	mov    %edx,%ecx
  80190f:	89 c6                	mov    %eax,%esi
  801911:	e9 71 ff ff ff       	jmp    801887 <__umoddi3+0xb3>
  801916:	66 90                	xchg   %ax,%ax
  801918:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80191c:	72 ea                	jb     801908 <__umoddi3+0x134>
  80191e:	89 d9                	mov    %ebx,%ecx
  801920:	e9 62 ff ff ff       	jmp    801887 <__umoddi3+0xb3>
