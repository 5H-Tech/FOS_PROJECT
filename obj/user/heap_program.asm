
obj/user/heap_program:     file format elf32-i386


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
  800031:	e8 ed 01 00 00       	call   800223 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int kilo = 1024;
  800041:	c7 45 d8 00 04 00 00 	movl   $0x400,-0x28(%ebp)
	int Mega = 1024*1024;
  800048:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)

	/// testing freeHeap()
	{
		uint32 size = 13*Mega;
  80004f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800052:	89 d0                	mov    %edx,%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	01 d0                	add    %edx,%eax
  800058:	c1 e0 02             	shl    $0x2,%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	ff 75 d0             	pushl  -0x30(%ebp)
  800066:	e8 29 13 00 00       	call   801394 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 18 13 00 00       	call   801394 <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 2e 19 00 00       	call   8019b5 <sys_pf_calculate_allocated_pages>
  800087:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		x[1]=-1;
  80008a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80008d:	40                   	inc    %eax
  80008e:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  800091:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800094:	89 d0                	mov    %edx,%eax
  800096:	c1 e0 02             	shl    $0x2,%eax
  800099:	01 d0                	add    %edx,%eax
  80009b:	89 c2                	mov    %eax,%edx
  80009d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000a0:	01 d0                	add    %edx,%eax
  8000a2:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  8000a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000a8:	c1 e0 03             	shl    $0x3,%eax
  8000ab:	89 c2                	mov    %eax,%edx
  8000ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8000b5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000b8:	89 d0                	mov    %edx,%eax
  8000ba:	01 c0                	add    %eax,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 02             	shl    $0x2,%eax
  8000c1:	89 c2                	mov    %eax,%edx
  8000c3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c6 00 ff             	movb   $0xff,(%eax)

		//int usedDiskPages = sys_pf_calculate_allocated_pages() ;

		free(x);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	ff 75 cc             	pushl  -0x34(%ebp)
  8000d1:	e8 86 15 00 00       	call   80165c <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 78 15 00 00       	call   80165c <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 46 18 00 00       	call   801932 <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 9a 12 00 00       	call   801394 <malloc>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 cc             	mov    %eax,-0x34(%ebp)

		x[1]=-2;
  800100:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800103:	40                   	inc    %eax
  800104:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800107:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80010a:	89 d0                	mov    %edx,%eax
  80010c:	c1 e0 02             	shl    $0x2,%eax
  80010f:	01 d0                	add    %edx,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80011b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80011e:	c1 e0 03             	shl    $0x3,%eax
  800121:	89 c2                	mov    %eax,%edx
  800123:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80012b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80012e:	89 d0                	mov    %edx,%eax
  800130:	01 c0                	add    %eax,%eax
  800132:	01 d0                	add    %edx,%eax
  800134:	c1 e0 02             	shl    $0x2,%eax
  800137:	89 c2                	mov    %eax,%edx
  800139:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c6 00 fe             	movb   $0xfe,(%eax)

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};
  800141:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800144:	bb 60 21 80 00       	mov    $0x802160,%ebx
  800149:	ba 08 00 00 00       	mov    $0x8,%edx
  80014e:	89 c7                	mov    %eax,%edi
  800150:	89 de                	mov    %ebx,%esi
  800152:	89 d1                	mov    %edx,%ecx
  800154:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800156:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  80015d:	eb 73                	jmp    8001d2 <_main+0x19a>
		{
			int found = 0 ;
  80015f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  800166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80016d:	eb 37                	jmp    8001a6 <_main+0x16e>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  80016f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800172:	8b 54 85 9c          	mov    -0x64(%ebp,%eax,4),%edx
  800176:	a1 20 30 80 00       	mov    0x803020,%eax
  80017b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800181:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  800184:	c1 e1 04             	shl    $0x4,%ecx
  800187:	01 c8                	add    %ecx,%eax
  800189:	8b 00                	mov    (%eax),%eax
  80018b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80018e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800191:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800196:	39 c2                	cmp    %eax,%edx
  800198:	75 09                	jne    8001a3 <_main+0x16b>
				{
					found = 1 ;
  80019a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8001a1:	eb 12                	jmp    8001b5 <_main+0x17d>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8001a3:	ff 45 e0             	incl   -0x20(%ebp)
  8001a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ab:	8b 50 74             	mov    0x74(%eax),%edx
  8001ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001b1:	39 c2                	cmp    %eax,%edx
  8001b3:	77 ba                	ja     80016f <_main+0x137>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8001b5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001b9:	75 14                	jne    8001cf <_main+0x197>
				panic("PAGE Placement algorithm failed after applying freeHeap");
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 a0 20 80 00       	push   $0x8020a0
  8001c3:	6a 41                	push   $0x41
  8001c5:	68 d8 20 80 00       	push   $0x8020d8
  8001ca:	e8 99 01 00 00       	call   800368 <_panic>
		x[12*Mega]=-2;

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  8001cf:	ff 45 e4             	incl   -0x1c(%ebp)
  8001d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d7:	8b 50 74             	mov    0x74(%eax),%edx
  8001da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001dd:	39 c2                	cmp    %eax,%edx
  8001df:	0f 87 7a ff ff ff    	ja     80015f <_main+0x127>
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap");
		}


		if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
  8001e5:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8001e8:	e8 45 17 00 00       	call   801932 <sys_calculate_free_frames>
  8001ed:	29 c3                	sub    %eax,%ebx
  8001ef:	89 d8                	mov    %ebx,%eax
  8001f1:	83 f8 08             	cmp    $0x8,%eax
  8001f4:	74 14                	je     80020a <_main+0x1d2>
  8001f6:	83 ec 04             	sub    $0x4,%esp
  8001f9:	68 ec 20 80 00       	push   $0x8020ec
  8001fe:	6a 45                	push   $0x45
  800200:	68 d8 20 80 00       	push   $0x8020d8
  800205:	e8 5e 01 00 00       	call   800368 <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  80020a:	83 ec 0c             	sub    $0xc,%esp
  80020d:	68 14 21 80 00       	push   $0x802114
  800212:	e8 f3 03 00 00       	call   80060a <cprintf>
  800217:	83 c4 10             	add    $0x10,%esp


	return;
  80021a:	90                   	nop
}
  80021b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80021e:	5b                   	pop    %ebx
  80021f:	5e                   	pop    %esi
  800220:	5f                   	pop    %edi
  800221:	5d                   	pop    %ebp
  800222:	c3                   	ret    

00800223 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800223:	55                   	push   %ebp
  800224:	89 e5                	mov    %esp,%ebp
  800226:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800229:	e8 39 16 00 00       	call   801867 <sys_getenvindex>
  80022e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800231:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800234:	89 d0                	mov    %edx,%eax
  800236:	c1 e0 03             	shl    $0x3,%eax
  800239:	01 d0                	add    %edx,%eax
  80023b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800242:	01 c8                	add    %ecx,%eax
  800244:	01 c0                	add    %eax,%eax
  800246:	01 d0                	add    %edx,%eax
  800248:	01 c0                	add    %eax,%eax
  80024a:	01 d0                	add    %edx,%eax
  80024c:	89 c2                	mov    %eax,%edx
  80024e:	c1 e2 05             	shl    $0x5,%edx
  800251:	29 c2                	sub    %eax,%edx
  800253:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80025a:	89 c2                	mov    %eax,%edx
  80025c:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800262:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800267:	a1 20 30 80 00       	mov    0x803020,%eax
  80026c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800272:	84 c0                	test   %al,%al
  800274:	74 0f                	je     800285 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800276:	a1 20 30 80 00       	mov    0x803020,%eax
  80027b:	05 40 3c 01 00       	add    $0x13c40,%eax
  800280:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800285:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800289:	7e 0a                	jle    800295 <libmain+0x72>
		binaryname = argv[0];
  80028b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80028e:	8b 00                	mov    (%eax),%eax
  800290:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800295:	83 ec 08             	sub    $0x8,%esp
  800298:	ff 75 0c             	pushl  0xc(%ebp)
  80029b:	ff 75 08             	pushl  0x8(%ebp)
  80029e:	e8 95 fd ff ff       	call   800038 <_main>
  8002a3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8002a6:	e8 57 17 00 00       	call   801a02 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002ab:	83 ec 0c             	sub    $0xc,%esp
  8002ae:	68 98 21 80 00       	push   $0x802198
  8002b3:	e8 52 03 00 00       	call   80060a <cprintf>
  8002b8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c0:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8002c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cb:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8002d1:	83 ec 04             	sub    $0x4,%esp
  8002d4:	52                   	push   %edx
  8002d5:	50                   	push   %eax
  8002d6:	68 c0 21 80 00       	push   $0x8021c0
  8002db:	e8 2a 03 00 00       	call   80060a <cprintf>
  8002e0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8002e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e8:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8002ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f3:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002f9:	83 ec 04             	sub    $0x4,%esp
  8002fc:	52                   	push   %edx
  8002fd:	50                   	push   %eax
  8002fe:	68 e8 21 80 00       	push   $0x8021e8
  800303:	e8 02 03 00 00       	call   80060a <cprintf>
  800308:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80030b:	a1 20 30 80 00       	mov    0x803020,%eax
  800310:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	50                   	push   %eax
  80031a:	68 29 22 80 00       	push   $0x802229
  80031f:	e8 e6 02 00 00       	call   80060a <cprintf>
  800324:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800327:	83 ec 0c             	sub    $0xc,%esp
  80032a:	68 98 21 80 00       	push   $0x802198
  80032f:	e8 d6 02 00 00       	call   80060a <cprintf>
  800334:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800337:	e8 e0 16 00 00       	call   801a1c <sys_enable_interrupt>

	// exit gracefully
	exit();
  80033c:	e8 19 00 00 00       	call   80035a <exit>
}
  800341:	90                   	nop
  800342:	c9                   	leave  
  800343:	c3                   	ret    

00800344 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800344:	55                   	push   %ebp
  800345:	89 e5                	mov    %esp,%ebp
  800347:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80034a:	83 ec 0c             	sub    $0xc,%esp
  80034d:	6a 00                	push   $0x0
  80034f:	e8 df 14 00 00       	call   801833 <sys_env_destroy>
  800354:	83 c4 10             	add    $0x10,%esp
}
  800357:	90                   	nop
  800358:	c9                   	leave  
  800359:	c3                   	ret    

0080035a <exit>:

void
exit(void)
{
  80035a:	55                   	push   %ebp
  80035b:	89 e5                	mov    %esp,%ebp
  80035d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800360:	e8 34 15 00 00       	call   801899 <sys_env_exit>
}
  800365:	90                   	nop
  800366:	c9                   	leave  
  800367:	c3                   	ret    

00800368 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800368:	55                   	push   %ebp
  800369:	89 e5                	mov    %esp,%ebp
  80036b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80036e:	8d 45 10             	lea    0x10(%ebp),%eax
  800371:	83 c0 04             	add    $0x4,%eax
  800374:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800377:	a1 18 31 80 00       	mov    0x803118,%eax
  80037c:	85 c0                	test   %eax,%eax
  80037e:	74 16                	je     800396 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800380:	a1 18 31 80 00       	mov    0x803118,%eax
  800385:	83 ec 08             	sub    $0x8,%esp
  800388:	50                   	push   %eax
  800389:	68 40 22 80 00       	push   $0x802240
  80038e:	e8 77 02 00 00       	call   80060a <cprintf>
  800393:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800396:	a1 00 30 80 00       	mov    0x803000,%eax
  80039b:	ff 75 0c             	pushl  0xc(%ebp)
  80039e:	ff 75 08             	pushl  0x8(%ebp)
  8003a1:	50                   	push   %eax
  8003a2:	68 45 22 80 00       	push   $0x802245
  8003a7:	e8 5e 02 00 00       	call   80060a <cprintf>
  8003ac:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8003af:	8b 45 10             	mov    0x10(%ebp),%eax
  8003b2:	83 ec 08             	sub    $0x8,%esp
  8003b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003b8:	50                   	push   %eax
  8003b9:	e8 e1 01 00 00       	call   80059f <vcprintf>
  8003be:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8003c1:	83 ec 08             	sub    $0x8,%esp
  8003c4:	6a 00                	push   $0x0
  8003c6:	68 61 22 80 00       	push   $0x802261
  8003cb:	e8 cf 01 00 00       	call   80059f <vcprintf>
  8003d0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003d3:	e8 82 ff ff ff       	call   80035a <exit>

	// should not return here
	while (1) ;
  8003d8:	eb fe                	jmp    8003d8 <_panic+0x70>

008003da <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003da:	55                   	push   %ebp
  8003db:	89 e5                	mov    %esp,%ebp
  8003dd:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e5:	8b 50 74             	mov    0x74(%eax),%edx
  8003e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003eb:	39 c2                	cmp    %eax,%edx
  8003ed:	74 14                	je     800403 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003ef:	83 ec 04             	sub    $0x4,%esp
  8003f2:	68 64 22 80 00       	push   $0x802264
  8003f7:	6a 26                	push   $0x26
  8003f9:	68 b0 22 80 00       	push   $0x8022b0
  8003fe:	e8 65 ff ff ff       	call   800368 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800403:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80040a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800411:	e9 b6 00 00 00       	jmp    8004cc <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800416:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800419:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	01 d0                	add    %edx,%eax
  800425:	8b 00                	mov    (%eax),%eax
  800427:	85 c0                	test   %eax,%eax
  800429:	75 08                	jne    800433 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80042b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80042e:	e9 96 00 00 00       	jmp    8004c9 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800433:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80043a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800441:	eb 5d                	jmp    8004a0 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800443:	a1 20 30 80 00       	mov    0x803020,%eax
  800448:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80044e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800451:	c1 e2 04             	shl    $0x4,%edx
  800454:	01 d0                	add    %edx,%eax
  800456:	8a 40 04             	mov    0x4(%eax),%al
  800459:	84 c0                	test   %al,%al
  80045b:	75 40                	jne    80049d <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80045d:	a1 20 30 80 00       	mov    0x803020,%eax
  800462:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800468:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80046b:	c1 e2 04             	shl    $0x4,%edx
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800475:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800478:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80047d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80047f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800482:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800489:	8b 45 08             	mov    0x8(%ebp),%eax
  80048c:	01 c8                	add    %ecx,%eax
  80048e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800490:	39 c2                	cmp    %eax,%edx
  800492:	75 09                	jne    80049d <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800494:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80049b:	eb 12                	jmp    8004af <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80049d:	ff 45 e8             	incl   -0x18(%ebp)
  8004a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a5:	8b 50 74             	mov    0x74(%eax),%edx
  8004a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004ab:	39 c2                	cmp    %eax,%edx
  8004ad:	77 94                	ja     800443 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8004af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8004b3:	75 14                	jne    8004c9 <CheckWSWithoutLastIndex+0xef>
			panic(
  8004b5:	83 ec 04             	sub    $0x4,%esp
  8004b8:	68 bc 22 80 00       	push   $0x8022bc
  8004bd:	6a 3a                	push   $0x3a
  8004bf:	68 b0 22 80 00       	push   $0x8022b0
  8004c4:	e8 9f fe ff ff       	call   800368 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004c9:	ff 45 f0             	incl   -0x10(%ebp)
  8004cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004cf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004d2:	0f 8c 3e ff ff ff    	jl     800416 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004df:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004e6:	eb 20                	jmp    800508 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ed:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004f6:	c1 e2 04             	shl    $0x4,%edx
  8004f9:	01 d0                	add    %edx,%eax
  8004fb:	8a 40 04             	mov    0x4(%eax),%al
  8004fe:	3c 01                	cmp    $0x1,%al
  800500:	75 03                	jne    800505 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800502:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800505:	ff 45 e0             	incl   -0x20(%ebp)
  800508:	a1 20 30 80 00       	mov    0x803020,%eax
  80050d:	8b 50 74             	mov    0x74(%eax),%edx
  800510:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800513:	39 c2                	cmp    %eax,%edx
  800515:	77 d1                	ja     8004e8 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800517:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80051a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80051d:	74 14                	je     800533 <CheckWSWithoutLastIndex+0x159>
		panic(
  80051f:	83 ec 04             	sub    $0x4,%esp
  800522:	68 10 23 80 00       	push   $0x802310
  800527:	6a 44                	push   $0x44
  800529:	68 b0 22 80 00       	push   $0x8022b0
  80052e:	e8 35 fe ff ff       	call   800368 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800533:	90                   	nop
  800534:	c9                   	leave  
  800535:	c3                   	ret    

00800536 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800536:	55                   	push   %ebp
  800537:	89 e5                	mov    %esp,%ebp
  800539:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053f:	8b 00                	mov    (%eax),%eax
  800541:	8d 48 01             	lea    0x1(%eax),%ecx
  800544:	8b 55 0c             	mov    0xc(%ebp),%edx
  800547:	89 0a                	mov    %ecx,(%edx)
  800549:	8b 55 08             	mov    0x8(%ebp),%edx
  80054c:	88 d1                	mov    %dl,%cl
  80054e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800551:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800555:	8b 45 0c             	mov    0xc(%ebp),%eax
  800558:	8b 00                	mov    (%eax),%eax
  80055a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80055f:	75 2c                	jne    80058d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800561:	a0 24 30 80 00       	mov    0x803024,%al
  800566:	0f b6 c0             	movzbl %al,%eax
  800569:	8b 55 0c             	mov    0xc(%ebp),%edx
  80056c:	8b 12                	mov    (%edx),%edx
  80056e:	89 d1                	mov    %edx,%ecx
  800570:	8b 55 0c             	mov    0xc(%ebp),%edx
  800573:	83 c2 08             	add    $0x8,%edx
  800576:	83 ec 04             	sub    $0x4,%esp
  800579:	50                   	push   %eax
  80057a:	51                   	push   %ecx
  80057b:	52                   	push   %edx
  80057c:	e8 70 12 00 00       	call   8017f1 <sys_cputs>
  800581:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800584:	8b 45 0c             	mov    0xc(%ebp),%eax
  800587:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80058d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800590:	8b 40 04             	mov    0x4(%eax),%eax
  800593:	8d 50 01             	lea    0x1(%eax),%edx
  800596:	8b 45 0c             	mov    0xc(%ebp),%eax
  800599:	89 50 04             	mov    %edx,0x4(%eax)
}
  80059c:	90                   	nop
  80059d:	c9                   	leave  
  80059e:	c3                   	ret    

0080059f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80059f:	55                   	push   %ebp
  8005a0:	89 e5                	mov    %esp,%ebp
  8005a2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005a8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005af:	00 00 00 
	b.cnt = 0;
  8005b2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005b9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005bc:	ff 75 0c             	pushl  0xc(%ebp)
  8005bf:	ff 75 08             	pushl  0x8(%ebp)
  8005c2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005c8:	50                   	push   %eax
  8005c9:	68 36 05 80 00       	push   $0x800536
  8005ce:	e8 11 02 00 00       	call   8007e4 <vprintfmt>
  8005d3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005d6:	a0 24 30 80 00       	mov    0x803024,%al
  8005db:	0f b6 c0             	movzbl %al,%eax
  8005de:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005e4:	83 ec 04             	sub    $0x4,%esp
  8005e7:	50                   	push   %eax
  8005e8:	52                   	push   %edx
  8005e9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005ef:	83 c0 08             	add    $0x8,%eax
  8005f2:	50                   	push   %eax
  8005f3:	e8 f9 11 00 00       	call   8017f1 <sys_cputs>
  8005f8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005fb:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800602:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800608:	c9                   	leave  
  800609:	c3                   	ret    

0080060a <cprintf>:

int cprintf(const char *fmt, ...) {
  80060a:	55                   	push   %ebp
  80060b:	89 e5                	mov    %esp,%ebp
  80060d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800610:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800617:	8d 45 0c             	lea    0xc(%ebp),%eax
  80061a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	83 ec 08             	sub    $0x8,%esp
  800623:	ff 75 f4             	pushl  -0xc(%ebp)
  800626:	50                   	push   %eax
  800627:	e8 73 ff ff ff       	call   80059f <vcprintf>
  80062c:	83 c4 10             	add    $0x10,%esp
  80062f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800632:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800635:	c9                   	leave  
  800636:	c3                   	ret    

00800637 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800637:	55                   	push   %ebp
  800638:	89 e5                	mov    %esp,%ebp
  80063a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80063d:	e8 c0 13 00 00       	call   801a02 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800642:	8d 45 0c             	lea    0xc(%ebp),%eax
  800645:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800648:	8b 45 08             	mov    0x8(%ebp),%eax
  80064b:	83 ec 08             	sub    $0x8,%esp
  80064e:	ff 75 f4             	pushl  -0xc(%ebp)
  800651:	50                   	push   %eax
  800652:	e8 48 ff ff ff       	call   80059f <vcprintf>
  800657:	83 c4 10             	add    $0x10,%esp
  80065a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80065d:	e8 ba 13 00 00       	call   801a1c <sys_enable_interrupt>
	return cnt;
  800662:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800665:	c9                   	leave  
  800666:	c3                   	ret    

00800667 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800667:	55                   	push   %ebp
  800668:	89 e5                	mov    %esp,%ebp
  80066a:	53                   	push   %ebx
  80066b:	83 ec 14             	sub    $0x14,%esp
  80066e:	8b 45 10             	mov    0x10(%ebp),%eax
  800671:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800674:	8b 45 14             	mov    0x14(%ebp),%eax
  800677:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80067a:	8b 45 18             	mov    0x18(%ebp),%eax
  80067d:	ba 00 00 00 00       	mov    $0x0,%edx
  800682:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800685:	77 55                	ja     8006dc <printnum+0x75>
  800687:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80068a:	72 05                	jb     800691 <printnum+0x2a>
  80068c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80068f:	77 4b                	ja     8006dc <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800691:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800694:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800697:	8b 45 18             	mov    0x18(%ebp),%eax
  80069a:	ba 00 00 00 00       	mov    $0x0,%edx
  80069f:	52                   	push   %edx
  8006a0:	50                   	push   %eax
  8006a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8006a4:	ff 75 f0             	pushl  -0x10(%ebp)
  8006a7:	e8 78 17 00 00       	call   801e24 <__udivdi3>
  8006ac:	83 c4 10             	add    $0x10,%esp
  8006af:	83 ec 04             	sub    $0x4,%esp
  8006b2:	ff 75 20             	pushl  0x20(%ebp)
  8006b5:	53                   	push   %ebx
  8006b6:	ff 75 18             	pushl  0x18(%ebp)
  8006b9:	52                   	push   %edx
  8006ba:	50                   	push   %eax
  8006bb:	ff 75 0c             	pushl  0xc(%ebp)
  8006be:	ff 75 08             	pushl  0x8(%ebp)
  8006c1:	e8 a1 ff ff ff       	call   800667 <printnum>
  8006c6:	83 c4 20             	add    $0x20,%esp
  8006c9:	eb 1a                	jmp    8006e5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006cb:	83 ec 08             	sub    $0x8,%esp
  8006ce:	ff 75 0c             	pushl  0xc(%ebp)
  8006d1:	ff 75 20             	pushl  0x20(%ebp)
  8006d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d7:	ff d0                	call   *%eax
  8006d9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006dc:	ff 4d 1c             	decl   0x1c(%ebp)
  8006df:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006e3:	7f e6                	jg     8006cb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006e5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006e8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f3:	53                   	push   %ebx
  8006f4:	51                   	push   %ecx
  8006f5:	52                   	push   %edx
  8006f6:	50                   	push   %eax
  8006f7:	e8 38 18 00 00       	call   801f34 <__umoddi3>
  8006fc:	83 c4 10             	add    $0x10,%esp
  8006ff:	05 74 25 80 00       	add    $0x802574,%eax
  800704:	8a 00                	mov    (%eax),%al
  800706:	0f be c0             	movsbl %al,%eax
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 0c             	pushl  0xc(%ebp)
  80070f:	50                   	push   %eax
  800710:	8b 45 08             	mov    0x8(%ebp),%eax
  800713:	ff d0                	call   *%eax
  800715:	83 c4 10             	add    $0x10,%esp
}
  800718:	90                   	nop
  800719:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80071c:	c9                   	leave  
  80071d:	c3                   	ret    

0080071e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80071e:	55                   	push   %ebp
  80071f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800721:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800725:	7e 1c                	jle    800743 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800727:	8b 45 08             	mov    0x8(%ebp),%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	8d 50 08             	lea    0x8(%eax),%edx
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	89 10                	mov    %edx,(%eax)
  800734:	8b 45 08             	mov    0x8(%ebp),%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	83 e8 08             	sub    $0x8,%eax
  80073c:	8b 50 04             	mov    0x4(%eax),%edx
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	eb 40                	jmp    800783 <getuint+0x65>
	else if (lflag)
  800743:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800747:	74 1e                	je     800767 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	8b 00                	mov    (%eax),%eax
  80074e:	8d 50 04             	lea    0x4(%eax),%edx
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	89 10                	mov    %edx,(%eax)
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	8b 00                	mov    (%eax),%eax
  80075b:	83 e8 04             	sub    $0x4,%eax
  80075e:	8b 00                	mov    (%eax),%eax
  800760:	ba 00 00 00 00       	mov    $0x0,%edx
  800765:	eb 1c                	jmp    800783 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800767:	8b 45 08             	mov    0x8(%ebp),%eax
  80076a:	8b 00                	mov    (%eax),%eax
  80076c:	8d 50 04             	lea    0x4(%eax),%edx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	89 10                	mov    %edx,(%eax)
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	8b 00                	mov    (%eax),%eax
  800779:	83 e8 04             	sub    $0x4,%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800783:	5d                   	pop    %ebp
  800784:	c3                   	ret    

00800785 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800785:	55                   	push   %ebp
  800786:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800788:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80078c:	7e 1c                	jle    8007aa <getint+0x25>
		return va_arg(*ap, long long);
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	8b 00                	mov    (%eax),%eax
  800793:	8d 50 08             	lea    0x8(%eax),%edx
  800796:	8b 45 08             	mov    0x8(%ebp),%eax
  800799:	89 10                	mov    %edx,(%eax)
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	8b 00                	mov    (%eax),%eax
  8007a0:	83 e8 08             	sub    $0x8,%eax
  8007a3:	8b 50 04             	mov    0x4(%eax),%edx
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	eb 38                	jmp    8007e2 <getint+0x5d>
	else if (lflag)
  8007aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ae:	74 1a                	je     8007ca <getint+0x45>
		return va_arg(*ap, long);
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	8b 00                	mov    (%eax),%eax
  8007b5:	8d 50 04             	lea    0x4(%eax),%edx
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	89 10                	mov    %edx,(%eax)
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	8b 00                	mov    (%eax),%eax
  8007c2:	83 e8 04             	sub    $0x4,%eax
  8007c5:	8b 00                	mov    (%eax),%eax
  8007c7:	99                   	cltd   
  8007c8:	eb 18                	jmp    8007e2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	8b 00                	mov    (%eax),%eax
  8007cf:	8d 50 04             	lea    0x4(%eax),%edx
  8007d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d5:	89 10                	mov    %edx,(%eax)
  8007d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007da:	8b 00                	mov    (%eax),%eax
  8007dc:	83 e8 04             	sub    $0x4,%eax
  8007df:	8b 00                	mov    (%eax),%eax
  8007e1:	99                   	cltd   
}
  8007e2:	5d                   	pop    %ebp
  8007e3:	c3                   	ret    

008007e4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007e4:	55                   	push   %ebp
  8007e5:	89 e5                	mov    %esp,%ebp
  8007e7:	56                   	push   %esi
  8007e8:	53                   	push   %ebx
  8007e9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007ec:	eb 17                	jmp    800805 <vprintfmt+0x21>
			if (ch == '\0')
  8007ee:	85 db                	test   %ebx,%ebx
  8007f0:	0f 84 af 03 00 00    	je     800ba5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 0c             	pushl  0xc(%ebp)
  8007fc:	53                   	push   %ebx
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	ff d0                	call   *%eax
  800802:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800805:	8b 45 10             	mov    0x10(%ebp),%eax
  800808:	8d 50 01             	lea    0x1(%eax),%edx
  80080b:	89 55 10             	mov    %edx,0x10(%ebp)
  80080e:	8a 00                	mov    (%eax),%al
  800810:	0f b6 d8             	movzbl %al,%ebx
  800813:	83 fb 25             	cmp    $0x25,%ebx
  800816:	75 d6                	jne    8007ee <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800818:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80081c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800823:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80082a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800831:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800838:	8b 45 10             	mov    0x10(%ebp),%eax
  80083b:	8d 50 01             	lea    0x1(%eax),%edx
  80083e:	89 55 10             	mov    %edx,0x10(%ebp)
  800841:	8a 00                	mov    (%eax),%al
  800843:	0f b6 d8             	movzbl %al,%ebx
  800846:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800849:	83 f8 55             	cmp    $0x55,%eax
  80084c:	0f 87 2b 03 00 00    	ja     800b7d <vprintfmt+0x399>
  800852:	8b 04 85 98 25 80 00 	mov    0x802598(,%eax,4),%eax
  800859:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80085b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80085f:	eb d7                	jmp    800838 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800861:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800865:	eb d1                	jmp    800838 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800867:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80086e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800871:	89 d0                	mov    %edx,%eax
  800873:	c1 e0 02             	shl    $0x2,%eax
  800876:	01 d0                	add    %edx,%eax
  800878:	01 c0                	add    %eax,%eax
  80087a:	01 d8                	add    %ebx,%eax
  80087c:	83 e8 30             	sub    $0x30,%eax
  80087f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800882:	8b 45 10             	mov    0x10(%ebp),%eax
  800885:	8a 00                	mov    (%eax),%al
  800887:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80088a:	83 fb 2f             	cmp    $0x2f,%ebx
  80088d:	7e 3e                	jle    8008cd <vprintfmt+0xe9>
  80088f:	83 fb 39             	cmp    $0x39,%ebx
  800892:	7f 39                	jg     8008cd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800894:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800897:	eb d5                	jmp    80086e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800899:	8b 45 14             	mov    0x14(%ebp),%eax
  80089c:	83 c0 04             	add    $0x4,%eax
  80089f:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a5:	83 e8 04             	sub    $0x4,%eax
  8008a8:	8b 00                	mov    (%eax),%eax
  8008aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008ad:	eb 1f                	jmp    8008ce <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008af:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b3:	79 83                	jns    800838 <vprintfmt+0x54>
				width = 0;
  8008b5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008bc:	e9 77 ff ff ff       	jmp    800838 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008c1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008c8:	e9 6b ff ff ff       	jmp    800838 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008cd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d2:	0f 89 60 ff ff ff    	jns    800838 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008de:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008e5:	e9 4e ff ff ff       	jmp    800838 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008ea:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008ed:	e9 46 ff ff ff       	jmp    800838 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f5:	83 c0 04             	add    $0x4,%eax
  8008f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8008fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fe:	83 e8 04             	sub    $0x4,%eax
  800901:	8b 00                	mov    (%eax),%eax
  800903:	83 ec 08             	sub    $0x8,%esp
  800906:	ff 75 0c             	pushl  0xc(%ebp)
  800909:	50                   	push   %eax
  80090a:	8b 45 08             	mov    0x8(%ebp),%eax
  80090d:	ff d0                	call   *%eax
  80090f:	83 c4 10             	add    $0x10,%esp
			break;
  800912:	e9 89 02 00 00       	jmp    800ba0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800917:	8b 45 14             	mov    0x14(%ebp),%eax
  80091a:	83 c0 04             	add    $0x4,%eax
  80091d:	89 45 14             	mov    %eax,0x14(%ebp)
  800920:	8b 45 14             	mov    0x14(%ebp),%eax
  800923:	83 e8 04             	sub    $0x4,%eax
  800926:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800928:	85 db                	test   %ebx,%ebx
  80092a:	79 02                	jns    80092e <vprintfmt+0x14a>
				err = -err;
  80092c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80092e:	83 fb 64             	cmp    $0x64,%ebx
  800931:	7f 0b                	jg     80093e <vprintfmt+0x15a>
  800933:	8b 34 9d e0 23 80 00 	mov    0x8023e0(,%ebx,4),%esi
  80093a:	85 f6                	test   %esi,%esi
  80093c:	75 19                	jne    800957 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80093e:	53                   	push   %ebx
  80093f:	68 85 25 80 00       	push   $0x802585
  800944:	ff 75 0c             	pushl  0xc(%ebp)
  800947:	ff 75 08             	pushl  0x8(%ebp)
  80094a:	e8 5e 02 00 00       	call   800bad <printfmt>
  80094f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800952:	e9 49 02 00 00       	jmp    800ba0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800957:	56                   	push   %esi
  800958:	68 8e 25 80 00       	push   $0x80258e
  80095d:	ff 75 0c             	pushl  0xc(%ebp)
  800960:	ff 75 08             	pushl  0x8(%ebp)
  800963:	e8 45 02 00 00       	call   800bad <printfmt>
  800968:	83 c4 10             	add    $0x10,%esp
			break;
  80096b:	e9 30 02 00 00       	jmp    800ba0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800970:	8b 45 14             	mov    0x14(%ebp),%eax
  800973:	83 c0 04             	add    $0x4,%eax
  800976:	89 45 14             	mov    %eax,0x14(%ebp)
  800979:	8b 45 14             	mov    0x14(%ebp),%eax
  80097c:	83 e8 04             	sub    $0x4,%eax
  80097f:	8b 30                	mov    (%eax),%esi
  800981:	85 f6                	test   %esi,%esi
  800983:	75 05                	jne    80098a <vprintfmt+0x1a6>
				p = "(null)";
  800985:	be 91 25 80 00       	mov    $0x802591,%esi
			if (width > 0 && padc != '-')
  80098a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098e:	7e 6d                	jle    8009fd <vprintfmt+0x219>
  800990:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800994:	74 67                	je     8009fd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800996:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800999:	83 ec 08             	sub    $0x8,%esp
  80099c:	50                   	push   %eax
  80099d:	56                   	push   %esi
  80099e:	e8 0c 03 00 00       	call   800caf <strnlen>
  8009a3:	83 c4 10             	add    $0x10,%esp
  8009a6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009a9:	eb 16                	jmp    8009c1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009ab:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009af:	83 ec 08             	sub    $0x8,%esp
  8009b2:	ff 75 0c             	pushl  0xc(%ebp)
  8009b5:	50                   	push   %eax
  8009b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b9:	ff d0                	call   *%eax
  8009bb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009be:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c5:	7f e4                	jg     8009ab <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009c7:	eb 34                	jmp    8009fd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009c9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009cd:	74 1c                	je     8009eb <vprintfmt+0x207>
  8009cf:	83 fb 1f             	cmp    $0x1f,%ebx
  8009d2:	7e 05                	jle    8009d9 <vprintfmt+0x1f5>
  8009d4:	83 fb 7e             	cmp    $0x7e,%ebx
  8009d7:	7e 12                	jle    8009eb <vprintfmt+0x207>
					putch('?', putdat);
  8009d9:	83 ec 08             	sub    $0x8,%esp
  8009dc:	ff 75 0c             	pushl  0xc(%ebp)
  8009df:	6a 3f                	push   $0x3f
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	ff d0                	call   *%eax
  8009e6:	83 c4 10             	add    $0x10,%esp
  8009e9:	eb 0f                	jmp    8009fa <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009eb:	83 ec 08             	sub    $0x8,%esp
  8009ee:	ff 75 0c             	pushl  0xc(%ebp)
  8009f1:	53                   	push   %ebx
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	ff d0                	call   *%eax
  8009f7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009fa:	ff 4d e4             	decl   -0x1c(%ebp)
  8009fd:	89 f0                	mov    %esi,%eax
  8009ff:	8d 70 01             	lea    0x1(%eax),%esi
  800a02:	8a 00                	mov    (%eax),%al
  800a04:	0f be d8             	movsbl %al,%ebx
  800a07:	85 db                	test   %ebx,%ebx
  800a09:	74 24                	je     800a2f <vprintfmt+0x24b>
  800a0b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a0f:	78 b8                	js     8009c9 <vprintfmt+0x1e5>
  800a11:	ff 4d e0             	decl   -0x20(%ebp)
  800a14:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a18:	79 af                	jns    8009c9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a1a:	eb 13                	jmp    800a2f <vprintfmt+0x24b>
				putch(' ', putdat);
  800a1c:	83 ec 08             	sub    $0x8,%esp
  800a1f:	ff 75 0c             	pushl  0xc(%ebp)
  800a22:	6a 20                	push   $0x20
  800a24:	8b 45 08             	mov    0x8(%ebp),%eax
  800a27:	ff d0                	call   *%eax
  800a29:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a2c:	ff 4d e4             	decl   -0x1c(%ebp)
  800a2f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a33:	7f e7                	jg     800a1c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a35:	e9 66 01 00 00       	jmp    800ba0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a3a:	83 ec 08             	sub    $0x8,%esp
  800a3d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a40:	8d 45 14             	lea    0x14(%ebp),%eax
  800a43:	50                   	push   %eax
  800a44:	e8 3c fd ff ff       	call   800785 <getint>
  800a49:	83 c4 10             	add    $0x10,%esp
  800a4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a52:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a55:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a58:	85 d2                	test   %edx,%edx
  800a5a:	79 23                	jns    800a7f <vprintfmt+0x29b>
				putch('-', putdat);
  800a5c:	83 ec 08             	sub    $0x8,%esp
  800a5f:	ff 75 0c             	pushl  0xc(%ebp)
  800a62:	6a 2d                	push   $0x2d
  800a64:	8b 45 08             	mov    0x8(%ebp),%eax
  800a67:	ff d0                	call   *%eax
  800a69:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a72:	f7 d8                	neg    %eax
  800a74:	83 d2 00             	adc    $0x0,%edx
  800a77:	f7 da                	neg    %edx
  800a79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a7f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a86:	e9 bc 00 00 00       	jmp    800b47 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a91:	8d 45 14             	lea    0x14(%ebp),%eax
  800a94:	50                   	push   %eax
  800a95:	e8 84 fc ff ff       	call   80071e <getuint>
  800a9a:	83 c4 10             	add    $0x10,%esp
  800a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800aa3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aaa:	e9 98 00 00 00       	jmp    800b47 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800aaf:	83 ec 08             	sub    $0x8,%esp
  800ab2:	ff 75 0c             	pushl  0xc(%ebp)
  800ab5:	6a 58                	push   $0x58
  800ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aba:	ff d0                	call   *%eax
  800abc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800abf:	83 ec 08             	sub    $0x8,%esp
  800ac2:	ff 75 0c             	pushl  0xc(%ebp)
  800ac5:	6a 58                	push   $0x58
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	ff d0                	call   *%eax
  800acc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800acf:	83 ec 08             	sub    $0x8,%esp
  800ad2:	ff 75 0c             	pushl  0xc(%ebp)
  800ad5:	6a 58                	push   $0x58
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	ff d0                	call   *%eax
  800adc:	83 c4 10             	add    $0x10,%esp
			break;
  800adf:	e9 bc 00 00 00       	jmp    800ba0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	6a 30                	push   $0x30
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	ff d0                	call   *%eax
  800af1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 0c             	pushl  0xc(%ebp)
  800afa:	6a 78                	push   $0x78
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	ff d0                	call   *%eax
  800b01:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b04:	8b 45 14             	mov    0x14(%ebp),%eax
  800b07:	83 c0 04             	add    $0x4,%eax
  800b0a:	89 45 14             	mov    %eax,0x14(%ebp)
  800b0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b10:	83 e8 04             	sub    $0x4,%eax
  800b13:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b1f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b26:	eb 1f                	jmp    800b47 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b28:	83 ec 08             	sub    $0x8,%esp
  800b2b:	ff 75 e8             	pushl  -0x18(%ebp)
  800b2e:	8d 45 14             	lea    0x14(%ebp),%eax
  800b31:	50                   	push   %eax
  800b32:	e8 e7 fb ff ff       	call   80071e <getuint>
  800b37:	83 c4 10             	add    $0x10,%esp
  800b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b3d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b40:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b47:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b4e:	83 ec 04             	sub    $0x4,%esp
  800b51:	52                   	push   %edx
  800b52:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b55:	50                   	push   %eax
  800b56:	ff 75 f4             	pushl  -0xc(%ebp)
  800b59:	ff 75 f0             	pushl  -0x10(%ebp)
  800b5c:	ff 75 0c             	pushl  0xc(%ebp)
  800b5f:	ff 75 08             	pushl  0x8(%ebp)
  800b62:	e8 00 fb ff ff       	call   800667 <printnum>
  800b67:	83 c4 20             	add    $0x20,%esp
			break;
  800b6a:	eb 34                	jmp    800ba0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	53                   	push   %ebx
  800b73:	8b 45 08             	mov    0x8(%ebp),%eax
  800b76:	ff d0                	call   *%eax
  800b78:	83 c4 10             	add    $0x10,%esp
			break;
  800b7b:	eb 23                	jmp    800ba0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b7d:	83 ec 08             	sub    $0x8,%esp
  800b80:	ff 75 0c             	pushl  0xc(%ebp)
  800b83:	6a 25                	push   $0x25
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	ff d0                	call   *%eax
  800b8a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b8d:	ff 4d 10             	decl   0x10(%ebp)
  800b90:	eb 03                	jmp    800b95 <vprintfmt+0x3b1>
  800b92:	ff 4d 10             	decl   0x10(%ebp)
  800b95:	8b 45 10             	mov    0x10(%ebp),%eax
  800b98:	48                   	dec    %eax
  800b99:	8a 00                	mov    (%eax),%al
  800b9b:	3c 25                	cmp    $0x25,%al
  800b9d:	75 f3                	jne    800b92 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b9f:	90                   	nop
		}
	}
  800ba0:	e9 47 fc ff ff       	jmp    8007ec <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ba5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ba6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ba9:	5b                   	pop    %ebx
  800baa:	5e                   	pop    %esi
  800bab:	5d                   	pop    %ebp
  800bac:	c3                   	ret    

00800bad <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bb3:	8d 45 10             	lea    0x10(%ebp),%eax
  800bb6:	83 c0 04             	add    $0x4,%eax
  800bb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbf:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc2:	50                   	push   %eax
  800bc3:	ff 75 0c             	pushl  0xc(%ebp)
  800bc6:	ff 75 08             	pushl  0x8(%ebp)
  800bc9:	e8 16 fc ff ff       	call   8007e4 <vprintfmt>
  800bce:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bd1:	90                   	nop
  800bd2:	c9                   	leave  
  800bd3:	c3                   	ret    

00800bd4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bda:	8b 40 08             	mov    0x8(%eax),%eax
  800bdd:	8d 50 01             	lea    0x1(%eax),%edx
  800be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800be6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be9:	8b 10                	mov    (%eax),%edx
  800beb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bee:	8b 40 04             	mov    0x4(%eax),%eax
  800bf1:	39 c2                	cmp    %eax,%edx
  800bf3:	73 12                	jae    800c07 <sprintputch+0x33>
		*b->buf++ = ch;
  800bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf8:	8b 00                	mov    (%eax),%eax
  800bfa:	8d 48 01             	lea    0x1(%eax),%ecx
  800bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c00:	89 0a                	mov    %ecx,(%edx)
  800c02:	8b 55 08             	mov    0x8(%ebp),%edx
  800c05:	88 10                	mov    %dl,(%eax)
}
  800c07:	90                   	nop
  800c08:	5d                   	pop    %ebp
  800c09:	c3                   	ret    

00800c0a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c0a:	55                   	push   %ebp
  800c0b:	89 e5                	mov    %esp,%ebp
  800c0d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c19:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	01 d0                	add    %edx,%eax
  800c21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c2b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c2f:	74 06                	je     800c37 <vsnprintf+0x2d>
  800c31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c35:	7f 07                	jg     800c3e <vsnprintf+0x34>
		return -E_INVAL;
  800c37:	b8 03 00 00 00       	mov    $0x3,%eax
  800c3c:	eb 20                	jmp    800c5e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c3e:	ff 75 14             	pushl  0x14(%ebp)
  800c41:	ff 75 10             	pushl  0x10(%ebp)
  800c44:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c47:	50                   	push   %eax
  800c48:	68 d4 0b 80 00       	push   $0x800bd4
  800c4d:	e8 92 fb ff ff       	call   8007e4 <vprintfmt>
  800c52:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c55:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c58:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c5e:	c9                   	leave  
  800c5f:	c3                   	ret    

00800c60 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c60:	55                   	push   %ebp
  800c61:	89 e5                	mov    %esp,%ebp
  800c63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c66:	8d 45 10             	lea    0x10(%ebp),%eax
  800c69:	83 c0 04             	add    $0x4,%eax
  800c6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c72:	ff 75 f4             	pushl  -0xc(%ebp)
  800c75:	50                   	push   %eax
  800c76:	ff 75 0c             	pushl  0xc(%ebp)
  800c79:	ff 75 08             	pushl  0x8(%ebp)
  800c7c:	e8 89 ff ff ff       	call   800c0a <vsnprintf>
  800c81:	83 c4 10             	add    $0x10,%esp
  800c84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c87:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c8a:	c9                   	leave  
  800c8b:	c3                   	ret    

00800c8c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
  800c8f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c99:	eb 06                	jmp    800ca1 <strlen+0x15>
		n++;
  800c9b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c9e:	ff 45 08             	incl   0x8(%ebp)
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	84 c0                	test   %al,%al
  800ca8:	75 f1                	jne    800c9b <strlen+0xf>
		n++;
	return n;
  800caa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cad:	c9                   	leave  
  800cae:	c3                   	ret    

00800caf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800caf:	55                   	push   %ebp
  800cb0:	89 e5                	mov    %esp,%ebp
  800cb2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cbc:	eb 09                	jmp    800cc7 <strnlen+0x18>
		n++;
  800cbe:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cc1:	ff 45 08             	incl   0x8(%ebp)
  800cc4:	ff 4d 0c             	decl   0xc(%ebp)
  800cc7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ccb:	74 09                	je     800cd6 <strnlen+0x27>
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	8a 00                	mov    (%eax),%al
  800cd2:	84 c0                	test   %al,%al
  800cd4:	75 e8                	jne    800cbe <strnlen+0xf>
		n++;
	return n;
  800cd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd9:	c9                   	leave  
  800cda:	c3                   	ret    

00800cdb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cdb:	55                   	push   %ebp
  800cdc:	89 e5                	mov    %esp,%ebp
  800cde:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ce7:	90                   	nop
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8d 50 01             	lea    0x1(%eax),%edx
  800cee:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cfa:	8a 12                	mov    (%edx),%dl
  800cfc:	88 10                	mov    %dl,(%eax)
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	84 c0                	test   %al,%al
  800d02:	75 e4                	jne    800ce8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d04:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d07:	c9                   	leave  
  800d08:	c3                   	ret    

00800d09 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
  800d0c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1c:	eb 1f                	jmp    800d3d <strncpy+0x34>
		*dst++ = *src;
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	8d 50 01             	lea    0x1(%eax),%edx
  800d24:	89 55 08             	mov    %edx,0x8(%ebp)
  800d27:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d2a:	8a 12                	mov    (%edx),%dl
  800d2c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	84 c0                	test   %al,%al
  800d35:	74 03                	je     800d3a <strncpy+0x31>
			src++;
  800d37:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d3a:	ff 45 fc             	incl   -0x4(%ebp)
  800d3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d40:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d43:	72 d9                	jb     800d1e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d45:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d48:	c9                   	leave  
  800d49:	c3                   	ret    

00800d4a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d4a:	55                   	push   %ebp
  800d4b:	89 e5                	mov    %esp,%ebp
  800d4d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5a:	74 30                	je     800d8c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d5c:	eb 16                	jmp    800d74 <strlcpy+0x2a>
			*dst++ = *src++;
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8d 50 01             	lea    0x1(%eax),%edx
  800d64:	89 55 08             	mov    %edx,0x8(%ebp)
  800d67:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d6d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d70:	8a 12                	mov    (%edx),%dl
  800d72:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d74:	ff 4d 10             	decl   0x10(%ebp)
  800d77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d7b:	74 09                	je     800d86 <strlcpy+0x3c>
  800d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	84 c0                	test   %al,%al
  800d84:	75 d8                	jne    800d5e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d8c:	8b 55 08             	mov    0x8(%ebp),%edx
  800d8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d92:	29 c2                	sub    %eax,%edx
  800d94:	89 d0                	mov    %edx,%eax
}
  800d96:	c9                   	leave  
  800d97:	c3                   	ret    

00800d98 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d98:	55                   	push   %ebp
  800d99:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d9b:	eb 06                	jmp    800da3 <strcmp+0xb>
		p++, q++;
  800d9d:	ff 45 08             	incl   0x8(%ebp)
  800da0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	84 c0                	test   %al,%al
  800daa:	74 0e                	je     800dba <strcmp+0x22>
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	8a 10                	mov    (%eax),%dl
  800db1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	38 c2                	cmp    %al,%dl
  800db8:	74 e3                	je     800d9d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800dba:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbd:	8a 00                	mov    (%eax),%al
  800dbf:	0f b6 d0             	movzbl %al,%edx
  800dc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc5:	8a 00                	mov    (%eax),%al
  800dc7:	0f b6 c0             	movzbl %al,%eax
  800dca:	29 c2                	sub    %eax,%edx
  800dcc:	89 d0                	mov    %edx,%eax
}
  800dce:	5d                   	pop    %ebp
  800dcf:	c3                   	ret    

00800dd0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dd0:	55                   	push   %ebp
  800dd1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800dd3:	eb 09                	jmp    800dde <strncmp+0xe>
		n--, p++, q++;
  800dd5:	ff 4d 10             	decl   0x10(%ebp)
  800dd8:	ff 45 08             	incl   0x8(%ebp)
  800ddb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dde:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de2:	74 17                	je     800dfb <strncmp+0x2b>
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
  800de7:	8a 00                	mov    (%eax),%al
  800de9:	84 c0                	test   %al,%al
  800deb:	74 0e                	je     800dfb <strncmp+0x2b>
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	8a 10                	mov    (%eax),%dl
  800df2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	38 c2                	cmp    %al,%dl
  800df9:	74 da                	je     800dd5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dff:	75 07                	jne    800e08 <strncmp+0x38>
		return 0;
  800e01:	b8 00 00 00 00       	mov    $0x0,%eax
  800e06:	eb 14                	jmp    800e1c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8a 00                	mov    (%eax),%al
  800e0d:	0f b6 d0             	movzbl %al,%edx
  800e10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e13:	8a 00                	mov    (%eax),%al
  800e15:	0f b6 c0             	movzbl %al,%eax
  800e18:	29 c2                	sub    %eax,%edx
  800e1a:	89 d0                	mov    %edx,%eax
}
  800e1c:	5d                   	pop    %ebp
  800e1d:	c3                   	ret    

00800e1e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e1e:	55                   	push   %ebp
  800e1f:	89 e5                	mov    %esp,%ebp
  800e21:	83 ec 04             	sub    $0x4,%esp
  800e24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e27:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e2a:	eb 12                	jmp    800e3e <strchr+0x20>
		if (*s == c)
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e34:	75 05                	jne    800e3b <strchr+0x1d>
			return (char *) s;
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	eb 11                	jmp    800e4c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e3b:	ff 45 08             	incl   0x8(%ebp)
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	84 c0                	test   %al,%al
  800e45:	75 e5                	jne    800e2c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e47:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e4c:	c9                   	leave  
  800e4d:	c3                   	ret    

00800e4e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e4e:	55                   	push   %ebp
  800e4f:	89 e5                	mov    %esp,%ebp
  800e51:	83 ec 04             	sub    $0x4,%esp
  800e54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e57:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e5a:	eb 0d                	jmp    800e69 <strfind+0x1b>
		if (*s == c)
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e64:	74 0e                	je     800e74 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e66:	ff 45 08             	incl   0x8(%ebp)
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	84 c0                	test   %al,%al
  800e70:	75 ea                	jne    800e5c <strfind+0xe>
  800e72:	eb 01                	jmp    800e75 <strfind+0x27>
		if (*s == c)
			break;
  800e74:	90                   	nop
	return (char *) s;
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e78:	c9                   	leave  
  800e79:	c3                   	ret    

00800e7a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e7a:	55                   	push   %ebp
  800e7b:	89 e5                	mov    %esp,%ebp
  800e7d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e86:	8b 45 10             	mov    0x10(%ebp),%eax
  800e89:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e8c:	eb 0e                	jmp    800e9c <memset+0x22>
		*p++ = c;
  800e8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e91:	8d 50 01             	lea    0x1(%eax),%edx
  800e94:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e9c:	ff 4d f8             	decl   -0x8(%ebp)
  800e9f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ea3:	79 e9                	jns    800e8e <memset+0x14>
		*p++ = c;

	return v;
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea8:	c9                   	leave  
  800ea9:	c3                   	ret    

00800eaa <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800eaa:	55                   	push   %ebp
  800eab:	89 e5                	mov    %esp,%ebp
  800ead:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ebc:	eb 16                	jmp    800ed4 <memcpy+0x2a>
		*d++ = *s++;
  800ebe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec1:	8d 50 01             	lea    0x1(%eax),%edx
  800ec4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ec7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eca:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ecd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ed0:	8a 12                	mov    (%edx),%dl
  800ed2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ed4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eda:	89 55 10             	mov    %edx,0x10(%ebp)
  800edd:	85 c0                	test   %eax,%eax
  800edf:	75 dd                	jne    800ebe <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee4:	c9                   	leave  
  800ee5:	c3                   	ret    

00800ee6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ee6:	55                   	push   %ebp
  800ee7:	89 e5                	mov    %esp,%ebp
  800ee9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ef8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800efe:	73 50                	jae    800f50 <memmove+0x6a>
  800f00:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f03:	8b 45 10             	mov    0x10(%ebp),%eax
  800f06:	01 d0                	add    %edx,%eax
  800f08:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f0b:	76 43                	jbe    800f50 <memmove+0x6a>
		s += n;
  800f0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f10:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f13:	8b 45 10             	mov    0x10(%ebp),%eax
  800f16:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f19:	eb 10                	jmp    800f2b <memmove+0x45>
			*--d = *--s;
  800f1b:	ff 4d f8             	decl   -0x8(%ebp)
  800f1e:	ff 4d fc             	decl   -0x4(%ebp)
  800f21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f24:	8a 10                	mov    (%eax),%dl
  800f26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f29:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f31:	89 55 10             	mov    %edx,0x10(%ebp)
  800f34:	85 c0                	test   %eax,%eax
  800f36:	75 e3                	jne    800f1b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f38:	eb 23                	jmp    800f5d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3d:	8d 50 01             	lea    0x1(%eax),%edx
  800f40:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f46:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f49:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f4c:	8a 12                	mov    (%edx),%dl
  800f4e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f50:	8b 45 10             	mov    0x10(%ebp),%eax
  800f53:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f56:	89 55 10             	mov    %edx,0x10(%ebp)
  800f59:	85 c0                	test   %eax,%eax
  800f5b:	75 dd                	jne    800f3a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f60:	c9                   	leave  
  800f61:	c3                   	ret    

00800f62 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f62:	55                   	push   %ebp
  800f63:	89 e5                	mov    %esp,%ebp
  800f65:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f74:	eb 2a                	jmp    800fa0 <memcmp+0x3e>
		if (*s1 != *s2)
  800f76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f79:	8a 10                	mov    (%eax),%dl
  800f7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7e:	8a 00                	mov    (%eax),%al
  800f80:	38 c2                	cmp    %al,%dl
  800f82:	74 16                	je     800f9a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	0f b6 d0             	movzbl %al,%edx
  800f8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	0f b6 c0             	movzbl %al,%eax
  800f94:	29 c2                	sub    %eax,%edx
  800f96:	89 d0                	mov    %edx,%eax
  800f98:	eb 18                	jmp    800fb2 <memcmp+0x50>
		s1++, s2++;
  800f9a:	ff 45 fc             	incl   -0x4(%ebp)
  800f9d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800fa0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa6:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa9:	85 c0                	test   %eax,%eax
  800fab:	75 c9                	jne    800f76 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800fad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fb2:	c9                   	leave  
  800fb3:	c3                   	ret    

00800fb4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fb4:	55                   	push   %ebp
  800fb5:	89 e5                	mov    %esp,%ebp
  800fb7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fba:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc0:	01 d0                	add    %edx,%eax
  800fc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fc5:	eb 15                	jmp    800fdc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	0f b6 d0             	movzbl %al,%edx
  800fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd2:	0f b6 c0             	movzbl %al,%eax
  800fd5:	39 c2                	cmp    %eax,%edx
  800fd7:	74 0d                	je     800fe6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fd9:	ff 45 08             	incl   0x8(%ebp)
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fe2:	72 e3                	jb     800fc7 <memfind+0x13>
  800fe4:	eb 01                	jmp    800fe7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fe6:	90                   	nop
	return (void *) s;
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fea:	c9                   	leave  
  800feb:	c3                   	ret    

00800fec <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
  800fef:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ff2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ff9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801000:	eb 03                	jmp    801005 <strtol+0x19>
		s++;
  801002:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	3c 20                	cmp    $0x20,%al
  80100c:	74 f4                	je     801002 <strtol+0x16>
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	3c 09                	cmp    $0x9,%al
  801015:	74 eb                	je     801002 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	8a 00                	mov    (%eax),%al
  80101c:	3c 2b                	cmp    $0x2b,%al
  80101e:	75 05                	jne    801025 <strtol+0x39>
		s++;
  801020:	ff 45 08             	incl   0x8(%ebp)
  801023:	eb 13                	jmp    801038 <strtol+0x4c>
	else if (*s == '-')
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 00                	mov    (%eax),%al
  80102a:	3c 2d                	cmp    $0x2d,%al
  80102c:	75 0a                	jne    801038 <strtol+0x4c>
		s++, neg = 1;
  80102e:	ff 45 08             	incl   0x8(%ebp)
  801031:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801038:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80103c:	74 06                	je     801044 <strtol+0x58>
  80103e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801042:	75 20                	jne    801064 <strtol+0x78>
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	3c 30                	cmp    $0x30,%al
  80104b:	75 17                	jne    801064 <strtol+0x78>
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	40                   	inc    %eax
  801051:	8a 00                	mov    (%eax),%al
  801053:	3c 78                	cmp    $0x78,%al
  801055:	75 0d                	jne    801064 <strtol+0x78>
		s += 2, base = 16;
  801057:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80105b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801062:	eb 28                	jmp    80108c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801064:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801068:	75 15                	jne    80107f <strtol+0x93>
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	3c 30                	cmp    $0x30,%al
  801071:	75 0c                	jne    80107f <strtol+0x93>
		s++, base = 8;
  801073:	ff 45 08             	incl   0x8(%ebp)
  801076:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80107d:	eb 0d                	jmp    80108c <strtol+0xa0>
	else if (base == 0)
  80107f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801083:	75 07                	jne    80108c <strtol+0xa0>
		base = 10;
  801085:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	3c 2f                	cmp    $0x2f,%al
  801093:	7e 19                	jle    8010ae <strtol+0xc2>
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	8a 00                	mov    (%eax),%al
  80109a:	3c 39                	cmp    $0x39,%al
  80109c:	7f 10                	jg     8010ae <strtol+0xc2>
			dig = *s - '0';
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	8a 00                	mov    (%eax),%al
  8010a3:	0f be c0             	movsbl %al,%eax
  8010a6:	83 e8 30             	sub    $0x30,%eax
  8010a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ac:	eb 42                	jmp    8010f0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	3c 60                	cmp    $0x60,%al
  8010b5:	7e 19                	jle    8010d0 <strtol+0xe4>
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	8a 00                	mov    (%eax),%al
  8010bc:	3c 7a                	cmp    $0x7a,%al
  8010be:	7f 10                	jg     8010d0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	0f be c0             	movsbl %al,%eax
  8010c8:	83 e8 57             	sub    $0x57,%eax
  8010cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ce:	eb 20                	jmp    8010f0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	3c 40                	cmp    $0x40,%al
  8010d7:	7e 39                	jle    801112 <strtol+0x126>
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	3c 5a                	cmp    $0x5a,%al
  8010e0:	7f 30                	jg     801112 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	0f be c0             	movsbl %al,%eax
  8010ea:	83 e8 37             	sub    $0x37,%eax
  8010ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010f6:	7d 19                	jge    801111 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010f8:	ff 45 08             	incl   0x8(%ebp)
  8010fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fe:	0f af 45 10          	imul   0x10(%ebp),%eax
  801102:	89 c2                	mov    %eax,%edx
  801104:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801107:	01 d0                	add    %edx,%eax
  801109:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80110c:	e9 7b ff ff ff       	jmp    80108c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801111:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801112:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801116:	74 08                	je     801120 <strtol+0x134>
		*endptr = (char *) s;
  801118:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111b:	8b 55 08             	mov    0x8(%ebp),%edx
  80111e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801120:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801124:	74 07                	je     80112d <strtol+0x141>
  801126:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801129:	f7 d8                	neg    %eax
  80112b:	eb 03                	jmp    801130 <strtol+0x144>
  80112d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801130:	c9                   	leave  
  801131:	c3                   	ret    

00801132 <ltostr>:

void
ltostr(long value, char *str)
{
  801132:	55                   	push   %ebp
  801133:	89 e5                	mov    %esp,%ebp
  801135:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801138:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80113f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801146:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80114a:	79 13                	jns    80115f <ltostr+0x2d>
	{
		neg = 1;
  80114c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801153:	8b 45 0c             	mov    0xc(%ebp),%eax
  801156:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801159:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80115c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801167:	99                   	cltd   
  801168:	f7 f9                	idiv   %ecx
  80116a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80116d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801170:	8d 50 01             	lea    0x1(%eax),%edx
  801173:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801176:	89 c2                	mov    %eax,%edx
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	01 d0                	add    %edx,%eax
  80117d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801180:	83 c2 30             	add    $0x30,%edx
  801183:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801185:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801188:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80118d:	f7 e9                	imul   %ecx
  80118f:	c1 fa 02             	sar    $0x2,%edx
  801192:	89 c8                	mov    %ecx,%eax
  801194:	c1 f8 1f             	sar    $0x1f,%eax
  801197:	29 c2                	sub    %eax,%edx
  801199:	89 d0                	mov    %edx,%eax
  80119b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80119e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011a1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011a6:	f7 e9                	imul   %ecx
  8011a8:	c1 fa 02             	sar    $0x2,%edx
  8011ab:	89 c8                	mov    %ecx,%eax
  8011ad:	c1 f8 1f             	sar    $0x1f,%eax
  8011b0:	29 c2                	sub    %eax,%edx
  8011b2:	89 d0                	mov    %edx,%eax
  8011b4:	c1 e0 02             	shl    $0x2,%eax
  8011b7:	01 d0                	add    %edx,%eax
  8011b9:	01 c0                	add    %eax,%eax
  8011bb:	29 c1                	sub    %eax,%ecx
  8011bd:	89 ca                	mov    %ecx,%edx
  8011bf:	85 d2                	test   %edx,%edx
  8011c1:	75 9c                	jne    80115f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cd:	48                   	dec    %eax
  8011ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011d5:	74 3d                	je     801214 <ltostr+0xe2>
		start = 1 ;
  8011d7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011de:	eb 34                	jmp    801214 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e6:	01 d0                	add    %edx,%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f3:	01 c2                	add    %eax,%edx
  8011f5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fb:	01 c8                	add    %ecx,%eax
  8011fd:	8a 00                	mov    (%eax),%al
  8011ff:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801201:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801204:	8b 45 0c             	mov    0xc(%ebp),%eax
  801207:	01 c2                	add    %eax,%edx
  801209:	8a 45 eb             	mov    -0x15(%ebp),%al
  80120c:	88 02                	mov    %al,(%edx)
		start++ ;
  80120e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801211:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801214:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801217:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80121a:	7c c4                	jl     8011e0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80121c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80121f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801222:	01 d0                	add    %edx,%eax
  801224:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801227:	90                   	nop
  801228:	c9                   	leave  
  801229:	c3                   	ret    

0080122a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80122a:	55                   	push   %ebp
  80122b:	89 e5                	mov    %esp,%ebp
  80122d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801230:	ff 75 08             	pushl  0x8(%ebp)
  801233:	e8 54 fa ff ff       	call   800c8c <strlen>
  801238:	83 c4 04             	add    $0x4,%esp
  80123b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80123e:	ff 75 0c             	pushl  0xc(%ebp)
  801241:	e8 46 fa ff ff       	call   800c8c <strlen>
  801246:	83 c4 04             	add    $0x4,%esp
  801249:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80124c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801253:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80125a:	eb 17                	jmp    801273 <strcconcat+0x49>
		final[s] = str1[s] ;
  80125c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125f:	8b 45 10             	mov    0x10(%ebp),%eax
  801262:	01 c2                	add    %eax,%edx
  801264:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	01 c8                	add    %ecx,%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801270:	ff 45 fc             	incl   -0x4(%ebp)
  801273:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801276:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801279:	7c e1                	jl     80125c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80127b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801282:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801289:	eb 1f                	jmp    8012aa <strcconcat+0x80>
		final[s++] = str2[i] ;
  80128b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128e:	8d 50 01             	lea    0x1(%eax),%edx
  801291:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801294:	89 c2                	mov    %eax,%edx
  801296:	8b 45 10             	mov    0x10(%ebp),%eax
  801299:	01 c2                	add    %eax,%edx
  80129b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	01 c8                	add    %ecx,%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012a7:	ff 45 f8             	incl   -0x8(%ebp)
  8012aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012b0:	7c d9                	jl     80128b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b8:	01 d0                	add    %edx,%eax
  8012ba:	c6 00 00             	movb   $0x0,(%eax)
}
  8012bd:	90                   	nop
  8012be:	c9                   	leave  
  8012bf:	c3                   	ret    

008012c0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8012cf:	8b 00                	mov    (%eax),%eax
  8012d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012db:	01 d0                	add    %edx,%eax
  8012dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012e3:	eb 0c                	jmp    8012f1 <strsplit+0x31>
			*string++ = 0;
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	8d 50 01             	lea    0x1(%eax),%edx
  8012eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ee:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	8a 00                	mov    (%eax),%al
  8012f6:	84 c0                	test   %al,%al
  8012f8:	74 18                	je     801312 <strsplit+0x52>
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	0f be c0             	movsbl %al,%eax
  801302:	50                   	push   %eax
  801303:	ff 75 0c             	pushl  0xc(%ebp)
  801306:	e8 13 fb ff ff       	call   800e1e <strchr>
  80130b:	83 c4 08             	add    $0x8,%esp
  80130e:	85 c0                	test   %eax,%eax
  801310:	75 d3                	jne    8012e5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	84 c0                	test   %al,%al
  801319:	74 5a                	je     801375 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80131b:	8b 45 14             	mov    0x14(%ebp),%eax
  80131e:	8b 00                	mov    (%eax),%eax
  801320:	83 f8 0f             	cmp    $0xf,%eax
  801323:	75 07                	jne    80132c <strsplit+0x6c>
		{
			return 0;
  801325:	b8 00 00 00 00       	mov    $0x0,%eax
  80132a:	eb 66                	jmp    801392 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80132c:	8b 45 14             	mov    0x14(%ebp),%eax
  80132f:	8b 00                	mov    (%eax),%eax
  801331:	8d 48 01             	lea    0x1(%eax),%ecx
  801334:	8b 55 14             	mov    0x14(%ebp),%edx
  801337:	89 0a                	mov    %ecx,(%edx)
  801339:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801340:	8b 45 10             	mov    0x10(%ebp),%eax
  801343:	01 c2                	add    %eax,%edx
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
  801348:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80134a:	eb 03                	jmp    80134f <strsplit+0x8f>
			string++;
  80134c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	84 c0                	test   %al,%al
  801356:	74 8b                	je     8012e3 <strsplit+0x23>
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	0f be c0             	movsbl %al,%eax
  801360:	50                   	push   %eax
  801361:	ff 75 0c             	pushl  0xc(%ebp)
  801364:	e8 b5 fa ff ff       	call   800e1e <strchr>
  801369:	83 c4 08             	add    $0x8,%esp
  80136c:	85 c0                	test   %eax,%eax
  80136e:	74 dc                	je     80134c <strsplit+0x8c>
			string++;
	}
  801370:	e9 6e ff ff ff       	jmp    8012e3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801375:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801376:	8b 45 14             	mov    0x14(%ebp),%eax
  801379:	8b 00                	mov    (%eax),%eax
  80137b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801382:	8b 45 10             	mov    0x10(%ebp),%eax
  801385:	01 d0                	add    %edx,%eax
  801387:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80138d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
  801397:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80139a:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  8013a1:	76 0a                	jbe    8013ad <malloc+0x19>
		return NULL;
  8013a3:	b8 00 00 00 00       	mov    $0x0,%eax
  8013a8:	e9 ad 02 00 00       	jmp    80165a <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	c1 e8 0c             	shr    $0xc,%eax
  8013b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	25 ff 0f 00 00       	and    $0xfff,%eax
  8013be:	85 c0                	test   %eax,%eax
  8013c0:	74 03                	je     8013c5 <malloc+0x31>
		num++;
  8013c2:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  8013c5:	a1 28 30 80 00       	mov    0x803028,%eax
  8013ca:	85 c0                	test   %eax,%eax
  8013cc:	75 71                	jne    80143f <malloc+0xab>
		sys_allocateMem(last_addres, size);
  8013ce:	a1 04 30 80 00       	mov    0x803004,%eax
  8013d3:	83 ec 08             	sub    $0x8,%esp
  8013d6:	ff 75 08             	pushl  0x8(%ebp)
  8013d9:	50                   	push   %eax
  8013da:	e8 ba 05 00 00       	call   801999 <sys_allocateMem>
  8013df:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  8013e2:	a1 04 30 80 00       	mov    0x803004,%eax
  8013e7:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  8013ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ed:	c1 e0 0c             	shl    $0xc,%eax
  8013f0:	89 c2                	mov    %eax,%edx
  8013f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8013f7:	01 d0                	add    %edx,%eax
  8013f9:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8013fe:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801403:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801406:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  80140d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801412:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801415:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  80141c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801421:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801428:	01 00 00 00 
		sizeofarray++;
  80142c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801431:	40                   	inc    %eax
  801432:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  801437:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80143a:	e9 1b 02 00 00       	jmp    80165a <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  80143f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801446:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  80144d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801454:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  80145b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801462:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801469:	eb 72                	jmp    8014dd <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  80146b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80146e:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801475:	85 c0                	test   %eax,%eax
  801477:	75 12                	jne    80148b <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801479:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80147c:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801483:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801486:	ff 45 dc             	incl   -0x24(%ebp)
  801489:	eb 4f                	jmp    8014da <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  80148b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80148e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801491:	7d 39                	jge    8014cc <malloc+0x138>
  801493:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801496:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801499:	7c 31                	jl     8014cc <malloc+0x138>
					{
						min=count;
  80149b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80149e:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  8014a1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014a4:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8014ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014ae:	c1 e2 0c             	shl    $0xc,%edx
  8014b1:	29 d0                	sub    %edx,%eax
  8014b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  8014b6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014b9:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8014bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  8014bf:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  8014c6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  8014cc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  8014d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  8014da:	ff 45 d4             	incl   -0x2c(%ebp)
  8014dd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014e2:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  8014e5:	7c 84                	jl     80146b <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  8014e7:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  8014eb:	0f 85 e3 00 00 00    	jne    8015d4 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  8014f1:	83 ec 08             	sub    $0x8,%esp
  8014f4:	ff 75 08             	pushl  0x8(%ebp)
  8014f7:	ff 75 e0             	pushl  -0x20(%ebp)
  8014fa:	e8 9a 04 00 00       	call   801999 <sys_allocateMem>
  8014ff:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801502:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801507:	40                   	inc    %eax
  801508:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  80150d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801512:	48                   	dec    %eax
  801513:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801516:	eb 42                	jmp    80155a <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801518:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80151b:	48                   	dec    %eax
  80151c:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801523:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801526:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  80152d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801530:	48                   	dec    %eax
  801531:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801538:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80153b:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801542:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801545:	48                   	dec    %eax
  801546:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  80154d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801550:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801557:	ff 4d d0             	decl   -0x30(%ebp)
  80155a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80155d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801560:	7f b6                	jg     801518 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801562:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801565:	40                   	inc    %eax
  801566:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801569:	8b 55 08             	mov    0x8(%ebp),%edx
  80156c:	01 ca                	add    %ecx,%edx
  80156e:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801575:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801578:	8d 50 01             	lea    0x1(%eax),%edx
  80157b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80157e:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801585:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801588:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  80158f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801592:	40                   	inc    %eax
  801593:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  80159a:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  80159e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a4:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  8015ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015ae:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8015b1:	eb 11                	jmp    8015c4 <malloc+0x230>
				{
					changed[index] = 1;
  8015b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015b6:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8015bd:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  8015c1:	ff 45 cc             	incl   -0x34(%ebp)
  8015c4:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8015c7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015ca:	7c e7                	jl     8015b3 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  8015cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015cf:	e9 86 00 00 00       	jmp    80165a <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  8015d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8015d9:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  8015de:	29 c2                	sub    %eax,%edx
  8015e0:	89 d0                	mov    %edx,%eax
  8015e2:	3b 45 08             	cmp    0x8(%ebp),%eax
  8015e5:	73 07                	jae    8015ee <malloc+0x25a>
						return NULL;
  8015e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8015ec:	eb 6c                	jmp    80165a <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  8015ee:	a1 04 30 80 00       	mov    0x803004,%eax
  8015f3:	83 ec 08             	sub    $0x8,%esp
  8015f6:	ff 75 08             	pushl  0x8(%ebp)
  8015f9:	50                   	push   %eax
  8015fa:	e8 9a 03 00 00       	call   801999 <sys_allocateMem>
  8015ff:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801602:	a1 04 30 80 00       	mov    0x803004,%eax
  801607:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  80160a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80160d:	c1 e0 0c             	shl    $0xc,%eax
  801610:	89 c2                	mov    %eax,%edx
  801612:	a1 04 30 80 00       	mov    0x803004,%eax
  801617:	01 d0                	add    %edx,%eax
  801619:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  80161e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801623:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801626:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  80162d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801632:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801635:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  80163c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801641:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801648:	01 00 00 00 
					sizeofarray++;
  80164c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801651:	40                   	inc    %eax
  801652:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  801657:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801668:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  80166f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801676:	eb 30                	jmp    8016a8 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801678:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80167b:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801682:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801685:	75 1e                	jne    8016a5 <free+0x49>
  801687:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80168a:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801691:	83 f8 01             	cmp    $0x1,%eax
  801694:	75 0f                	jne    8016a5 <free+0x49>
			is_found = 1;
  801696:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  80169d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8016a3:	eb 0d                	jmp    8016b2 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8016a5:	ff 45 ec             	incl   -0x14(%ebp)
  8016a8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016ad:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8016b0:	7c c6                	jl     801678 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8016b2:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8016b6:	75 3a                	jne    8016f2 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  8016b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016bb:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8016c2:	c1 e0 0c             	shl    $0xc,%eax
  8016c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  8016c8:	83 ec 08             	sub    $0x8,%esp
  8016cb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016ce:	ff 75 e8             	pushl  -0x18(%ebp)
  8016d1:	e8 a7 02 00 00       	call   80197d <sys_freeMem>
  8016d6:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  8016d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016dc:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  8016e3:	00 00 00 00 
		changes++;
  8016e7:	a1 28 30 80 00       	mov    0x803028,%eax
  8016ec:	40                   	inc    %eax
  8016ed:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  8016f2:	90                   	nop
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
  8016f8:	83 ec 18             	sub    $0x18,%esp
  8016fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fe:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801701:	83 ec 04             	sub    $0x4,%esp
  801704:	68 f0 26 80 00       	push   $0x8026f0
  801709:	68 b6 00 00 00       	push   $0xb6
  80170e:	68 13 27 80 00       	push   $0x802713
  801713:	e8 50 ec ff ff       	call   800368 <_panic>

00801718 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80171e:	83 ec 04             	sub    $0x4,%esp
  801721:	68 f0 26 80 00       	push   $0x8026f0
  801726:	68 bb 00 00 00       	push   $0xbb
  80172b:	68 13 27 80 00       	push   $0x802713
  801730:	e8 33 ec ff ff       	call   800368 <_panic>

00801735 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
  801738:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80173b:	83 ec 04             	sub    $0x4,%esp
  80173e:	68 f0 26 80 00       	push   $0x8026f0
  801743:	68 c0 00 00 00       	push   $0xc0
  801748:	68 13 27 80 00       	push   $0x802713
  80174d:	e8 16 ec ff ff       	call   800368 <_panic>

00801752 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801752:	55                   	push   %ebp
  801753:	89 e5                	mov    %esp,%ebp
  801755:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801758:	83 ec 04             	sub    $0x4,%esp
  80175b:	68 f0 26 80 00       	push   $0x8026f0
  801760:	68 c4 00 00 00       	push   $0xc4
  801765:	68 13 27 80 00       	push   $0x802713
  80176a:	e8 f9 eb ff ff       	call   800368 <_panic>

0080176f <expand>:
	return 0;
}

void expand(uint32 newSize) {
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
  801772:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801775:	83 ec 04             	sub    $0x4,%esp
  801778:	68 f0 26 80 00       	push   $0x8026f0
  80177d:	68 c9 00 00 00       	push   $0xc9
  801782:	68 13 27 80 00       	push   $0x802713
  801787:	e8 dc eb ff ff       	call   800368 <_panic>

0080178c <shrink>:
}
void shrink(uint32 newSize) {
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
  80178f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801792:	83 ec 04             	sub    $0x4,%esp
  801795:	68 f0 26 80 00       	push   $0x8026f0
  80179a:	68 cc 00 00 00       	push   $0xcc
  80179f:	68 13 27 80 00       	push   $0x802713
  8017a4:	e8 bf eb ff ff       	call   800368 <_panic>

008017a9 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
  8017ac:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017af:	83 ec 04             	sub    $0x4,%esp
  8017b2:	68 f0 26 80 00       	push   $0x8026f0
  8017b7:	68 d0 00 00 00       	push   $0xd0
  8017bc:	68 13 27 80 00       	push   $0x802713
  8017c1:	e8 a2 eb ff ff       	call   800368 <_panic>

008017c6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	57                   	push   %edi
  8017ca:	56                   	push   %esi
  8017cb:	53                   	push   %ebx
  8017cc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017d8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017db:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017de:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017e1:	cd 30                	int    $0x30
  8017e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017e9:	83 c4 10             	add    $0x10,%esp
  8017ec:	5b                   	pop    %ebx
  8017ed:	5e                   	pop    %esi
  8017ee:	5f                   	pop    %edi
  8017ef:	5d                   	pop    %ebp
  8017f0:	c3                   	ret    

008017f1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 04             	sub    $0x4,%esp
  8017f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017fd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	52                   	push   %edx
  801809:	ff 75 0c             	pushl  0xc(%ebp)
  80180c:	50                   	push   %eax
  80180d:	6a 00                	push   $0x0
  80180f:	e8 b2 ff ff ff       	call   8017c6 <syscall>
  801814:	83 c4 18             	add    $0x18,%esp
}
  801817:	90                   	nop
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_cgetc>:

int
sys_cgetc(void)
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 01                	push   $0x1
  801829:	e8 98 ff ff ff       	call   8017c6 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	50                   	push   %eax
  801842:	6a 05                	push   $0x5
  801844:	e8 7d ff ff ff       	call   8017c6 <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
}
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 02                	push   $0x2
  80185d:	e8 64 ff ff ff       	call   8017c6 <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
}
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 03                	push   $0x3
  801876:	e8 4b ff ff ff       	call   8017c6 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
}
  80187e:	c9                   	leave  
  80187f:	c3                   	ret    

00801880 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801880:	55                   	push   %ebp
  801881:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 04                	push   $0x4
  80188f:	e8 32 ff ff ff       	call   8017c6 <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_env_exit>:


void sys_env_exit(void)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 06                	push   $0x6
  8018a8:	e8 19 ff ff ff       	call   8017c6 <syscall>
  8018ad:	83 c4 18             	add    $0x18,%esp
}
  8018b0:	90                   	nop
  8018b1:	c9                   	leave  
  8018b2:	c3                   	ret    

008018b3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018b3:	55                   	push   %ebp
  8018b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	52                   	push   %edx
  8018c3:	50                   	push   %eax
  8018c4:	6a 07                	push   $0x7
  8018c6:	e8 fb fe ff ff       	call   8017c6 <syscall>
  8018cb:	83 c4 18             	add    $0x18,%esp
}
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
  8018d3:	56                   	push   %esi
  8018d4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018d5:	8b 75 18             	mov    0x18(%ebp),%esi
  8018d8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e4:	56                   	push   %esi
  8018e5:	53                   	push   %ebx
  8018e6:	51                   	push   %ecx
  8018e7:	52                   	push   %edx
  8018e8:	50                   	push   %eax
  8018e9:	6a 08                	push   $0x8
  8018eb:	e8 d6 fe ff ff       	call   8017c6 <syscall>
  8018f0:	83 c4 18             	add    $0x18,%esp
}
  8018f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018f6:	5b                   	pop    %ebx
  8018f7:	5e                   	pop    %esi
  8018f8:	5d                   	pop    %ebp
  8018f9:	c3                   	ret    

008018fa <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018fa:	55                   	push   %ebp
  8018fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	52                   	push   %edx
  80190a:	50                   	push   %eax
  80190b:	6a 09                	push   $0x9
  80190d:	e8 b4 fe ff ff       	call   8017c6 <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
}
  801915:	c9                   	leave  
  801916:	c3                   	ret    

00801917 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801917:	55                   	push   %ebp
  801918:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	ff 75 0c             	pushl  0xc(%ebp)
  801923:	ff 75 08             	pushl  0x8(%ebp)
  801926:	6a 0a                	push   $0xa
  801928:	e8 99 fe ff ff       	call   8017c6 <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 0b                	push   $0xb
  801941:	e8 80 fe ff ff       	call   8017c6 <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 0c                	push   $0xc
  80195a:	e8 67 fe ff ff       	call   8017c6 <syscall>
  80195f:	83 c4 18             	add    $0x18,%esp
}
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 0d                	push   $0xd
  801973:	e8 4e fe ff ff       	call   8017c6 <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	ff 75 0c             	pushl  0xc(%ebp)
  801989:	ff 75 08             	pushl  0x8(%ebp)
  80198c:	6a 11                	push   $0x11
  80198e:	e8 33 fe ff ff       	call   8017c6 <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
	return;
  801996:	90                   	nop
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	ff 75 0c             	pushl  0xc(%ebp)
  8019a5:	ff 75 08             	pushl  0x8(%ebp)
  8019a8:	6a 12                	push   $0x12
  8019aa:	e8 17 fe ff ff       	call   8017c6 <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b2:	90                   	nop
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 0e                	push   $0xe
  8019c4:	e8 fd fd ff ff       	call   8017c6 <syscall>
  8019c9:	83 c4 18             	add    $0x18,%esp
}
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	ff 75 08             	pushl  0x8(%ebp)
  8019dc:	6a 0f                	push   $0xf
  8019de:	e8 e3 fd ff ff       	call   8017c6 <syscall>
  8019e3:	83 c4 18             	add    $0x18,%esp
}
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 10                	push   $0x10
  8019f7:	e8 ca fd ff ff       	call   8017c6 <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	90                   	nop
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 14                	push   $0x14
  801a11:	e8 b0 fd ff ff       	call   8017c6 <syscall>
  801a16:	83 c4 18             	add    $0x18,%esp
}
  801a19:	90                   	nop
  801a1a:	c9                   	leave  
  801a1b:	c3                   	ret    

00801a1c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a1c:	55                   	push   %ebp
  801a1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 15                	push   $0x15
  801a2b:	e8 96 fd ff ff       	call   8017c6 <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
  801a39:	83 ec 04             	sub    $0x4,%esp
  801a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a42:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	50                   	push   %eax
  801a4f:	6a 16                	push   $0x16
  801a51:	e8 70 fd ff ff       	call   8017c6 <syscall>
  801a56:	83 c4 18             	add    $0x18,%esp
}
  801a59:	90                   	nop
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 17                	push   $0x17
  801a6b:	e8 56 fd ff ff       	call   8017c6 <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
}
  801a73:	90                   	nop
  801a74:	c9                   	leave  
  801a75:	c3                   	ret    

00801a76 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a79:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	ff 75 0c             	pushl  0xc(%ebp)
  801a85:	50                   	push   %eax
  801a86:	6a 18                	push   $0x18
  801a88:	e8 39 fd ff ff       	call   8017c6 <syscall>
  801a8d:	83 c4 18             	add    $0x18,%esp
}
  801a90:	c9                   	leave  
  801a91:	c3                   	ret    

00801a92 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a92:	55                   	push   %ebp
  801a93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a98:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	52                   	push   %edx
  801aa2:	50                   	push   %eax
  801aa3:	6a 1b                	push   $0x1b
  801aa5:	e8 1c fd ff ff       	call   8017c6 <syscall>
  801aaa:	83 c4 18             	add    $0x18,%esp
}
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ab2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	52                   	push   %edx
  801abf:	50                   	push   %eax
  801ac0:	6a 19                	push   $0x19
  801ac2:	e8 ff fc ff ff       	call   8017c6 <syscall>
  801ac7:	83 c4 18             	add    $0x18,%esp
}
  801aca:	90                   	nop
  801acb:	c9                   	leave  
  801acc:	c3                   	ret    

00801acd <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ad0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	52                   	push   %edx
  801add:	50                   	push   %eax
  801ade:	6a 1a                	push   $0x1a
  801ae0:	e8 e1 fc ff ff       	call   8017c6 <syscall>
  801ae5:	83 c4 18             	add    $0x18,%esp
}
  801ae8:	90                   	nop
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
  801aee:	83 ec 04             	sub    $0x4,%esp
  801af1:	8b 45 10             	mov    0x10(%ebp),%eax
  801af4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801af7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801afa:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801afe:	8b 45 08             	mov    0x8(%ebp),%eax
  801b01:	6a 00                	push   $0x0
  801b03:	51                   	push   %ecx
  801b04:	52                   	push   %edx
  801b05:	ff 75 0c             	pushl  0xc(%ebp)
  801b08:	50                   	push   %eax
  801b09:	6a 1c                	push   $0x1c
  801b0b:	e8 b6 fc ff ff       	call   8017c6 <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
}
  801b13:	c9                   	leave  
  801b14:	c3                   	ret    

00801b15 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b15:	55                   	push   %ebp
  801b16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	52                   	push   %edx
  801b25:	50                   	push   %eax
  801b26:	6a 1d                	push   $0x1d
  801b28:	e8 99 fc ff ff       	call   8017c6 <syscall>
  801b2d:	83 c4 18             	add    $0x18,%esp
}
  801b30:	c9                   	leave  
  801b31:	c3                   	ret    

00801b32 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b35:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	51                   	push   %ecx
  801b43:	52                   	push   %edx
  801b44:	50                   	push   %eax
  801b45:	6a 1e                	push   $0x1e
  801b47:	e8 7a fc ff ff       	call   8017c6 <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	52                   	push   %edx
  801b61:	50                   	push   %eax
  801b62:	6a 1f                	push   $0x1f
  801b64:	e8 5d fc ff ff       	call   8017c6 <syscall>
  801b69:	83 c4 18             	add    $0x18,%esp
}
  801b6c:	c9                   	leave  
  801b6d:	c3                   	ret    

00801b6e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b6e:	55                   	push   %ebp
  801b6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 20                	push   $0x20
  801b7d:	e8 44 fc ff ff       	call   8017c6 <syscall>
  801b82:	83 c4 18             	add    $0x18,%esp
}
  801b85:	c9                   	leave  
  801b86:	c3                   	ret    

00801b87 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b87:	55                   	push   %ebp
  801b88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8d:	6a 00                	push   $0x0
  801b8f:	ff 75 14             	pushl  0x14(%ebp)
  801b92:	ff 75 10             	pushl  0x10(%ebp)
  801b95:	ff 75 0c             	pushl  0xc(%ebp)
  801b98:	50                   	push   %eax
  801b99:	6a 21                	push   $0x21
  801b9b:	e8 26 fc ff ff       	call   8017c6 <syscall>
  801ba0:	83 c4 18             	add    $0x18,%esp
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	50                   	push   %eax
  801bb4:	6a 22                	push   $0x22
  801bb6:	e8 0b fc ff ff       	call   8017c6 <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
}
  801bbe:	90                   	nop
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	50                   	push   %eax
  801bd0:	6a 23                	push   $0x23
  801bd2:	e8 ef fb ff ff       	call   8017c6 <syscall>
  801bd7:	83 c4 18             	add    $0x18,%esp
}
  801bda:	90                   	nop
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
  801be0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801be3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801be6:	8d 50 04             	lea    0x4(%eax),%edx
  801be9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	52                   	push   %edx
  801bf3:	50                   	push   %eax
  801bf4:	6a 24                	push   $0x24
  801bf6:	e8 cb fb ff ff       	call   8017c6 <syscall>
  801bfb:	83 c4 18             	add    $0x18,%esp
	return result;
  801bfe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c04:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c07:	89 01                	mov    %eax,(%ecx)
  801c09:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0f:	c9                   	leave  
  801c10:	c2 04 00             	ret    $0x4

00801c13 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	ff 75 10             	pushl  0x10(%ebp)
  801c1d:	ff 75 0c             	pushl  0xc(%ebp)
  801c20:	ff 75 08             	pushl  0x8(%ebp)
  801c23:	6a 13                	push   $0x13
  801c25:	e8 9c fb ff ff       	call   8017c6 <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c2d:	90                   	nop
}
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 25                	push   $0x25
  801c3f:	e8 82 fb ff ff       	call   8017c6 <syscall>
  801c44:	83 c4 18             	add    $0x18,%esp
}
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
  801c4c:	83 ec 04             	sub    $0x4,%esp
  801c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c52:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c55:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	50                   	push   %eax
  801c62:	6a 26                	push   $0x26
  801c64:	e8 5d fb ff ff       	call   8017c6 <syscall>
  801c69:	83 c4 18             	add    $0x18,%esp
	return ;
  801c6c:	90                   	nop
}
  801c6d:	c9                   	leave  
  801c6e:	c3                   	ret    

00801c6f <rsttst>:
void rsttst()
{
  801c6f:	55                   	push   %ebp
  801c70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 28                	push   $0x28
  801c7e:	e8 43 fb ff ff       	call   8017c6 <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
	return ;
  801c86:	90                   	nop
}
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	83 ec 04             	sub    $0x4,%esp
  801c8f:	8b 45 14             	mov    0x14(%ebp),%eax
  801c92:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c95:	8b 55 18             	mov    0x18(%ebp),%edx
  801c98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c9c:	52                   	push   %edx
  801c9d:	50                   	push   %eax
  801c9e:	ff 75 10             	pushl  0x10(%ebp)
  801ca1:	ff 75 0c             	pushl  0xc(%ebp)
  801ca4:	ff 75 08             	pushl  0x8(%ebp)
  801ca7:	6a 27                	push   $0x27
  801ca9:	e8 18 fb ff ff       	call   8017c6 <syscall>
  801cae:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb1:	90                   	nop
}
  801cb2:	c9                   	leave  
  801cb3:	c3                   	ret    

00801cb4 <chktst>:
void chktst(uint32 n)
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	ff 75 08             	pushl  0x8(%ebp)
  801cc2:	6a 29                	push   $0x29
  801cc4:	e8 fd fa ff ff       	call   8017c6 <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
	return ;
  801ccc:	90                   	nop
}
  801ccd:	c9                   	leave  
  801cce:	c3                   	ret    

00801ccf <inctst>:

void inctst()
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 2a                	push   $0x2a
  801cde:	e8 e3 fa ff ff       	call   8017c6 <syscall>
  801ce3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ce6:	90                   	nop
}
  801ce7:	c9                   	leave  
  801ce8:	c3                   	ret    

00801ce9 <gettst>:
uint32 gettst()
{
  801ce9:	55                   	push   %ebp
  801cea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 2b                	push   $0x2b
  801cf8:	e8 c9 fa ff ff       	call   8017c6 <syscall>
  801cfd:	83 c4 18             	add    $0x18,%esp
}
  801d00:	c9                   	leave  
  801d01:	c3                   	ret    

00801d02 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d02:	55                   	push   %ebp
  801d03:	89 e5                	mov    %esp,%ebp
  801d05:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 2c                	push   $0x2c
  801d14:	e8 ad fa ff ff       	call   8017c6 <syscall>
  801d19:	83 c4 18             	add    $0x18,%esp
  801d1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d1f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d23:	75 07                	jne    801d2c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d25:	b8 01 00 00 00       	mov    $0x1,%eax
  801d2a:	eb 05                	jmp    801d31 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d31:	c9                   	leave  
  801d32:	c3                   	ret    

00801d33 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
  801d36:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 2c                	push   $0x2c
  801d45:	e8 7c fa ff ff       	call   8017c6 <syscall>
  801d4a:	83 c4 18             	add    $0x18,%esp
  801d4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d50:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d54:	75 07                	jne    801d5d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d56:	b8 01 00 00 00       	mov    $0x1,%eax
  801d5b:	eb 05                	jmp    801d62 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d62:	c9                   	leave  
  801d63:	c3                   	ret    

00801d64 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d64:	55                   	push   %ebp
  801d65:	89 e5                	mov    %esp,%ebp
  801d67:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 2c                	push   $0x2c
  801d76:	e8 4b fa ff ff       	call   8017c6 <syscall>
  801d7b:	83 c4 18             	add    $0x18,%esp
  801d7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d81:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d85:	75 07                	jne    801d8e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d87:	b8 01 00 00 00       	mov    $0x1,%eax
  801d8c:	eb 05                	jmp    801d93 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d8e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
  801d98:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 2c                	push   $0x2c
  801da7:	e8 1a fa ff ff       	call   8017c6 <syscall>
  801dac:	83 c4 18             	add    $0x18,%esp
  801daf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801db2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801db6:	75 07                	jne    801dbf <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801db8:	b8 01 00 00 00       	mov    $0x1,%eax
  801dbd:	eb 05                	jmp    801dc4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801dbf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dc4:	c9                   	leave  
  801dc5:	c3                   	ret    

00801dc6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801dc6:	55                   	push   %ebp
  801dc7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	ff 75 08             	pushl  0x8(%ebp)
  801dd4:	6a 2d                	push   $0x2d
  801dd6:	e8 eb f9 ff ff       	call   8017c6 <syscall>
  801ddb:	83 c4 18             	add    $0x18,%esp
	return ;
  801dde:	90                   	nop
}
  801ddf:	c9                   	leave  
  801de0:	c3                   	ret    

00801de1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801de1:	55                   	push   %ebp
  801de2:	89 e5                	mov    %esp,%ebp
  801de4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801de5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801de8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801deb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dee:	8b 45 08             	mov    0x8(%ebp),%eax
  801df1:	6a 00                	push   $0x0
  801df3:	53                   	push   %ebx
  801df4:	51                   	push   %ecx
  801df5:	52                   	push   %edx
  801df6:	50                   	push   %eax
  801df7:	6a 2e                	push   $0x2e
  801df9:	e8 c8 f9 ff ff       	call   8017c6 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e04:	c9                   	leave  
  801e05:	c3                   	ret    

00801e06 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e06:	55                   	push   %ebp
  801e07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e09:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	52                   	push   %edx
  801e16:	50                   	push   %eax
  801e17:	6a 2f                	push   $0x2f
  801e19:	e8 a8 f9 ff ff       	call   8017c6 <syscall>
  801e1e:	83 c4 18             	add    $0x18,%esp
}
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    
  801e23:	90                   	nop

00801e24 <__udivdi3>:
  801e24:	55                   	push   %ebp
  801e25:	57                   	push   %edi
  801e26:	56                   	push   %esi
  801e27:	53                   	push   %ebx
  801e28:	83 ec 1c             	sub    $0x1c,%esp
  801e2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e3b:	89 ca                	mov    %ecx,%edx
  801e3d:	89 f8                	mov    %edi,%eax
  801e3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e43:	85 f6                	test   %esi,%esi
  801e45:	75 2d                	jne    801e74 <__udivdi3+0x50>
  801e47:	39 cf                	cmp    %ecx,%edi
  801e49:	77 65                	ja     801eb0 <__udivdi3+0x8c>
  801e4b:	89 fd                	mov    %edi,%ebp
  801e4d:	85 ff                	test   %edi,%edi
  801e4f:	75 0b                	jne    801e5c <__udivdi3+0x38>
  801e51:	b8 01 00 00 00       	mov    $0x1,%eax
  801e56:	31 d2                	xor    %edx,%edx
  801e58:	f7 f7                	div    %edi
  801e5a:	89 c5                	mov    %eax,%ebp
  801e5c:	31 d2                	xor    %edx,%edx
  801e5e:	89 c8                	mov    %ecx,%eax
  801e60:	f7 f5                	div    %ebp
  801e62:	89 c1                	mov    %eax,%ecx
  801e64:	89 d8                	mov    %ebx,%eax
  801e66:	f7 f5                	div    %ebp
  801e68:	89 cf                	mov    %ecx,%edi
  801e6a:	89 fa                	mov    %edi,%edx
  801e6c:	83 c4 1c             	add    $0x1c,%esp
  801e6f:	5b                   	pop    %ebx
  801e70:	5e                   	pop    %esi
  801e71:	5f                   	pop    %edi
  801e72:	5d                   	pop    %ebp
  801e73:	c3                   	ret    
  801e74:	39 ce                	cmp    %ecx,%esi
  801e76:	77 28                	ja     801ea0 <__udivdi3+0x7c>
  801e78:	0f bd fe             	bsr    %esi,%edi
  801e7b:	83 f7 1f             	xor    $0x1f,%edi
  801e7e:	75 40                	jne    801ec0 <__udivdi3+0x9c>
  801e80:	39 ce                	cmp    %ecx,%esi
  801e82:	72 0a                	jb     801e8e <__udivdi3+0x6a>
  801e84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e88:	0f 87 9e 00 00 00    	ja     801f2c <__udivdi3+0x108>
  801e8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e93:	89 fa                	mov    %edi,%edx
  801e95:	83 c4 1c             	add    $0x1c,%esp
  801e98:	5b                   	pop    %ebx
  801e99:	5e                   	pop    %esi
  801e9a:	5f                   	pop    %edi
  801e9b:	5d                   	pop    %ebp
  801e9c:	c3                   	ret    
  801e9d:	8d 76 00             	lea    0x0(%esi),%esi
  801ea0:	31 ff                	xor    %edi,%edi
  801ea2:	31 c0                	xor    %eax,%eax
  801ea4:	89 fa                	mov    %edi,%edx
  801ea6:	83 c4 1c             	add    $0x1c,%esp
  801ea9:	5b                   	pop    %ebx
  801eaa:	5e                   	pop    %esi
  801eab:	5f                   	pop    %edi
  801eac:	5d                   	pop    %ebp
  801ead:	c3                   	ret    
  801eae:	66 90                	xchg   %ax,%ax
  801eb0:	89 d8                	mov    %ebx,%eax
  801eb2:	f7 f7                	div    %edi
  801eb4:	31 ff                	xor    %edi,%edi
  801eb6:	89 fa                	mov    %edi,%edx
  801eb8:	83 c4 1c             	add    $0x1c,%esp
  801ebb:	5b                   	pop    %ebx
  801ebc:	5e                   	pop    %esi
  801ebd:	5f                   	pop    %edi
  801ebe:	5d                   	pop    %ebp
  801ebf:	c3                   	ret    
  801ec0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ec5:	89 eb                	mov    %ebp,%ebx
  801ec7:	29 fb                	sub    %edi,%ebx
  801ec9:	89 f9                	mov    %edi,%ecx
  801ecb:	d3 e6                	shl    %cl,%esi
  801ecd:	89 c5                	mov    %eax,%ebp
  801ecf:	88 d9                	mov    %bl,%cl
  801ed1:	d3 ed                	shr    %cl,%ebp
  801ed3:	89 e9                	mov    %ebp,%ecx
  801ed5:	09 f1                	or     %esi,%ecx
  801ed7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801edb:	89 f9                	mov    %edi,%ecx
  801edd:	d3 e0                	shl    %cl,%eax
  801edf:	89 c5                	mov    %eax,%ebp
  801ee1:	89 d6                	mov    %edx,%esi
  801ee3:	88 d9                	mov    %bl,%cl
  801ee5:	d3 ee                	shr    %cl,%esi
  801ee7:	89 f9                	mov    %edi,%ecx
  801ee9:	d3 e2                	shl    %cl,%edx
  801eeb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eef:	88 d9                	mov    %bl,%cl
  801ef1:	d3 e8                	shr    %cl,%eax
  801ef3:	09 c2                	or     %eax,%edx
  801ef5:	89 d0                	mov    %edx,%eax
  801ef7:	89 f2                	mov    %esi,%edx
  801ef9:	f7 74 24 0c          	divl   0xc(%esp)
  801efd:	89 d6                	mov    %edx,%esi
  801eff:	89 c3                	mov    %eax,%ebx
  801f01:	f7 e5                	mul    %ebp
  801f03:	39 d6                	cmp    %edx,%esi
  801f05:	72 19                	jb     801f20 <__udivdi3+0xfc>
  801f07:	74 0b                	je     801f14 <__udivdi3+0xf0>
  801f09:	89 d8                	mov    %ebx,%eax
  801f0b:	31 ff                	xor    %edi,%edi
  801f0d:	e9 58 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f12:	66 90                	xchg   %ax,%ax
  801f14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f18:	89 f9                	mov    %edi,%ecx
  801f1a:	d3 e2                	shl    %cl,%edx
  801f1c:	39 c2                	cmp    %eax,%edx
  801f1e:	73 e9                	jae    801f09 <__udivdi3+0xe5>
  801f20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f23:	31 ff                	xor    %edi,%edi
  801f25:	e9 40 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f2a:	66 90                	xchg   %ax,%ax
  801f2c:	31 c0                	xor    %eax,%eax
  801f2e:	e9 37 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f33:	90                   	nop

00801f34 <__umoddi3>:
  801f34:	55                   	push   %ebp
  801f35:	57                   	push   %edi
  801f36:	56                   	push   %esi
  801f37:	53                   	push   %ebx
  801f38:	83 ec 1c             	sub    $0x1c,%esp
  801f3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f53:	89 f3                	mov    %esi,%ebx
  801f55:	89 fa                	mov    %edi,%edx
  801f57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f5b:	89 34 24             	mov    %esi,(%esp)
  801f5e:	85 c0                	test   %eax,%eax
  801f60:	75 1a                	jne    801f7c <__umoddi3+0x48>
  801f62:	39 f7                	cmp    %esi,%edi
  801f64:	0f 86 a2 00 00 00    	jbe    80200c <__umoddi3+0xd8>
  801f6a:	89 c8                	mov    %ecx,%eax
  801f6c:	89 f2                	mov    %esi,%edx
  801f6e:	f7 f7                	div    %edi
  801f70:	89 d0                	mov    %edx,%eax
  801f72:	31 d2                	xor    %edx,%edx
  801f74:	83 c4 1c             	add    $0x1c,%esp
  801f77:	5b                   	pop    %ebx
  801f78:	5e                   	pop    %esi
  801f79:	5f                   	pop    %edi
  801f7a:	5d                   	pop    %ebp
  801f7b:	c3                   	ret    
  801f7c:	39 f0                	cmp    %esi,%eax
  801f7e:	0f 87 ac 00 00 00    	ja     802030 <__umoddi3+0xfc>
  801f84:	0f bd e8             	bsr    %eax,%ebp
  801f87:	83 f5 1f             	xor    $0x1f,%ebp
  801f8a:	0f 84 ac 00 00 00    	je     80203c <__umoddi3+0x108>
  801f90:	bf 20 00 00 00       	mov    $0x20,%edi
  801f95:	29 ef                	sub    %ebp,%edi
  801f97:	89 fe                	mov    %edi,%esi
  801f99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f9d:	89 e9                	mov    %ebp,%ecx
  801f9f:	d3 e0                	shl    %cl,%eax
  801fa1:	89 d7                	mov    %edx,%edi
  801fa3:	89 f1                	mov    %esi,%ecx
  801fa5:	d3 ef                	shr    %cl,%edi
  801fa7:	09 c7                	or     %eax,%edi
  801fa9:	89 e9                	mov    %ebp,%ecx
  801fab:	d3 e2                	shl    %cl,%edx
  801fad:	89 14 24             	mov    %edx,(%esp)
  801fb0:	89 d8                	mov    %ebx,%eax
  801fb2:	d3 e0                	shl    %cl,%eax
  801fb4:	89 c2                	mov    %eax,%edx
  801fb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fba:	d3 e0                	shl    %cl,%eax
  801fbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fc0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fc4:	89 f1                	mov    %esi,%ecx
  801fc6:	d3 e8                	shr    %cl,%eax
  801fc8:	09 d0                	or     %edx,%eax
  801fca:	d3 eb                	shr    %cl,%ebx
  801fcc:	89 da                	mov    %ebx,%edx
  801fce:	f7 f7                	div    %edi
  801fd0:	89 d3                	mov    %edx,%ebx
  801fd2:	f7 24 24             	mull   (%esp)
  801fd5:	89 c6                	mov    %eax,%esi
  801fd7:	89 d1                	mov    %edx,%ecx
  801fd9:	39 d3                	cmp    %edx,%ebx
  801fdb:	0f 82 87 00 00 00    	jb     802068 <__umoddi3+0x134>
  801fe1:	0f 84 91 00 00 00    	je     802078 <__umoddi3+0x144>
  801fe7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801feb:	29 f2                	sub    %esi,%edx
  801fed:	19 cb                	sbb    %ecx,%ebx
  801fef:	89 d8                	mov    %ebx,%eax
  801ff1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ff5:	d3 e0                	shl    %cl,%eax
  801ff7:	89 e9                	mov    %ebp,%ecx
  801ff9:	d3 ea                	shr    %cl,%edx
  801ffb:	09 d0                	or     %edx,%eax
  801ffd:	89 e9                	mov    %ebp,%ecx
  801fff:	d3 eb                	shr    %cl,%ebx
  802001:	89 da                	mov    %ebx,%edx
  802003:	83 c4 1c             	add    $0x1c,%esp
  802006:	5b                   	pop    %ebx
  802007:	5e                   	pop    %esi
  802008:	5f                   	pop    %edi
  802009:	5d                   	pop    %ebp
  80200a:	c3                   	ret    
  80200b:	90                   	nop
  80200c:	89 fd                	mov    %edi,%ebp
  80200e:	85 ff                	test   %edi,%edi
  802010:	75 0b                	jne    80201d <__umoddi3+0xe9>
  802012:	b8 01 00 00 00       	mov    $0x1,%eax
  802017:	31 d2                	xor    %edx,%edx
  802019:	f7 f7                	div    %edi
  80201b:	89 c5                	mov    %eax,%ebp
  80201d:	89 f0                	mov    %esi,%eax
  80201f:	31 d2                	xor    %edx,%edx
  802021:	f7 f5                	div    %ebp
  802023:	89 c8                	mov    %ecx,%eax
  802025:	f7 f5                	div    %ebp
  802027:	89 d0                	mov    %edx,%eax
  802029:	e9 44 ff ff ff       	jmp    801f72 <__umoddi3+0x3e>
  80202e:	66 90                	xchg   %ax,%ax
  802030:	89 c8                	mov    %ecx,%eax
  802032:	89 f2                	mov    %esi,%edx
  802034:	83 c4 1c             	add    $0x1c,%esp
  802037:	5b                   	pop    %ebx
  802038:	5e                   	pop    %esi
  802039:	5f                   	pop    %edi
  80203a:	5d                   	pop    %ebp
  80203b:	c3                   	ret    
  80203c:	3b 04 24             	cmp    (%esp),%eax
  80203f:	72 06                	jb     802047 <__umoddi3+0x113>
  802041:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802045:	77 0f                	ja     802056 <__umoddi3+0x122>
  802047:	89 f2                	mov    %esi,%edx
  802049:	29 f9                	sub    %edi,%ecx
  80204b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80204f:	89 14 24             	mov    %edx,(%esp)
  802052:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802056:	8b 44 24 04          	mov    0x4(%esp),%eax
  80205a:	8b 14 24             	mov    (%esp),%edx
  80205d:	83 c4 1c             	add    $0x1c,%esp
  802060:	5b                   	pop    %ebx
  802061:	5e                   	pop    %esi
  802062:	5f                   	pop    %edi
  802063:	5d                   	pop    %ebp
  802064:	c3                   	ret    
  802065:	8d 76 00             	lea    0x0(%esi),%esi
  802068:	2b 04 24             	sub    (%esp),%eax
  80206b:	19 fa                	sbb    %edi,%edx
  80206d:	89 d1                	mov    %edx,%ecx
  80206f:	89 c6                	mov    %eax,%esi
  802071:	e9 71 ff ff ff       	jmp    801fe7 <__umoddi3+0xb3>
  802076:	66 90                	xchg   %ax,%ax
  802078:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80207c:	72 ea                	jb     802068 <__umoddi3+0x134>
  80207e:	89 d9                	mov    %ebx,%ecx
  802080:	e9 62 ff ff ff       	jmp    801fe7 <__umoddi3+0xb3>
