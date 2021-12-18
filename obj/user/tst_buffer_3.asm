
obj/user/tst_buffer_3:     file format elf32-i386


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
  800031:	e8 72 02 00 00       	call   8002a8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
//		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}
	int kilo = 1024;
  80003f:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	int Mega = 1024*1024;
  800046:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)

	{
		int freeFrames = sys_calculate_free_frames() ;
  80004d:	e8 1a 18 00 00       	call   80186c <sys_calculate_free_frames>
  800052:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int origFreeFrames = freeFrames ;
  800055:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800058:	89 45 e0             	mov    %eax,-0x20(%ebp)

		uint32 size = 10*Mega;
  80005b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80005e:	89 d0                	mov    %edx,%eax
  800060:	c1 e0 02             	shl    $0x2,%eax
  800063:	01 d0                	add    %edx,%eax
  800065:	01 c0                	add    %eax,%eax
  800067:	89 45 dc             	mov    %eax,-0x24(%ebp)
		unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  80006a:	83 ec 0c             	sub    $0xc,%esp
  80006d:	ff 75 dc             	pushl  -0x24(%ebp)
  800070:	e8 a4 13 00 00       	call   801419 <malloc>
  800075:	83 c4 10             	add    $0x10,%esp
  800078:	89 45 d8             	mov    %eax,-0x28(%ebp)
		freeFrames = sys_calculate_free_frames() ;
  80007b:	e8 ec 17 00 00       	call   80186c <sys_calculate_free_frames>
  800080:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int modFrames = sys_calculate_modified_frames();
  800083:	e8 fd 17 00 00       	call   801885 <sys_calculate_modified_frames>
  800088:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		cprintf("all frames AFTER malloc = %d\n", freeFrames + modFrames);
  80008b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80008e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800091:	01 d0                	add    %edx,%eax
  800093:	83 ec 08             	sub    $0x8,%esp
  800096:	50                   	push   %eax
  800097:	68 e0 1f 80 00       	push   $0x801fe0
  80009c:	e8 ee 05 00 00       	call   80068f <cprintf>
  8000a1:	83 c4 10             	add    $0x10,%esp
		x[1]=-1;
  8000a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000a7:	40                   	inc    %eax
  8000a8:	c6 00 ff             	movb   $0xff,(%eax)

		x[1*Mega] = -1;
  8000ab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8000ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000b1:	01 d0                	add    %edx,%eax
  8000b3:	c6 00 ff             	movb   $0xff,(%eax)

		int i = x[2*Mega];
  8000b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b9:	01 c0                	add    %eax,%eax
  8000bb:	89 c2                	mov    %eax,%edx
  8000bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c0:	01 d0                	add    %edx,%eax
  8000c2:	8a 00                	mov    (%eax),%al
  8000c4:	0f b6 c0             	movzbl %al,%eax
  8000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)

		int j = x[3*Mega];
  8000ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000cd:	89 c2                	mov    %eax,%edx
  8000cf:	01 d2                	add    %edx,%edx
  8000d1:	01 d0                	add    %edx,%eax
  8000d3:	89 c2                	mov    %eax,%edx
  8000d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000d8:	01 d0                	add    %edx,%eax
  8000da:	8a 00                	mov    (%eax),%al
  8000dc:	0f b6 c0             	movzbl %al,%eax
  8000df:	89 45 d0             	mov    %eax,-0x30(%ebp)

		x[4*Mega] = -1;
  8000e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e5:	c1 e0 02             	shl    $0x2,%eax
  8000e8:	89 c2                	mov    %eax,%edx
  8000ea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000ed:	01 d0                	add    %edx,%eax
  8000ef:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega] = -1;
  8000f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8000f5:	89 d0                	mov    %edx,%eax
  8000f7:	c1 e0 02             	shl    $0x2,%eax
  8000fa:	01 d0                	add    %edx,%eax
  8000fc:	89 c2                	mov    %eax,%edx
  8000fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	c6 00 ff             	movb   $0xff,(%eax)

		x[6*Mega] = -1;
  800106:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800109:	89 d0                	mov    %edx,%eax
  80010b:	01 c0                	add    %eax,%eax
  80010d:	01 d0                	add    %edx,%eax
  80010f:	01 c0                	add    %eax,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 ff             	movb   $0xff,(%eax)

		x[7*Mega] = -1;
  80011b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80011e:	89 d0                	mov    %edx,%eax
  800120:	01 c0                	add    %eax,%eax
  800122:	01 d0                	add    %edx,%eax
  800124:	01 c0                	add    %eax,%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	89 c2                	mov    %eax,%edx
  80012a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80012d:	01 d0                	add    %edx,%eax
  80012f:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  800132:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800135:	c1 e0 03             	shl    $0x3,%eax
  800138:	89 c2                	mov    %eax,%edx
  80013a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80013d:	01 d0                	add    %edx,%eax
  80013f:	c6 00 ff             	movb   $0xff,(%eax)

		x[9*Mega] = -1;
  800142:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800145:	89 d0                	mov    %edx,%eax
  800147:	c1 e0 03             	shl    $0x3,%eax
  80014a:	01 d0                	add    %edx,%eax
  80014c:	89 c2                	mov    %eax,%edx
  80014e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800151:	01 d0                	add    %edx,%eax
  800153:	c6 00 ff             	movb   $0xff,(%eax)

		free(x);
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	ff 75 d8             	pushl  -0x28(%ebp)
  80015c:	e8 c8 14 00 00       	call   801629 <free>
  800161:	83 c4 10             	add    $0x10,%esp

		int numOFEmptyLocInWS = 0;
  800164:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80016b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800172:	eb 6d                	jmp    8001e1 <_main+0x1a9>
		{
			if (myEnv->__uptr_pws[i].empty)
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80017f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800182:	c1 e2 04             	shl    $0x4,%edx
  800185:	01 d0                	add    %edx,%eax
  800187:	8a 40 04             	mov    0x4(%eax),%al
  80018a:	84 c0                	test   %al,%al
  80018c:	74 05                	je     800193 <_main+0x15b>
			{
				numOFEmptyLocInWS++;
  80018e:	ff 45 f0             	incl   -0x10(%ebp)
  800191:	eb 4b                	jmp    8001de <_main+0x1a6>
			}
			else
			{
				uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  800193:	a1 20 30 80 00       	mov    0x803020,%eax
  800198:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80019e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001a1:	c1 e2 04             	shl    $0x4,%edx
  8001a4:	01 d0                	add    %edx,%eax
  8001a6:	8b 00                	mov    (%eax),%eax
  8001a8:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001ab:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001b3:	89 45 c8             	mov    %eax,-0x38(%ebp)
				if (va >= USER_HEAP_START && va < (USER_HEAP_START + size))
  8001b6:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001b9:	85 c0                	test   %eax,%eax
  8001bb:	79 21                	jns    8001de <_main+0x1a6>
  8001bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001c0:	05 00 00 00 80       	add    $0x80000000,%eax
  8001c5:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8001c8:	76 14                	jbe    8001de <_main+0x1a6>
					panic("freeMem didn't remove its page(s) from the WS");
  8001ca:	83 ec 04             	sub    $0x4,%esp
  8001cd:	68 00 20 80 00       	push   $0x802000
  8001d2:	6a 4e                	push   $0x4e
  8001d4:	68 2e 20 80 00       	push   $0x80202e
  8001d9:	e8 0f 02 00 00       	call   8003ed <_panic>
		x[9*Mega] = -1;

		free(x);

		int numOFEmptyLocInWS = 0;
		for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  8001de:	ff 45 f4             	incl   -0xc(%ebp)
  8001e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e6:	8b 50 74             	mov    0x74(%eax),%edx
  8001e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001ec:	39 c2                	cmp    %eax,%edx
  8001ee:	77 84                	ja     800174 <_main+0x13c>
				uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
				if (va >= USER_HEAP_START && va < (USER_HEAP_START + size))
					panic("freeMem didn't remove its page(s) from the WS");
			}
		}
		int free_frames = sys_calculate_free_frames();
  8001f0:	e8 77 16 00 00       	call   80186c <sys_calculate_free_frames>
  8001f5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int mod_frames = sys_calculate_modified_frames();
  8001f8:	e8 88 16 00 00       	call   801885 <sys_calculate_modified_frames>
  8001fd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((sys_calculate_modified_frames() + sys_calculate_free_frames() - numOFEmptyLocInWS) - (modFrames + freeFrames) != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
  800200:	e8 80 16 00 00       	call   801885 <sys_calculate_modified_frames>
  800205:	89 c3                	mov    %eax,%ebx
  800207:	e8 60 16 00 00       	call   80186c <sys_calculate_free_frames>
  80020c:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80020f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800212:	89 d1                	mov    %edx,%ecx
  800214:	29 c1                	sub    %eax,%ecx
  800216:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800219:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80021c:	01 d0                	add    %edx,%eax
  80021e:	39 c1                	cmp    %eax,%ecx
  800220:	74 14                	je     800236 <_main+0x1fe>
  800222:	83 ec 04             	sub    $0x4,%esp
  800225:	68 44 20 80 00       	push   $0x802044
  80022a:	6a 53                	push   $0x53
  80022c:	68 2e 20 80 00       	push   $0x80202e
  800231:	e8 b7 01 00 00       	call   8003ed <_panic>
		//if (sys_calculate_modified_frames() != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
		//if (sys_calculate_notmod_frames() != 7) panic("FreeMem didn't remove all un-modified frames in the given range from the free frame list");

		//if (sys_calculate_free_frames() - freeFrames != 3) panic("FreeMem didn't UN-BUFFER the removed BUFFERED frames in the given range.. (check updating of isBuffered");

		cprintf("Congratulations!! test of removing BUFFERED pages in freeHeap is completed successfully.\n");
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	68 98 20 80 00       	push   $0x802098
  80023e:	e8 4c 04 00 00       	call   80068f <cprintf>
  800243:	83 c4 10             	add    $0x10,%esp

		//Try to access any of the removed buffered pages in the Heap [It's ILLEGAL ACCESS now]
		{
			cprintf("\nNow, trying to access the removed BUFFERED pages, you should make the kernel PANIC with ILLEGAL MEMORY ACCESS in page_fault_handler() since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK.\n\n\n");
  800246:	83 ec 0c             	sub    $0xc,%esp
  800249:	68 f4 20 80 00       	push   $0x8020f4
  80024e:	e8 3c 04 00 00       	call   80068f <cprintf>
  800253:	83 c4 10             	add    $0x10,%esp

			x[1]=-1;
  800256:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800259:	40                   	inc    %eax
  80025a:	c6 00 ff             	movb   $0xff,(%eax)

			x[1*Mega] = -1;
  80025d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800260:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800263:	01 d0                	add    %edx,%eax
  800265:	c6 00 ff             	movb   $0xff,(%eax)

			int i = x[2*Mega];
  800268:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80026b:	01 c0                	add    %eax,%eax
  80026d:	89 c2                	mov    %eax,%edx
  80026f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800272:	01 d0                	add    %edx,%eax
  800274:	8a 00                	mov    (%eax),%al
  800276:	0f b6 c0             	movzbl %al,%eax
  800279:	89 45 bc             	mov    %eax,-0x44(%ebp)

			int j = x[3*Mega];
  80027c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80027f:	89 c2                	mov    %eax,%edx
  800281:	01 d2                	add    %edx,%edx
  800283:	01 d0                	add    %edx,%eax
  800285:	89 c2                	mov    %eax,%edx
  800287:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80028a:	01 d0                	add    %edx,%eax
  80028c:	8a 00                	mov    (%eax),%al
  80028e:	0f b6 c0             	movzbl %al,%eax
  800291:	89 45 b8             	mov    %eax,-0x48(%ebp)
		}
		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for stack pages\n");
  800294:	83 ec 04             	sub    $0x4,%esp
  800297:	68 d8 21 80 00       	push   $0x8021d8
  80029c:	6a 68                	push   $0x68
  80029e:	68 2e 20 80 00       	push   $0x80202e
  8002a3:	e8 45 01 00 00       	call   8003ed <_panic>

008002a8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002a8:	55                   	push   %ebp
  8002a9:	89 e5                	mov    %esp,%ebp
  8002ab:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002ae:	e8 ee 14 00 00       	call   8017a1 <sys_getenvindex>
  8002b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002b9:	89 d0                	mov    %edx,%eax
  8002bb:	c1 e0 03             	shl    $0x3,%eax
  8002be:	01 d0                	add    %edx,%eax
  8002c0:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8002c7:	01 c8                	add    %ecx,%eax
  8002c9:	01 c0                	add    %eax,%eax
  8002cb:	01 d0                	add    %edx,%eax
  8002cd:	01 c0                	add    %eax,%eax
  8002cf:	01 d0                	add    %edx,%eax
  8002d1:	89 c2                	mov    %eax,%edx
  8002d3:	c1 e2 05             	shl    $0x5,%edx
  8002d6:	29 c2                	sub    %eax,%edx
  8002d8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8002df:	89 c2                	mov    %eax,%edx
  8002e1:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8002e7:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f1:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8002f7:	84 c0                	test   %al,%al
  8002f9:	74 0f                	je     80030a <libmain+0x62>
		binaryname = myEnv->prog_name;
  8002fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800300:	05 40 3c 01 00       	add    $0x13c40,%eax
  800305:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80030a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80030e:	7e 0a                	jle    80031a <libmain+0x72>
		binaryname = argv[0];
  800310:	8b 45 0c             	mov    0xc(%ebp),%eax
  800313:	8b 00                	mov    (%eax),%eax
  800315:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80031a:	83 ec 08             	sub    $0x8,%esp
  80031d:	ff 75 0c             	pushl  0xc(%ebp)
  800320:	ff 75 08             	pushl  0x8(%ebp)
  800323:	e8 10 fd ff ff       	call   800038 <_main>
  800328:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80032b:	e8 0c 16 00 00       	call   80193c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800330:	83 ec 0c             	sub    $0xc,%esp
  800333:	68 f8 22 80 00       	push   $0x8022f8
  800338:	e8 52 03 00 00       	call   80068f <cprintf>
  80033d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800340:	a1 20 30 80 00       	mov    0x803020,%eax
  800345:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80034b:	a1 20 30 80 00       	mov    0x803020,%eax
  800350:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800356:	83 ec 04             	sub    $0x4,%esp
  800359:	52                   	push   %edx
  80035a:	50                   	push   %eax
  80035b:	68 20 23 80 00       	push   $0x802320
  800360:	e8 2a 03 00 00       	call   80068f <cprintf>
  800365:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800368:	a1 20 30 80 00       	mov    0x803020,%eax
  80036d:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800373:	a1 20 30 80 00       	mov    0x803020,%eax
  800378:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80037e:	83 ec 04             	sub    $0x4,%esp
  800381:	52                   	push   %edx
  800382:	50                   	push   %eax
  800383:	68 48 23 80 00       	push   $0x802348
  800388:	e8 02 03 00 00       	call   80068f <cprintf>
  80038d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800390:	a1 20 30 80 00       	mov    0x803020,%eax
  800395:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80039b:	83 ec 08             	sub    $0x8,%esp
  80039e:	50                   	push   %eax
  80039f:	68 89 23 80 00       	push   $0x802389
  8003a4:	e8 e6 02 00 00       	call   80068f <cprintf>
  8003a9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003ac:	83 ec 0c             	sub    $0xc,%esp
  8003af:	68 f8 22 80 00       	push   $0x8022f8
  8003b4:	e8 d6 02 00 00       	call   80068f <cprintf>
  8003b9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003bc:	e8 95 15 00 00       	call   801956 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003c1:	e8 19 00 00 00       	call   8003df <exit>
}
  8003c6:	90                   	nop
  8003c7:	c9                   	leave  
  8003c8:	c3                   	ret    

008003c9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003c9:	55                   	push   %ebp
  8003ca:	89 e5                	mov    %esp,%ebp
  8003cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003cf:	83 ec 0c             	sub    $0xc,%esp
  8003d2:	6a 00                	push   $0x0
  8003d4:	e8 94 13 00 00       	call   80176d <sys_env_destroy>
  8003d9:	83 c4 10             	add    $0x10,%esp
}
  8003dc:	90                   	nop
  8003dd:	c9                   	leave  
  8003de:	c3                   	ret    

008003df <exit>:

void
exit(void)
{
  8003df:	55                   	push   %ebp
  8003e0:	89 e5                	mov    %esp,%ebp
  8003e2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003e5:	e8 e9 13 00 00       	call   8017d3 <sys_env_exit>
}
  8003ea:	90                   	nop
  8003eb:	c9                   	leave  
  8003ec:	c3                   	ret    

008003ed <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003ed:	55                   	push   %ebp
  8003ee:	89 e5                	mov    %esp,%ebp
  8003f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003f3:	8d 45 10             	lea    0x10(%ebp),%eax
  8003f6:	83 c0 04             	add    $0x4,%eax
  8003f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003fc:	a1 18 31 80 00       	mov    0x803118,%eax
  800401:	85 c0                	test   %eax,%eax
  800403:	74 16                	je     80041b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800405:	a1 18 31 80 00       	mov    0x803118,%eax
  80040a:	83 ec 08             	sub    $0x8,%esp
  80040d:	50                   	push   %eax
  80040e:	68 a0 23 80 00       	push   $0x8023a0
  800413:	e8 77 02 00 00       	call   80068f <cprintf>
  800418:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80041b:	a1 00 30 80 00       	mov    0x803000,%eax
  800420:	ff 75 0c             	pushl  0xc(%ebp)
  800423:	ff 75 08             	pushl  0x8(%ebp)
  800426:	50                   	push   %eax
  800427:	68 a5 23 80 00       	push   $0x8023a5
  80042c:	e8 5e 02 00 00       	call   80068f <cprintf>
  800431:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800434:	8b 45 10             	mov    0x10(%ebp),%eax
  800437:	83 ec 08             	sub    $0x8,%esp
  80043a:	ff 75 f4             	pushl  -0xc(%ebp)
  80043d:	50                   	push   %eax
  80043e:	e8 e1 01 00 00       	call   800624 <vcprintf>
  800443:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800446:	83 ec 08             	sub    $0x8,%esp
  800449:	6a 00                	push   $0x0
  80044b:	68 c1 23 80 00       	push   $0x8023c1
  800450:	e8 cf 01 00 00       	call   800624 <vcprintf>
  800455:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800458:	e8 82 ff ff ff       	call   8003df <exit>

	// should not return here
	while (1) ;
  80045d:	eb fe                	jmp    80045d <_panic+0x70>

0080045f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80045f:	55                   	push   %ebp
  800460:	89 e5                	mov    %esp,%ebp
  800462:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800465:	a1 20 30 80 00       	mov    0x803020,%eax
  80046a:	8b 50 74             	mov    0x74(%eax),%edx
  80046d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800470:	39 c2                	cmp    %eax,%edx
  800472:	74 14                	je     800488 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	68 c4 23 80 00       	push   $0x8023c4
  80047c:	6a 26                	push   $0x26
  80047e:	68 10 24 80 00       	push   $0x802410
  800483:	e8 65 ff ff ff       	call   8003ed <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800488:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80048f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800496:	e9 b6 00 00 00       	jmp    800551 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80049b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80049e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a8:	01 d0                	add    %edx,%eax
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	85 c0                	test   %eax,%eax
  8004ae:	75 08                	jne    8004b8 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004b0:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004b3:	e9 96 00 00 00       	jmp    80054e <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8004b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004c6:	eb 5d                	jmp    800525 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004d3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004d6:	c1 e2 04             	shl    $0x4,%edx
  8004d9:	01 d0                	add    %edx,%eax
  8004db:	8a 40 04             	mov    0x4(%eax),%al
  8004de:	84 c0                	test   %al,%al
  8004e0:	75 40                	jne    800522 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004ed:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004f0:	c1 e2 04             	shl    $0x4,%edx
  8004f3:	01 d0                	add    %edx,%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800502:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800504:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800507:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80050e:	8b 45 08             	mov    0x8(%ebp),%eax
  800511:	01 c8                	add    %ecx,%eax
  800513:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800515:	39 c2                	cmp    %eax,%edx
  800517:	75 09                	jne    800522 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800519:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800520:	eb 12                	jmp    800534 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800522:	ff 45 e8             	incl   -0x18(%ebp)
  800525:	a1 20 30 80 00       	mov    0x803020,%eax
  80052a:	8b 50 74             	mov    0x74(%eax),%edx
  80052d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800530:	39 c2                	cmp    %eax,%edx
  800532:	77 94                	ja     8004c8 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800534:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800538:	75 14                	jne    80054e <CheckWSWithoutLastIndex+0xef>
			panic(
  80053a:	83 ec 04             	sub    $0x4,%esp
  80053d:	68 1c 24 80 00       	push   $0x80241c
  800542:	6a 3a                	push   $0x3a
  800544:	68 10 24 80 00       	push   $0x802410
  800549:	e8 9f fe ff ff       	call   8003ed <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80054e:	ff 45 f0             	incl   -0x10(%ebp)
  800551:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800554:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800557:	0f 8c 3e ff ff ff    	jl     80049b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80055d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800564:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80056b:	eb 20                	jmp    80058d <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80056d:	a1 20 30 80 00       	mov    0x803020,%eax
  800572:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800578:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80057b:	c1 e2 04             	shl    $0x4,%edx
  80057e:	01 d0                	add    %edx,%eax
  800580:	8a 40 04             	mov    0x4(%eax),%al
  800583:	3c 01                	cmp    $0x1,%al
  800585:	75 03                	jne    80058a <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800587:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80058a:	ff 45 e0             	incl   -0x20(%ebp)
  80058d:	a1 20 30 80 00       	mov    0x803020,%eax
  800592:	8b 50 74             	mov    0x74(%eax),%edx
  800595:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800598:	39 c2                	cmp    %eax,%edx
  80059a:	77 d1                	ja     80056d <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80059c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005a2:	74 14                	je     8005b8 <CheckWSWithoutLastIndex+0x159>
		panic(
  8005a4:	83 ec 04             	sub    $0x4,%esp
  8005a7:	68 70 24 80 00       	push   $0x802470
  8005ac:	6a 44                	push   $0x44
  8005ae:	68 10 24 80 00       	push   $0x802410
  8005b3:	e8 35 fe ff ff       	call   8003ed <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005b8:	90                   	nop
  8005b9:	c9                   	leave  
  8005ba:	c3                   	ret    

008005bb <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005bb:	55                   	push   %ebp
  8005bc:	89 e5                	mov    %esp,%ebp
  8005be:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c4:	8b 00                	mov    (%eax),%eax
  8005c6:	8d 48 01             	lea    0x1(%eax),%ecx
  8005c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005cc:	89 0a                	mov    %ecx,(%edx)
  8005ce:	8b 55 08             	mov    0x8(%ebp),%edx
  8005d1:	88 d1                	mov    %dl,%cl
  8005d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005dd:	8b 00                	mov    (%eax),%eax
  8005df:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005e4:	75 2c                	jne    800612 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005e6:	a0 24 30 80 00       	mov    0x803024,%al
  8005eb:	0f b6 c0             	movzbl %al,%eax
  8005ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f1:	8b 12                	mov    (%edx),%edx
  8005f3:	89 d1                	mov    %edx,%ecx
  8005f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f8:	83 c2 08             	add    $0x8,%edx
  8005fb:	83 ec 04             	sub    $0x4,%esp
  8005fe:	50                   	push   %eax
  8005ff:	51                   	push   %ecx
  800600:	52                   	push   %edx
  800601:	e8 25 11 00 00       	call   80172b <sys_cputs>
  800606:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800609:	8b 45 0c             	mov    0xc(%ebp),%eax
  80060c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800612:	8b 45 0c             	mov    0xc(%ebp),%eax
  800615:	8b 40 04             	mov    0x4(%eax),%eax
  800618:	8d 50 01             	lea    0x1(%eax),%edx
  80061b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800621:	90                   	nop
  800622:	c9                   	leave  
  800623:	c3                   	ret    

00800624 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800624:	55                   	push   %ebp
  800625:	89 e5                	mov    %esp,%ebp
  800627:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80062d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800634:	00 00 00 
	b.cnt = 0;
  800637:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80063e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800641:	ff 75 0c             	pushl  0xc(%ebp)
  800644:	ff 75 08             	pushl  0x8(%ebp)
  800647:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80064d:	50                   	push   %eax
  80064e:	68 bb 05 80 00       	push   $0x8005bb
  800653:	e8 11 02 00 00       	call   800869 <vprintfmt>
  800658:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80065b:	a0 24 30 80 00       	mov    0x803024,%al
  800660:	0f b6 c0             	movzbl %al,%eax
  800663:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800669:	83 ec 04             	sub    $0x4,%esp
  80066c:	50                   	push   %eax
  80066d:	52                   	push   %edx
  80066e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800674:	83 c0 08             	add    $0x8,%eax
  800677:	50                   	push   %eax
  800678:	e8 ae 10 00 00       	call   80172b <sys_cputs>
  80067d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800680:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800687:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80068d:	c9                   	leave  
  80068e:	c3                   	ret    

0080068f <cprintf>:

int cprintf(const char *fmt, ...) {
  80068f:	55                   	push   %ebp
  800690:	89 e5                	mov    %esp,%ebp
  800692:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800695:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80069c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	83 ec 08             	sub    $0x8,%esp
  8006a8:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ab:	50                   	push   %eax
  8006ac:	e8 73 ff ff ff       	call   800624 <vcprintf>
  8006b1:	83 c4 10             	add    $0x10,%esp
  8006b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006ba:	c9                   	leave  
  8006bb:	c3                   	ret    

008006bc <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006bc:	55                   	push   %ebp
  8006bd:	89 e5                	mov    %esp,%ebp
  8006bf:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006c2:	e8 75 12 00 00       	call   80193c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006c7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d0:	83 ec 08             	sub    $0x8,%esp
  8006d3:	ff 75 f4             	pushl  -0xc(%ebp)
  8006d6:	50                   	push   %eax
  8006d7:	e8 48 ff ff ff       	call   800624 <vcprintf>
  8006dc:	83 c4 10             	add    $0x10,%esp
  8006df:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006e2:	e8 6f 12 00 00       	call   801956 <sys_enable_interrupt>
	return cnt;
  8006e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006ea:	c9                   	leave  
  8006eb:	c3                   	ret    

008006ec <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006ec:	55                   	push   %ebp
  8006ed:	89 e5                	mov    %esp,%ebp
  8006ef:	53                   	push   %ebx
  8006f0:	83 ec 14             	sub    $0x14,%esp
  8006f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006ff:	8b 45 18             	mov    0x18(%ebp),%eax
  800702:	ba 00 00 00 00       	mov    $0x0,%edx
  800707:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80070a:	77 55                	ja     800761 <printnum+0x75>
  80070c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80070f:	72 05                	jb     800716 <printnum+0x2a>
  800711:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800714:	77 4b                	ja     800761 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800716:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800719:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80071c:	8b 45 18             	mov    0x18(%ebp),%eax
  80071f:	ba 00 00 00 00       	mov    $0x0,%edx
  800724:	52                   	push   %edx
  800725:	50                   	push   %eax
  800726:	ff 75 f4             	pushl  -0xc(%ebp)
  800729:	ff 75 f0             	pushl  -0x10(%ebp)
  80072c:	e8 2f 16 00 00       	call   801d60 <__udivdi3>
  800731:	83 c4 10             	add    $0x10,%esp
  800734:	83 ec 04             	sub    $0x4,%esp
  800737:	ff 75 20             	pushl  0x20(%ebp)
  80073a:	53                   	push   %ebx
  80073b:	ff 75 18             	pushl  0x18(%ebp)
  80073e:	52                   	push   %edx
  80073f:	50                   	push   %eax
  800740:	ff 75 0c             	pushl  0xc(%ebp)
  800743:	ff 75 08             	pushl  0x8(%ebp)
  800746:	e8 a1 ff ff ff       	call   8006ec <printnum>
  80074b:	83 c4 20             	add    $0x20,%esp
  80074e:	eb 1a                	jmp    80076a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800750:	83 ec 08             	sub    $0x8,%esp
  800753:	ff 75 0c             	pushl  0xc(%ebp)
  800756:	ff 75 20             	pushl  0x20(%ebp)
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	ff d0                	call   *%eax
  80075e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800761:	ff 4d 1c             	decl   0x1c(%ebp)
  800764:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800768:	7f e6                	jg     800750 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80076a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80076d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800772:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800775:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800778:	53                   	push   %ebx
  800779:	51                   	push   %ecx
  80077a:	52                   	push   %edx
  80077b:	50                   	push   %eax
  80077c:	e8 ef 16 00 00       	call   801e70 <__umoddi3>
  800781:	83 c4 10             	add    $0x10,%esp
  800784:	05 d4 26 80 00       	add    $0x8026d4,%eax
  800789:	8a 00                	mov    (%eax),%al
  80078b:	0f be c0             	movsbl %al,%eax
  80078e:	83 ec 08             	sub    $0x8,%esp
  800791:	ff 75 0c             	pushl  0xc(%ebp)
  800794:	50                   	push   %eax
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	ff d0                	call   *%eax
  80079a:	83 c4 10             	add    $0x10,%esp
}
  80079d:	90                   	nop
  80079e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007a1:	c9                   	leave  
  8007a2:	c3                   	ret    

008007a3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007a3:	55                   	push   %ebp
  8007a4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007aa:	7e 1c                	jle    8007c8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	8d 50 08             	lea    0x8(%eax),%edx
  8007b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b7:	89 10                	mov    %edx,(%eax)
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	8b 00                	mov    (%eax),%eax
  8007be:	83 e8 08             	sub    $0x8,%eax
  8007c1:	8b 50 04             	mov    0x4(%eax),%edx
  8007c4:	8b 00                	mov    (%eax),%eax
  8007c6:	eb 40                	jmp    800808 <getuint+0x65>
	else if (lflag)
  8007c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007cc:	74 1e                	je     8007ec <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d1:	8b 00                	mov    (%eax),%eax
  8007d3:	8d 50 04             	lea    0x4(%eax),%edx
  8007d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d9:	89 10                	mov    %edx,(%eax)
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	8b 00                	mov    (%eax),%eax
  8007e0:	83 e8 04             	sub    $0x4,%eax
  8007e3:	8b 00                	mov    (%eax),%eax
  8007e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8007ea:	eb 1c                	jmp    800808 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	8b 00                	mov    (%eax),%eax
  8007f1:	8d 50 04             	lea    0x4(%eax),%edx
  8007f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f7:	89 10                	mov    %edx,(%eax)
  8007f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fc:	8b 00                	mov    (%eax),%eax
  8007fe:	83 e8 04             	sub    $0x4,%eax
  800801:	8b 00                	mov    (%eax),%eax
  800803:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800808:	5d                   	pop    %ebp
  800809:	c3                   	ret    

0080080a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80080a:	55                   	push   %ebp
  80080b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80080d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800811:	7e 1c                	jle    80082f <getint+0x25>
		return va_arg(*ap, long long);
  800813:	8b 45 08             	mov    0x8(%ebp),%eax
  800816:	8b 00                	mov    (%eax),%eax
  800818:	8d 50 08             	lea    0x8(%eax),%edx
  80081b:	8b 45 08             	mov    0x8(%ebp),%eax
  80081e:	89 10                	mov    %edx,(%eax)
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	83 e8 08             	sub    $0x8,%eax
  800828:	8b 50 04             	mov    0x4(%eax),%edx
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	eb 38                	jmp    800867 <getint+0x5d>
	else if (lflag)
  80082f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800833:	74 1a                	je     80084f <getint+0x45>
		return va_arg(*ap, long);
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	8b 00                	mov    (%eax),%eax
  80083a:	8d 50 04             	lea    0x4(%eax),%edx
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	89 10                	mov    %edx,(%eax)
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	83 e8 04             	sub    $0x4,%eax
  80084a:	8b 00                	mov    (%eax),%eax
  80084c:	99                   	cltd   
  80084d:	eb 18                	jmp    800867 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	8b 00                	mov    (%eax),%eax
  800854:	8d 50 04             	lea    0x4(%eax),%edx
  800857:	8b 45 08             	mov    0x8(%ebp),%eax
  80085a:	89 10                	mov    %edx,(%eax)
  80085c:	8b 45 08             	mov    0x8(%ebp),%eax
  80085f:	8b 00                	mov    (%eax),%eax
  800861:	83 e8 04             	sub    $0x4,%eax
  800864:	8b 00                	mov    (%eax),%eax
  800866:	99                   	cltd   
}
  800867:	5d                   	pop    %ebp
  800868:	c3                   	ret    

00800869 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800869:	55                   	push   %ebp
  80086a:	89 e5                	mov    %esp,%ebp
  80086c:	56                   	push   %esi
  80086d:	53                   	push   %ebx
  80086e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800871:	eb 17                	jmp    80088a <vprintfmt+0x21>
			if (ch == '\0')
  800873:	85 db                	test   %ebx,%ebx
  800875:	0f 84 af 03 00 00    	je     800c2a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80087b:	83 ec 08             	sub    $0x8,%esp
  80087e:	ff 75 0c             	pushl  0xc(%ebp)
  800881:	53                   	push   %ebx
  800882:	8b 45 08             	mov    0x8(%ebp),%eax
  800885:	ff d0                	call   *%eax
  800887:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80088a:	8b 45 10             	mov    0x10(%ebp),%eax
  80088d:	8d 50 01             	lea    0x1(%eax),%edx
  800890:	89 55 10             	mov    %edx,0x10(%ebp)
  800893:	8a 00                	mov    (%eax),%al
  800895:	0f b6 d8             	movzbl %al,%ebx
  800898:	83 fb 25             	cmp    $0x25,%ebx
  80089b:	75 d6                	jne    800873 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80089d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008a1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008a8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008b6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c0:	8d 50 01             	lea    0x1(%eax),%edx
  8008c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8008c6:	8a 00                	mov    (%eax),%al
  8008c8:	0f b6 d8             	movzbl %al,%ebx
  8008cb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008ce:	83 f8 55             	cmp    $0x55,%eax
  8008d1:	0f 87 2b 03 00 00    	ja     800c02 <vprintfmt+0x399>
  8008d7:	8b 04 85 f8 26 80 00 	mov    0x8026f8(,%eax,4),%eax
  8008de:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008e0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008e4:	eb d7                	jmp    8008bd <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008e6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008ea:	eb d1                	jmp    8008bd <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008ec:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f6:	89 d0                	mov    %edx,%eax
  8008f8:	c1 e0 02             	shl    $0x2,%eax
  8008fb:	01 d0                	add    %edx,%eax
  8008fd:	01 c0                	add    %eax,%eax
  8008ff:	01 d8                	add    %ebx,%eax
  800901:	83 e8 30             	sub    $0x30,%eax
  800904:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800907:	8b 45 10             	mov    0x10(%ebp),%eax
  80090a:	8a 00                	mov    (%eax),%al
  80090c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80090f:	83 fb 2f             	cmp    $0x2f,%ebx
  800912:	7e 3e                	jle    800952 <vprintfmt+0xe9>
  800914:	83 fb 39             	cmp    $0x39,%ebx
  800917:	7f 39                	jg     800952 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800919:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80091c:	eb d5                	jmp    8008f3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80091e:	8b 45 14             	mov    0x14(%ebp),%eax
  800921:	83 c0 04             	add    $0x4,%eax
  800924:	89 45 14             	mov    %eax,0x14(%ebp)
  800927:	8b 45 14             	mov    0x14(%ebp),%eax
  80092a:	83 e8 04             	sub    $0x4,%eax
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800932:	eb 1f                	jmp    800953 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800934:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800938:	79 83                	jns    8008bd <vprintfmt+0x54>
				width = 0;
  80093a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800941:	e9 77 ff ff ff       	jmp    8008bd <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800946:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80094d:	e9 6b ff ff ff       	jmp    8008bd <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800952:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800953:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800957:	0f 89 60 ff ff ff    	jns    8008bd <vprintfmt+0x54>
				width = precision, precision = -1;
  80095d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800960:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800963:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80096a:	e9 4e ff ff ff       	jmp    8008bd <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80096f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800972:	e9 46 ff ff ff       	jmp    8008bd <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800977:	8b 45 14             	mov    0x14(%ebp),%eax
  80097a:	83 c0 04             	add    $0x4,%eax
  80097d:	89 45 14             	mov    %eax,0x14(%ebp)
  800980:	8b 45 14             	mov    0x14(%ebp),%eax
  800983:	83 e8 04             	sub    $0x4,%eax
  800986:	8b 00                	mov    (%eax),%eax
  800988:	83 ec 08             	sub    $0x8,%esp
  80098b:	ff 75 0c             	pushl  0xc(%ebp)
  80098e:	50                   	push   %eax
  80098f:	8b 45 08             	mov    0x8(%ebp),%eax
  800992:	ff d0                	call   *%eax
  800994:	83 c4 10             	add    $0x10,%esp
			break;
  800997:	e9 89 02 00 00       	jmp    800c25 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80099c:	8b 45 14             	mov    0x14(%ebp),%eax
  80099f:	83 c0 04             	add    $0x4,%eax
  8009a2:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a8:	83 e8 04             	sub    $0x4,%eax
  8009ab:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009ad:	85 db                	test   %ebx,%ebx
  8009af:	79 02                	jns    8009b3 <vprintfmt+0x14a>
				err = -err;
  8009b1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009b3:	83 fb 64             	cmp    $0x64,%ebx
  8009b6:	7f 0b                	jg     8009c3 <vprintfmt+0x15a>
  8009b8:	8b 34 9d 40 25 80 00 	mov    0x802540(,%ebx,4),%esi
  8009bf:	85 f6                	test   %esi,%esi
  8009c1:	75 19                	jne    8009dc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009c3:	53                   	push   %ebx
  8009c4:	68 e5 26 80 00       	push   $0x8026e5
  8009c9:	ff 75 0c             	pushl  0xc(%ebp)
  8009cc:	ff 75 08             	pushl  0x8(%ebp)
  8009cf:	e8 5e 02 00 00       	call   800c32 <printfmt>
  8009d4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009d7:	e9 49 02 00 00       	jmp    800c25 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009dc:	56                   	push   %esi
  8009dd:	68 ee 26 80 00       	push   $0x8026ee
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	ff 75 08             	pushl  0x8(%ebp)
  8009e8:	e8 45 02 00 00       	call   800c32 <printfmt>
  8009ed:	83 c4 10             	add    $0x10,%esp
			break;
  8009f0:	e9 30 02 00 00       	jmp    800c25 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f8:	83 c0 04             	add    $0x4,%eax
  8009fb:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800a01:	83 e8 04             	sub    $0x4,%eax
  800a04:	8b 30                	mov    (%eax),%esi
  800a06:	85 f6                	test   %esi,%esi
  800a08:	75 05                	jne    800a0f <vprintfmt+0x1a6>
				p = "(null)";
  800a0a:	be f1 26 80 00       	mov    $0x8026f1,%esi
			if (width > 0 && padc != '-')
  800a0f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a13:	7e 6d                	jle    800a82 <vprintfmt+0x219>
  800a15:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a19:	74 67                	je     800a82 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a1e:	83 ec 08             	sub    $0x8,%esp
  800a21:	50                   	push   %eax
  800a22:	56                   	push   %esi
  800a23:	e8 0c 03 00 00       	call   800d34 <strnlen>
  800a28:	83 c4 10             	add    $0x10,%esp
  800a2b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a2e:	eb 16                	jmp    800a46 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a30:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	50                   	push   %eax
  800a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3e:	ff d0                	call   *%eax
  800a40:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a43:	ff 4d e4             	decl   -0x1c(%ebp)
  800a46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a4a:	7f e4                	jg     800a30 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a4c:	eb 34                	jmp    800a82 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a4e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a52:	74 1c                	je     800a70 <vprintfmt+0x207>
  800a54:	83 fb 1f             	cmp    $0x1f,%ebx
  800a57:	7e 05                	jle    800a5e <vprintfmt+0x1f5>
  800a59:	83 fb 7e             	cmp    $0x7e,%ebx
  800a5c:	7e 12                	jle    800a70 <vprintfmt+0x207>
					putch('?', putdat);
  800a5e:	83 ec 08             	sub    $0x8,%esp
  800a61:	ff 75 0c             	pushl  0xc(%ebp)
  800a64:	6a 3f                	push   $0x3f
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	ff d0                	call   *%eax
  800a6b:	83 c4 10             	add    $0x10,%esp
  800a6e:	eb 0f                	jmp    800a7f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	ff 75 0c             	pushl  0xc(%ebp)
  800a76:	53                   	push   %ebx
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	ff d0                	call   *%eax
  800a7c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a7f:	ff 4d e4             	decl   -0x1c(%ebp)
  800a82:	89 f0                	mov    %esi,%eax
  800a84:	8d 70 01             	lea    0x1(%eax),%esi
  800a87:	8a 00                	mov    (%eax),%al
  800a89:	0f be d8             	movsbl %al,%ebx
  800a8c:	85 db                	test   %ebx,%ebx
  800a8e:	74 24                	je     800ab4 <vprintfmt+0x24b>
  800a90:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a94:	78 b8                	js     800a4e <vprintfmt+0x1e5>
  800a96:	ff 4d e0             	decl   -0x20(%ebp)
  800a99:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a9d:	79 af                	jns    800a4e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a9f:	eb 13                	jmp    800ab4 <vprintfmt+0x24b>
				putch(' ', putdat);
  800aa1:	83 ec 08             	sub    $0x8,%esp
  800aa4:	ff 75 0c             	pushl  0xc(%ebp)
  800aa7:	6a 20                	push   $0x20
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	ff d0                	call   *%eax
  800aae:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ab1:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab8:	7f e7                	jg     800aa1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800aba:	e9 66 01 00 00       	jmp    800c25 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800abf:	83 ec 08             	sub    $0x8,%esp
  800ac2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac8:	50                   	push   %eax
  800ac9:	e8 3c fd ff ff       	call   80080a <getint>
  800ace:	83 c4 10             	add    $0x10,%esp
  800ad1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ada:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800add:	85 d2                	test   %edx,%edx
  800adf:	79 23                	jns    800b04 <vprintfmt+0x29b>
				putch('-', putdat);
  800ae1:	83 ec 08             	sub    $0x8,%esp
  800ae4:	ff 75 0c             	pushl  0xc(%ebp)
  800ae7:	6a 2d                	push   $0x2d
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	ff d0                	call   *%eax
  800aee:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af7:	f7 d8                	neg    %eax
  800af9:	83 d2 00             	adc    $0x0,%edx
  800afc:	f7 da                	neg    %edx
  800afe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b01:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b04:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b0b:	e9 bc 00 00 00       	jmp    800bcc <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b10:	83 ec 08             	sub    $0x8,%esp
  800b13:	ff 75 e8             	pushl  -0x18(%ebp)
  800b16:	8d 45 14             	lea    0x14(%ebp),%eax
  800b19:	50                   	push   %eax
  800b1a:	e8 84 fc ff ff       	call   8007a3 <getuint>
  800b1f:	83 c4 10             	add    $0x10,%esp
  800b22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b25:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b28:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b2f:	e9 98 00 00 00       	jmp    800bcc <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b34:	83 ec 08             	sub    $0x8,%esp
  800b37:	ff 75 0c             	pushl  0xc(%ebp)
  800b3a:	6a 58                	push   $0x58
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	ff d0                	call   *%eax
  800b41:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b44:	83 ec 08             	sub    $0x8,%esp
  800b47:	ff 75 0c             	pushl  0xc(%ebp)
  800b4a:	6a 58                	push   $0x58
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	ff d0                	call   *%eax
  800b51:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 0c             	pushl  0xc(%ebp)
  800b5a:	6a 58                	push   $0x58
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	ff d0                	call   *%eax
  800b61:	83 c4 10             	add    $0x10,%esp
			break;
  800b64:	e9 bc 00 00 00       	jmp    800c25 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b69:	83 ec 08             	sub    $0x8,%esp
  800b6c:	ff 75 0c             	pushl  0xc(%ebp)
  800b6f:	6a 30                	push   $0x30
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	ff d0                	call   *%eax
  800b76:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b79:	83 ec 08             	sub    $0x8,%esp
  800b7c:	ff 75 0c             	pushl  0xc(%ebp)
  800b7f:	6a 78                	push   $0x78
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	ff d0                	call   *%eax
  800b86:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b89:	8b 45 14             	mov    0x14(%ebp),%eax
  800b8c:	83 c0 04             	add    $0x4,%eax
  800b8f:	89 45 14             	mov    %eax,0x14(%ebp)
  800b92:	8b 45 14             	mov    0x14(%ebp),%eax
  800b95:	83 e8 04             	sub    $0x4,%eax
  800b98:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ba4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bab:	eb 1f                	jmp    800bcc <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bad:	83 ec 08             	sub    $0x8,%esp
  800bb0:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb3:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb6:	50                   	push   %eax
  800bb7:	e8 e7 fb ff ff       	call   8007a3 <getuint>
  800bbc:	83 c4 10             	add    $0x10,%esp
  800bbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bc5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bcc:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd3:	83 ec 04             	sub    $0x4,%esp
  800bd6:	52                   	push   %edx
  800bd7:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bda:	50                   	push   %eax
  800bdb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bde:	ff 75 f0             	pushl  -0x10(%ebp)
  800be1:	ff 75 0c             	pushl  0xc(%ebp)
  800be4:	ff 75 08             	pushl  0x8(%ebp)
  800be7:	e8 00 fb ff ff       	call   8006ec <printnum>
  800bec:	83 c4 20             	add    $0x20,%esp
			break;
  800bef:	eb 34                	jmp    800c25 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bf1:	83 ec 08             	sub    $0x8,%esp
  800bf4:	ff 75 0c             	pushl  0xc(%ebp)
  800bf7:	53                   	push   %ebx
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfb:	ff d0                	call   *%eax
  800bfd:	83 c4 10             	add    $0x10,%esp
			break;
  800c00:	eb 23                	jmp    800c25 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c02:	83 ec 08             	sub    $0x8,%esp
  800c05:	ff 75 0c             	pushl  0xc(%ebp)
  800c08:	6a 25                	push   $0x25
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	ff d0                	call   *%eax
  800c0f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c12:	ff 4d 10             	decl   0x10(%ebp)
  800c15:	eb 03                	jmp    800c1a <vprintfmt+0x3b1>
  800c17:	ff 4d 10             	decl   0x10(%ebp)
  800c1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1d:	48                   	dec    %eax
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	3c 25                	cmp    $0x25,%al
  800c22:	75 f3                	jne    800c17 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c24:	90                   	nop
		}
	}
  800c25:	e9 47 fc ff ff       	jmp    800871 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c2a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c2b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c2e:	5b                   	pop    %ebx
  800c2f:	5e                   	pop    %esi
  800c30:	5d                   	pop    %ebp
  800c31:	c3                   	ret    

00800c32 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c32:	55                   	push   %ebp
  800c33:	89 e5                	mov    %esp,%ebp
  800c35:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c38:	8d 45 10             	lea    0x10(%ebp),%eax
  800c3b:	83 c0 04             	add    $0x4,%eax
  800c3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c41:	8b 45 10             	mov    0x10(%ebp),%eax
  800c44:	ff 75 f4             	pushl  -0xc(%ebp)
  800c47:	50                   	push   %eax
  800c48:	ff 75 0c             	pushl  0xc(%ebp)
  800c4b:	ff 75 08             	pushl  0x8(%ebp)
  800c4e:	e8 16 fc ff ff       	call   800869 <vprintfmt>
  800c53:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c56:	90                   	nop
  800c57:	c9                   	leave  
  800c58:	c3                   	ret    

00800c59 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c59:	55                   	push   %ebp
  800c5a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5f:	8b 40 08             	mov    0x8(%eax),%eax
  800c62:	8d 50 01             	lea    0x1(%eax),%edx
  800c65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c68:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6e:	8b 10                	mov    (%eax),%edx
  800c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c73:	8b 40 04             	mov    0x4(%eax),%eax
  800c76:	39 c2                	cmp    %eax,%edx
  800c78:	73 12                	jae    800c8c <sprintputch+0x33>
		*b->buf++ = ch;
  800c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7d:	8b 00                	mov    (%eax),%eax
  800c7f:	8d 48 01             	lea    0x1(%eax),%ecx
  800c82:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c85:	89 0a                	mov    %ecx,(%edx)
  800c87:	8b 55 08             	mov    0x8(%ebp),%edx
  800c8a:	88 10                	mov    %dl,(%eax)
}
  800c8c:	90                   	nop
  800c8d:	5d                   	pop    %ebp
  800c8e:	c3                   	ret    

00800c8f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c8f:	55                   	push   %ebp
  800c90:	89 e5                	mov    %esp,%ebp
  800c92:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
  800c98:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	01 d0                	add    %edx,%eax
  800ca6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cb0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cb4:	74 06                	je     800cbc <vsnprintf+0x2d>
  800cb6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cba:	7f 07                	jg     800cc3 <vsnprintf+0x34>
		return -E_INVAL;
  800cbc:	b8 03 00 00 00       	mov    $0x3,%eax
  800cc1:	eb 20                	jmp    800ce3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cc3:	ff 75 14             	pushl  0x14(%ebp)
  800cc6:	ff 75 10             	pushl  0x10(%ebp)
  800cc9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ccc:	50                   	push   %eax
  800ccd:	68 59 0c 80 00       	push   $0x800c59
  800cd2:	e8 92 fb ff ff       	call   800869 <vprintfmt>
  800cd7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cda:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cdd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ce0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ce3:	c9                   	leave  
  800ce4:	c3                   	ret    

00800ce5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ce5:	55                   	push   %ebp
  800ce6:	89 e5                	mov    %esp,%ebp
  800ce8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ceb:	8d 45 10             	lea    0x10(%ebp),%eax
  800cee:	83 c0 04             	add    $0x4,%eax
  800cf1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cf4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf7:	ff 75 f4             	pushl  -0xc(%ebp)
  800cfa:	50                   	push   %eax
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	ff 75 08             	pushl  0x8(%ebp)
  800d01:	e8 89 ff ff ff       	call   800c8f <vsnprintf>
  800d06:	83 c4 10             	add    $0x10,%esp
  800d09:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d0f:	c9                   	leave  
  800d10:	c3                   	ret    

00800d11 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d11:	55                   	push   %ebp
  800d12:	89 e5                	mov    %esp,%ebp
  800d14:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d17:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1e:	eb 06                	jmp    800d26 <strlen+0x15>
		n++;
  800d20:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d23:	ff 45 08             	incl   0x8(%ebp)
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	84 c0                	test   %al,%al
  800d2d:	75 f1                	jne    800d20 <strlen+0xf>
		n++;
	return n;
  800d2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d32:	c9                   	leave  
  800d33:	c3                   	ret    

00800d34 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d34:	55                   	push   %ebp
  800d35:	89 e5                	mov    %esp,%ebp
  800d37:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d3a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d41:	eb 09                	jmp    800d4c <strnlen+0x18>
		n++;
  800d43:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d46:	ff 45 08             	incl   0x8(%ebp)
  800d49:	ff 4d 0c             	decl   0xc(%ebp)
  800d4c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d50:	74 09                	je     800d5b <strnlen+0x27>
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	84 c0                	test   %al,%al
  800d59:	75 e8                	jne    800d43 <strnlen+0xf>
		n++;
	return n;
  800d5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5e:	c9                   	leave  
  800d5f:	c3                   	ret    

00800d60 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d60:	55                   	push   %ebp
  800d61:	89 e5                	mov    %esp,%ebp
  800d63:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d6c:	90                   	nop
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8d 50 01             	lea    0x1(%eax),%edx
  800d73:	89 55 08             	mov    %edx,0x8(%ebp)
  800d76:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d79:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d7c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d7f:	8a 12                	mov    (%edx),%dl
  800d81:	88 10                	mov    %dl,(%eax)
  800d83:	8a 00                	mov    (%eax),%al
  800d85:	84 c0                	test   %al,%al
  800d87:	75 e4                	jne    800d6d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d8c:	c9                   	leave  
  800d8d:	c3                   	ret    

00800d8e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d8e:	55                   	push   %ebp
  800d8f:	89 e5                	mov    %esp,%ebp
  800d91:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da1:	eb 1f                	jmp    800dc2 <strncpy+0x34>
		*dst++ = *src;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	8d 50 01             	lea    0x1(%eax),%edx
  800da9:	89 55 08             	mov    %edx,0x8(%ebp)
  800dac:	8b 55 0c             	mov    0xc(%ebp),%edx
  800daf:	8a 12                	mov    (%edx),%dl
  800db1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800db3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db6:	8a 00                	mov    (%eax),%al
  800db8:	84 c0                	test   %al,%al
  800dba:	74 03                	je     800dbf <strncpy+0x31>
			src++;
  800dbc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dbf:	ff 45 fc             	incl   -0x4(%ebp)
  800dc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc8:	72 d9                	jb     800da3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dcd:	c9                   	leave  
  800dce:	c3                   	ret    

00800dcf <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dcf:	55                   	push   %ebp
  800dd0:	89 e5                	mov    %esp,%ebp
  800dd2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ddb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddf:	74 30                	je     800e11 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800de1:	eb 16                	jmp    800df9 <strlcpy+0x2a>
			*dst++ = *src++;
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8d 50 01             	lea    0x1(%eax),%edx
  800de9:	89 55 08             	mov    %edx,0x8(%ebp)
  800dec:	8b 55 0c             	mov    0xc(%ebp),%edx
  800def:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df5:	8a 12                	mov    (%edx),%dl
  800df7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800df9:	ff 4d 10             	decl   0x10(%ebp)
  800dfc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e00:	74 09                	je     800e0b <strlcpy+0x3c>
  800e02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e05:	8a 00                	mov    (%eax),%al
  800e07:	84 c0                	test   %al,%al
  800e09:	75 d8                	jne    800de3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e11:	8b 55 08             	mov    0x8(%ebp),%edx
  800e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e17:	29 c2                	sub    %eax,%edx
  800e19:	89 d0                	mov    %edx,%eax
}
  800e1b:	c9                   	leave  
  800e1c:	c3                   	ret    

00800e1d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e1d:	55                   	push   %ebp
  800e1e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e20:	eb 06                	jmp    800e28 <strcmp+0xb>
		p++, q++;
  800e22:	ff 45 08             	incl   0x8(%ebp)
  800e25:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	84 c0                	test   %al,%al
  800e2f:	74 0e                	je     800e3f <strcmp+0x22>
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	8a 10                	mov    (%eax),%dl
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	8a 00                	mov    (%eax),%al
  800e3b:	38 c2                	cmp    %al,%dl
  800e3d:	74 e3                	je     800e22 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	8a 00                	mov    (%eax),%al
  800e44:	0f b6 d0             	movzbl %al,%edx
  800e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	0f b6 c0             	movzbl %al,%eax
  800e4f:	29 c2                	sub    %eax,%edx
  800e51:	89 d0                	mov    %edx,%eax
}
  800e53:	5d                   	pop    %ebp
  800e54:	c3                   	ret    

00800e55 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e55:	55                   	push   %ebp
  800e56:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e58:	eb 09                	jmp    800e63 <strncmp+0xe>
		n--, p++, q++;
  800e5a:	ff 4d 10             	decl   0x10(%ebp)
  800e5d:	ff 45 08             	incl   0x8(%ebp)
  800e60:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e67:	74 17                	je     800e80 <strncmp+0x2b>
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	84 c0                	test   %al,%al
  800e70:	74 0e                	je     800e80 <strncmp+0x2b>
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	8a 10                	mov    (%eax),%dl
  800e77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	38 c2                	cmp    %al,%dl
  800e7e:	74 da                	je     800e5a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e84:	75 07                	jne    800e8d <strncmp+0x38>
		return 0;
  800e86:	b8 00 00 00 00       	mov    $0x0,%eax
  800e8b:	eb 14                	jmp    800ea1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e90:	8a 00                	mov    (%eax),%al
  800e92:	0f b6 d0             	movzbl %al,%edx
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	8a 00                	mov    (%eax),%al
  800e9a:	0f b6 c0             	movzbl %al,%eax
  800e9d:	29 c2                	sub    %eax,%edx
  800e9f:	89 d0                	mov    %edx,%eax
}
  800ea1:	5d                   	pop    %ebp
  800ea2:	c3                   	ret    

00800ea3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ea3:	55                   	push   %ebp
  800ea4:	89 e5                	mov    %esp,%ebp
  800ea6:	83 ec 04             	sub    $0x4,%esp
  800ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eac:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eaf:	eb 12                	jmp    800ec3 <strchr+0x20>
		if (*s == c)
  800eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb4:	8a 00                	mov    (%eax),%al
  800eb6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eb9:	75 05                	jne    800ec0 <strchr+0x1d>
			return (char *) s;
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	eb 11                	jmp    800ed1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ec0:	ff 45 08             	incl   0x8(%ebp)
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	8a 00                	mov    (%eax),%al
  800ec8:	84 c0                	test   %al,%al
  800eca:	75 e5                	jne    800eb1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ecc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 04             	sub    $0x4,%esp
  800ed9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800edf:	eb 0d                	jmp    800eee <strfind+0x1b>
		if (*s == c)
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ee9:	74 0e                	je     800ef9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800eeb:	ff 45 08             	incl   0x8(%ebp)
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	84 c0                	test   %al,%al
  800ef5:	75 ea                	jne    800ee1 <strfind+0xe>
  800ef7:	eb 01                	jmp    800efa <strfind+0x27>
		if (*s == c)
			break;
  800ef9:	90                   	nop
	return (char *) s;
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
  800f02:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f11:	eb 0e                	jmp    800f21 <memset+0x22>
		*p++ = c;
  800f13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f16:	8d 50 01             	lea    0x1(%eax),%edx
  800f19:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f21:	ff 4d f8             	decl   -0x8(%ebp)
  800f24:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f28:	79 e9                	jns    800f13 <memset+0x14>
		*p++ = c;

	return v;
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f2d:	c9                   	leave  
  800f2e:	c3                   	ret    

00800f2f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f2f:	55                   	push   %ebp
  800f30:	89 e5                	mov    %esp,%ebp
  800f32:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f41:	eb 16                	jmp    800f59 <memcpy+0x2a>
		*d++ = *s++;
  800f43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f46:	8d 50 01             	lea    0x1(%eax),%edx
  800f49:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f4c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f52:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f55:	8a 12                	mov    (%edx),%dl
  800f57:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f59:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f5f:	89 55 10             	mov    %edx,0x10(%ebp)
  800f62:	85 c0                	test   %eax,%eax
  800f64:	75 dd                	jne    800f43 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f69:	c9                   	leave  
  800f6a:	c3                   	ret    

00800f6b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f6b:	55                   	push   %ebp
  800f6c:	89 e5                	mov    %esp,%ebp
  800f6e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f80:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f83:	73 50                	jae    800fd5 <memmove+0x6a>
  800f85:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f88:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8b:	01 d0                	add    %edx,%eax
  800f8d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f90:	76 43                	jbe    800fd5 <memmove+0x6a>
		s += n;
  800f92:	8b 45 10             	mov    0x10(%ebp),%eax
  800f95:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f98:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f9e:	eb 10                	jmp    800fb0 <memmove+0x45>
			*--d = *--s;
  800fa0:	ff 4d f8             	decl   -0x8(%ebp)
  800fa3:	ff 4d fc             	decl   -0x4(%ebp)
  800fa6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa9:	8a 10                	mov    (%eax),%dl
  800fab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fae:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb6:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb9:	85 c0                	test   %eax,%eax
  800fbb:	75 e3                	jne    800fa0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fbd:	eb 23                	jmp    800fe2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc2:	8d 50 01             	lea    0x1(%eax),%edx
  800fc5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fc8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fcb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fd1:	8a 12                	mov    (%edx),%dl
  800fd3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fdb:	89 55 10             	mov    %edx,0x10(%ebp)
  800fde:	85 c0                	test   %eax,%eax
  800fe0:	75 dd                	jne    800fbf <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe5:	c9                   	leave  
  800fe6:	c3                   	ret    

00800fe7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fe7:	55                   	push   %ebp
  800fe8:	89 e5                	mov    %esp,%ebp
  800fea:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ff9:	eb 2a                	jmp    801025 <memcmp+0x3e>
		if (*s1 != *s2)
  800ffb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ffe:	8a 10                	mov    (%eax),%dl
  801000:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	38 c2                	cmp    %al,%dl
  801007:	74 16                	je     80101f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801009:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100c:	8a 00                	mov    (%eax),%al
  80100e:	0f b6 d0             	movzbl %al,%edx
  801011:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	0f b6 c0             	movzbl %al,%eax
  801019:	29 c2                	sub    %eax,%edx
  80101b:	89 d0                	mov    %edx,%eax
  80101d:	eb 18                	jmp    801037 <memcmp+0x50>
		s1++, s2++;
  80101f:	ff 45 fc             	incl   -0x4(%ebp)
  801022:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801025:	8b 45 10             	mov    0x10(%ebp),%eax
  801028:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102b:	89 55 10             	mov    %edx,0x10(%ebp)
  80102e:	85 c0                	test   %eax,%eax
  801030:	75 c9                	jne    800ffb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801032:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801037:	c9                   	leave  
  801038:	c3                   	ret    

00801039 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801039:	55                   	push   %ebp
  80103a:	89 e5                	mov    %esp,%ebp
  80103c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80103f:	8b 55 08             	mov    0x8(%ebp),%edx
  801042:	8b 45 10             	mov    0x10(%ebp),%eax
  801045:	01 d0                	add    %edx,%eax
  801047:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80104a:	eb 15                	jmp    801061 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	8a 00                	mov    (%eax),%al
  801051:	0f b6 d0             	movzbl %al,%edx
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	0f b6 c0             	movzbl %al,%eax
  80105a:	39 c2                	cmp    %eax,%edx
  80105c:	74 0d                	je     80106b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80105e:	ff 45 08             	incl   0x8(%ebp)
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801067:	72 e3                	jb     80104c <memfind+0x13>
  801069:	eb 01                	jmp    80106c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80106b:	90                   	nop
	return (void *) s;
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80106f:	c9                   	leave  
  801070:	c3                   	ret    

00801071 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801071:	55                   	push   %ebp
  801072:	89 e5                	mov    %esp,%ebp
  801074:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801077:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80107e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801085:	eb 03                	jmp    80108a <strtol+0x19>
		s++;
  801087:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	8a 00                	mov    (%eax),%al
  80108f:	3c 20                	cmp    $0x20,%al
  801091:	74 f4                	je     801087 <strtol+0x16>
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	8a 00                	mov    (%eax),%al
  801098:	3c 09                	cmp    $0x9,%al
  80109a:	74 eb                	je     801087 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	3c 2b                	cmp    $0x2b,%al
  8010a3:	75 05                	jne    8010aa <strtol+0x39>
		s++;
  8010a5:	ff 45 08             	incl   0x8(%ebp)
  8010a8:	eb 13                	jmp    8010bd <strtol+0x4c>
	else if (*s == '-')
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	8a 00                	mov    (%eax),%al
  8010af:	3c 2d                	cmp    $0x2d,%al
  8010b1:	75 0a                	jne    8010bd <strtol+0x4c>
		s++, neg = 1;
  8010b3:	ff 45 08             	incl   0x8(%ebp)
  8010b6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c1:	74 06                	je     8010c9 <strtol+0x58>
  8010c3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010c7:	75 20                	jne    8010e9 <strtol+0x78>
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	8a 00                	mov    (%eax),%al
  8010ce:	3c 30                	cmp    $0x30,%al
  8010d0:	75 17                	jne    8010e9 <strtol+0x78>
  8010d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d5:	40                   	inc    %eax
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	3c 78                	cmp    $0x78,%al
  8010da:	75 0d                	jne    8010e9 <strtol+0x78>
		s += 2, base = 16;
  8010dc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010e0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010e7:	eb 28                	jmp    801111 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ed:	75 15                	jne    801104 <strtol+0x93>
  8010ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f2:	8a 00                	mov    (%eax),%al
  8010f4:	3c 30                	cmp    $0x30,%al
  8010f6:	75 0c                	jne    801104 <strtol+0x93>
		s++, base = 8;
  8010f8:	ff 45 08             	incl   0x8(%ebp)
  8010fb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801102:	eb 0d                	jmp    801111 <strtol+0xa0>
	else if (base == 0)
  801104:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801108:	75 07                	jne    801111 <strtol+0xa0>
		base = 10;
  80110a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	8a 00                	mov    (%eax),%al
  801116:	3c 2f                	cmp    $0x2f,%al
  801118:	7e 19                	jle    801133 <strtol+0xc2>
  80111a:	8b 45 08             	mov    0x8(%ebp),%eax
  80111d:	8a 00                	mov    (%eax),%al
  80111f:	3c 39                	cmp    $0x39,%al
  801121:	7f 10                	jg     801133 <strtol+0xc2>
			dig = *s - '0';
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	0f be c0             	movsbl %al,%eax
  80112b:	83 e8 30             	sub    $0x30,%eax
  80112e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801131:	eb 42                	jmp    801175 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	3c 60                	cmp    $0x60,%al
  80113a:	7e 19                	jle    801155 <strtol+0xe4>
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	3c 7a                	cmp    $0x7a,%al
  801143:	7f 10                	jg     801155 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	8a 00                	mov    (%eax),%al
  80114a:	0f be c0             	movsbl %al,%eax
  80114d:	83 e8 57             	sub    $0x57,%eax
  801150:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801153:	eb 20                	jmp    801175 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	3c 40                	cmp    $0x40,%al
  80115c:	7e 39                	jle    801197 <strtol+0x126>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	3c 5a                	cmp    $0x5a,%al
  801165:	7f 30                	jg     801197 <strtol+0x126>
			dig = *s - 'A' + 10;
  801167:	8b 45 08             	mov    0x8(%ebp),%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	0f be c0             	movsbl %al,%eax
  80116f:	83 e8 37             	sub    $0x37,%eax
  801172:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801175:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801178:	3b 45 10             	cmp    0x10(%ebp),%eax
  80117b:	7d 19                	jge    801196 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80117d:	ff 45 08             	incl   0x8(%ebp)
  801180:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801183:	0f af 45 10          	imul   0x10(%ebp),%eax
  801187:	89 c2                	mov    %eax,%edx
  801189:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80118c:	01 d0                	add    %edx,%eax
  80118e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801191:	e9 7b ff ff ff       	jmp    801111 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801196:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801197:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80119b:	74 08                	je     8011a5 <strtol+0x134>
		*endptr = (char *) s;
  80119d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8011a3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011a9:	74 07                	je     8011b2 <strtol+0x141>
  8011ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ae:	f7 d8                	neg    %eax
  8011b0:	eb 03                	jmp    8011b5 <strtol+0x144>
  8011b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <ltostr>:

void
ltostr(long value, char *str)
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
  8011ba:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011c4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011cb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011cf:	79 13                	jns    8011e4 <ltostr+0x2d>
	{
		neg = 1;
  8011d1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011db:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011de:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011e1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011ec:	99                   	cltd   
  8011ed:	f7 f9                	idiv   %ecx
  8011ef:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f5:	8d 50 01             	lea    0x1(%eax),%edx
  8011f8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011fb:	89 c2                	mov    %eax,%edx
  8011fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801200:	01 d0                	add    %edx,%eax
  801202:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801205:	83 c2 30             	add    $0x30,%edx
  801208:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80120a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80120d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801212:	f7 e9                	imul   %ecx
  801214:	c1 fa 02             	sar    $0x2,%edx
  801217:	89 c8                	mov    %ecx,%eax
  801219:	c1 f8 1f             	sar    $0x1f,%eax
  80121c:	29 c2                	sub    %eax,%edx
  80121e:	89 d0                	mov    %edx,%eax
  801220:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801223:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801226:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80122b:	f7 e9                	imul   %ecx
  80122d:	c1 fa 02             	sar    $0x2,%edx
  801230:	89 c8                	mov    %ecx,%eax
  801232:	c1 f8 1f             	sar    $0x1f,%eax
  801235:	29 c2                	sub    %eax,%edx
  801237:	89 d0                	mov    %edx,%eax
  801239:	c1 e0 02             	shl    $0x2,%eax
  80123c:	01 d0                	add    %edx,%eax
  80123e:	01 c0                	add    %eax,%eax
  801240:	29 c1                	sub    %eax,%ecx
  801242:	89 ca                	mov    %ecx,%edx
  801244:	85 d2                	test   %edx,%edx
  801246:	75 9c                	jne    8011e4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801248:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80124f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801252:	48                   	dec    %eax
  801253:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801256:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80125a:	74 3d                	je     801299 <ltostr+0xe2>
		start = 1 ;
  80125c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801263:	eb 34                	jmp    801299 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801265:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126b:	01 d0                	add    %edx,%eax
  80126d:	8a 00                	mov    (%eax),%al
  80126f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801272:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801275:	8b 45 0c             	mov    0xc(%ebp),%eax
  801278:	01 c2                	add    %eax,%edx
  80127a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80127d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801280:	01 c8                	add    %ecx,%eax
  801282:	8a 00                	mov    (%eax),%al
  801284:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801286:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	01 c2                	add    %eax,%edx
  80128e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801291:	88 02                	mov    %al,(%edx)
		start++ ;
  801293:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801296:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801299:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80129c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129f:	7c c4                	jl     801265 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012a1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a7:	01 d0                	add    %edx,%eax
  8012a9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012ac:	90                   	nop
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
  8012b2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012b5:	ff 75 08             	pushl  0x8(%ebp)
  8012b8:	e8 54 fa ff ff       	call   800d11 <strlen>
  8012bd:	83 c4 04             	add    $0x4,%esp
  8012c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012c3:	ff 75 0c             	pushl  0xc(%ebp)
  8012c6:	e8 46 fa ff ff       	call   800d11 <strlen>
  8012cb:	83 c4 04             	add    $0x4,%esp
  8012ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012df:	eb 17                	jmp    8012f8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e7:	01 c2                	add    %eax,%edx
  8012e9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	01 c8                	add    %ecx,%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012f5:	ff 45 fc             	incl   -0x4(%ebp)
  8012f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012fe:	7c e1                	jl     8012e1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801300:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801307:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80130e:	eb 1f                	jmp    80132f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801310:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801313:	8d 50 01             	lea    0x1(%eax),%edx
  801316:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801319:	89 c2                	mov    %eax,%edx
  80131b:	8b 45 10             	mov    0x10(%ebp),%eax
  80131e:	01 c2                	add    %eax,%edx
  801320:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801323:	8b 45 0c             	mov    0xc(%ebp),%eax
  801326:	01 c8                	add    %ecx,%eax
  801328:	8a 00                	mov    (%eax),%al
  80132a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80132c:	ff 45 f8             	incl   -0x8(%ebp)
  80132f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801332:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801335:	7c d9                	jl     801310 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801337:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80133a:	8b 45 10             	mov    0x10(%ebp),%eax
  80133d:	01 d0                	add    %edx,%eax
  80133f:	c6 00 00             	movb   $0x0,(%eax)
}
  801342:	90                   	nop
  801343:	c9                   	leave  
  801344:	c3                   	ret    

00801345 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801345:	55                   	push   %ebp
  801346:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801348:	8b 45 14             	mov    0x14(%ebp),%eax
  80134b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801351:	8b 45 14             	mov    0x14(%ebp),%eax
  801354:	8b 00                	mov    (%eax),%eax
  801356:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80135d:	8b 45 10             	mov    0x10(%ebp),%eax
  801360:	01 d0                	add    %edx,%eax
  801362:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801368:	eb 0c                	jmp    801376 <strsplit+0x31>
			*string++ = 0;
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8d 50 01             	lea    0x1(%eax),%edx
  801370:	89 55 08             	mov    %edx,0x8(%ebp)
  801373:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	84 c0                	test   %al,%al
  80137d:	74 18                	je     801397 <strsplit+0x52>
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	0f be c0             	movsbl %al,%eax
  801387:	50                   	push   %eax
  801388:	ff 75 0c             	pushl  0xc(%ebp)
  80138b:	e8 13 fb ff ff       	call   800ea3 <strchr>
  801390:	83 c4 08             	add    $0x8,%esp
  801393:	85 c0                	test   %eax,%eax
  801395:	75 d3                	jne    80136a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	84 c0                	test   %al,%al
  80139e:	74 5a                	je     8013fa <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a3:	8b 00                	mov    (%eax),%eax
  8013a5:	83 f8 0f             	cmp    $0xf,%eax
  8013a8:	75 07                	jne    8013b1 <strsplit+0x6c>
		{
			return 0;
  8013aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8013af:	eb 66                	jmp    801417 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b4:	8b 00                	mov    (%eax),%eax
  8013b6:	8d 48 01             	lea    0x1(%eax),%ecx
  8013b9:	8b 55 14             	mov    0x14(%ebp),%edx
  8013bc:	89 0a                	mov    %ecx,(%edx)
  8013be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c8:	01 c2                	add    %eax,%edx
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013cf:	eb 03                	jmp    8013d4 <strsplit+0x8f>
			string++;
  8013d1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	84 c0                	test   %al,%al
  8013db:	74 8b                	je     801368 <strsplit+0x23>
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	0f be c0             	movsbl %al,%eax
  8013e5:	50                   	push   %eax
  8013e6:	ff 75 0c             	pushl  0xc(%ebp)
  8013e9:	e8 b5 fa ff ff       	call   800ea3 <strchr>
  8013ee:	83 c4 08             	add    $0x8,%esp
  8013f1:	85 c0                	test   %eax,%eax
  8013f3:	74 dc                	je     8013d1 <strsplit+0x8c>
			string++;
	}
  8013f5:	e9 6e ff ff ff       	jmp    801368 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013fa:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fe:	8b 00                	mov    (%eax),%eax
  801400:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801407:	8b 45 10             	mov    0x10(%ebp),%eax
  80140a:	01 d0                	add    %edx,%eax
  80140c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801412:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801417:	c9                   	leave  
  801418:	c3                   	ret    

00801419 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801419:	55                   	push   %ebp
  80141a:	89 e5                	mov    %esp,%ebp
  80141c:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	c1 e8 0c             	shr    $0xc,%eax
  801425:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	25 ff 0f 00 00       	and    $0xfff,%eax
  801430:	85 c0                	test   %eax,%eax
  801432:	74 03                	je     801437 <malloc+0x1e>
			num++;
  801434:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801437:	a1 04 30 80 00       	mov    0x803004,%eax
  80143c:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801441:	75 73                	jne    8014b6 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801443:	83 ec 08             	sub    $0x8,%esp
  801446:	ff 75 08             	pushl  0x8(%ebp)
  801449:	68 00 00 00 80       	push   $0x80000000
  80144e:	e8 80 04 00 00       	call   8018d3 <sys_allocateMem>
  801453:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801456:	a1 04 30 80 00       	mov    0x803004,%eax
  80145b:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80145e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801461:	c1 e0 0c             	shl    $0xc,%eax
  801464:	89 c2                	mov    %eax,%edx
  801466:	a1 04 30 80 00       	mov    0x803004,%eax
  80146b:	01 d0                	add    %edx,%eax
  80146d:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801472:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801477:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80147a:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801481:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801486:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80148c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801493:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801498:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80149f:	01 00 00 00 
			sizeofarray++;
  8014a3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014a8:	40                   	inc    %eax
  8014a9:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8014ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8014b1:	e9 71 01 00 00       	jmp    801627 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8014b6:	a1 28 30 80 00       	mov    0x803028,%eax
  8014bb:	85 c0                	test   %eax,%eax
  8014bd:	75 71                	jne    801530 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8014bf:	a1 04 30 80 00       	mov    0x803004,%eax
  8014c4:	83 ec 08             	sub    $0x8,%esp
  8014c7:	ff 75 08             	pushl  0x8(%ebp)
  8014ca:	50                   	push   %eax
  8014cb:	e8 03 04 00 00       	call   8018d3 <sys_allocateMem>
  8014d0:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8014d3:	a1 04 30 80 00       	mov    0x803004,%eax
  8014d8:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8014db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014de:	c1 e0 0c             	shl    $0xc,%eax
  8014e1:	89 c2                	mov    %eax,%edx
  8014e3:	a1 04 30 80 00       	mov    0x803004,%eax
  8014e8:	01 d0                	add    %edx,%eax
  8014ea:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  8014ef:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014f7:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8014fe:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801503:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801506:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80150d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801512:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801519:	01 00 00 00 
				sizeofarray++;
  80151d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801522:	40                   	inc    %eax
  801523:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801528:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80152b:	e9 f7 00 00 00       	jmp    801627 <malloc+0x20e>
			}
			else{
				int count=0;
  801530:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801537:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80153e:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801545:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80154c:	eb 7c                	jmp    8015ca <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  80154e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801555:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80155c:	eb 1a                	jmp    801578 <malloc+0x15f>
					{
						if(addresses[j]==i)
  80155e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801561:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801568:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80156b:	75 08                	jne    801575 <malloc+0x15c>
						{
							index=j;
  80156d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801570:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801573:	eb 0d                	jmp    801582 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801575:	ff 45 dc             	incl   -0x24(%ebp)
  801578:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80157d:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801580:	7c dc                	jl     80155e <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801582:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801586:	75 05                	jne    80158d <malloc+0x174>
					{
						count++;
  801588:	ff 45 f0             	incl   -0x10(%ebp)
  80158b:	eb 36                	jmp    8015c3 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  80158d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801590:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801597:	85 c0                	test   %eax,%eax
  801599:	75 05                	jne    8015a0 <malloc+0x187>
						{
							count++;
  80159b:	ff 45 f0             	incl   -0x10(%ebp)
  80159e:	eb 23                	jmp    8015c3 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8015a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015a3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8015a6:	7d 14                	jge    8015bc <malloc+0x1a3>
  8015a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ae:	7c 0c                	jl     8015bc <malloc+0x1a3>
							{
								min=count;
  8015b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8015b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8015bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8015c3:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8015ca:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8015d1:	0f 86 77 ff ff ff    	jbe    80154e <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8015d7:	83 ec 08             	sub    $0x8,%esp
  8015da:	ff 75 08             	pushl  0x8(%ebp)
  8015dd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8015e0:	e8 ee 02 00 00       	call   8018d3 <sys_allocateMem>
  8015e5:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8015e8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015f0:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8015f7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015fc:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801602:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801609:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80160e:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801615:	01 00 00 00 
				sizeofarray++;
  801619:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80161e:	40                   	inc    %eax
  80161f:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801624:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  80162c:	90                   	nop
  80162d:	5d                   	pop    %ebp
  80162e:	c3                   	ret    

0080162f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80162f:	55                   	push   %ebp
  801630:	89 e5                	mov    %esp,%ebp
  801632:	83 ec 18             	sub    $0x18,%esp
  801635:	8b 45 10             	mov    0x10(%ebp),%eax
  801638:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80163b:	83 ec 04             	sub    $0x4,%esp
  80163e:	68 50 28 80 00       	push   $0x802850
  801643:	68 8d 00 00 00       	push   $0x8d
  801648:	68 73 28 80 00       	push   $0x802873
  80164d:	e8 9b ed ff ff       	call   8003ed <_panic>

00801652 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
  801655:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801658:	83 ec 04             	sub    $0x4,%esp
  80165b:	68 50 28 80 00       	push   $0x802850
  801660:	68 93 00 00 00       	push   $0x93
  801665:	68 73 28 80 00       	push   $0x802873
  80166a:	e8 7e ed ff ff       	call   8003ed <_panic>

0080166f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
  801672:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801675:	83 ec 04             	sub    $0x4,%esp
  801678:	68 50 28 80 00       	push   $0x802850
  80167d:	68 99 00 00 00       	push   $0x99
  801682:	68 73 28 80 00       	push   $0x802873
  801687:	e8 61 ed ff ff       	call   8003ed <_panic>

0080168c <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
  80168f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801692:	83 ec 04             	sub    $0x4,%esp
  801695:	68 50 28 80 00       	push   $0x802850
  80169a:	68 9e 00 00 00       	push   $0x9e
  80169f:	68 73 28 80 00       	push   $0x802873
  8016a4:	e8 44 ed ff ff       	call   8003ed <_panic>

008016a9 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
  8016ac:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016af:	83 ec 04             	sub    $0x4,%esp
  8016b2:	68 50 28 80 00       	push   $0x802850
  8016b7:	68 a4 00 00 00       	push   $0xa4
  8016bc:	68 73 28 80 00       	push   $0x802873
  8016c1:	e8 27 ed ff ff       	call   8003ed <_panic>

008016c6 <shrink>:
}
void shrink(uint32 newSize)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
  8016c9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016cc:	83 ec 04             	sub    $0x4,%esp
  8016cf:	68 50 28 80 00       	push   $0x802850
  8016d4:	68 a8 00 00 00       	push   $0xa8
  8016d9:	68 73 28 80 00       	push   $0x802873
  8016de:	e8 0a ed ff ff       	call   8003ed <_panic>

008016e3 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
  8016e6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016e9:	83 ec 04             	sub    $0x4,%esp
  8016ec:	68 50 28 80 00       	push   $0x802850
  8016f1:	68 ad 00 00 00       	push   $0xad
  8016f6:	68 73 28 80 00       	push   $0x802873
  8016fb:	e8 ed ec ff ff       	call   8003ed <_panic>

00801700 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801700:	55                   	push   %ebp
  801701:	89 e5                	mov    %esp,%ebp
  801703:	57                   	push   %edi
  801704:	56                   	push   %esi
  801705:	53                   	push   %ebx
  801706:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801712:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801715:	8b 7d 18             	mov    0x18(%ebp),%edi
  801718:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80171b:	cd 30                	int    $0x30
  80171d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801720:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801723:	83 c4 10             	add    $0x10,%esp
  801726:	5b                   	pop    %ebx
  801727:	5e                   	pop    %esi
  801728:	5f                   	pop    %edi
  801729:	5d                   	pop    %ebp
  80172a:	c3                   	ret    

0080172b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
  80172e:	83 ec 04             	sub    $0x4,%esp
  801731:	8b 45 10             	mov    0x10(%ebp),%eax
  801734:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801737:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	52                   	push   %edx
  801743:	ff 75 0c             	pushl  0xc(%ebp)
  801746:	50                   	push   %eax
  801747:	6a 00                	push   $0x0
  801749:	e8 b2 ff ff ff       	call   801700 <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
}
  801751:	90                   	nop
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <sys_cgetc>:

int
sys_cgetc(void)
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 01                	push   $0x1
  801763:	e8 98 ff ff ff       	call   801700 <syscall>
  801768:	83 c4 18             	add    $0x18,%esp
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	50                   	push   %eax
  80177c:	6a 05                	push   $0x5
  80177e:	e8 7d ff ff ff       	call   801700 <syscall>
  801783:	83 c4 18             	add    $0x18,%esp
}
  801786:	c9                   	leave  
  801787:	c3                   	ret    

00801788 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801788:	55                   	push   %ebp
  801789:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 02                	push   $0x2
  801797:	e8 64 ff ff ff       	call   801700 <syscall>
  80179c:	83 c4 18             	add    $0x18,%esp
}
  80179f:	c9                   	leave  
  8017a0:	c3                   	ret    

008017a1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017a1:	55                   	push   %ebp
  8017a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 03                	push   $0x3
  8017b0:	e8 4b ff ff ff       	call   801700 <syscall>
  8017b5:	83 c4 18             	add    $0x18,%esp
}
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 04                	push   $0x4
  8017c9:	e8 32 ff ff ff       	call   801700 <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
}
  8017d1:	c9                   	leave  
  8017d2:	c3                   	ret    

008017d3 <sys_env_exit>:


void sys_env_exit(void)
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 06                	push   $0x6
  8017e2:	e8 19 ff ff ff       	call   801700 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	90                   	nop
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	52                   	push   %edx
  8017fd:	50                   	push   %eax
  8017fe:	6a 07                	push   $0x7
  801800:	e8 fb fe ff ff       	call   801700 <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
  80180d:	56                   	push   %esi
  80180e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80180f:	8b 75 18             	mov    0x18(%ebp),%esi
  801812:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801815:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801818:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181b:	8b 45 08             	mov    0x8(%ebp),%eax
  80181e:	56                   	push   %esi
  80181f:	53                   	push   %ebx
  801820:	51                   	push   %ecx
  801821:	52                   	push   %edx
  801822:	50                   	push   %eax
  801823:	6a 08                	push   $0x8
  801825:	e8 d6 fe ff ff       	call   801700 <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
}
  80182d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801830:	5b                   	pop    %ebx
  801831:	5e                   	pop    %esi
  801832:	5d                   	pop    %ebp
  801833:	c3                   	ret    

00801834 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801837:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	52                   	push   %edx
  801844:	50                   	push   %eax
  801845:	6a 09                	push   $0x9
  801847:	e8 b4 fe ff ff       	call   801700 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	ff 75 0c             	pushl  0xc(%ebp)
  80185d:	ff 75 08             	pushl  0x8(%ebp)
  801860:	6a 0a                	push   $0xa
  801862:	e8 99 fe ff ff       	call   801700 <syscall>
  801867:	83 c4 18             	add    $0x18,%esp
}
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 0b                	push   $0xb
  80187b:	e8 80 fe ff ff       	call   801700 <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 0c                	push   $0xc
  801894:	e8 67 fe ff ff       	call   801700 <syscall>
  801899:	83 c4 18             	add    $0x18,%esp
}
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 0d                	push   $0xd
  8018ad:	e8 4e fe ff ff       	call   801700 <syscall>
  8018b2:	83 c4 18             	add    $0x18,%esp
}
  8018b5:	c9                   	leave  
  8018b6:	c3                   	ret    

008018b7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018b7:	55                   	push   %ebp
  8018b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	ff 75 0c             	pushl  0xc(%ebp)
  8018c3:	ff 75 08             	pushl  0x8(%ebp)
  8018c6:	6a 11                	push   $0x11
  8018c8:	e8 33 fe ff ff       	call   801700 <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
	return;
  8018d0:	90                   	nop
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	ff 75 0c             	pushl  0xc(%ebp)
  8018df:	ff 75 08             	pushl  0x8(%ebp)
  8018e2:	6a 12                	push   $0x12
  8018e4:	e8 17 fe ff ff       	call   801700 <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ec:	90                   	nop
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 0e                	push   $0xe
  8018fe:	e8 fd fd ff ff       	call   801700 <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	ff 75 08             	pushl  0x8(%ebp)
  801916:	6a 0f                	push   $0xf
  801918:	e8 e3 fd ff ff       	call   801700 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 10                	push   $0x10
  801931:	e8 ca fd ff ff       	call   801700 <syscall>
  801936:	83 c4 18             	add    $0x18,%esp
}
  801939:	90                   	nop
  80193a:	c9                   	leave  
  80193b:	c3                   	ret    

0080193c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80193c:	55                   	push   %ebp
  80193d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 14                	push   $0x14
  80194b:	e8 b0 fd ff ff       	call   801700 <syscall>
  801950:	83 c4 18             	add    $0x18,%esp
}
  801953:	90                   	nop
  801954:	c9                   	leave  
  801955:	c3                   	ret    

00801956 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801956:	55                   	push   %ebp
  801957:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 15                	push   $0x15
  801965:	e8 96 fd ff ff       	call   801700 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	90                   	nop
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_cputc>:


void
sys_cputc(const char c)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
  801973:	83 ec 04             	sub    $0x4,%esp
  801976:	8b 45 08             	mov    0x8(%ebp),%eax
  801979:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80197c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	50                   	push   %eax
  801989:	6a 16                	push   $0x16
  80198b:	e8 70 fd ff ff       	call   801700 <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
}
  801993:	90                   	nop
  801994:	c9                   	leave  
  801995:	c3                   	ret    

00801996 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801996:	55                   	push   %ebp
  801997:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 17                	push   $0x17
  8019a5:	e8 56 fd ff ff       	call   801700 <syscall>
  8019aa:	83 c4 18             	add    $0x18,%esp
}
  8019ad:	90                   	nop
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	ff 75 0c             	pushl  0xc(%ebp)
  8019bf:	50                   	push   %eax
  8019c0:	6a 18                	push   $0x18
  8019c2:	e8 39 fd ff ff       	call   801700 <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
}
  8019ca:	c9                   	leave  
  8019cb:	c3                   	ret    

008019cc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019cc:	55                   	push   %ebp
  8019cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	52                   	push   %edx
  8019dc:	50                   	push   %eax
  8019dd:	6a 1b                	push   $0x1b
  8019df:	e8 1c fd ff ff       	call   801700 <syscall>
  8019e4:	83 c4 18             	add    $0x18,%esp
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	52                   	push   %edx
  8019f9:	50                   	push   %eax
  8019fa:	6a 19                	push   $0x19
  8019fc:	e8 ff fc ff ff       	call   801700 <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
}
  801a04:	90                   	nop
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    

00801a07 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	52                   	push   %edx
  801a17:	50                   	push   %eax
  801a18:	6a 1a                	push   $0x1a
  801a1a:	e8 e1 fc ff ff       	call   801700 <syscall>
  801a1f:	83 c4 18             	add    $0x18,%esp
}
  801a22:	90                   	nop
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
  801a28:	83 ec 04             	sub    $0x4,%esp
  801a2b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a31:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a34:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a38:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3b:	6a 00                	push   $0x0
  801a3d:	51                   	push   %ecx
  801a3e:	52                   	push   %edx
  801a3f:	ff 75 0c             	pushl  0xc(%ebp)
  801a42:	50                   	push   %eax
  801a43:	6a 1c                	push   $0x1c
  801a45:	e8 b6 fc ff ff       	call   801700 <syscall>
  801a4a:	83 c4 18             	add    $0x18,%esp
}
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a55:	8b 45 08             	mov    0x8(%ebp),%eax
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	52                   	push   %edx
  801a5f:	50                   	push   %eax
  801a60:	6a 1d                	push   $0x1d
  801a62:	e8 99 fc ff ff       	call   801700 <syscall>
  801a67:	83 c4 18             	add    $0x18,%esp
}
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a6f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a72:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a75:	8b 45 08             	mov    0x8(%ebp),%eax
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	51                   	push   %ecx
  801a7d:	52                   	push   %edx
  801a7e:	50                   	push   %eax
  801a7f:	6a 1e                	push   $0x1e
  801a81:	e8 7a fc ff ff       	call   801700 <syscall>
  801a86:	83 c4 18             	add    $0x18,%esp
}
  801a89:	c9                   	leave  
  801a8a:	c3                   	ret    

00801a8b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a8b:	55                   	push   %ebp
  801a8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a91:	8b 45 08             	mov    0x8(%ebp),%eax
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	52                   	push   %edx
  801a9b:	50                   	push   %eax
  801a9c:	6a 1f                	push   $0x1f
  801a9e:	e8 5d fc ff ff       	call   801700 <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 20                	push   $0x20
  801ab7:	e8 44 fc ff ff       	call   801700 <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
}
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	6a 00                	push   $0x0
  801ac9:	ff 75 14             	pushl  0x14(%ebp)
  801acc:	ff 75 10             	pushl  0x10(%ebp)
  801acf:	ff 75 0c             	pushl  0xc(%ebp)
  801ad2:	50                   	push   %eax
  801ad3:	6a 21                	push   $0x21
  801ad5:	e8 26 fc ff ff       	call   801700 <syscall>
  801ada:	83 c4 18             	add    $0x18,%esp
}
  801add:	c9                   	leave  
  801ade:	c3                   	ret    

00801adf <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801adf:	55                   	push   %ebp
  801ae0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	50                   	push   %eax
  801aee:	6a 22                	push   $0x22
  801af0:	e8 0b fc ff ff       	call   801700 <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	90                   	nop
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801afe:	8b 45 08             	mov    0x8(%ebp),%eax
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	50                   	push   %eax
  801b0a:	6a 23                	push   $0x23
  801b0c:	e8 ef fb ff ff       	call   801700 <syscall>
  801b11:	83 c4 18             	add    $0x18,%esp
}
  801b14:	90                   	nop
  801b15:	c9                   	leave  
  801b16:	c3                   	ret    

00801b17 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
  801b1a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b1d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b20:	8d 50 04             	lea    0x4(%eax),%edx
  801b23:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	52                   	push   %edx
  801b2d:	50                   	push   %eax
  801b2e:	6a 24                	push   $0x24
  801b30:	e8 cb fb ff ff       	call   801700 <syscall>
  801b35:	83 c4 18             	add    $0x18,%esp
	return result;
  801b38:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b3e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b41:	89 01                	mov    %eax,(%ecx)
  801b43:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b46:	8b 45 08             	mov    0x8(%ebp),%eax
  801b49:	c9                   	leave  
  801b4a:	c2 04 00             	ret    $0x4

00801b4d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	ff 75 10             	pushl  0x10(%ebp)
  801b57:	ff 75 0c             	pushl  0xc(%ebp)
  801b5a:	ff 75 08             	pushl  0x8(%ebp)
  801b5d:	6a 13                	push   $0x13
  801b5f:	e8 9c fb ff ff       	call   801700 <syscall>
  801b64:	83 c4 18             	add    $0x18,%esp
	return ;
  801b67:	90                   	nop
}
  801b68:	c9                   	leave  
  801b69:	c3                   	ret    

00801b6a <sys_rcr2>:
uint32 sys_rcr2()
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 25                	push   $0x25
  801b79:	e8 82 fb ff ff       	call   801700 <syscall>
  801b7e:	83 c4 18             	add    $0x18,%esp
}
  801b81:	c9                   	leave  
  801b82:	c3                   	ret    

00801b83 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b83:	55                   	push   %ebp
  801b84:	89 e5                	mov    %esp,%ebp
  801b86:	83 ec 04             	sub    $0x4,%esp
  801b89:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b8f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	50                   	push   %eax
  801b9c:	6a 26                	push   $0x26
  801b9e:	e8 5d fb ff ff       	call   801700 <syscall>
  801ba3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba6:	90                   	nop
}
  801ba7:	c9                   	leave  
  801ba8:	c3                   	ret    

00801ba9 <rsttst>:
void rsttst()
{
  801ba9:	55                   	push   %ebp
  801baa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 28                	push   $0x28
  801bb8:	e8 43 fb ff ff       	call   801700 <syscall>
  801bbd:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc0:	90                   	nop
}
  801bc1:	c9                   	leave  
  801bc2:	c3                   	ret    

00801bc3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bc3:	55                   	push   %ebp
  801bc4:	89 e5                	mov    %esp,%ebp
  801bc6:	83 ec 04             	sub    $0x4,%esp
  801bc9:	8b 45 14             	mov    0x14(%ebp),%eax
  801bcc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bcf:	8b 55 18             	mov    0x18(%ebp),%edx
  801bd2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bd6:	52                   	push   %edx
  801bd7:	50                   	push   %eax
  801bd8:	ff 75 10             	pushl  0x10(%ebp)
  801bdb:	ff 75 0c             	pushl  0xc(%ebp)
  801bde:	ff 75 08             	pushl  0x8(%ebp)
  801be1:	6a 27                	push   $0x27
  801be3:	e8 18 fb ff ff       	call   801700 <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
	return ;
  801beb:	90                   	nop
}
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <chktst>:
void chktst(uint32 n)
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	ff 75 08             	pushl  0x8(%ebp)
  801bfc:	6a 29                	push   $0x29
  801bfe:	e8 fd fa ff ff       	call   801700 <syscall>
  801c03:	83 c4 18             	add    $0x18,%esp
	return ;
  801c06:	90                   	nop
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <inctst>:

void inctst()
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 2a                	push   $0x2a
  801c18:	e8 e3 fa ff ff       	call   801700 <syscall>
  801c1d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c20:	90                   	nop
}
  801c21:	c9                   	leave  
  801c22:	c3                   	ret    

00801c23 <gettst>:
uint32 gettst()
{
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 2b                	push   $0x2b
  801c32:	e8 c9 fa ff ff       	call   801700 <syscall>
  801c37:	83 c4 18             	add    $0x18,%esp
}
  801c3a:	c9                   	leave  
  801c3b:	c3                   	ret    

00801c3c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c3c:	55                   	push   %ebp
  801c3d:	89 e5                	mov    %esp,%ebp
  801c3f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 2c                	push   $0x2c
  801c4e:	e8 ad fa ff ff       	call   801700 <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
  801c56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c59:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c5d:	75 07                	jne    801c66 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c5f:	b8 01 00 00 00       	mov    $0x1,%eax
  801c64:	eb 05                	jmp    801c6b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c66:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
  801c70:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 2c                	push   $0x2c
  801c7f:	e8 7c fa ff ff       	call   801700 <syscall>
  801c84:	83 c4 18             	add    $0x18,%esp
  801c87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c8a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c8e:	75 07                	jne    801c97 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c90:	b8 01 00 00 00       	mov    $0x1,%eax
  801c95:	eb 05                	jmp    801c9c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c97:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
  801ca1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 2c                	push   $0x2c
  801cb0:	e8 4b fa ff ff       	call   801700 <syscall>
  801cb5:	83 c4 18             	add    $0x18,%esp
  801cb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cbb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cbf:	75 07                	jne    801cc8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cc1:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc6:	eb 05                	jmp    801ccd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cc8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ccd:	c9                   	leave  
  801cce:	c3                   	ret    

00801ccf <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
  801cd2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 2c                	push   $0x2c
  801ce1:	e8 1a fa ff ff       	call   801700 <syscall>
  801ce6:	83 c4 18             	add    $0x18,%esp
  801ce9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cec:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cf0:	75 07                	jne    801cf9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cf2:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf7:	eb 05                	jmp    801cfe <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cf9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cfe:	c9                   	leave  
  801cff:	c3                   	ret    

00801d00 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d00:	55                   	push   %ebp
  801d01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	ff 75 08             	pushl  0x8(%ebp)
  801d0e:	6a 2d                	push   $0x2d
  801d10:	e8 eb f9 ff ff       	call   801700 <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
	return ;
  801d18:	90                   	nop
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
  801d1e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d1f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d22:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d25:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d28:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2b:	6a 00                	push   $0x0
  801d2d:	53                   	push   %ebx
  801d2e:	51                   	push   %ecx
  801d2f:	52                   	push   %edx
  801d30:	50                   	push   %eax
  801d31:	6a 2e                	push   $0x2e
  801d33:	e8 c8 f9 ff ff       	call   801700 <syscall>
  801d38:	83 c4 18             	add    $0x18,%esp
}
  801d3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d3e:	c9                   	leave  
  801d3f:	c3                   	ret    

00801d40 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d40:	55                   	push   %ebp
  801d41:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d43:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d46:	8b 45 08             	mov    0x8(%ebp),%eax
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	52                   	push   %edx
  801d50:	50                   	push   %eax
  801d51:	6a 2f                	push   $0x2f
  801d53:	e8 a8 f9 ff ff       	call   801700 <syscall>
  801d58:	83 c4 18             	add    $0x18,%esp
}
  801d5b:	c9                   	leave  
  801d5c:	c3                   	ret    
  801d5d:	66 90                	xchg   %ax,%ax
  801d5f:	90                   	nop

00801d60 <__udivdi3>:
  801d60:	55                   	push   %ebp
  801d61:	57                   	push   %edi
  801d62:	56                   	push   %esi
  801d63:	53                   	push   %ebx
  801d64:	83 ec 1c             	sub    $0x1c,%esp
  801d67:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d6b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d73:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d77:	89 ca                	mov    %ecx,%edx
  801d79:	89 f8                	mov    %edi,%eax
  801d7b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d7f:	85 f6                	test   %esi,%esi
  801d81:	75 2d                	jne    801db0 <__udivdi3+0x50>
  801d83:	39 cf                	cmp    %ecx,%edi
  801d85:	77 65                	ja     801dec <__udivdi3+0x8c>
  801d87:	89 fd                	mov    %edi,%ebp
  801d89:	85 ff                	test   %edi,%edi
  801d8b:	75 0b                	jne    801d98 <__udivdi3+0x38>
  801d8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d92:	31 d2                	xor    %edx,%edx
  801d94:	f7 f7                	div    %edi
  801d96:	89 c5                	mov    %eax,%ebp
  801d98:	31 d2                	xor    %edx,%edx
  801d9a:	89 c8                	mov    %ecx,%eax
  801d9c:	f7 f5                	div    %ebp
  801d9e:	89 c1                	mov    %eax,%ecx
  801da0:	89 d8                	mov    %ebx,%eax
  801da2:	f7 f5                	div    %ebp
  801da4:	89 cf                	mov    %ecx,%edi
  801da6:	89 fa                	mov    %edi,%edx
  801da8:	83 c4 1c             	add    $0x1c,%esp
  801dab:	5b                   	pop    %ebx
  801dac:	5e                   	pop    %esi
  801dad:	5f                   	pop    %edi
  801dae:	5d                   	pop    %ebp
  801daf:	c3                   	ret    
  801db0:	39 ce                	cmp    %ecx,%esi
  801db2:	77 28                	ja     801ddc <__udivdi3+0x7c>
  801db4:	0f bd fe             	bsr    %esi,%edi
  801db7:	83 f7 1f             	xor    $0x1f,%edi
  801dba:	75 40                	jne    801dfc <__udivdi3+0x9c>
  801dbc:	39 ce                	cmp    %ecx,%esi
  801dbe:	72 0a                	jb     801dca <__udivdi3+0x6a>
  801dc0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801dc4:	0f 87 9e 00 00 00    	ja     801e68 <__udivdi3+0x108>
  801dca:	b8 01 00 00 00       	mov    $0x1,%eax
  801dcf:	89 fa                	mov    %edi,%edx
  801dd1:	83 c4 1c             	add    $0x1c,%esp
  801dd4:	5b                   	pop    %ebx
  801dd5:	5e                   	pop    %esi
  801dd6:	5f                   	pop    %edi
  801dd7:	5d                   	pop    %ebp
  801dd8:	c3                   	ret    
  801dd9:	8d 76 00             	lea    0x0(%esi),%esi
  801ddc:	31 ff                	xor    %edi,%edi
  801dde:	31 c0                	xor    %eax,%eax
  801de0:	89 fa                	mov    %edi,%edx
  801de2:	83 c4 1c             	add    $0x1c,%esp
  801de5:	5b                   	pop    %ebx
  801de6:	5e                   	pop    %esi
  801de7:	5f                   	pop    %edi
  801de8:	5d                   	pop    %ebp
  801de9:	c3                   	ret    
  801dea:	66 90                	xchg   %ax,%ax
  801dec:	89 d8                	mov    %ebx,%eax
  801dee:	f7 f7                	div    %edi
  801df0:	31 ff                	xor    %edi,%edi
  801df2:	89 fa                	mov    %edi,%edx
  801df4:	83 c4 1c             	add    $0x1c,%esp
  801df7:	5b                   	pop    %ebx
  801df8:	5e                   	pop    %esi
  801df9:	5f                   	pop    %edi
  801dfa:	5d                   	pop    %ebp
  801dfb:	c3                   	ret    
  801dfc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e01:	89 eb                	mov    %ebp,%ebx
  801e03:	29 fb                	sub    %edi,%ebx
  801e05:	89 f9                	mov    %edi,%ecx
  801e07:	d3 e6                	shl    %cl,%esi
  801e09:	89 c5                	mov    %eax,%ebp
  801e0b:	88 d9                	mov    %bl,%cl
  801e0d:	d3 ed                	shr    %cl,%ebp
  801e0f:	89 e9                	mov    %ebp,%ecx
  801e11:	09 f1                	or     %esi,%ecx
  801e13:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e17:	89 f9                	mov    %edi,%ecx
  801e19:	d3 e0                	shl    %cl,%eax
  801e1b:	89 c5                	mov    %eax,%ebp
  801e1d:	89 d6                	mov    %edx,%esi
  801e1f:	88 d9                	mov    %bl,%cl
  801e21:	d3 ee                	shr    %cl,%esi
  801e23:	89 f9                	mov    %edi,%ecx
  801e25:	d3 e2                	shl    %cl,%edx
  801e27:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e2b:	88 d9                	mov    %bl,%cl
  801e2d:	d3 e8                	shr    %cl,%eax
  801e2f:	09 c2                	or     %eax,%edx
  801e31:	89 d0                	mov    %edx,%eax
  801e33:	89 f2                	mov    %esi,%edx
  801e35:	f7 74 24 0c          	divl   0xc(%esp)
  801e39:	89 d6                	mov    %edx,%esi
  801e3b:	89 c3                	mov    %eax,%ebx
  801e3d:	f7 e5                	mul    %ebp
  801e3f:	39 d6                	cmp    %edx,%esi
  801e41:	72 19                	jb     801e5c <__udivdi3+0xfc>
  801e43:	74 0b                	je     801e50 <__udivdi3+0xf0>
  801e45:	89 d8                	mov    %ebx,%eax
  801e47:	31 ff                	xor    %edi,%edi
  801e49:	e9 58 ff ff ff       	jmp    801da6 <__udivdi3+0x46>
  801e4e:	66 90                	xchg   %ax,%ax
  801e50:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e54:	89 f9                	mov    %edi,%ecx
  801e56:	d3 e2                	shl    %cl,%edx
  801e58:	39 c2                	cmp    %eax,%edx
  801e5a:	73 e9                	jae    801e45 <__udivdi3+0xe5>
  801e5c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e5f:	31 ff                	xor    %edi,%edi
  801e61:	e9 40 ff ff ff       	jmp    801da6 <__udivdi3+0x46>
  801e66:	66 90                	xchg   %ax,%ax
  801e68:	31 c0                	xor    %eax,%eax
  801e6a:	e9 37 ff ff ff       	jmp    801da6 <__udivdi3+0x46>
  801e6f:	90                   	nop

00801e70 <__umoddi3>:
  801e70:	55                   	push   %ebp
  801e71:	57                   	push   %edi
  801e72:	56                   	push   %esi
  801e73:	53                   	push   %ebx
  801e74:	83 ec 1c             	sub    $0x1c,%esp
  801e77:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e7b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e7f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e83:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e87:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e8b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e8f:	89 f3                	mov    %esi,%ebx
  801e91:	89 fa                	mov    %edi,%edx
  801e93:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e97:	89 34 24             	mov    %esi,(%esp)
  801e9a:	85 c0                	test   %eax,%eax
  801e9c:	75 1a                	jne    801eb8 <__umoddi3+0x48>
  801e9e:	39 f7                	cmp    %esi,%edi
  801ea0:	0f 86 a2 00 00 00    	jbe    801f48 <__umoddi3+0xd8>
  801ea6:	89 c8                	mov    %ecx,%eax
  801ea8:	89 f2                	mov    %esi,%edx
  801eaa:	f7 f7                	div    %edi
  801eac:	89 d0                	mov    %edx,%eax
  801eae:	31 d2                	xor    %edx,%edx
  801eb0:	83 c4 1c             	add    $0x1c,%esp
  801eb3:	5b                   	pop    %ebx
  801eb4:	5e                   	pop    %esi
  801eb5:	5f                   	pop    %edi
  801eb6:	5d                   	pop    %ebp
  801eb7:	c3                   	ret    
  801eb8:	39 f0                	cmp    %esi,%eax
  801eba:	0f 87 ac 00 00 00    	ja     801f6c <__umoddi3+0xfc>
  801ec0:	0f bd e8             	bsr    %eax,%ebp
  801ec3:	83 f5 1f             	xor    $0x1f,%ebp
  801ec6:	0f 84 ac 00 00 00    	je     801f78 <__umoddi3+0x108>
  801ecc:	bf 20 00 00 00       	mov    $0x20,%edi
  801ed1:	29 ef                	sub    %ebp,%edi
  801ed3:	89 fe                	mov    %edi,%esi
  801ed5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ed9:	89 e9                	mov    %ebp,%ecx
  801edb:	d3 e0                	shl    %cl,%eax
  801edd:	89 d7                	mov    %edx,%edi
  801edf:	89 f1                	mov    %esi,%ecx
  801ee1:	d3 ef                	shr    %cl,%edi
  801ee3:	09 c7                	or     %eax,%edi
  801ee5:	89 e9                	mov    %ebp,%ecx
  801ee7:	d3 e2                	shl    %cl,%edx
  801ee9:	89 14 24             	mov    %edx,(%esp)
  801eec:	89 d8                	mov    %ebx,%eax
  801eee:	d3 e0                	shl    %cl,%eax
  801ef0:	89 c2                	mov    %eax,%edx
  801ef2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ef6:	d3 e0                	shl    %cl,%eax
  801ef8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801efc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f00:	89 f1                	mov    %esi,%ecx
  801f02:	d3 e8                	shr    %cl,%eax
  801f04:	09 d0                	or     %edx,%eax
  801f06:	d3 eb                	shr    %cl,%ebx
  801f08:	89 da                	mov    %ebx,%edx
  801f0a:	f7 f7                	div    %edi
  801f0c:	89 d3                	mov    %edx,%ebx
  801f0e:	f7 24 24             	mull   (%esp)
  801f11:	89 c6                	mov    %eax,%esi
  801f13:	89 d1                	mov    %edx,%ecx
  801f15:	39 d3                	cmp    %edx,%ebx
  801f17:	0f 82 87 00 00 00    	jb     801fa4 <__umoddi3+0x134>
  801f1d:	0f 84 91 00 00 00    	je     801fb4 <__umoddi3+0x144>
  801f23:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f27:	29 f2                	sub    %esi,%edx
  801f29:	19 cb                	sbb    %ecx,%ebx
  801f2b:	89 d8                	mov    %ebx,%eax
  801f2d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f31:	d3 e0                	shl    %cl,%eax
  801f33:	89 e9                	mov    %ebp,%ecx
  801f35:	d3 ea                	shr    %cl,%edx
  801f37:	09 d0                	or     %edx,%eax
  801f39:	89 e9                	mov    %ebp,%ecx
  801f3b:	d3 eb                	shr    %cl,%ebx
  801f3d:	89 da                	mov    %ebx,%edx
  801f3f:	83 c4 1c             	add    $0x1c,%esp
  801f42:	5b                   	pop    %ebx
  801f43:	5e                   	pop    %esi
  801f44:	5f                   	pop    %edi
  801f45:	5d                   	pop    %ebp
  801f46:	c3                   	ret    
  801f47:	90                   	nop
  801f48:	89 fd                	mov    %edi,%ebp
  801f4a:	85 ff                	test   %edi,%edi
  801f4c:	75 0b                	jne    801f59 <__umoddi3+0xe9>
  801f4e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f53:	31 d2                	xor    %edx,%edx
  801f55:	f7 f7                	div    %edi
  801f57:	89 c5                	mov    %eax,%ebp
  801f59:	89 f0                	mov    %esi,%eax
  801f5b:	31 d2                	xor    %edx,%edx
  801f5d:	f7 f5                	div    %ebp
  801f5f:	89 c8                	mov    %ecx,%eax
  801f61:	f7 f5                	div    %ebp
  801f63:	89 d0                	mov    %edx,%eax
  801f65:	e9 44 ff ff ff       	jmp    801eae <__umoddi3+0x3e>
  801f6a:	66 90                	xchg   %ax,%ax
  801f6c:	89 c8                	mov    %ecx,%eax
  801f6e:	89 f2                	mov    %esi,%edx
  801f70:	83 c4 1c             	add    $0x1c,%esp
  801f73:	5b                   	pop    %ebx
  801f74:	5e                   	pop    %esi
  801f75:	5f                   	pop    %edi
  801f76:	5d                   	pop    %ebp
  801f77:	c3                   	ret    
  801f78:	3b 04 24             	cmp    (%esp),%eax
  801f7b:	72 06                	jb     801f83 <__umoddi3+0x113>
  801f7d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f81:	77 0f                	ja     801f92 <__umoddi3+0x122>
  801f83:	89 f2                	mov    %esi,%edx
  801f85:	29 f9                	sub    %edi,%ecx
  801f87:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f8b:	89 14 24             	mov    %edx,(%esp)
  801f8e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f92:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f96:	8b 14 24             	mov    (%esp),%edx
  801f99:	83 c4 1c             	add    $0x1c,%esp
  801f9c:	5b                   	pop    %ebx
  801f9d:	5e                   	pop    %esi
  801f9e:	5f                   	pop    %edi
  801f9f:	5d                   	pop    %ebp
  801fa0:	c3                   	ret    
  801fa1:	8d 76 00             	lea    0x0(%esi),%esi
  801fa4:	2b 04 24             	sub    (%esp),%eax
  801fa7:	19 fa                	sbb    %edi,%edx
  801fa9:	89 d1                	mov    %edx,%ecx
  801fab:	89 c6                	mov    %eax,%esi
  801fad:	e9 71 ff ff ff       	jmp    801f23 <__umoddi3+0xb3>
  801fb2:	66 90                	xchg   %ax,%ax
  801fb4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fb8:	72 ea                	jb     801fa4 <__umoddi3+0x134>
  801fba:	89 d9                	mov    %ebx,%ecx
  801fbc:	e9 62 ff ff ff       	jmp    801f23 <__umoddi3+0xb3>
