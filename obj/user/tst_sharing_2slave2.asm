
obj/user/tst_sharing_2slave2:     file format elf32-i386


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
  800031:	e8 b0 01 00 00       	call   8001e6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Slave program2: Get 2 shared variables, edit the writable one, and attempt to edit the readOnly one
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 23                	jmp    80006f <_main+0x37>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	c1 e2 04             	shl    $0x4,%edx
  80005d:	01 d0                	add    %edx,%eax
  80005f:	8a 40 04             	mov    0x4(%eax),%al
  800062:	84 c0                	test   %al,%al
  800064:	74 06                	je     80006c <_main+0x34>
			{
				fullWS = 0;
  800066:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006a:	eb 12                	jmp    80007e <_main+0x46>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006c:	ff 45 f0             	incl   -0x10(%ebp)
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 50 74             	mov    0x74(%eax),%edx
  800077:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007a:	39 c2                	cmp    %eax,%edx
  80007c:	77 ce                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007e:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800082:	74 14                	je     800098 <_main+0x60>
  800084:	83 ec 04             	sub    $0x4,%esp
  800087:	68 a0 1f 80 00       	push   $0x801fa0
  80008c:	6a 13                	push   $0x13
  80008e:	68 bc 1f 80 00       	push   $0x801fbc
  800093:	e8 93 02 00 00       	call   80032b <_panic>
	}

	int32 parentenvID = sys_getparentenvid();
  800098:	e8 ef 16 00 00       	call   80178c <sys_getparentenvid>
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	uint32 *x, *z;

	//GET: z then x, opposite to creation order (x then y then z)
	//So, addresses here will be different from the OWNER addresses
	sys_disable_interrupt();
  8000a0:	e8 69 18 00 00       	call   80190e <sys_disable_interrupt>
	int freeFrames = sys_calculate_free_frames() ;
  8000a5:	e8 94 17 00 00       	call   80183e <sys_calculate_free_frames>
  8000aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
	z = sget(parentenvID,"z");
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	68 d7 1f 80 00       	push   $0x801fd7
  8000b5:	ff 75 ec             	pushl  -0x14(%ebp)
  8000b8:	e8 67 15 00 00       	call   801624 <sget>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 0 * PAGE_SIZE)) panic("Get(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000c3:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 dc 1f 80 00       	push   $0x801fdc
  8000d4:	6a 1e                	push   $0x1e
  8000d6:	68 bc 1f 80 00       	push   $0x801fbc
  8000db:	e8 4b 02 00 00       	call   80032b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1) panic("Get(): Wrong sharing- make sure that you share the required space in the current user environment using the correct frames (from frames_storage)");
  8000e0:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000e3:	e8 56 17 00 00       	call   80183e <sys_calculate_free_frames>
  8000e8:	29 c3                	sub    %eax,%ebx
  8000ea:	89 d8                	mov    %ebx,%eax
  8000ec:	83 f8 01             	cmp    $0x1,%eax
  8000ef:	74 14                	je     800105 <_main+0xcd>
  8000f1:	83 ec 04             	sub    $0x4,%esp
  8000f4:	68 3c 20 80 00       	push   $0x80203c
  8000f9:	6a 1f                	push   $0x1f
  8000fb:	68 bc 1f 80 00       	push   $0x801fbc
  800100:	e8 26 02 00 00       	call   80032b <_panic>
	sys_enable_interrupt();
  800105:	e8 1e 18 00 00       	call   801928 <sys_enable_interrupt>

	sys_disable_interrupt();
  80010a:	e8 ff 17 00 00       	call   80190e <sys_disable_interrupt>
	freeFrames = sys_calculate_free_frames() ;
  80010f:	e8 2a 17 00 00       	call   80183e <sys_calculate_free_frames>
  800114:	89 45 e8             	mov    %eax,-0x18(%ebp)
	x = sget(parentenvID,"x");
  800117:	83 ec 08             	sub    $0x8,%esp
  80011a:	68 cd 20 80 00       	push   $0x8020cd
  80011f:	ff 75 ec             	pushl  -0x14(%ebp)
  800122:	e8 fd 14 00 00       	call   801624 <sget>
  800127:	83 c4 10             	add    $0x10,%esp
  80012a:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (x != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Get(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  80012d:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 dc 1f 80 00       	push   $0x801fdc
  80013e:	6a 25                	push   $0x25
  800140:	68 bc 1f 80 00       	push   $0x801fbc
  800145:	e8 e1 01 00 00       	call   80032b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Get(): Wrong sharing- make sure that you share the required space in the current user environment using the correct frames (from frames_storage)");
  80014a:	e8 ef 16 00 00       	call   80183e <sys_calculate_free_frames>
  80014f:	89 c2                	mov    %eax,%edx
  800151:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800154:	39 c2                	cmp    %eax,%edx
  800156:	74 14                	je     80016c <_main+0x134>
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	68 3c 20 80 00       	push   $0x80203c
  800160:	6a 26                	push   $0x26
  800162:	68 bc 1f 80 00       	push   $0x801fbc
  800167:	e8 bf 01 00 00       	call   80032b <_panic>
	sys_enable_interrupt();
  80016c:	e8 b7 17 00 00       	call   801928 <sys_enable_interrupt>

	if (*x != 10) panic("Get(): Shared Variable is not created or got correctly") ;
  800171:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800174:	8b 00                	mov    (%eax),%eax
  800176:	83 f8 0a             	cmp    $0xa,%eax
  800179:	74 14                	je     80018f <_main+0x157>
  80017b:	83 ec 04             	sub    $0x4,%esp
  80017e:	68 d0 20 80 00       	push   $0x8020d0
  800183:	6a 29                	push   $0x29
  800185:	68 bc 1f 80 00       	push   $0x801fbc
  80018a:	e8 9c 01 00 00       	call   80032b <_panic>

	//Edit the writable object
	*z = 30;
  80018f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800192:	c7 00 1e 00 00 00    	movl   $0x1e,(%eax)
	if (*z != 30) panic("Get(): Shared Variable is not created or got correctly") ;
  800198:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80019b:	8b 00                	mov    (%eax),%eax
  80019d:	83 f8 1e             	cmp    $0x1e,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 d0 20 80 00       	push   $0x8020d0
  8001aa:	6a 2d                	push   $0x2d
  8001ac:	68 bc 1f 80 00       	push   $0x801fbc
  8001b1:	e8 75 01 00 00       	call   80032b <_panic>

	//Attempt to edit the ReadOnly object, it should panic
	cprintf("Attempt to edit the ReadOnly object @ va = %x\n", x);
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	ff 75 e0             	pushl  -0x20(%ebp)
  8001bc:	68 08 21 80 00       	push   $0x802108
  8001c1:	e8 07 04 00 00       	call   8005cd <cprintf>
  8001c6:	83 c4 10             	add    $0x10,%esp
	*x = 100;
  8001c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001cc:	c7 00 64 00 00 00    	movl   $0x64,(%eax)

	panic("Test FAILED! it should panic early and not reach this line of code") ;
  8001d2:	83 ec 04             	sub    $0x4,%esp
  8001d5:	68 38 21 80 00       	push   $0x802138
  8001da:	6a 33                	push   $0x33
  8001dc:	68 bc 1f 80 00       	push   $0x801fbc
  8001e1:	e8 45 01 00 00       	call   80032b <_panic>

008001e6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001e6:	55                   	push   %ebp
  8001e7:	89 e5                	mov    %esp,%ebp
  8001e9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001ec:	e8 82 15 00 00       	call   801773 <sys_getenvindex>
  8001f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001f7:	89 d0                	mov    %edx,%eax
  8001f9:	c1 e0 03             	shl    $0x3,%eax
  8001fc:	01 d0                	add    %edx,%eax
  8001fe:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800205:	01 c8                	add    %ecx,%eax
  800207:	01 c0                	add    %eax,%eax
  800209:	01 d0                	add    %edx,%eax
  80020b:	01 c0                	add    %eax,%eax
  80020d:	01 d0                	add    %edx,%eax
  80020f:	89 c2                	mov    %eax,%edx
  800211:	c1 e2 05             	shl    $0x5,%edx
  800214:	29 c2                	sub    %eax,%edx
  800216:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80021d:	89 c2                	mov    %eax,%edx
  80021f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800225:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80022a:	a1 20 30 80 00       	mov    0x803020,%eax
  80022f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800235:	84 c0                	test   %al,%al
  800237:	74 0f                	je     800248 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800239:	a1 20 30 80 00       	mov    0x803020,%eax
  80023e:	05 40 3c 01 00       	add    $0x13c40,%eax
  800243:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800248:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80024c:	7e 0a                	jle    800258 <libmain+0x72>
		binaryname = argv[0];
  80024e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800251:	8b 00                	mov    (%eax),%eax
  800253:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800258:	83 ec 08             	sub    $0x8,%esp
  80025b:	ff 75 0c             	pushl  0xc(%ebp)
  80025e:	ff 75 08             	pushl  0x8(%ebp)
  800261:	e8 d2 fd ff ff       	call   800038 <_main>
  800266:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800269:	e8 a0 16 00 00       	call   80190e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	68 94 21 80 00       	push   $0x802194
  800276:	e8 52 03 00 00       	call   8005cd <cprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80027e:	a1 20 30 80 00       	mov    0x803020,%eax
  800283:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800289:	a1 20 30 80 00       	mov    0x803020,%eax
  80028e:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800294:	83 ec 04             	sub    $0x4,%esp
  800297:	52                   	push   %edx
  800298:	50                   	push   %eax
  800299:	68 bc 21 80 00       	push   $0x8021bc
  80029e:	e8 2a 03 00 00       	call   8005cd <cprintf>
  8002a3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8002a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ab:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8002b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b6:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002bc:	83 ec 04             	sub    $0x4,%esp
  8002bf:	52                   	push   %edx
  8002c0:	50                   	push   %eax
  8002c1:	68 e4 21 80 00       	push   $0x8021e4
  8002c6:	e8 02 03 00 00       	call   8005cd <cprintf>
  8002cb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d3:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002d9:	83 ec 08             	sub    $0x8,%esp
  8002dc:	50                   	push   %eax
  8002dd:	68 25 22 80 00       	push   $0x802225
  8002e2:	e8 e6 02 00 00       	call   8005cd <cprintf>
  8002e7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	68 94 21 80 00       	push   $0x802194
  8002f2:	e8 d6 02 00 00       	call   8005cd <cprintf>
  8002f7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002fa:	e8 29 16 00 00       	call   801928 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002ff:	e8 19 00 00 00       	call   80031d <exit>
}
  800304:	90                   	nop
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80030d:	83 ec 0c             	sub    $0xc,%esp
  800310:	6a 00                	push   $0x0
  800312:	e8 28 14 00 00       	call   80173f <sys_env_destroy>
  800317:	83 c4 10             	add    $0x10,%esp
}
  80031a:	90                   	nop
  80031b:	c9                   	leave  
  80031c:	c3                   	ret    

0080031d <exit>:

void
exit(void)
{
  80031d:	55                   	push   %ebp
  80031e:	89 e5                	mov    %esp,%ebp
  800320:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800323:	e8 7d 14 00 00       	call   8017a5 <sys_env_exit>
}
  800328:	90                   	nop
  800329:	c9                   	leave  
  80032a:	c3                   	ret    

0080032b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80032b:	55                   	push   %ebp
  80032c:	89 e5                	mov    %esp,%ebp
  80032e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800331:	8d 45 10             	lea    0x10(%ebp),%eax
  800334:	83 c0 04             	add    $0x4,%eax
  800337:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80033a:	a1 18 31 80 00       	mov    0x803118,%eax
  80033f:	85 c0                	test   %eax,%eax
  800341:	74 16                	je     800359 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800343:	a1 18 31 80 00       	mov    0x803118,%eax
  800348:	83 ec 08             	sub    $0x8,%esp
  80034b:	50                   	push   %eax
  80034c:	68 3c 22 80 00       	push   $0x80223c
  800351:	e8 77 02 00 00       	call   8005cd <cprintf>
  800356:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800359:	a1 00 30 80 00       	mov    0x803000,%eax
  80035e:	ff 75 0c             	pushl  0xc(%ebp)
  800361:	ff 75 08             	pushl  0x8(%ebp)
  800364:	50                   	push   %eax
  800365:	68 41 22 80 00       	push   $0x802241
  80036a:	e8 5e 02 00 00       	call   8005cd <cprintf>
  80036f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800372:	8b 45 10             	mov    0x10(%ebp),%eax
  800375:	83 ec 08             	sub    $0x8,%esp
  800378:	ff 75 f4             	pushl  -0xc(%ebp)
  80037b:	50                   	push   %eax
  80037c:	e8 e1 01 00 00       	call   800562 <vcprintf>
  800381:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800384:	83 ec 08             	sub    $0x8,%esp
  800387:	6a 00                	push   $0x0
  800389:	68 5d 22 80 00       	push   $0x80225d
  80038e:	e8 cf 01 00 00       	call   800562 <vcprintf>
  800393:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800396:	e8 82 ff ff ff       	call   80031d <exit>

	// should not return here
	while (1) ;
  80039b:	eb fe                	jmp    80039b <_panic+0x70>

0080039d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80039d:	55                   	push   %ebp
  80039e:	89 e5                	mov    %esp,%ebp
  8003a0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a8:	8b 50 74             	mov    0x74(%eax),%edx
  8003ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ae:	39 c2                	cmp    %eax,%edx
  8003b0:	74 14                	je     8003c6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003b2:	83 ec 04             	sub    $0x4,%esp
  8003b5:	68 60 22 80 00       	push   $0x802260
  8003ba:	6a 26                	push   $0x26
  8003bc:	68 ac 22 80 00       	push   $0x8022ac
  8003c1:	e8 65 ff ff ff       	call   80032b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003d4:	e9 b6 00 00 00       	jmp    80048f <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 d0                	add    %edx,%eax
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	85 c0                	test   %eax,%eax
  8003ec:	75 08                	jne    8003f6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003ee:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003f1:	e9 96 00 00 00       	jmp    80048c <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800404:	eb 5d                	jmp    800463 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800406:	a1 20 30 80 00       	mov    0x803020,%eax
  80040b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800411:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800414:	c1 e2 04             	shl    $0x4,%edx
  800417:	01 d0                	add    %edx,%eax
  800419:	8a 40 04             	mov    0x4(%eax),%al
  80041c:	84 c0                	test   %al,%al
  80041e:	75 40                	jne    800460 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800420:	a1 20 30 80 00       	mov    0x803020,%eax
  800425:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80042b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80042e:	c1 e2 04             	shl    $0x4,%edx
  800431:	01 d0                	add    %edx,%eax
  800433:	8b 00                	mov    (%eax),%eax
  800435:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800438:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80043b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800440:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800442:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800445:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	01 c8                	add    %ecx,%eax
  800451:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800453:	39 c2                	cmp    %eax,%edx
  800455:	75 09                	jne    800460 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800457:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80045e:	eb 12                	jmp    800472 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800460:	ff 45 e8             	incl   -0x18(%ebp)
  800463:	a1 20 30 80 00       	mov    0x803020,%eax
  800468:	8b 50 74             	mov    0x74(%eax),%edx
  80046b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80046e:	39 c2                	cmp    %eax,%edx
  800470:	77 94                	ja     800406 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800472:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800476:	75 14                	jne    80048c <CheckWSWithoutLastIndex+0xef>
			panic(
  800478:	83 ec 04             	sub    $0x4,%esp
  80047b:	68 b8 22 80 00       	push   $0x8022b8
  800480:	6a 3a                	push   $0x3a
  800482:	68 ac 22 80 00       	push   $0x8022ac
  800487:	e8 9f fe ff ff       	call   80032b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80048c:	ff 45 f0             	incl   -0x10(%ebp)
  80048f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800492:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800495:	0f 8c 3e ff ff ff    	jl     8003d9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80049b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004a9:	eb 20                	jmp    8004cb <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004b9:	c1 e2 04             	shl    $0x4,%edx
  8004bc:	01 d0                	add    %edx,%eax
  8004be:	8a 40 04             	mov    0x4(%eax),%al
  8004c1:	3c 01                	cmp    $0x1,%al
  8004c3:	75 03                	jne    8004c8 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8004c5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004c8:	ff 45 e0             	incl   -0x20(%ebp)
  8004cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d0:	8b 50 74             	mov    0x74(%eax),%edx
  8004d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004d6:	39 c2                	cmp    %eax,%edx
  8004d8:	77 d1                	ja     8004ab <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004dd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004e0:	74 14                	je     8004f6 <CheckWSWithoutLastIndex+0x159>
		panic(
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	68 0c 23 80 00       	push   $0x80230c
  8004ea:	6a 44                	push   $0x44
  8004ec:	68 ac 22 80 00       	push   $0x8022ac
  8004f1:	e8 35 fe ff ff       	call   80032b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004f6:	90                   	nop
  8004f7:	c9                   	leave  
  8004f8:	c3                   	ret    

008004f9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004f9:	55                   	push   %ebp
  8004fa:	89 e5                	mov    %esp,%ebp
  8004fc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800502:	8b 00                	mov    (%eax),%eax
  800504:	8d 48 01             	lea    0x1(%eax),%ecx
  800507:	8b 55 0c             	mov    0xc(%ebp),%edx
  80050a:	89 0a                	mov    %ecx,(%edx)
  80050c:	8b 55 08             	mov    0x8(%ebp),%edx
  80050f:	88 d1                	mov    %dl,%cl
  800511:	8b 55 0c             	mov    0xc(%ebp),%edx
  800514:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800518:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051b:	8b 00                	mov    (%eax),%eax
  80051d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800522:	75 2c                	jne    800550 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800524:	a0 24 30 80 00       	mov    0x803024,%al
  800529:	0f b6 c0             	movzbl %al,%eax
  80052c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80052f:	8b 12                	mov    (%edx),%edx
  800531:	89 d1                	mov    %edx,%ecx
  800533:	8b 55 0c             	mov    0xc(%ebp),%edx
  800536:	83 c2 08             	add    $0x8,%edx
  800539:	83 ec 04             	sub    $0x4,%esp
  80053c:	50                   	push   %eax
  80053d:	51                   	push   %ecx
  80053e:	52                   	push   %edx
  80053f:	e8 b9 11 00 00       	call   8016fd <sys_cputs>
  800544:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800547:	8b 45 0c             	mov    0xc(%ebp),%eax
  80054a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800550:	8b 45 0c             	mov    0xc(%ebp),%eax
  800553:	8b 40 04             	mov    0x4(%eax),%eax
  800556:	8d 50 01             	lea    0x1(%eax),%edx
  800559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80055c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80055f:	90                   	nop
  800560:	c9                   	leave  
  800561:	c3                   	ret    

00800562 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800562:	55                   	push   %ebp
  800563:	89 e5                	mov    %esp,%ebp
  800565:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80056b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800572:	00 00 00 
	b.cnt = 0;
  800575:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80057c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80057f:	ff 75 0c             	pushl  0xc(%ebp)
  800582:	ff 75 08             	pushl  0x8(%ebp)
  800585:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80058b:	50                   	push   %eax
  80058c:	68 f9 04 80 00       	push   $0x8004f9
  800591:	e8 11 02 00 00       	call   8007a7 <vprintfmt>
  800596:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800599:	a0 24 30 80 00       	mov    0x803024,%al
  80059e:	0f b6 c0             	movzbl %al,%eax
  8005a1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005a7:	83 ec 04             	sub    $0x4,%esp
  8005aa:	50                   	push   %eax
  8005ab:	52                   	push   %edx
  8005ac:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005b2:	83 c0 08             	add    $0x8,%eax
  8005b5:	50                   	push   %eax
  8005b6:	e8 42 11 00 00       	call   8016fd <sys_cputs>
  8005bb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005be:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005c5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005cb:	c9                   	leave  
  8005cc:	c3                   	ret    

008005cd <cprintf>:

int cprintf(const char *fmt, ...) {
  8005cd:	55                   	push   %ebp
  8005ce:	89 e5                	mov    %esp,%ebp
  8005d0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005d3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005da:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e3:	83 ec 08             	sub    $0x8,%esp
  8005e6:	ff 75 f4             	pushl  -0xc(%ebp)
  8005e9:	50                   	push   %eax
  8005ea:	e8 73 ff ff ff       	call   800562 <vcprintf>
  8005ef:	83 c4 10             	add    $0x10,%esp
  8005f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005f8:	c9                   	leave  
  8005f9:	c3                   	ret    

008005fa <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
  8005fd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800600:	e8 09 13 00 00       	call   80190e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800605:	8d 45 0c             	lea    0xc(%ebp),%eax
  800608:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80060b:	8b 45 08             	mov    0x8(%ebp),%eax
  80060e:	83 ec 08             	sub    $0x8,%esp
  800611:	ff 75 f4             	pushl  -0xc(%ebp)
  800614:	50                   	push   %eax
  800615:	e8 48 ff ff ff       	call   800562 <vcprintf>
  80061a:	83 c4 10             	add    $0x10,%esp
  80061d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800620:	e8 03 13 00 00       	call   801928 <sys_enable_interrupt>
	return cnt;
  800625:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800628:	c9                   	leave  
  800629:	c3                   	ret    

0080062a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80062a:	55                   	push   %ebp
  80062b:	89 e5                	mov    %esp,%ebp
  80062d:	53                   	push   %ebx
  80062e:	83 ec 14             	sub    $0x14,%esp
  800631:	8b 45 10             	mov    0x10(%ebp),%eax
  800634:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800637:	8b 45 14             	mov    0x14(%ebp),%eax
  80063a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80063d:	8b 45 18             	mov    0x18(%ebp),%eax
  800640:	ba 00 00 00 00       	mov    $0x0,%edx
  800645:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800648:	77 55                	ja     80069f <printnum+0x75>
  80064a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80064d:	72 05                	jb     800654 <printnum+0x2a>
  80064f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800652:	77 4b                	ja     80069f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800654:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800657:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80065a:	8b 45 18             	mov    0x18(%ebp),%eax
  80065d:	ba 00 00 00 00       	mov    $0x0,%edx
  800662:	52                   	push   %edx
  800663:	50                   	push   %eax
  800664:	ff 75 f4             	pushl  -0xc(%ebp)
  800667:	ff 75 f0             	pushl  -0x10(%ebp)
  80066a:	e8 c1 16 00 00       	call   801d30 <__udivdi3>
  80066f:	83 c4 10             	add    $0x10,%esp
  800672:	83 ec 04             	sub    $0x4,%esp
  800675:	ff 75 20             	pushl  0x20(%ebp)
  800678:	53                   	push   %ebx
  800679:	ff 75 18             	pushl  0x18(%ebp)
  80067c:	52                   	push   %edx
  80067d:	50                   	push   %eax
  80067e:	ff 75 0c             	pushl  0xc(%ebp)
  800681:	ff 75 08             	pushl  0x8(%ebp)
  800684:	e8 a1 ff ff ff       	call   80062a <printnum>
  800689:	83 c4 20             	add    $0x20,%esp
  80068c:	eb 1a                	jmp    8006a8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80068e:	83 ec 08             	sub    $0x8,%esp
  800691:	ff 75 0c             	pushl  0xc(%ebp)
  800694:	ff 75 20             	pushl  0x20(%ebp)
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	ff d0                	call   *%eax
  80069c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80069f:	ff 4d 1c             	decl   0x1c(%ebp)
  8006a2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006a6:	7f e6                	jg     80068e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006a8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006ab:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b6:	53                   	push   %ebx
  8006b7:	51                   	push   %ecx
  8006b8:	52                   	push   %edx
  8006b9:	50                   	push   %eax
  8006ba:	e8 81 17 00 00       	call   801e40 <__umoddi3>
  8006bf:	83 c4 10             	add    $0x10,%esp
  8006c2:	05 74 25 80 00       	add    $0x802574,%eax
  8006c7:	8a 00                	mov    (%eax),%al
  8006c9:	0f be c0             	movsbl %al,%eax
  8006cc:	83 ec 08             	sub    $0x8,%esp
  8006cf:	ff 75 0c             	pushl  0xc(%ebp)
  8006d2:	50                   	push   %eax
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	ff d0                	call   *%eax
  8006d8:	83 c4 10             	add    $0x10,%esp
}
  8006db:	90                   	nop
  8006dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006df:	c9                   	leave  
  8006e0:	c3                   	ret    

008006e1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006e1:	55                   	push   %ebp
  8006e2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006e4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006e8:	7e 1c                	jle    800706 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ed:	8b 00                	mov    (%eax),%eax
  8006ef:	8d 50 08             	lea    0x8(%eax),%edx
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	89 10                	mov    %edx,(%eax)
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	83 e8 08             	sub    $0x8,%eax
  8006ff:	8b 50 04             	mov    0x4(%eax),%edx
  800702:	8b 00                	mov    (%eax),%eax
  800704:	eb 40                	jmp    800746 <getuint+0x65>
	else if (lflag)
  800706:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80070a:	74 1e                	je     80072a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80070c:	8b 45 08             	mov    0x8(%ebp),%eax
  80070f:	8b 00                	mov    (%eax),%eax
  800711:	8d 50 04             	lea    0x4(%eax),%edx
  800714:	8b 45 08             	mov    0x8(%ebp),%eax
  800717:	89 10                	mov    %edx,(%eax)
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	8b 00                	mov    (%eax),%eax
  80071e:	83 e8 04             	sub    $0x4,%eax
  800721:	8b 00                	mov    (%eax),%eax
  800723:	ba 00 00 00 00       	mov    $0x0,%edx
  800728:	eb 1c                	jmp    800746 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80072a:	8b 45 08             	mov    0x8(%ebp),%eax
  80072d:	8b 00                	mov    (%eax),%eax
  80072f:	8d 50 04             	lea    0x4(%eax),%edx
  800732:	8b 45 08             	mov    0x8(%ebp),%eax
  800735:	89 10                	mov    %edx,(%eax)
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	8b 00                	mov    (%eax),%eax
  80073c:	83 e8 04             	sub    $0x4,%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800746:	5d                   	pop    %ebp
  800747:	c3                   	ret    

00800748 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800748:	55                   	push   %ebp
  800749:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80074b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80074f:	7e 1c                	jle    80076d <getint+0x25>
		return va_arg(*ap, long long);
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	8b 00                	mov    (%eax),%eax
  800756:	8d 50 08             	lea    0x8(%eax),%edx
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	89 10                	mov    %edx,(%eax)
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	8b 00                	mov    (%eax),%eax
  800763:	83 e8 08             	sub    $0x8,%eax
  800766:	8b 50 04             	mov    0x4(%eax),%edx
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	eb 38                	jmp    8007a5 <getint+0x5d>
	else if (lflag)
  80076d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800771:	74 1a                	je     80078d <getint+0x45>
		return va_arg(*ap, long);
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	8b 00                	mov    (%eax),%eax
  800778:	8d 50 04             	lea    0x4(%eax),%edx
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	89 10                	mov    %edx,(%eax)
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	83 e8 04             	sub    $0x4,%eax
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	99                   	cltd   
  80078b:	eb 18                	jmp    8007a5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	8d 50 04             	lea    0x4(%eax),%edx
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	89 10                	mov    %edx,(%eax)
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	83 e8 04             	sub    $0x4,%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	99                   	cltd   
}
  8007a5:	5d                   	pop    %ebp
  8007a6:	c3                   	ret    

008007a7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007a7:	55                   	push   %ebp
  8007a8:	89 e5                	mov    %esp,%ebp
  8007aa:	56                   	push   %esi
  8007ab:	53                   	push   %ebx
  8007ac:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007af:	eb 17                	jmp    8007c8 <vprintfmt+0x21>
			if (ch == '\0')
  8007b1:	85 db                	test   %ebx,%ebx
  8007b3:	0f 84 af 03 00 00    	je     800b68 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007b9:	83 ec 08             	sub    $0x8,%esp
  8007bc:	ff 75 0c             	pushl  0xc(%ebp)
  8007bf:	53                   	push   %ebx
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	ff d0                	call   *%eax
  8007c5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cb:	8d 50 01             	lea    0x1(%eax),%edx
  8007ce:	89 55 10             	mov    %edx,0x10(%ebp)
  8007d1:	8a 00                	mov    (%eax),%al
  8007d3:	0f b6 d8             	movzbl %al,%ebx
  8007d6:	83 fb 25             	cmp    $0x25,%ebx
  8007d9:	75 d6                	jne    8007b1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007db:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007df:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007e6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007ed:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007f4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8007fe:	8d 50 01             	lea    0x1(%eax),%edx
  800801:	89 55 10             	mov    %edx,0x10(%ebp)
  800804:	8a 00                	mov    (%eax),%al
  800806:	0f b6 d8             	movzbl %al,%ebx
  800809:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80080c:	83 f8 55             	cmp    $0x55,%eax
  80080f:	0f 87 2b 03 00 00    	ja     800b40 <vprintfmt+0x399>
  800815:	8b 04 85 98 25 80 00 	mov    0x802598(,%eax,4),%eax
  80081c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80081e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800822:	eb d7                	jmp    8007fb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800824:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800828:	eb d1                	jmp    8007fb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80082a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800831:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800834:	89 d0                	mov    %edx,%eax
  800836:	c1 e0 02             	shl    $0x2,%eax
  800839:	01 d0                	add    %edx,%eax
  80083b:	01 c0                	add    %eax,%eax
  80083d:	01 d8                	add    %ebx,%eax
  80083f:	83 e8 30             	sub    $0x30,%eax
  800842:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800845:	8b 45 10             	mov    0x10(%ebp),%eax
  800848:	8a 00                	mov    (%eax),%al
  80084a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80084d:	83 fb 2f             	cmp    $0x2f,%ebx
  800850:	7e 3e                	jle    800890 <vprintfmt+0xe9>
  800852:	83 fb 39             	cmp    $0x39,%ebx
  800855:	7f 39                	jg     800890 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800857:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80085a:	eb d5                	jmp    800831 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80085c:	8b 45 14             	mov    0x14(%ebp),%eax
  80085f:	83 c0 04             	add    $0x4,%eax
  800862:	89 45 14             	mov    %eax,0x14(%ebp)
  800865:	8b 45 14             	mov    0x14(%ebp),%eax
  800868:	83 e8 04             	sub    $0x4,%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800870:	eb 1f                	jmp    800891 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800872:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800876:	79 83                	jns    8007fb <vprintfmt+0x54>
				width = 0;
  800878:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80087f:	e9 77 ff ff ff       	jmp    8007fb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800884:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80088b:	e9 6b ff ff ff       	jmp    8007fb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800890:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800891:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800895:	0f 89 60 ff ff ff    	jns    8007fb <vprintfmt+0x54>
				width = precision, precision = -1;
  80089b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80089e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008a1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008a8:	e9 4e ff ff ff       	jmp    8007fb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008ad:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008b0:	e9 46 ff ff ff       	jmp    8007fb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b8:	83 c0 04             	add    $0x4,%eax
  8008bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8008be:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c1:	83 e8 04             	sub    $0x4,%eax
  8008c4:	8b 00                	mov    (%eax),%eax
  8008c6:	83 ec 08             	sub    $0x8,%esp
  8008c9:	ff 75 0c             	pushl  0xc(%ebp)
  8008cc:	50                   	push   %eax
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	ff d0                	call   *%eax
  8008d2:	83 c4 10             	add    $0x10,%esp
			break;
  8008d5:	e9 89 02 00 00       	jmp    800b63 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008da:	8b 45 14             	mov    0x14(%ebp),%eax
  8008dd:	83 c0 04             	add    $0x4,%eax
  8008e0:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e6:	83 e8 04             	sub    $0x4,%eax
  8008e9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008eb:	85 db                	test   %ebx,%ebx
  8008ed:	79 02                	jns    8008f1 <vprintfmt+0x14a>
				err = -err;
  8008ef:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008f1:	83 fb 64             	cmp    $0x64,%ebx
  8008f4:	7f 0b                	jg     800901 <vprintfmt+0x15a>
  8008f6:	8b 34 9d e0 23 80 00 	mov    0x8023e0(,%ebx,4),%esi
  8008fd:	85 f6                	test   %esi,%esi
  8008ff:	75 19                	jne    80091a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800901:	53                   	push   %ebx
  800902:	68 85 25 80 00       	push   $0x802585
  800907:	ff 75 0c             	pushl  0xc(%ebp)
  80090a:	ff 75 08             	pushl  0x8(%ebp)
  80090d:	e8 5e 02 00 00       	call   800b70 <printfmt>
  800912:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800915:	e9 49 02 00 00       	jmp    800b63 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80091a:	56                   	push   %esi
  80091b:	68 8e 25 80 00       	push   $0x80258e
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	ff 75 08             	pushl  0x8(%ebp)
  800926:	e8 45 02 00 00       	call   800b70 <printfmt>
  80092b:	83 c4 10             	add    $0x10,%esp
			break;
  80092e:	e9 30 02 00 00       	jmp    800b63 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800933:	8b 45 14             	mov    0x14(%ebp),%eax
  800936:	83 c0 04             	add    $0x4,%eax
  800939:	89 45 14             	mov    %eax,0x14(%ebp)
  80093c:	8b 45 14             	mov    0x14(%ebp),%eax
  80093f:	83 e8 04             	sub    $0x4,%eax
  800942:	8b 30                	mov    (%eax),%esi
  800944:	85 f6                	test   %esi,%esi
  800946:	75 05                	jne    80094d <vprintfmt+0x1a6>
				p = "(null)";
  800948:	be 91 25 80 00       	mov    $0x802591,%esi
			if (width > 0 && padc != '-')
  80094d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800951:	7e 6d                	jle    8009c0 <vprintfmt+0x219>
  800953:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800957:	74 67                	je     8009c0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800959:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80095c:	83 ec 08             	sub    $0x8,%esp
  80095f:	50                   	push   %eax
  800960:	56                   	push   %esi
  800961:	e8 0c 03 00 00       	call   800c72 <strnlen>
  800966:	83 c4 10             	add    $0x10,%esp
  800969:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80096c:	eb 16                	jmp    800984 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80096e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 0c             	pushl  0xc(%ebp)
  800978:	50                   	push   %eax
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	ff d0                	call   *%eax
  80097e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800981:	ff 4d e4             	decl   -0x1c(%ebp)
  800984:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800988:	7f e4                	jg     80096e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80098a:	eb 34                	jmp    8009c0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80098c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800990:	74 1c                	je     8009ae <vprintfmt+0x207>
  800992:	83 fb 1f             	cmp    $0x1f,%ebx
  800995:	7e 05                	jle    80099c <vprintfmt+0x1f5>
  800997:	83 fb 7e             	cmp    $0x7e,%ebx
  80099a:	7e 12                	jle    8009ae <vprintfmt+0x207>
					putch('?', putdat);
  80099c:	83 ec 08             	sub    $0x8,%esp
  80099f:	ff 75 0c             	pushl  0xc(%ebp)
  8009a2:	6a 3f                	push   $0x3f
  8009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a7:	ff d0                	call   *%eax
  8009a9:	83 c4 10             	add    $0x10,%esp
  8009ac:	eb 0f                	jmp    8009bd <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	ff 75 0c             	pushl  0xc(%ebp)
  8009b4:	53                   	push   %ebx
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	ff d0                	call   *%eax
  8009ba:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009bd:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c0:	89 f0                	mov    %esi,%eax
  8009c2:	8d 70 01             	lea    0x1(%eax),%esi
  8009c5:	8a 00                	mov    (%eax),%al
  8009c7:	0f be d8             	movsbl %al,%ebx
  8009ca:	85 db                	test   %ebx,%ebx
  8009cc:	74 24                	je     8009f2 <vprintfmt+0x24b>
  8009ce:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009d2:	78 b8                	js     80098c <vprintfmt+0x1e5>
  8009d4:	ff 4d e0             	decl   -0x20(%ebp)
  8009d7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009db:	79 af                	jns    80098c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009dd:	eb 13                	jmp    8009f2 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	6a 20                	push   $0x20
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009ef:	ff 4d e4             	decl   -0x1c(%ebp)
  8009f2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009f6:	7f e7                	jg     8009df <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009f8:	e9 66 01 00 00       	jmp    800b63 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009fd:	83 ec 08             	sub    $0x8,%esp
  800a00:	ff 75 e8             	pushl  -0x18(%ebp)
  800a03:	8d 45 14             	lea    0x14(%ebp),%eax
  800a06:	50                   	push   %eax
  800a07:	e8 3c fd ff ff       	call   800748 <getint>
  800a0c:	83 c4 10             	add    $0x10,%esp
  800a0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a1b:	85 d2                	test   %edx,%edx
  800a1d:	79 23                	jns    800a42 <vprintfmt+0x29b>
				putch('-', putdat);
  800a1f:	83 ec 08             	sub    $0x8,%esp
  800a22:	ff 75 0c             	pushl  0xc(%ebp)
  800a25:	6a 2d                	push   $0x2d
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	ff d0                	call   *%eax
  800a2c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a35:	f7 d8                	neg    %eax
  800a37:	83 d2 00             	adc    $0x0,%edx
  800a3a:	f7 da                	neg    %edx
  800a3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a42:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a49:	e9 bc 00 00 00       	jmp    800b0a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a4e:	83 ec 08             	sub    $0x8,%esp
  800a51:	ff 75 e8             	pushl  -0x18(%ebp)
  800a54:	8d 45 14             	lea    0x14(%ebp),%eax
  800a57:	50                   	push   %eax
  800a58:	e8 84 fc ff ff       	call   8006e1 <getuint>
  800a5d:	83 c4 10             	add    $0x10,%esp
  800a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a63:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a66:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a6d:	e9 98 00 00 00       	jmp    800b0a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a72:	83 ec 08             	sub    $0x8,%esp
  800a75:	ff 75 0c             	pushl  0xc(%ebp)
  800a78:	6a 58                	push   $0x58
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	ff d0                	call   *%eax
  800a7f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a82:	83 ec 08             	sub    $0x8,%esp
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	6a 58                	push   $0x58
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	ff d0                	call   *%eax
  800a8f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a92:	83 ec 08             	sub    $0x8,%esp
  800a95:	ff 75 0c             	pushl  0xc(%ebp)
  800a98:	6a 58                	push   $0x58
  800a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9d:	ff d0                	call   *%eax
  800a9f:	83 c4 10             	add    $0x10,%esp
			break;
  800aa2:	e9 bc 00 00 00       	jmp    800b63 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800aa7:	83 ec 08             	sub    $0x8,%esp
  800aaa:	ff 75 0c             	pushl  0xc(%ebp)
  800aad:	6a 30                	push   $0x30
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	ff d0                	call   *%eax
  800ab4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ab7:	83 ec 08             	sub    $0x8,%esp
  800aba:	ff 75 0c             	pushl  0xc(%ebp)
  800abd:	6a 78                	push   $0x78
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	ff d0                	call   *%eax
  800ac4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ac7:	8b 45 14             	mov    0x14(%ebp),%eax
  800aca:	83 c0 04             	add    $0x4,%eax
  800acd:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad3:	83 e8 04             	sub    $0x4,%eax
  800ad6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800adb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ae2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ae9:	eb 1f                	jmp    800b0a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800aeb:	83 ec 08             	sub    $0x8,%esp
  800aee:	ff 75 e8             	pushl  -0x18(%ebp)
  800af1:	8d 45 14             	lea    0x14(%ebp),%eax
  800af4:	50                   	push   %eax
  800af5:	e8 e7 fb ff ff       	call   8006e1 <getuint>
  800afa:	83 c4 10             	add    $0x10,%esp
  800afd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b00:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b03:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b0a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b11:	83 ec 04             	sub    $0x4,%esp
  800b14:	52                   	push   %edx
  800b15:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b18:	50                   	push   %eax
  800b19:	ff 75 f4             	pushl  -0xc(%ebp)
  800b1c:	ff 75 f0             	pushl  -0x10(%ebp)
  800b1f:	ff 75 0c             	pushl  0xc(%ebp)
  800b22:	ff 75 08             	pushl  0x8(%ebp)
  800b25:	e8 00 fb ff ff       	call   80062a <printnum>
  800b2a:	83 c4 20             	add    $0x20,%esp
			break;
  800b2d:	eb 34                	jmp    800b63 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b2f:	83 ec 08             	sub    $0x8,%esp
  800b32:	ff 75 0c             	pushl  0xc(%ebp)
  800b35:	53                   	push   %ebx
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	ff d0                	call   *%eax
  800b3b:	83 c4 10             	add    $0x10,%esp
			break;
  800b3e:	eb 23                	jmp    800b63 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b40:	83 ec 08             	sub    $0x8,%esp
  800b43:	ff 75 0c             	pushl  0xc(%ebp)
  800b46:	6a 25                	push   $0x25
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	ff d0                	call   *%eax
  800b4d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b50:	ff 4d 10             	decl   0x10(%ebp)
  800b53:	eb 03                	jmp    800b58 <vprintfmt+0x3b1>
  800b55:	ff 4d 10             	decl   0x10(%ebp)
  800b58:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5b:	48                   	dec    %eax
  800b5c:	8a 00                	mov    (%eax),%al
  800b5e:	3c 25                	cmp    $0x25,%al
  800b60:	75 f3                	jne    800b55 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b62:	90                   	nop
		}
	}
  800b63:	e9 47 fc ff ff       	jmp    8007af <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b68:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b69:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b6c:	5b                   	pop    %ebx
  800b6d:	5e                   	pop    %esi
  800b6e:	5d                   	pop    %ebp
  800b6f:	c3                   	ret    

00800b70 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b70:	55                   	push   %ebp
  800b71:	89 e5                	mov    %esp,%ebp
  800b73:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b76:	8d 45 10             	lea    0x10(%ebp),%eax
  800b79:	83 c0 04             	add    $0x4,%eax
  800b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b82:	ff 75 f4             	pushl  -0xc(%ebp)
  800b85:	50                   	push   %eax
  800b86:	ff 75 0c             	pushl  0xc(%ebp)
  800b89:	ff 75 08             	pushl  0x8(%ebp)
  800b8c:	e8 16 fc ff ff       	call   8007a7 <vprintfmt>
  800b91:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b94:	90                   	nop
  800b95:	c9                   	leave  
  800b96:	c3                   	ret    

00800b97 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b97:	55                   	push   %ebp
  800b98:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9d:	8b 40 08             	mov    0x8(%eax),%eax
  800ba0:	8d 50 01             	lea    0x1(%eax),%edx
  800ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bac:	8b 10                	mov    (%eax),%edx
  800bae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb1:	8b 40 04             	mov    0x4(%eax),%eax
  800bb4:	39 c2                	cmp    %eax,%edx
  800bb6:	73 12                	jae    800bca <sprintputch+0x33>
		*b->buf++ = ch;
  800bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	8d 48 01             	lea    0x1(%eax),%ecx
  800bc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc3:	89 0a                	mov    %ecx,(%edx)
  800bc5:	8b 55 08             	mov    0x8(%ebp),%edx
  800bc8:	88 10                	mov    %dl,(%eax)
}
  800bca:	90                   	nop
  800bcb:	5d                   	pop    %ebp
  800bcc:	c3                   	ret    

00800bcd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bcd:	55                   	push   %ebp
  800bce:	89 e5                	mov    %esp,%ebp
  800bd0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	01 d0                	add    %edx,%eax
  800be4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bf2:	74 06                	je     800bfa <vsnprintf+0x2d>
  800bf4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf8:	7f 07                	jg     800c01 <vsnprintf+0x34>
		return -E_INVAL;
  800bfa:	b8 03 00 00 00       	mov    $0x3,%eax
  800bff:	eb 20                	jmp    800c21 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c01:	ff 75 14             	pushl  0x14(%ebp)
  800c04:	ff 75 10             	pushl  0x10(%ebp)
  800c07:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c0a:	50                   	push   %eax
  800c0b:	68 97 0b 80 00       	push   $0x800b97
  800c10:	e8 92 fb ff ff       	call   8007a7 <vprintfmt>
  800c15:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c1b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c21:	c9                   	leave  
  800c22:	c3                   	ret    

00800c23 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c23:	55                   	push   %ebp
  800c24:	89 e5                	mov    %esp,%ebp
  800c26:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c29:	8d 45 10             	lea    0x10(%ebp),%eax
  800c2c:	83 c0 04             	add    $0x4,%eax
  800c2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c32:	8b 45 10             	mov    0x10(%ebp),%eax
  800c35:	ff 75 f4             	pushl  -0xc(%ebp)
  800c38:	50                   	push   %eax
  800c39:	ff 75 0c             	pushl  0xc(%ebp)
  800c3c:	ff 75 08             	pushl  0x8(%ebp)
  800c3f:	e8 89 ff ff ff       	call   800bcd <vsnprintf>
  800c44:	83 c4 10             	add    $0x10,%esp
  800c47:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c4d:	c9                   	leave  
  800c4e:	c3                   	ret    

00800c4f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c4f:	55                   	push   %ebp
  800c50:	89 e5                	mov    %esp,%ebp
  800c52:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c5c:	eb 06                	jmp    800c64 <strlen+0x15>
		n++;
  800c5e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c61:	ff 45 08             	incl   0x8(%ebp)
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	84 c0                	test   %al,%al
  800c6b:	75 f1                	jne    800c5e <strlen+0xf>
		n++;
	return n;
  800c6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c70:	c9                   	leave  
  800c71:	c3                   	ret    

00800c72 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c72:	55                   	push   %ebp
  800c73:	89 e5                	mov    %esp,%ebp
  800c75:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c7f:	eb 09                	jmp    800c8a <strnlen+0x18>
		n++;
  800c81:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c84:	ff 45 08             	incl   0x8(%ebp)
  800c87:	ff 4d 0c             	decl   0xc(%ebp)
  800c8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c8e:	74 09                	je     800c99 <strnlen+0x27>
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	84 c0                	test   %al,%al
  800c97:	75 e8                	jne    800c81 <strnlen+0xf>
		n++;
	return n;
  800c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c9c:	c9                   	leave  
  800c9d:	c3                   	ret    

00800c9e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c9e:	55                   	push   %ebp
  800c9f:	89 e5                	mov    %esp,%ebp
  800ca1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800caa:	90                   	nop
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8d 50 01             	lea    0x1(%eax),%edx
  800cb1:	89 55 08             	mov    %edx,0x8(%ebp)
  800cb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cba:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cbd:	8a 12                	mov    (%edx),%dl
  800cbf:	88 10                	mov    %dl,(%eax)
  800cc1:	8a 00                	mov    (%eax),%al
  800cc3:	84 c0                	test   %al,%al
  800cc5:	75 e4                	jne    800cab <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cca:	c9                   	leave  
  800ccb:	c3                   	ret    

00800ccc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ccc:	55                   	push   %ebp
  800ccd:	89 e5                	mov    %esp,%ebp
  800ccf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cdf:	eb 1f                	jmp    800d00 <strncpy+0x34>
		*dst++ = *src;
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8d 50 01             	lea    0x1(%eax),%edx
  800ce7:	89 55 08             	mov    %edx,0x8(%ebp)
  800cea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ced:	8a 12                	mov    (%edx),%dl
  800cef:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	84 c0                	test   %al,%al
  800cf8:	74 03                	je     800cfd <strncpy+0x31>
			src++;
  800cfa:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cfd:	ff 45 fc             	incl   -0x4(%ebp)
  800d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d03:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d06:	72 d9                	jb     800ce1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d08:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d0b:	c9                   	leave  
  800d0c:	c3                   	ret    

00800d0d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d0d:	55                   	push   %ebp
  800d0e:	89 e5                	mov    %esp,%ebp
  800d10:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1d:	74 30                	je     800d4f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d1f:	eb 16                	jmp    800d37 <strlcpy+0x2a>
			*dst++ = *src++;
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8d 50 01             	lea    0x1(%eax),%edx
  800d27:	89 55 08             	mov    %edx,0x8(%ebp)
  800d2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d2d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d30:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d33:	8a 12                	mov    (%edx),%dl
  800d35:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d37:	ff 4d 10             	decl   0x10(%ebp)
  800d3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3e:	74 09                	je     800d49 <strlcpy+0x3c>
  800d40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d43:	8a 00                	mov    (%eax),%al
  800d45:	84 c0                	test   %al,%al
  800d47:	75 d8                	jne    800d21 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d4f:	8b 55 08             	mov    0x8(%ebp),%edx
  800d52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d55:	29 c2                	sub    %eax,%edx
  800d57:	89 d0                	mov    %edx,%eax
}
  800d59:	c9                   	leave  
  800d5a:	c3                   	ret    

00800d5b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d5b:	55                   	push   %ebp
  800d5c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d5e:	eb 06                	jmp    800d66 <strcmp+0xb>
		p++, q++;
  800d60:	ff 45 08             	incl   0x8(%ebp)
  800d63:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	8a 00                	mov    (%eax),%al
  800d6b:	84 c0                	test   %al,%al
  800d6d:	74 0e                	je     800d7d <strcmp+0x22>
  800d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d72:	8a 10                	mov    (%eax),%dl
  800d74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d77:	8a 00                	mov    (%eax),%al
  800d79:	38 c2                	cmp    %al,%dl
  800d7b:	74 e3                	je     800d60 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	0f b6 d0             	movzbl %al,%edx
  800d85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	0f b6 c0             	movzbl %al,%eax
  800d8d:	29 c2                	sub    %eax,%edx
  800d8f:	89 d0                	mov    %edx,%eax
}
  800d91:	5d                   	pop    %ebp
  800d92:	c3                   	ret    

00800d93 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d93:	55                   	push   %ebp
  800d94:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d96:	eb 09                	jmp    800da1 <strncmp+0xe>
		n--, p++, q++;
  800d98:	ff 4d 10             	decl   0x10(%ebp)
  800d9b:	ff 45 08             	incl   0x8(%ebp)
  800d9e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800da1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da5:	74 17                	je     800dbe <strncmp+0x2b>
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	8a 00                	mov    (%eax),%al
  800dac:	84 c0                	test   %al,%al
  800dae:	74 0e                	je     800dbe <strncmp+0x2b>
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	8a 10                	mov    (%eax),%dl
  800db5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db8:	8a 00                	mov    (%eax),%al
  800dba:	38 c2                	cmp    %al,%dl
  800dbc:	74 da                	je     800d98 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc2:	75 07                	jne    800dcb <strncmp+0x38>
		return 0;
  800dc4:	b8 00 00 00 00       	mov    $0x0,%eax
  800dc9:	eb 14                	jmp    800ddf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	8a 00                	mov    (%eax),%al
  800dd0:	0f b6 d0             	movzbl %al,%edx
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	0f b6 c0             	movzbl %al,%eax
  800ddb:	29 c2                	sub    %eax,%edx
  800ddd:	89 d0                	mov    %edx,%eax
}
  800ddf:	5d                   	pop    %ebp
  800de0:	c3                   	ret    

00800de1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800de1:	55                   	push   %ebp
  800de2:	89 e5                	mov    %esp,%ebp
  800de4:	83 ec 04             	sub    $0x4,%esp
  800de7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ded:	eb 12                	jmp    800e01 <strchr+0x20>
		if (*s == c)
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	8a 00                	mov    (%eax),%al
  800df4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800df7:	75 05                	jne    800dfe <strchr+0x1d>
			return (char *) s;
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	eb 11                	jmp    800e0f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dfe:	ff 45 08             	incl   0x8(%ebp)
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	84 c0                	test   %al,%al
  800e08:	75 e5                	jne    800def <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e0f:	c9                   	leave  
  800e10:	c3                   	ret    

00800e11 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e11:	55                   	push   %ebp
  800e12:	89 e5                	mov    %esp,%ebp
  800e14:	83 ec 04             	sub    $0x4,%esp
  800e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e1d:	eb 0d                	jmp    800e2c <strfind+0x1b>
		if (*s == c)
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	8a 00                	mov    (%eax),%al
  800e24:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e27:	74 0e                	je     800e37 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e29:	ff 45 08             	incl   0x8(%ebp)
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	84 c0                	test   %al,%al
  800e33:	75 ea                	jne    800e1f <strfind+0xe>
  800e35:	eb 01                	jmp    800e38 <strfind+0x27>
		if (*s == c)
			break;
  800e37:	90                   	nop
	return (char *) s;
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
  800e40:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e49:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e4f:	eb 0e                	jmp    800e5f <memset+0x22>
		*p++ = c;
  800e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e54:	8d 50 01             	lea    0x1(%eax),%edx
  800e57:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e5f:	ff 4d f8             	decl   -0x8(%ebp)
  800e62:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e66:	79 e9                	jns    800e51 <memset+0x14>
		*p++ = c;

	return v;
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6b:	c9                   	leave  
  800e6c:	c3                   	ret    

00800e6d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e6d:	55                   	push   %ebp
  800e6e:	89 e5                	mov    %esp,%ebp
  800e70:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e7f:	eb 16                	jmp    800e97 <memcpy+0x2a>
		*d++ = *s++;
  800e81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e84:	8d 50 01             	lea    0x1(%eax),%edx
  800e87:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e8a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e90:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e93:	8a 12                	mov    (%edx),%dl
  800e95:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e97:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e9d:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea0:	85 c0                	test   %eax,%eax
  800ea2:	75 dd                	jne    800e81 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ebb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ec1:	73 50                	jae    800f13 <memmove+0x6a>
  800ec3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec9:	01 d0                	add    %edx,%eax
  800ecb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ece:	76 43                	jbe    800f13 <memmove+0x6a>
		s += n;
  800ed0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800edc:	eb 10                	jmp    800eee <memmove+0x45>
			*--d = *--s;
  800ede:	ff 4d f8             	decl   -0x8(%ebp)
  800ee1:	ff 4d fc             	decl   -0x4(%ebp)
  800ee4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee7:	8a 10                	mov    (%eax),%dl
  800ee9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eec:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800eee:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef4:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef7:	85 c0                	test   %eax,%eax
  800ef9:	75 e3                	jne    800ede <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800efb:	eb 23                	jmp    800f20 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800efd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f00:	8d 50 01             	lea    0x1(%eax),%edx
  800f03:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f06:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f09:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f0c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f0f:	8a 12                	mov    (%edx),%dl
  800f11:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f13:	8b 45 10             	mov    0x10(%ebp),%eax
  800f16:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f19:	89 55 10             	mov    %edx,0x10(%ebp)
  800f1c:	85 c0                	test   %eax,%eax
  800f1e:	75 dd                	jne    800efd <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f23:	c9                   	leave  
  800f24:	c3                   	ret    

00800f25 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f25:	55                   	push   %ebp
  800f26:	89 e5                	mov    %esp,%ebp
  800f28:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f34:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f37:	eb 2a                	jmp    800f63 <memcmp+0x3e>
		if (*s1 != *s2)
  800f39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f3c:	8a 10                	mov    (%eax),%dl
  800f3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	38 c2                	cmp    %al,%dl
  800f45:	74 16                	je     800f5d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	0f b6 d0             	movzbl %al,%edx
  800f4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	0f b6 c0             	movzbl %al,%eax
  800f57:	29 c2                	sub    %eax,%edx
  800f59:	89 d0                	mov    %edx,%eax
  800f5b:	eb 18                	jmp    800f75 <memcmp+0x50>
		s1++, s2++;
  800f5d:	ff 45 fc             	incl   -0x4(%ebp)
  800f60:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f63:	8b 45 10             	mov    0x10(%ebp),%eax
  800f66:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f69:	89 55 10             	mov    %edx,0x10(%ebp)
  800f6c:	85 c0                	test   %eax,%eax
  800f6e:	75 c9                	jne    800f39 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f70:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f75:	c9                   	leave  
  800f76:	c3                   	ret    

00800f77 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
  800f7a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800f80:	8b 45 10             	mov    0x10(%ebp),%eax
  800f83:	01 d0                	add    %edx,%eax
  800f85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f88:	eb 15                	jmp    800f9f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	0f b6 d0             	movzbl %al,%edx
  800f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f95:	0f b6 c0             	movzbl %al,%eax
  800f98:	39 c2                	cmp    %eax,%edx
  800f9a:	74 0d                	je     800fa9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f9c:	ff 45 08             	incl   0x8(%ebp)
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fa5:	72 e3                	jb     800f8a <memfind+0x13>
  800fa7:	eb 01                	jmp    800faa <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fa9:	90                   	nop
	return (void *) s;
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fad:	c9                   	leave  
  800fae:	c3                   	ret    

00800faf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800faf:	55                   	push   %ebp
  800fb0:	89 e5                	mov    %esp,%ebp
  800fb2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fbc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fc3:	eb 03                	jmp    800fc8 <strtol+0x19>
		s++;
  800fc5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	3c 20                	cmp    $0x20,%al
  800fcf:	74 f4                	je     800fc5 <strtol+0x16>
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 09                	cmp    $0x9,%al
  800fd8:	74 eb                	je     800fc5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 2b                	cmp    $0x2b,%al
  800fe1:	75 05                	jne    800fe8 <strtol+0x39>
		s++;
  800fe3:	ff 45 08             	incl   0x8(%ebp)
  800fe6:	eb 13                	jmp    800ffb <strtol+0x4c>
	else if (*s == '-')
  800fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  800feb:	8a 00                	mov    (%eax),%al
  800fed:	3c 2d                	cmp    $0x2d,%al
  800fef:	75 0a                	jne    800ffb <strtol+0x4c>
		s++, neg = 1;
  800ff1:	ff 45 08             	incl   0x8(%ebp)
  800ff4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ffb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fff:	74 06                	je     801007 <strtol+0x58>
  801001:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801005:	75 20                	jne    801027 <strtol+0x78>
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	8a 00                	mov    (%eax),%al
  80100c:	3c 30                	cmp    $0x30,%al
  80100e:	75 17                	jne    801027 <strtol+0x78>
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	40                   	inc    %eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	3c 78                	cmp    $0x78,%al
  801018:	75 0d                	jne    801027 <strtol+0x78>
		s += 2, base = 16;
  80101a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80101e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801025:	eb 28                	jmp    80104f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801027:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80102b:	75 15                	jne    801042 <strtol+0x93>
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	3c 30                	cmp    $0x30,%al
  801034:	75 0c                	jne    801042 <strtol+0x93>
		s++, base = 8;
  801036:	ff 45 08             	incl   0x8(%ebp)
  801039:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801040:	eb 0d                	jmp    80104f <strtol+0xa0>
	else if (base == 0)
  801042:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801046:	75 07                	jne    80104f <strtol+0xa0>
		base = 10;
  801048:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	8a 00                	mov    (%eax),%al
  801054:	3c 2f                	cmp    $0x2f,%al
  801056:	7e 19                	jle    801071 <strtol+0xc2>
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	3c 39                	cmp    $0x39,%al
  80105f:	7f 10                	jg     801071 <strtol+0xc2>
			dig = *s - '0';
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	0f be c0             	movsbl %al,%eax
  801069:	83 e8 30             	sub    $0x30,%eax
  80106c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80106f:	eb 42                	jmp    8010b3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	3c 60                	cmp    $0x60,%al
  801078:	7e 19                	jle    801093 <strtol+0xe4>
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	8a 00                	mov    (%eax),%al
  80107f:	3c 7a                	cmp    $0x7a,%al
  801081:	7f 10                	jg     801093 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	0f be c0             	movsbl %al,%eax
  80108b:	83 e8 57             	sub    $0x57,%eax
  80108e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801091:	eb 20                	jmp    8010b3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	8a 00                	mov    (%eax),%al
  801098:	3c 40                	cmp    $0x40,%al
  80109a:	7e 39                	jle    8010d5 <strtol+0x126>
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	3c 5a                	cmp    $0x5a,%al
  8010a3:	7f 30                	jg     8010d5 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	0f be c0             	movsbl %al,%eax
  8010ad:	83 e8 37             	sub    $0x37,%eax
  8010b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b9:	7d 19                	jge    8010d4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010bb:	ff 45 08             	incl   0x8(%ebp)
  8010be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010c5:	89 c2                	mov    %eax,%edx
  8010c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ca:	01 d0                	add    %edx,%eax
  8010cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010cf:	e9 7b ff ff ff       	jmp    80104f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010d4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010d9:	74 08                	je     8010e3 <strtol+0x134>
		*endptr = (char *) s;
  8010db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010de:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010e7:	74 07                	je     8010f0 <strtol+0x141>
  8010e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ec:	f7 d8                	neg    %eax
  8010ee:	eb 03                	jmp    8010f3 <strtol+0x144>
  8010f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010f3:	c9                   	leave  
  8010f4:	c3                   	ret    

008010f5 <ltostr>:

void
ltostr(long value, char *str)
{
  8010f5:	55                   	push   %ebp
  8010f6:	89 e5                	mov    %esp,%ebp
  8010f8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801102:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801109:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80110d:	79 13                	jns    801122 <ltostr+0x2d>
	{
		neg = 1;
  80110f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801116:	8b 45 0c             	mov    0xc(%ebp),%eax
  801119:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80111c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80111f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80112a:	99                   	cltd   
  80112b:	f7 f9                	idiv   %ecx
  80112d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801130:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801133:	8d 50 01             	lea    0x1(%eax),%edx
  801136:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801139:	89 c2                	mov    %eax,%edx
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	01 d0                	add    %edx,%eax
  801140:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801143:	83 c2 30             	add    $0x30,%edx
  801146:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801148:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80114b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801150:	f7 e9                	imul   %ecx
  801152:	c1 fa 02             	sar    $0x2,%edx
  801155:	89 c8                	mov    %ecx,%eax
  801157:	c1 f8 1f             	sar    $0x1f,%eax
  80115a:	29 c2                	sub    %eax,%edx
  80115c:	89 d0                	mov    %edx,%eax
  80115e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801161:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801164:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801169:	f7 e9                	imul   %ecx
  80116b:	c1 fa 02             	sar    $0x2,%edx
  80116e:	89 c8                	mov    %ecx,%eax
  801170:	c1 f8 1f             	sar    $0x1f,%eax
  801173:	29 c2                	sub    %eax,%edx
  801175:	89 d0                	mov    %edx,%eax
  801177:	c1 e0 02             	shl    $0x2,%eax
  80117a:	01 d0                	add    %edx,%eax
  80117c:	01 c0                	add    %eax,%eax
  80117e:	29 c1                	sub    %eax,%ecx
  801180:	89 ca                	mov    %ecx,%edx
  801182:	85 d2                	test   %edx,%edx
  801184:	75 9c                	jne    801122 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801186:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80118d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801190:	48                   	dec    %eax
  801191:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801194:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801198:	74 3d                	je     8011d7 <ltostr+0xe2>
		start = 1 ;
  80119a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011a1:	eb 34                	jmp    8011d7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a9:	01 d0                	add    %edx,%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b6:	01 c2                	add    %eax,%edx
  8011b8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011be:	01 c8                	add    %ecx,%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ca:	01 c2                	add    %eax,%edx
  8011cc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011cf:	88 02                	mov    %al,(%edx)
		start++ ;
  8011d1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011d4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011da:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011dd:	7c c4                	jl     8011a3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011df:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e5:	01 d0                	add    %edx,%eax
  8011e7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011ea:	90                   	nop
  8011eb:	c9                   	leave  
  8011ec:	c3                   	ret    

008011ed <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011ed:	55                   	push   %ebp
  8011ee:	89 e5                	mov    %esp,%ebp
  8011f0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011f3:	ff 75 08             	pushl  0x8(%ebp)
  8011f6:	e8 54 fa ff ff       	call   800c4f <strlen>
  8011fb:	83 c4 04             	add    $0x4,%esp
  8011fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	e8 46 fa ff ff       	call   800c4f <strlen>
  801209:	83 c4 04             	add    $0x4,%esp
  80120c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80120f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801216:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80121d:	eb 17                	jmp    801236 <strcconcat+0x49>
		final[s] = str1[s] ;
  80121f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801222:	8b 45 10             	mov    0x10(%ebp),%eax
  801225:	01 c2                	add    %eax,%edx
  801227:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	01 c8                	add    %ecx,%eax
  80122f:	8a 00                	mov    (%eax),%al
  801231:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801233:	ff 45 fc             	incl   -0x4(%ebp)
  801236:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801239:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80123c:	7c e1                	jl     80121f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80123e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801245:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80124c:	eb 1f                	jmp    80126d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80124e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801251:	8d 50 01             	lea    0x1(%eax),%edx
  801254:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801257:	89 c2                	mov    %eax,%edx
  801259:	8b 45 10             	mov    0x10(%ebp),%eax
  80125c:	01 c2                	add    %eax,%edx
  80125e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801261:	8b 45 0c             	mov    0xc(%ebp),%eax
  801264:	01 c8                	add    %ecx,%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80126a:	ff 45 f8             	incl   -0x8(%ebp)
  80126d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801270:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801273:	7c d9                	jl     80124e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801275:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801278:	8b 45 10             	mov    0x10(%ebp),%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	c6 00 00             	movb   $0x0,(%eax)
}
  801280:	90                   	nop
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801286:	8b 45 14             	mov    0x14(%ebp),%eax
  801289:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80128f:	8b 45 14             	mov    0x14(%ebp),%eax
  801292:	8b 00                	mov    (%eax),%eax
  801294:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80129b:	8b 45 10             	mov    0x10(%ebp),%eax
  80129e:	01 d0                	add    %edx,%eax
  8012a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012a6:	eb 0c                	jmp    8012b4 <strsplit+0x31>
			*string++ = 0;
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	8d 50 01             	lea    0x1(%eax),%edx
  8012ae:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	84 c0                	test   %al,%al
  8012bb:	74 18                	je     8012d5 <strsplit+0x52>
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	0f be c0             	movsbl %al,%eax
  8012c5:	50                   	push   %eax
  8012c6:	ff 75 0c             	pushl  0xc(%ebp)
  8012c9:	e8 13 fb ff ff       	call   800de1 <strchr>
  8012ce:	83 c4 08             	add    $0x8,%esp
  8012d1:	85 c0                	test   %eax,%eax
  8012d3:	75 d3                	jne    8012a8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d8:	8a 00                	mov    (%eax),%al
  8012da:	84 c0                	test   %al,%al
  8012dc:	74 5a                	je     801338 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012de:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e1:	8b 00                	mov    (%eax),%eax
  8012e3:	83 f8 0f             	cmp    $0xf,%eax
  8012e6:	75 07                	jne    8012ef <strsplit+0x6c>
		{
			return 0;
  8012e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8012ed:	eb 66                	jmp    801355 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8012f2:	8b 00                	mov    (%eax),%eax
  8012f4:	8d 48 01             	lea    0x1(%eax),%ecx
  8012f7:	8b 55 14             	mov    0x14(%ebp),%edx
  8012fa:	89 0a                	mov    %ecx,(%edx)
  8012fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801303:	8b 45 10             	mov    0x10(%ebp),%eax
  801306:	01 c2                	add    %eax,%edx
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80130d:	eb 03                	jmp    801312 <strsplit+0x8f>
			string++;
  80130f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	84 c0                	test   %al,%al
  801319:	74 8b                	je     8012a6 <strsplit+0x23>
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	8a 00                	mov    (%eax),%al
  801320:	0f be c0             	movsbl %al,%eax
  801323:	50                   	push   %eax
  801324:	ff 75 0c             	pushl  0xc(%ebp)
  801327:	e8 b5 fa ff ff       	call   800de1 <strchr>
  80132c:	83 c4 08             	add    $0x8,%esp
  80132f:	85 c0                	test   %eax,%eax
  801331:	74 dc                	je     80130f <strsplit+0x8c>
			string++;
	}
  801333:	e9 6e ff ff ff       	jmp    8012a6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801338:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801339:	8b 45 14             	mov    0x14(%ebp),%eax
  80133c:	8b 00                	mov    (%eax),%eax
  80133e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801345:	8b 45 10             	mov    0x10(%ebp),%eax
  801348:	01 d0                	add    %edx,%eax
  80134a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801350:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
  80135a:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	c1 e8 0c             	shr    $0xc,%eax
  801363:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	25 ff 0f 00 00       	and    $0xfff,%eax
  80136e:	85 c0                	test   %eax,%eax
  801370:	74 03                	je     801375 <malloc+0x1e>
			num++;
  801372:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801375:	a1 04 30 80 00       	mov    0x803004,%eax
  80137a:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80137f:	75 73                	jne    8013f4 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801381:	83 ec 08             	sub    $0x8,%esp
  801384:	ff 75 08             	pushl  0x8(%ebp)
  801387:	68 00 00 00 80       	push   $0x80000000
  80138c:	e8 14 05 00 00       	call   8018a5 <sys_allocateMem>
  801391:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801394:	a1 04 30 80 00       	mov    0x803004,%eax
  801399:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80139c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80139f:	c1 e0 0c             	shl    $0xc,%eax
  8013a2:	89 c2                	mov    %eax,%edx
  8013a4:	a1 04 30 80 00       	mov    0x803004,%eax
  8013a9:	01 d0                	add    %edx,%eax
  8013ab:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8013b0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b8:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8013bf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013c4:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8013ca:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8013d1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013d6:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8013dd:	01 00 00 00 
			sizeofarray++;
  8013e1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013e6:	40                   	inc    %eax
  8013e7:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8013ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8013ef:	e9 71 01 00 00       	jmp    801565 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8013f4:	a1 28 30 80 00       	mov    0x803028,%eax
  8013f9:	85 c0                	test   %eax,%eax
  8013fb:	75 71                	jne    80146e <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8013fd:	a1 04 30 80 00       	mov    0x803004,%eax
  801402:	83 ec 08             	sub    $0x8,%esp
  801405:	ff 75 08             	pushl  0x8(%ebp)
  801408:	50                   	push   %eax
  801409:	e8 97 04 00 00       	call   8018a5 <sys_allocateMem>
  80140e:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801411:	a1 04 30 80 00       	mov    0x803004,%eax
  801416:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801419:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80141c:	c1 e0 0c             	shl    $0xc,%eax
  80141f:	89 c2                	mov    %eax,%edx
  801421:	a1 04 30 80 00       	mov    0x803004,%eax
  801426:	01 d0                	add    %edx,%eax
  801428:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  80142d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801432:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801435:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80143c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801441:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801444:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80144b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801450:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801457:	01 00 00 00 
				sizeofarray++;
  80145b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801460:	40                   	inc    %eax
  801461:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801466:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801469:	e9 f7 00 00 00       	jmp    801565 <malloc+0x20e>
			}
			else{
				int count=0;
  80146e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801475:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80147c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801483:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80148a:	eb 7c                	jmp    801508 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  80148c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801493:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80149a:	eb 1a                	jmp    8014b6 <malloc+0x15f>
					{
						if(addresses[j]==i)
  80149c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80149f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8014a6:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8014a9:	75 08                	jne    8014b3 <malloc+0x15c>
						{
							index=j;
  8014ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8014ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8014b1:	eb 0d                	jmp    8014c0 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8014b3:	ff 45 dc             	incl   -0x24(%ebp)
  8014b6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014bb:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8014be:	7c dc                	jl     80149c <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8014c0:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8014c4:	75 05                	jne    8014cb <malloc+0x174>
					{
						count++;
  8014c6:	ff 45 f0             	incl   -0x10(%ebp)
  8014c9:	eb 36                	jmp    801501 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8014cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014ce:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8014d5:	85 c0                	test   %eax,%eax
  8014d7:	75 05                	jne    8014de <malloc+0x187>
						{
							count++;
  8014d9:	ff 45 f0             	incl   -0x10(%ebp)
  8014dc:	eb 23                	jmp    801501 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8014de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014e1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8014e4:	7d 14                	jge    8014fa <malloc+0x1a3>
  8014e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014e9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014ec:	7c 0c                	jl     8014fa <malloc+0x1a3>
							{
								min=count;
  8014ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8014f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8014fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801501:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801508:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80150f:	0f 86 77 ff ff ff    	jbe    80148c <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801515:	83 ec 08             	sub    $0x8,%esp
  801518:	ff 75 08             	pushl  0x8(%ebp)
  80151b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80151e:	e8 82 03 00 00       	call   8018a5 <sys_allocateMem>
  801523:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801526:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80152b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80152e:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801535:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80153a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801540:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801547:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80154c:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801553:	01 00 00 00 
				sizeofarray++;
  801557:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80155c:	40                   	inc    %eax
  80155d:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801562:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801565:	c9                   	leave  
  801566:	c3                   	ret    

00801567 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
  80156a:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  801573:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  80157a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801581:	eb 30                	jmp    8015b3 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801583:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801586:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80158d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801590:	75 1e                	jne    8015b0 <free+0x49>
  801592:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801595:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80159c:	83 f8 01             	cmp    $0x1,%eax
  80159f:	75 0f                	jne    8015b0 <free+0x49>
    		is_found=1;
  8015a1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  8015a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  8015ae:	eb 0d                	jmp    8015bd <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  8015b0:	ff 45 ec             	incl   -0x14(%ebp)
  8015b3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015b8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8015bb:	7c c6                	jl     801583 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  8015bd:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8015c1:	75 3b                	jne    8015fe <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  8015c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015c6:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8015cd:	c1 e0 0c             	shl    $0xc,%eax
  8015d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  8015d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015d6:	83 ec 08             	sub    $0x8,%esp
  8015d9:	50                   	push   %eax
  8015da:	ff 75 e8             	pushl  -0x18(%ebp)
  8015dd:	e8 a7 02 00 00       	call   801889 <sys_freeMem>
  8015e2:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  8015e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e8:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  8015ef:	00 00 00 00 
    	changes++;
  8015f3:	a1 28 30 80 00       	mov    0x803028,%eax
  8015f8:	40                   	inc    %eax
  8015f9:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  8015fe:	90                   	nop
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
  801604:	83 ec 18             	sub    $0x18,%esp
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80160d:	83 ec 04             	sub    $0x4,%esp
  801610:	68 f0 26 80 00       	push   $0x8026f0
  801615:	68 9f 00 00 00       	push   $0x9f
  80161a:	68 13 27 80 00       	push   $0x802713
  80161f:	e8 07 ed ff ff       	call   80032b <_panic>

00801624 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
  801627:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80162a:	83 ec 04             	sub    $0x4,%esp
  80162d:	68 f0 26 80 00       	push   $0x8026f0
  801632:	68 a5 00 00 00       	push   $0xa5
  801637:	68 13 27 80 00       	push   $0x802713
  80163c:	e8 ea ec ff ff       	call   80032b <_panic>

00801641 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801647:	83 ec 04             	sub    $0x4,%esp
  80164a:	68 f0 26 80 00       	push   $0x8026f0
  80164f:	68 ab 00 00 00       	push   $0xab
  801654:	68 13 27 80 00       	push   $0x802713
  801659:	e8 cd ec ff ff       	call   80032b <_panic>

0080165e <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80165e:	55                   	push   %ebp
  80165f:	89 e5                	mov    %esp,%ebp
  801661:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801664:	83 ec 04             	sub    $0x4,%esp
  801667:	68 f0 26 80 00       	push   $0x8026f0
  80166c:	68 b0 00 00 00       	push   $0xb0
  801671:	68 13 27 80 00       	push   $0x802713
  801676:	e8 b0 ec ff ff       	call   80032b <_panic>

0080167b <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
  80167e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801681:	83 ec 04             	sub    $0x4,%esp
  801684:	68 f0 26 80 00       	push   $0x8026f0
  801689:	68 b6 00 00 00       	push   $0xb6
  80168e:	68 13 27 80 00       	push   $0x802713
  801693:	e8 93 ec ff ff       	call   80032b <_panic>

00801698 <shrink>:
}
void shrink(uint32 newSize)
{
  801698:	55                   	push   %ebp
  801699:	89 e5                	mov    %esp,%ebp
  80169b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80169e:	83 ec 04             	sub    $0x4,%esp
  8016a1:	68 f0 26 80 00       	push   $0x8026f0
  8016a6:	68 ba 00 00 00       	push   $0xba
  8016ab:	68 13 27 80 00       	push   $0x802713
  8016b0:	e8 76 ec ff ff       	call   80032b <_panic>

008016b5 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
  8016b8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016bb:	83 ec 04             	sub    $0x4,%esp
  8016be:	68 f0 26 80 00       	push   $0x8026f0
  8016c3:	68 bf 00 00 00       	push   $0xbf
  8016c8:	68 13 27 80 00       	push   $0x802713
  8016cd:	e8 59 ec ff ff       	call   80032b <_panic>

008016d2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016d2:	55                   	push   %ebp
  8016d3:	89 e5                	mov    %esp,%ebp
  8016d5:	57                   	push   %edi
  8016d6:	56                   	push   %esi
  8016d7:	53                   	push   %ebx
  8016d8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016e4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016ea:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016ed:	cd 30                	int    $0x30
  8016ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016f5:	83 c4 10             	add    $0x10,%esp
  8016f8:	5b                   	pop    %ebx
  8016f9:	5e                   	pop    %esi
  8016fa:	5f                   	pop    %edi
  8016fb:	5d                   	pop    %ebp
  8016fc:	c3                   	ret    

008016fd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016fd:	55                   	push   %ebp
  8016fe:	89 e5                	mov    %esp,%ebp
  801700:	83 ec 04             	sub    $0x4,%esp
  801703:	8b 45 10             	mov    0x10(%ebp),%eax
  801706:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801709:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	52                   	push   %edx
  801715:	ff 75 0c             	pushl  0xc(%ebp)
  801718:	50                   	push   %eax
  801719:	6a 00                	push   $0x0
  80171b:	e8 b2 ff ff ff       	call   8016d2 <syscall>
  801720:	83 c4 18             	add    $0x18,%esp
}
  801723:	90                   	nop
  801724:	c9                   	leave  
  801725:	c3                   	ret    

00801726 <sys_cgetc>:

int
sys_cgetc(void)
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 01                	push   $0x1
  801735:	e8 98 ff ff ff       	call   8016d2 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
}
  80173d:	c9                   	leave  
  80173e:	c3                   	ret    

0080173f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80173f:	55                   	push   %ebp
  801740:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	50                   	push   %eax
  80174e:	6a 05                	push   $0x5
  801750:	e8 7d ff ff ff       	call   8016d2 <syscall>
  801755:	83 c4 18             	add    $0x18,%esp
}
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 02                	push   $0x2
  801769:	e8 64 ff ff ff       	call   8016d2 <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 03                	push   $0x3
  801782:	e8 4b ff ff ff       	call   8016d2 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 04                	push   $0x4
  80179b:	e8 32 ff ff ff       	call   8016d2 <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_env_exit>:


void sys_env_exit(void)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 06                	push   $0x6
  8017b4:	e8 19 ff ff ff       	call   8016d2 <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	90                   	nop
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	52                   	push   %edx
  8017cf:	50                   	push   %eax
  8017d0:	6a 07                	push   $0x7
  8017d2:	e8 fb fe ff ff       	call   8016d2 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
  8017df:	56                   	push   %esi
  8017e0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017e1:	8b 75 18             	mov    0x18(%ebp),%esi
  8017e4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f0:	56                   	push   %esi
  8017f1:	53                   	push   %ebx
  8017f2:	51                   	push   %ecx
  8017f3:	52                   	push   %edx
  8017f4:	50                   	push   %eax
  8017f5:	6a 08                	push   $0x8
  8017f7:	e8 d6 fe ff ff       	call   8016d2 <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
}
  8017ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801802:	5b                   	pop    %ebx
  801803:	5e                   	pop    %esi
  801804:	5d                   	pop    %ebp
  801805:	c3                   	ret    

00801806 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801809:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	52                   	push   %edx
  801816:	50                   	push   %eax
  801817:	6a 09                	push   $0x9
  801819:	e8 b4 fe ff ff       	call   8016d2 <syscall>
  80181e:	83 c4 18             	add    $0x18,%esp
}
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	ff 75 0c             	pushl  0xc(%ebp)
  80182f:	ff 75 08             	pushl  0x8(%ebp)
  801832:	6a 0a                	push   $0xa
  801834:	e8 99 fe ff ff       	call   8016d2 <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
}
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 0b                	push   $0xb
  80184d:	e8 80 fe ff ff       	call   8016d2 <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 0c                	push   $0xc
  801866:	e8 67 fe ff ff       	call   8016d2 <syscall>
  80186b:	83 c4 18             	add    $0x18,%esp
}
  80186e:	c9                   	leave  
  80186f:	c3                   	ret    

00801870 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 0d                	push   $0xd
  80187f:	e8 4e fe ff ff       	call   8016d2 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	ff 75 0c             	pushl  0xc(%ebp)
  801895:	ff 75 08             	pushl  0x8(%ebp)
  801898:	6a 11                	push   $0x11
  80189a:	e8 33 fe ff ff       	call   8016d2 <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
	return;
  8018a2:	90                   	nop
}
  8018a3:	c9                   	leave  
  8018a4:	c3                   	ret    

008018a5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	ff 75 0c             	pushl  0xc(%ebp)
  8018b1:	ff 75 08             	pushl  0x8(%ebp)
  8018b4:	6a 12                	push   $0x12
  8018b6:	e8 17 fe ff ff       	call   8016d2 <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8018be:	90                   	nop
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 0e                	push   $0xe
  8018d0:	e8 fd fd ff ff       	call   8016d2 <syscall>
  8018d5:	83 c4 18             	add    $0x18,%esp
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	ff 75 08             	pushl  0x8(%ebp)
  8018e8:	6a 0f                	push   $0xf
  8018ea:	e8 e3 fd ff ff       	call   8016d2 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 10                	push   $0x10
  801903:	e8 ca fd ff ff       	call   8016d2 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
}
  80190b:	90                   	nop
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 14                	push   $0x14
  80191d:	e8 b0 fd ff ff       	call   8016d2 <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
}
  801925:	90                   	nop
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 15                	push   $0x15
  801937:	e8 96 fd ff ff       	call   8016d2 <syscall>
  80193c:	83 c4 18             	add    $0x18,%esp
}
  80193f:	90                   	nop
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <sys_cputc>:


void
sys_cputc(const char c)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
  801945:	83 ec 04             	sub    $0x4,%esp
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80194e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	50                   	push   %eax
  80195b:	6a 16                	push   $0x16
  80195d:	e8 70 fd ff ff       	call   8016d2 <syscall>
  801962:	83 c4 18             	add    $0x18,%esp
}
  801965:	90                   	nop
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 17                	push   $0x17
  801977:	e8 56 fd ff ff       	call   8016d2 <syscall>
  80197c:	83 c4 18             	add    $0x18,%esp
}
  80197f:	90                   	nop
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	ff 75 0c             	pushl  0xc(%ebp)
  801991:	50                   	push   %eax
  801992:	6a 18                	push   $0x18
  801994:	e8 39 fd ff ff       	call   8016d2 <syscall>
  801999:	83 c4 18             	add    $0x18,%esp
}
  80199c:	c9                   	leave  
  80199d:	c3                   	ret    

0080199e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80199e:	55                   	push   %ebp
  80199f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	52                   	push   %edx
  8019ae:	50                   	push   %eax
  8019af:	6a 1b                	push   $0x1b
  8019b1:	e8 1c fd ff ff       	call   8016d2 <syscall>
  8019b6:	83 c4 18             	add    $0x18,%esp
}
  8019b9:	c9                   	leave  
  8019ba:	c3                   	ret    

008019bb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019bb:	55                   	push   %ebp
  8019bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	52                   	push   %edx
  8019cb:	50                   	push   %eax
  8019cc:	6a 19                	push   $0x19
  8019ce:	e8 ff fc ff ff       	call   8016d2 <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
}
  8019d6:	90                   	nop
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019df:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	52                   	push   %edx
  8019e9:	50                   	push   %eax
  8019ea:	6a 1a                	push   $0x1a
  8019ec:	e8 e1 fc ff ff       	call   8016d2 <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	90                   	nop
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
  8019fa:	83 ec 04             	sub    $0x4,%esp
  8019fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801a00:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a03:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a06:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0d:	6a 00                	push   $0x0
  801a0f:	51                   	push   %ecx
  801a10:	52                   	push   %edx
  801a11:	ff 75 0c             	pushl  0xc(%ebp)
  801a14:	50                   	push   %eax
  801a15:	6a 1c                	push   $0x1c
  801a17:	e8 b6 fc ff ff       	call   8016d2 <syscall>
  801a1c:	83 c4 18             	add    $0x18,%esp
}
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    

00801a21 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a21:	55                   	push   %ebp
  801a22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a24:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	52                   	push   %edx
  801a31:	50                   	push   %eax
  801a32:	6a 1d                	push   $0x1d
  801a34:	e8 99 fc ff ff       	call   8016d2 <syscall>
  801a39:	83 c4 18             	add    $0x18,%esp
}
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a41:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a47:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	51                   	push   %ecx
  801a4f:	52                   	push   %edx
  801a50:	50                   	push   %eax
  801a51:	6a 1e                	push   $0x1e
  801a53:	e8 7a fc ff ff       	call   8016d2 <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
}
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	52                   	push   %edx
  801a6d:	50                   	push   %eax
  801a6e:	6a 1f                	push   $0x1f
  801a70:	e8 5d fc ff ff       	call   8016d2 <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
}
  801a78:	c9                   	leave  
  801a79:	c3                   	ret    

00801a7a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 20                	push   $0x20
  801a89:	e8 44 fc ff ff       	call   8016d2 <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
}
  801a91:	c9                   	leave  
  801a92:	c3                   	ret    

00801a93 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801a96:	8b 45 08             	mov    0x8(%ebp),%eax
  801a99:	6a 00                	push   $0x0
  801a9b:	ff 75 14             	pushl  0x14(%ebp)
  801a9e:	ff 75 10             	pushl  0x10(%ebp)
  801aa1:	ff 75 0c             	pushl  0xc(%ebp)
  801aa4:	50                   	push   %eax
  801aa5:	6a 21                	push   $0x21
  801aa7:	e8 26 fc ff ff       	call   8016d2 <syscall>
  801aac:	83 c4 18             	add    $0x18,%esp
}
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	50                   	push   %eax
  801ac0:	6a 22                	push   $0x22
  801ac2:	e8 0b fc ff ff       	call   8016d2 <syscall>
  801ac7:	83 c4 18             	add    $0x18,%esp
}
  801aca:	90                   	nop
  801acb:	c9                   	leave  
  801acc:	c3                   	ret    

00801acd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	50                   	push   %eax
  801adc:	6a 23                	push   $0x23
  801ade:	e8 ef fb ff ff       	call   8016d2 <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
}
  801ae6:	90                   	nop
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
  801aec:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801aef:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801af2:	8d 50 04             	lea    0x4(%eax),%edx
  801af5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	52                   	push   %edx
  801aff:	50                   	push   %eax
  801b00:	6a 24                	push   $0x24
  801b02:	e8 cb fb ff ff       	call   8016d2 <syscall>
  801b07:	83 c4 18             	add    $0x18,%esp
	return result;
  801b0a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b10:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b13:	89 01                	mov    %eax,(%ecx)
  801b15:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	c9                   	leave  
  801b1c:	c2 04 00             	ret    $0x4

00801b1f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	ff 75 10             	pushl  0x10(%ebp)
  801b29:	ff 75 0c             	pushl  0xc(%ebp)
  801b2c:	ff 75 08             	pushl  0x8(%ebp)
  801b2f:	6a 13                	push   $0x13
  801b31:	e8 9c fb ff ff       	call   8016d2 <syscall>
  801b36:	83 c4 18             	add    $0x18,%esp
	return ;
  801b39:	90                   	nop
}
  801b3a:	c9                   	leave  
  801b3b:	c3                   	ret    

00801b3c <sys_rcr2>:
uint32 sys_rcr2()
{
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 25                	push   $0x25
  801b4b:	e8 82 fb ff ff       	call   8016d2 <syscall>
  801b50:	83 c4 18             	add    $0x18,%esp
}
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
  801b58:	83 ec 04             	sub    $0x4,%esp
  801b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b61:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	50                   	push   %eax
  801b6e:	6a 26                	push   $0x26
  801b70:	e8 5d fb ff ff       	call   8016d2 <syscall>
  801b75:	83 c4 18             	add    $0x18,%esp
	return ;
  801b78:	90                   	nop
}
  801b79:	c9                   	leave  
  801b7a:	c3                   	ret    

00801b7b <rsttst>:
void rsttst()
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 28                	push   $0x28
  801b8a:	e8 43 fb ff ff       	call   8016d2 <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b92:	90                   	nop
}
  801b93:	c9                   	leave  
  801b94:	c3                   	ret    

00801b95 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b95:	55                   	push   %ebp
  801b96:	89 e5                	mov    %esp,%ebp
  801b98:	83 ec 04             	sub    $0x4,%esp
  801b9b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ba1:	8b 55 18             	mov    0x18(%ebp),%edx
  801ba4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ba8:	52                   	push   %edx
  801ba9:	50                   	push   %eax
  801baa:	ff 75 10             	pushl  0x10(%ebp)
  801bad:	ff 75 0c             	pushl  0xc(%ebp)
  801bb0:	ff 75 08             	pushl  0x8(%ebp)
  801bb3:	6a 27                	push   $0x27
  801bb5:	e8 18 fb ff ff       	call   8016d2 <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbd:	90                   	nop
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <chktst>:
void chktst(uint32 n)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	ff 75 08             	pushl  0x8(%ebp)
  801bce:	6a 29                	push   $0x29
  801bd0:	e8 fd fa ff ff       	call   8016d2 <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd8:	90                   	nop
}
  801bd9:	c9                   	leave  
  801bda:	c3                   	ret    

00801bdb <inctst>:

void inctst()
{
  801bdb:	55                   	push   %ebp
  801bdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 2a                	push   $0x2a
  801bea:	e8 e3 fa ff ff       	call   8016d2 <syscall>
  801bef:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf2:	90                   	nop
}
  801bf3:	c9                   	leave  
  801bf4:	c3                   	ret    

00801bf5 <gettst>:
uint32 gettst()
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 2b                	push   $0x2b
  801c04:	e8 c9 fa ff ff       	call   8016d2 <syscall>
  801c09:	83 c4 18             	add    $0x18,%esp
}
  801c0c:	c9                   	leave  
  801c0d:	c3                   	ret    

00801c0e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
  801c11:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 2c                	push   $0x2c
  801c20:	e8 ad fa ff ff       	call   8016d2 <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
  801c28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c2b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c2f:	75 07                	jne    801c38 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c31:	b8 01 00 00 00       	mov    $0x1,%eax
  801c36:	eb 05                	jmp    801c3d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c38:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
  801c42:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 2c                	push   $0x2c
  801c51:	e8 7c fa ff ff       	call   8016d2 <syscall>
  801c56:	83 c4 18             	add    $0x18,%esp
  801c59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c5c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c60:	75 07                	jne    801c69 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c62:	b8 01 00 00 00       	mov    $0x1,%eax
  801c67:	eb 05                	jmp    801c6e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c69:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6e:	c9                   	leave  
  801c6f:	c3                   	ret    

00801c70 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
  801c73:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 2c                	push   $0x2c
  801c82:	e8 4b fa ff ff       	call   8016d2 <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
  801c8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c8d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c91:	75 07                	jne    801c9a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c93:	b8 01 00 00 00       	mov    $0x1,%eax
  801c98:	eb 05                	jmp    801c9f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9f:	c9                   	leave  
  801ca0:	c3                   	ret    

00801ca1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
  801ca4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 2c                	push   $0x2c
  801cb3:	e8 1a fa ff ff       	call   8016d2 <syscall>
  801cb8:	83 c4 18             	add    $0x18,%esp
  801cbb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cbe:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cc2:	75 07                	jne    801ccb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cc4:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc9:	eb 05                	jmp    801cd0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ccb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	ff 75 08             	pushl  0x8(%ebp)
  801ce0:	6a 2d                	push   $0x2d
  801ce2:	e8 eb f9 ff ff       	call   8016d2 <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
	return ;
  801cea:	90                   	nop
}
  801ceb:	c9                   	leave  
  801cec:	c3                   	ret    

00801ced <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ced:	55                   	push   %ebp
  801cee:	89 e5                	mov    %esp,%ebp
  801cf0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801cf1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cf4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cf7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfd:	6a 00                	push   $0x0
  801cff:	53                   	push   %ebx
  801d00:	51                   	push   %ecx
  801d01:	52                   	push   %edx
  801d02:	50                   	push   %eax
  801d03:	6a 2e                	push   $0x2e
  801d05:	e8 c8 f9 ff ff       	call   8016d2 <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
}
  801d0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d18:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	52                   	push   %edx
  801d22:	50                   	push   %eax
  801d23:	6a 2f                	push   $0x2f
  801d25:	e8 a8 f9 ff ff       	call   8016d2 <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
}
  801d2d:	c9                   	leave  
  801d2e:	c3                   	ret    
  801d2f:	90                   	nop

00801d30 <__udivdi3>:
  801d30:	55                   	push   %ebp
  801d31:	57                   	push   %edi
  801d32:	56                   	push   %esi
  801d33:	53                   	push   %ebx
  801d34:	83 ec 1c             	sub    $0x1c,%esp
  801d37:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d3b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d43:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d47:	89 ca                	mov    %ecx,%edx
  801d49:	89 f8                	mov    %edi,%eax
  801d4b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d4f:	85 f6                	test   %esi,%esi
  801d51:	75 2d                	jne    801d80 <__udivdi3+0x50>
  801d53:	39 cf                	cmp    %ecx,%edi
  801d55:	77 65                	ja     801dbc <__udivdi3+0x8c>
  801d57:	89 fd                	mov    %edi,%ebp
  801d59:	85 ff                	test   %edi,%edi
  801d5b:	75 0b                	jne    801d68 <__udivdi3+0x38>
  801d5d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d62:	31 d2                	xor    %edx,%edx
  801d64:	f7 f7                	div    %edi
  801d66:	89 c5                	mov    %eax,%ebp
  801d68:	31 d2                	xor    %edx,%edx
  801d6a:	89 c8                	mov    %ecx,%eax
  801d6c:	f7 f5                	div    %ebp
  801d6e:	89 c1                	mov    %eax,%ecx
  801d70:	89 d8                	mov    %ebx,%eax
  801d72:	f7 f5                	div    %ebp
  801d74:	89 cf                	mov    %ecx,%edi
  801d76:	89 fa                	mov    %edi,%edx
  801d78:	83 c4 1c             	add    $0x1c,%esp
  801d7b:	5b                   	pop    %ebx
  801d7c:	5e                   	pop    %esi
  801d7d:	5f                   	pop    %edi
  801d7e:	5d                   	pop    %ebp
  801d7f:	c3                   	ret    
  801d80:	39 ce                	cmp    %ecx,%esi
  801d82:	77 28                	ja     801dac <__udivdi3+0x7c>
  801d84:	0f bd fe             	bsr    %esi,%edi
  801d87:	83 f7 1f             	xor    $0x1f,%edi
  801d8a:	75 40                	jne    801dcc <__udivdi3+0x9c>
  801d8c:	39 ce                	cmp    %ecx,%esi
  801d8e:	72 0a                	jb     801d9a <__udivdi3+0x6a>
  801d90:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d94:	0f 87 9e 00 00 00    	ja     801e38 <__udivdi3+0x108>
  801d9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d9f:	89 fa                	mov    %edi,%edx
  801da1:	83 c4 1c             	add    $0x1c,%esp
  801da4:	5b                   	pop    %ebx
  801da5:	5e                   	pop    %esi
  801da6:	5f                   	pop    %edi
  801da7:	5d                   	pop    %ebp
  801da8:	c3                   	ret    
  801da9:	8d 76 00             	lea    0x0(%esi),%esi
  801dac:	31 ff                	xor    %edi,%edi
  801dae:	31 c0                	xor    %eax,%eax
  801db0:	89 fa                	mov    %edi,%edx
  801db2:	83 c4 1c             	add    $0x1c,%esp
  801db5:	5b                   	pop    %ebx
  801db6:	5e                   	pop    %esi
  801db7:	5f                   	pop    %edi
  801db8:	5d                   	pop    %ebp
  801db9:	c3                   	ret    
  801dba:	66 90                	xchg   %ax,%ax
  801dbc:	89 d8                	mov    %ebx,%eax
  801dbe:	f7 f7                	div    %edi
  801dc0:	31 ff                	xor    %edi,%edi
  801dc2:	89 fa                	mov    %edi,%edx
  801dc4:	83 c4 1c             	add    $0x1c,%esp
  801dc7:	5b                   	pop    %ebx
  801dc8:	5e                   	pop    %esi
  801dc9:	5f                   	pop    %edi
  801dca:	5d                   	pop    %ebp
  801dcb:	c3                   	ret    
  801dcc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dd1:	89 eb                	mov    %ebp,%ebx
  801dd3:	29 fb                	sub    %edi,%ebx
  801dd5:	89 f9                	mov    %edi,%ecx
  801dd7:	d3 e6                	shl    %cl,%esi
  801dd9:	89 c5                	mov    %eax,%ebp
  801ddb:	88 d9                	mov    %bl,%cl
  801ddd:	d3 ed                	shr    %cl,%ebp
  801ddf:	89 e9                	mov    %ebp,%ecx
  801de1:	09 f1                	or     %esi,%ecx
  801de3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801de7:	89 f9                	mov    %edi,%ecx
  801de9:	d3 e0                	shl    %cl,%eax
  801deb:	89 c5                	mov    %eax,%ebp
  801ded:	89 d6                	mov    %edx,%esi
  801def:	88 d9                	mov    %bl,%cl
  801df1:	d3 ee                	shr    %cl,%esi
  801df3:	89 f9                	mov    %edi,%ecx
  801df5:	d3 e2                	shl    %cl,%edx
  801df7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dfb:	88 d9                	mov    %bl,%cl
  801dfd:	d3 e8                	shr    %cl,%eax
  801dff:	09 c2                	or     %eax,%edx
  801e01:	89 d0                	mov    %edx,%eax
  801e03:	89 f2                	mov    %esi,%edx
  801e05:	f7 74 24 0c          	divl   0xc(%esp)
  801e09:	89 d6                	mov    %edx,%esi
  801e0b:	89 c3                	mov    %eax,%ebx
  801e0d:	f7 e5                	mul    %ebp
  801e0f:	39 d6                	cmp    %edx,%esi
  801e11:	72 19                	jb     801e2c <__udivdi3+0xfc>
  801e13:	74 0b                	je     801e20 <__udivdi3+0xf0>
  801e15:	89 d8                	mov    %ebx,%eax
  801e17:	31 ff                	xor    %edi,%edi
  801e19:	e9 58 ff ff ff       	jmp    801d76 <__udivdi3+0x46>
  801e1e:	66 90                	xchg   %ax,%ax
  801e20:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e24:	89 f9                	mov    %edi,%ecx
  801e26:	d3 e2                	shl    %cl,%edx
  801e28:	39 c2                	cmp    %eax,%edx
  801e2a:	73 e9                	jae    801e15 <__udivdi3+0xe5>
  801e2c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e2f:	31 ff                	xor    %edi,%edi
  801e31:	e9 40 ff ff ff       	jmp    801d76 <__udivdi3+0x46>
  801e36:	66 90                	xchg   %ax,%ax
  801e38:	31 c0                	xor    %eax,%eax
  801e3a:	e9 37 ff ff ff       	jmp    801d76 <__udivdi3+0x46>
  801e3f:	90                   	nop

00801e40 <__umoddi3>:
  801e40:	55                   	push   %ebp
  801e41:	57                   	push   %edi
  801e42:	56                   	push   %esi
  801e43:	53                   	push   %ebx
  801e44:	83 ec 1c             	sub    $0x1c,%esp
  801e47:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e4b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e4f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e53:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e57:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e5b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e5f:	89 f3                	mov    %esi,%ebx
  801e61:	89 fa                	mov    %edi,%edx
  801e63:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e67:	89 34 24             	mov    %esi,(%esp)
  801e6a:	85 c0                	test   %eax,%eax
  801e6c:	75 1a                	jne    801e88 <__umoddi3+0x48>
  801e6e:	39 f7                	cmp    %esi,%edi
  801e70:	0f 86 a2 00 00 00    	jbe    801f18 <__umoddi3+0xd8>
  801e76:	89 c8                	mov    %ecx,%eax
  801e78:	89 f2                	mov    %esi,%edx
  801e7a:	f7 f7                	div    %edi
  801e7c:	89 d0                	mov    %edx,%eax
  801e7e:	31 d2                	xor    %edx,%edx
  801e80:	83 c4 1c             	add    $0x1c,%esp
  801e83:	5b                   	pop    %ebx
  801e84:	5e                   	pop    %esi
  801e85:	5f                   	pop    %edi
  801e86:	5d                   	pop    %ebp
  801e87:	c3                   	ret    
  801e88:	39 f0                	cmp    %esi,%eax
  801e8a:	0f 87 ac 00 00 00    	ja     801f3c <__umoddi3+0xfc>
  801e90:	0f bd e8             	bsr    %eax,%ebp
  801e93:	83 f5 1f             	xor    $0x1f,%ebp
  801e96:	0f 84 ac 00 00 00    	je     801f48 <__umoddi3+0x108>
  801e9c:	bf 20 00 00 00       	mov    $0x20,%edi
  801ea1:	29 ef                	sub    %ebp,%edi
  801ea3:	89 fe                	mov    %edi,%esi
  801ea5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ea9:	89 e9                	mov    %ebp,%ecx
  801eab:	d3 e0                	shl    %cl,%eax
  801ead:	89 d7                	mov    %edx,%edi
  801eaf:	89 f1                	mov    %esi,%ecx
  801eb1:	d3 ef                	shr    %cl,%edi
  801eb3:	09 c7                	or     %eax,%edi
  801eb5:	89 e9                	mov    %ebp,%ecx
  801eb7:	d3 e2                	shl    %cl,%edx
  801eb9:	89 14 24             	mov    %edx,(%esp)
  801ebc:	89 d8                	mov    %ebx,%eax
  801ebe:	d3 e0                	shl    %cl,%eax
  801ec0:	89 c2                	mov    %eax,%edx
  801ec2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec6:	d3 e0                	shl    %cl,%eax
  801ec8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ecc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ed0:	89 f1                	mov    %esi,%ecx
  801ed2:	d3 e8                	shr    %cl,%eax
  801ed4:	09 d0                	or     %edx,%eax
  801ed6:	d3 eb                	shr    %cl,%ebx
  801ed8:	89 da                	mov    %ebx,%edx
  801eda:	f7 f7                	div    %edi
  801edc:	89 d3                	mov    %edx,%ebx
  801ede:	f7 24 24             	mull   (%esp)
  801ee1:	89 c6                	mov    %eax,%esi
  801ee3:	89 d1                	mov    %edx,%ecx
  801ee5:	39 d3                	cmp    %edx,%ebx
  801ee7:	0f 82 87 00 00 00    	jb     801f74 <__umoddi3+0x134>
  801eed:	0f 84 91 00 00 00    	je     801f84 <__umoddi3+0x144>
  801ef3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ef7:	29 f2                	sub    %esi,%edx
  801ef9:	19 cb                	sbb    %ecx,%ebx
  801efb:	89 d8                	mov    %ebx,%eax
  801efd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f01:	d3 e0                	shl    %cl,%eax
  801f03:	89 e9                	mov    %ebp,%ecx
  801f05:	d3 ea                	shr    %cl,%edx
  801f07:	09 d0                	or     %edx,%eax
  801f09:	89 e9                	mov    %ebp,%ecx
  801f0b:	d3 eb                	shr    %cl,%ebx
  801f0d:	89 da                	mov    %ebx,%edx
  801f0f:	83 c4 1c             	add    $0x1c,%esp
  801f12:	5b                   	pop    %ebx
  801f13:	5e                   	pop    %esi
  801f14:	5f                   	pop    %edi
  801f15:	5d                   	pop    %ebp
  801f16:	c3                   	ret    
  801f17:	90                   	nop
  801f18:	89 fd                	mov    %edi,%ebp
  801f1a:	85 ff                	test   %edi,%edi
  801f1c:	75 0b                	jne    801f29 <__umoddi3+0xe9>
  801f1e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f23:	31 d2                	xor    %edx,%edx
  801f25:	f7 f7                	div    %edi
  801f27:	89 c5                	mov    %eax,%ebp
  801f29:	89 f0                	mov    %esi,%eax
  801f2b:	31 d2                	xor    %edx,%edx
  801f2d:	f7 f5                	div    %ebp
  801f2f:	89 c8                	mov    %ecx,%eax
  801f31:	f7 f5                	div    %ebp
  801f33:	89 d0                	mov    %edx,%eax
  801f35:	e9 44 ff ff ff       	jmp    801e7e <__umoddi3+0x3e>
  801f3a:	66 90                	xchg   %ax,%ax
  801f3c:	89 c8                	mov    %ecx,%eax
  801f3e:	89 f2                	mov    %esi,%edx
  801f40:	83 c4 1c             	add    $0x1c,%esp
  801f43:	5b                   	pop    %ebx
  801f44:	5e                   	pop    %esi
  801f45:	5f                   	pop    %edi
  801f46:	5d                   	pop    %ebp
  801f47:	c3                   	ret    
  801f48:	3b 04 24             	cmp    (%esp),%eax
  801f4b:	72 06                	jb     801f53 <__umoddi3+0x113>
  801f4d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f51:	77 0f                	ja     801f62 <__umoddi3+0x122>
  801f53:	89 f2                	mov    %esi,%edx
  801f55:	29 f9                	sub    %edi,%ecx
  801f57:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f5b:	89 14 24             	mov    %edx,(%esp)
  801f5e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f62:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f66:	8b 14 24             	mov    (%esp),%edx
  801f69:	83 c4 1c             	add    $0x1c,%esp
  801f6c:	5b                   	pop    %ebx
  801f6d:	5e                   	pop    %esi
  801f6e:	5f                   	pop    %edi
  801f6f:	5d                   	pop    %ebp
  801f70:	c3                   	ret    
  801f71:	8d 76 00             	lea    0x0(%esi),%esi
  801f74:	2b 04 24             	sub    (%esp),%eax
  801f77:	19 fa                	sbb    %edi,%edx
  801f79:	89 d1                	mov    %edx,%ecx
  801f7b:	89 c6                	mov    %eax,%esi
  801f7d:	e9 71 ff ff ff       	jmp    801ef3 <__umoddi3+0xb3>
  801f82:	66 90                	xchg   %ax,%ax
  801f84:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f88:	72 ea                	jb     801f74 <__umoddi3+0x134>
  801f8a:	89 d9                	mov    %ebx,%ecx
  801f8c:	e9 62 ff ff ff       	jmp    801ef3 <__umoddi3+0xb3>
