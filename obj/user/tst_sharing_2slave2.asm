
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
  800087:	68 20 1d 80 00       	push   $0x801d20
  80008c:	6a 13                	push   $0x13
  80008e:	68 3c 1d 80 00       	push   $0x801d3c
  800093:	e8 93 02 00 00       	call   80032b <_panic>
	}

	int32 parentenvID = sys_getparentenvid();
  800098:	e8 64 14 00 00       	call   801501 <sys_getparentenvid>
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	uint32 *x, *z;

	//GET: z then x, opposite to creation order (x then y then z)
	//So, addresses here will be different from the OWNER addresses
	sys_disable_interrupt();
  8000a0:	e8 de 15 00 00       	call   801683 <sys_disable_interrupt>
	int freeFrames = sys_calculate_free_frames() ;
  8000a5:	e8 09 15 00 00       	call   8015b3 <sys_calculate_free_frames>
  8000aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
	z = sget(parentenvID,"z");
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	68 57 1d 80 00       	push   $0x801d57
  8000b5:	ff 75 ec             	pushl  -0x14(%ebp)
  8000b8:	e8 ee 12 00 00       	call   8013ab <sget>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 0 * PAGE_SIZE)) panic("Get(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000c3:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 5c 1d 80 00       	push   $0x801d5c
  8000d4:	6a 1e                	push   $0x1e
  8000d6:	68 3c 1d 80 00       	push   $0x801d3c
  8000db:	e8 4b 02 00 00       	call   80032b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1) panic("Get(): Wrong sharing- make sure that you share the required space in the current user environment using the correct frames (from frames_storage)");
  8000e0:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000e3:	e8 cb 14 00 00       	call   8015b3 <sys_calculate_free_frames>
  8000e8:	29 c3                	sub    %eax,%ebx
  8000ea:	89 d8                	mov    %ebx,%eax
  8000ec:	83 f8 01             	cmp    $0x1,%eax
  8000ef:	74 14                	je     800105 <_main+0xcd>
  8000f1:	83 ec 04             	sub    $0x4,%esp
  8000f4:	68 bc 1d 80 00       	push   $0x801dbc
  8000f9:	6a 1f                	push   $0x1f
  8000fb:	68 3c 1d 80 00       	push   $0x801d3c
  800100:	e8 26 02 00 00       	call   80032b <_panic>
	sys_enable_interrupt();
  800105:	e8 93 15 00 00       	call   80169d <sys_enable_interrupt>

	sys_disable_interrupt();
  80010a:	e8 74 15 00 00       	call   801683 <sys_disable_interrupt>
	freeFrames = sys_calculate_free_frames() ;
  80010f:	e8 9f 14 00 00       	call   8015b3 <sys_calculate_free_frames>
  800114:	89 45 e8             	mov    %eax,-0x18(%ebp)
	x = sget(parentenvID,"x");
  800117:	83 ec 08             	sub    $0x8,%esp
  80011a:	68 4d 1e 80 00       	push   $0x801e4d
  80011f:	ff 75 ec             	pushl  -0x14(%ebp)
  800122:	e8 84 12 00 00       	call   8013ab <sget>
  800127:	83 c4 10             	add    $0x10,%esp
  80012a:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (x != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Get(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  80012d:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 5c 1d 80 00       	push   $0x801d5c
  80013e:	6a 25                	push   $0x25
  800140:	68 3c 1d 80 00       	push   $0x801d3c
  800145:	e8 e1 01 00 00       	call   80032b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Get(): Wrong sharing- make sure that you share the required space in the current user environment using the correct frames (from frames_storage)");
  80014a:	e8 64 14 00 00       	call   8015b3 <sys_calculate_free_frames>
  80014f:	89 c2                	mov    %eax,%edx
  800151:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800154:	39 c2                	cmp    %eax,%edx
  800156:	74 14                	je     80016c <_main+0x134>
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	68 bc 1d 80 00       	push   $0x801dbc
  800160:	6a 26                	push   $0x26
  800162:	68 3c 1d 80 00       	push   $0x801d3c
  800167:	e8 bf 01 00 00       	call   80032b <_panic>
	sys_enable_interrupt();
  80016c:	e8 2c 15 00 00       	call   80169d <sys_enable_interrupt>

	if (*x != 10) panic("Get(): Shared Variable is not created or got correctly") ;
  800171:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800174:	8b 00                	mov    (%eax),%eax
  800176:	83 f8 0a             	cmp    $0xa,%eax
  800179:	74 14                	je     80018f <_main+0x157>
  80017b:	83 ec 04             	sub    $0x4,%esp
  80017e:	68 50 1e 80 00       	push   $0x801e50
  800183:	6a 29                	push   $0x29
  800185:	68 3c 1d 80 00       	push   $0x801d3c
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
  8001a5:	68 50 1e 80 00       	push   $0x801e50
  8001aa:	6a 2d                	push   $0x2d
  8001ac:	68 3c 1d 80 00       	push   $0x801d3c
  8001b1:	e8 75 01 00 00       	call   80032b <_panic>

	//Attempt to edit the ReadOnly object, it should panic
	cprintf("Attempt to edit the ReadOnly object @ va = %x\n", x);
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	ff 75 e0             	pushl  -0x20(%ebp)
  8001bc:	68 88 1e 80 00       	push   $0x801e88
  8001c1:	e8 07 04 00 00       	call   8005cd <cprintf>
  8001c6:	83 c4 10             	add    $0x10,%esp
	*x = 100;
  8001c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001cc:	c7 00 64 00 00 00    	movl   $0x64,(%eax)

	panic("Test FAILED! it should panic early and not reach this line of code") ;
  8001d2:	83 ec 04             	sub    $0x4,%esp
  8001d5:	68 b8 1e 80 00       	push   $0x801eb8
  8001da:	6a 33                	push   $0x33
  8001dc:	68 3c 1d 80 00       	push   $0x801d3c
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
  8001ec:	e8 f7 12 00 00       	call   8014e8 <sys_getenvindex>
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
  800269:	e8 15 14 00 00       	call   801683 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	68 14 1f 80 00       	push   $0x801f14
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
  800299:	68 3c 1f 80 00       	push   $0x801f3c
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
  8002c1:	68 64 1f 80 00       	push   $0x801f64
  8002c6:	e8 02 03 00 00       	call   8005cd <cprintf>
  8002cb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d3:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002d9:	83 ec 08             	sub    $0x8,%esp
  8002dc:	50                   	push   %eax
  8002dd:	68 a5 1f 80 00       	push   $0x801fa5
  8002e2:	e8 e6 02 00 00       	call   8005cd <cprintf>
  8002e7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	68 14 1f 80 00       	push   $0x801f14
  8002f2:	e8 d6 02 00 00       	call   8005cd <cprintf>
  8002f7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002fa:	e8 9e 13 00 00       	call   80169d <sys_enable_interrupt>

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
  800312:	e8 9d 11 00 00       	call   8014b4 <sys_env_destroy>
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
  800323:	e8 f2 11 00 00       	call   80151a <sys_env_exit>
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
  80034c:	68 bc 1f 80 00       	push   $0x801fbc
  800351:	e8 77 02 00 00       	call   8005cd <cprintf>
  800356:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800359:	a1 00 30 80 00       	mov    0x803000,%eax
  80035e:	ff 75 0c             	pushl  0xc(%ebp)
  800361:	ff 75 08             	pushl  0x8(%ebp)
  800364:	50                   	push   %eax
  800365:	68 c1 1f 80 00       	push   $0x801fc1
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
  800389:	68 dd 1f 80 00       	push   $0x801fdd
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
  8003b5:	68 e0 1f 80 00       	push   $0x801fe0
  8003ba:	6a 26                	push   $0x26
  8003bc:	68 2c 20 80 00       	push   $0x80202c
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
  80047b:	68 38 20 80 00       	push   $0x802038
  800480:	6a 3a                	push   $0x3a
  800482:	68 2c 20 80 00       	push   $0x80202c
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
  8004e5:	68 8c 20 80 00       	push   $0x80208c
  8004ea:	6a 44                	push   $0x44
  8004ec:	68 2c 20 80 00       	push   $0x80202c
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
  80053f:	e8 2e 0f 00 00       	call   801472 <sys_cputs>
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
  8005b6:	e8 b7 0e 00 00       	call   801472 <sys_cputs>
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
  800600:	e8 7e 10 00 00       	call   801683 <sys_disable_interrupt>
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
  800620:	e8 78 10 00 00       	call   80169d <sys_enable_interrupt>
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
  80066a:	e8 35 14 00 00       	call   801aa4 <__udivdi3>
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
  8006ba:	e8 f5 14 00 00       	call   801bb4 <__umoddi3>
  8006bf:	83 c4 10             	add    $0x10,%esp
  8006c2:	05 f4 22 80 00       	add    $0x8022f4,%eax
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
  800815:	8b 04 85 18 23 80 00 	mov    0x802318(,%eax,4),%eax
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
  8008f6:	8b 34 9d 60 21 80 00 	mov    0x802160(,%ebx,4),%esi
  8008fd:	85 f6                	test   %esi,%esi
  8008ff:	75 19                	jne    80091a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800901:	53                   	push   %ebx
  800902:	68 05 23 80 00       	push   $0x802305
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
  80091b:	68 0e 23 80 00       	push   $0x80230e
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
  800948:	be 11 23 80 00       	mov    $0x802311,%esi
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

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
  80135a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80135d:	83 ec 04             	sub    $0x4,%esp
  801360:	68 70 24 80 00       	push   $0x802470
  801365:	6a 16                	push   $0x16
  801367:	68 95 24 80 00       	push   $0x802495
  80136c:	e8 ba ef ff ff       	call   80032b <_panic>

00801371 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
  801374:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801377:	83 ec 04             	sub    $0x4,%esp
  80137a:	68 a4 24 80 00       	push   $0x8024a4
  80137f:	6a 2e                	push   $0x2e
  801381:	68 95 24 80 00       	push   $0x802495
  801386:	e8 a0 ef ff ff       	call   80032b <_panic>

0080138b <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
  80138e:	83 ec 18             	sub    $0x18,%esp
  801391:	8b 45 10             	mov    0x10(%ebp),%eax
  801394:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801397:	83 ec 04             	sub    $0x4,%esp
  80139a:	68 c8 24 80 00       	push   $0x8024c8
  80139f:	6a 3b                	push   $0x3b
  8013a1:	68 95 24 80 00       	push   $0x802495
  8013a6:	e8 80 ef ff ff       	call   80032b <_panic>

008013ab <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
  8013ae:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013b1:	83 ec 04             	sub    $0x4,%esp
  8013b4:	68 c8 24 80 00       	push   $0x8024c8
  8013b9:	6a 41                	push   $0x41
  8013bb:	68 95 24 80 00       	push   $0x802495
  8013c0:	e8 66 ef ff ff       	call   80032b <_panic>

008013c5 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8013c5:	55                   	push   %ebp
  8013c6:	89 e5                	mov    %esp,%ebp
  8013c8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013cb:	83 ec 04             	sub    $0x4,%esp
  8013ce:	68 c8 24 80 00       	push   $0x8024c8
  8013d3:	6a 47                	push   $0x47
  8013d5:	68 95 24 80 00       	push   $0x802495
  8013da:	e8 4c ef ff ff       	call   80032b <_panic>

008013df <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8013df:	55                   	push   %ebp
  8013e0:	89 e5                	mov    %esp,%ebp
  8013e2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013e5:	83 ec 04             	sub    $0x4,%esp
  8013e8:	68 c8 24 80 00       	push   $0x8024c8
  8013ed:	6a 4c                	push   $0x4c
  8013ef:	68 95 24 80 00       	push   $0x802495
  8013f4:	e8 32 ef ff ff       	call   80032b <_panic>

008013f9 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
  8013fc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013ff:	83 ec 04             	sub    $0x4,%esp
  801402:	68 c8 24 80 00       	push   $0x8024c8
  801407:	6a 52                	push   $0x52
  801409:	68 95 24 80 00       	push   $0x802495
  80140e:	e8 18 ef ff ff       	call   80032b <_panic>

00801413 <shrink>:
}
void shrink(uint32 newSize)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
  801416:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801419:	83 ec 04             	sub    $0x4,%esp
  80141c:	68 c8 24 80 00       	push   $0x8024c8
  801421:	6a 56                	push   $0x56
  801423:	68 95 24 80 00       	push   $0x802495
  801428:	e8 fe ee ff ff       	call   80032b <_panic>

0080142d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
  801430:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801433:	83 ec 04             	sub    $0x4,%esp
  801436:	68 c8 24 80 00       	push   $0x8024c8
  80143b:	6a 5b                	push   $0x5b
  80143d:	68 95 24 80 00       	push   $0x802495
  801442:	e8 e4 ee ff ff       	call   80032b <_panic>

00801447 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801447:	55                   	push   %ebp
  801448:	89 e5                	mov    %esp,%ebp
  80144a:	57                   	push   %edi
  80144b:	56                   	push   %esi
  80144c:	53                   	push   %ebx
  80144d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8b 55 0c             	mov    0xc(%ebp),%edx
  801456:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801459:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80145c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80145f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801462:	cd 30                	int    $0x30
  801464:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801467:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80146a:	83 c4 10             	add    $0x10,%esp
  80146d:	5b                   	pop    %ebx
  80146e:	5e                   	pop    %esi
  80146f:	5f                   	pop    %edi
  801470:	5d                   	pop    %ebp
  801471:	c3                   	ret    

00801472 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
  801475:	83 ec 04             	sub    $0x4,%esp
  801478:	8b 45 10             	mov    0x10(%ebp),%eax
  80147b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80147e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801482:	8b 45 08             	mov    0x8(%ebp),%eax
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	52                   	push   %edx
  80148a:	ff 75 0c             	pushl  0xc(%ebp)
  80148d:	50                   	push   %eax
  80148e:	6a 00                	push   $0x0
  801490:	e8 b2 ff ff ff       	call   801447 <syscall>
  801495:	83 c4 18             	add    $0x18,%esp
}
  801498:	90                   	nop
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <sys_cgetc>:

int
sys_cgetc(void)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 01                	push   $0x1
  8014aa:	e8 98 ff ff ff       	call   801447 <syscall>
  8014af:	83 c4 18             	add    $0x18,%esp
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	50                   	push   %eax
  8014c3:	6a 05                	push   $0x5
  8014c5:	e8 7d ff ff ff       	call   801447 <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
}
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 02                	push   $0x2
  8014de:	e8 64 ff ff ff       	call   801447 <syscall>
  8014e3:	83 c4 18             	add    $0x18,%esp
}
  8014e6:	c9                   	leave  
  8014e7:	c3                   	ret    

008014e8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014e8:	55                   	push   %ebp
  8014e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 03                	push   $0x3
  8014f7:	e8 4b ff ff ff       	call   801447 <syscall>
  8014fc:	83 c4 18             	add    $0x18,%esp
}
  8014ff:	c9                   	leave  
  801500:	c3                   	ret    

00801501 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801501:	55                   	push   %ebp
  801502:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 04                	push   $0x4
  801510:	e8 32 ff ff ff       	call   801447 <syscall>
  801515:	83 c4 18             	add    $0x18,%esp
}
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <sys_env_exit>:


void sys_env_exit(void)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 06                	push   $0x6
  801529:	e8 19 ff ff ff       	call   801447 <syscall>
  80152e:	83 c4 18             	add    $0x18,%esp
}
  801531:	90                   	nop
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801537:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153a:	8b 45 08             	mov    0x8(%ebp),%eax
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	52                   	push   %edx
  801544:	50                   	push   %eax
  801545:	6a 07                	push   $0x7
  801547:	e8 fb fe ff ff       	call   801447 <syscall>
  80154c:	83 c4 18             	add    $0x18,%esp
}
  80154f:	c9                   	leave  
  801550:	c3                   	ret    

00801551 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
  801554:	56                   	push   %esi
  801555:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801556:	8b 75 18             	mov    0x18(%ebp),%esi
  801559:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80155c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80155f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	56                   	push   %esi
  801566:	53                   	push   %ebx
  801567:	51                   	push   %ecx
  801568:	52                   	push   %edx
  801569:	50                   	push   %eax
  80156a:	6a 08                	push   $0x8
  80156c:	e8 d6 fe ff ff       	call   801447 <syscall>
  801571:	83 c4 18             	add    $0x18,%esp
}
  801574:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801577:	5b                   	pop    %ebx
  801578:	5e                   	pop    %esi
  801579:	5d                   	pop    %ebp
  80157a:	c3                   	ret    

0080157b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80157e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	52                   	push   %edx
  80158b:	50                   	push   %eax
  80158c:	6a 09                	push   $0x9
  80158e:	e8 b4 fe ff ff       	call   801447 <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
}
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	ff 75 0c             	pushl  0xc(%ebp)
  8015a4:	ff 75 08             	pushl  0x8(%ebp)
  8015a7:	6a 0a                	push   $0xa
  8015a9:	e8 99 fe ff ff       	call   801447 <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 0b                	push   $0xb
  8015c2:	e8 80 fe ff ff       	call   801447 <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 0c                	push   $0xc
  8015db:	e8 67 fe ff ff       	call   801447 <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 0d                	push   $0xd
  8015f4:	e8 4e fe ff ff       	call   801447 <syscall>
  8015f9:	83 c4 18             	add    $0x18,%esp
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	ff 75 0c             	pushl  0xc(%ebp)
  80160a:	ff 75 08             	pushl  0x8(%ebp)
  80160d:	6a 11                	push   $0x11
  80160f:	e8 33 fe ff ff       	call   801447 <syscall>
  801614:	83 c4 18             	add    $0x18,%esp
	return;
  801617:	90                   	nop
}
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	ff 75 0c             	pushl  0xc(%ebp)
  801626:	ff 75 08             	pushl  0x8(%ebp)
  801629:	6a 12                	push   $0x12
  80162b:	e8 17 fe ff ff       	call   801447 <syscall>
  801630:	83 c4 18             	add    $0x18,%esp
	return ;
  801633:	90                   	nop
}
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 0e                	push   $0xe
  801645:	e8 fd fd ff ff       	call   801447 <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
}
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	ff 75 08             	pushl  0x8(%ebp)
  80165d:	6a 0f                	push   $0xf
  80165f:	e8 e3 fd ff ff       	call   801447 <syscall>
  801664:	83 c4 18             	add    $0x18,%esp
}
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 10                	push   $0x10
  801678:	e8 ca fd ff ff       	call   801447 <syscall>
  80167d:	83 c4 18             	add    $0x18,%esp
}
  801680:	90                   	nop
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 14                	push   $0x14
  801692:	e8 b0 fd ff ff       	call   801447 <syscall>
  801697:	83 c4 18             	add    $0x18,%esp
}
  80169a:	90                   	nop
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 15                	push   $0x15
  8016ac:	e8 96 fd ff ff       	call   801447 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	90                   	nop
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
  8016ba:	83 ec 04             	sub    $0x4,%esp
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016c3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	50                   	push   %eax
  8016d0:	6a 16                	push   $0x16
  8016d2:	e8 70 fd ff ff       	call   801447 <syscall>
  8016d7:	83 c4 18             	add    $0x18,%esp
}
  8016da:	90                   	nop
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 17                	push   $0x17
  8016ec:	e8 56 fd ff ff       	call   801447 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	90                   	nop
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	ff 75 0c             	pushl  0xc(%ebp)
  801706:	50                   	push   %eax
  801707:	6a 18                	push   $0x18
  801709:	e8 39 fd ff ff       	call   801447 <syscall>
  80170e:	83 c4 18             	add    $0x18,%esp
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801716:	8b 55 0c             	mov    0xc(%ebp),%edx
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	52                   	push   %edx
  801723:	50                   	push   %eax
  801724:	6a 1b                	push   $0x1b
  801726:	e8 1c fd ff ff       	call   801447 <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
}
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801733:	8b 55 0c             	mov    0xc(%ebp),%edx
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	52                   	push   %edx
  801740:	50                   	push   %eax
  801741:	6a 19                	push   $0x19
  801743:	e8 ff fc ff ff       	call   801447 <syscall>
  801748:	83 c4 18             	add    $0x18,%esp
}
  80174b:	90                   	nop
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801751:	8b 55 0c             	mov    0xc(%ebp),%edx
  801754:	8b 45 08             	mov    0x8(%ebp),%eax
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	52                   	push   %edx
  80175e:	50                   	push   %eax
  80175f:	6a 1a                	push   $0x1a
  801761:	e8 e1 fc ff ff       	call   801447 <syscall>
  801766:	83 c4 18             	add    $0x18,%esp
}
  801769:	90                   	nop
  80176a:	c9                   	leave  
  80176b:	c3                   	ret    

0080176c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
  80176f:	83 ec 04             	sub    $0x4,%esp
  801772:	8b 45 10             	mov    0x10(%ebp),%eax
  801775:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801778:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80177b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	6a 00                	push   $0x0
  801784:	51                   	push   %ecx
  801785:	52                   	push   %edx
  801786:	ff 75 0c             	pushl  0xc(%ebp)
  801789:	50                   	push   %eax
  80178a:	6a 1c                	push   $0x1c
  80178c:	e8 b6 fc ff ff       	call   801447 <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801799:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	52                   	push   %edx
  8017a6:	50                   	push   %eax
  8017a7:	6a 1d                	push   $0x1d
  8017a9:	e8 99 fc ff ff       	call   801447 <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
}
  8017b1:	c9                   	leave  
  8017b2:	c3                   	ret    

008017b3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017b3:	55                   	push   %ebp
  8017b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	51                   	push   %ecx
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 1e                	push   $0x1e
  8017c8:	e8 7a fc ff ff       	call   801447 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	52                   	push   %edx
  8017e2:	50                   	push   %eax
  8017e3:	6a 1f                	push   $0x1f
  8017e5:	e8 5d fc ff ff       	call   801447 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 20                	push   $0x20
  8017fe:	e8 44 fc ff ff       	call   801447 <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	6a 00                	push   $0x0
  801810:	ff 75 14             	pushl  0x14(%ebp)
  801813:	ff 75 10             	pushl  0x10(%ebp)
  801816:	ff 75 0c             	pushl  0xc(%ebp)
  801819:	50                   	push   %eax
  80181a:	6a 21                	push   $0x21
  80181c:	e8 26 fc ff ff       	call   801447 <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801829:	8b 45 08             	mov    0x8(%ebp),%eax
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	50                   	push   %eax
  801835:	6a 22                	push   $0x22
  801837:	e8 0b fc ff ff       	call   801447 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	90                   	nop
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801845:	8b 45 08             	mov    0x8(%ebp),%eax
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	50                   	push   %eax
  801851:	6a 23                	push   $0x23
  801853:	e8 ef fb ff ff       	call   801447 <syscall>
  801858:	83 c4 18             	add    $0x18,%esp
}
  80185b:	90                   	nop
  80185c:	c9                   	leave  
  80185d:	c3                   	ret    

0080185e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80185e:	55                   	push   %ebp
  80185f:	89 e5                	mov    %esp,%ebp
  801861:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801864:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801867:	8d 50 04             	lea    0x4(%eax),%edx
  80186a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	52                   	push   %edx
  801874:	50                   	push   %eax
  801875:	6a 24                	push   $0x24
  801877:	e8 cb fb ff ff       	call   801447 <syscall>
  80187c:	83 c4 18             	add    $0x18,%esp
	return result;
  80187f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801882:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801885:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801888:	89 01                	mov    %eax,(%ecx)
  80188a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80188d:	8b 45 08             	mov    0x8(%ebp),%eax
  801890:	c9                   	leave  
  801891:	c2 04 00             	ret    $0x4

00801894 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	ff 75 10             	pushl  0x10(%ebp)
  80189e:	ff 75 0c             	pushl  0xc(%ebp)
  8018a1:	ff 75 08             	pushl  0x8(%ebp)
  8018a4:	6a 13                	push   $0x13
  8018a6:	e8 9c fb ff ff       	call   801447 <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ae:	90                   	nop
}
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 25                	push   $0x25
  8018c0:	e8 82 fb ff ff       	call   801447 <syscall>
  8018c5:	83 c4 18             	add    $0x18,%esp
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
  8018cd:	83 ec 04             	sub    $0x4,%esp
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018d6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	50                   	push   %eax
  8018e3:	6a 26                	push   $0x26
  8018e5:	e8 5d fb ff ff       	call   801447 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ed:	90                   	nop
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <rsttst>:
void rsttst()
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 28                	push   $0x28
  8018ff:	e8 43 fb ff ff       	call   801447 <syscall>
  801904:	83 c4 18             	add    $0x18,%esp
	return ;
  801907:	90                   	nop
}
  801908:	c9                   	leave  
  801909:	c3                   	ret    

0080190a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80190a:	55                   	push   %ebp
  80190b:	89 e5                	mov    %esp,%ebp
  80190d:	83 ec 04             	sub    $0x4,%esp
  801910:	8b 45 14             	mov    0x14(%ebp),%eax
  801913:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801916:	8b 55 18             	mov    0x18(%ebp),%edx
  801919:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80191d:	52                   	push   %edx
  80191e:	50                   	push   %eax
  80191f:	ff 75 10             	pushl  0x10(%ebp)
  801922:	ff 75 0c             	pushl  0xc(%ebp)
  801925:	ff 75 08             	pushl  0x8(%ebp)
  801928:	6a 27                	push   $0x27
  80192a:	e8 18 fb ff ff       	call   801447 <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
	return ;
  801932:	90                   	nop
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <chktst>:
void chktst(uint32 n)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	ff 75 08             	pushl  0x8(%ebp)
  801943:	6a 29                	push   $0x29
  801945:	e8 fd fa ff ff       	call   801447 <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
	return ;
  80194d:	90                   	nop
}
  80194e:	c9                   	leave  
  80194f:	c3                   	ret    

00801950 <inctst>:

void inctst()
{
  801950:	55                   	push   %ebp
  801951:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 2a                	push   $0x2a
  80195f:	e8 e3 fa ff ff       	call   801447 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
	return ;
  801967:	90                   	nop
}
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <gettst>:
uint32 gettst()
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 2b                	push   $0x2b
  801979:	e8 c9 fa ff ff       	call   801447 <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
  801986:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 2c                	push   $0x2c
  801995:	e8 ad fa ff ff       	call   801447 <syscall>
  80199a:	83 c4 18             	add    $0x18,%esp
  80199d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019a0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019a4:	75 07                	jne    8019ad <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ab:	eb 05                	jmp    8019b2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019b2:	c9                   	leave  
  8019b3:	c3                   	ret    

008019b4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019b4:	55                   	push   %ebp
  8019b5:	89 e5                	mov    %esp,%ebp
  8019b7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 2c                	push   $0x2c
  8019c6:	e8 7c fa ff ff       	call   801447 <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
  8019ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019d1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019d5:	75 07                	jne    8019de <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019d7:	b8 01 00 00 00       	mov    $0x1,%eax
  8019dc:	eb 05                	jmp    8019e3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019de:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019e3:	c9                   	leave  
  8019e4:	c3                   	ret    

008019e5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019e5:	55                   	push   %ebp
  8019e6:	89 e5                	mov    %esp,%ebp
  8019e8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 2c                	push   $0x2c
  8019f7:	e8 4b fa ff ff       	call   801447 <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
  8019ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a02:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a06:	75 07                	jne    801a0f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a08:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0d:	eb 05                	jmp    801a14 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a14:	c9                   	leave  
  801a15:	c3                   	ret    

00801a16 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
  801a19:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 2c                	push   $0x2c
  801a28:	e8 1a fa ff ff       	call   801447 <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
  801a30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a33:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a37:	75 07                	jne    801a40 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a39:	b8 01 00 00 00       	mov    $0x1,%eax
  801a3e:	eb 05                	jmp    801a45 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a45:	c9                   	leave  
  801a46:	c3                   	ret    

00801a47 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	ff 75 08             	pushl  0x8(%ebp)
  801a55:	6a 2d                	push   $0x2d
  801a57:	e8 eb f9 ff ff       	call   801447 <syscall>
  801a5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5f:	90                   	nop
}
  801a60:	c9                   	leave  
  801a61:	c3                   	ret    

00801a62 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
  801a65:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a66:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a69:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	6a 00                	push   $0x0
  801a74:	53                   	push   %ebx
  801a75:	51                   	push   %ecx
  801a76:	52                   	push   %edx
  801a77:	50                   	push   %eax
  801a78:	6a 2e                	push   $0x2e
  801a7a:	e8 c8 f9 ff ff       	call   801447 <syscall>
  801a7f:	83 c4 18             	add    $0x18,%esp
}
  801a82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	52                   	push   %edx
  801a97:	50                   	push   %eax
  801a98:	6a 2f                	push   $0x2f
  801a9a:	e8 a8 f9 ff ff       	call   801447 <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
}
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <__udivdi3>:
  801aa4:	55                   	push   %ebp
  801aa5:	57                   	push   %edi
  801aa6:	56                   	push   %esi
  801aa7:	53                   	push   %ebx
  801aa8:	83 ec 1c             	sub    $0x1c,%esp
  801aab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801aaf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ab3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ab7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801abb:	89 ca                	mov    %ecx,%edx
  801abd:	89 f8                	mov    %edi,%eax
  801abf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ac3:	85 f6                	test   %esi,%esi
  801ac5:	75 2d                	jne    801af4 <__udivdi3+0x50>
  801ac7:	39 cf                	cmp    %ecx,%edi
  801ac9:	77 65                	ja     801b30 <__udivdi3+0x8c>
  801acb:	89 fd                	mov    %edi,%ebp
  801acd:	85 ff                	test   %edi,%edi
  801acf:	75 0b                	jne    801adc <__udivdi3+0x38>
  801ad1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad6:	31 d2                	xor    %edx,%edx
  801ad8:	f7 f7                	div    %edi
  801ada:	89 c5                	mov    %eax,%ebp
  801adc:	31 d2                	xor    %edx,%edx
  801ade:	89 c8                	mov    %ecx,%eax
  801ae0:	f7 f5                	div    %ebp
  801ae2:	89 c1                	mov    %eax,%ecx
  801ae4:	89 d8                	mov    %ebx,%eax
  801ae6:	f7 f5                	div    %ebp
  801ae8:	89 cf                	mov    %ecx,%edi
  801aea:	89 fa                	mov    %edi,%edx
  801aec:	83 c4 1c             	add    $0x1c,%esp
  801aef:	5b                   	pop    %ebx
  801af0:	5e                   	pop    %esi
  801af1:	5f                   	pop    %edi
  801af2:	5d                   	pop    %ebp
  801af3:	c3                   	ret    
  801af4:	39 ce                	cmp    %ecx,%esi
  801af6:	77 28                	ja     801b20 <__udivdi3+0x7c>
  801af8:	0f bd fe             	bsr    %esi,%edi
  801afb:	83 f7 1f             	xor    $0x1f,%edi
  801afe:	75 40                	jne    801b40 <__udivdi3+0x9c>
  801b00:	39 ce                	cmp    %ecx,%esi
  801b02:	72 0a                	jb     801b0e <__udivdi3+0x6a>
  801b04:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b08:	0f 87 9e 00 00 00    	ja     801bac <__udivdi3+0x108>
  801b0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b13:	89 fa                	mov    %edi,%edx
  801b15:	83 c4 1c             	add    $0x1c,%esp
  801b18:	5b                   	pop    %ebx
  801b19:	5e                   	pop    %esi
  801b1a:	5f                   	pop    %edi
  801b1b:	5d                   	pop    %ebp
  801b1c:	c3                   	ret    
  801b1d:	8d 76 00             	lea    0x0(%esi),%esi
  801b20:	31 ff                	xor    %edi,%edi
  801b22:	31 c0                	xor    %eax,%eax
  801b24:	89 fa                	mov    %edi,%edx
  801b26:	83 c4 1c             	add    $0x1c,%esp
  801b29:	5b                   	pop    %ebx
  801b2a:	5e                   	pop    %esi
  801b2b:	5f                   	pop    %edi
  801b2c:	5d                   	pop    %ebp
  801b2d:	c3                   	ret    
  801b2e:	66 90                	xchg   %ax,%ax
  801b30:	89 d8                	mov    %ebx,%eax
  801b32:	f7 f7                	div    %edi
  801b34:	31 ff                	xor    %edi,%edi
  801b36:	89 fa                	mov    %edi,%edx
  801b38:	83 c4 1c             	add    $0x1c,%esp
  801b3b:	5b                   	pop    %ebx
  801b3c:	5e                   	pop    %esi
  801b3d:	5f                   	pop    %edi
  801b3e:	5d                   	pop    %ebp
  801b3f:	c3                   	ret    
  801b40:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b45:	89 eb                	mov    %ebp,%ebx
  801b47:	29 fb                	sub    %edi,%ebx
  801b49:	89 f9                	mov    %edi,%ecx
  801b4b:	d3 e6                	shl    %cl,%esi
  801b4d:	89 c5                	mov    %eax,%ebp
  801b4f:	88 d9                	mov    %bl,%cl
  801b51:	d3 ed                	shr    %cl,%ebp
  801b53:	89 e9                	mov    %ebp,%ecx
  801b55:	09 f1                	or     %esi,%ecx
  801b57:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b5b:	89 f9                	mov    %edi,%ecx
  801b5d:	d3 e0                	shl    %cl,%eax
  801b5f:	89 c5                	mov    %eax,%ebp
  801b61:	89 d6                	mov    %edx,%esi
  801b63:	88 d9                	mov    %bl,%cl
  801b65:	d3 ee                	shr    %cl,%esi
  801b67:	89 f9                	mov    %edi,%ecx
  801b69:	d3 e2                	shl    %cl,%edx
  801b6b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b6f:	88 d9                	mov    %bl,%cl
  801b71:	d3 e8                	shr    %cl,%eax
  801b73:	09 c2                	or     %eax,%edx
  801b75:	89 d0                	mov    %edx,%eax
  801b77:	89 f2                	mov    %esi,%edx
  801b79:	f7 74 24 0c          	divl   0xc(%esp)
  801b7d:	89 d6                	mov    %edx,%esi
  801b7f:	89 c3                	mov    %eax,%ebx
  801b81:	f7 e5                	mul    %ebp
  801b83:	39 d6                	cmp    %edx,%esi
  801b85:	72 19                	jb     801ba0 <__udivdi3+0xfc>
  801b87:	74 0b                	je     801b94 <__udivdi3+0xf0>
  801b89:	89 d8                	mov    %ebx,%eax
  801b8b:	31 ff                	xor    %edi,%edi
  801b8d:	e9 58 ff ff ff       	jmp    801aea <__udivdi3+0x46>
  801b92:	66 90                	xchg   %ax,%ax
  801b94:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b98:	89 f9                	mov    %edi,%ecx
  801b9a:	d3 e2                	shl    %cl,%edx
  801b9c:	39 c2                	cmp    %eax,%edx
  801b9e:	73 e9                	jae    801b89 <__udivdi3+0xe5>
  801ba0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ba3:	31 ff                	xor    %edi,%edi
  801ba5:	e9 40 ff ff ff       	jmp    801aea <__udivdi3+0x46>
  801baa:	66 90                	xchg   %ax,%ax
  801bac:	31 c0                	xor    %eax,%eax
  801bae:	e9 37 ff ff ff       	jmp    801aea <__udivdi3+0x46>
  801bb3:	90                   	nop

00801bb4 <__umoddi3>:
  801bb4:	55                   	push   %ebp
  801bb5:	57                   	push   %edi
  801bb6:	56                   	push   %esi
  801bb7:	53                   	push   %ebx
  801bb8:	83 ec 1c             	sub    $0x1c,%esp
  801bbb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bbf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bc3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bc7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bcb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bcf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bd3:	89 f3                	mov    %esi,%ebx
  801bd5:	89 fa                	mov    %edi,%edx
  801bd7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bdb:	89 34 24             	mov    %esi,(%esp)
  801bde:	85 c0                	test   %eax,%eax
  801be0:	75 1a                	jne    801bfc <__umoddi3+0x48>
  801be2:	39 f7                	cmp    %esi,%edi
  801be4:	0f 86 a2 00 00 00    	jbe    801c8c <__umoddi3+0xd8>
  801bea:	89 c8                	mov    %ecx,%eax
  801bec:	89 f2                	mov    %esi,%edx
  801bee:	f7 f7                	div    %edi
  801bf0:	89 d0                	mov    %edx,%eax
  801bf2:	31 d2                	xor    %edx,%edx
  801bf4:	83 c4 1c             	add    $0x1c,%esp
  801bf7:	5b                   	pop    %ebx
  801bf8:	5e                   	pop    %esi
  801bf9:	5f                   	pop    %edi
  801bfa:	5d                   	pop    %ebp
  801bfb:	c3                   	ret    
  801bfc:	39 f0                	cmp    %esi,%eax
  801bfe:	0f 87 ac 00 00 00    	ja     801cb0 <__umoddi3+0xfc>
  801c04:	0f bd e8             	bsr    %eax,%ebp
  801c07:	83 f5 1f             	xor    $0x1f,%ebp
  801c0a:	0f 84 ac 00 00 00    	je     801cbc <__umoddi3+0x108>
  801c10:	bf 20 00 00 00       	mov    $0x20,%edi
  801c15:	29 ef                	sub    %ebp,%edi
  801c17:	89 fe                	mov    %edi,%esi
  801c19:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c1d:	89 e9                	mov    %ebp,%ecx
  801c1f:	d3 e0                	shl    %cl,%eax
  801c21:	89 d7                	mov    %edx,%edi
  801c23:	89 f1                	mov    %esi,%ecx
  801c25:	d3 ef                	shr    %cl,%edi
  801c27:	09 c7                	or     %eax,%edi
  801c29:	89 e9                	mov    %ebp,%ecx
  801c2b:	d3 e2                	shl    %cl,%edx
  801c2d:	89 14 24             	mov    %edx,(%esp)
  801c30:	89 d8                	mov    %ebx,%eax
  801c32:	d3 e0                	shl    %cl,%eax
  801c34:	89 c2                	mov    %eax,%edx
  801c36:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c3a:	d3 e0                	shl    %cl,%eax
  801c3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c40:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c44:	89 f1                	mov    %esi,%ecx
  801c46:	d3 e8                	shr    %cl,%eax
  801c48:	09 d0                	or     %edx,%eax
  801c4a:	d3 eb                	shr    %cl,%ebx
  801c4c:	89 da                	mov    %ebx,%edx
  801c4e:	f7 f7                	div    %edi
  801c50:	89 d3                	mov    %edx,%ebx
  801c52:	f7 24 24             	mull   (%esp)
  801c55:	89 c6                	mov    %eax,%esi
  801c57:	89 d1                	mov    %edx,%ecx
  801c59:	39 d3                	cmp    %edx,%ebx
  801c5b:	0f 82 87 00 00 00    	jb     801ce8 <__umoddi3+0x134>
  801c61:	0f 84 91 00 00 00    	je     801cf8 <__umoddi3+0x144>
  801c67:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c6b:	29 f2                	sub    %esi,%edx
  801c6d:	19 cb                	sbb    %ecx,%ebx
  801c6f:	89 d8                	mov    %ebx,%eax
  801c71:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c75:	d3 e0                	shl    %cl,%eax
  801c77:	89 e9                	mov    %ebp,%ecx
  801c79:	d3 ea                	shr    %cl,%edx
  801c7b:	09 d0                	or     %edx,%eax
  801c7d:	89 e9                	mov    %ebp,%ecx
  801c7f:	d3 eb                	shr    %cl,%ebx
  801c81:	89 da                	mov    %ebx,%edx
  801c83:	83 c4 1c             	add    $0x1c,%esp
  801c86:	5b                   	pop    %ebx
  801c87:	5e                   	pop    %esi
  801c88:	5f                   	pop    %edi
  801c89:	5d                   	pop    %ebp
  801c8a:	c3                   	ret    
  801c8b:	90                   	nop
  801c8c:	89 fd                	mov    %edi,%ebp
  801c8e:	85 ff                	test   %edi,%edi
  801c90:	75 0b                	jne    801c9d <__umoddi3+0xe9>
  801c92:	b8 01 00 00 00       	mov    $0x1,%eax
  801c97:	31 d2                	xor    %edx,%edx
  801c99:	f7 f7                	div    %edi
  801c9b:	89 c5                	mov    %eax,%ebp
  801c9d:	89 f0                	mov    %esi,%eax
  801c9f:	31 d2                	xor    %edx,%edx
  801ca1:	f7 f5                	div    %ebp
  801ca3:	89 c8                	mov    %ecx,%eax
  801ca5:	f7 f5                	div    %ebp
  801ca7:	89 d0                	mov    %edx,%eax
  801ca9:	e9 44 ff ff ff       	jmp    801bf2 <__umoddi3+0x3e>
  801cae:	66 90                	xchg   %ax,%ax
  801cb0:	89 c8                	mov    %ecx,%eax
  801cb2:	89 f2                	mov    %esi,%edx
  801cb4:	83 c4 1c             	add    $0x1c,%esp
  801cb7:	5b                   	pop    %ebx
  801cb8:	5e                   	pop    %esi
  801cb9:	5f                   	pop    %edi
  801cba:	5d                   	pop    %ebp
  801cbb:	c3                   	ret    
  801cbc:	3b 04 24             	cmp    (%esp),%eax
  801cbf:	72 06                	jb     801cc7 <__umoddi3+0x113>
  801cc1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cc5:	77 0f                	ja     801cd6 <__umoddi3+0x122>
  801cc7:	89 f2                	mov    %esi,%edx
  801cc9:	29 f9                	sub    %edi,%ecx
  801ccb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ccf:	89 14 24             	mov    %edx,(%esp)
  801cd2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cd6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cda:	8b 14 24             	mov    (%esp),%edx
  801cdd:	83 c4 1c             	add    $0x1c,%esp
  801ce0:	5b                   	pop    %ebx
  801ce1:	5e                   	pop    %esi
  801ce2:	5f                   	pop    %edi
  801ce3:	5d                   	pop    %ebp
  801ce4:	c3                   	ret    
  801ce5:	8d 76 00             	lea    0x0(%esi),%esi
  801ce8:	2b 04 24             	sub    (%esp),%eax
  801ceb:	19 fa                	sbb    %edi,%edx
  801ced:	89 d1                	mov    %edx,%ecx
  801cef:	89 c6                	mov    %eax,%esi
  801cf1:	e9 71 ff ff ff       	jmp    801c67 <__umoddi3+0xb3>
  801cf6:	66 90                	xchg   %ax,%ax
  801cf8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cfc:	72 ea                	jb     801ce8 <__umoddi3+0x134>
  801cfe:	89 d9                	mov    %ebx,%ecx
  801d00:	e9 62 ff ff ff       	jmp    801c67 <__umoddi3+0xb3>
