
obj/user/tst_first_fit_2:     file format elf32-i386


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
  800031:	e8 bd 06 00 00       	call   8006f3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 4c 22 00 00       	call   802296 <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 23                	jmp    80007d <_main+0x45>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	c1 e2 04             	shl    $0x4,%edx
  80006b:	01 d0                	add    %edx,%eax
  80006d:	8a 40 04             	mov    0x4(%eax),%al
  800070:	84 c0                	test   %al,%al
  800072:	74 06                	je     80007a <_main+0x42>
			{
				fullWS = 0;
  800074:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800078:	eb 12                	jmp    80008c <_main+0x54>
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80007a:	ff 45 f0             	incl   -0x10(%ebp)
  80007d:	a1 20 30 80 00       	mov    0x803020,%eax
  800082:	8b 50 74             	mov    0x74(%eax),%edx
  800085:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800088:	39 c2                	cmp    %eax,%edx
  80008a:	77 ce                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80008c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800090:	74 14                	je     8000a6 <_main+0x6e>
  800092:	83 ec 04             	sub    $0x4,%esp
  800095:	68 60 25 80 00       	push   $0x802560
  80009a:	6a 1b                	push   $0x1b
  80009c:	68 7c 25 80 00       	push   $0x80257c
  8000a1:	e8 92 07 00 00       	call   800838 <_panic>
	}


	int Mega = 1024*1024;
  8000a6:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000ad:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000b4:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000b7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c1:	89 d7                	mov    %edx,%edi
  8000c3:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  8000c5:	83 ec 0c             	sub    $0xc,%esp
  8000c8:	68 01 00 00 20       	push   $0x20000001
  8000cd:	e8 92 17 00 00       	call   801864 <malloc>
  8000d2:	83 c4 10             	add    $0x10,%esp
  8000d5:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000d8:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000db:	85 c0                	test   %eax,%eax
  8000dd:	74 14                	je     8000f3 <_main+0xbb>
  8000df:	83 ec 04             	sub    $0x4,%esp
  8000e2:	68 94 25 80 00       	push   $0x802594
  8000e7:	6a 26                	push   $0x26
  8000e9:	68 7c 25 80 00       	push   $0x80257c
  8000ee:	e8 45 07 00 00       	call   800838 <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f3:	e8 0a 1d 00 00       	call   801e02 <sys_calculate_free_frames>
  8000f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  8000fb:	e8 85 1d 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800100:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800103:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800106:	01 c0                	add    %eax,%eax
  800108:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	50                   	push   %eax
  80010f:	e8 50 17 00 00       	call   801864 <malloc>
  800114:	83 c4 10             	add    $0x10,%esp
  800117:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80011a:	8b 45 90             	mov    -0x70(%ebp),%eax
  80011d:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800122:	74 14                	je     800138 <_main+0x100>
  800124:	83 ec 04             	sub    $0x4,%esp
  800127:	68 d8 25 80 00       	push   $0x8025d8
  80012c:	6a 2f                	push   $0x2f
  80012e:	68 7c 25 80 00       	push   $0x80257c
  800133:	e8 00 07 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800138:	e8 48 1d 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80013d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800140:	3d 00 02 00 00       	cmp    $0x200,%eax
  800145:	74 14                	je     80015b <_main+0x123>
  800147:	83 ec 04             	sub    $0x4,%esp
  80014a:	68 08 26 80 00       	push   $0x802608
  80014f:	6a 31                	push   $0x31
  800151:	68 7c 25 80 00       	push   $0x80257c
  800156:	e8 dd 06 00 00       	call   800838 <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  80015b:	e8 a2 1c 00 00       	call   801e02 <sys_calculate_free_frames>
  800160:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800163:	e8 1d 1d 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800168:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80016b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016e:	01 c0                	add    %eax,%eax
  800170:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800173:	83 ec 0c             	sub    $0xc,%esp
  800176:	50                   	push   %eax
  800177:	e8 e8 16 00 00       	call   801864 <malloc>
  80017c:	83 c4 10             	add    $0x10,%esp
  80017f:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800182:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800185:	89 c2                	mov    %eax,%edx
  800187:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018a:	01 c0                	add    %eax,%eax
  80018c:	05 00 00 00 80       	add    $0x80000000,%eax
  800191:	39 c2                	cmp    %eax,%edx
  800193:	74 14                	je     8001a9 <_main+0x171>
  800195:	83 ec 04             	sub    $0x4,%esp
  800198:	68 d8 25 80 00       	push   $0x8025d8
  80019d:	6a 37                	push   $0x37
  80019f:	68 7c 25 80 00       	push   $0x80257c
  8001a4:	e8 8f 06 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001a9:	e8 d7 1c 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8001ae:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001b6:	74 14                	je     8001cc <_main+0x194>
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	68 08 26 80 00       	push   $0x802608
  8001c0:	6a 39                	push   $0x39
  8001c2:	68 7c 25 80 00       	push   $0x80257c
  8001c7:	e8 6c 06 00 00       	call   800838 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  8001cc:	e8 31 1c 00 00       	call   801e02 <sys_calculate_free_frames>
  8001d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001d4:	e8 ac 1c 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8001d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  8001dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001df:	89 c2                	mov    %eax,%edx
  8001e1:	01 d2                	add    %edx,%edx
  8001e3:	01 d0                	add    %edx,%eax
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	50                   	push   %eax
  8001e9:	e8 76 16 00 00       	call   801864 <malloc>
  8001ee:	83 c4 10             	add    $0x10,%esp
  8001f1:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8001f4:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001f7:	89 c2                	mov    %eax,%edx
  8001f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001fc:	c1 e0 02             	shl    $0x2,%eax
  8001ff:	05 00 00 00 80       	add    $0x80000000,%eax
  800204:	39 c2                	cmp    %eax,%edx
  800206:	74 14                	je     80021c <_main+0x1e4>
  800208:	83 ec 04             	sub    $0x4,%esp
  80020b:	68 d8 25 80 00       	push   $0x8025d8
  800210:	6a 3f                	push   $0x3f
  800212:	68 7c 25 80 00       	push   $0x80257c
  800217:	e8 1c 06 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021c:	e8 64 1c 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800221:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800224:	83 f8 01             	cmp    $0x1,%eax
  800227:	74 14                	je     80023d <_main+0x205>
  800229:	83 ec 04             	sub    $0x4,%esp
  80022c:	68 08 26 80 00       	push   $0x802608
  800231:	6a 41                	push   $0x41
  800233:	68 7c 25 80 00       	push   $0x80257c
  800238:	e8 fb 05 00 00       	call   800838 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  80023d:	e8 c0 1b 00 00       	call   801e02 <sys_calculate_free_frames>
  800242:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800245:	e8 3b 1c 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80024a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  80024d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800250:	89 c2                	mov    %eax,%edx
  800252:	01 d2                	add    %edx,%edx
  800254:	01 d0                	add    %edx,%eax
  800256:	83 ec 0c             	sub    $0xc,%esp
  800259:	50                   	push   %eax
  80025a:	e8 05 16 00 00       	call   801864 <malloc>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... ");
  800265:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800268:	89 c2                	mov    %eax,%edx
  80026a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80026d:	c1 e0 02             	shl    $0x2,%eax
  800270:	89 c1                	mov    %eax,%ecx
  800272:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800275:	c1 e0 02             	shl    $0x2,%eax
  800278:	01 c8                	add    %ecx,%eax
  80027a:	05 00 00 00 80       	add    $0x80000000,%eax
  80027f:	39 c2                	cmp    %eax,%edx
  800281:	74 14                	je     800297 <_main+0x25f>
  800283:	83 ec 04             	sub    $0x4,%esp
  800286:	68 d8 25 80 00       	push   $0x8025d8
  80028b:	6a 47                	push   $0x47
  80028d:	68 7c 25 80 00       	push   $0x80257c
  800292:	e8 a1 05 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800297:	e8 e9 1b 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80029c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029f:	83 f8 01             	cmp    $0x1,%eax
  8002a2:	74 14                	je     8002b8 <_main+0x280>
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 08 26 80 00       	push   $0x802608
  8002ac:	6a 49                	push   $0x49
  8002ae:	68 7c 25 80 00       	push   $0x80257c
  8002b3:	e8 80 05 00 00       	call   800838 <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b8:	e8 45 1b 00 00       	call   801e02 <sys_calculate_free_frames>
  8002bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c0:	e8 c0 1b 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8002c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c8:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002cb:	83 ec 0c             	sub    $0xc,%esp
  8002ce:	50                   	push   %eax
  8002cf:	e8 58 18 00 00       	call   801b2c <free>
  8002d4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d7:	e8 a9 1b 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8002dc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002df:	29 c2                	sub    %eax,%edx
  8002e1:	89 d0                	mov    %edx,%eax
  8002e3:	83 f8 01             	cmp    $0x1,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 25 26 80 00       	push   $0x802625
  8002f0:	6a 50                	push   $0x50
  8002f2:	68 7c 25 80 00       	push   $0x80257c
  8002f7:	e8 3c 05 00 00       	call   800838 <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fc:	e8 01 1b 00 00       	call   801e02 <sys_calculate_free_frames>
  800301:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800304:	e8 7c 1b 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800309:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80030c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80030f:	89 d0                	mov    %edx,%eax
  800311:	01 c0                	add    %eax,%eax
  800313:	01 d0                	add    %edx,%eax
  800315:	01 c0                	add    %eax,%eax
  800317:	01 d0                	add    %edx,%eax
  800319:	83 ec 0c             	sub    $0xc,%esp
  80031c:	50                   	push   %eax
  80031d:	e8 42 15 00 00       	call   801864 <malloc>
  800322:	83 c4 10             	add    $0x10,%esp
  800325:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... ");
  800328:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80032b:	89 c2                	mov    %eax,%edx
  80032d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800330:	c1 e0 02             	shl    $0x2,%eax
  800333:	89 c1                	mov    %eax,%ecx
  800335:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800338:	c1 e0 03             	shl    $0x3,%eax
  80033b:	01 c8                	add    %ecx,%eax
  80033d:	05 00 00 00 80       	add    $0x80000000,%eax
  800342:	39 c2                	cmp    %eax,%edx
  800344:	74 14                	je     80035a <_main+0x322>
  800346:	83 ec 04             	sub    $0x4,%esp
  800349:	68 d8 25 80 00       	push   $0x8025d8
  80034e:	6a 56                	push   $0x56
  800350:	68 7c 25 80 00       	push   $0x80257c
  800355:	e8 de 04 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  80035a:	e8 26 1b 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80035f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800362:	83 f8 02             	cmp    $0x2,%eax
  800365:	74 14                	je     80037b <_main+0x343>
  800367:	83 ec 04             	sub    $0x4,%esp
  80036a:	68 08 26 80 00       	push   $0x802608
  80036f:	6a 58                	push   $0x58
  800371:	68 7c 25 80 00       	push   $0x80257c
  800376:	e8 bd 04 00 00       	call   800838 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80037b:	e8 82 1a 00 00       	call   801e02 <sys_calculate_free_frames>
  800380:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800383:	e8 fd 1a 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800388:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  80038b:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038e:	83 ec 0c             	sub    $0xc,%esp
  800391:	50                   	push   %eax
  800392:	e8 95 17 00 00       	call   801b2c <free>
  800397:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  80039a:	e8 e6 1a 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80039f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a2:	29 c2                	sub    %eax,%edx
  8003a4:	89 d0                	mov    %edx,%eax
  8003a6:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003ab:	74 14                	je     8003c1 <_main+0x389>
  8003ad:	83 ec 04             	sub    $0x4,%esp
  8003b0:	68 25 26 80 00       	push   $0x802625
  8003b5:	6a 5f                	push   $0x5f
  8003b7:	68 7c 25 80 00       	push   $0x80257c
  8003bc:	e8 77 04 00 00       	call   800838 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003c1:	e8 3c 1a 00 00       	call   801e02 <sys_calculate_free_frames>
  8003c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c9:	e8 b7 1a 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8003ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d4:	89 c2                	mov    %eax,%edx
  8003d6:	01 d2                	add    %edx,%edx
  8003d8:	01 d0                	add    %edx,%eax
  8003da:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003dd:	83 ec 0c             	sub    $0xc,%esp
  8003e0:	50                   	push   %eax
  8003e1:	e8 7e 14 00 00       	call   801864 <malloc>
  8003e6:	83 c4 10             	add    $0x10,%esp
  8003e9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8003ec:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003ef:	89 c2                	mov    %eax,%edx
  8003f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003f4:	c1 e0 02             	shl    $0x2,%eax
  8003f7:	89 c1                	mov    %eax,%ecx
  8003f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003fc:	c1 e0 04             	shl    $0x4,%eax
  8003ff:	01 c8                	add    %ecx,%eax
  800401:	05 00 00 00 80       	add    $0x80000000,%eax
  800406:	39 c2                	cmp    %eax,%edx
  800408:	74 14                	je     80041e <_main+0x3e6>
  80040a:	83 ec 04             	sub    $0x4,%esp
  80040d:	68 d8 25 80 00       	push   $0x8025d8
  800412:	6a 65                	push   $0x65
  800414:	68 7c 25 80 00       	push   $0x80257c
  800419:	e8 1a 04 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041e:	e8 62 1a 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800423:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800426:	89 c2                	mov    %eax,%edx
  800428:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80042b:	89 c1                	mov    %eax,%ecx
  80042d:	01 c9                	add    %ecx,%ecx
  80042f:	01 c8                	add    %ecx,%eax
  800431:	85 c0                	test   %eax,%eax
  800433:	79 05                	jns    80043a <_main+0x402>
  800435:	05 ff 0f 00 00       	add    $0xfff,%eax
  80043a:	c1 f8 0c             	sar    $0xc,%eax
  80043d:	39 c2                	cmp    %eax,%edx
  80043f:	74 14                	je     800455 <_main+0x41d>
  800441:	83 ec 04             	sub    $0x4,%esp
  800444:	68 08 26 80 00       	push   $0x802608
  800449:	6a 67                	push   $0x67
  80044b:	68 7c 25 80 00       	push   $0x80257c
  800450:	e8 e3 03 00 00       	call   800838 <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800455:	e8 a8 19 00 00       	call   801e02 <sys_calculate_free_frames>
  80045a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045d:	e8 23 1a 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800462:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  800465:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800468:	89 c2                	mov    %eax,%edx
  80046a:	01 d2                	add    %edx,%edx
  80046c:	01 c2                	add    %eax,%edx
  80046e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800471:	01 d0                	add    %edx,%eax
  800473:	01 c0                	add    %eax,%eax
  800475:	83 ec 0c             	sub    $0xc,%esp
  800478:	50                   	push   %eax
  800479:	e8 e6 13 00 00       	call   801864 <malloc>
  80047e:	83 c4 10             	add    $0x10,%esp
  800481:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800484:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800487:	89 c1                	mov    %eax,%ecx
  800489:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80048c:	89 d0                	mov    %edx,%eax
  80048e:	01 c0                	add    %eax,%eax
  800490:	01 d0                	add    %edx,%eax
  800492:	01 c0                	add    %eax,%eax
  800494:	01 d0                	add    %edx,%eax
  800496:	89 c2                	mov    %eax,%edx
  800498:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80049b:	c1 e0 04             	shl    $0x4,%eax
  80049e:	01 d0                	add    %edx,%eax
  8004a0:	05 00 00 00 80       	add    $0x80000000,%eax
  8004a5:	39 c1                	cmp    %eax,%ecx
  8004a7:	74 14                	je     8004bd <_main+0x485>
  8004a9:	83 ec 04             	sub    $0x4,%esp
  8004ac:	68 d8 25 80 00       	push   $0x8025d8
  8004b1:	6a 6d                	push   $0x6d
  8004b3:	68 7c 25 80 00       	push   $0x80257c
  8004b8:	e8 7b 03 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bd:	e8 c3 19 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8004c2:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c5:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004ca:	74 14                	je     8004e0 <_main+0x4a8>
  8004cc:	83 ec 04             	sub    $0x4,%esp
  8004cf:	68 08 26 80 00       	push   $0x802608
  8004d4:	6a 6f                	push   $0x6f
  8004d6:	68 7c 25 80 00       	push   $0x80257c
  8004db:	e8 58 03 00 00       	call   800838 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8004e0:	e8 1d 19 00 00       	call   801e02 <sys_calculate_free_frames>
  8004e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e8:	e8 98 19 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8004ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  8004f0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004f3:	83 ec 0c             	sub    $0xc,%esp
  8004f6:	50                   	push   %eax
  8004f7:	e8 30 16 00 00       	call   801b2c <free>
  8004fc:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  8004ff:	e8 81 19 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800504:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800507:	29 c2                	sub    %eax,%edx
  800509:	89 d0                	mov    %edx,%eax
  80050b:	3d 00 03 00 00       	cmp    $0x300,%eax
  800510:	74 14                	je     800526 <_main+0x4ee>
  800512:	83 ec 04             	sub    $0x4,%esp
  800515:	68 25 26 80 00       	push   $0x802625
  80051a:	6a 76                	push   $0x76
  80051c:	68 7c 25 80 00       	push   $0x80257c
  800521:	e8 12 03 00 00       	call   800838 <_panic>

		//2 MB Hole [Resulting Hole = 2 MB + 2 MB + 4 KB = 4 MB + 4 KB]
		freeFrames = sys_calculate_free_frames() ;
  800526:	e8 d7 18 00 00       	call   801e02 <sys_calculate_free_frames>
  80052b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80052e:	e8 52 19 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800533:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800536:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800539:	83 ec 0c             	sub    $0xc,%esp
  80053c:	50                   	push   %eax
  80053d:	e8 ea 15 00 00       	call   801b2c <free>
  800542:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800545:	e8 3b 19 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80054a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054d:	29 c2                	sub    %eax,%edx
  80054f:	89 d0                	mov    %edx,%eax
  800551:	3d 00 02 00 00       	cmp    $0x200,%eax
  800556:	74 14                	je     80056c <_main+0x534>
  800558:	83 ec 04             	sub    $0x4,%esp
  80055b:	68 25 26 80 00       	push   $0x802625
  800560:	6a 7d                	push   $0x7d
  800562:	68 7c 25 80 00       	push   $0x80257c
  800567:	e8 cc 02 00 00       	call   800838 <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  80056c:	e8 91 18 00 00       	call   801e02 <sys_calculate_free_frames>
  800571:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800574:	e8 0c 19 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800579:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  80057c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80057f:	89 d0                	mov    %edx,%eax
  800581:	c1 e0 02             	shl    $0x2,%eax
  800584:	01 d0                	add    %edx,%eax
  800586:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800589:	83 ec 0c             	sub    $0xc,%esp
  80058c:	50                   	push   %eax
  80058d:	e8 d2 12 00 00       	call   801864 <malloc>
  800592:	83 c4 10             	add    $0x10,%esp
  800595:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  800598:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80059b:	89 c1                	mov    %eax,%ecx
  80059d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005a0:	89 d0                	mov    %edx,%eax
  8005a2:	c1 e0 03             	shl    $0x3,%eax
  8005a5:	01 d0                	add    %edx,%eax
  8005a7:	89 c3                	mov    %eax,%ebx
  8005a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005ac:	89 d0                	mov    %edx,%eax
  8005ae:	01 c0                	add    %eax,%eax
  8005b0:	01 d0                	add    %edx,%eax
  8005b2:	c1 e0 03             	shl    $0x3,%eax
  8005b5:	01 d8                	add    %ebx,%eax
  8005b7:	05 00 00 00 80       	add    $0x80000000,%eax
  8005bc:	39 c1                	cmp    %eax,%ecx
  8005be:	74 17                	je     8005d7 <_main+0x59f>
  8005c0:	83 ec 04             	sub    $0x4,%esp
  8005c3:	68 d8 25 80 00       	push   $0x8025d8
  8005c8:	68 83 00 00 00       	push   $0x83
  8005cd:	68 7c 25 80 00       	push   $0x80257c
  8005d2:	e8 61 02 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  8005d7:	e8 a9 18 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  8005dc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005df:	89 c1                	mov    %eax,%ecx
  8005e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005e4:	89 d0                	mov    %edx,%eax
  8005e6:	c1 e0 02             	shl    $0x2,%eax
  8005e9:	01 d0                	add    %edx,%eax
  8005eb:	85 c0                	test   %eax,%eax
  8005ed:	79 05                	jns    8005f4 <_main+0x5bc>
  8005ef:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f4:	c1 f8 0c             	sar    $0xc,%eax
  8005f7:	39 c1                	cmp    %eax,%ecx
  8005f9:	74 17                	je     800612 <_main+0x5da>
  8005fb:	83 ec 04             	sub    $0x4,%esp
  8005fe:	68 08 26 80 00       	push   $0x802608
  800603:	68 85 00 00 00       	push   $0x85
  800608:	68 7c 25 80 00       	push   $0x80257c
  80060d:	e8 26 02 00 00       	call   800838 <_panic>
//		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
//		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");

		//[FIRST FIT Case]
		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800612:	e8 eb 17 00 00       	call   801e02 <sys_calculate_free_frames>
  800617:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80061a:	e8 66 18 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  80061f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(3*Mega-kilo);
  800622:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800625:	89 c2                	mov    %eax,%edx
  800627:	01 d2                	add    %edx,%edx
  800629:	01 d0                	add    %edx,%eax
  80062b:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80062e:	83 ec 0c             	sub    $0xc,%esp
  800631:	50                   	push   %eax
  800632:	e8 2d 12 00 00       	call   801864 <malloc>
  800637:	83 c4 10             	add    $0x10,%esp
  80063a:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80063d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800640:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800645:	74 17                	je     80065e <_main+0x626>
  800647:	83 ec 04             	sub    $0x4,%esp
  80064a:	68 d8 25 80 00       	push   $0x8025d8
  80064f:	68 93 00 00 00       	push   $0x93
  800654:	68 7c 25 80 00       	push   $0x80257c
  800659:	e8 da 01 00 00       	call   800838 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80065e:	e8 22 18 00 00       	call   801e85 <sys_pf_calculate_allocated_pages>
  800663:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800666:	89 c2                	mov    %eax,%edx
  800668:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80066b:	89 c1                	mov    %eax,%ecx
  80066d:	01 c9                	add    %ecx,%ecx
  80066f:	01 c8                	add    %ecx,%eax
  800671:	85 c0                	test   %eax,%eax
  800673:	79 05                	jns    80067a <_main+0x642>
  800675:	05 ff 0f 00 00       	add    $0xfff,%eax
  80067a:	c1 f8 0c             	sar    $0xc,%eax
  80067d:	39 c2                	cmp    %eax,%edx
  80067f:	74 17                	je     800698 <_main+0x660>
  800681:	83 ec 04             	sub    $0x4,%esp
  800684:	68 08 26 80 00       	push   $0x802608
  800689:	68 95 00 00 00       	push   $0x95
  80068e:	68 7c 25 80 00       	push   $0x80257c
  800693:	e8 a0 01 00 00       	call   800838 <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800698:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80069b:	89 d0                	mov    %edx,%eax
  80069d:	01 c0                	add    %eax,%eax
  80069f:	01 d0                	add    %edx,%eax
  8006a1:	01 c0                	add    %eax,%eax
  8006a3:	01 d0                	add    %edx,%eax
  8006a5:	01 c0                	add    %eax,%eax
  8006a7:	f7 d8                	neg    %eax
  8006a9:	05 00 00 00 20       	add    $0x20000000,%eax
  8006ae:	83 ec 0c             	sub    $0xc,%esp
  8006b1:	50                   	push   %eax
  8006b2:	e8 ad 11 00 00       	call   801864 <malloc>
  8006b7:	83 c4 10             	add    $0x10,%esp
  8006ba:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if (ptr_allocations[9] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8006bd:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006c0:	85 c0                	test   %eax,%eax
  8006c2:	74 17                	je     8006db <_main+0x6a3>
  8006c4:	83 ec 04             	sub    $0x4,%esp
  8006c7:	68 3c 26 80 00       	push   $0x80263c
  8006cc:	68 9e 00 00 00       	push   $0x9e
  8006d1:	68 7c 25 80 00       	push   $0x80257c
  8006d6:	e8 5d 01 00 00       	call   800838 <_panic>

		cprintf("Congratulations!! test FIRST FIT allocation (2) completed successfully.\n");
  8006db:	83 ec 0c             	sub    $0xc,%esp
  8006de:	68 a0 26 80 00       	push   $0x8026a0
  8006e3:	e8 f2 03 00 00       	call   800ada <cprintf>
  8006e8:	83 c4 10             	add    $0x10,%esp

		return;
  8006eb:	90                   	nop
	}
}
  8006ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8006ef:	5b                   	pop    %ebx
  8006f0:	5f                   	pop    %edi
  8006f1:	5d                   	pop    %ebp
  8006f2:	c3                   	ret    

008006f3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006f3:	55                   	push   %ebp
  8006f4:	89 e5                	mov    %esp,%ebp
  8006f6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006f9:	e8 39 16 00 00       	call   801d37 <sys_getenvindex>
  8006fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800701:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800704:	89 d0                	mov    %edx,%eax
  800706:	c1 e0 03             	shl    $0x3,%eax
  800709:	01 d0                	add    %edx,%eax
  80070b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800712:	01 c8                	add    %ecx,%eax
  800714:	01 c0                	add    %eax,%eax
  800716:	01 d0                	add    %edx,%eax
  800718:	01 c0                	add    %eax,%eax
  80071a:	01 d0                	add    %edx,%eax
  80071c:	89 c2                	mov    %eax,%edx
  80071e:	c1 e2 05             	shl    $0x5,%edx
  800721:	29 c2                	sub    %eax,%edx
  800723:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80072a:	89 c2                	mov    %eax,%edx
  80072c:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800732:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800737:	a1 20 30 80 00       	mov    0x803020,%eax
  80073c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800742:	84 c0                	test   %al,%al
  800744:	74 0f                	je     800755 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800746:	a1 20 30 80 00       	mov    0x803020,%eax
  80074b:	05 40 3c 01 00       	add    $0x13c40,%eax
  800750:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800755:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800759:	7e 0a                	jle    800765 <libmain+0x72>
		binaryname = argv[0];
  80075b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075e:	8b 00                	mov    (%eax),%eax
  800760:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 0c             	pushl  0xc(%ebp)
  80076b:	ff 75 08             	pushl  0x8(%ebp)
  80076e:	e8 c5 f8 ff ff       	call   800038 <_main>
  800773:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800776:	e8 57 17 00 00       	call   801ed2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80077b:	83 ec 0c             	sub    $0xc,%esp
  80077e:	68 04 27 80 00       	push   $0x802704
  800783:	e8 52 03 00 00       	call   800ada <cprintf>
  800788:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80078b:	a1 20 30 80 00       	mov    0x803020,%eax
  800790:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800796:	a1 20 30 80 00       	mov    0x803020,%eax
  80079b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8007a1:	83 ec 04             	sub    $0x4,%esp
  8007a4:	52                   	push   %edx
  8007a5:	50                   	push   %eax
  8007a6:	68 2c 27 80 00       	push   $0x80272c
  8007ab:	e8 2a 03 00 00       	call   800ada <cprintf>
  8007b0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8007b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b8:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8007be:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c3:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8007c9:	83 ec 04             	sub    $0x4,%esp
  8007cc:	52                   	push   %edx
  8007cd:	50                   	push   %eax
  8007ce:	68 54 27 80 00       	push   $0x802754
  8007d3:	e8 02 03 00 00       	call   800ada <cprintf>
  8007d8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007db:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e0:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8007e6:	83 ec 08             	sub    $0x8,%esp
  8007e9:	50                   	push   %eax
  8007ea:	68 95 27 80 00       	push   $0x802795
  8007ef:	e8 e6 02 00 00       	call   800ada <cprintf>
  8007f4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007f7:	83 ec 0c             	sub    $0xc,%esp
  8007fa:	68 04 27 80 00       	push   $0x802704
  8007ff:	e8 d6 02 00 00       	call   800ada <cprintf>
  800804:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800807:	e8 e0 16 00 00       	call   801eec <sys_enable_interrupt>

	// exit gracefully
	exit();
  80080c:	e8 19 00 00 00       	call   80082a <exit>
}
  800811:	90                   	nop
  800812:	c9                   	leave  
  800813:	c3                   	ret    

00800814 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800814:	55                   	push   %ebp
  800815:	89 e5                	mov    %esp,%ebp
  800817:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80081a:	83 ec 0c             	sub    $0xc,%esp
  80081d:	6a 00                	push   $0x0
  80081f:	e8 df 14 00 00       	call   801d03 <sys_env_destroy>
  800824:	83 c4 10             	add    $0x10,%esp
}
  800827:	90                   	nop
  800828:	c9                   	leave  
  800829:	c3                   	ret    

0080082a <exit>:

void
exit(void)
{
  80082a:	55                   	push   %ebp
  80082b:	89 e5                	mov    %esp,%ebp
  80082d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800830:	e8 34 15 00 00       	call   801d69 <sys_env_exit>
}
  800835:	90                   	nop
  800836:	c9                   	leave  
  800837:	c3                   	ret    

00800838 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800838:	55                   	push   %ebp
  800839:	89 e5                	mov    %esp,%ebp
  80083b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80083e:	8d 45 10             	lea    0x10(%ebp),%eax
  800841:	83 c0 04             	add    $0x4,%eax
  800844:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800847:	a1 18 31 80 00       	mov    0x803118,%eax
  80084c:	85 c0                	test   %eax,%eax
  80084e:	74 16                	je     800866 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800850:	a1 18 31 80 00       	mov    0x803118,%eax
  800855:	83 ec 08             	sub    $0x8,%esp
  800858:	50                   	push   %eax
  800859:	68 ac 27 80 00       	push   $0x8027ac
  80085e:	e8 77 02 00 00       	call   800ada <cprintf>
  800863:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800866:	a1 00 30 80 00       	mov    0x803000,%eax
  80086b:	ff 75 0c             	pushl  0xc(%ebp)
  80086e:	ff 75 08             	pushl  0x8(%ebp)
  800871:	50                   	push   %eax
  800872:	68 b1 27 80 00       	push   $0x8027b1
  800877:	e8 5e 02 00 00       	call   800ada <cprintf>
  80087c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80087f:	8b 45 10             	mov    0x10(%ebp),%eax
  800882:	83 ec 08             	sub    $0x8,%esp
  800885:	ff 75 f4             	pushl  -0xc(%ebp)
  800888:	50                   	push   %eax
  800889:	e8 e1 01 00 00       	call   800a6f <vcprintf>
  80088e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800891:	83 ec 08             	sub    $0x8,%esp
  800894:	6a 00                	push   $0x0
  800896:	68 cd 27 80 00       	push   $0x8027cd
  80089b:	e8 cf 01 00 00       	call   800a6f <vcprintf>
  8008a0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008a3:	e8 82 ff ff ff       	call   80082a <exit>

	// should not return here
	while (1) ;
  8008a8:	eb fe                	jmp    8008a8 <_panic+0x70>

008008aa <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
  8008ad:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b5:	8b 50 74             	mov    0x74(%eax),%edx
  8008b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bb:	39 c2                	cmp    %eax,%edx
  8008bd:	74 14                	je     8008d3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008bf:	83 ec 04             	sub    $0x4,%esp
  8008c2:	68 d0 27 80 00       	push   $0x8027d0
  8008c7:	6a 26                	push   $0x26
  8008c9:	68 1c 28 80 00       	push   $0x80281c
  8008ce:	e8 65 ff ff ff       	call   800838 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008e1:	e9 b6 00 00 00       	jmp    80099c <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8008e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	01 d0                	add    %edx,%eax
  8008f5:	8b 00                	mov    (%eax),%eax
  8008f7:	85 c0                	test   %eax,%eax
  8008f9:	75 08                	jne    800903 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008fb:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008fe:	e9 96 00 00 00       	jmp    800999 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800903:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80090a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800911:	eb 5d                	jmp    800970 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800913:	a1 20 30 80 00       	mov    0x803020,%eax
  800918:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80091e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800921:	c1 e2 04             	shl    $0x4,%edx
  800924:	01 d0                	add    %edx,%eax
  800926:	8a 40 04             	mov    0x4(%eax),%al
  800929:	84 c0                	test   %al,%al
  80092b:	75 40                	jne    80096d <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80092d:	a1 20 30 80 00       	mov    0x803020,%eax
  800932:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800938:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80093b:	c1 e2 04             	shl    $0x4,%edx
  80093e:	01 d0                	add    %edx,%eax
  800940:	8b 00                	mov    (%eax),%eax
  800942:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800945:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800948:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80094d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80094f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800952:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	01 c8                	add    %ecx,%eax
  80095e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800960:	39 c2                	cmp    %eax,%edx
  800962:	75 09                	jne    80096d <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800964:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80096b:	eb 12                	jmp    80097f <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80096d:	ff 45 e8             	incl   -0x18(%ebp)
  800970:	a1 20 30 80 00       	mov    0x803020,%eax
  800975:	8b 50 74             	mov    0x74(%eax),%edx
  800978:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80097b:	39 c2                	cmp    %eax,%edx
  80097d:	77 94                	ja     800913 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80097f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800983:	75 14                	jne    800999 <CheckWSWithoutLastIndex+0xef>
			panic(
  800985:	83 ec 04             	sub    $0x4,%esp
  800988:	68 28 28 80 00       	push   $0x802828
  80098d:	6a 3a                	push   $0x3a
  80098f:	68 1c 28 80 00       	push   $0x80281c
  800994:	e8 9f fe ff ff       	call   800838 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800999:	ff 45 f0             	incl   -0x10(%ebp)
  80099c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009a2:	0f 8c 3e ff ff ff    	jl     8008e6 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009a8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009b6:	eb 20                	jmp    8009d8 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8009bd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009c3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c6:	c1 e2 04             	shl    $0x4,%edx
  8009c9:	01 d0                	add    %edx,%eax
  8009cb:	8a 40 04             	mov    0x4(%eax),%al
  8009ce:	3c 01                	cmp    $0x1,%al
  8009d0:	75 03                	jne    8009d5 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8009d2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009d5:	ff 45 e0             	incl   -0x20(%ebp)
  8009d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8009dd:	8b 50 74             	mov    0x74(%eax),%edx
  8009e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009e3:	39 c2                	cmp    %eax,%edx
  8009e5:	77 d1                	ja     8009b8 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009ea:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009ed:	74 14                	je     800a03 <CheckWSWithoutLastIndex+0x159>
		panic(
  8009ef:	83 ec 04             	sub    $0x4,%esp
  8009f2:	68 7c 28 80 00       	push   $0x80287c
  8009f7:	6a 44                	push   $0x44
  8009f9:	68 1c 28 80 00       	push   $0x80281c
  8009fe:	e8 35 fe ff ff       	call   800838 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a03:	90                   	nop
  800a04:	c9                   	leave  
  800a05:	c3                   	ret    

00800a06 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a06:	55                   	push   %ebp
  800a07:	89 e5                	mov    %esp,%ebp
  800a09:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0f:	8b 00                	mov    (%eax),%eax
  800a11:	8d 48 01             	lea    0x1(%eax),%ecx
  800a14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a17:	89 0a                	mov    %ecx,(%edx)
  800a19:	8b 55 08             	mov    0x8(%ebp),%edx
  800a1c:	88 d1                	mov    %dl,%cl
  800a1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a21:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a28:	8b 00                	mov    (%eax),%eax
  800a2a:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a2f:	75 2c                	jne    800a5d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a31:	a0 24 30 80 00       	mov    0x803024,%al
  800a36:	0f b6 c0             	movzbl %al,%eax
  800a39:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3c:	8b 12                	mov    (%edx),%edx
  800a3e:	89 d1                	mov    %edx,%ecx
  800a40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a43:	83 c2 08             	add    $0x8,%edx
  800a46:	83 ec 04             	sub    $0x4,%esp
  800a49:	50                   	push   %eax
  800a4a:	51                   	push   %ecx
  800a4b:	52                   	push   %edx
  800a4c:	e8 70 12 00 00       	call   801cc1 <sys_cputs>
  800a51:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a57:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a60:	8b 40 04             	mov    0x4(%eax),%eax
  800a63:	8d 50 01             	lea    0x1(%eax),%edx
  800a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a69:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a6c:	90                   	nop
  800a6d:	c9                   	leave  
  800a6e:	c3                   	ret    

00800a6f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a6f:	55                   	push   %ebp
  800a70:	89 e5                	mov    %esp,%ebp
  800a72:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a78:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a7f:	00 00 00 
	b.cnt = 0;
  800a82:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a89:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a8c:	ff 75 0c             	pushl  0xc(%ebp)
  800a8f:	ff 75 08             	pushl  0x8(%ebp)
  800a92:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a98:	50                   	push   %eax
  800a99:	68 06 0a 80 00       	push   $0x800a06
  800a9e:	e8 11 02 00 00       	call   800cb4 <vprintfmt>
  800aa3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800aa6:	a0 24 30 80 00       	mov    0x803024,%al
  800aab:	0f b6 c0             	movzbl %al,%eax
  800aae:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800ab4:	83 ec 04             	sub    $0x4,%esp
  800ab7:	50                   	push   %eax
  800ab8:	52                   	push   %edx
  800ab9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800abf:	83 c0 08             	add    $0x8,%eax
  800ac2:	50                   	push   %eax
  800ac3:	e8 f9 11 00 00       	call   801cc1 <sys_cputs>
  800ac8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800acb:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800ad2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ad8:	c9                   	leave  
  800ad9:	c3                   	ret    

00800ada <cprintf>:

int cprintf(const char *fmt, ...) {
  800ada:	55                   	push   %ebp
  800adb:	89 e5                	mov    %esp,%ebp
  800add:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ae0:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ae7:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	83 ec 08             	sub    $0x8,%esp
  800af3:	ff 75 f4             	pushl  -0xc(%ebp)
  800af6:	50                   	push   %eax
  800af7:	e8 73 ff ff ff       	call   800a6f <vcprintf>
  800afc:	83 c4 10             	add    $0x10,%esp
  800aff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b02:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b05:	c9                   	leave  
  800b06:	c3                   	ret    

00800b07 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b07:	55                   	push   %ebp
  800b08:	89 e5                	mov    %esp,%ebp
  800b0a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b0d:	e8 c0 13 00 00       	call   801ed2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b12:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b15:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	83 ec 08             	sub    $0x8,%esp
  800b1e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b21:	50                   	push   %eax
  800b22:	e8 48 ff ff ff       	call   800a6f <vcprintf>
  800b27:	83 c4 10             	add    $0x10,%esp
  800b2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b2d:	e8 ba 13 00 00       	call   801eec <sys_enable_interrupt>
	return cnt;
  800b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b35:	c9                   	leave  
  800b36:	c3                   	ret    

00800b37 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b37:	55                   	push   %ebp
  800b38:	89 e5                	mov    %esp,%ebp
  800b3a:	53                   	push   %ebx
  800b3b:	83 ec 14             	sub    $0x14,%esp
  800b3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b44:	8b 45 14             	mov    0x14(%ebp),%eax
  800b47:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b4a:	8b 45 18             	mov    0x18(%ebp),%eax
  800b4d:	ba 00 00 00 00       	mov    $0x0,%edx
  800b52:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b55:	77 55                	ja     800bac <printnum+0x75>
  800b57:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b5a:	72 05                	jb     800b61 <printnum+0x2a>
  800b5c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b5f:	77 4b                	ja     800bac <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b61:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b64:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b67:	8b 45 18             	mov    0x18(%ebp),%eax
  800b6a:	ba 00 00 00 00       	mov    $0x0,%edx
  800b6f:	52                   	push   %edx
  800b70:	50                   	push   %eax
  800b71:	ff 75 f4             	pushl  -0xc(%ebp)
  800b74:	ff 75 f0             	pushl  -0x10(%ebp)
  800b77:	e8 78 17 00 00       	call   8022f4 <__udivdi3>
  800b7c:	83 c4 10             	add    $0x10,%esp
  800b7f:	83 ec 04             	sub    $0x4,%esp
  800b82:	ff 75 20             	pushl  0x20(%ebp)
  800b85:	53                   	push   %ebx
  800b86:	ff 75 18             	pushl  0x18(%ebp)
  800b89:	52                   	push   %edx
  800b8a:	50                   	push   %eax
  800b8b:	ff 75 0c             	pushl  0xc(%ebp)
  800b8e:	ff 75 08             	pushl  0x8(%ebp)
  800b91:	e8 a1 ff ff ff       	call   800b37 <printnum>
  800b96:	83 c4 20             	add    $0x20,%esp
  800b99:	eb 1a                	jmp    800bb5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ba1:	ff 75 20             	pushl  0x20(%ebp)
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	ff d0                	call   *%eax
  800ba9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800bac:	ff 4d 1c             	decl   0x1c(%ebp)
  800baf:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800bb3:	7f e6                	jg     800b9b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800bb5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800bb8:	bb 00 00 00 00       	mov    $0x0,%ebx
  800bbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc3:	53                   	push   %ebx
  800bc4:	51                   	push   %ecx
  800bc5:	52                   	push   %edx
  800bc6:	50                   	push   %eax
  800bc7:	e8 38 18 00 00       	call   802404 <__umoddi3>
  800bcc:	83 c4 10             	add    $0x10,%esp
  800bcf:	05 f4 2a 80 00       	add    $0x802af4,%eax
  800bd4:	8a 00                	mov    (%eax),%al
  800bd6:	0f be c0             	movsbl %al,%eax
  800bd9:	83 ec 08             	sub    $0x8,%esp
  800bdc:	ff 75 0c             	pushl  0xc(%ebp)
  800bdf:	50                   	push   %eax
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	ff d0                	call   *%eax
  800be5:	83 c4 10             	add    $0x10,%esp
}
  800be8:	90                   	nop
  800be9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bec:	c9                   	leave  
  800bed:	c3                   	ret    

00800bee <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bee:	55                   	push   %ebp
  800bef:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bf1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bf5:	7e 1c                	jle    800c13 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	8b 00                	mov    (%eax),%eax
  800bfc:	8d 50 08             	lea    0x8(%eax),%edx
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	89 10                	mov    %edx,(%eax)
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	83 e8 08             	sub    $0x8,%eax
  800c0c:	8b 50 04             	mov    0x4(%eax),%edx
  800c0f:	8b 00                	mov    (%eax),%eax
  800c11:	eb 40                	jmp    800c53 <getuint+0x65>
	else if (lflag)
  800c13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c17:	74 1e                	je     800c37 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	8b 00                	mov    (%eax),%eax
  800c1e:	8d 50 04             	lea    0x4(%eax),%edx
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	89 10                	mov    %edx,(%eax)
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	8b 00                	mov    (%eax),%eax
  800c2b:	83 e8 04             	sub    $0x4,%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	ba 00 00 00 00       	mov    $0x0,%edx
  800c35:	eb 1c                	jmp    800c53 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	8b 00                	mov    (%eax),%eax
  800c3c:	8d 50 04             	lea    0x4(%eax),%edx
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	89 10                	mov    %edx,(%eax)
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	8b 00                	mov    (%eax),%eax
  800c49:	83 e8 04             	sub    $0x4,%eax
  800c4c:	8b 00                	mov    (%eax),%eax
  800c4e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c53:	5d                   	pop    %ebp
  800c54:	c3                   	ret    

00800c55 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c55:	55                   	push   %ebp
  800c56:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c58:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c5c:	7e 1c                	jle    800c7a <getint+0x25>
		return va_arg(*ap, long long);
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	8b 00                	mov    (%eax),%eax
  800c63:	8d 50 08             	lea    0x8(%eax),%edx
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	89 10                	mov    %edx,(%eax)
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	8b 00                	mov    (%eax),%eax
  800c70:	83 e8 08             	sub    $0x8,%eax
  800c73:	8b 50 04             	mov    0x4(%eax),%edx
  800c76:	8b 00                	mov    (%eax),%eax
  800c78:	eb 38                	jmp    800cb2 <getint+0x5d>
	else if (lflag)
  800c7a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c7e:	74 1a                	je     800c9a <getint+0x45>
		return va_arg(*ap, long);
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8b 00                	mov    (%eax),%eax
  800c85:	8d 50 04             	lea    0x4(%eax),%edx
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	89 10                	mov    %edx,(%eax)
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8b 00                	mov    (%eax),%eax
  800c92:	83 e8 04             	sub    $0x4,%eax
  800c95:	8b 00                	mov    (%eax),%eax
  800c97:	99                   	cltd   
  800c98:	eb 18                	jmp    800cb2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8b 00                	mov    (%eax),%eax
  800c9f:	8d 50 04             	lea    0x4(%eax),%edx
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	89 10                	mov    %edx,(%eax)
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	8b 00                	mov    (%eax),%eax
  800cac:	83 e8 04             	sub    $0x4,%eax
  800caf:	8b 00                	mov    (%eax),%eax
  800cb1:	99                   	cltd   
}
  800cb2:	5d                   	pop    %ebp
  800cb3:	c3                   	ret    

00800cb4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800cb4:	55                   	push   %ebp
  800cb5:	89 e5                	mov    %esp,%ebp
  800cb7:	56                   	push   %esi
  800cb8:	53                   	push   %ebx
  800cb9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cbc:	eb 17                	jmp    800cd5 <vprintfmt+0x21>
			if (ch == '\0')
  800cbe:	85 db                	test   %ebx,%ebx
  800cc0:	0f 84 af 03 00 00    	je     801075 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800cc6:	83 ec 08             	sub    $0x8,%esp
  800cc9:	ff 75 0c             	pushl  0xc(%ebp)
  800ccc:	53                   	push   %ebx
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	ff d0                	call   *%eax
  800cd2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd8:	8d 50 01             	lea    0x1(%eax),%edx
  800cdb:	89 55 10             	mov    %edx,0x10(%ebp)
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	0f b6 d8             	movzbl %al,%ebx
  800ce3:	83 fb 25             	cmp    $0x25,%ebx
  800ce6:	75 d6                	jne    800cbe <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ce8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cec:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cf3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cfa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d01:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d08:	8b 45 10             	mov    0x10(%ebp),%eax
  800d0b:	8d 50 01             	lea    0x1(%eax),%edx
  800d0e:	89 55 10             	mov    %edx,0x10(%ebp)
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	0f b6 d8             	movzbl %al,%ebx
  800d16:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d19:	83 f8 55             	cmp    $0x55,%eax
  800d1c:	0f 87 2b 03 00 00    	ja     80104d <vprintfmt+0x399>
  800d22:	8b 04 85 18 2b 80 00 	mov    0x802b18(,%eax,4),%eax
  800d29:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d2b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d2f:	eb d7                	jmp    800d08 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d31:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d35:	eb d1                	jmp    800d08 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d37:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d3e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d41:	89 d0                	mov    %edx,%eax
  800d43:	c1 e0 02             	shl    $0x2,%eax
  800d46:	01 d0                	add    %edx,%eax
  800d48:	01 c0                	add    %eax,%eax
  800d4a:	01 d8                	add    %ebx,%eax
  800d4c:	83 e8 30             	sub    $0x30,%eax
  800d4f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d52:	8b 45 10             	mov    0x10(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d5a:	83 fb 2f             	cmp    $0x2f,%ebx
  800d5d:	7e 3e                	jle    800d9d <vprintfmt+0xe9>
  800d5f:	83 fb 39             	cmp    $0x39,%ebx
  800d62:	7f 39                	jg     800d9d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d64:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d67:	eb d5                	jmp    800d3e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d69:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6c:	83 c0 04             	add    $0x4,%eax
  800d6f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d72:	8b 45 14             	mov    0x14(%ebp),%eax
  800d75:	83 e8 04             	sub    $0x4,%eax
  800d78:	8b 00                	mov    (%eax),%eax
  800d7a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d7d:	eb 1f                	jmp    800d9e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d83:	79 83                	jns    800d08 <vprintfmt+0x54>
				width = 0;
  800d85:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d8c:	e9 77 ff ff ff       	jmp    800d08 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d91:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d98:	e9 6b ff ff ff       	jmp    800d08 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d9d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d9e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da2:	0f 89 60 ff ff ff    	jns    800d08 <vprintfmt+0x54>
				width = precision, precision = -1;
  800da8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800dae:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800db5:	e9 4e ff ff ff       	jmp    800d08 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800dba:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800dbd:	e9 46 ff ff ff       	jmp    800d08 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800dc2:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc5:	83 c0 04             	add    $0x4,%eax
  800dc8:	89 45 14             	mov    %eax,0x14(%ebp)
  800dcb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dce:	83 e8 04             	sub    $0x4,%eax
  800dd1:	8b 00                	mov    (%eax),%eax
  800dd3:	83 ec 08             	sub    $0x8,%esp
  800dd6:	ff 75 0c             	pushl  0xc(%ebp)
  800dd9:	50                   	push   %eax
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	ff d0                	call   *%eax
  800ddf:	83 c4 10             	add    $0x10,%esp
			break;
  800de2:	e9 89 02 00 00       	jmp    801070 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800de7:	8b 45 14             	mov    0x14(%ebp),%eax
  800dea:	83 c0 04             	add    $0x4,%eax
  800ded:	89 45 14             	mov    %eax,0x14(%ebp)
  800df0:	8b 45 14             	mov    0x14(%ebp),%eax
  800df3:	83 e8 04             	sub    $0x4,%eax
  800df6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800df8:	85 db                	test   %ebx,%ebx
  800dfa:	79 02                	jns    800dfe <vprintfmt+0x14a>
				err = -err;
  800dfc:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dfe:	83 fb 64             	cmp    $0x64,%ebx
  800e01:	7f 0b                	jg     800e0e <vprintfmt+0x15a>
  800e03:	8b 34 9d 60 29 80 00 	mov    0x802960(,%ebx,4),%esi
  800e0a:	85 f6                	test   %esi,%esi
  800e0c:	75 19                	jne    800e27 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e0e:	53                   	push   %ebx
  800e0f:	68 05 2b 80 00       	push   $0x802b05
  800e14:	ff 75 0c             	pushl  0xc(%ebp)
  800e17:	ff 75 08             	pushl  0x8(%ebp)
  800e1a:	e8 5e 02 00 00       	call   80107d <printfmt>
  800e1f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e22:	e9 49 02 00 00       	jmp    801070 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e27:	56                   	push   %esi
  800e28:	68 0e 2b 80 00       	push   $0x802b0e
  800e2d:	ff 75 0c             	pushl  0xc(%ebp)
  800e30:	ff 75 08             	pushl  0x8(%ebp)
  800e33:	e8 45 02 00 00       	call   80107d <printfmt>
  800e38:	83 c4 10             	add    $0x10,%esp
			break;
  800e3b:	e9 30 02 00 00       	jmp    801070 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e40:	8b 45 14             	mov    0x14(%ebp),%eax
  800e43:	83 c0 04             	add    $0x4,%eax
  800e46:	89 45 14             	mov    %eax,0x14(%ebp)
  800e49:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4c:	83 e8 04             	sub    $0x4,%eax
  800e4f:	8b 30                	mov    (%eax),%esi
  800e51:	85 f6                	test   %esi,%esi
  800e53:	75 05                	jne    800e5a <vprintfmt+0x1a6>
				p = "(null)";
  800e55:	be 11 2b 80 00       	mov    $0x802b11,%esi
			if (width > 0 && padc != '-')
  800e5a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e5e:	7e 6d                	jle    800ecd <vprintfmt+0x219>
  800e60:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e64:	74 67                	je     800ecd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e66:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e69:	83 ec 08             	sub    $0x8,%esp
  800e6c:	50                   	push   %eax
  800e6d:	56                   	push   %esi
  800e6e:	e8 0c 03 00 00       	call   80117f <strnlen>
  800e73:	83 c4 10             	add    $0x10,%esp
  800e76:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e79:	eb 16                	jmp    800e91 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e7b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e7f:	83 ec 08             	sub    $0x8,%esp
  800e82:	ff 75 0c             	pushl  0xc(%ebp)
  800e85:	50                   	push   %eax
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	ff d0                	call   *%eax
  800e8b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e8e:	ff 4d e4             	decl   -0x1c(%ebp)
  800e91:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e95:	7f e4                	jg     800e7b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e97:	eb 34                	jmp    800ecd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e99:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e9d:	74 1c                	je     800ebb <vprintfmt+0x207>
  800e9f:	83 fb 1f             	cmp    $0x1f,%ebx
  800ea2:	7e 05                	jle    800ea9 <vprintfmt+0x1f5>
  800ea4:	83 fb 7e             	cmp    $0x7e,%ebx
  800ea7:	7e 12                	jle    800ebb <vprintfmt+0x207>
					putch('?', putdat);
  800ea9:	83 ec 08             	sub    $0x8,%esp
  800eac:	ff 75 0c             	pushl  0xc(%ebp)
  800eaf:	6a 3f                	push   $0x3f
  800eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb4:	ff d0                	call   *%eax
  800eb6:	83 c4 10             	add    $0x10,%esp
  800eb9:	eb 0f                	jmp    800eca <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ebb:	83 ec 08             	sub    $0x8,%esp
  800ebe:	ff 75 0c             	pushl  0xc(%ebp)
  800ec1:	53                   	push   %ebx
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	ff d0                	call   *%eax
  800ec7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800eca:	ff 4d e4             	decl   -0x1c(%ebp)
  800ecd:	89 f0                	mov    %esi,%eax
  800ecf:	8d 70 01             	lea    0x1(%eax),%esi
  800ed2:	8a 00                	mov    (%eax),%al
  800ed4:	0f be d8             	movsbl %al,%ebx
  800ed7:	85 db                	test   %ebx,%ebx
  800ed9:	74 24                	je     800eff <vprintfmt+0x24b>
  800edb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800edf:	78 b8                	js     800e99 <vprintfmt+0x1e5>
  800ee1:	ff 4d e0             	decl   -0x20(%ebp)
  800ee4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ee8:	79 af                	jns    800e99 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eea:	eb 13                	jmp    800eff <vprintfmt+0x24b>
				putch(' ', putdat);
  800eec:	83 ec 08             	sub    $0x8,%esp
  800eef:	ff 75 0c             	pushl  0xc(%ebp)
  800ef2:	6a 20                	push   $0x20
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	ff d0                	call   *%eax
  800ef9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800efc:	ff 4d e4             	decl   -0x1c(%ebp)
  800eff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f03:	7f e7                	jg     800eec <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f05:	e9 66 01 00 00       	jmp    801070 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f0a:	83 ec 08             	sub    $0x8,%esp
  800f0d:	ff 75 e8             	pushl  -0x18(%ebp)
  800f10:	8d 45 14             	lea    0x14(%ebp),%eax
  800f13:	50                   	push   %eax
  800f14:	e8 3c fd ff ff       	call   800c55 <getint>
  800f19:	83 c4 10             	add    $0x10,%esp
  800f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f22:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f25:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f28:	85 d2                	test   %edx,%edx
  800f2a:	79 23                	jns    800f4f <vprintfmt+0x29b>
				putch('-', putdat);
  800f2c:	83 ec 08             	sub    $0x8,%esp
  800f2f:	ff 75 0c             	pushl  0xc(%ebp)
  800f32:	6a 2d                	push   $0x2d
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f42:	f7 d8                	neg    %eax
  800f44:	83 d2 00             	adc    $0x0,%edx
  800f47:	f7 da                	neg    %edx
  800f49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f4f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f56:	e9 bc 00 00 00       	jmp    801017 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f5b:	83 ec 08             	sub    $0x8,%esp
  800f5e:	ff 75 e8             	pushl  -0x18(%ebp)
  800f61:	8d 45 14             	lea    0x14(%ebp),%eax
  800f64:	50                   	push   %eax
  800f65:	e8 84 fc ff ff       	call   800bee <getuint>
  800f6a:	83 c4 10             	add    $0x10,%esp
  800f6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f73:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f7a:	e9 98 00 00 00       	jmp    801017 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	6a 58                	push   $0x58
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	ff d0                	call   *%eax
  800f8c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f8f:	83 ec 08             	sub    $0x8,%esp
  800f92:	ff 75 0c             	pushl  0xc(%ebp)
  800f95:	6a 58                	push   $0x58
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	ff d0                	call   *%eax
  800f9c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f9f:	83 ec 08             	sub    $0x8,%esp
  800fa2:	ff 75 0c             	pushl  0xc(%ebp)
  800fa5:	6a 58                	push   $0x58
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	ff d0                	call   *%eax
  800fac:	83 c4 10             	add    $0x10,%esp
			break;
  800faf:	e9 bc 00 00 00       	jmp    801070 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800fb4:	83 ec 08             	sub    $0x8,%esp
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	6a 30                	push   $0x30
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	ff d0                	call   *%eax
  800fc1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800fc4:	83 ec 08             	sub    $0x8,%esp
  800fc7:	ff 75 0c             	pushl  0xc(%ebp)
  800fca:	6a 78                	push   $0x78
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	ff d0                	call   *%eax
  800fd1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fd4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd7:	83 c0 04             	add    $0x4,%eax
  800fda:	89 45 14             	mov    %eax,0x14(%ebp)
  800fdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe0:	83 e8 04             	sub    $0x4,%eax
  800fe3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fe5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fef:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ff6:	eb 1f                	jmp    801017 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ff8:	83 ec 08             	sub    $0x8,%esp
  800ffb:	ff 75 e8             	pushl  -0x18(%ebp)
  800ffe:	8d 45 14             	lea    0x14(%ebp),%eax
  801001:	50                   	push   %eax
  801002:	e8 e7 fb ff ff       	call   800bee <getuint>
  801007:	83 c4 10             	add    $0x10,%esp
  80100a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80100d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801010:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801017:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80101b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80101e:	83 ec 04             	sub    $0x4,%esp
  801021:	52                   	push   %edx
  801022:	ff 75 e4             	pushl  -0x1c(%ebp)
  801025:	50                   	push   %eax
  801026:	ff 75 f4             	pushl  -0xc(%ebp)
  801029:	ff 75 f0             	pushl  -0x10(%ebp)
  80102c:	ff 75 0c             	pushl  0xc(%ebp)
  80102f:	ff 75 08             	pushl  0x8(%ebp)
  801032:	e8 00 fb ff ff       	call   800b37 <printnum>
  801037:	83 c4 20             	add    $0x20,%esp
			break;
  80103a:	eb 34                	jmp    801070 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80103c:	83 ec 08             	sub    $0x8,%esp
  80103f:	ff 75 0c             	pushl  0xc(%ebp)
  801042:	53                   	push   %ebx
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	ff d0                	call   *%eax
  801048:	83 c4 10             	add    $0x10,%esp
			break;
  80104b:	eb 23                	jmp    801070 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80104d:	83 ec 08             	sub    $0x8,%esp
  801050:	ff 75 0c             	pushl  0xc(%ebp)
  801053:	6a 25                	push   $0x25
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	ff d0                	call   *%eax
  80105a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80105d:	ff 4d 10             	decl   0x10(%ebp)
  801060:	eb 03                	jmp    801065 <vprintfmt+0x3b1>
  801062:	ff 4d 10             	decl   0x10(%ebp)
  801065:	8b 45 10             	mov    0x10(%ebp),%eax
  801068:	48                   	dec    %eax
  801069:	8a 00                	mov    (%eax),%al
  80106b:	3c 25                	cmp    $0x25,%al
  80106d:	75 f3                	jne    801062 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80106f:	90                   	nop
		}
	}
  801070:	e9 47 fc ff ff       	jmp    800cbc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801075:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801076:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801079:	5b                   	pop    %ebx
  80107a:	5e                   	pop    %esi
  80107b:	5d                   	pop    %ebp
  80107c:	c3                   	ret    

0080107d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801083:	8d 45 10             	lea    0x10(%ebp),%eax
  801086:	83 c0 04             	add    $0x4,%eax
  801089:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80108c:	8b 45 10             	mov    0x10(%ebp),%eax
  80108f:	ff 75 f4             	pushl  -0xc(%ebp)
  801092:	50                   	push   %eax
  801093:	ff 75 0c             	pushl  0xc(%ebp)
  801096:	ff 75 08             	pushl  0x8(%ebp)
  801099:	e8 16 fc ff ff       	call   800cb4 <vprintfmt>
  80109e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8010a1:	90                   	nop
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8010a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010aa:	8b 40 08             	mov    0x8(%eax),%eax
  8010ad:	8d 50 01             	lea    0x1(%eax),%edx
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8010b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b9:	8b 10                	mov    (%eax),%edx
  8010bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010be:	8b 40 04             	mov    0x4(%eax),%eax
  8010c1:	39 c2                	cmp    %eax,%edx
  8010c3:	73 12                	jae    8010d7 <sprintputch+0x33>
		*b->buf++ = ch;
  8010c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c8:	8b 00                	mov    (%eax),%eax
  8010ca:	8d 48 01             	lea    0x1(%eax),%ecx
  8010cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d0:	89 0a                	mov    %ecx,(%edx)
  8010d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8010d5:	88 10                	mov    %dl,(%eax)
}
  8010d7:	90                   	nop
  8010d8:	5d                   	pop    %ebp
  8010d9:	c3                   	ret    

008010da <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010da:	55                   	push   %ebp
  8010db:	89 e5                	mov    %esp,%ebp
  8010dd:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	01 d0                	add    %edx,%eax
  8010f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ff:	74 06                	je     801107 <vsnprintf+0x2d>
  801101:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801105:	7f 07                	jg     80110e <vsnprintf+0x34>
		return -E_INVAL;
  801107:	b8 03 00 00 00       	mov    $0x3,%eax
  80110c:	eb 20                	jmp    80112e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80110e:	ff 75 14             	pushl  0x14(%ebp)
  801111:	ff 75 10             	pushl  0x10(%ebp)
  801114:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801117:	50                   	push   %eax
  801118:	68 a4 10 80 00       	push   $0x8010a4
  80111d:	e8 92 fb ff ff       	call   800cb4 <vprintfmt>
  801122:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801125:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801128:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80112b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80112e:	c9                   	leave  
  80112f:	c3                   	ret    

00801130 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
  801133:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801136:	8d 45 10             	lea    0x10(%ebp),%eax
  801139:	83 c0 04             	add    $0x4,%eax
  80113c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80113f:	8b 45 10             	mov    0x10(%ebp),%eax
  801142:	ff 75 f4             	pushl  -0xc(%ebp)
  801145:	50                   	push   %eax
  801146:	ff 75 0c             	pushl  0xc(%ebp)
  801149:	ff 75 08             	pushl  0x8(%ebp)
  80114c:	e8 89 ff ff ff       	call   8010da <vsnprintf>
  801151:	83 c4 10             	add    $0x10,%esp
  801154:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801157:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80115a:	c9                   	leave  
  80115b:	c3                   	ret    

0080115c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80115c:	55                   	push   %ebp
  80115d:	89 e5                	mov    %esp,%ebp
  80115f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801162:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801169:	eb 06                	jmp    801171 <strlen+0x15>
		n++;
  80116b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80116e:	ff 45 08             	incl   0x8(%ebp)
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	84 c0                	test   %al,%al
  801178:	75 f1                	jne    80116b <strlen+0xf>
		n++;
	return n;
  80117a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80117d:	c9                   	leave  
  80117e:	c3                   	ret    

0080117f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80117f:	55                   	push   %ebp
  801180:	89 e5                	mov    %esp,%ebp
  801182:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801185:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80118c:	eb 09                	jmp    801197 <strnlen+0x18>
		n++;
  80118e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801191:	ff 45 08             	incl   0x8(%ebp)
  801194:	ff 4d 0c             	decl   0xc(%ebp)
  801197:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80119b:	74 09                	je     8011a6 <strnlen+0x27>
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	84 c0                	test   %al,%al
  8011a4:	75 e8                	jne    80118e <strnlen+0xf>
		n++;
	return n;
  8011a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8011b7:	90                   	nop
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8d 50 01             	lea    0x1(%eax),%edx
  8011be:	89 55 08             	mov    %edx,0x8(%ebp)
  8011c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011ca:	8a 12                	mov    (%edx),%dl
  8011cc:	88 10                	mov    %dl,(%eax)
  8011ce:	8a 00                	mov    (%eax),%al
  8011d0:	84 c0                	test   %al,%al
  8011d2:	75 e4                	jne    8011b8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8011d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011d7:	c9                   	leave  
  8011d8:	c3                   	ret    

008011d9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8011d9:	55                   	push   %ebp
  8011da:	89 e5                	mov    %esp,%ebp
  8011dc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8011e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011ec:	eb 1f                	jmp    80120d <strncpy+0x34>
		*dst++ = *src;
  8011ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f1:	8d 50 01             	lea    0x1(%eax),%edx
  8011f4:	89 55 08             	mov    %edx,0x8(%ebp)
  8011f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011fa:	8a 12                	mov    (%edx),%dl
  8011fc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	84 c0                	test   %al,%al
  801205:	74 03                	je     80120a <strncpy+0x31>
			src++;
  801207:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80120a:	ff 45 fc             	incl   -0x4(%ebp)
  80120d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801210:	3b 45 10             	cmp    0x10(%ebp),%eax
  801213:	72 d9                	jb     8011ee <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801215:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801218:	c9                   	leave  
  801219:	c3                   	ret    

0080121a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80121a:	55                   	push   %ebp
  80121b:	89 e5                	mov    %esp,%ebp
  80121d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801226:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80122a:	74 30                	je     80125c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80122c:	eb 16                	jmp    801244 <strlcpy+0x2a>
			*dst++ = *src++;
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8d 50 01             	lea    0x1(%eax),%edx
  801234:	89 55 08             	mov    %edx,0x8(%ebp)
  801237:	8b 55 0c             	mov    0xc(%ebp),%edx
  80123a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80123d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801240:	8a 12                	mov    (%edx),%dl
  801242:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801244:	ff 4d 10             	decl   0x10(%ebp)
  801247:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80124b:	74 09                	je     801256 <strlcpy+0x3c>
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	84 c0                	test   %al,%al
  801254:	75 d8                	jne    80122e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80125c:	8b 55 08             	mov    0x8(%ebp),%edx
  80125f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801262:	29 c2                	sub    %eax,%edx
  801264:	89 d0                	mov    %edx,%eax
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80126b:	eb 06                	jmp    801273 <strcmp+0xb>
		p++, q++;
  80126d:	ff 45 08             	incl   0x8(%ebp)
  801270:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	8a 00                	mov    (%eax),%al
  801278:	84 c0                	test   %al,%al
  80127a:	74 0e                	je     80128a <strcmp+0x22>
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	8a 10                	mov    (%eax),%dl
  801281:	8b 45 0c             	mov    0xc(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	38 c2                	cmp    %al,%dl
  801288:	74 e3                	je     80126d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80128a:	8b 45 08             	mov    0x8(%ebp),%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	0f b6 d0             	movzbl %al,%edx
  801292:	8b 45 0c             	mov    0xc(%ebp),%eax
  801295:	8a 00                	mov    (%eax),%al
  801297:	0f b6 c0             	movzbl %al,%eax
  80129a:	29 c2                	sub    %eax,%edx
  80129c:	89 d0                	mov    %edx,%eax
}
  80129e:	5d                   	pop    %ebp
  80129f:	c3                   	ret    

008012a0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8012a3:	eb 09                	jmp    8012ae <strncmp+0xe>
		n--, p++, q++;
  8012a5:	ff 4d 10             	decl   0x10(%ebp)
  8012a8:	ff 45 08             	incl   0x8(%ebp)
  8012ab:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8012ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012b2:	74 17                	je     8012cb <strncmp+0x2b>
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	84 c0                	test   %al,%al
  8012bb:	74 0e                	je     8012cb <strncmp+0x2b>
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 10                	mov    (%eax),%dl
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	38 c2                	cmp    %al,%dl
  8012c9:	74 da                	je     8012a5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8012cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012cf:	75 07                	jne    8012d8 <strncmp+0x38>
		return 0;
  8012d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8012d6:	eb 14                	jmp    8012ec <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8a 00                	mov    (%eax),%al
  8012dd:	0f b6 d0             	movzbl %al,%edx
  8012e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	0f b6 c0             	movzbl %al,%eax
  8012e8:	29 c2                	sub    %eax,%edx
  8012ea:	89 d0                	mov    %edx,%eax
}
  8012ec:	5d                   	pop    %ebp
  8012ed:	c3                   	ret    

008012ee <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012ee:	55                   	push   %ebp
  8012ef:	89 e5                	mov    %esp,%ebp
  8012f1:	83 ec 04             	sub    $0x4,%esp
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012fa:	eb 12                	jmp    80130e <strchr+0x20>
		if (*s == c)
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	8a 00                	mov    (%eax),%al
  801301:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801304:	75 05                	jne    80130b <strchr+0x1d>
			return (char *) s;
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	eb 11                	jmp    80131c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80130b:	ff 45 08             	incl   0x8(%ebp)
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	84 c0                	test   %al,%al
  801315:	75 e5                	jne    8012fc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801317:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
  801321:	83 ec 04             	sub    $0x4,%esp
  801324:	8b 45 0c             	mov    0xc(%ebp),%eax
  801327:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80132a:	eb 0d                	jmp    801339 <strfind+0x1b>
		if (*s == c)
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	8a 00                	mov    (%eax),%al
  801331:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801334:	74 0e                	je     801344 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801336:	ff 45 08             	incl   0x8(%ebp)
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8a 00                	mov    (%eax),%al
  80133e:	84 c0                	test   %al,%al
  801340:	75 ea                	jne    80132c <strfind+0xe>
  801342:	eb 01                	jmp    801345 <strfind+0x27>
		if (*s == c)
			break;
  801344:	90                   	nop
	return (char *) s;
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801348:	c9                   	leave  
  801349:	c3                   	ret    

0080134a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
  80134d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801356:	8b 45 10             	mov    0x10(%ebp),%eax
  801359:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80135c:	eb 0e                	jmp    80136c <memset+0x22>
		*p++ = c;
  80135e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801361:	8d 50 01             	lea    0x1(%eax),%edx
  801364:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801367:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80136c:	ff 4d f8             	decl   -0x8(%ebp)
  80136f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801373:	79 e9                	jns    80135e <memset+0x14>
		*p++ = c;

	return v;
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801378:	c9                   	leave  
  801379:	c3                   	ret    

0080137a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80137a:	55                   	push   %ebp
  80137b:	89 e5                	mov    %esp,%ebp
  80137d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801380:	8b 45 0c             	mov    0xc(%ebp),%eax
  801383:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80138c:	eb 16                	jmp    8013a4 <memcpy+0x2a>
		*d++ = *s++;
  80138e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801391:	8d 50 01             	lea    0x1(%eax),%edx
  801394:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801397:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80139a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80139d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013a0:	8a 12                	mov    (%edx),%dl
  8013a2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8013a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8013ad:	85 c0                	test   %eax,%eax
  8013af:	75 dd                	jne    80138e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013b4:	c9                   	leave  
  8013b5:	c3                   	ret    

008013b6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
  8013b9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8013bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8013c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013ce:	73 50                	jae    801420 <memmove+0x6a>
  8013d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d6:	01 d0                	add    %edx,%eax
  8013d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013db:	76 43                	jbe    801420 <memmove+0x6a>
		s += n;
  8013dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8013e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8013e9:	eb 10                	jmp    8013fb <memmove+0x45>
			*--d = *--s;
  8013eb:	ff 4d f8             	decl   -0x8(%ebp)
  8013ee:	ff 4d fc             	decl   -0x4(%ebp)
  8013f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f4:	8a 10                	mov    (%eax),%dl
  8013f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801401:	89 55 10             	mov    %edx,0x10(%ebp)
  801404:	85 c0                	test   %eax,%eax
  801406:	75 e3                	jne    8013eb <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801408:	eb 23                	jmp    80142d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80140a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80140d:	8d 50 01             	lea    0x1(%eax),%edx
  801410:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801413:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801416:	8d 4a 01             	lea    0x1(%edx),%ecx
  801419:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80141c:	8a 12                	mov    (%edx),%dl
  80141e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801420:	8b 45 10             	mov    0x10(%ebp),%eax
  801423:	8d 50 ff             	lea    -0x1(%eax),%edx
  801426:	89 55 10             	mov    %edx,0x10(%ebp)
  801429:	85 c0                	test   %eax,%eax
  80142b:	75 dd                	jne    80140a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80143e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801441:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801444:	eb 2a                	jmp    801470 <memcmp+0x3e>
		if (*s1 != *s2)
  801446:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801449:	8a 10                	mov    (%eax),%dl
  80144b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	38 c2                	cmp    %al,%dl
  801452:	74 16                	je     80146a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801454:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801457:	8a 00                	mov    (%eax),%al
  801459:	0f b6 d0             	movzbl %al,%edx
  80145c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145f:	8a 00                	mov    (%eax),%al
  801461:	0f b6 c0             	movzbl %al,%eax
  801464:	29 c2                	sub    %eax,%edx
  801466:	89 d0                	mov    %edx,%eax
  801468:	eb 18                	jmp    801482 <memcmp+0x50>
		s1++, s2++;
  80146a:	ff 45 fc             	incl   -0x4(%ebp)
  80146d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801470:	8b 45 10             	mov    0x10(%ebp),%eax
  801473:	8d 50 ff             	lea    -0x1(%eax),%edx
  801476:	89 55 10             	mov    %edx,0x10(%ebp)
  801479:	85 c0                	test   %eax,%eax
  80147b:	75 c9                	jne    801446 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80147d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801482:	c9                   	leave  
  801483:	c3                   	ret    

00801484 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801484:	55                   	push   %ebp
  801485:	89 e5                	mov    %esp,%ebp
  801487:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80148a:	8b 55 08             	mov    0x8(%ebp),%edx
  80148d:	8b 45 10             	mov    0x10(%ebp),%eax
  801490:	01 d0                	add    %edx,%eax
  801492:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801495:	eb 15                	jmp    8014ac <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	8a 00                	mov    (%eax),%al
  80149c:	0f b6 d0             	movzbl %al,%edx
  80149f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a2:	0f b6 c0             	movzbl %al,%eax
  8014a5:	39 c2                	cmp    %eax,%edx
  8014a7:	74 0d                	je     8014b6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8014a9:	ff 45 08             	incl   0x8(%ebp)
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014b2:	72 e3                	jb     801497 <memfind+0x13>
  8014b4:	eb 01                	jmp    8014b7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8014b6:	90                   	nop
	return (void *) s;
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
  8014bf:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8014c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8014c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014d0:	eb 03                	jmp    8014d5 <strtol+0x19>
		s++;
  8014d2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	8a 00                	mov    (%eax),%al
  8014da:	3c 20                	cmp    $0x20,%al
  8014dc:	74 f4                	je     8014d2 <strtol+0x16>
  8014de:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e1:	8a 00                	mov    (%eax),%al
  8014e3:	3c 09                	cmp    $0x9,%al
  8014e5:	74 eb                	je     8014d2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	8a 00                	mov    (%eax),%al
  8014ec:	3c 2b                	cmp    $0x2b,%al
  8014ee:	75 05                	jne    8014f5 <strtol+0x39>
		s++;
  8014f0:	ff 45 08             	incl   0x8(%ebp)
  8014f3:	eb 13                	jmp    801508 <strtol+0x4c>
	else if (*s == '-')
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	8a 00                	mov    (%eax),%al
  8014fa:	3c 2d                	cmp    $0x2d,%al
  8014fc:	75 0a                	jne    801508 <strtol+0x4c>
		s++, neg = 1;
  8014fe:	ff 45 08             	incl   0x8(%ebp)
  801501:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801508:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80150c:	74 06                	je     801514 <strtol+0x58>
  80150e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801512:	75 20                	jne    801534 <strtol+0x78>
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	8a 00                	mov    (%eax),%al
  801519:	3c 30                	cmp    $0x30,%al
  80151b:	75 17                	jne    801534 <strtol+0x78>
  80151d:	8b 45 08             	mov    0x8(%ebp),%eax
  801520:	40                   	inc    %eax
  801521:	8a 00                	mov    (%eax),%al
  801523:	3c 78                	cmp    $0x78,%al
  801525:	75 0d                	jne    801534 <strtol+0x78>
		s += 2, base = 16;
  801527:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80152b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801532:	eb 28                	jmp    80155c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801534:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801538:	75 15                	jne    80154f <strtol+0x93>
  80153a:	8b 45 08             	mov    0x8(%ebp),%eax
  80153d:	8a 00                	mov    (%eax),%al
  80153f:	3c 30                	cmp    $0x30,%al
  801541:	75 0c                	jne    80154f <strtol+0x93>
		s++, base = 8;
  801543:	ff 45 08             	incl   0x8(%ebp)
  801546:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80154d:	eb 0d                	jmp    80155c <strtol+0xa0>
	else if (base == 0)
  80154f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801553:	75 07                	jne    80155c <strtol+0xa0>
		base = 10;
  801555:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	3c 2f                	cmp    $0x2f,%al
  801563:	7e 19                	jle    80157e <strtol+0xc2>
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	8a 00                	mov    (%eax),%al
  80156a:	3c 39                	cmp    $0x39,%al
  80156c:	7f 10                	jg     80157e <strtol+0xc2>
			dig = *s - '0';
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
  801571:	8a 00                	mov    (%eax),%al
  801573:	0f be c0             	movsbl %al,%eax
  801576:	83 e8 30             	sub    $0x30,%eax
  801579:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80157c:	eb 42                	jmp    8015c0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	3c 60                	cmp    $0x60,%al
  801585:	7e 19                	jle    8015a0 <strtol+0xe4>
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	3c 7a                	cmp    $0x7a,%al
  80158e:	7f 10                	jg     8015a0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801590:	8b 45 08             	mov    0x8(%ebp),%eax
  801593:	8a 00                	mov    (%eax),%al
  801595:	0f be c0             	movsbl %al,%eax
  801598:	83 e8 57             	sub    $0x57,%eax
  80159b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80159e:	eb 20                	jmp    8015c0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	8a 00                	mov    (%eax),%al
  8015a5:	3c 40                	cmp    $0x40,%al
  8015a7:	7e 39                	jle    8015e2 <strtol+0x126>
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	8a 00                	mov    (%eax),%al
  8015ae:	3c 5a                	cmp    $0x5a,%al
  8015b0:	7f 30                	jg     8015e2 <strtol+0x126>
			dig = *s - 'A' + 10;
  8015b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b5:	8a 00                	mov    (%eax),%al
  8015b7:	0f be c0             	movsbl %al,%eax
  8015ba:	83 e8 37             	sub    $0x37,%eax
  8015bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8015c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015c6:	7d 19                	jge    8015e1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8015c8:	ff 45 08             	incl   0x8(%ebp)
  8015cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ce:	0f af 45 10          	imul   0x10(%ebp),%eax
  8015d2:	89 c2                	mov    %eax,%edx
  8015d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015d7:	01 d0                	add    %edx,%eax
  8015d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8015dc:	e9 7b ff ff ff       	jmp    80155c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8015e1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8015e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015e6:	74 08                	je     8015f0 <strtol+0x134>
		*endptr = (char *) s;
  8015e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8015ee:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015f4:	74 07                	je     8015fd <strtol+0x141>
  8015f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f9:	f7 d8                	neg    %eax
  8015fb:	eb 03                	jmp    801600 <strtol+0x144>
  8015fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <ltostr>:

void
ltostr(long value, char *str)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
  801605:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801608:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80160f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801616:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80161a:	79 13                	jns    80162f <ltostr+0x2d>
	{
		neg = 1;
  80161c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801623:	8b 45 0c             	mov    0xc(%ebp),%eax
  801626:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801629:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80162c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801637:	99                   	cltd   
  801638:	f7 f9                	idiv   %ecx
  80163a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80163d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801640:	8d 50 01             	lea    0x1(%eax),%edx
  801643:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801646:	89 c2                	mov    %eax,%edx
  801648:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164b:	01 d0                	add    %edx,%eax
  80164d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801650:	83 c2 30             	add    $0x30,%edx
  801653:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801655:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801658:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80165d:	f7 e9                	imul   %ecx
  80165f:	c1 fa 02             	sar    $0x2,%edx
  801662:	89 c8                	mov    %ecx,%eax
  801664:	c1 f8 1f             	sar    $0x1f,%eax
  801667:	29 c2                	sub    %eax,%edx
  801669:	89 d0                	mov    %edx,%eax
  80166b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80166e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801671:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801676:	f7 e9                	imul   %ecx
  801678:	c1 fa 02             	sar    $0x2,%edx
  80167b:	89 c8                	mov    %ecx,%eax
  80167d:	c1 f8 1f             	sar    $0x1f,%eax
  801680:	29 c2                	sub    %eax,%edx
  801682:	89 d0                	mov    %edx,%eax
  801684:	c1 e0 02             	shl    $0x2,%eax
  801687:	01 d0                	add    %edx,%eax
  801689:	01 c0                	add    %eax,%eax
  80168b:	29 c1                	sub    %eax,%ecx
  80168d:	89 ca                	mov    %ecx,%edx
  80168f:	85 d2                	test   %edx,%edx
  801691:	75 9c                	jne    80162f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801693:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80169a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80169d:	48                   	dec    %eax
  80169e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8016a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016a5:	74 3d                	je     8016e4 <ltostr+0xe2>
		start = 1 ;
  8016a7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8016ae:	eb 34                	jmp    8016e4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8016b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b6:	01 d0                	add    %edx,%eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8016bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c3:	01 c2                	add    %eax,%edx
  8016c5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8016c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cb:	01 c8                	add    %ecx,%eax
  8016cd:	8a 00                	mov    (%eax),%al
  8016cf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8016d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d7:	01 c2                	add    %eax,%edx
  8016d9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8016dc:	88 02                	mov    %al,(%edx)
		start++ ;
  8016de:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8016e1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8016e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016e7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016ea:	7c c4                	jl     8016b0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f2:	01 d0                	add    %edx,%eax
  8016f4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016f7:	90                   	nop
  8016f8:	c9                   	leave  
  8016f9:	c3                   	ret    

008016fa <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016fa:	55                   	push   %ebp
  8016fb:	89 e5                	mov    %esp,%ebp
  8016fd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801700:	ff 75 08             	pushl  0x8(%ebp)
  801703:	e8 54 fa ff ff       	call   80115c <strlen>
  801708:	83 c4 04             	add    $0x4,%esp
  80170b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80170e:	ff 75 0c             	pushl  0xc(%ebp)
  801711:	e8 46 fa ff ff       	call   80115c <strlen>
  801716:	83 c4 04             	add    $0x4,%esp
  801719:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80171c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801723:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80172a:	eb 17                	jmp    801743 <strcconcat+0x49>
		final[s] = str1[s] ;
  80172c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80172f:	8b 45 10             	mov    0x10(%ebp),%eax
  801732:	01 c2                	add    %eax,%edx
  801734:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	01 c8                	add    %ecx,%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801740:	ff 45 fc             	incl   -0x4(%ebp)
  801743:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801746:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801749:	7c e1                	jl     80172c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80174b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801752:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801759:	eb 1f                	jmp    80177a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80175b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80175e:	8d 50 01             	lea    0x1(%eax),%edx
  801761:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801764:	89 c2                	mov    %eax,%edx
  801766:	8b 45 10             	mov    0x10(%ebp),%eax
  801769:	01 c2                	add    %eax,%edx
  80176b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80176e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801771:	01 c8                	add    %ecx,%eax
  801773:	8a 00                	mov    (%eax),%al
  801775:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801777:	ff 45 f8             	incl   -0x8(%ebp)
  80177a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80177d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801780:	7c d9                	jl     80175b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801782:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801785:	8b 45 10             	mov    0x10(%ebp),%eax
  801788:	01 d0                	add    %edx,%eax
  80178a:	c6 00 00             	movb   $0x0,(%eax)
}
  80178d:	90                   	nop
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801793:	8b 45 14             	mov    0x14(%ebp),%eax
  801796:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80179c:	8b 45 14             	mov    0x14(%ebp),%eax
  80179f:	8b 00                	mov    (%eax),%eax
  8017a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ab:	01 d0                	add    %edx,%eax
  8017ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017b3:	eb 0c                	jmp    8017c1 <strsplit+0x31>
			*string++ = 0;
  8017b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b8:	8d 50 01             	lea    0x1(%eax),%edx
  8017bb:	89 55 08             	mov    %edx,0x8(%ebp)
  8017be:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	8a 00                	mov    (%eax),%al
  8017c6:	84 c0                	test   %al,%al
  8017c8:	74 18                	je     8017e2 <strsplit+0x52>
  8017ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cd:	8a 00                	mov    (%eax),%al
  8017cf:	0f be c0             	movsbl %al,%eax
  8017d2:	50                   	push   %eax
  8017d3:	ff 75 0c             	pushl  0xc(%ebp)
  8017d6:	e8 13 fb ff ff       	call   8012ee <strchr>
  8017db:	83 c4 08             	add    $0x8,%esp
  8017de:	85 c0                	test   %eax,%eax
  8017e0:	75 d3                	jne    8017b5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8017e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e5:	8a 00                	mov    (%eax),%al
  8017e7:	84 c0                	test   %al,%al
  8017e9:	74 5a                	je     801845 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8017eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8017ee:	8b 00                	mov    (%eax),%eax
  8017f0:	83 f8 0f             	cmp    $0xf,%eax
  8017f3:	75 07                	jne    8017fc <strsplit+0x6c>
		{
			return 0;
  8017f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8017fa:	eb 66                	jmp    801862 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8017ff:	8b 00                	mov    (%eax),%eax
  801801:	8d 48 01             	lea    0x1(%eax),%ecx
  801804:	8b 55 14             	mov    0x14(%ebp),%edx
  801807:	89 0a                	mov    %ecx,(%edx)
  801809:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801810:	8b 45 10             	mov    0x10(%ebp),%eax
  801813:	01 c2                	add    %eax,%edx
  801815:	8b 45 08             	mov    0x8(%ebp),%eax
  801818:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80181a:	eb 03                	jmp    80181f <strsplit+0x8f>
			string++;
  80181c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	84 c0                	test   %al,%al
  801826:	74 8b                	je     8017b3 <strsplit+0x23>
  801828:	8b 45 08             	mov    0x8(%ebp),%eax
  80182b:	8a 00                	mov    (%eax),%al
  80182d:	0f be c0             	movsbl %al,%eax
  801830:	50                   	push   %eax
  801831:	ff 75 0c             	pushl  0xc(%ebp)
  801834:	e8 b5 fa ff ff       	call   8012ee <strchr>
  801839:	83 c4 08             	add    $0x8,%esp
  80183c:	85 c0                	test   %eax,%eax
  80183e:	74 dc                	je     80181c <strsplit+0x8c>
			string++;
	}
  801840:	e9 6e ff ff ff       	jmp    8017b3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801845:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801846:	8b 45 14             	mov    0x14(%ebp),%eax
  801849:	8b 00                	mov    (%eax),%eax
  80184b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801852:	8b 45 10             	mov    0x10(%ebp),%eax
  801855:	01 d0                	add    %edx,%eax
  801857:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80185d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80186a:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801871:	76 0a                	jbe    80187d <malloc+0x19>
		return NULL;
  801873:	b8 00 00 00 00       	mov    $0x0,%eax
  801878:	e9 ad 02 00 00       	jmp    801b2a <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	c1 e8 0c             	shr    $0xc,%eax
  801883:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801886:	8b 45 08             	mov    0x8(%ebp),%eax
  801889:	25 ff 0f 00 00       	and    $0xfff,%eax
  80188e:	85 c0                	test   %eax,%eax
  801890:	74 03                	je     801895 <malloc+0x31>
		num++;
  801892:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801895:	a1 28 30 80 00       	mov    0x803028,%eax
  80189a:	85 c0                	test   %eax,%eax
  80189c:	75 71                	jne    80190f <malloc+0xab>
		sys_allocateMem(last_addres, size);
  80189e:	a1 04 30 80 00       	mov    0x803004,%eax
  8018a3:	83 ec 08             	sub    $0x8,%esp
  8018a6:	ff 75 08             	pushl  0x8(%ebp)
  8018a9:	50                   	push   %eax
  8018aa:	e8 ba 05 00 00       	call   801e69 <sys_allocateMem>
  8018af:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  8018b2:	a1 04 30 80 00       	mov    0x803004,%eax
  8018b7:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  8018ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018bd:	c1 e0 0c             	shl    $0xc,%eax
  8018c0:	89 c2                	mov    %eax,%edx
  8018c2:	a1 04 30 80 00       	mov    0x803004,%eax
  8018c7:	01 d0                	add    %edx,%eax
  8018c9:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8018ce:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018d6:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8018dd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018e2:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8018e5:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  8018ec:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018f1:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8018f8:	01 00 00 00 
		sizeofarray++;
  8018fc:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801901:	40                   	inc    %eax
  801902:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  801907:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80190a:	e9 1b 02 00 00       	jmp    801b2a <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  80190f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801916:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  80191d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801924:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  80192b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801932:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801939:	eb 72                	jmp    8019ad <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  80193b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80193e:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801945:	85 c0                	test   %eax,%eax
  801947:	75 12                	jne    80195b <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801949:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80194c:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801953:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801956:	ff 45 dc             	incl   -0x24(%ebp)
  801959:	eb 4f                	jmp    8019aa <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  80195b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80195e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801961:	7d 39                	jge    80199c <malloc+0x138>
  801963:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801966:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801969:	7c 31                	jl     80199c <malloc+0x138>
					{
						min=count;
  80196b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80196e:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801971:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801974:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80197b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80197e:	c1 e2 0c             	shl    $0xc,%edx
  801981:	29 d0                	sub    %edx,%eax
  801983:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801986:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801989:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80198c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  80198f:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801996:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801999:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  80199c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  8019a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  8019aa:	ff 45 d4             	incl   -0x2c(%ebp)
  8019ad:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019b2:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  8019b5:	7c 84                	jl     80193b <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  8019b7:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  8019bb:	0f 85 e3 00 00 00    	jne    801aa4 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  8019c1:	83 ec 08             	sub    $0x8,%esp
  8019c4:	ff 75 08             	pushl  0x8(%ebp)
  8019c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8019ca:	e8 9a 04 00 00       	call   801e69 <sys_allocateMem>
  8019cf:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  8019d2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019d7:	40                   	inc    %eax
  8019d8:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  8019dd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019e2:	48                   	dec    %eax
  8019e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8019e6:	eb 42                	jmp    801a2a <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  8019e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8019eb:	48                   	dec    %eax
  8019ec:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  8019f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8019f6:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  8019fd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a00:	48                   	dec    %eax
  801a01:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801a08:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a0b:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801a12:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a15:	48                   	dec    %eax
  801a16:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801a1d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a20:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801a27:	ff 4d d0             	decl   -0x30(%ebp)
  801a2a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a2d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a30:	7f b6                	jg     8019e8 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a35:	40                   	inc    %eax
  801a36:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801a39:	8b 55 08             	mov    0x8(%ebp),%edx
  801a3c:	01 ca                	add    %ecx,%edx
  801a3e:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801a45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a48:	8d 50 01             	lea    0x1(%eax),%edx
  801a4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a4e:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a55:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801a58:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801a5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a62:	40                   	inc    %eax
  801a63:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801a6a:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801a6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a71:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a74:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801a7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a7e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801a81:	eb 11                	jmp    801a94 <malloc+0x230>
				{
					changed[index] = 1;
  801a83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a86:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801a8d:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801a91:	ff 45 cc             	incl   -0x34(%ebp)
  801a94:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801a97:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a9a:	7c e7                	jl     801a83 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801a9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a9f:	e9 86 00 00 00       	jmp    801b2a <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801aa4:	a1 04 30 80 00       	mov    0x803004,%eax
  801aa9:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801aae:	29 c2                	sub    %eax,%edx
  801ab0:	89 d0                	mov    %edx,%eax
  801ab2:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ab5:	73 07                	jae    801abe <malloc+0x25a>
						return NULL;
  801ab7:	b8 00 00 00 00       	mov    $0x0,%eax
  801abc:	eb 6c                	jmp    801b2a <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801abe:	a1 04 30 80 00       	mov    0x803004,%eax
  801ac3:	83 ec 08             	sub    $0x8,%esp
  801ac6:	ff 75 08             	pushl  0x8(%ebp)
  801ac9:	50                   	push   %eax
  801aca:	e8 9a 03 00 00       	call   801e69 <sys_allocateMem>
  801acf:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801ad2:	a1 04 30 80 00       	mov    0x803004,%eax
  801ad7:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801add:	c1 e0 0c             	shl    $0xc,%eax
  801ae0:	89 c2                	mov    %eax,%edx
  801ae2:	a1 04 30 80 00       	mov    0x803004,%eax
  801ae7:	01 d0                	add    %edx,%eax
  801ae9:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801aee:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801af3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801af6:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801afd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b02:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801b05:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801b0c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b11:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801b18:	01 00 00 00 
					sizeofarray++;
  801b1c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b21:	40                   	inc    %eax
  801b22:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  801b27:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801b2a:	c9                   	leave  
  801b2b:	c3                   	ret    

00801b2c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b2c:	55                   	push   %ebp
  801b2d:	89 e5                	mov    %esp,%ebp
  801b2f:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801b32:	8b 45 08             	mov    0x8(%ebp),%eax
  801b35:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801b38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801b3f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801b46:	eb 30                	jmp    801b78 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b4b:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801b52:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b55:	75 1e                	jne    801b75 <free+0x49>
  801b57:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b5a:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801b61:	83 f8 01             	cmp    $0x1,%eax
  801b64:	75 0f                	jne    801b75 <free+0x49>
			is_found = 1;
  801b66:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801b6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b70:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801b73:	eb 0d                	jmp    801b82 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801b75:	ff 45 ec             	incl   -0x14(%ebp)
  801b78:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b7d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801b80:	7c c6                	jl     801b48 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801b82:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801b86:	75 3a                	jne    801bc2 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b8b:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b92:	c1 e0 0c             	shl    $0xc,%eax
  801b95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801b98:	83 ec 08             	sub    $0x8,%esp
  801b9b:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b9e:	ff 75 e8             	pushl  -0x18(%ebp)
  801ba1:	e8 a7 02 00 00       	call   801e4d <sys_freeMem>
  801ba6:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801ba9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bac:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801bb3:	00 00 00 00 
		changes++;
  801bb7:	a1 28 30 80 00       	mov    0x803028,%eax
  801bbc:	40                   	inc    %eax
  801bbd:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801bc2:	90                   	nop
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
  801bc8:	83 ec 18             	sub    $0x18,%esp
  801bcb:	8b 45 10             	mov    0x10(%ebp),%eax
  801bce:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801bd1:	83 ec 04             	sub    $0x4,%esp
  801bd4:	68 70 2c 80 00       	push   $0x802c70
  801bd9:	68 b6 00 00 00       	push   $0xb6
  801bde:	68 93 2c 80 00       	push   $0x802c93
  801be3:	e8 50 ec ff ff       	call   800838 <_panic>

00801be8 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801be8:	55                   	push   %ebp
  801be9:	89 e5                	mov    %esp,%ebp
  801beb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bee:	83 ec 04             	sub    $0x4,%esp
  801bf1:	68 70 2c 80 00       	push   $0x802c70
  801bf6:	68 bb 00 00 00       	push   $0xbb
  801bfb:	68 93 2c 80 00       	push   $0x802c93
  801c00:	e8 33 ec ff ff       	call   800838 <_panic>

00801c05 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c0b:	83 ec 04             	sub    $0x4,%esp
  801c0e:	68 70 2c 80 00       	push   $0x802c70
  801c13:	68 c0 00 00 00       	push   $0xc0
  801c18:	68 93 2c 80 00       	push   $0x802c93
  801c1d:	e8 16 ec ff ff       	call   800838 <_panic>

00801c22 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801c22:	55                   	push   %ebp
  801c23:	89 e5                	mov    %esp,%ebp
  801c25:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c28:	83 ec 04             	sub    $0x4,%esp
  801c2b:	68 70 2c 80 00       	push   $0x802c70
  801c30:	68 c4 00 00 00       	push   $0xc4
  801c35:	68 93 2c 80 00       	push   $0x802c93
  801c3a:	e8 f9 eb ff ff       	call   800838 <_panic>

00801c3f <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
  801c42:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c45:	83 ec 04             	sub    $0x4,%esp
  801c48:	68 70 2c 80 00       	push   $0x802c70
  801c4d:	68 c9 00 00 00       	push   $0xc9
  801c52:	68 93 2c 80 00       	push   $0x802c93
  801c57:	e8 dc eb ff ff       	call   800838 <_panic>

00801c5c <shrink>:
}
void shrink(uint32 newSize) {
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
  801c5f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c62:	83 ec 04             	sub    $0x4,%esp
  801c65:	68 70 2c 80 00       	push   $0x802c70
  801c6a:	68 cc 00 00 00       	push   $0xcc
  801c6f:	68 93 2c 80 00       	push   $0x802c93
  801c74:	e8 bf eb ff ff       	call   800838 <_panic>

00801c79 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
  801c7c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c7f:	83 ec 04             	sub    $0x4,%esp
  801c82:	68 70 2c 80 00       	push   $0x802c70
  801c87:	68 d0 00 00 00       	push   $0xd0
  801c8c:	68 93 2c 80 00       	push   $0x802c93
  801c91:	e8 a2 eb ff ff       	call   800838 <_panic>

00801c96 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c96:	55                   	push   %ebp
  801c97:	89 e5                	mov    %esp,%ebp
  801c99:	57                   	push   %edi
  801c9a:	56                   	push   %esi
  801c9b:	53                   	push   %ebx
  801c9c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ca8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cab:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cae:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cb1:	cd 30                	int    $0x30
  801cb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cb9:	83 c4 10             	add    $0x10,%esp
  801cbc:	5b                   	pop    %ebx
  801cbd:	5e                   	pop    %esi
  801cbe:	5f                   	pop    %edi
  801cbf:	5d                   	pop    %ebp
  801cc0:	c3                   	ret    

00801cc1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
  801cc4:	83 ec 04             	sub    $0x4,%esp
  801cc7:	8b 45 10             	mov    0x10(%ebp),%eax
  801cca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ccd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	52                   	push   %edx
  801cd9:	ff 75 0c             	pushl  0xc(%ebp)
  801cdc:	50                   	push   %eax
  801cdd:	6a 00                	push   $0x0
  801cdf:	e8 b2 ff ff ff       	call   801c96 <syscall>
  801ce4:	83 c4 18             	add    $0x18,%esp
}
  801ce7:	90                   	nop
  801ce8:	c9                   	leave  
  801ce9:	c3                   	ret    

00801cea <sys_cgetc>:

int
sys_cgetc(void)
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 01                	push   $0x1
  801cf9:	e8 98 ff ff ff       	call   801c96 <syscall>
  801cfe:	83 c4 18             	add    $0x18,%esp
}
  801d01:	c9                   	leave  
  801d02:	c3                   	ret    

00801d03 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d03:	55                   	push   %ebp
  801d04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d06:	8b 45 08             	mov    0x8(%ebp),%eax
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	50                   	push   %eax
  801d12:	6a 05                	push   $0x5
  801d14:	e8 7d ff ff ff       	call   801c96 <syscall>
  801d19:	83 c4 18             	add    $0x18,%esp
}
  801d1c:	c9                   	leave  
  801d1d:	c3                   	ret    

00801d1e <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d1e:	55                   	push   %ebp
  801d1f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 02                	push   $0x2
  801d2d:	e8 64 ff ff ff       	call   801c96 <syscall>
  801d32:	83 c4 18             	add    $0x18,%esp
}
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 03                	push   $0x3
  801d46:	e8 4b ff ff ff       	call   801c96 <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
}
  801d4e:	c9                   	leave  
  801d4f:	c3                   	ret    

00801d50 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d50:	55                   	push   %ebp
  801d51:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 04                	push   $0x4
  801d5f:	e8 32 ff ff ff       	call   801c96 <syscall>
  801d64:	83 c4 18             	add    $0x18,%esp
}
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <sys_env_exit>:


void sys_env_exit(void)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 06                	push   $0x6
  801d78:	e8 19 ff ff ff       	call   801c96 <syscall>
  801d7d:	83 c4 18             	add    $0x18,%esp
}
  801d80:	90                   	nop
  801d81:	c9                   	leave  
  801d82:	c3                   	ret    

00801d83 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d83:	55                   	push   %ebp
  801d84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d86:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d89:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	52                   	push   %edx
  801d93:	50                   	push   %eax
  801d94:	6a 07                	push   $0x7
  801d96:	e8 fb fe ff ff       	call   801c96 <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
}
  801d9e:	c9                   	leave  
  801d9f:	c3                   	ret    

00801da0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801da0:	55                   	push   %ebp
  801da1:	89 e5                	mov    %esp,%ebp
  801da3:	56                   	push   %esi
  801da4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801da5:	8b 75 18             	mov    0x18(%ebp),%esi
  801da8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db1:	8b 45 08             	mov    0x8(%ebp),%eax
  801db4:	56                   	push   %esi
  801db5:	53                   	push   %ebx
  801db6:	51                   	push   %ecx
  801db7:	52                   	push   %edx
  801db8:	50                   	push   %eax
  801db9:	6a 08                	push   $0x8
  801dbb:	e8 d6 fe ff ff       	call   801c96 <syscall>
  801dc0:	83 c4 18             	add    $0x18,%esp
}
  801dc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dc6:	5b                   	pop    %ebx
  801dc7:	5e                   	pop    %esi
  801dc8:	5d                   	pop    %ebp
  801dc9:	c3                   	ret    

00801dca <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801dca:	55                   	push   %ebp
  801dcb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801dcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	52                   	push   %edx
  801dda:	50                   	push   %eax
  801ddb:	6a 09                	push   $0x9
  801ddd:	e8 b4 fe ff ff       	call   801c96 <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
}
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	ff 75 0c             	pushl  0xc(%ebp)
  801df3:	ff 75 08             	pushl  0x8(%ebp)
  801df6:	6a 0a                	push   $0xa
  801df8:	e8 99 fe ff ff       	call   801c96 <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	c9                   	leave  
  801e01:	c3                   	ret    

00801e02 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e02:	55                   	push   %ebp
  801e03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 0b                	push   $0xb
  801e11:	e8 80 fe ff ff       	call   801c96 <syscall>
  801e16:	83 c4 18             	add    $0x18,%esp
}
  801e19:	c9                   	leave  
  801e1a:	c3                   	ret    

00801e1b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e1b:	55                   	push   %ebp
  801e1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 0c                	push   $0xc
  801e2a:	e8 67 fe ff ff       	call   801c96 <syscall>
  801e2f:	83 c4 18             	add    $0x18,%esp
}
  801e32:	c9                   	leave  
  801e33:	c3                   	ret    

00801e34 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e34:	55                   	push   %ebp
  801e35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 0d                	push   $0xd
  801e43:	e8 4e fe ff ff       	call   801c96 <syscall>
  801e48:	83 c4 18             	add    $0x18,%esp
}
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	ff 75 0c             	pushl  0xc(%ebp)
  801e59:	ff 75 08             	pushl  0x8(%ebp)
  801e5c:	6a 11                	push   $0x11
  801e5e:	e8 33 fe ff ff       	call   801c96 <syscall>
  801e63:	83 c4 18             	add    $0x18,%esp
	return;
  801e66:	90                   	nop
}
  801e67:	c9                   	leave  
  801e68:	c3                   	ret    

00801e69 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e69:	55                   	push   %ebp
  801e6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	ff 75 0c             	pushl  0xc(%ebp)
  801e75:	ff 75 08             	pushl  0x8(%ebp)
  801e78:	6a 12                	push   $0x12
  801e7a:	e8 17 fe ff ff       	call   801c96 <syscall>
  801e7f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e82:	90                   	nop
}
  801e83:	c9                   	leave  
  801e84:	c3                   	ret    

00801e85 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e85:	55                   	push   %ebp
  801e86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 0e                	push   $0xe
  801e94:	e8 fd fd ff ff       	call   801c96 <syscall>
  801e99:	83 c4 18             	add    $0x18,%esp
}
  801e9c:	c9                   	leave  
  801e9d:	c3                   	ret    

00801e9e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e9e:	55                   	push   %ebp
  801e9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	ff 75 08             	pushl  0x8(%ebp)
  801eac:	6a 0f                	push   $0xf
  801eae:	e8 e3 fd ff ff       	call   801c96 <syscall>
  801eb3:	83 c4 18             	add    $0x18,%esp
}
  801eb6:	c9                   	leave  
  801eb7:	c3                   	ret    

00801eb8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801eb8:	55                   	push   %ebp
  801eb9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 10                	push   $0x10
  801ec7:	e8 ca fd ff ff       	call   801c96 <syscall>
  801ecc:	83 c4 18             	add    $0x18,%esp
}
  801ecf:	90                   	nop
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 14                	push   $0x14
  801ee1:	e8 b0 fd ff ff       	call   801c96 <syscall>
  801ee6:	83 c4 18             	add    $0x18,%esp
}
  801ee9:	90                   	nop
  801eea:	c9                   	leave  
  801eeb:	c3                   	ret    

00801eec <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801eec:	55                   	push   %ebp
  801eed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 15                	push   $0x15
  801efb:	e8 96 fd ff ff       	call   801c96 <syscall>
  801f00:	83 c4 18             	add    $0x18,%esp
}
  801f03:	90                   	nop
  801f04:	c9                   	leave  
  801f05:	c3                   	ret    

00801f06 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f06:	55                   	push   %ebp
  801f07:	89 e5                	mov    %esp,%ebp
  801f09:	83 ec 04             	sub    $0x4,%esp
  801f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f12:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	50                   	push   %eax
  801f1f:	6a 16                	push   $0x16
  801f21:	e8 70 fd ff ff       	call   801c96 <syscall>
  801f26:	83 c4 18             	add    $0x18,%esp
}
  801f29:	90                   	nop
  801f2a:	c9                   	leave  
  801f2b:	c3                   	ret    

00801f2c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f2c:	55                   	push   %ebp
  801f2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 17                	push   $0x17
  801f3b:	e8 56 fd ff ff       	call   801c96 <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
}
  801f43:	90                   	nop
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f49:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	ff 75 0c             	pushl  0xc(%ebp)
  801f55:	50                   	push   %eax
  801f56:	6a 18                	push   $0x18
  801f58:	e8 39 fd ff ff       	call   801c96 <syscall>
  801f5d:	83 c4 18             	add    $0x18,%esp
}
  801f60:	c9                   	leave  
  801f61:	c3                   	ret    

00801f62 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f62:	55                   	push   %ebp
  801f63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f68:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	52                   	push   %edx
  801f72:	50                   	push   %eax
  801f73:	6a 1b                	push   $0x1b
  801f75:	e8 1c fd ff ff       	call   801c96 <syscall>
  801f7a:	83 c4 18             	add    $0x18,%esp
}
  801f7d:	c9                   	leave  
  801f7e:	c3                   	ret    

00801f7f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f7f:	55                   	push   %ebp
  801f80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f85:	8b 45 08             	mov    0x8(%ebp),%eax
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	52                   	push   %edx
  801f8f:	50                   	push   %eax
  801f90:	6a 19                	push   $0x19
  801f92:	e8 ff fc ff ff       	call   801c96 <syscall>
  801f97:	83 c4 18             	add    $0x18,%esp
}
  801f9a:	90                   	nop
  801f9b:	c9                   	leave  
  801f9c:	c3                   	ret    

00801f9d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fa0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	52                   	push   %edx
  801fad:	50                   	push   %eax
  801fae:	6a 1a                	push   $0x1a
  801fb0:	e8 e1 fc ff ff       	call   801c96 <syscall>
  801fb5:	83 c4 18             	add    $0x18,%esp
}
  801fb8:	90                   	nop
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
  801fbe:	83 ec 04             	sub    $0x4,%esp
  801fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  801fc4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801fc7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fca:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fce:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd1:	6a 00                	push   $0x0
  801fd3:	51                   	push   %ecx
  801fd4:	52                   	push   %edx
  801fd5:	ff 75 0c             	pushl  0xc(%ebp)
  801fd8:	50                   	push   %eax
  801fd9:	6a 1c                	push   $0x1c
  801fdb:	e8 b6 fc ff ff       	call   801c96 <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
}
  801fe3:	c9                   	leave  
  801fe4:	c3                   	ret    

00801fe5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801fe5:	55                   	push   %ebp
  801fe6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fe8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801feb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	52                   	push   %edx
  801ff5:	50                   	push   %eax
  801ff6:	6a 1d                	push   $0x1d
  801ff8:	e8 99 fc ff ff       	call   801c96 <syscall>
  801ffd:	83 c4 18             	add    $0x18,%esp
}
  802000:	c9                   	leave  
  802001:	c3                   	ret    

00802002 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802002:	55                   	push   %ebp
  802003:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802005:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802008:	8b 55 0c             	mov    0xc(%ebp),%edx
  80200b:	8b 45 08             	mov    0x8(%ebp),%eax
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	51                   	push   %ecx
  802013:	52                   	push   %edx
  802014:	50                   	push   %eax
  802015:	6a 1e                	push   $0x1e
  802017:	e8 7a fc ff ff       	call   801c96 <syscall>
  80201c:	83 c4 18             	add    $0x18,%esp
}
  80201f:	c9                   	leave  
  802020:	c3                   	ret    

00802021 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802021:	55                   	push   %ebp
  802022:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802024:	8b 55 0c             	mov    0xc(%ebp),%edx
  802027:	8b 45 08             	mov    0x8(%ebp),%eax
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	52                   	push   %edx
  802031:	50                   	push   %eax
  802032:	6a 1f                	push   $0x1f
  802034:	e8 5d fc ff ff       	call   801c96 <syscall>
  802039:	83 c4 18             	add    $0x18,%esp
}
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 20                	push   $0x20
  80204d:	e8 44 fc ff ff       	call   801c96 <syscall>
  802052:	83 c4 18             	add    $0x18,%esp
}
  802055:	c9                   	leave  
  802056:	c3                   	ret    

00802057 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802057:	55                   	push   %ebp
  802058:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80205a:	8b 45 08             	mov    0x8(%ebp),%eax
  80205d:	6a 00                	push   $0x0
  80205f:	ff 75 14             	pushl  0x14(%ebp)
  802062:	ff 75 10             	pushl  0x10(%ebp)
  802065:	ff 75 0c             	pushl  0xc(%ebp)
  802068:	50                   	push   %eax
  802069:	6a 21                	push   $0x21
  80206b:	e8 26 fc ff ff       	call   801c96 <syscall>
  802070:	83 c4 18             	add    $0x18,%esp
}
  802073:	c9                   	leave  
  802074:	c3                   	ret    

00802075 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802075:	55                   	push   %ebp
  802076:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802078:	8b 45 08             	mov    0x8(%ebp),%eax
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	50                   	push   %eax
  802084:	6a 22                	push   $0x22
  802086:	e8 0b fc ff ff       	call   801c96 <syscall>
  80208b:	83 c4 18             	add    $0x18,%esp
}
  80208e:	90                   	nop
  80208f:	c9                   	leave  
  802090:	c3                   	ret    

00802091 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802091:	55                   	push   %ebp
  802092:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802094:	8b 45 08             	mov    0x8(%ebp),%eax
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	50                   	push   %eax
  8020a0:	6a 23                	push   $0x23
  8020a2:	e8 ef fb ff ff       	call   801c96 <syscall>
  8020a7:	83 c4 18             	add    $0x18,%esp
}
  8020aa:	90                   	nop
  8020ab:	c9                   	leave  
  8020ac:	c3                   	ret    

008020ad <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020ad:	55                   	push   %ebp
  8020ae:	89 e5                	mov    %esp,%ebp
  8020b0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020b3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020b6:	8d 50 04             	lea    0x4(%eax),%edx
  8020b9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	52                   	push   %edx
  8020c3:	50                   	push   %eax
  8020c4:	6a 24                	push   $0x24
  8020c6:	e8 cb fb ff ff       	call   801c96 <syscall>
  8020cb:	83 c4 18             	add    $0x18,%esp
	return result;
  8020ce:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020d7:	89 01                	mov    %eax,(%ecx)
  8020d9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020df:	c9                   	leave  
  8020e0:	c2 04 00             	ret    $0x4

008020e3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020e3:	55                   	push   %ebp
  8020e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	ff 75 10             	pushl  0x10(%ebp)
  8020ed:	ff 75 0c             	pushl  0xc(%ebp)
  8020f0:	ff 75 08             	pushl  0x8(%ebp)
  8020f3:	6a 13                	push   $0x13
  8020f5:	e8 9c fb ff ff       	call   801c96 <syscall>
  8020fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8020fd:	90                   	nop
}
  8020fe:	c9                   	leave  
  8020ff:	c3                   	ret    

00802100 <sys_rcr2>:
uint32 sys_rcr2()
{
  802100:	55                   	push   %ebp
  802101:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	6a 25                	push   $0x25
  80210f:	e8 82 fb ff ff       	call   801c96 <syscall>
  802114:	83 c4 18             	add    $0x18,%esp
}
  802117:	c9                   	leave  
  802118:	c3                   	ret    

00802119 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802119:	55                   	push   %ebp
  80211a:	89 e5                	mov    %esp,%ebp
  80211c:	83 ec 04             	sub    $0x4,%esp
  80211f:	8b 45 08             	mov    0x8(%ebp),%eax
  802122:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802125:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	50                   	push   %eax
  802132:	6a 26                	push   $0x26
  802134:	e8 5d fb ff ff       	call   801c96 <syscall>
  802139:	83 c4 18             	add    $0x18,%esp
	return ;
  80213c:	90                   	nop
}
  80213d:	c9                   	leave  
  80213e:	c3                   	ret    

0080213f <rsttst>:
void rsttst()
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 28                	push   $0x28
  80214e:	e8 43 fb ff ff       	call   801c96 <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
	return ;
  802156:	90                   	nop
}
  802157:	c9                   	leave  
  802158:	c3                   	ret    

00802159 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802159:	55                   	push   %ebp
  80215a:	89 e5                	mov    %esp,%ebp
  80215c:	83 ec 04             	sub    $0x4,%esp
  80215f:	8b 45 14             	mov    0x14(%ebp),%eax
  802162:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802165:	8b 55 18             	mov    0x18(%ebp),%edx
  802168:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80216c:	52                   	push   %edx
  80216d:	50                   	push   %eax
  80216e:	ff 75 10             	pushl  0x10(%ebp)
  802171:	ff 75 0c             	pushl  0xc(%ebp)
  802174:	ff 75 08             	pushl  0x8(%ebp)
  802177:	6a 27                	push   $0x27
  802179:	e8 18 fb ff ff       	call   801c96 <syscall>
  80217e:	83 c4 18             	add    $0x18,%esp
	return ;
  802181:	90                   	nop
}
  802182:	c9                   	leave  
  802183:	c3                   	ret    

00802184 <chktst>:
void chktst(uint32 n)
{
  802184:	55                   	push   %ebp
  802185:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	ff 75 08             	pushl  0x8(%ebp)
  802192:	6a 29                	push   $0x29
  802194:	e8 fd fa ff ff       	call   801c96 <syscall>
  802199:	83 c4 18             	add    $0x18,%esp
	return ;
  80219c:	90                   	nop
}
  80219d:	c9                   	leave  
  80219e:	c3                   	ret    

0080219f <inctst>:

void inctst()
{
  80219f:	55                   	push   %ebp
  8021a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 2a                	push   $0x2a
  8021ae:	e8 e3 fa ff ff       	call   801c96 <syscall>
  8021b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b6:	90                   	nop
}
  8021b7:	c9                   	leave  
  8021b8:	c3                   	ret    

008021b9 <gettst>:
uint32 gettst()
{
  8021b9:	55                   	push   %ebp
  8021ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021bc:	6a 00                	push   $0x0
  8021be:	6a 00                	push   $0x0
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	6a 2b                	push   $0x2b
  8021c8:	e8 c9 fa ff ff       	call   801c96 <syscall>
  8021cd:	83 c4 18             	add    $0x18,%esp
}
  8021d0:	c9                   	leave  
  8021d1:	c3                   	ret    

008021d2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021d2:	55                   	push   %ebp
  8021d3:	89 e5                	mov    %esp,%ebp
  8021d5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 2c                	push   $0x2c
  8021e4:	e8 ad fa ff ff       	call   801c96 <syscall>
  8021e9:	83 c4 18             	add    $0x18,%esp
  8021ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021ef:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021f3:	75 07                	jne    8021fc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fa:	eb 05                	jmp    802201 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802201:	c9                   	leave  
  802202:	c3                   	ret    

00802203 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802203:	55                   	push   %ebp
  802204:	89 e5                	mov    %esp,%ebp
  802206:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 00                	push   $0x0
  802213:	6a 2c                	push   $0x2c
  802215:	e8 7c fa ff ff       	call   801c96 <syscall>
  80221a:	83 c4 18             	add    $0x18,%esp
  80221d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802220:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802224:	75 07                	jne    80222d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802226:	b8 01 00 00 00       	mov    $0x1,%eax
  80222b:	eb 05                	jmp    802232 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80222d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802232:	c9                   	leave  
  802233:	c3                   	ret    

00802234 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
  802237:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 2c                	push   $0x2c
  802246:	e8 4b fa ff ff       	call   801c96 <syscall>
  80224b:	83 c4 18             	add    $0x18,%esp
  80224e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802251:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802255:	75 07                	jne    80225e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802257:	b8 01 00 00 00       	mov    $0x1,%eax
  80225c:	eb 05                	jmp    802263 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80225e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802263:	c9                   	leave  
  802264:	c3                   	ret    

00802265 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802265:	55                   	push   %ebp
  802266:	89 e5                	mov    %esp,%ebp
  802268:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80226b:	6a 00                	push   $0x0
  80226d:	6a 00                	push   $0x0
  80226f:	6a 00                	push   $0x0
  802271:	6a 00                	push   $0x0
  802273:	6a 00                	push   $0x0
  802275:	6a 2c                	push   $0x2c
  802277:	e8 1a fa ff ff       	call   801c96 <syscall>
  80227c:	83 c4 18             	add    $0x18,%esp
  80227f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802282:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802286:	75 07                	jne    80228f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802288:	b8 01 00 00 00       	mov    $0x1,%eax
  80228d:	eb 05                	jmp    802294 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80228f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802294:	c9                   	leave  
  802295:	c3                   	ret    

00802296 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802296:	55                   	push   %ebp
  802297:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	ff 75 08             	pushl  0x8(%ebp)
  8022a4:	6a 2d                	push   $0x2d
  8022a6:	e8 eb f9 ff ff       	call   801c96 <syscall>
  8022ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ae:	90                   	nop
}
  8022af:	c9                   	leave  
  8022b0:	c3                   	ret    

008022b1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8022b1:	55                   	push   %ebp
  8022b2:	89 e5                	mov    %esp,%ebp
  8022b4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8022b5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8022b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022be:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c1:	6a 00                	push   $0x0
  8022c3:	53                   	push   %ebx
  8022c4:	51                   	push   %ecx
  8022c5:	52                   	push   %edx
  8022c6:	50                   	push   %eax
  8022c7:	6a 2e                	push   $0x2e
  8022c9:	e8 c8 f9 ff ff       	call   801c96 <syscall>
  8022ce:	83 c4 18             	add    $0x18,%esp
}
  8022d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8022d4:	c9                   	leave  
  8022d5:	c3                   	ret    

008022d6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8022d6:	55                   	push   %ebp
  8022d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8022d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 00                	push   $0x0
  8022e5:	52                   	push   %edx
  8022e6:	50                   	push   %eax
  8022e7:	6a 2f                	push   $0x2f
  8022e9:	e8 a8 f9 ff ff       	call   801c96 <syscall>
  8022ee:	83 c4 18             	add    $0x18,%esp
}
  8022f1:	c9                   	leave  
  8022f2:	c3                   	ret    
  8022f3:	90                   	nop

008022f4 <__udivdi3>:
  8022f4:	55                   	push   %ebp
  8022f5:	57                   	push   %edi
  8022f6:	56                   	push   %esi
  8022f7:	53                   	push   %ebx
  8022f8:	83 ec 1c             	sub    $0x1c,%esp
  8022fb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022ff:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802303:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802307:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80230b:	89 ca                	mov    %ecx,%edx
  80230d:	89 f8                	mov    %edi,%eax
  80230f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802313:	85 f6                	test   %esi,%esi
  802315:	75 2d                	jne    802344 <__udivdi3+0x50>
  802317:	39 cf                	cmp    %ecx,%edi
  802319:	77 65                	ja     802380 <__udivdi3+0x8c>
  80231b:	89 fd                	mov    %edi,%ebp
  80231d:	85 ff                	test   %edi,%edi
  80231f:	75 0b                	jne    80232c <__udivdi3+0x38>
  802321:	b8 01 00 00 00       	mov    $0x1,%eax
  802326:	31 d2                	xor    %edx,%edx
  802328:	f7 f7                	div    %edi
  80232a:	89 c5                	mov    %eax,%ebp
  80232c:	31 d2                	xor    %edx,%edx
  80232e:	89 c8                	mov    %ecx,%eax
  802330:	f7 f5                	div    %ebp
  802332:	89 c1                	mov    %eax,%ecx
  802334:	89 d8                	mov    %ebx,%eax
  802336:	f7 f5                	div    %ebp
  802338:	89 cf                	mov    %ecx,%edi
  80233a:	89 fa                	mov    %edi,%edx
  80233c:	83 c4 1c             	add    $0x1c,%esp
  80233f:	5b                   	pop    %ebx
  802340:	5e                   	pop    %esi
  802341:	5f                   	pop    %edi
  802342:	5d                   	pop    %ebp
  802343:	c3                   	ret    
  802344:	39 ce                	cmp    %ecx,%esi
  802346:	77 28                	ja     802370 <__udivdi3+0x7c>
  802348:	0f bd fe             	bsr    %esi,%edi
  80234b:	83 f7 1f             	xor    $0x1f,%edi
  80234e:	75 40                	jne    802390 <__udivdi3+0x9c>
  802350:	39 ce                	cmp    %ecx,%esi
  802352:	72 0a                	jb     80235e <__udivdi3+0x6a>
  802354:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802358:	0f 87 9e 00 00 00    	ja     8023fc <__udivdi3+0x108>
  80235e:	b8 01 00 00 00       	mov    $0x1,%eax
  802363:	89 fa                	mov    %edi,%edx
  802365:	83 c4 1c             	add    $0x1c,%esp
  802368:	5b                   	pop    %ebx
  802369:	5e                   	pop    %esi
  80236a:	5f                   	pop    %edi
  80236b:	5d                   	pop    %ebp
  80236c:	c3                   	ret    
  80236d:	8d 76 00             	lea    0x0(%esi),%esi
  802370:	31 ff                	xor    %edi,%edi
  802372:	31 c0                	xor    %eax,%eax
  802374:	89 fa                	mov    %edi,%edx
  802376:	83 c4 1c             	add    $0x1c,%esp
  802379:	5b                   	pop    %ebx
  80237a:	5e                   	pop    %esi
  80237b:	5f                   	pop    %edi
  80237c:	5d                   	pop    %ebp
  80237d:	c3                   	ret    
  80237e:	66 90                	xchg   %ax,%ax
  802380:	89 d8                	mov    %ebx,%eax
  802382:	f7 f7                	div    %edi
  802384:	31 ff                	xor    %edi,%edi
  802386:	89 fa                	mov    %edi,%edx
  802388:	83 c4 1c             	add    $0x1c,%esp
  80238b:	5b                   	pop    %ebx
  80238c:	5e                   	pop    %esi
  80238d:	5f                   	pop    %edi
  80238e:	5d                   	pop    %ebp
  80238f:	c3                   	ret    
  802390:	bd 20 00 00 00       	mov    $0x20,%ebp
  802395:	89 eb                	mov    %ebp,%ebx
  802397:	29 fb                	sub    %edi,%ebx
  802399:	89 f9                	mov    %edi,%ecx
  80239b:	d3 e6                	shl    %cl,%esi
  80239d:	89 c5                	mov    %eax,%ebp
  80239f:	88 d9                	mov    %bl,%cl
  8023a1:	d3 ed                	shr    %cl,%ebp
  8023a3:	89 e9                	mov    %ebp,%ecx
  8023a5:	09 f1                	or     %esi,%ecx
  8023a7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023ab:	89 f9                	mov    %edi,%ecx
  8023ad:	d3 e0                	shl    %cl,%eax
  8023af:	89 c5                	mov    %eax,%ebp
  8023b1:	89 d6                	mov    %edx,%esi
  8023b3:	88 d9                	mov    %bl,%cl
  8023b5:	d3 ee                	shr    %cl,%esi
  8023b7:	89 f9                	mov    %edi,%ecx
  8023b9:	d3 e2                	shl    %cl,%edx
  8023bb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023bf:	88 d9                	mov    %bl,%cl
  8023c1:	d3 e8                	shr    %cl,%eax
  8023c3:	09 c2                	or     %eax,%edx
  8023c5:	89 d0                	mov    %edx,%eax
  8023c7:	89 f2                	mov    %esi,%edx
  8023c9:	f7 74 24 0c          	divl   0xc(%esp)
  8023cd:	89 d6                	mov    %edx,%esi
  8023cf:	89 c3                	mov    %eax,%ebx
  8023d1:	f7 e5                	mul    %ebp
  8023d3:	39 d6                	cmp    %edx,%esi
  8023d5:	72 19                	jb     8023f0 <__udivdi3+0xfc>
  8023d7:	74 0b                	je     8023e4 <__udivdi3+0xf0>
  8023d9:	89 d8                	mov    %ebx,%eax
  8023db:	31 ff                	xor    %edi,%edi
  8023dd:	e9 58 ff ff ff       	jmp    80233a <__udivdi3+0x46>
  8023e2:	66 90                	xchg   %ax,%ax
  8023e4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023e8:	89 f9                	mov    %edi,%ecx
  8023ea:	d3 e2                	shl    %cl,%edx
  8023ec:	39 c2                	cmp    %eax,%edx
  8023ee:	73 e9                	jae    8023d9 <__udivdi3+0xe5>
  8023f0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023f3:	31 ff                	xor    %edi,%edi
  8023f5:	e9 40 ff ff ff       	jmp    80233a <__udivdi3+0x46>
  8023fa:	66 90                	xchg   %ax,%ax
  8023fc:	31 c0                	xor    %eax,%eax
  8023fe:	e9 37 ff ff ff       	jmp    80233a <__udivdi3+0x46>
  802403:	90                   	nop

00802404 <__umoddi3>:
  802404:	55                   	push   %ebp
  802405:	57                   	push   %edi
  802406:	56                   	push   %esi
  802407:	53                   	push   %ebx
  802408:	83 ec 1c             	sub    $0x1c,%esp
  80240b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80240f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802413:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802417:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80241b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80241f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802423:	89 f3                	mov    %esi,%ebx
  802425:	89 fa                	mov    %edi,%edx
  802427:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80242b:	89 34 24             	mov    %esi,(%esp)
  80242e:	85 c0                	test   %eax,%eax
  802430:	75 1a                	jne    80244c <__umoddi3+0x48>
  802432:	39 f7                	cmp    %esi,%edi
  802434:	0f 86 a2 00 00 00    	jbe    8024dc <__umoddi3+0xd8>
  80243a:	89 c8                	mov    %ecx,%eax
  80243c:	89 f2                	mov    %esi,%edx
  80243e:	f7 f7                	div    %edi
  802440:	89 d0                	mov    %edx,%eax
  802442:	31 d2                	xor    %edx,%edx
  802444:	83 c4 1c             	add    $0x1c,%esp
  802447:	5b                   	pop    %ebx
  802448:	5e                   	pop    %esi
  802449:	5f                   	pop    %edi
  80244a:	5d                   	pop    %ebp
  80244b:	c3                   	ret    
  80244c:	39 f0                	cmp    %esi,%eax
  80244e:	0f 87 ac 00 00 00    	ja     802500 <__umoddi3+0xfc>
  802454:	0f bd e8             	bsr    %eax,%ebp
  802457:	83 f5 1f             	xor    $0x1f,%ebp
  80245a:	0f 84 ac 00 00 00    	je     80250c <__umoddi3+0x108>
  802460:	bf 20 00 00 00       	mov    $0x20,%edi
  802465:	29 ef                	sub    %ebp,%edi
  802467:	89 fe                	mov    %edi,%esi
  802469:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80246d:	89 e9                	mov    %ebp,%ecx
  80246f:	d3 e0                	shl    %cl,%eax
  802471:	89 d7                	mov    %edx,%edi
  802473:	89 f1                	mov    %esi,%ecx
  802475:	d3 ef                	shr    %cl,%edi
  802477:	09 c7                	or     %eax,%edi
  802479:	89 e9                	mov    %ebp,%ecx
  80247b:	d3 e2                	shl    %cl,%edx
  80247d:	89 14 24             	mov    %edx,(%esp)
  802480:	89 d8                	mov    %ebx,%eax
  802482:	d3 e0                	shl    %cl,%eax
  802484:	89 c2                	mov    %eax,%edx
  802486:	8b 44 24 08          	mov    0x8(%esp),%eax
  80248a:	d3 e0                	shl    %cl,%eax
  80248c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802490:	8b 44 24 08          	mov    0x8(%esp),%eax
  802494:	89 f1                	mov    %esi,%ecx
  802496:	d3 e8                	shr    %cl,%eax
  802498:	09 d0                	or     %edx,%eax
  80249a:	d3 eb                	shr    %cl,%ebx
  80249c:	89 da                	mov    %ebx,%edx
  80249e:	f7 f7                	div    %edi
  8024a0:	89 d3                	mov    %edx,%ebx
  8024a2:	f7 24 24             	mull   (%esp)
  8024a5:	89 c6                	mov    %eax,%esi
  8024a7:	89 d1                	mov    %edx,%ecx
  8024a9:	39 d3                	cmp    %edx,%ebx
  8024ab:	0f 82 87 00 00 00    	jb     802538 <__umoddi3+0x134>
  8024b1:	0f 84 91 00 00 00    	je     802548 <__umoddi3+0x144>
  8024b7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024bb:	29 f2                	sub    %esi,%edx
  8024bd:	19 cb                	sbb    %ecx,%ebx
  8024bf:	89 d8                	mov    %ebx,%eax
  8024c1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024c5:	d3 e0                	shl    %cl,%eax
  8024c7:	89 e9                	mov    %ebp,%ecx
  8024c9:	d3 ea                	shr    %cl,%edx
  8024cb:	09 d0                	or     %edx,%eax
  8024cd:	89 e9                	mov    %ebp,%ecx
  8024cf:	d3 eb                	shr    %cl,%ebx
  8024d1:	89 da                	mov    %ebx,%edx
  8024d3:	83 c4 1c             	add    $0x1c,%esp
  8024d6:	5b                   	pop    %ebx
  8024d7:	5e                   	pop    %esi
  8024d8:	5f                   	pop    %edi
  8024d9:	5d                   	pop    %ebp
  8024da:	c3                   	ret    
  8024db:	90                   	nop
  8024dc:	89 fd                	mov    %edi,%ebp
  8024de:	85 ff                	test   %edi,%edi
  8024e0:	75 0b                	jne    8024ed <__umoddi3+0xe9>
  8024e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8024e7:	31 d2                	xor    %edx,%edx
  8024e9:	f7 f7                	div    %edi
  8024eb:	89 c5                	mov    %eax,%ebp
  8024ed:	89 f0                	mov    %esi,%eax
  8024ef:	31 d2                	xor    %edx,%edx
  8024f1:	f7 f5                	div    %ebp
  8024f3:	89 c8                	mov    %ecx,%eax
  8024f5:	f7 f5                	div    %ebp
  8024f7:	89 d0                	mov    %edx,%eax
  8024f9:	e9 44 ff ff ff       	jmp    802442 <__umoddi3+0x3e>
  8024fe:	66 90                	xchg   %ax,%ax
  802500:	89 c8                	mov    %ecx,%eax
  802502:	89 f2                	mov    %esi,%edx
  802504:	83 c4 1c             	add    $0x1c,%esp
  802507:	5b                   	pop    %ebx
  802508:	5e                   	pop    %esi
  802509:	5f                   	pop    %edi
  80250a:	5d                   	pop    %ebp
  80250b:	c3                   	ret    
  80250c:	3b 04 24             	cmp    (%esp),%eax
  80250f:	72 06                	jb     802517 <__umoddi3+0x113>
  802511:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802515:	77 0f                	ja     802526 <__umoddi3+0x122>
  802517:	89 f2                	mov    %esi,%edx
  802519:	29 f9                	sub    %edi,%ecx
  80251b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80251f:	89 14 24             	mov    %edx,(%esp)
  802522:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802526:	8b 44 24 04          	mov    0x4(%esp),%eax
  80252a:	8b 14 24             	mov    (%esp),%edx
  80252d:	83 c4 1c             	add    $0x1c,%esp
  802530:	5b                   	pop    %ebx
  802531:	5e                   	pop    %esi
  802532:	5f                   	pop    %edi
  802533:	5d                   	pop    %ebp
  802534:	c3                   	ret    
  802535:	8d 76 00             	lea    0x0(%esi),%esi
  802538:	2b 04 24             	sub    (%esp),%eax
  80253b:	19 fa                	sbb    %edi,%edx
  80253d:	89 d1                	mov    %edx,%ecx
  80253f:	89 c6                	mov    %eax,%esi
  802541:	e9 71 ff ff ff       	jmp    8024b7 <__umoddi3+0xb3>
  802546:	66 90                	xchg   %ax,%ax
  802548:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80254c:	72 ea                	jb     802538 <__umoddi3+0x134>
  80254e:	89 d9                	mov    %ebx,%ecx
  802550:	e9 62 ff ff ff       	jmp    8024b7 <__umoddi3+0xb3>
