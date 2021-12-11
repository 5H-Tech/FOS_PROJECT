
obj/user/test_trim1_b:     file format elf32-i386


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
  800031:	e8 0e 01 00 00       	call   800144 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int first = 1;
uint32 ws_size_first=0;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	if(first == 1)
  80003e:	a1 00 20 80 00       	mov    0x802000,%eax
  800043:	83 f8 01             	cmp    $0x1,%eax
  800046:	75 7c                	jne    8000c4 <_main+0x8c>
	{
		first = 0;
  800048:	c7 05 00 20 80 00 00 	movl   $0x0,0x802000
  80004f:	00 00 00 

		int envID = sys_getenvid();
  800052:	e8 18 11 00 00       	call   80116f <sys_getenvid>
  800057:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("envID = %d\n",envID);
  80005a:	83 ec 08             	sub    $0x8,%esp
  80005d:	ff 75 e8             	pushl  -0x18(%ebp)
  800060:	68 c0 19 80 00       	push   $0x8019c0
  800065:	e8 f3 02 00 00       	call   80035d <cprintf>
  80006a:	83 c4 10             	add    $0x10,%esp


		uint32 i=0;
  80006d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		}
		cprintf("\n");
		}
		*/

		cprintf("testing trim: hello from B\n");
  800074:	83 ec 0c             	sub    $0xc,%esp
  800077:	68 cc 19 80 00       	push   $0x8019cc
  80007c:	e8 dc 02 00 00       	call   80035d <cprintf>
  800081:	83 c4 10             	add    $0x10,%esp
		i=0;
  800084:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(; i< (myEnv->page_WS_max_size); i++)
  80008b:	eb 28                	jmp    8000b5 <_main+0x7d>
		{
			if(myEnv->__uptr_pws[i].empty == 0)
  80008d:	a1 24 20 80 00       	mov    0x802024,%eax
  800092:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800098:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009b:	c1 e2 04             	shl    $0x4,%edx
  80009e:	01 d0                	add    %edx,%eax
  8000a0:	8a 40 04             	mov    0x4(%eax),%al
  8000a3:	84 c0                	test   %al,%al
  8000a5:	75 0b                	jne    8000b2 <_main+0x7a>
			{
				ws_size_first++;
  8000a7:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ac:	40                   	inc    %eax
  8000ad:	a3 20 20 80 00       	mov    %eax,0x802020
		}
		*/

		cprintf("testing trim: hello from B\n");
		i=0;
		for(; i< (myEnv->page_WS_max_size); i++)
  8000b2:	ff 45 f4             	incl   -0xc(%ebp)
  8000b5:	a1 24 20 80 00       	mov    0x802024,%eax
  8000ba:	8b 40 74             	mov    0x74(%eax),%eax
  8000bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000c0:	77 cb                	ja     80008d <_main+0x55>
		uint32 reduced_frames = ws_size_first-ws_size;
		//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 B: WS size after trimming is reduced by %d frames\n", reduced_frames);
	}
}
  8000c2:	eb 7d                	jmp    800141 <_main+0x109>
		}
		//cprintf("ws_size_first = %d\n",ws_size_first);
	}
	else
	{
		int envID = sys_getenvid();
  8000c4:	e8 a6 10 00 00       	call   80116f <sys_getenvid>
  8000c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("envID = %d\n",envID);
  8000cc:	83 ec 08             	sub    $0x8,%esp
  8000cf:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000d2:	68 c0 19 80 00       	push   $0x8019c0
  8000d7:	e8 81 02 00 00       	call   80035d <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp

		uint32 i=0;
  8000df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		}
		cprintf("\n");
		}
		*/

		i=0;
  8000e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		uint32 ws_size=0;
  8000ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(; i< (myEnv->page_WS_max_size); i++)
  8000f4:	eb 20                	jmp    800116 <_main+0xde>
		{
			if(myEnv->__uptr_pws[i].empty == 0)
  8000f6:	a1 24 20 80 00       	mov    0x802024,%eax
  8000fb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800101:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800104:	c1 e2 04             	shl    $0x4,%edx
  800107:	01 d0                	add    %edx,%eax
  800109:	8a 40 04             	mov    0x4(%eax),%al
  80010c:	84 c0                	test   %al,%al
  80010e:	75 03                	jne    800113 <_main+0xdb>
			{
				ws_size++;
  800110:	ff 45 ec             	incl   -0x14(%ebp)
		}
		*/

		i=0;
		uint32 ws_size=0;
		for(; i< (myEnv->page_WS_max_size); i++)
  800113:	ff 45 f0             	incl   -0x10(%ebp)
  800116:	a1 24 20 80 00       	mov    0x802024,%eax
  80011b:	8b 40 74             	mov    0x74(%eax),%eax
  80011e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800121:	77 d3                	ja     8000f6 <_main+0xbe>
			{
				ws_size++;
			}
		}

		uint32 reduced_frames = ws_size_first-ws_size;
  800123:	a1 20 20 80 00       	mov    0x802020,%eax
  800128:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80012b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 B: WS size after trimming is reduced by %d frames\n", reduced_frames);
  80012e:	83 ec 08             	sub    $0x8,%esp
  800131:	ff 75 e0             	pushl  -0x20(%ebp)
  800134:	68 e8 19 80 00       	push   $0x8019e8
  800139:	e8 1f 02 00 00       	call   80035d <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
	}
}
  800141:	90                   	nop
  800142:	c9                   	leave  
  800143:	c3                   	ret    

00800144 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800144:	55                   	push   %ebp
  800145:	89 e5                	mov    %esp,%ebp
  800147:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80014a:	e8 39 10 00 00       	call   801188 <sys_getenvindex>
  80014f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800152:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800155:	89 d0                	mov    %edx,%eax
  800157:	c1 e0 03             	shl    $0x3,%eax
  80015a:	01 d0                	add    %edx,%eax
  80015c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800163:	01 c8                	add    %ecx,%eax
  800165:	01 c0                	add    %eax,%eax
  800167:	01 d0                	add    %edx,%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	01 d0                	add    %edx,%eax
  80016d:	89 c2                	mov    %eax,%edx
  80016f:	c1 e2 05             	shl    $0x5,%edx
  800172:	29 c2                	sub    %eax,%edx
  800174:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80017b:	89 c2                	mov    %eax,%edx
  80017d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800183:	a3 24 20 80 00       	mov    %eax,0x802024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800188:	a1 24 20 80 00       	mov    0x802024,%eax
  80018d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800193:	84 c0                	test   %al,%al
  800195:	74 0f                	je     8001a6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800197:	a1 24 20 80 00       	mov    0x802024,%eax
  80019c:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001a1:	a3 04 20 80 00       	mov    %eax,0x802004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001aa:	7e 0a                	jle    8001b6 <libmain+0x72>
		binaryname = argv[0];
  8001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001af:	8b 00                	mov    (%eax),%eax
  8001b1:	a3 04 20 80 00       	mov    %eax,0x802004

	// call user main routine
	_main(argc, argv);
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	ff 75 0c             	pushl  0xc(%ebp)
  8001bc:	ff 75 08             	pushl  0x8(%ebp)
  8001bf:	e8 74 fe ff ff       	call   800038 <_main>
  8001c4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c7:	e8 57 11 00 00       	call   801323 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	68 40 1a 80 00       	push   $0x801a40
  8001d4:	e8 84 01 00 00       	call   80035d <cprintf>
  8001d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001dc:	a1 24 20 80 00       	mov    0x802024,%eax
  8001e1:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001e7:	a1 24 20 80 00       	mov    0x802024,%eax
  8001ec:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	52                   	push   %edx
  8001f6:	50                   	push   %eax
  8001f7:	68 68 1a 80 00       	push   $0x801a68
  8001fc:	e8 5c 01 00 00       	call   80035d <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800204:	a1 24 20 80 00       	mov    0x802024,%eax
  800209:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80020f:	a1 24 20 80 00       	mov    0x802024,%eax
  800214:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	52                   	push   %edx
  80021e:	50                   	push   %eax
  80021f:	68 90 1a 80 00       	push   $0x801a90
  800224:	e8 34 01 00 00       	call   80035d <cprintf>
  800229:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80022c:	a1 24 20 80 00       	mov    0x802024,%eax
  800231:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800237:	83 ec 08             	sub    $0x8,%esp
  80023a:	50                   	push   %eax
  80023b:	68 d1 1a 80 00       	push   $0x801ad1
  800240:	e8 18 01 00 00       	call   80035d <cprintf>
  800245:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	68 40 1a 80 00       	push   $0x801a40
  800250:	e8 08 01 00 00       	call   80035d <cprintf>
  800255:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800258:	e8 e0 10 00 00       	call   80133d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80025d:	e8 19 00 00 00       	call   80027b <exit>
}
  800262:	90                   	nop
  800263:	c9                   	leave  
  800264:	c3                   	ret    

00800265 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800265:	55                   	push   %ebp
  800266:	89 e5                	mov    %esp,%ebp
  800268:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	6a 00                	push   $0x0
  800270:	e8 df 0e 00 00       	call   801154 <sys_env_destroy>
  800275:	83 c4 10             	add    $0x10,%esp
}
  800278:	90                   	nop
  800279:	c9                   	leave  
  80027a:	c3                   	ret    

0080027b <exit>:

void
exit(void)
{
  80027b:	55                   	push   %ebp
  80027c:	89 e5                	mov    %esp,%ebp
  80027e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800281:	e8 34 0f 00 00       	call   8011ba <sys_env_exit>
}
  800286:	90                   	nop
  800287:	c9                   	leave  
  800288:	c3                   	ret    

00800289 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800289:	55                   	push   %ebp
  80028a:	89 e5                	mov    %esp,%ebp
  80028c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80028f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	8d 48 01             	lea    0x1(%eax),%ecx
  800297:	8b 55 0c             	mov    0xc(%ebp),%edx
  80029a:	89 0a                	mov    %ecx,(%edx)
  80029c:	8b 55 08             	mov    0x8(%ebp),%edx
  80029f:	88 d1                	mov    %dl,%cl
  8002a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002a4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ab:	8b 00                	mov    (%eax),%eax
  8002ad:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002b2:	75 2c                	jne    8002e0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002b4:	a0 28 20 80 00       	mov    0x802028,%al
  8002b9:	0f b6 c0             	movzbl %al,%eax
  8002bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002bf:	8b 12                	mov    (%edx),%edx
  8002c1:	89 d1                	mov    %edx,%ecx
  8002c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002c6:	83 c2 08             	add    $0x8,%edx
  8002c9:	83 ec 04             	sub    $0x4,%esp
  8002cc:	50                   	push   %eax
  8002cd:	51                   	push   %ecx
  8002ce:	52                   	push   %edx
  8002cf:	e8 3e 0e 00 00       	call   801112 <sys_cputs>
  8002d4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002e3:	8b 40 04             	mov    0x4(%eax),%eax
  8002e6:	8d 50 01             	lea    0x1(%eax),%edx
  8002e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ec:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002ef:	90                   	nop
  8002f0:	c9                   	leave  
  8002f1:	c3                   	ret    

008002f2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002f2:	55                   	push   %ebp
  8002f3:	89 e5                	mov    %esp,%ebp
  8002f5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002fb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800302:	00 00 00 
	b.cnt = 0;
  800305:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80030c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80030f:	ff 75 0c             	pushl  0xc(%ebp)
  800312:	ff 75 08             	pushl  0x8(%ebp)
  800315:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80031b:	50                   	push   %eax
  80031c:	68 89 02 80 00       	push   $0x800289
  800321:	e8 11 02 00 00       	call   800537 <vprintfmt>
  800326:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800329:	a0 28 20 80 00       	mov    0x802028,%al
  80032e:	0f b6 c0             	movzbl %al,%eax
  800331:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800337:	83 ec 04             	sub    $0x4,%esp
  80033a:	50                   	push   %eax
  80033b:	52                   	push   %edx
  80033c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800342:	83 c0 08             	add    $0x8,%eax
  800345:	50                   	push   %eax
  800346:	e8 c7 0d 00 00       	call   801112 <sys_cputs>
  80034b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80034e:	c6 05 28 20 80 00 00 	movb   $0x0,0x802028
	return b.cnt;
  800355:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80035b:	c9                   	leave  
  80035c:	c3                   	ret    

0080035d <cprintf>:

int cprintf(const char *fmt, ...) {
  80035d:	55                   	push   %ebp
  80035e:	89 e5                	mov    %esp,%ebp
  800360:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800363:	c6 05 28 20 80 00 01 	movb   $0x1,0x802028
	va_start(ap, fmt);
  80036a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80036d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800370:	8b 45 08             	mov    0x8(%ebp),%eax
  800373:	83 ec 08             	sub    $0x8,%esp
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	50                   	push   %eax
  80037a:	e8 73 ff ff ff       	call   8002f2 <vcprintf>
  80037f:	83 c4 10             	add    $0x10,%esp
  800382:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800385:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800388:	c9                   	leave  
  800389:	c3                   	ret    

0080038a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80038a:	55                   	push   %ebp
  80038b:	89 e5                	mov    %esp,%ebp
  80038d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800390:	e8 8e 0f 00 00       	call   801323 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800395:	8d 45 0c             	lea    0xc(%ebp),%eax
  800398:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80039b:	8b 45 08             	mov    0x8(%ebp),%eax
  80039e:	83 ec 08             	sub    $0x8,%esp
  8003a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a4:	50                   	push   %eax
  8003a5:	e8 48 ff ff ff       	call   8002f2 <vcprintf>
  8003aa:	83 c4 10             	add    $0x10,%esp
  8003ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003b0:	e8 88 0f 00 00       	call   80133d <sys_enable_interrupt>
	return cnt;
  8003b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003b8:	c9                   	leave  
  8003b9:	c3                   	ret    

008003ba <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8003ba:	55                   	push   %ebp
  8003bb:	89 e5                	mov    %esp,%ebp
  8003bd:	53                   	push   %ebx
  8003be:	83 ec 14             	sub    $0x14,%esp
  8003c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8003c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8003ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003cd:	8b 45 18             	mov    0x18(%ebp),%eax
  8003d0:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003d8:	77 55                	ja     80042f <printnum+0x75>
  8003da:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003dd:	72 05                	jb     8003e4 <printnum+0x2a>
  8003df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003e2:	77 4b                	ja     80042f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003e4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003e7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003ea:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ed:	ba 00 00 00 00       	mov    $0x0,%edx
  8003f2:	52                   	push   %edx
  8003f3:	50                   	push   %eax
  8003f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f7:	ff 75 f0             	pushl  -0x10(%ebp)
  8003fa:	e8 45 13 00 00       	call   801744 <__udivdi3>
  8003ff:	83 c4 10             	add    $0x10,%esp
  800402:	83 ec 04             	sub    $0x4,%esp
  800405:	ff 75 20             	pushl  0x20(%ebp)
  800408:	53                   	push   %ebx
  800409:	ff 75 18             	pushl  0x18(%ebp)
  80040c:	52                   	push   %edx
  80040d:	50                   	push   %eax
  80040e:	ff 75 0c             	pushl  0xc(%ebp)
  800411:	ff 75 08             	pushl  0x8(%ebp)
  800414:	e8 a1 ff ff ff       	call   8003ba <printnum>
  800419:	83 c4 20             	add    $0x20,%esp
  80041c:	eb 1a                	jmp    800438 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80041e:	83 ec 08             	sub    $0x8,%esp
  800421:	ff 75 0c             	pushl  0xc(%ebp)
  800424:	ff 75 20             	pushl  0x20(%ebp)
  800427:	8b 45 08             	mov    0x8(%ebp),%eax
  80042a:	ff d0                	call   *%eax
  80042c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80042f:	ff 4d 1c             	decl   0x1c(%ebp)
  800432:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800436:	7f e6                	jg     80041e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800438:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80043b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800440:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800443:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800446:	53                   	push   %ebx
  800447:	51                   	push   %ecx
  800448:	52                   	push   %edx
  800449:	50                   	push   %eax
  80044a:	e8 05 14 00 00       	call   801854 <__umoddi3>
  80044f:	83 c4 10             	add    $0x10,%esp
  800452:	05 14 1d 80 00       	add    $0x801d14,%eax
  800457:	8a 00                	mov    (%eax),%al
  800459:	0f be c0             	movsbl %al,%eax
  80045c:	83 ec 08             	sub    $0x8,%esp
  80045f:	ff 75 0c             	pushl  0xc(%ebp)
  800462:	50                   	push   %eax
  800463:	8b 45 08             	mov    0x8(%ebp),%eax
  800466:	ff d0                	call   *%eax
  800468:	83 c4 10             	add    $0x10,%esp
}
  80046b:	90                   	nop
  80046c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80046f:	c9                   	leave  
  800470:	c3                   	ret    

00800471 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800471:	55                   	push   %ebp
  800472:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800474:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800478:	7e 1c                	jle    800496 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80047a:	8b 45 08             	mov    0x8(%ebp),%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	8d 50 08             	lea    0x8(%eax),%edx
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	89 10                	mov    %edx,(%eax)
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	8b 00                	mov    (%eax),%eax
  80048c:	83 e8 08             	sub    $0x8,%eax
  80048f:	8b 50 04             	mov    0x4(%eax),%edx
  800492:	8b 00                	mov    (%eax),%eax
  800494:	eb 40                	jmp    8004d6 <getuint+0x65>
	else if (lflag)
  800496:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80049a:	74 1e                	je     8004ba <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80049c:	8b 45 08             	mov    0x8(%ebp),%eax
  80049f:	8b 00                	mov    (%eax),%eax
  8004a1:	8d 50 04             	lea    0x4(%eax),%edx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	89 10                	mov    %edx,(%eax)
  8004a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ac:	8b 00                	mov    (%eax),%eax
  8004ae:	83 e8 04             	sub    $0x4,%eax
  8004b1:	8b 00                	mov    (%eax),%eax
  8004b3:	ba 00 00 00 00       	mov    $0x0,%edx
  8004b8:	eb 1c                	jmp    8004d6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	8b 00                	mov    (%eax),%eax
  8004bf:	8d 50 04             	lea    0x4(%eax),%edx
  8004c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c5:	89 10                	mov    %edx,(%eax)
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	8b 00                	mov    (%eax),%eax
  8004cc:	83 e8 04             	sub    $0x4,%eax
  8004cf:	8b 00                	mov    (%eax),%eax
  8004d1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004d6:	5d                   	pop    %ebp
  8004d7:	c3                   	ret    

008004d8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004d8:	55                   	push   %ebp
  8004d9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004db:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004df:	7e 1c                	jle    8004fd <getint+0x25>
		return va_arg(*ap, long long);
  8004e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	8d 50 08             	lea    0x8(%eax),%edx
  8004e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ec:	89 10                	mov    %edx,(%eax)
  8004ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f1:	8b 00                	mov    (%eax),%eax
  8004f3:	83 e8 08             	sub    $0x8,%eax
  8004f6:	8b 50 04             	mov    0x4(%eax),%edx
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	eb 38                	jmp    800535 <getint+0x5d>
	else if (lflag)
  8004fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800501:	74 1a                	je     80051d <getint+0x45>
		return va_arg(*ap, long);
  800503:	8b 45 08             	mov    0x8(%ebp),%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	8d 50 04             	lea    0x4(%eax),%edx
  80050b:	8b 45 08             	mov    0x8(%ebp),%eax
  80050e:	89 10                	mov    %edx,(%eax)
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	8b 00                	mov    (%eax),%eax
  800515:	83 e8 04             	sub    $0x4,%eax
  800518:	8b 00                	mov    (%eax),%eax
  80051a:	99                   	cltd   
  80051b:	eb 18                	jmp    800535 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80051d:	8b 45 08             	mov    0x8(%ebp),%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	8d 50 04             	lea    0x4(%eax),%edx
  800525:	8b 45 08             	mov    0x8(%ebp),%eax
  800528:	89 10                	mov    %edx,(%eax)
  80052a:	8b 45 08             	mov    0x8(%ebp),%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	83 e8 04             	sub    $0x4,%eax
  800532:	8b 00                	mov    (%eax),%eax
  800534:	99                   	cltd   
}
  800535:	5d                   	pop    %ebp
  800536:	c3                   	ret    

00800537 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800537:	55                   	push   %ebp
  800538:	89 e5                	mov    %esp,%ebp
  80053a:	56                   	push   %esi
  80053b:	53                   	push   %ebx
  80053c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80053f:	eb 17                	jmp    800558 <vprintfmt+0x21>
			if (ch == '\0')
  800541:	85 db                	test   %ebx,%ebx
  800543:	0f 84 af 03 00 00    	je     8008f8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800549:	83 ec 08             	sub    $0x8,%esp
  80054c:	ff 75 0c             	pushl  0xc(%ebp)
  80054f:	53                   	push   %ebx
  800550:	8b 45 08             	mov    0x8(%ebp),%eax
  800553:	ff d0                	call   *%eax
  800555:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800558:	8b 45 10             	mov    0x10(%ebp),%eax
  80055b:	8d 50 01             	lea    0x1(%eax),%edx
  80055e:	89 55 10             	mov    %edx,0x10(%ebp)
  800561:	8a 00                	mov    (%eax),%al
  800563:	0f b6 d8             	movzbl %al,%ebx
  800566:	83 fb 25             	cmp    $0x25,%ebx
  800569:	75 d6                	jne    800541 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80056b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80056f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800576:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80057d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800584:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80058b:	8b 45 10             	mov    0x10(%ebp),%eax
  80058e:	8d 50 01             	lea    0x1(%eax),%edx
  800591:	89 55 10             	mov    %edx,0x10(%ebp)
  800594:	8a 00                	mov    (%eax),%al
  800596:	0f b6 d8             	movzbl %al,%ebx
  800599:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80059c:	83 f8 55             	cmp    $0x55,%eax
  80059f:	0f 87 2b 03 00 00    	ja     8008d0 <vprintfmt+0x399>
  8005a5:	8b 04 85 38 1d 80 00 	mov    0x801d38(,%eax,4),%eax
  8005ac:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005ae:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005b2:	eb d7                	jmp    80058b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005b4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8005b8:	eb d1                	jmp    80058b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005ba:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005c4:	89 d0                	mov    %edx,%eax
  8005c6:	c1 e0 02             	shl    $0x2,%eax
  8005c9:	01 d0                	add    %edx,%eax
  8005cb:	01 c0                	add    %eax,%eax
  8005cd:	01 d8                	add    %ebx,%eax
  8005cf:	83 e8 30             	sub    $0x30,%eax
  8005d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d8:	8a 00                	mov    (%eax),%al
  8005da:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005dd:	83 fb 2f             	cmp    $0x2f,%ebx
  8005e0:	7e 3e                	jle    800620 <vprintfmt+0xe9>
  8005e2:	83 fb 39             	cmp    $0x39,%ebx
  8005e5:	7f 39                	jg     800620 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005e7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005ea:	eb d5                	jmp    8005c1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ef:	83 c0 04             	add    $0x4,%eax
  8005f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f8:	83 e8 04             	sub    $0x4,%eax
  8005fb:	8b 00                	mov    (%eax),%eax
  8005fd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800600:	eb 1f                	jmp    800621 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800602:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800606:	79 83                	jns    80058b <vprintfmt+0x54>
				width = 0;
  800608:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80060f:	e9 77 ff ff ff       	jmp    80058b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800614:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80061b:	e9 6b ff ff ff       	jmp    80058b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800620:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800621:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800625:	0f 89 60 ff ff ff    	jns    80058b <vprintfmt+0x54>
				width = precision, precision = -1;
  80062b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800631:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800638:	e9 4e ff ff ff       	jmp    80058b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80063d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800640:	e9 46 ff ff ff       	jmp    80058b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800645:	8b 45 14             	mov    0x14(%ebp),%eax
  800648:	83 c0 04             	add    $0x4,%eax
  80064b:	89 45 14             	mov    %eax,0x14(%ebp)
  80064e:	8b 45 14             	mov    0x14(%ebp),%eax
  800651:	83 e8 04             	sub    $0x4,%eax
  800654:	8b 00                	mov    (%eax),%eax
  800656:	83 ec 08             	sub    $0x8,%esp
  800659:	ff 75 0c             	pushl  0xc(%ebp)
  80065c:	50                   	push   %eax
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	ff d0                	call   *%eax
  800662:	83 c4 10             	add    $0x10,%esp
			break;
  800665:	e9 89 02 00 00       	jmp    8008f3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80066a:	8b 45 14             	mov    0x14(%ebp),%eax
  80066d:	83 c0 04             	add    $0x4,%eax
  800670:	89 45 14             	mov    %eax,0x14(%ebp)
  800673:	8b 45 14             	mov    0x14(%ebp),%eax
  800676:	83 e8 04             	sub    $0x4,%eax
  800679:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80067b:	85 db                	test   %ebx,%ebx
  80067d:	79 02                	jns    800681 <vprintfmt+0x14a>
				err = -err;
  80067f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800681:	83 fb 64             	cmp    $0x64,%ebx
  800684:	7f 0b                	jg     800691 <vprintfmt+0x15a>
  800686:	8b 34 9d 80 1b 80 00 	mov    0x801b80(,%ebx,4),%esi
  80068d:	85 f6                	test   %esi,%esi
  80068f:	75 19                	jne    8006aa <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800691:	53                   	push   %ebx
  800692:	68 25 1d 80 00       	push   $0x801d25
  800697:	ff 75 0c             	pushl  0xc(%ebp)
  80069a:	ff 75 08             	pushl  0x8(%ebp)
  80069d:	e8 5e 02 00 00       	call   800900 <printfmt>
  8006a2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006a5:	e9 49 02 00 00       	jmp    8008f3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006aa:	56                   	push   %esi
  8006ab:	68 2e 1d 80 00       	push   $0x801d2e
  8006b0:	ff 75 0c             	pushl  0xc(%ebp)
  8006b3:	ff 75 08             	pushl  0x8(%ebp)
  8006b6:	e8 45 02 00 00       	call   800900 <printfmt>
  8006bb:	83 c4 10             	add    $0x10,%esp
			break;
  8006be:	e9 30 02 00 00       	jmp    8008f3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c6:	83 c0 04             	add    $0x4,%eax
  8006c9:	89 45 14             	mov    %eax,0x14(%ebp)
  8006cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8006cf:	83 e8 04             	sub    $0x4,%eax
  8006d2:	8b 30                	mov    (%eax),%esi
  8006d4:	85 f6                	test   %esi,%esi
  8006d6:	75 05                	jne    8006dd <vprintfmt+0x1a6>
				p = "(null)";
  8006d8:	be 31 1d 80 00       	mov    $0x801d31,%esi
			if (width > 0 && padc != '-')
  8006dd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e1:	7e 6d                	jle    800750 <vprintfmt+0x219>
  8006e3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006e7:	74 67                	je     800750 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	50                   	push   %eax
  8006f0:	56                   	push   %esi
  8006f1:	e8 0c 03 00 00       	call   800a02 <strnlen>
  8006f6:	83 c4 10             	add    $0x10,%esp
  8006f9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006fc:	eb 16                	jmp    800714 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006fe:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	ff 75 0c             	pushl  0xc(%ebp)
  800708:	50                   	push   %eax
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	ff d0                	call   *%eax
  80070e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800711:	ff 4d e4             	decl   -0x1c(%ebp)
  800714:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800718:	7f e4                	jg     8006fe <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80071a:	eb 34                	jmp    800750 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80071c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800720:	74 1c                	je     80073e <vprintfmt+0x207>
  800722:	83 fb 1f             	cmp    $0x1f,%ebx
  800725:	7e 05                	jle    80072c <vprintfmt+0x1f5>
  800727:	83 fb 7e             	cmp    $0x7e,%ebx
  80072a:	7e 12                	jle    80073e <vprintfmt+0x207>
					putch('?', putdat);
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	ff 75 0c             	pushl  0xc(%ebp)
  800732:	6a 3f                	push   $0x3f
  800734:	8b 45 08             	mov    0x8(%ebp),%eax
  800737:	ff d0                	call   *%eax
  800739:	83 c4 10             	add    $0x10,%esp
  80073c:	eb 0f                	jmp    80074d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	ff 75 0c             	pushl  0xc(%ebp)
  800744:	53                   	push   %ebx
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	ff d0                	call   *%eax
  80074a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80074d:	ff 4d e4             	decl   -0x1c(%ebp)
  800750:	89 f0                	mov    %esi,%eax
  800752:	8d 70 01             	lea    0x1(%eax),%esi
  800755:	8a 00                	mov    (%eax),%al
  800757:	0f be d8             	movsbl %al,%ebx
  80075a:	85 db                	test   %ebx,%ebx
  80075c:	74 24                	je     800782 <vprintfmt+0x24b>
  80075e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800762:	78 b8                	js     80071c <vprintfmt+0x1e5>
  800764:	ff 4d e0             	decl   -0x20(%ebp)
  800767:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80076b:	79 af                	jns    80071c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80076d:	eb 13                	jmp    800782 <vprintfmt+0x24b>
				putch(' ', putdat);
  80076f:	83 ec 08             	sub    $0x8,%esp
  800772:	ff 75 0c             	pushl  0xc(%ebp)
  800775:	6a 20                	push   $0x20
  800777:	8b 45 08             	mov    0x8(%ebp),%eax
  80077a:	ff d0                	call   *%eax
  80077c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80077f:	ff 4d e4             	decl   -0x1c(%ebp)
  800782:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800786:	7f e7                	jg     80076f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800788:	e9 66 01 00 00       	jmp    8008f3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80078d:	83 ec 08             	sub    $0x8,%esp
  800790:	ff 75 e8             	pushl  -0x18(%ebp)
  800793:	8d 45 14             	lea    0x14(%ebp),%eax
  800796:	50                   	push   %eax
  800797:	e8 3c fd ff ff       	call   8004d8 <getint>
  80079c:	83 c4 10             	add    $0x10,%esp
  80079f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ab:	85 d2                	test   %edx,%edx
  8007ad:	79 23                	jns    8007d2 <vprintfmt+0x29b>
				putch('-', putdat);
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	ff 75 0c             	pushl  0xc(%ebp)
  8007b5:	6a 2d                	push   $0x2d
  8007b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ba:	ff d0                	call   *%eax
  8007bc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c5:	f7 d8                	neg    %eax
  8007c7:	83 d2 00             	adc    $0x0,%edx
  8007ca:	f7 da                	neg    %edx
  8007cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007d2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007d9:	e9 bc 00 00 00       	jmp    80089a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007de:	83 ec 08             	sub    $0x8,%esp
  8007e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e7:	50                   	push   %eax
  8007e8:	e8 84 fc ff ff       	call   800471 <getuint>
  8007ed:	83 c4 10             	add    $0x10,%esp
  8007f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007f6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007fd:	e9 98 00 00 00       	jmp    80089a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	6a 58                	push   $0x58
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	ff d0                	call   *%eax
  80080f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	6a 58                	push   $0x58
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	ff d0                	call   *%eax
  80081f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800822:	83 ec 08             	sub    $0x8,%esp
  800825:	ff 75 0c             	pushl  0xc(%ebp)
  800828:	6a 58                	push   $0x58
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
			break;
  800832:	e9 bc 00 00 00       	jmp    8008f3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800837:	83 ec 08             	sub    $0x8,%esp
  80083a:	ff 75 0c             	pushl  0xc(%ebp)
  80083d:	6a 30                	push   $0x30
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	ff d0                	call   *%eax
  800844:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800847:	83 ec 08             	sub    $0x8,%esp
  80084a:	ff 75 0c             	pushl  0xc(%ebp)
  80084d:	6a 78                	push   $0x78
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	ff d0                	call   *%eax
  800854:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800857:	8b 45 14             	mov    0x14(%ebp),%eax
  80085a:	83 c0 04             	add    $0x4,%eax
  80085d:	89 45 14             	mov    %eax,0x14(%ebp)
  800860:	8b 45 14             	mov    0x14(%ebp),%eax
  800863:	83 e8 04             	sub    $0x4,%eax
  800866:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800868:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80086b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800872:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800879:	eb 1f                	jmp    80089a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80087b:	83 ec 08             	sub    $0x8,%esp
  80087e:	ff 75 e8             	pushl  -0x18(%ebp)
  800881:	8d 45 14             	lea    0x14(%ebp),%eax
  800884:	50                   	push   %eax
  800885:	e8 e7 fb ff ff       	call   800471 <getuint>
  80088a:	83 c4 10             	add    $0x10,%esp
  80088d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800890:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800893:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80089a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80089e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a1:	83 ec 04             	sub    $0x4,%esp
  8008a4:	52                   	push   %edx
  8008a5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008a8:	50                   	push   %eax
  8008a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8008af:	ff 75 0c             	pushl  0xc(%ebp)
  8008b2:	ff 75 08             	pushl  0x8(%ebp)
  8008b5:	e8 00 fb ff ff       	call   8003ba <printnum>
  8008ba:	83 c4 20             	add    $0x20,%esp
			break;
  8008bd:	eb 34                	jmp    8008f3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008bf:	83 ec 08             	sub    $0x8,%esp
  8008c2:	ff 75 0c             	pushl  0xc(%ebp)
  8008c5:	53                   	push   %ebx
  8008c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c9:	ff d0                	call   *%eax
  8008cb:	83 c4 10             	add    $0x10,%esp
			break;
  8008ce:	eb 23                	jmp    8008f3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008d0:	83 ec 08             	sub    $0x8,%esp
  8008d3:	ff 75 0c             	pushl  0xc(%ebp)
  8008d6:	6a 25                	push   $0x25
  8008d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008db:	ff d0                	call   *%eax
  8008dd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008e0:	ff 4d 10             	decl   0x10(%ebp)
  8008e3:	eb 03                	jmp    8008e8 <vprintfmt+0x3b1>
  8008e5:	ff 4d 10             	decl   0x10(%ebp)
  8008e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008eb:	48                   	dec    %eax
  8008ec:	8a 00                	mov    (%eax),%al
  8008ee:	3c 25                	cmp    $0x25,%al
  8008f0:	75 f3                	jne    8008e5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008f2:	90                   	nop
		}
	}
  8008f3:	e9 47 fc ff ff       	jmp    80053f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008f8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008fc:	5b                   	pop    %ebx
  8008fd:	5e                   	pop    %esi
  8008fe:	5d                   	pop    %ebp
  8008ff:	c3                   	ret    

00800900 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800900:	55                   	push   %ebp
  800901:	89 e5                	mov    %esp,%ebp
  800903:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800906:	8d 45 10             	lea    0x10(%ebp),%eax
  800909:	83 c0 04             	add    $0x4,%eax
  80090c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80090f:	8b 45 10             	mov    0x10(%ebp),%eax
  800912:	ff 75 f4             	pushl  -0xc(%ebp)
  800915:	50                   	push   %eax
  800916:	ff 75 0c             	pushl  0xc(%ebp)
  800919:	ff 75 08             	pushl  0x8(%ebp)
  80091c:	e8 16 fc ff ff       	call   800537 <vprintfmt>
  800921:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800924:	90                   	nop
  800925:	c9                   	leave  
  800926:	c3                   	ret    

00800927 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800927:	55                   	push   %ebp
  800928:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80092a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092d:	8b 40 08             	mov    0x8(%eax),%eax
  800930:	8d 50 01             	lea    0x1(%eax),%edx
  800933:	8b 45 0c             	mov    0xc(%ebp),%eax
  800936:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800939:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093c:	8b 10                	mov    (%eax),%edx
  80093e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800941:	8b 40 04             	mov    0x4(%eax),%eax
  800944:	39 c2                	cmp    %eax,%edx
  800946:	73 12                	jae    80095a <sprintputch+0x33>
		*b->buf++ = ch;
  800948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094b:	8b 00                	mov    (%eax),%eax
  80094d:	8d 48 01             	lea    0x1(%eax),%ecx
  800950:	8b 55 0c             	mov    0xc(%ebp),%edx
  800953:	89 0a                	mov    %ecx,(%edx)
  800955:	8b 55 08             	mov    0x8(%ebp),%edx
  800958:	88 10                	mov    %dl,(%eax)
}
  80095a:	90                   	nop
  80095b:	5d                   	pop    %ebp
  80095c:	c3                   	ret    

0080095d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80095d:	55                   	push   %ebp
  80095e:	89 e5                	mov    %esp,%ebp
  800960:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800969:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	01 d0                	add    %edx,%eax
  800974:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800977:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80097e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800982:	74 06                	je     80098a <vsnprintf+0x2d>
  800984:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800988:	7f 07                	jg     800991 <vsnprintf+0x34>
		return -E_INVAL;
  80098a:	b8 03 00 00 00       	mov    $0x3,%eax
  80098f:	eb 20                	jmp    8009b1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800991:	ff 75 14             	pushl  0x14(%ebp)
  800994:	ff 75 10             	pushl  0x10(%ebp)
  800997:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80099a:	50                   	push   %eax
  80099b:	68 27 09 80 00       	push   $0x800927
  8009a0:	e8 92 fb ff ff       	call   800537 <vprintfmt>
  8009a5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009ab:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009b1:	c9                   	leave  
  8009b2:	c3                   	ret    

008009b3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009b3:	55                   	push   %ebp
  8009b4:	89 e5                	mov    %esp,%ebp
  8009b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8009b9:	8d 45 10             	lea    0x10(%ebp),%eax
  8009bc:	83 c0 04             	add    $0x4,%eax
  8009bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8009c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c8:	50                   	push   %eax
  8009c9:	ff 75 0c             	pushl  0xc(%ebp)
  8009cc:	ff 75 08             	pushl  0x8(%ebp)
  8009cf:	e8 89 ff ff ff       	call   80095d <vsnprintf>
  8009d4:	83 c4 10             	add    $0x10,%esp
  8009d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ec:	eb 06                	jmp    8009f4 <strlen+0x15>
		n++;
  8009ee:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009f1:	ff 45 08             	incl   0x8(%ebp)
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	8a 00                	mov    (%eax),%al
  8009f9:	84 c0                	test   %al,%al
  8009fb:	75 f1                	jne    8009ee <strlen+0xf>
		n++;
	return n;
  8009fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a00:	c9                   	leave  
  800a01:	c3                   	ret    

00800a02 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a02:	55                   	push   %ebp
  800a03:	89 e5                	mov    %esp,%ebp
  800a05:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a08:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a0f:	eb 09                	jmp    800a1a <strnlen+0x18>
		n++;
  800a11:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a14:	ff 45 08             	incl   0x8(%ebp)
  800a17:	ff 4d 0c             	decl   0xc(%ebp)
  800a1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a1e:	74 09                	je     800a29 <strnlen+0x27>
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	8a 00                	mov    (%eax),%al
  800a25:	84 c0                	test   %al,%al
  800a27:	75 e8                	jne    800a11 <strnlen+0xf>
		n++;
	return n;
  800a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a2c:	c9                   	leave  
  800a2d:	c3                   	ret    

00800a2e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a2e:	55                   	push   %ebp
  800a2f:	89 e5                	mov    %esp,%ebp
  800a31:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a34:	8b 45 08             	mov    0x8(%ebp),%eax
  800a37:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a3a:	90                   	nop
  800a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3e:	8d 50 01             	lea    0x1(%eax),%edx
  800a41:	89 55 08             	mov    %edx,0x8(%ebp)
  800a44:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a47:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a4a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a4d:	8a 12                	mov    (%edx),%dl
  800a4f:	88 10                	mov    %dl,(%eax)
  800a51:	8a 00                	mov    (%eax),%al
  800a53:	84 c0                	test   %al,%al
  800a55:	75 e4                	jne    800a3b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a57:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a5a:	c9                   	leave  
  800a5b:	c3                   	ret    

00800a5c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a5c:	55                   	push   %ebp
  800a5d:	89 e5                	mov    %esp,%ebp
  800a5f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a6f:	eb 1f                	jmp    800a90 <strncpy+0x34>
		*dst++ = *src;
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	8d 50 01             	lea    0x1(%eax),%edx
  800a77:	89 55 08             	mov    %edx,0x8(%ebp)
  800a7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7d:	8a 12                	mov    (%edx),%dl
  800a7f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	84 c0                	test   %al,%al
  800a88:	74 03                	je     800a8d <strncpy+0x31>
			src++;
  800a8a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a8d:	ff 45 fc             	incl   -0x4(%ebp)
  800a90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a93:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a96:	72 d9                	jb     800a71 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a98:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a9b:	c9                   	leave  
  800a9c:	c3                   	ret    

00800a9d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a9d:	55                   	push   %ebp
  800a9e:	89 e5                	mov    %esp,%ebp
  800aa0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800aa9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aad:	74 30                	je     800adf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800aaf:	eb 16                	jmp    800ac7 <strlcpy+0x2a>
			*dst++ = *src++;
  800ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab4:	8d 50 01             	lea    0x1(%eax),%edx
  800ab7:	89 55 08             	mov    %edx,0x8(%ebp)
  800aba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800abd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ac0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ac3:	8a 12                	mov    (%edx),%dl
  800ac5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ac7:	ff 4d 10             	decl   0x10(%ebp)
  800aca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ace:	74 09                	je     800ad9 <strlcpy+0x3c>
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	8a 00                	mov    (%eax),%al
  800ad5:	84 c0                	test   %al,%al
  800ad7:	75 d8                	jne    800ab1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800adf:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ae5:	29 c2                	sub    %eax,%edx
  800ae7:	89 d0                	mov    %edx,%eax
}
  800ae9:	c9                   	leave  
  800aea:	c3                   	ret    

00800aeb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800aeb:	55                   	push   %ebp
  800aec:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800aee:	eb 06                	jmp    800af6 <strcmp+0xb>
		p++, q++;
  800af0:	ff 45 08             	incl   0x8(%ebp)
  800af3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	8a 00                	mov    (%eax),%al
  800afb:	84 c0                	test   %al,%al
  800afd:	74 0e                	je     800b0d <strcmp+0x22>
  800aff:	8b 45 08             	mov    0x8(%ebp),%eax
  800b02:	8a 10                	mov    (%eax),%dl
  800b04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b07:	8a 00                	mov    (%eax),%al
  800b09:	38 c2                	cmp    %al,%dl
  800b0b:	74 e3                	je     800af0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	8a 00                	mov    (%eax),%al
  800b12:	0f b6 d0             	movzbl %al,%edx
  800b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b18:	8a 00                	mov    (%eax),%al
  800b1a:	0f b6 c0             	movzbl %al,%eax
  800b1d:	29 c2                	sub    %eax,%edx
  800b1f:	89 d0                	mov    %edx,%eax
}
  800b21:	5d                   	pop    %ebp
  800b22:	c3                   	ret    

00800b23 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b23:	55                   	push   %ebp
  800b24:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b26:	eb 09                	jmp    800b31 <strncmp+0xe>
		n--, p++, q++;
  800b28:	ff 4d 10             	decl   0x10(%ebp)
  800b2b:	ff 45 08             	incl   0x8(%ebp)
  800b2e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b31:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b35:	74 17                	je     800b4e <strncmp+0x2b>
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8a 00                	mov    (%eax),%al
  800b3c:	84 c0                	test   %al,%al
  800b3e:	74 0e                	je     800b4e <strncmp+0x2b>
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	8a 10                	mov    (%eax),%dl
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	8a 00                	mov    (%eax),%al
  800b4a:	38 c2                	cmp    %al,%dl
  800b4c:	74 da                	je     800b28 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b52:	75 07                	jne    800b5b <strncmp+0x38>
		return 0;
  800b54:	b8 00 00 00 00       	mov    $0x0,%eax
  800b59:	eb 14                	jmp    800b6f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	0f b6 d0             	movzbl %al,%edx
  800b63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	0f b6 c0             	movzbl %al,%eax
  800b6b:	29 c2                	sub    %eax,%edx
  800b6d:	89 d0                	mov    %edx,%eax
}
  800b6f:	5d                   	pop    %ebp
  800b70:	c3                   	ret    

00800b71 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
  800b74:	83 ec 04             	sub    $0x4,%esp
  800b77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b7d:	eb 12                	jmp    800b91 <strchr+0x20>
		if (*s == c)
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b87:	75 05                	jne    800b8e <strchr+0x1d>
			return (char *) s;
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	eb 11                	jmp    800b9f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b8e:	ff 45 08             	incl   0x8(%ebp)
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	84 c0                	test   %al,%al
  800b98:	75 e5                	jne    800b7f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
  800ba4:	83 ec 04             	sub    $0x4,%esp
  800ba7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800baa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bad:	eb 0d                	jmp    800bbc <strfind+0x1b>
		if (*s == c)
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	8a 00                	mov    (%eax),%al
  800bb4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bb7:	74 0e                	je     800bc7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800bb9:	ff 45 08             	incl   0x8(%ebp)
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	8a 00                	mov    (%eax),%al
  800bc1:	84 c0                	test   %al,%al
  800bc3:	75 ea                	jne    800baf <strfind+0xe>
  800bc5:	eb 01                	jmp    800bc8 <strfind+0x27>
		if (*s == c)
			break;
  800bc7:	90                   	nop
	return (char *) s;
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bcb:	c9                   	leave  
  800bcc:	c3                   	ret    

00800bcd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800bcd:	55                   	push   %ebp
  800bce:	89 e5                	mov    %esp,%ebp
  800bd0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bdf:	eb 0e                	jmp    800bef <memset+0x22>
		*p++ = c;
  800be1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be4:	8d 50 01             	lea    0x1(%eax),%edx
  800be7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bed:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bef:	ff 4d f8             	decl   -0x8(%ebp)
  800bf2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bf6:	79 e9                	jns    800be1 <memset+0x14>
		*p++ = c;

	return v;
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bfb:	c9                   	leave  
  800bfc:	c3                   	ret    

00800bfd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c0f:	eb 16                	jmp    800c27 <memcpy+0x2a>
		*d++ = *s++;
  800c11:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c14:	8d 50 01             	lea    0x1(%eax),%edx
  800c17:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c1d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c20:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c23:	8a 12                	mov    (%edx),%dl
  800c25:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c27:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c2d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c30:	85 c0                	test   %eax,%eax
  800c32:	75 dd                	jne    800c11 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c37:	c9                   	leave  
  800c38:	c3                   	ret    

00800c39 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c39:	55                   	push   %ebp
  800c3a:	89 e5                	mov    %esp,%ebp
  800c3c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c51:	73 50                	jae    800ca3 <memmove+0x6a>
  800c53:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c56:	8b 45 10             	mov    0x10(%ebp),%eax
  800c59:	01 d0                	add    %edx,%eax
  800c5b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c5e:	76 43                	jbe    800ca3 <memmove+0x6a>
		s += n;
  800c60:	8b 45 10             	mov    0x10(%ebp),%eax
  800c63:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c66:	8b 45 10             	mov    0x10(%ebp),%eax
  800c69:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c6c:	eb 10                	jmp    800c7e <memmove+0x45>
			*--d = *--s;
  800c6e:	ff 4d f8             	decl   -0x8(%ebp)
  800c71:	ff 4d fc             	decl   -0x4(%ebp)
  800c74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c77:	8a 10                	mov    (%eax),%dl
  800c79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c7c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c81:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c84:	89 55 10             	mov    %edx,0x10(%ebp)
  800c87:	85 c0                	test   %eax,%eax
  800c89:	75 e3                	jne    800c6e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c8b:	eb 23                	jmp    800cb0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c90:	8d 50 01             	lea    0x1(%eax),%edx
  800c93:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c96:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c99:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c9c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c9f:	8a 12                	mov    (%edx),%dl
  800ca1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ca3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ca9:	89 55 10             	mov    %edx,0x10(%ebp)
  800cac:	85 c0                	test   %eax,%eax
  800cae:	75 dd                	jne    800c8d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cb3:	c9                   	leave  
  800cb4:	c3                   	ret    

00800cb5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800cb5:	55                   	push   %ebp
  800cb6:	89 e5                	mov    %esp,%ebp
  800cb8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800cc7:	eb 2a                	jmp    800cf3 <memcmp+0x3e>
		if (*s1 != *s2)
  800cc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ccc:	8a 10                	mov    (%eax),%dl
  800cce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cd1:	8a 00                	mov    (%eax),%al
  800cd3:	38 c2                	cmp    %al,%dl
  800cd5:	74 16                	je     800ced <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	0f b6 d0             	movzbl %al,%edx
  800cdf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	0f b6 c0             	movzbl %al,%eax
  800ce7:	29 c2                	sub    %eax,%edx
  800ce9:	89 d0                	mov    %edx,%eax
  800ceb:	eb 18                	jmp    800d05 <memcmp+0x50>
		s1++, s2++;
  800ced:	ff 45 fc             	incl   -0x4(%ebp)
  800cf0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf9:	89 55 10             	mov    %edx,0x10(%ebp)
  800cfc:	85 c0                	test   %eax,%eax
  800cfe:	75 c9                	jne    800cc9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d00:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d05:	c9                   	leave  
  800d06:	c3                   	ret    

00800d07 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d07:	55                   	push   %ebp
  800d08:	89 e5                	mov    %esp,%ebp
  800d0a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d0d:	8b 55 08             	mov    0x8(%ebp),%edx
  800d10:	8b 45 10             	mov    0x10(%ebp),%eax
  800d13:	01 d0                	add    %edx,%eax
  800d15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d18:	eb 15                	jmp    800d2f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	8a 00                	mov    (%eax),%al
  800d1f:	0f b6 d0             	movzbl %al,%edx
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	0f b6 c0             	movzbl %al,%eax
  800d28:	39 c2                	cmp    %eax,%edx
  800d2a:	74 0d                	je     800d39 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d2c:	ff 45 08             	incl   0x8(%ebp)
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d35:	72 e3                	jb     800d1a <memfind+0x13>
  800d37:	eb 01                	jmp    800d3a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d39:	90                   	nop
	return (void *) s;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3d:	c9                   	leave  
  800d3e:	c3                   	ret    

00800d3f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
  800d42:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d4c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d53:	eb 03                	jmp    800d58 <strtol+0x19>
		s++;
  800d55:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8a 00                	mov    (%eax),%al
  800d5d:	3c 20                	cmp    $0x20,%al
  800d5f:	74 f4                	je     800d55 <strtol+0x16>
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	3c 09                	cmp    $0x9,%al
  800d68:	74 eb                	je     800d55 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8a 00                	mov    (%eax),%al
  800d6f:	3c 2b                	cmp    $0x2b,%al
  800d71:	75 05                	jne    800d78 <strtol+0x39>
		s++;
  800d73:	ff 45 08             	incl   0x8(%ebp)
  800d76:	eb 13                	jmp    800d8b <strtol+0x4c>
	else if (*s == '-')
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	8a 00                	mov    (%eax),%al
  800d7d:	3c 2d                	cmp    $0x2d,%al
  800d7f:	75 0a                	jne    800d8b <strtol+0x4c>
		s++, neg = 1;
  800d81:	ff 45 08             	incl   0x8(%ebp)
  800d84:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d8f:	74 06                	je     800d97 <strtol+0x58>
  800d91:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d95:	75 20                	jne    800db7 <strtol+0x78>
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	8a 00                	mov    (%eax),%al
  800d9c:	3c 30                	cmp    $0x30,%al
  800d9e:	75 17                	jne    800db7 <strtol+0x78>
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	40                   	inc    %eax
  800da4:	8a 00                	mov    (%eax),%al
  800da6:	3c 78                	cmp    $0x78,%al
  800da8:	75 0d                	jne    800db7 <strtol+0x78>
		s += 2, base = 16;
  800daa:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800dae:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800db5:	eb 28                	jmp    800ddf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800db7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dbb:	75 15                	jne    800dd2 <strtol+0x93>
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	8a 00                	mov    (%eax),%al
  800dc2:	3c 30                	cmp    $0x30,%al
  800dc4:	75 0c                	jne    800dd2 <strtol+0x93>
		s++, base = 8;
  800dc6:	ff 45 08             	incl   0x8(%ebp)
  800dc9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800dd0:	eb 0d                	jmp    800ddf <strtol+0xa0>
	else if (base == 0)
  800dd2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd6:	75 07                	jne    800ddf <strtol+0xa0>
		base = 10;
  800dd8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	8a 00                	mov    (%eax),%al
  800de4:	3c 2f                	cmp    $0x2f,%al
  800de6:	7e 19                	jle    800e01 <strtol+0xc2>
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	8a 00                	mov    (%eax),%al
  800ded:	3c 39                	cmp    $0x39,%al
  800def:	7f 10                	jg     800e01 <strtol+0xc2>
			dig = *s - '0';
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	0f be c0             	movsbl %al,%eax
  800df9:	83 e8 30             	sub    $0x30,%eax
  800dfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dff:	eb 42                	jmp    800e43 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	3c 60                	cmp    $0x60,%al
  800e08:	7e 19                	jle    800e23 <strtol+0xe4>
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	3c 7a                	cmp    $0x7a,%al
  800e11:	7f 10                	jg     800e23 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	0f be c0             	movsbl %al,%eax
  800e1b:	83 e8 57             	sub    $0x57,%eax
  800e1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e21:	eb 20                	jmp    800e43 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	8a 00                	mov    (%eax),%al
  800e28:	3c 40                	cmp    $0x40,%al
  800e2a:	7e 39                	jle    800e65 <strtol+0x126>
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	3c 5a                	cmp    $0x5a,%al
  800e33:	7f 30                	jg     800e65 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	0f be c0             	movsbl %al,%eax
  800e3d:	83 e8 37             	sub    $0x37,%eax
  800e40:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e46:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e49:	7d 19                	jge    800e64 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e4b:	ff 45 08             	incl   0x8(%ebp)
  800e4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e51:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e55:	89 c2                	mov    %eax,%edx
  800e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e5a:	01 d0                	add    %edx,%eax
  800e5c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e5f:	e9 7b ff ff ff       	jmp    800ddf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e64:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e65:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e69:	74 08                	je     800e73 <strtol+0x134>
		*endptr = (char *) s;
  800e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6e:	8b 55 08             	mov    0x8(%ebp),%edx
  800e71:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e73:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e77:	74 07                	je     800e80 <strtol+0x141>
  800e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7c:	f7 d8                	neg    %eax
  800e7e:	eb 03                	jmp    800e83 <strtol+0x144>
  800e80:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e83:	c9                   	leave  
  800e84:	c3                   	ret    

00800e85 <ltostr>:

void
ltostr(long value, char *str)
{
  800e85:	55                   	push   %ebp
  800e86:	89 e5                	mov    %esp,%ebp
  800e88:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e99:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e9d:	79 13                	jns    800eb2 <ltostr+0x2d>
	{
		neg = 1;
  800e9f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800eac:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800eaf:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800eba:	99                   	cltd   
  800ebb:	f7 f9                	idiv   %ecx
  800ebd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ec0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec3:	8d 50 01             	lea    0x1(%eax),%edx
  800ec6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ec9:	89 c2                	mov    %eax,%edx
  800ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ece:	01 d0                	add    %edx,%eax
  800ed0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ed3:	83 c2 30             	add    $0x30,%edx
  800ed6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ed8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800edb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ee0:	f7 e9                	imul   %ecx
  800ee2:	c1 fa 02             	sar    $0x2,%edx
  800ee5:	89 c8                	mov    %ecx,%eax
  800ee7:	c1 f8 1f             	sar    $0x1f,%eax
  800eea:	29 c2                	sub    %eax,%edx
  800eec:	89 d0                	mov    %edx,%eax
  800eee:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ef1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ef4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ef9:	f7 e9                	imul   %ecx
  800efb:	c1 fa 02             	sar    $0x2,%edx
  800efe:	89 c8                	mov    %ecx,%eax
  800f00:	c1 f8 1f             	sar    $0x1f,%eax
  800f03:	29 c2                	sub    %eax,%edx
  800f05:	89 d0                	mov    %edx,%eax
  800f07:	c1 e0 02             	shl    $0x2,%eax
  800f0a:	01 d0                	add    %edx,%eax
  800f0c:	01 c0                	add    %eax,%eax
  800f0e:	29 c1                	sub    %eax,%ecx
  800f10:	89 ca                	mov    %ecx,%edx
  800f12:	85 d2                	test   %edx,%edx
  800f14:	75 9c                	jne    800eb2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f20:	48                   	dec    %eax
  800f21:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f24:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f28:	74 3d                	je     800f67 <ltostr+0xe2>
		start = 1 ;
  800f2a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f31:	eb 34                	jmp    800f67 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f39:	01 d0                	add    %edx,%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f46:	01 c2                	add    %eax,%edx
  800f48:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	01 c8                	add    %ecx,%eax
  800f50:	8a 00                	mov    (%eax),%al
  800f52:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f54:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	01 c2                	add    %eax,%edx
  800f5c:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f5f:	88 02                	mov    %al,(%edx)
		start++ ;
  800f61:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f64:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f6a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f6d:	7c c4                	jl     800f33 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f6f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f75:	01 d0                	add    %edx,%eax
  800f77:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f7a:	90                   	nop
  800f7b:	c9                   	leave  
  800f7c:	c3                   	ret    

00800f7d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f7d:	55                   	push   %ebp
  800f7e:	89 e5                	mov    %esp,%ebp
  800f80:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f83:	ff 75 08             	pushl  0x8(%ebp)
  800f86:	e8 54 fa ff ff       	call   8009df <strlen>
  800f8b:	83 c4 04             	add    $0x4,%esp
  800f8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f91:	ff 75 0c             	pushl  0xc(%ebp)
  800f94:	e8 46 fa ff ff       	call   8009df <strlen>
  800f99:	83 c4 04             	add    $0x4,%esp
  800f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800fa6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fad:	eb 17                	jmp    800fc6 <strcconcat+0x49>
		final[s] = str1[s] ;
  800faf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb5:	01 c2                	add    %eax,%edx
  800fb7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	01 c8                	add    %ecx,%eax
  800fbf:	8a 00                	mov    (%eax),%al
  800fc1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fc3:	ff 45 fc             	incl   -0x4(%ebp)
  800fc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fcc:	7c e1                	jl     800faf <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fd5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fdc:	eb 1f                	jmp    800ffd <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe1:	8d 50 01             	lea    0x1(%eax),%edx
  800fe4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fe7:	89 c2                	mov    %eax,%edx
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	01 c2                	add    %eax,%edx
  800fee:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff4:	01 c8                	add    %ecx,%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ffa:	ff 45 f8             	incl   -0x8(%ebp)
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801000:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801003:	7c d9                	jl     800fde <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801005:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801008:	8b 45 10             	mov    0x10(%ebp),%eax
  80100b:	01 d0                	add    %edx,%eax
  80100d:	c6 00 00             	movb   $0x0,(%eax)
}
  801010:	90                   	nop
  801011:	c9                   	leave  
  801012:	c3                   	ret    

00801013 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801013:	55                   	push   %ebp
  801014:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801016:	8b 45 14             	mov    0x14(%ebp),%eax
  801019:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80101f:	8b 45 14             	mov    0x14(%ebp),%eax
  801022:	8b 00                	mov    (%eax),%eax
  801024:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80102b:	8b 45 10             	mov    0x10(%ebp),%eax
  80102e:	01 d0                	add    %edx,%eax
  801030:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801036:	eb 0c                	jmp    801044 <strsplit+0x31>
			*string++ = 0;
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
  80103b:	8d 50 01             	lea    0x1(%eax),%edx
  80103e:	89 55 08             	mov    %edx,0x8(%ebp)
  801041:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	84 c0                	test   %al,%al
  80104b:	74 18                	je     801065 <strsplit+0x52>
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	0f be c0             	movsbl %al,%eax
  801055:	50                   	push   %eax
  801056:	ff 75 0c             	pushl  0xc(%ebp)
  801059:	e8 13 fb ff ff       	call   800b71 <strchr>
  80105e:	83 c4 08             	add    $0x8,%esp
  801061:	85 c0                	test   %eax,%eax
  801063:	75 d3                	jne    801038 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801065:	8b 45 08             	mov    0x8(%ebp),%eax
  801068:	8a 00                	mov    (%eax),%al
  80106a:	84 c0                	test   %al,%al
  80106c:	74 5a                	je     8010c8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80106e:	8b 45 14             	mov    0x14(%ebp),%eax
  801071:	8b 00                	mov    (%eax),%eax
  801073:	83 f8 0f             	cmp    $0xf,%eax
  801076:	75 07                	jne    80107f <strsplit+0x6c>
		{
			return 0;
  801078:	b8 00 00 00 00       	mov    $0x0,%eax
  80107d:	eb 66                	jmp    8010e5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80107f:	8b 45 14             	mov    0x14(%ebp),%eax
  801082:	8b 00                	mov    (%eax),%eax
  801084:	8d 48 01             	lea    0x1(%eax),%ecx
  801087:	8b 55 14             	mov    0x14(%ebp),%edx
  80108a:	89 0a                	mov    %ecx,(%edx)
  80108c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801093:	8b 45 10             	mov    0x10(%ebp),%eax
  801096:	01 c2                	add    %eax,%edx
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80109d:	eb 03                	jmp    8010a2 <strsplit+0x8f>
			string++;
  80109f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	84 c0                	test   %al,%al
  8010a9:	74 8b                	je     801036 <strsplit+0x23>
  8010ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ae:	8a 00                	mov    (%eax),%al
  8010b0:	0f be c0             	movsbl %al,%eax
  8010b3:	50                   	push   %eax
  8010b4:	ff 75 0c             	pushl  0xc(%ebp)
  8010b7:	e8 b5 fa ff ff       	call   800b71 <strchr>
  8010bc:	83 c4 08             	add    $0x8,%esp
  8010bf:	85 c0                	test   %eax,%eax
  8010c1:	74 dc                	je     80109f <strsplit+0x8c>
			string++;
	}
  8010c3:	e9 6e ff ff ff       	jmp    801036 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010c8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8010cc:	8b 00                	mov    (%eax),%eax
  8010ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d8:	01 d0                	add    %edx,%eax
  8010da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010e0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010e5:	c9                   	leave  
  8010e6:	c3                   	ret    

008010e7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8010e7:	55                   	push   %ebp
  8010e8:	89 e5                	mov    %esp,%ebp
  8010ea:	57                   	push   %edi
  8010eb:	56                   	push   %esi
  8010ec:	53                   	push   %ebx
  8010ed:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8010f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010fc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010ff:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801102:	cd 30                	int    $0x30
  801104:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801107:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80110a:	83 c4 10             	add    $0x10,%esp
  80110d:	5b                   	pop    %ebx
  80110e:	5e                   	pop    %esi
  80110f:	5f                   	pop    %edi
  801110:	5d                   	pop    %ebp
  801111:	c3                   	ret    

00801112 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
  801115:	83 ec 04             	sub    $0x4,%esp
  801118:	8b 45 10             	mov    0x10(%ebp),%eax
  80111b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80111e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	6a 00                	push   $0x0
  801127:	6a 00                	push   $0x0
  801129:	52                   	push   %edx
  80112a:	ff 75 0c             	pushl  0xc(%ebp)
  80112d:	50                   	push   %eax
  80112e:	6a 00                	push   $0x0
  801130:	e8 b2 ff ff ff       	call   8010e7 <syscall>
  801135:	83 c4 18             	add    $0x18,%esp
}
  801138:	90                   	nop
  801139:	c9                   	leave  
  80113a:	c3                   	ret    

0080113b <sys_cgetc>:

int
sys_cgetc(void)
{
  80113b:	55                   	push   %ebp
  80113c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80113e:	6a 00                	push   $0x0
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	6a 00                	push   $0x0
  801148:	6a 01                	push   $0x1
  80114a:	e8 98 ff ff ff       	call   8010e7 <syscall>
  80114f:	83 c4 18             	add    $0x18,%esp
}
  801152:	c9                   	leave  
  801153:	c3                   	ret    

00801154 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	6a 00                	push   $0x0
  80115c:	6a 00                	push   $0x0
  80115e:	6a 00                	push   $0x0
  801160:	6a 00                	push   $0x0
  801162:	50                   	push   %eax
  801163:	6a 05                	push   $0x5
  801165:	e8 7d ff ff ff       	call   8010e7 <syscall>
  80116a:	83 c4 18             	add    $0x18,%esp
}
  80116d:	c9                   	leave  
  80116e:	c3                   	ret    

0080116f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80116f:	55                   	push   %ebp
  801170:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801172:	6a 00                	push   $0x0
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 02                	push   $0x2
  80117e:	e8 64 ff ff ff       	call   8010e7 <syscall>
  801183:	83 c4 18             	add    $0x18,%esp
}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 03                	push   $0x3
  801197:	e8 4b ff ff ff       	call   8010e7 <syscall>
  80119c:	83 c4 18             	add    $0x18,%esp
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 04                	push   $0x4
  8011b0:	e8 32 ff ff ff       	call   8010e7 <syscall>
  8011b5:	83 c4 18             	add    $0x18,%esp
}
  8011b8:	c9                   	leave  
  8011b9:	c3                   	ret    

008011ba <sys_env_exit>:


void sys_env_exit(void)
{
  8011ba:	55                   	push   %ebp
  8011bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 06                	push   $0x6
  8011c9:	e8 19 ff ff ff       	call   8010e7 <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	90                   	nop
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8011d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	52                   	push   %edx
  8011e4:	50                   	push   %eax
  8011e5:	6a 07                	push   $0x7
  8011e7:	e8 fb fe ff ff       	call   8010e7 <syscall>
  8011ec:	83 c4 18             	add    $0x18,%esp
}
  8011ef:	c9                   	leave  
  8011f0:	c3                   	ret    

008011f1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8011f1:	55                   	push   %ebp
  8011f2:	89 e5                	mov    %esp,%ebp
  8011f4:	56                   	push   %esi
  8011f5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011f6:	8b 75 18             	mov    0x18(%ebp),%esi
  8011f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	56                   	push   %esi
  801206:	53                   	push   %ebx
  801207:	51                   	push   %ecx
  801208:	52                   	push   %edx
  801209:	50                   	push   %eax
  80120a:	6a 08                	push   $0x8
  80120c:	e8 d6 fe ff ff       	call   8010e7 <syscall>
  801211:	83 c4 18             	add    $0x18,%esp
}
  801214:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801217:	5b                   	pop    %ebx
  801218:	5e                   	pop    %esi
  801219:	5d                   	pop    %ebp
  80121a:	c3                   	ret    

0080121b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80121b:	55                   	push   %ebp
  80121c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80121e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	52                   	push   %edx
  80122b:	50                   	push   %eax
  80122c:	6a 09                	push   $0x9
  80122e:	e8 b4 fe ff ff       	call   8010e7 <syscall>
  801233:	83 c4 18             	add    $0x18,%esp
}
  801236:	c9                   	leave  
  801237:	c3                   	ret    

00801238 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801238:	55                   	push   %ebp
  801239:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	ff 75 0c             	pushl  0xc(%ebp)
  801244:	ff 75 08             	pushl  0x8(%ebp)
  801247:	6a 0a                	push   $0xa
  801249:	e8 99 fe ff ff       	call   8010e7 <syscall>
  80124e:	83 c4 18             	add    $0x18,%esp
}
  801251:	c9                   	leave  
  801252:	c3                   	ret    

00801253 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801253:	55                   	push   %ebp
  801254:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801256:	6a 00                	push   $0x0
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 0b                	push   $0xb
  801262:	e8 80 fe ff ff       	call   8010e7 <syscall>
  801267:	83 c4 18             	add    $0x18,%esp
}
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 0c                	push   $0xc
  80127b:	e8 67 fe ff ff       	call   8010e7 <syscall>
  801280:	83 c4 18             	add    $0x18,%esp
}
  801283:	c9                   	leave  
  801284:	c3                   	ret    

00801285 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801285:	55                   	push   %ebp
  801286:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 0d                	push   $0xd
  801294:	e8 4e fe ff ff       	call   8010e7 <syscall>
  801299:	83 c4 18             	add    $0x18,%esp
}
  80129c:	c9                   	leave  
  80129d:	c3                   	ret    

0080129e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8012a1:	6a 00                	push   $0x0
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	ff 75 0c             	pushl  0xc(%ebp)
  8012aa:	ff 75 08             	pushl  0x8(%ebp)
  8012ad:	6a 11                	push   $0x11
  8012af:	e8 33 fe ff ff       	call   8010e7 <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
	return;
  8012b7:	90                   	nop
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	ff 75 0c             	pushl  0xc(%ebp)
  8012c6:	ff 75 08             	pushl  0x8(%ebp)
  8012c9:	6a 12                	push   $0x12
  8012cb:	e8 17 fe ff ff       	call   8010e7 <syscall>
  8012d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8012d3:	90                   	nop
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 0e                	push   $0xe
  8012e5:	e8 fd fd ff ff       	call   8010e7 <syscall>
  8012ea:	83 c4 18             	add    $0x18,%esp
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	ff 75 08             	pushl  0x8(%ebp)
  8012fd:	6a 0f                	push   $0xf
  8012ff:	e8 e3 fd ff ff       	call   8010e7 <syscall>
  801304:	83 c4 18             	add    $0x18,%esp
}
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 10                	push   $0x10
  801318:	e8 ca fd ff ff       	call   8010e7 <syscall>
  80131d:	83 c4 18             	add    $0x18,%esp
}
  801320:	90                   	nop
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 14                	push   $0x14
  801332:	e8 b0 fd ff ff       	call   8010e7 <syscall>
  801337:	83 c4 18             	add    $0x18,%esp
}
  80133a:	90                   	nop
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 15                	push   $0x15
  80134c:	e8 96 fd ff ff       	call   8010e7 <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	90                   	nop
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <sys_cputc>:


void
sys_cputc(const char c)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
  80135a:	83 ec 04             	sub    $0x4,%esp
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801363:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	50                   	push   %eax
  801370:	6a 16                	push   $0x16
  801372:	e8 70 fd ff ff       	call   8010e7 <syscall>
  801377:	83 c4 18             	add    $0x18,%esp
}
  80137a:	90                   	nop
  80137b:	c9                   	leave  
  80137c:	c3                   	ret    

0080137d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80137d:	55                   	push   %ebp
  80137e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	6a 17                	push   $0x17
  80138c:	e8 56 fd ff ff       	call   8010e7 <syscall>
  801391:	83 c4 18             	add    $0x18,%esp
}
  801394:	90                   	nop
  801395:	c9                   	leave  
  801396:	c3                   	ret    

00801397 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801397:	55                   	push   %ebp
  801398:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	ff 75 0c             	pushl  0xc(%ebp)
  8013a6:	50                   	push   %eax
  8013a7:	6a 18                	push   $0x18
  8013a9:	e8 39 fd ff ff       	call   8010e7 <syscall>
  8013ae:	83 c4 18             	add    $0x18,%esp
}
  8013b1:	c9                   	leave  
  8013b2:	c3                   	ret    

008013b3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	52                   	push   %edx
  8013c3:	50                   	push   %eax
  8013c4:	6a 1b                	push   $0x1b
  8013c6:	e8 1c fd ff ff       	call   8010e7 <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	52                   	push   %edx
  8013e0:	50                   	push   %eax
  8013e1:	6a 19                	push   $0x19
  8013e3:	e8 ff fc ff ff       	call   8010e7 <syscall>
  8013e8:	83 c4 18             	add    $0x18,%esp
}
  8013eb:	90                   	nop
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	52                   	push   %edx
  8013fe:	50                   	push   %eax
  8013ff:	6a 1a                	push   $0x1a
  801401:	e8 e1 fc ff ff       	call   8010e7 <syscall>
  801406:	83 c4 18             	add    $0x18,%esp
}
  801409:	90                   	nop
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
  80140f:	83 ec 04             	sub    $0x4,%esp
  801412:	8b 45 10             	mov    0x10(%ebp),%eax
  801415:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801418:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80141b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	6a 00                	push   $0x0
  801424:	51                   	push   %ecx
  801425:	52                   	push   %edx
  801426:	ff 75 0c             	pushl  0xc(%ebp)
  801429:	50                   	push   %eax
  80142a:	6a 1c                	push   $0x1c
  80142c:	e8 b6 fc ff ff       	call   8010e7 <syscall>
  801431:	83 c4 18             	add    $0x18,%esp
}
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801439:	8b 55 0c             	mov    0xc(%ebp),%edx
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	52                   	push   %edx
  801446:	50                   	push   %eax
  801447:	6a 1d                	push   $0x1d
  801449:	e8 99 fc ff ff       	call   8010e7 <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801456:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801459:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	51                   	push   %ecx
  801464:	52                   	push   %edx
  801465:	50                   	push   %eax
  801466:	6a 1e                	push   $0x1e
  801468:	e8 7a fc ff ff       	call   8010e7 <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
}
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801475:	8b 55 0c             	mov    0xc(%ebp),%edx
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	52                   	push   %edx
  801482:	50                   	push   %eax
  801483:	6a 1f                	push   $0x1f
  801485:	e8 5d fc ff ff       	call   8010e7 <syscall>
  80148a:	83 c4 18             	add    $0x18,%esp
}
  80148d:	c9                   	leave  
  80148e:	c3                   	ret    

0080148f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80148f:	55                   	push   %ebp
  801490:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 20                	push   $0x20
  80149e:	e8 44 fc ff ff       	call   8010e7 <syscall>
  8014a3:	83 c4 18             	add    $0x18,%esp
}
  8014a6:	c9                   	leave  
  8014a7:	c3                   	ret    

008014a8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	6a 00                	push   $0x0
  8014b0:	ff 75 14             	pushl  0x14(%ebp)
  8014b3:	ff 75 10             	pushl  0x10(%ebp)
  8014b6:	ff 75 0c             	pushl  0xc(%ebp)
  8014b9:	50                   	push   %eax
  8014ba:	6a 21                	push   $0x21
  8014bc:	e8 26 fc ff ff       	call   8010e7 <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	50                   	push   %eax
  8014d5:	6a 22                	push   $0x22
  8014d7:	e8 0b fc ff ff       	call   8010e7 <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	90                   	nop
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	50                   	push   %eax
  8014f1:	6a 23                	push   $0x23
  8014f3:	e8 ef fb ff ff       	call   8010e7 <syscall>
  8014f8:	83 c4 18             	add    $0x18,%esp
}
  8014fb:	90                   	nop
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
  801501:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801504:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801507:	8d 50 04             	lea    0x4(%eax),%edx
  80150a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	52                   	push   %edx
  801514:	50                   	push   %eax
  801515:	6a 24                	push   $0x24
  801517:	e8 cb fb ff ff       	call   8010e7 <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
	return result;
  80151f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801522:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801525:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801528:	89 01                	mov    %eax,(%ecx)
  80152a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	c9                   	leave  
  801531:	c2 04 00             	ret    $0x4

00801534 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	ff 75 10             	pushl  0x10(%ebp)
  80153e:	ff 75 0c             	pushl  0xc(%ebp)
  801541:	ff 75 08             	pushl  0x8(%ebp)
  801544:	6a 13                	push   $0x13
  801546:	e8 9c fb ff ff       	call   8010e7 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
	return ;
  80154e:	90                   	nop
}
  80154f:	c9                   	leave  
  801550:	c3                   	ret    

00801551 <sys_rcr2>:
uint32 sys_rcr2()
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 25                	push   $0x25
  801560:	e8 82 fb ff ff       	call   8010e7 <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
}
  801568:	c9                   	leave  
  801569:	c3                   	ret    

0080156a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80156a:	55                   	push   %ebp
  80156b:	89 e5                	mov    %esp,%ebp
  80156d:	83 ec 04             	sub    $0x4,%esp
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801576:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	50                   	push   %eax
  801583:	6a 26                	push   $0x26
  801585:	e8 5d fb ff ff       	call   8010e7 <syscall>
  80158a:	83 c4 18             	add    $0x18,%esp
	return ;
  80158d:	90                   	nop
}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <rsttst>:
void rsttst()
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 28                	push   $0x28
  80159f:	e8 43 fb ff ff       	call   8010e7 <syscall>
  8015a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8015a7:	90                   	nop
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 04             	sub    $0x4,%esp
  8015b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8015b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8015b6:	8b 55 18             	mov    0x18(%ebp),%edx
  8015b9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015bd:	52                   	push   %edx
  8015be:	50                   	push   %eax
  8015bf:	ff 75 10             	pushl  0x10(%ebp)
  8015c2:	ff 75 0c             	pushl  0xc(%ebp)
  8015c5:	ff 75 08             	pushl  0x8(%ebp)
  8015c8:	6a 27                	push   $0x27
  8015ca:	e8 18 fb ff ff       	call   8010e7 <syscall>
  8015cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d2:	90                   	nop
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <chktst>:
void chktst(uint32 n)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	ff 75 08             	pushl  0x8(%ebp)
  8015e3:	6a 29                	push   $0x29
  8015e5:	e8 fd fa ff ff       	call   8010e7 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ed:	90                   	nop
}
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <inctst>:

void inctst()
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 2a                	push   $0x2a
  8015ff:	e8 e3 fa ff ff       	call   8010e7 <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
	return ;
  801607:	90                   	nop
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <gettst>:
uint32 gettst()
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 2b                	push   $0x2b
  801619:	e8 c9 fa ff ff       	call   8010e7 <syscall>
  80161e:	83 c4 18             	add    $0x18,%esp
}
  801621:	c9                   	leave  
  801622:	c3                   	ret    

00801623 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801623:	55                   	push   %ebp
  801624:	89 e5                	mov    %esp,%ebp
  801626:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 2c                	push   $0x2c
  801635:	e8 ad fa ff ff       	call   8010e7 <syscall>
  80163a:	83 c4 18             	add    $0x18,%esp
  80163d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801640:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801644:	75 07                	jne    80164d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801646:	b8 01 00 00 00       	mov    $0x1,%eax
  80164b:	eb 05                	jmp    801652 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80164d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
  801657:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 2c                	push   $0x2c
  801666:	e8 7c fa ff ff       	call   8010e7 <syscall>
  80166b:	83 c4 18             	add    $0x18,%esp
  80166e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801671:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801675:	75 07                	jne    80167e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801677:	b8 01 00 00 00       	mov    $0x1,%eax
  80167c:	eb 05                	jmp    801683 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80167e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
  801688:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 2c                	push   $0x2c
  801697:	e8 4b fa ff ff       	call   8010e7 <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
  80169f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8016a2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8016a6:	75 07                	jne    8016af <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8016a8:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ad:	eb 05                	jmp    8016b4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8016af:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016b4:	c9                   	leave  
  8016b5:	c3                   	ret    

008016b6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8016b6:	55                   	push   %ebp
  8016b7:	89 e5                	mov    %esp,%ebp
  8016b9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 2c                	push   $0x2c
  8016c8:	e8 1a fa ff ff       	call   8010e7 <syscall>
  8016cd:	83 c4 18             	add    $0x18,%esp
  8016d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8016d3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8016d7:	75 07                	jne    8016e0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8016d9:	b8 01 00 00 00       	mov    $0x1,%eax
  8016de:	eb 05                	jmp    8016e5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8016e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	ff 75 08             	pushl  0x8(%ebp)
  8016f5:	6a 2d                	push   $0x2d
  8016f7:	e8 eb f9 ff ff       	call   8010e7 <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ff:	90                   	nop
}
  801700:	c9                   	leave  
  801701:	c3                   	ret    

00801702 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
  801705:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801706:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801709:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80170c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	6a 00                	push   $0x0
  801714:	53                   	push   %ebx
  801715:	51                   	push   %ecx
  801716:	52                   	push   %edx
  801717:	50                   	push   %eax
  801718:	6a 2e                	push   $0x2e
  80171a:	e8 c8 f9 ff ff       	call   8010e7 <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
}
  801722:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80172a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172d:	8b 45 08             	mov    0x8(%ebp),%eax
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	52                   	push   %edx
  801737:	50                   	push   %eax
  801738:	6a 2f                	push   $0x2f
  80173a:	e8 a8 f9 ff ff       	call   8010e7 <syscall>
  80173f:	83 c4 18             	add    $0x18,%esp
}
  801742:	c9                   	leave  
  801743:	c3                   	ret    

00801744 <__udivdi3>:
  801744:	55                   	push   %ebp
  801745:	57                   	push   %edi
  801746:	56                   	push   %esi
  801747:	53                   	push   %ebx
  801748:	83 ec 1c             	sub    $0x1c,%esp
  80174b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80174f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801753:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801757:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80175b:	89 ca                	mov    %ecx,%edx
  80175d:	89 f8                	mov    %edi,%eax
  80175f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801763:	85 f6                	test   %esi,%esi
  801765:	75 2d                	jne    801794 <__udivdi3+0x50>
  801767:	39 cf                	cmp    %ecx,%edi
  801769:	77 65                	ja     8017d0 <__udivdi3+0x8c>
  80176b:	89 fd                	mov    %edi,%ebp
  80176d:	85 ff                	test   %edi,%edi
  80176f:	75 0b                	jne    80177c <__udivdi3+0x38>
  801771:	b8 01 00 00 00       	mov    $0x1,%eax
  801776:	31 d2                	xor    %edx,%edx
  801778:	f7 f7                	div    %edi
  80177a:	89 c5                	mov    %eax,%ebp
  80177c:	31 d2                	xor    %edx,%edx
  80177e:	89 c8                	mov    %ecx,%eax
  801780:	f7 f5                	div    %ebp
  801782:	89 c1                	mov    %eax,%ecx
  801784:	89 d8                	mov    %ebx,%eax
  801786:	f7 f5                	div    %ebp
  801788:	89 cf                	mov    %ecx,%edi
  80178a:	89 fa                	mov    %edi,%edx
  80178c:	83 c4 1c             	add    $0x1c,%esp
  80178f:	5b                   	pop    %ebx
  801790:	5e                   	pop    %esi
  801791:	5f                   	pop    %edi
  801792:	5d                   	pop    %ebp
  801793:	c3                   	ret    
  801794:	39 ce                	cmp    %ecx,%esi
  801796:	77 28                	ja     8017c0 <__udivdi3+0x7c>
  801798:	0f bd fe             	bsr    %esi,%edi
  80179b:	83 f7 1f             	xor    $0x1f,%edi
  80179e:	75 40                	jne    8017e0 <__udivdi3+0x9c>
  8017a0:	39 ce                	cmp    %ecx,%esi
  8017a2:	72 0a                	jb     8017ae <__udivdi3+0x6a>
  8017a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017a8:	0f 87 9e 00 00 00    	ja     80184c <__udivdi3+0x108>
  8017ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8017b3:	89 fa                	mov    %edi,%edx
  8017b5:	83 c4 1c             	add    $0x1c,%esp
  8017b8:	5b                   	pop    %ebx
  8017b9:	5e                   	pop    %esi
  8017ba:	5f                   	pop    %edi
  8017bb:	5d                   	pop    %ebp
  8017bc:	c3                   	ret    
  8017bd:	8d 76 00             	lea    0x0(%esi),%esi
  8017c0:	31 ff                	xor    %edi,%edi
  8017c2:	31 c0                	xor    %eax,%eax
  8017c4:	89 fa                	mov    %edi,%edx
  8017c6:	83 c4 1c             	add    $0x1c,%esp
  8017c9:	5b                   	pop    %ebx
  8017ca:	5e                   	pop    %esi
  8017cb:	5f                   	pop    %edi
  8017cc:	5d                   	pop    %ebp
  8017cd:	c3                   	ret    
  8017ce:	66 90                	xchg   %ax,%ax
  8017d0:	89 d8                	mov    %ebx,%eax
  8017d2:	f7 f7                	div    %edi
  8017d4:	31 ff                	xor    %edi,%edi
  8017d6:	89 fa                	mov    %edi,%edx
  8017d8:	83 c4 1c             	add    $0x1c,%esp
  8017db:	5b                   	pop    %ebx
  8017dc:	5e                   	pop    %esi
  8017dd:	5f                   	pop    %edi
  8017de:	5d                   	pop    %ebp
  8017df:	c3                   	ret    
  8017e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017e5:	89 eb                	mov    %ebp,%ebx
  8017e7:	29 fb                	sub    %edi,%ebx
  8017e9:	89 f9                	mov    %edi,%ecx
  8017eb:	d3 e6                	shl    %cl,%esi
  8017ed:	89 c5                	mov    %eax,%ebp
  8017ef:	88 d9                	mov    %bl,%cl
  8017f1:	d3 ed                	shr    %cl,%ebp
  8017f3:	89 e9                	mov    %ebp,%ecx
  8017f5:	09 f1                	or     %esi,%ecx
  8017f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017fb:	89 f9                	mov    %edi,%ecx
  8017fd:	d3 e0                	shl    %cl,%eax
  8017ff:	89 c5                	mov    %eax,%ebp
  801801:	89 d6                	mov    %edx,%esi
  801803:	88 d9                	mov    %bl,%cl
  801805:	d3 ee                	shr    %cl,%esi
  801807:	89 f9                	mov    %edi,%ecx
  801809:	d3 e2                	shl    %cl,%edx
  80180b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80180f:	88 d9                	mov    %bl,%cl
  801811:	d3 e8                	shr    %cl,%eax
  801813:	09 c2                	or     %eax,%edx
  801815:	89 d0                	mov    %edx,%eax
  801817:	89 f2                	mov    %esi,%edx
  801819:	f7 74 24 0c          	divl   0xc(%esp)
  80181d:	89 d6                	mov    %edx,%esi
  80181f:	89 c3                	mov    %eax,%ebx
  801821:	f7 e5                	mul    %ebp
  801823:	39 d6                	cmp    %edx,%esi
  801825:	72 19                	jb     801840 <__udivdi3+0xfc>
  801827:	74 0b                	je     801834 <__udivdi3+0xf0>
  801829:	89 d8                	mov    %ebx,%eax
  80182b:	31 ff                	xor    %edi,%edi
  80182d:	e9 58 ff ff ff       	jmp    80178a <__udivdi3+0x46>
  801832:	66 90                	xchg   %ax,%ax
  801834:	8b 54 24 08          	mov    0x8(%esp),%edx
  801838:	89 f9                	mov    %edi,%ecx
  80183a:	d3 e2                	shl    %cl,%edx
  80183c:	39 c2                	cmp    %eax,%edx
  80183e:	73 e9                	jae    801829 <__udivdi3+0xe5>
  801840:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801843:	31 ff                	xor    %edi,%edi
  801845:	e9 40 ff ff ff       	jmp    80178a <__udivdi3+0x46>
  80184a:	66 90                	xchg   %ax,%ax
  80184c:	31 c0                	xor    %eax,%eax
  80184e:	e9 37 ff ff ff       	jmp    80178a <__udivdi3+0x46>
  801853:	90                   	nop

00801854 <__umoddi3>:
  801854:	55                   	push   %ebp
  801855:	57                   	push   %edi
  801856:	56                   	push   %esi
  801857:	53                   	push   %ebx
  801858:	83 ec 1c             	sub    $0x1c,%esp
  80185b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80185f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801863:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801867:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80186b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80186f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801873:	89 f3                	mov    %esi,%ebx
  801875:	89 fa                	mov    %edi,%edx
  801877:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80187b:	89 34 24             	mov    %esi,(%esp)
  80187e:	85 c0                	test   %eax,%eax
  801880:	75 1a                	jne    80189c <__umoddi3+0x48>
  801882:	39 f7                	cmp    %esi,%edi
  801884:	0f 86 a2 00 00 00    	jbe    80192c <__umoddi3+0xd8>
  80188a:	89 c8                	mov    %ecx,%eax
  80188c:	89 f2                	mov    %esi,%edx
  80188e:	f7 f7                	div    %edi
  801890:	89 d0                	mov    %edx,%eax
  801892:	31 d2                	xor    %edx,%edx
  801894:	83 c4 1c             	add    $0x1c,%esp
  801897:	5b                   	pop    %ebx
  801898:	5e                   	pop    %esi
  801899:	5f                   	pop    %edi
  80189a:	5d                   	pop    %ebp
  80189b:	c3                   	ret    
  80189c:	39 f0                	cmp    %esi,%eax
  80189e:	0f 87 ac 00 00 00    	ja     801950 <__umoddi3+0xfc>
  8018a4:	0f bd e8             	bsr    %eax,%ebp
  8018a7:	83 f5 1f             	xor    $0x1f,%ebp
  8018aa:	0f 84 ac 00 00 00    	je     80195c <__umoddi3+0x108>
  8018b0:	bf 20 00 00 00       	mov    $0x20,%edi
  8018b5:	29 ef                	sub    %ebp,%edi
  8018b7:	89 fe                	mov    %edi,%esi
  8018b9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018bd:	89 e9                	mov    %ebp,%ecx
  8018bf:	d3 e0                	shl    %cl,%eax
  8018c1:	89 d7                	mov    %edx,%edi
  8018c3:	89 f1                	mov    %esi,%ecx
  8018c5:	d3 ef                	shr    %cl,%edi
  8018c7:	09 c7                	or     %eax,%edi
  8018c9:	89 e9                	mov    %ebp,%ecx
  8018cb:	d3 e2                	shl    %cl,%edx
  8018cd:	89 14 24             	mov    %edx,(%esp)
  8018d0:	89 d8                	mov    %ebx,%eax
  8018d2:	d3 e0                	shl    %cl,%eax
  8018d4:	89 c2                	mov    %eax,%edx
  8018d6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018da:	d3 e0                	shl    %cl,%eax
  8018dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018e0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018e4:	89 f1                	mov    %esi,%ecx
  8018e6:	d3 e8                	shr    %cl,%eax
  8018e8:	09 d0                	or     %edx,%eax
  8018ea:	d3 eb                	shr    %cl,%ebx
  8018ec:	89 da                	mov    %ebx,%edx
  8018ee:	f7 f7                	div    %edi
  8018f0:	89 d3                	mov    %edx,%ebx
  8018f2:	f7 24 24             	mull   (%esp)
  8018f5:	89 c6                	mov    %eax,%esi
  8018f7:	89 d1                	mov    %edx,%ecx
  8018f9:	39 d3                	cmp    %edx,%ebx
  8018fb:	0f 82 87 00 00 00    	jb     801988 <__umoddi3+0x134>
  801901:	0f 84 91 00 00 00    	je     801998 <__umoddi3+0x144>
  801907:	8b 54 24 04          	mov    0x4(%esp),%edx
  80190b:	29 f2                	sub    %esi,%edx
  80190d:	19 cb                	sbb    %ecx,%ebx
  80190f:	89 d8                	mov    %ebx,%eax
  801911:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801915:	d3 e0                	shl    %cl,%eax
  801917:	89 e9                	mov    %ebp,%ecx
  801919:	d3 ea                	shr    %cl,%edx
  80191b:	09 d0                	or     %edx,%eax
  80191d:	89 e9                	mov    %ebp,%ecx
  80191f:	d3 eb                	shr    %cl,%ebx
  801921:	89 da                	mov    %ebx,%edx
  801923:	83 c4 1c             	add    $0x1c,%esp
  801926:	5b                   	pop    %ebx
  801927:	5e                   	pop    %esi
  801928:	5f                   	pop    %edi
  801929:	5d                   	pop    %ebp
  80192a:	c3                   	ret    
  80192b:	90                   	nop
  80192c:	89 fd                	mov    %edi,%ebp
  80192e:	85 ff                	test   %edi,%edi
  801930:	75 0b                	jne    80193d <__umoddi3+0xe9>
  801932:	b8 01 00 00 00       	mov    $0x1,%eax
  801937:	31 d2                	xor    %edx,%edx
  801939:	f7 f7                	div    %edi
  80193b:	89 c5                	mov    %eax,%ebp
  80193d:	89 f0                	mov    %esi,%eax
  80193f:	31 d2                	xor    %edx,%edx
  801941:	f7 f5                	div    %ebp
  801943:	89 c8                	mov    %ecx,%eax
  801945:	f7 f5                	div    %ebp
  801947:	89 d0                	mov    %edx,%eax
  801949:	e9 44 ff ff ff       	jmp    801892 <__umoddi3+0x3e>
  80194e:	66 90                	xchg   %ax,%ax
  801950:	89 c8                	mov    %ecx,%eax
  801952:	89 f2                	mov    %esi,%edx
  801954:	83 c4 1c             	add    $0x1c,%esp
  801957:	5b                   	pop    %ebx
  801958:	5e                   	pop    %esi
  801959:	5f                   	pop    %edi
  80195a:	5d                   	pop    %ebp
  80195b:	c3                   	ret    
  80195c:	3b 04 24             	cmp    (%esp),%eax
  80195f:	72 06                	jb     801967 <__umoddi3+0x113>
  801961:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801965:	77 0f                	ja     801976 <__umoddi3+0x122>
  801967:	89 f2                	mov    %esi,%edx
  801969:	29 f9                	sub    %edi,%ecx
  80196b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80196f:	89 14 24             	mov    %edx,(%esp)
  801972:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801976:	8b 44 24 04          	mov    0x4(%esp),%eax
  80197a:	8b 14 24             	mov    (%esp),%edx
  80197d:	83 c4 1c             	add    $0x1c,%esp
  801980:	5b                   	pop    %ebx
  801981:	5e                   	pop    %esi
  801982:	5f                   	pop    %edi
  801983:	5d                   	pop    %ebp
  801984:	c3                   	ret    
  801985:	8d 76 00             	lea    0x0(%esi),%esi
  801988:	2b 04 24             	sub    (%esp),%eax
  80198b:	19 fa                	sbb    %edi,%edx
  80198d:	89 d1                	mov    %edx,%ecx
  80198f:	89 c6                	mov    %eax,%esi
  801991:	e9 71 ff ff ff       	jmp    801907 <__umoddi3+0xb3>
  801996:	66 90                	xchg   %ax,%ax
  801998:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80199c:	72 ea                	jb     801988 <__umoddi3+0x134>
  80199e:	89 d9                	mov    %ebx,%ecx
  8019a0:	e9 62 ff ff ff       	jmp    801907 <__umoddi3+0xb3>
