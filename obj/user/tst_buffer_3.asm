
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
  80004d:	e8 65 19 00 00       	call   8019b7 <sys_calculate_free_frames>
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
  80007b:	e8 37 19 00 00       	call   8019b7 <sys_calculate_free_frames>
  800080:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int modFrames = sys_calculate_modified_frames();
  800083:	e8 48 19 00 00       	call   8019d0 <sys_calculate_modified_frames>
  800088:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		cprintf("all frames AFTER malloc = %d\n", freeFrames + modFrames);
  80008b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80008e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800091:	01 d0                	add    %edx,%eax
  800093:	83 ec 08             	sub    $0x8,%esp
  800096:	50                   	push   %eax
  800097:	68 20 21 80 00       	push   $0x802120
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
  80015c:	e8 80 15 00 00       	call   8016e1 <free>
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
  8001cd:	68 40 21 80 00       	push   $0x802140
  8001d2:	6a 4e                	push   $0x4e
  8001d4:	68 6e 21 80 00       	push   $0x80216e
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
  8001f0:	e8 c2 17 00 00       	call   8019b7 <sys_calculate_free_frames>
  8001f5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int mod_frames = sys_calculate_modified_frames();
  8001f8:	e8 d3 17 00 00       	call   8019d0 <sys_calculate_modified_frames>
  8001fd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((sys_calculate_modified_frames() + sys_calculate_free_frames() - numOFEmptyLocInWS) - (modFrames + freeFrames) != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
  800200:	e8 cb 17 00 00       	call   8019d0 <sys_calculate_modified_frames>
  800205:	89 c3                	mov    %eax,%ebx
  800207:	e8 ab 17 00 00       	call   8019b7 <sys_calculate_free_frames>
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
  800225:	68 84 21 80 00       	push   $0x802184
  80022a:	6a 53                	push   $0x53
  80022c:	68 6e 21 80 00       	push   $0x80216e
  800231:	e8 b7 01 00 00       	call   8003ed <_panic>
		//if (sys_calculate_modified_frames() != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
		//if (sys_calculate_notmod_frames() != 7) panic("FreeMem didn't remove all un-modified frames in the given range from the free frame list");

		//if (sys_calculate_free_frames() - freeFrames != 3) panic("FreeMem didn't UN-BUFFER the removed BUFFERED frames in the given range.. (check updating of isBuffered");

		cprintf("Congratulations!! test of removing BUFFERED pages in freeHeap is completed successfully.\n");
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	68 d8 21 80 00       	push   $0x8021d8
  80023e:	e8 4c 04 00 00       	call   80068f <cprintf>
  800243:	83 c4 10             	add    $0x10,%esp

		//Try to access any of the removed buffered pages in the Heap [It's ILLEGAL ACCESS now]
		{
			cprintf("\nNow, trying to access the removed BUFFERED pages, you should make the kernel PANIC with ILLEGAL MEMORY ACCESS in page_fault_handler() since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK.\n\n\n");
  800246:	83 ec 0c             	sub    $0xc,%esp
  800249:	68 34 22 80 00       	push   $0x802234
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
  800297:	68 18 23 80 00       	push   $0x802318
  80029c:	6a 68                	push   $0x68
  80029e:	68 6e 21 80 00       	push   $0x80216e
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
  8002ae:	e8 39 16 00 00       	call   8018ec <sys_getenvindex>
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
  80032b:	e8 57 17 00 00       	call   801a87 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800330:	83 ec 0c             	sub    $0xc,%esp
  800333:	68 38 24 80 00       	push   $0x802438
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
  80035b:	68 60 24 80 00       	push   $0x802460
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
  800383:	68 88 24 80 00       	push   $0x802488
  800388:	e8 02 03 00 00       	call   80068f <cprintf>
  80038d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800390:	a1 20 30 80 00       	mov    0x803020,%eax
  800395:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80039b:	83 ec 08             	sub    $0x8,%esp
  80039e:	50                   	push   %eax
  80039f:	68 c9 24 80 00       	push   $0x8024c9
  8003a4:	e8 e6 02 00 00       	call   80068f <cprintf>
  8003a9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003ac:	83 ec 0c             	sub    $0xc,%esp
  8003af:	68 38 24 80 00       	push   $0x802438
  8003b4:	e8 d6 02 00 00       	call   80068f <cprintf>
  8003b9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003bc:	e8 e0 16 00 00       	call   801aa1 <sys_enable_interrupt>

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
  8003d4:	e8 df 14 00 00       	call   8018b8 <sys_env_destroy>
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
  8003e5:	e8 34 15 00 00       	call   80191e <sys_env_exit>
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
  80040e:	68 e0 24 80 00       	push   $0x8024e0
  800413:	e8 77 02 00 00       	call   80068f <cprintf>
  800418:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80041b:	a1 00 30 80 00       	mov    0x803000,%eax
  800420:	ff 75 0c             	pushl  0xc(%ebp)
  800423:	ff 75 08             	pushl  0x8(%ebp)
  800426:	50                   	push   %eax
  800427:	68 e5 24 80 00       	push   $0x8024e5
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
  80044b:	68 01 25 80 00       	push   $0x802501
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
  800477:	68 04 25 80 00       	push   $0x802504
  80047c:	6a 26                	push   $0x26
  80047e:	68 50 25 80 00       	push   $0x802550
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
  80053d:	68 5c 25 80 00       	push   $0x80255c
  800542:	6a 3a                	push   $0x3a
  800544:	68 50 25 80 00       	push   $0x802550
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
  8005a7:	68 b0 25 80 00       	push   $0x8025b0
  8005ac:	6a 44                	push   $0x44
  8005ae:	68 50 25 80 00       	push   $0x802550
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
  800601:	e8 70 12 00 00       	call   801876 <sys_cputs>
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
  800678:	e8 f9 11 00 00       	call   801876 <sys_cputs>
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
  8006c2:	e8 c0 13 00 00       	call   801a87 <sys_disable_interrupt>
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
  8006e2:	e8 ba 13 00 00       	call   801aa1 <sys_enable_interrupt>
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
  80072c:	e8 77 17 00 00       	call   801ea8 <__udivdi3>
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
  80077c:	e8 37 18 00 00       	call   801fb8 <__umoddi3>
  800781:	83 c4 10             	add    $0x10,%esp
  800784:	05 14 28 80 00       	add    $0x802814,%eax
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
  8008d7:	8b 04 85 38 28 80 00 	mov    0x802838(,%eax,4),%eax
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
  8009b8:	8b 34 9d 80 26 80 00 	mov    0x802680(,%ebx,4),%esi
  8009bf:	85 f6                	test   %esi,%esi
  8009c1:	75 19                	jne    8009dc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009c3:	53                   	push   %ebx
  8009c4:	68 25 28 80 00       	push   $0x802825
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
  8009dd:	68 2e 28 80 00       	push   $0x80282e
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
  800a0a:	be 31 28 80 00       	mov    $0x802831,%esi
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
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801419:	55                   	push   %ebp
  80141a:	89 e5                	mov    %esp,%ebp
  80141c:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80141f:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801426:	76 0a                	jbe    801432 <malloc+0x19>
		return NULL;
  801428:	b8 00 00 00 00       	mov    $0x0,%eax
  80142d:	e9 ad 02 00 00       	jmp    8016df <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	c1 e8 0c             	shr    $0xc,%eax
  801438:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	25 ff 0f 00 00       	and    $0xfff,%eax
  801443:	85 c0                	test   %eax,%eax
  801445:	74 03                	je     80144a <malloc+0x31>
		num++;
  801447:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  80144a:	a1 28 30 80 00       	mov    0x803028,%eax
  80144f:	85 c0                	test   %eax,%eax
  801451:	75 71                	jne    8014c4 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801453:	a1 04 30 80 00       	mov    0x803004,%eax
  801458:	83 ec 08             	sub    $0x8,%esp
  80145b:	ff 75 08             	pushl  0x8(%ebp)
  80145e:	50                   	push   %eax
  80145f:	e8 ba 05 00 00       	call   801a1e <sys_allocateMem>
  801464:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801467:	a1 04 30 80 00       	mov    0x803004,%eax
  80146c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  80146f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801472:	c1 e0 0c             	shl    $0xc,%eax
  801475:	89 c2                	mov    %eax,%edx
  801477:	a1 04 30 80 00       	mov    0x803004,%eax
  80147c:	01 d0                	add    %edx,%eax
  80147e:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801483:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801488:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80148b:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801492:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801497:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80149a:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  8014a1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014a6:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8014ad:	01 00 00 00 
		sizeofarray++;
  8014b1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014b6:	40                   	inc    %eax
  8014b7:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  8014bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8014bf:	e9 1b 02 00 00       	jmp    8016df <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8014c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8014cb:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8014d2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  8014d9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8014e0:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8014e7:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8014ee:	eb 72                	jmp    801562 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8014f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014f3:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8014fa:	85 c0                	test   %eax,%eax
  8014fc:	75 12                	jne    801510 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8014fe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801501:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801508:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  80150b:	ff 45 dc             	incl   -0x24(%ebp)
  80150e:	eb 4f                	jmp    80155f <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801510:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801513:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801516:	7d 39                	jge    801551 <malloc+0x138>
  801518:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80151b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80151e:	7c 31                	jl     801551 <malloc+0x138>
					{
						min=count;
  801520:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801523:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801526:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801529:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801530:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801533:	c1 e2 0c             	shl    $0xc,%edx
  801536:	29 d0                	sub    %edx,%eax
  801538:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  80153b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80153e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801541:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801544:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  80154b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80154e:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801551:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801558:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  80155f:	ff 45 d4             	incl   -0x2c(%ebp)
  801562:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801567:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  80156a:	7c 84                	jl     8014f0 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  80156c:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801570:	0f 85 e3 00 00 00    	jne    801659 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801576:	83 ec 08             	sub    $0x8,%esp
  801579:	ff 75 08             	pushl  0x8(%ebp)
  80157c:	ff 75 e0             	pushl  -0x20(%ebp)
  80157f:	e8 9a 04 00 00       	call   801a1e <sys_allocateMem>
  801584:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801587:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80158c:	40                   	inc    %eax
  80158d:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  801592:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801597:	48                   	dec    %eax
  801598:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80159b:	eb 42                	jmp    8015df <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  80159d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015a0:	48                   	dec    %eax
  8015a1:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  8015a8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015ab:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  8015b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015b5:	48                   	dec    %eax
  8015b6:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  8015bd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015c0:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  8015c7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015ca:	48                   	dec    %eax
  8015cb:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  8015d2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015d5:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  8015dc:	ff 4d d0             	decl   -0x30(%ebp)
  8015df:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015e2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015e5:	7f b6                	jg     80159d <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8015e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015ea:	40                   	inc    %eax
  8015eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8015ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8015f1:	01 ca                	add    %ecx,%edx
  8015f3:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8015fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015fd:	8d 50 01             	lea    0x1(%eax),%edx
  801600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801603:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  80160a:	2b 45 f4             	sub    -0xc(%ebp),%eax
  80160d:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801614:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801617:	40                   	inc    %eax
  801618:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  80161f:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801623:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801626:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801629:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801630:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801633:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801636:	eb 11                	jmp    801649 <malloc+0x230>
				{
					changed[index] = 1;
  801638:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80163b:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801642:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801646:	ff 45 cc             	incl   -0x34(%ebp)
  801649:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80164c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80164f:	7c e7                	jl     801638 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801651:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801654:	e9 86 00 00 00       	jmp    8016df <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801659:	a1 04 30 80 00       	mov    0x803004,%eax
  80165e:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801663:	29 c2                	sub    %eax,%edx
  801665:	89 d0                	mov    %edx,%eax
  801667:	3b 45 08             	cmp    0x8(%ebp),%eax
  80166a:	73 07                	jae    801673 <malloc+0x25a>
						return NULL;
  80166c:	b8 00 00 00 00       	mov    $0x0,%eax
  801671:	eb 6c                	jmp    8016df <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801673:	a1 04 30 80 00       	mov    0x803004,%eax
  801678:	83 ec 08             	sub    $0x8,%esp
  80167b:	ff 75 08             	pushl  0x8(%ebp)
  80167e:	50                   	push   %eax
  80167f:	e8 9a 03 00 00       	call   801a1e <sys_allocateMem>
  801684:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801687:	a1 04 30 80 00       	mov    0x803004,%eax
  80168c:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  80168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801692:	c1 e0 0c             	shl    $0xc,%eax
  801695:	89 c2                	mov    %eax,%edx
  801697:	a1 04 30 80 00       	mov    0x803004,%eax
  80169c:	01 d0                	add    %edx,%eax
  80169e:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  8016a3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016ab:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  8016b2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016b7:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8016ba:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  8016c1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016c6:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8016cd:	01 00 00 00 
					sizeofarray++;
  8016d1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016d6:	40                   	inc    %eax
  8016d7:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  8016dc:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8016df:	c9                   	leave  
  8016e0:	c3                   	ret    

008016e1 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8016e1:	55                   	push   %ebp
  8016e2:	89 e5                	mov    %esp,%ebp
  8016e4:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8016ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8016f4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8016fb:	eb 30                	jmp    80172d <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8016fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801700:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801707:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80170a:	75 1e                	jne    80172a <free+0x49>
  80170c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80170f:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801716:	83 f8 01             	cmp    $0x1,%eax
  801719:	75 0f                	jne    80172a <free+0x49>
			is_found = 1;
  80171b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801722:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801725:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801728:	eb 0d                	jmp    801737 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  80172a:	ff 45 ec             	incl   -0x14(%ebp)
  80172d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801732:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801735:	7c c6                	jl     8016fd <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801737:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  80173b:	75 3a                	jne    801777 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  80173d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801740:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801747:	c1 e0 0c             	shl    $0xc,%eax
  80174a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  80174d:	83 ec 08             	sub    $0x8,%esp
  801750:	ff 75 e4             	pushl  -0x1c(%ebp)
  801753:	ff 75 e8             	pushl  -0x18(%ebp)
  801756:	e8 a7 02 00 00       	call   801a02 <sys_freeMem>
  80175b:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  80175e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801761:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801768:	00 00 00 00 
		changes++;
  80176c:	a1 28 30 80 00       	mov    0x803028,%eax
  801771:	40                   	inc    %eax
  801772:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801777:	90                   	nop
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
  80177d:	83 ec 18             	sub    $0x18,%esp
  801780:	8b 45 10             	mov    0x10(%ebp),%eax
  801783:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801786:	83 ec 04             	sub    $0x4,%esp
  801789:	68 90 29 80 00       	push   $0x802990
  80178e:	68 b6 00 00 00       	push   $0xb6
  801793:	68 b3 29 80 00       	push   $0x8029b3
  801798:	e8 50 ec ff ff       	call   8003ed <_panic>

0080179d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
  8017a0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017a3:	83 ec 04             	sub    $0x4,%esp
  8017a6:	68 90 29 80 00       	push   $0x802990
  8017ab:	68 bb 00 00 00       	push   $0xbb
  8017b0:	68 b3 29 80 00       	push   $0x8029b3
  8017b5:	e8 33 ec ff ff       	call   8003ed <_panic>

008017ba <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
  8017bd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017c0:	83 ec 04             	sub    $0x4,%esp
  8017c3:	68 90 29 80 00       	push   $0x802990
  8017c8:	68 c0 00 00 00       	push   $0xc0
  8017cd:	68 b3 29 80 00       	push   $0x8029b3
  8017d2:	e8 16 ec ff ff       	call   8003ed <_panic>

008017d7 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017dd:	83 ec 04             	sub    $0x4,%esp
  8017e0:	68 90 29 80 00       	push   $0x802990
  8017e5:	68 c4 00 00 00       	push   $0xc4
  8017ea:	68 b3 29 80 00       	push   $0x8029b3
  8017ef:	e8 f9 eb ff ff       	call   8003ed <_panic>

008017f4 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017fa:	83 ec 04             	sub    $0x4,%esp
  8017fd:	68 90 29 80 00       	push   $0x802990
  801802:	68 c9 00 00 00       	push   $0xc9
  801807:	68 b3 29 80 00       	push   $0x8029b3
  80180c:	e8 dc eb ff ff       	call   8003ed <_panic>

00801811 <shrink>:
}
void shrink(uint32 newSize) {
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
  801814:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801817:	83 ec 04             	sub    $0x4,%esp
  80181a:	68 90 29 80 00       	push   $0x802990
  80181f:	68 cc 00 00 00       	push   $0xcc
  801824:	68 b3 29 80 00       	push   $0x8029b3
  801829:	e8 bf eb ff ff       	call   8003ed <_panic>

0080182e <freeHeap>:
}

void freeHeap(void* virtual_address) {
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801834:	83 ec 04             	sub    $0x4,%esp
  801837:	68 90 29 80 00       	push   $0x802990
  80183c:	68 d0 00 00 00       	push   $0xd0
  801841:	68 b3 29 80 00       	push   $0x8029b3
  801846:	e8 a2 eb ff ff       	call   8003ed <_panic>

0080184b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
  80184e:	57                   	push   %edi
  80184f:	56                   	push   %esi
  801850:	53                   	push   %ebx
  801851:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801860:	8b 7d 18             	mov    0x18(%ebp),%edi
  801863:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801866:	cd 30                	int    $0x30
  801868:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80186b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80186e:	83 c4 10             	add    $0x10,%esp
  801871:	5b                   	pop    %ebx
  801872:	5e                   	pop    %esi
  801873:	5f                   	pop    %edi
  801874:	5d                   	pop    %ebp
  801875:	c3                   	ret    

00801876 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
  801879:	83 ec 04             	sub    $0x4,%esp
  80187c:	8b 45 10             	mov    0x10(%ebp),%eax
  80187f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801882:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801886:	8b 45 08             	mov    0x8(%ebp),%eax
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	52                   	push   %edx
  80188e:	ff 75 0c             	pushl  0xc(%ebp)
  801891:	50                   	push   %eax
  801892:	6a 00                	push   $0x0
  801894:	e8 b2 ff ff ff       	call   80184b <syscall>
  801899:	83 c4 18             	add    $0x18,%esp
}
  80189c:	90                   	nop
  80189d:	c9                   	leave  
  80189e:	c3                   	ret    

0080189f <sys_cgetc>:

int
sys_cgetc(void)
{
  80189f:	55                   	push   %ebp
  8018a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 01                	push   $0x1
  8018ae:	e8 98 ff ff ff       	call   80184b <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	50                   	push   %eax
  8018c7:	6a 05                	push   $0x5
  8018c9:	e8 7d ff ff ff       	call   80184b <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 02                	push   $0x2
  8018e2:	e8 64 ff ff ff       	call   80184b <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 03                	push   $0x3
  8018fb:	e8 4b ff ff ff       	call   80184b <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 04                	push   $0x4
  801914:	e8 32 ff ff ff       	call   80184b <syscall>
  801919:	83 c4 18             	add    $0x18,%esp
}
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <sys_env_exit>:


void sys_env_exit(void)
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 06                	push   $0x6
  80192d:	e8 19 ff ff ff       	call   80184b <syscall>
  801932:	83 c4 18             	add    $0x18,%esp
}
  801935:	90                   	nop
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80193b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193e:	8b 45 08             	mov    0x8(%ebp),%eax
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	52                   	push   %edx
  801948:	50                   	push   %eax
  801949:	6a 07                	push   $0x7
  80194b:	e8 fb fe ff ff       	call   80184b <syscall>
  801950:	83 c4 18             	add    $0x18,%esp
}
  801953:	c9                   	leave  
  801954:	c3                   	ret    

00801955 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
  801958:	56                   	push   %esi
  801959:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80195a:	8b 75 18             	mov    0x18(%ebp),%esi
  80195d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801960:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801963:	8b 55 0c             	mov    0xc(%ebp),%edx
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	56                   	push   %esi
  80196a:	53                   	push   %ebx
  80196b:	51                   	push   %ecx
  80196c:	52                   	push   %edx
  80196d:	50                   	push   %eax
  80196e:	6a 08                	push   $0x8
  801970:	e8 d6 fe ff ff       	call   80184b <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80197b:	5b                   	pop    %ebx
  80197c:	5e                   	pop    %esi
  80197d:	5d                   	pop    %ebp
  80197e:	c3                   	ret    

0080197f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801982:	8b 55 0c             	mov    0xc(%ebp),%edx
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	52                   	push   %edx
  80198f:	50                   	push   %eax
  801990:	6a 09                	push   $0x9
  801992:	e8 b4 fe ff ff       	call   80184b <syscall>
  801997:	83 c4 18             	add    $0x18,%esp
}
  80199a:	c9                   	leave  
  80199b:	c3                   	ret    

0080199c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80199c:	55                   	push   %ebp
  80199d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	ff 75 0c             	pushl  0xc(%ebp)
  8019a8:	ff 75 08             	pushl  0x8(%ebp)
  8019ab:	6a 0a                	push   $0xa
  8019ad:	e8 99 fe ff ff       	call   80184b <syscall>
  8019b2:	83 c4 18             	add    $0x18,%esp
}
  8019b5:	c9                   	leave  
  8019b6:	c3                   	ret    

008019b7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019b7:	55                   	push   %ebp
  8019b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 0b                	push   $0xb
  8019c6:	e8 80 fe ff ff       	call   80184b <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
}
  8019ce:	c9                   	leave  
  8019cf:	c3                   	ret    

008019d0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 0c                	push   $0xc
  8019df:	e8 67 fe ff ff       	call   80184b <syscall>
  8019e4:	83 c4 18             	add    $0x18,%esp
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 0d                	push   $0xd
  8019f8:	e8 4e fe ff ff       	call   80184b <syscall>
  8019fd:	83 c4 18             	add    $0x18,%esp
}
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	ff 75 0c             	pushl  0xc(%ebp)
  801a0e:	ff 75 08             	pushl  0x8(%ebp)
  801a11:	6a 11                	push   $0x11
  801a13:	e8 33 fe ff ff       	call   80184b <syscall>
  801a18:	83 c4 18             	add    $0x18,%esp
	return;
  801a1b:	90                   	nop
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	ff 75 0c             	pushl  0xc(%ebp)
  801a2a:	ff 75 08             	pushl  0x8(%ebp)
  801a2d:	6a 12                	push   $0x12
  801a2f:	e8 17 fe ff ff       	call   80184b <syscall>
  801a34:	83 c4 18             	add    $0x18,%esp
	return ;
  801a37:	90                   	nop
}
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 0e                	push   $0xe
  801a49:	e8 fd fd ff ff       	call   80184b <syscall>
  801a4e:	83 c4 18             	add    $0x18,%esp
}
  801a51:	c9                   	leave  
  801a52:	c3                   	ret    

00801a53 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	ff 75 08             	pushl  0x8(%ebp)
  801a61:	6a 0f                	push   $0xf
  801a63:	e8 e3 fd ff ff       	call   80184b <syscall>
  801a68:	83 c4 18             	add    $0x18,%esp
}
  801a6b:	c9                   	leave  
  801a6c:	c3                   	ret    

00801a6d <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 10                	push   $0x10
  801a7c:	e8 ca fd ff ff       	call   80184b <syscall>
  801a81:	83 c4 18             	add    $0x18,%esp
}
  801a84:	90                   	nop
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 14                	push   $0x14
  801a96:	e8 b0 fd ff ff       	call   80184b <syscall>
  801a9b:	83 c4 18             	add    $0x18,%esp
}
  801a9e:	90                   	nop
  801a9f:	c9                   	leave  
  801aa0:	c3                   	ret    

00801aa1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801aa1:	55                   	push   %ebp
  801aa2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 15                	push   $0x15
  801ab0:	e8 96 fd ff ff       	call   80184b <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
}
  801ab8:	90                   	nop
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    

00801abb <sys_cputc>:


void
sys_cputc(const char c)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
  801abe:	83 ec 04             	sub    $0x4,%esp
  801ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ac7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	50                   	push   %eax
  801ad4:	6a 16                	push   $0x16
  801ad6:	e8 70 fd ff ff       	call   80184b <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	90                   	nop
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 17                	push   $0x17
  801af0:	e8 56 fd ff ff       	call   80184b <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	90                   	nop
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801afe:	8b 45 08             	mov    0x8(%ebp),%eax
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	ff 75 0c             	pushl  0xc(%ebp)
  801b0a:	50                   	push   %eax
  801b0b:	6a 18                	push   $0x18
  801b0d:	e8 39 fd ff ff       	call   80184b <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	c9                   	leave  
  801b16:	c3                   	ret    

00801b17 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	52                   	push   %edx
  801b27:	50                   	push   %eax
  801b28:	6a 1b                	push   $0x1b
  801b2a:	e8 1c fd ff ff       	call   80184b <syscall>
  801b2f:	83 c4 18             	add    $0x18,%esp
}
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b37:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	52                   	push   %edx
  801b44:	50                   	push   %eax
  801b45:	6a 19                	push   $0x19
  801b47:	e8 ff fc ff ff       	call   80184b <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
}
  801b4f:	90                   	nop
  801b50:	c9                   	leave  
  801b51:	c3                   	ret    

00801b52 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b58:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	52                   	push   %edx
  801b62:	50                   	push   %eax
  801b63:	6a 1a                	push   $0x1a
  801b65:	e8 e1 fc ff ff       	call   80184b <syscall>
  801b6a:	83 c4 18             	add    $0x18,%esp
}
  801b6d:	90                   	nop
  801b6e:	c9                   	leave  
  801b6f:	c3                   	ret    

00801b70 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
  801b73:	83 ec 04             	sub    $0x4,%esp
  801b76:	8b 45 10             	mov    0x10(%ebp),%eax
  801b79:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b7c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b7f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b83:	8b 45 08             	mov    0x8(%ebp),%eax
  801b86:	6a 00                	push   $0x0
  801b88:	51                   	push   %ecx
  801b89:	52                   	push   %edx
  801b8a:	ff 75 0c             	pushl  0xc(%ebp)
  801b8d:	50                   	push   %eax
  801b8e:	6a 1c                	push   $0x1c
  801b90:	e8 b6 fc ff ff       	call   80184b <syscall>
  801b95:	83 c4 18             	add    $0x18,%esp
}
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	52                   	push   %edx
  801baa:	50                   	push   %eax
  801bab:	6a 1d                	push   $0x1d
  801bad:	e8 99 fc ff ff       	call   80184b <syscall>
  801bb2:	83 c4 18             	add    $0x18,%esp
}
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801bba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	51                   	push   %ecx
  801bc8:	52                   	push   %edx
  801bc9:	50                   	push   %eax
  801bca:	6a 1e                	push   $0x1e
  801bcc:	e8 7a fc ff ff       	call   80184b <syscall>
  801bd1:	83 c4 18             	add    $0x18,%esp
}
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    

00801bd6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	52                   	push   %edx
  801be6:	50                   	push   %eax
  801be7:	6a 1f                	push   $0x1f
  801be9:	e8 5d fc ff ff       	call   80184b <syscall>
  801bee:	83 c4 18             	add    $0x18,%esp
}
  801bf1:	c9                   	leave  
  801bf2:	c3                   	ret    

00801bf3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 20                	push   $0x20
  801c02:	e8 44 fc ff ff       	call   80184b <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	6a 00                	push   $0x0
  801c14:	ff 75 14             	pushl  0x14(%ebp)
  801c17:	ff 75 10             	pushl  0x10(%ebp)
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	50                   	push   %eax
  801c1e:	6a 21                	push   $0x21
  801c20:	e8 26 fc ff ff       	call   80184b <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
}
  801c28:	c9                   	leave  
  801c29:	c3                   	ret    

00801c2a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c2a:	55                   	push   %ebp
  801c2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	50                   	push   %eax
  801c39:	6a 22                	push   $0x22
  801c3b:	e8 0b fc ff ff       	call   80184b <syscall>
  801c40:	83 c4 18             	add    $0x18,%esp
}
  801c43:	90                   	nop
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c49:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	50                   	push   %eax
  801c55:	6a 23                	push   $0x23
  801c57:	e8 ef fb ff ff       	call   80184b <syscall>
  801c5c:	83 c4 18             	add    $0x18,%esp
}
  801c5f:	90                   	nop
  801c60:	c9                   	leave  
  801c61:	c3                   	ret    

00801c62 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c62:	55                   	push   %ebp
  801c63:	89 e5                	mov    %esp,%ebp
  801c65:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c68:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c6b:	8d 50 04             	lea    0x4(%eax),%edx
  801c6e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	52                   	push   %edx
  801c78:	50                   	push   %eax
  801c79:	6a 24                	push   $0x24
  801c7b:	e8 cb fb ff ff       	call   80184b <syscall>
  801c80:	83 c4 18             	add    $0x18,%esp
	return result;
  801c83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c86:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c8c:	89 01                	mov    %eax,(%ecx)
  801c8e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	c9                   	leave  
  801c95:	c2 04 00             	ret    $0x4

00801c98 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	ff 75 10             	pushl  0x10(%ebp)
  801ca2:	ff 75 0c             	pushl  0xc(%ebp)
  801ca5:	ff 75 08             	pushl  0x8(%ebp)
  801ca8:	6a 13                	push   $0x13
  801caa:	e8 9c fb ff ff       	call   80184b <syscall>
  801caf:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb2:	90                   	nop
}
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <sys_rcr2>:
uint32 sys_rcr2()
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 25                	push   $0x25
  801cc4:	e8 82 fb ff ff       	call   80184b <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
  801cd1:	83 ec 04             	sub    $0x4,%esp
  801cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cda:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	50                   	push   %eax
  801ce7:	6a 26                	push   $0x26
  801ce9:	e8 5d fb ff ff       	call   80184b <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf1:	90                   	nop
}
  801cf2:	c9                   	leave  
  801cf3:	c3                   	ret    

00801cf4 <rsttst>:
void rsttst()
{
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 28                	push   $0x28
  801d03:	e8 43 fb ff ff       	call   80184b <syscall>
  801d08:	83 c4 18             	add    $0x18,%esp
	return ;
  801d0b:	90                   	nop
}
  801d0c:	c9                   	leave  
  801d0d:	c3                   	ret    

00801d0e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d0e:	55                   	push   %ebp
  801d0f:	89 e5                	mov    %esp,%ebp
  801d11:	83 ec 04             	sub    $0x4,%esp
  801d14:	8b 45 14             	mov    0x14(%ebp),%eax
  801d17:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d1a:	8b 55 18             	mov    0x18(%ebp),%edx
  801d1d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d21:	52                   	push   %edx
  801d22:	50                   	push   %eax
  801d23:	ff 75 10             	pushl  0x10(%ebp)
  801d26:	ff 75 0c             	pushl  0xc(%ebp)
  801d29:	ff 75 08             	pushl  0x8(%ebp)
  801d2c:	6a 27                	push   $0x27
  801d2e:	e8 18 fb ff ff       	call   80184b <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
	return ;
  801d36:	90                   	nop
}
  801d37:	c9                   	leave  
  801d38:	c3                   	ret    

00801d39 <chktst>:
void chktst(uint32 n)
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	ff 75 08             	pushl  0x8(%ebp)
  801d47:	6a 29                	push   $0x29
  801d49:	e8 fd fa ff ff       	call   80184b <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
	return ;
  801d51:	90                   	nop
}
  801d52:	c9                   	leave  
  801d53:	c3                   	ret    

00801d54 <inctst>:

void inctst()
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 2a                	push   $0x2a
  801d63:	e8 e3 fa ff ff       	call   80184b <syscall>
  801d68:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6b:	90                   	nop
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <gettst>:
uint32 gettst()
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 2b                	push   $0x2b
  801d7d:	e8 c9 fa ff ff       	call   80184b <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
  801d8a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 2c                	push   $0x2c
  801d99:	e8 ad fa ff ff       	call   80184b <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
  801da1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801da4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801da8:	75 07                	jne    801db1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801daa:	b8 01 00 00 00       	mov    $0x1,%eax
  801daf:	eb 05                	jmp    801db6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801db1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801db6:	c9                   	leave  
  801db7:	c3                   	ret    

00801db8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801db8:	55                   	push   %ebp
  801db9:	89 e5                	mov    %esp,%ebp
  801dbb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 2c                	push   $0x2c
  801dca:	e8 7c fa ff ff       	call   80184b <syscall>
  801dcf:	83 c4 18             	add    $0x18,%esp
  801dd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801dd5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801dd9:	75 07                	jne    801de2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ddb:	b8 01 00 00 00       	mov    $0x1,%eax
  801de0:	eb 05                	jmp    801de7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801de2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de7:	c9                   	leave  
  801de8:	c3                   	ret    

00801de9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801de9:	55                   	push   %ebp
  801dea:	89 e5                	mov    %esp,%ebp
  801dec:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 2c                	push   $0x2c
  801dfb:	e8 4b fa ff ff       	call   80184b <syscall>
  801e00:	83 c4 18             	add    $0x18,%esp
  801e03:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e06:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e0a:	75 07                	jne    801e13 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e0c:	b8 01 00 00 00       	mov    $0x1,%eax
  801e11:	eb 05                	jmp    801e18 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e13:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e18:	c9                   	leave  
  801e19:	c3                   	ret    

00801e1a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e1a:	55                   	push   %ebp
  801e1b:	89 e5                	mov    %esp,%ebp
  801e1d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 2c                	push   $0x2c
  801e2c:	e8 1a fa ff ff       	call   80184b <syscall>
  801e31:	83 c4 18             	add    $0x18,%esp
  801e34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e37:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e3b:	75 07                	jne    801e44 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e3d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e42:	eb 05                	jmp    801e49 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e44:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e49:	c9                   	leave  
  801e4a:	c3                   	ret    

00801e4b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e4b:	55                   	push   %ebp
  801e4c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	ff 75 08             	pushl  0x8(%ebp)
  801e59:	6a 2d                	push   $0x2d
  801e5b:	e8 eb f9 ff ff       	call   80184b <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
	return ;
  801e63:	90                   	nop
}
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
  801e69:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e6a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e6d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e73:	8b 45 08             	mov    0x8(%ebp),%eax
  801e76:	6a 00                	push   $0x0
  801e78:	53                   	push   %ebx
  801e79:	51                   	push   %ecx
  801e7a:	52                   	push   %edx
  801e7b:	50                   	push   %eax
  801e7c:	6a 2e                	push   $0x2e
  801e7e:	e8 c8 f9 ff ff       	call   80184b <syscall>
  801e83:	83 c4 18             	add    $0x18,%esp
}
  801e86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e91:	8b 45 08             	mov    0x8(%ebp),%eax
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	52                   	push   %edx
  801e9b:	50                   	push   %eax
  801e9c:	6a 2f                	push   $0x2f
  801e9e:	e8 a8 f9 ff ff       	call   80184b <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <__udivdi3>:
  801ea8:	55                   	push   %ebp
  801ea9:	57                   	push   %edi
  801eaa:	56                   	push   %esi
  801eab:	53                   	push   %ebx
  801eac:	83 ec 1c             	sub    $0x1c,%esp
  801eaf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801eb3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801eb7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ebb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ebf:	89 ca                	mov    %ecx,%edx
  801ec1:	89 f8                	mov    %edi,%eax
  801ec3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ec7:	85 f6                	test   %esi,%esi
  801ec9:	75 2d                	jne    801ef8 <__udivdi3+0x50>
  801ecb:	39 cf                	cmp    %ecx,%edi
  801ecd:	77 65                	ja     801f34 <__udivdi3+0x8c>
  801ecf:	89 fd                	mov    %edi,%ebp
  801ed1:	85 ff                	test   %edi,%edi
  801ed3:	75 0b                	jne    801ee0 <__udivdi3+0x38>
  801ed5:	b8 01 00 00 00       	mov    $0x1,%eax
  801eda:	31 d2                	xor    %edx,%edx
  801edc:	f7 f7                	div    %edi
  801ede:	89 c5                	mov    %eax,%ebp
  801ee0:	31 d2                	xor    %edx,%edx
  801ee2:	89 c8                	mov    %ecx,%eax
  801ee4:	f7 f5                	div    %ebp
  801ee6:	89 c1                	mov    %eax,%ecx
  801ee8:	89 d8                	mov    %ebx,%eax
  801eea:	f7 f5                	div    %ebp
  801eec:	89 cf                	mov    %ecx,%edi
  801eee:	89 fa                	mov    %edi,%edx
  801ef0:	83 c4 1c             	add    $0x1c,%esp
  801ef3:	5b                   	pop    %ebx
  801ef4:	5e                   	pop    %esi
  801ef5:	5f                   	pop    %edi
  801ef6:	5d                   	pop    %ebp
  801ef7:	c3                   	ret    
  801ef8:	39 ce                	cmp    %ecx,%esi
  801efa:	77 28                	ja     801f24 <__udivdi3+0x7c>
  801efc:	0f bd fe             	bsr    %esi,%edi
  801eff:	83 f7 1f             	xor    $0x1f,%edi
  801f02:	75 40                	jne    801f44 <__udivdi3+0x9c>
  801f04:	39 ce                	cmp    %ecx,%esi
  801f06:	72 0a                	jb     801f12 <__udivdi3+0x6a>
  801f08:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f0c:	0f 87 9e 00 00 00    	ja     801fb0 <__udivdi3+0x108>
  801f12:	b8 01 00 00 00       	mov    $0x1,%eax
  801f17:	89 fa                	mov    %edi,%edx
  801f19:	83 c4 1c             	add    $0x1c,%esp
  801f1c:	5b                   	pop    %ebx
  801f1d:	5e                   	pop    %esi
  801f1e:	5f                   	pop    %edi
  801f1f:	5d                   	pop    %ebp
  801f20:	c3                   	ret    
  801f21:	8d 76 00             	lea    0x0(%esi),%esi
  801f24:	31 ff                	xor    %edi,%edi
  801f26:	31 c0                	xor    %eax,%eax
  801f28:	89 fa                	mov    %edi,%edx
  801f2a:	83 c4 1c             	add    $0x1c,%esp
  801f2d:	5b                   	pop    %ebx
  801f2e:	5e                   	pop    %esi
  801f2f:	5f                   	pop    %edi
  801f30:	5d                   	pop    %ebp
  801f31:	c3                   	ret    
  801f32:	66 90                	xchg   %ax,%ax
  801f34:	89 d8                	mov    %ebx,%eax
  801f36:	f7 f7                	div    %edi
  801f38:	31 ff                	xor    %edi,%edi
  801f3a:	89 fa                	mov    %edi,%edx
  801f3c:	83 c4 1c             	add    $0x1c,%esp
  801f3f:	5b                   	pop    %ebx
  801f40:	5e                   	pop    %esi
  801f41:	5f                   	pop    %edi
  801f42:	5d                   	pop    %ebp
  801f43:	c3                   	ret    
  801f44:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f49:	89 eb                	mov    %ebp,%ebx
  801f4b:	29 fb                	sub    %edi,%ebx
  801f4d:	89 f9                	mov    %edi,%ecx
  801f4f:	d3 e6                	shl    %cl,%esi
  801f51:	89 c5                	mov    %eax,%ebp
  801f53:	88 d9                	mov    %bl,%cl
  801f55:	d3 ed                	shr    %cl,%ebp
  801f57:	89 e9                	mov    %ebp,%ecx
  801f59:	09 f1                	or     %esi,%ecx
  801f5b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f5f:	89 f9                	mov    %edi,%ecx
  801f61:	d3 e0                	shl    %cl,%eax
  801f63:	89 c5                	mov    %eax,%ebp
  801f65:	89 d6                	mov    %edx,%esi
  801f67:	88 d9                	mov    %bl,%cl
  801f69:	d3 ee                	shr    %cl,%esi
  801f6b:	89 f9                	mov    %edi,%ecx
  801f6d:	d3 e2                	shl    %cl,%edx
  801f6f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f73:	88 d9                	mov    %bl,%cl
  801f75:	d3 e8                	shr    %cl,%eax
  801f77:	09 c2                	or     %eax,%edx
  801f79:	89 d0                	mov    %edx,%eax
  801f7b:	89 f2                	mov    %esi,%edx
  801f7d:	f7 74 24 0c          	divl   0xc(%esp)
  801f81:	89 d6                	mov    %edx,%esi
  801f83:	89 c3                	mov    %eax,%ebx
  801f85:	f7 e5                	mul    %ebp
  801f87:	39 d6                	cmp    %edx,%esi
  801f89:	72 19                	jb     801fa4 <__udivdi3+0xfc>
  801f8b:	74 0b                	je     801f98 <__udivdi3+0xf0>
  801f8d:	89 d8                	mov    %ebx,%eax
  801f8f:	31 ff                	xor    %edi,%edi
  801f91:	e9 58 ff ff ff       	jmp    801eee <__udivdi3+0x46>
  801f96:	66 90                	xchg   %ax,%ax
  801f98:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f9c:	89 f9                	mov    %edi,%ecx
  801f9e:	d3 e2                	shl    %cl,%edx
  801fa0:	39 c2                	cmp    %eax,%edx
  801fa2:	73 e9                	jae    801f8d <__udivdi3+0xe5>
  801fa4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fa7:	31 ff                	xor    %edi,%edi
  801fa9:	e9 40 ff ff ff       	jmp    801eee <__udivdi3+0x46>
  801fae:	66 90                	xchg   %ax,%ax
  801fb0:	31 c0                	xor    %eax,%eax
  801fb2:	e9 37 ff ff ff       	jmp    801eee <__udivdi3+0x46>
  801fb7:	90                   	nop

00801fb8 <__umoddi3>:
  801fb8:	55                   	push   %ebp
  801fb9:	57                   	push   %edi
  801fba:	56                   	push   %esi
  801fbb:	53                   	push   %ebx
  801fbc:	83 ec 1c             	sub    $0x1c,%esp
  801fbf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801fc3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fc7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fcb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fcf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801fd3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801fd7:	89 f3                	mov    %esi,%ebx
  801fd9:	89 fa                	mov    %edi,%edx
  801fdb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fdf:	89 34 24             	mov    %esi,(%esp)
  801fe2:	85 c0                	test   %eax,%eax
  801fe4:	75 1a                	jne    802000 <__umoddi3+0x48>
  801fe6:	39 f7                	cmp    %esi,%edi
  801fe8:	0f 86 a2 00 00 00    	jbe    802090 <__umoddi3+0xd8>
  801fee:	89 c8                	mov    %ecx,%eax
  801ff0:	89 f2                	mov    %esi,%edx
  801ff2:	f7 f7                	div    %edi
  801ff4:	89 d0                	mov    %edx,%eax
  801ff6:	31 d2                	xor    %edx,%edx
  801ff8:	83 c4 1c             	add    $0x1c,%esp
  801ffb:	5b                   	pop    %ebx
  801ffc:	5e                   	pop    %esi
  801ffd:	5f                   	pop    %edi
  801ffe:	5d                   	pop    %ebp
  801fff:	c3                   	ret    
  802000:	39 f0                	cmp    %esi,%eax
  802002:	0f 87 ac 00 00 00    	ja     8020b4 <__umoddi3+0xfc>
  802008:	0f bd e8             	bsr    %eax,%ebp
  80200b:	83 f5 1f             	xor    $0x1f,%ebp
  80200e:	0f 84 ac 00 00 00    	je     8020c0 <__umoddi3+0x108>
  802014:	bf 20 00 00 00       	mov    $0x20,%edi
  802019:	29 ef                	sub    %ebp,%edi
  80201b:	89 fe                	mov    %edi,%esi
  80201d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802021:	89 e9                	mov    %ebp,%ecx
  802023:	d3 e0                	shl    %cl,%eax
  802025:	89 d7                	mov    %edx,%edi
  802027:	89 f1                	mov    %esi,%ecx
  802029:	d3 ef                	shr    %cl,%edi
  80202b:	09 c7                	or     %eax,%edi
  80202d:	89 e9                	mov    %ebp,%ecx
  80202f:	d3 e2                	shl    %cl,%edx
  802031:	89 14 24             	mov    %edx,(%esp)
  802034:	89 d8                	mov    %ebx,%eax
  802036:	d3 e0                	shl    %cl,%eax
  802038:	89 c2                	mov    %eax,%edx
  80203a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80203e:	d3 e0                	shl    %cl,%eax
  802040:	89 44 24 04          	mov    %eax,0x4(%esp)
  802044:	8b 44 24 08          	mov    0x8(%esp),%eax
  802048:	89 f1                	mov    %esi,%ecx
  80204a:	d3 e8                	shr    %cl,%eax
  80204c:	09 d0                	or     %edx,%eax
  80204e:	d3 eb                	shr    %cl,%ebx
  802050:	89 da                	mov    %ebx,%edx
  802052:	f7 f7                	div    %edi
  802054:	89 d3                	mov    %edx,%ebx
  802056:	f7 24 24             	mull   (%esp)
  802059:	89 c6                	mov    %eax,%esi
  80205b:	89 d1                	mov    %edx,%ecx
  80205d:	39 d3                	cmp    %edx,%ebx
  80205f:	0f 82 87 00 00 00    	jb     8020ec <__umoddi3+0x134>
  802065:	0f 84 91 00 00 00    	je     8020fc <__umoddi3+0x144>
  80206b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80206f:	29 f2                	sub    %esi,%edx
  802071:	19 cb                	sbb    %ecx,%ebx
  802073:	89 d8                	mov    %ebx,%eax
  802075:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802079:	d3 e0                	shl    %cl,%eax
  80207b:	89 e9                	mov    %ebp,%ecx
  80207d:	d3 ea                	shr    %cl,%edx
  80207f:	09 d0                	or     %edx,%eax
  802081:	89 e9                	mov    %ebp,%ecx
  802083:	d3 eb                	shr    %cl,%ebx
  802085:	89 da                	mov    %ebx,%edx
  802087:	83 c4 1c             	add    $0x1c,%esp
  80208a:	5b                   	pop    %ebx
  80208b:	5e                   	pop    %esi
  80208c:	5f                   	pop    %edi
  80208d:	5d                   	pop    %ebp
  80208e:	c3                   	ret    
  80208f:	90                   	nop
  802090:	89 fd                	mov    %edi,%ebp
  802092:	85 ff                	test   %edi,%edi
  802094:	75 0b                	jne    8020a1 <__umoddi3+0xe9>
  802096:	b8 01 00 00 00       	mov    $0x1,%eax
  80209b:	31 d2                	xor    %edx,%edx
  80209d:	f7 f7                	div    %edi
  80209f:	89 c5                	mov    %eax,%ebp
  8020a1:	89 f0                	mov    %esi,%eax
  8020a3:	31 d2                	xor    %edx,%edx
  8020a5:	f7 f5                	div    %ebp
  8020a7:	89 c8                	mov    %ecx,%eax
  8020a9:	f7 f5                	div    %ebp
  8020ab:	89 d0                	mov    %edx,%eax
  8020ad:	e9 44 ff ff ff       	jmp    801ff6 <__umoddi3+0x3e>
  8020b2:	66 90                	xchg   %ax,%ax
  8020b4:	89 c8                	mov    %ecx,%eax
  8020b6:	89 f2                	mov    %esi,%edx
  8020b8:	83 c4 1c             	add    $0x1c,%esp
  8020bb:	5b                   	pop    %ebx
  8020bc:	5e                   	pop    %esi
  8020bd:	5f                   	pop    %edi
  8020be:	5d                   	pop    %ebp
  8020bf:	c3                   	ret    
  8020c0:	3b 04 24             	cmp    (%esp),%eax
  8020c3:	72 06                	jb     8020cb <__umoddi3+0x113>
  8020c5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020c9:	77 0f                	ja     8020da <__umoddi3+0x122>
  8020cb:	89 f2                	mov    %esi,%edx
  8020cd:	29 f9                	sub    %edi,%ecx
  8020cf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020d3:	89 14 24             	mov    %edx,(%esp)
  8020d6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020da:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020de:	8b 14 24             	mov    (%esp),%edx
  8020e1:	83 c4 1c             	add    $0x1c,%esp
  8020e4:	5b                   	pop    %ebx
  8020e5:	5e                   	pop    %esi
  8020e6:	5f                   	pop    %edi
  8020e7:	5d                   	pop    %ebp
  8020e8:	c3                   	ret    
  8020e9:	8d 76 00             	lea    0x0(%esi),%esi
  8020ec:	2b 04 24             	sub    (%esp),%eax
  8020ef:	19 fa                	sbb    %edi,%edx
  8020f1:	89 d1                	mov    %edx,%ecx
  8020f3:	89 c6                	mov    %eax,%esi
  8020f5:	e9 71 ff ff ff       	jmp    80206b <__umoddi3+0xb3>
  8020fa:	66 90                	xchg   %ax,%ax
  8020fc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802100:	72 ea                	jb     8020ec <__umoddi3+0x134>
  802102:	89 d9                	mov    %ebx,%ecx
  802104:	e9 62 ff ff ff       	jmp    80206b <__umoddi3+0xb3>
