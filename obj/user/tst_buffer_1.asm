
obj/user/tst_buffer_1:     file format elf32-i386


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
  800031:	e8 83 05 00 00       	call   8005b9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define arrSize PAGE_SIZE*8 / 4
int src[arrSize];
int dst[arrSize];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80004e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 00 20 80 00       	push   $0x802000
  800065:	6a 16                	push   $0x16
  800067:	68 48 20 80 00       	push   $0x802048
  80006c:	e8 8d 06 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007c:	83 c0 10             	add    $0x10,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800084:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 00 20 80 00       	push   $0x802000
  80009b:	6a 17                	push   $0x17
  80009d:	68 48 20 80 00       	push   $0x802048
  8000a2:	e8 57 06 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b2:	83 c0 20             	add    $0x20,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 00 20 80 00       	push   $0x802000
  8000d1:	6a 18                	push   $0x18
  8000d3:	68 48 20 80 00       	push   $0x802048
  8000d8:	e8 21 06 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e8:	83 c0 30             	add    $0x30,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 00 20 80 00       	push   $0x802000
  800107:	6a 19                	push   $0x19
  800109:	68 48 20 80 00       	push   $0x802048
  80010e:	e8 eb 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011e:	83 c0 40             	add    $0x40,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800126:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 00 20 80 00       	push   $0x802000
  80013d:	6a 1a                	push   $0x1a
  80013f:	68 48 20 80 00       	push   $0x802048
  800144:	e8 b5 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800154:	83 c0 50             	add    $0x50,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 00 20 80 00       	push   $0x802000
  800173:	6a 1b                	push   $0x1b
  800175:	68 48 20 80 00       	push   $0x802048
  80017a:	e8 7f 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018a:	83 c0 60             	add    $0x60,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800192:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 00 20 80 00       	push   $0x802000
  8001a9:	6a 1c                	push   $0x1c
  8001ab:	68 48 20 80 00       	push   $0x802048
  8001b0:	e8 49 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c0:	83 c0 70             	add    $0x70,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001c8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 00 20 80 00       	push   $0x802000
  8001df:	6a 1d                	push   $0x1d
  8001e1:	68 48 20 80 00       	push   $0x802048
  8001e6:	e8 13 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 e8 80             	sub    $0xffffff80,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001fe:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 00 20 80 00       	push   $0x802000
  800215:	6a 1e                	push   $0x1e
  800217:	68 48 20 80 00       	push   $0x802048
  80021c:	e8 dd 04 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022c:	05 90 00 00 00       	add    $0x90,%eax
  800231:	8b 00                	mov    (%eax),%eax
  800233:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800236:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800239:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023e:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800243:	74 14                	je     800259 <_main+0x221>
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 00 20 80 00       	push   $0x802000
  80024d:	6a 1f                	push   $0x1f
  80024f:	68 48 20 80 00       	push   $0x802048
  800254:	e8 a5 04 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800259:	a1 20 30 80 00       	mov    0x803020,%eax
  80025e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800264:	05 a0 00 00 00       	add    $0xa0,%eax
  800269:	8b 00                	mov    (%eax),%eax
  80026b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80026e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800271:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800276:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027b:	74 14                	je     800291 <_main+0x259>
  80027d:	83 ec 04             	sub    $0x4,%esp
  800280:	68 00 20 80 00       	push   $0x802000
  800285:	6a 20                	push   $0x20
  800287:	68 48 20 80 00       	push   $0x802048
  80028c:	e8 6d 04 00 00       	call   8006fe <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800291:	a1 20 30 80 00       	mov    0x803020,%eax
  800296:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029c:	85 c0                	test   %eax,%eax
  80029e:	74 14                	je     8002b4 <_main+0x27c>
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	68 5c 20 80 00       	push   $0x80205c
  8002a8:	6a 21                	push   $0x21
  8002aa:	68 48 20 80 00       	push   $0x802048
  8002af:	e8 4a 04 00 00       	call   8006fe <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b4:	e8 f6 15 00 00       	call   8018af <sys_calculate_modified_frames>
  8002b9:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002bc:	e8 07 16 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  8002c1:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c4:	e8 50 16 00 00       	call   801919 <sys_pf_calculate_allocated_pages>
  8002c9:	89 45 a8             	mov    %eax,-0x58(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	//cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
	int dummy = 0;
  8002da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  8002e1:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8002e8:	eb 33                	jmp    80031d <_main+0x2e5>
	{
		dst[i] = i;
  8002ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002f0:	89 14 85 00 31 80 00 	mov    %edx,0x803100(,%eax,4)
		dstSum1 += i;
  8002f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fa:	01 45 f0             	add    %eax,-0x10(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8002fd:	e8 c6 15 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  800302:	89 c2                	mov    %eax,%edx
  800304:	a1 20 30 80 00       	mov    0x803020,%eax
  800309:	8b 40 4c             	mov    0x4c(%eax),%eax
  80030c:	01 c2                	add    %eax,%edx
  80030e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
	int dstSum1 = 0;
	//cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  800316:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80031d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800324:	7e c4                	jle    8002ea <_main+0x2b2>
		dstSum1 += i;
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}


	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800326:	e8 9d 15 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  80032b:	89 c2                	mov    %eax,%edx
  80032d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800330:	29 c2                	sub    %eax,%edx
  800332:	89 d0                	mov    %edx,%eax
  800334:	83 f8 07             	cmp    $0x7,%eax
  800337:	74 14                	je     80034d <_main+0x315>
  800339:	83 ec 04             	sub    $0x4,%esp
  80033c:	68 ac 20 80 00       	push   $0x8020ac
  800341:	6a 35                	push   $0x35
  800343:	68 48 20 80 00       	push   $0x802048
  800348:	e8 b1 03 00 00       	call   8006fe <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80034d:	e8 5d 15 00 00       	call   8018af <sys_calculate_modified_frames>
  800352:	89 c2                	mov    %eax,%edx
  800354:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800357:	39 c2                	cmp    %eax,%edx
  800359:	74 14                	je     80036f <_main+0x337>
  80035b:	83 ec 04             	sub    $0x4,%esp
  80035e:	68 10 21 80 00       	push   $0x802110
  800363:	6a 36                	push   $0x36
  800365:	68 48 20 80 00       	push   $0x802048
  80036a:	e8 8f 03 00 00       	call   8006fe <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  80036f:	e8 54 15 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  800374:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800377:	e8 33 15 00 00       	call   8018af <sys_calculate_modified_frames>
  80037c:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
  80037f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	i = PAGE_SIZE/4;
  800386:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	for(;i<arrSize;i+=PAGE_SIZE/4)
  80038d:	eb 2d                	jmp    8003bc <_main+0x384>
	{
		srcSum1 += src[i];
  80038f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800392:	8b 04 85 20 b1 80 00 	mov    0x80b120(,%eax,4),%eax
  800399:	01 45 e8             	add    %eax,-0x18(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  80039c:	e8 27 15 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  8003a1:	89 c2                	mov    %eax,%edx
  8003a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a8:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003ab:	01 c2                	add    %eax,%edx
  8003ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003b0:	01 d0                	add    %edx,%eax
  8003b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
	i = PAGE_SIZE/4;
	for(;i<arrSize;i+=PAGE_SIZE/4)
  8003b5:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  8003bc:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  8003c3:	7e ca                	jle    80038f <_main+0x357>
		srcSum1 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c5:	e8 fe 14 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  8003ca:	89 c2                	mov    %eax,%edx
  8003cc:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003cf:	39 c2                	cmp    %eax,%edx
  8003d1:	74 14                	je     8003e7 <_main+0x3af>
  8003d3:	83 ec 04             	sub    $0x4,%esp
  8003d6:	68 ac 20 80 00       	push   $0x8020ac
  8003db:	6a 45                	push   $0x45
  8003dd:	68 48 20 80 00       	push   $0x802048
  8003e2:	e8 17 03 00 00       	call   8006fe <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003e7:	e8 c3 14 00 00       	call   8018af <sys_calculate_modified_frames>
  8003ec:	89 c2                	mov    %eax,%edx
  8003ee:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003f1:	29 c2                	sub    %eax,%edx
  8003f3:	89 d0                	mov    %edx,%eax
  8003f5:	83 f8 07             	cmp    $0x7,%eax
  8003f8:	74 14                	je     80040e <_main+0x3d6>
  8003fa:	83 ec 04             	sub    $0x4,%esp
  8003fd:	68 10 21 80 00       	push   $0x802110
  800402:	6a 46                	push   $0x46
  800404:	68 48 20 80 00       	push   $0x802048
  800409:	e8 f0 02 00 00       	call   8006fe <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  80040e:	e8 b5 14 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  800413:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800416:	e8 94 14 00 00       	call   8018af <sys_calculate_modified_frames>
  80041b:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
	i = 0;
  80041e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum2 = 0 ;
  800425:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80042c:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  800433:	eb 2d                	jmp    800462 <_main+0x42a>
	{
		dstSum2 += dst[i];
  800435:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800438:	8b 04 85 00 31 80 00 	mov    0x803100(,%eax,4),%eax
  80043f:	01 45 e4             	add    %eax,-0x1c(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  800442:	e8 81 14 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  800447:	89 c2                	mov    %eax,%edx
  800449:	a1 20 30 80 00       	mov    0x803020,%eax
  80044e:	8b 40 4c             	mov    0x4c(%eax),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800456:	01 d0                	add    %edx,%eax
  800458:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80045b:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800462:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800469:	7e ca                	jle    800435 <_main+0x3fd>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80046b:	e8 58 14 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  800470:	89 c2                	mov    %eax,%edx
  800472:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800475:	29 c2                	sub    %eax,%edx
  800477:	89 d0                	mov    %edx,%eax
  800479:	83 f8 07             	cmp    $0x7,%eax
  80047c:	74 14                	je     800492 <_main+0x45a>
  80047e:	83 ec 04             	sub    $0x4,%esp
  800481:	68 ac 20 80 00       	push   $0x8020ac
  800486:	6a 53                	push   $0x53
  800488:	68 48 20 80 00       	push   $0x802048
  80048d:	e8 6c 02 00 00       	call   8006fe <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800492:	e8 18 14 00 00       	call   8018af <sys_calculate_modified_frames>
  800497:	89 c2                	mov    %eax,%edx
  800499:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80049c:	29 c2                	sub    %eax,%edx
  80049e:	89 d0                	mov    %edx,%eax
  8004a0:	83 f8 f9             	cmp    $0xfffffff9,%eax
  8004a3:	74 14                	je     8004b9 <_main+0x481>
  8004a5:	83 ec 04             	sub    $0x4,%esp
  8004a8:	68 10 21 80 00       	push   $0x802110
  8004ad:	6a 54                	push   $0x54
  8004af:	68 48 20 80 00       	push   $0x802048
  8004b4:	e8 45 02 00 00       	call   8006fe <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004b9:	e8 0a 14 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  8004be:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004c1:	e8 e9 13 00 00       	call   8018af <sys_calculate_modified_frames>
  8004c6:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
  8004c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int srcSum2 = 0 ;
  8004d0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  8004d7:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8004de:	eb 2d                	jmp    80050d <_main+0x4d5>
	{
		srcSum2 += src[i];
  8004e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e3:	8b 04 85 20 b1 80 00 	mov    0x80b120(,%eax,4),%eax
  8004ea:	01 45 e0             	add    %eax,-0x20(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8004ed:	e8 d6 13 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  8004f2:	89 c2                	mov    %eax,%edx
  8004f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f9:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004fc:	01 c2                	add    %eax,%edx
  8004fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800501:	01 d0                	add    %edx,%eax
  800503:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
	int srcSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800506:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80050d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800514:	7e ca                	jle    8004e0 <_main+0x4a8>
	{
		srcSum2 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800516:	e8 ad 13 00 00       	call   8018c8 <sys_calculate_notmod_frames>
  80051b:	89 c2                	mov    %eax,%edx
  80051d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800520:	29 c2                	sub    %eax,%edx
  800522:	89 d0                	mov    %edx,%eax
  800524:	83 f8 f9             	cmp    $0xfffffff9,%eax
  800527:	74 14                	je     80053d <_main+0x505>
  800529:	83 ec 04             	sub    $0x4,%esp
  80052c:	68 ac 20 80 00       	push   $0x8020ac
  800531:	6a 62                	push   $0x62
  800533:	68 48 20 80 00       	push   $0x802048
  800538:	e8 c1 01 00 00       	call   8006fe <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80053d:	e8 6d 13 00 00       	call   8018af <sys_calculate_modified_frames>
  800542:	89 c2                	mov    %eax,%edx
  800544:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800547:	29 c2                	sub    %eax,%edx
  800549:	89 d0                	mov    %edx,%eax
  80054b:	83 f8 07             	cmp    $0x7,%eax
  80054e:	74 14                	je     800564 <_main+0x52c>
  800550:	83 ec 04             	sub    $0x4,%esp
  800553:	68 10 21 80 00       	push   $0x802110
  800558:	6a 63                	push   $0x63
  80055a:	68 48 20 80 00       	push   $0x802048
  80055f:	e8 9a 01 00 00       	call   8006fe <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800564:	e8 b0 13 00 00       	call   801919 <sys_pf_calculate_allocated_pages>
  800569:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  80056c:	74 14                	je     800582 <_main+0x54a>
  80056e:	83 ec 04             	sub    $0x4,%esp
  800571:	68 7c 21 80 00       	push   $0x80217c
  800576:	6a 65                	push   $0x65
  800578:	68 48 20 80 00       	push   $0x802048
  80057d:	e8 7c 01 00 00       	call   8006fe <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  800582:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800585:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800588:	75 08                	jne    800592 <_main+0x55a>
  80058a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800590:	74 14                	je     8005a6 <_main+0x56e>
  800592:	83 ec 04             	sub    $0x4,%esp
  800595:	68 ec 21 80 00       	push   $0x8021ec
  80059a:	6a 67                	push   $0x67
  80059c:	68 48 20 80 00       	push   $0x802048
  8005a1:	e8 58 01 00 00       	call   8006fe <_panic>

	cprintf("Congratulations!! test buffered pages inside REPLACEMENT is completed successfully.\n");
  8005a6:	83 ec 0c             	sub    $0xc,%esp
  8005a9:	68 28 22 80 00       	push   $0x802228
  8005ae:	e8 ed 03 00 00       	call   8009a0 <cprintf>
  8005b3:	83 c4 10             	add    $0x10,%esp
	return;
  8005b6:	90                   	nop

}
  8005b7:	c9                   	leave  
  8005b8:	c3                   	ret    

008005b9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005b9:	55                   	push   %ebp
  8005ba:	89 e5                	mov    %esp,%ebp
  8005bc:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005bf:	e8 07 12 00 00       	call   8017cb <sys_getenvindex>
  8005c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ca:	89 d0                	mov    %edx,%eax
  8005cc:	c1 e0 03             	shl    $0x3,%eax
  8005cf:	01 d0                	add    %edx,%eax
  8005d1:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005d8:	01 c8                	add    %ecx,%eax
  8005da:	01 c0                	add    %eax,%eax
  8005dc:	01 d0                	add    %edx,%eax
  8005de:	01 c0                	add    %eax,%eax
  8005e0:	01 d0                	add    %edx,%eax
  8005e2:	89 c2                	mov    %eax,%edx
  8005e4:	c1 e2 05             	shl    $0x5,%edx
  8005e7:	29 c2                	sub    %eax,%edx
  8005e9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8005f0:	89 c2                	mov    %eax,%edx
  8005f2:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005f8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800602:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800608:	84 c0                	test   %al,%al
  80060a:	74 0f                	je     80061b <libmain+0x62>
		binaryname = myEnv->prog_name;
  80060c:	a1 20 30 80 00       	mov    0x803020,%eax
  800611:	05 40 3c 01 00       	add    $0x13c40,%eax
  800616:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80061b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80061f:	7e 0a                	jle    80062b <libmain+0x72>
		binaryname = argv[0];
  800621:	8b 45 0c             	mov    0xc(%ebp),%eax
  800624:	8b 00                	mov    (%eax),%eax
  800626:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80062b:	83 ec 08             	sub    $0x8,%esp
  80062e:	ff 75 0c             	pushl  0xc(%ebp)
  800631:	ff 75 08             	pushl  0x8(%ebp)
  800634:	e8 ff f9 ff ff       	call   800038 <_main>
  800639:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80063c:	e8 25 13 00 00       	call   801966 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800641:	83 ec 0c             	sub    $0xc,%esp
  800644:	68 98 22 80 00       	push   $0x802298
  800649:	e8 52 03 00 00       	call   8009a0 <cprintf>
  80064e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800651:	a1 20 30 80 00       	mov    0x803020,%eax
  800656:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80065c:	a1 20 30 80 00       	mov    0x803020,%eax
  800661:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800667:	83 ec 04             	sub    $0x4,%esp
  80066a:	52                   	push   %edx
  80066b:	50                   	push   %eax
  80066c:	68 c0 22 80 00       	push   $0x8022c0
  800671:	e8 2a 03 00 00       	call   8009a0 <cprintf>
  800676:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800679:	a1 20 30 80 00       	mov    0x803020,%eax
  80067e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800684:	a1 20 30 80 00       	mov    0x803020,%eax
  800689:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80068f:	83 ec 04             	sub    $0x4,%esp
  800692:	52                   	push   %edx
  800693:	50                   	push   %eax
  800694:	68 e8 22 80 00       	push   $0x8022e8
  800699:	e8 02 03 00 00       	call   8009a0 <cprintf>
  80069e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a6:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	50                   	push   %eax
  8006b0:	68 29 23 80 00       	push   $0x802329
  8006b5:	e8 e6 02 00 00       	call   8009a0 <cprintf>
  8006ba:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006bd:	83 ec 0c             	sub    $0xc,%esp
  8006c0:	68 98 22 80 00       	push   $0x802298
  8006c5:	e8 d6 02 00 00       	call   8009a0 <cprintf>
  8006ca:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006cd:	e8 ae 12 00 00       	call   801980 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006d2:	e8 19 00 00 00       	call   8006f0 <exit>
}
  8006d7:	90                   	nop
  8006d8:	c9                   	leave  
  8006d9:	c3                   	ret    

008006da <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006da:	55                   	push   %ebp
  8006db:	89 e5                	mov    %esp,%ebp
  8006dd:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006e0:	83 ec 0c             	sub    $0xc,%esp
  8006e3:	6a 00                	push   $0x0
  8006e5:	e8 ad 10 00 00       	call   801797 <sys_env_destroy>
  8006ea:	83 c4 10             	add    $0x10,%esp
}
  8006ed:	90                   	nop
  8006ee:	c9                   	leave  
  8006ef:	c3                   	ret    

008006f0 <exit>:

void
exit(void)
{
  8006f0:	55                   	push   %ebp
  8006f1:	89 e5                	mov    %esp,%ebp
  8006f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006f6:	e8 02 11 00 00       	call   8017fd <sys_env_exit>
}
  8006fb:	90                   	nop
  8006fc:	c9                   	leave  
  8006fd:	c3                   	ret    

008006fe <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006fe:	55                   	push   %ebp
  8006ff:	89 e5                	mov    %esp,%ebp
  800701:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800704:	8d 45 10             	lea    0x10(%ebp),%eax
  800707:	83 c0 04             	add    $0x4,%eax
  80070a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80070d:	a1 24 31 81 00       	mov    0x813124,%eax
  800712:	85 c0                	test   %eax,%eax
  800714:	74 16                	je     80072c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800716:	a1 24 31 81 00       	mov    0x813124,%eax
  80071b:	83 ec 08             	sub    $0x8,%esp
  80071e:	50                   	push   %eax
  80071f:	68 40 23 80 00       	push   $0x802340
  800724:	e8 77 02 00 00       	call   8009a0 <cprintf>
  800729:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80072c:	a1 00 30 80 00       	mov    0x803000,%eax
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	ff 75 08             	pushl  0x8(%ebp)
  800737:	50                   	push   %eax
  800738:	68 45 23 80 00       	push   $0x802345
  80073d:	e8 5e 02 00 00       	call   8009a0 <cprintf>
  800742:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800745:	8b 45 10             	mov    0x10(%ebp),%eax
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 f4             	pushl  -0xc(%ebp)
  80074e:	50                   	push   %eax
  80074f:	e8 e1 01 00 00       	call   800935 <vcprintf>
  800754:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800757:	83 ec 08             	sub    $0x8,%esp
  80075a:	6a 00                	push   $0x0
  80075c:	68 61 23 80 00       	push   $0x802361
  800761:	e8 cf 01 00 00       	call   800935 <vcprintf>
  800766:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800769:	e8 82 ff ff ff       	call   8006f0 <exit>

	// should not return here
	while (1) ;
  80076e:	eb fe                	jmp    80076e <_panic+0x70>

00800770 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800770:	55                   	push   %ebp
  800771:	89 e5                	mov    %esp,%ebp
  800773:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800776:	a1 20 30 80 00       	mov    0x803020,%eax
  80077b:	8b 50 74             	mov    0x74(%eax),%edx
  80077e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800781:	39 c2                	cmp    %eax,%edx
  800783:	74 14                	je     800799 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800785:	83 ec 04             	sub    $0x4,%esp
  800788:	68 64 23 80 00       	push   $0x802364
  80078d:	6a 26                	push   $0x26
  80078f:	68 b0 23 80 00       	push   $0x8023b0
  800794:	e8 65 ff ff ff       	call   8006fe <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800799:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007a7:	e9 b6 00 00 00       	jmp    800862 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	01 d0                	add    %edx,%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	85 c0                	test   %eax,%eax
  8007bf:	75 08                	jne    8007c9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007c1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007c4:	e9 96 00 00 00       	jmp    80085f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007d7:	eb 5d                	jmp    800836 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007de:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e7:	c1 e2 04             	shl    $0x4,%edx
  8007ea:	01 d0                	add    %edx,%eax
  8007ec:	8a 40 04             	mov    0x4(%eax),%al
  8007ef:	84 c0                	test   %al,%al
  8007f1:	75 40                	jne    800833 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8007f8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007fe:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800801:	c1 e2 04             	shl    $0x4,%edx
  800804:	01 d0                	add    %edx,%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80080b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80080e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800813:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800815:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800818:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	01 c8                	add    %ecx,%eax
  800824:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800826:	39 c2                	cmp    %eax,%edx
  800828:	75 09                	jne    800833 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80082a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800831:	eb 12                	jmp    800845 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800833:	ff 45 e8             	incl   -0x18(%ebp)
  800836:	a1 20 30 80 00       	mov    0x803020,%eax
  80083b:	8b 50 74             	mov    0x74(%eax),%edx
  80083e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800841:	39 c2                	cmp    %eax,%edx
  800843:	77 94                	ja     8007d9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800845:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800849:	75 14                	jne    80085f <CheckWSWithoutLastIndex+0xef>
			panic(
  80084b:	83 ec 04             	sub    $0x4,%esp
  80084e:	68 bc 23 80 00       	push   $0x8023bc
  800853:	6a 3a                	push   $0x3a
  800855:	68 b0 23 80 00       	push   $0x8023b0
  80085a:	e8 9f fe ff ff       	call   8006fe <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80085f:	ff 45 f0             	incl   -0x10(%ebp)
  800862:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800865:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800868:	0f 8c 3e ff ff ff    	jl     8007ac <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80086e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800875:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80087c:	eb 20                	jmp    80089e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80087e:	a1 20 30 80 00       	mov    0x803020,%eax
  800883:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800889:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80088c:	c1 e2 04             	shl    $0x4,%edx
  80088f:	01 d0                	add    %edx,%eax
  800891:	8a 40 04             	mov    0x4(%eax),%al
  800894:	3c 01                	cmp    $0x1,%al
  800896:	75 03                	jne    80089b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800898:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80089b:	ff 45 e0             	incl   -0x20(%ebp)
  80089e:	a1 20 30 80 00       	mov    0x803020,%eax
  8008a3:	8b 50 74             	mov    0x74(%eax),%edx
  8008a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a9:	39 c2                	cmp    %eax,%edx
  8008ab:	77 d1                	ja     80087e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008b3:	74 14                	je     8008c9 <CheckWSWithoutLastIndex+0x159>
		panic(
  8008b5:	83 ec 04             	sub    $0x4,%esp
  8008b8:	68 10 24 80 00       	push   $0x802410
  8008bd:	6a 44                	push   $0x44
  8008bf:	68 b0 23 80 00       	push   $0x8023b0
  8008c4:	e8 35 fe ff ff       	call   8006fe <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008c9:	90                   	nop
  8008ca:	c9                   	leave  
  8008cb:	c3                   	ret    

008008cc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008cc:	55                   	push   %ebp
  8008cd:	89 e5                	mov    %esp,%ebp
  8008cf:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008dd:	89 0a                	mov    %ecx,(%edx)
  8008df:	8b 55 08             	mov    0x8(%ebp),%edx
  8008e2:	88 d1                	mov    %dl,%cl
  8008e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ee:	8b 00                	mov    (%eax),%eax
  8008f0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008f5:	75 2c                	jne    800923 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008f7:	a0 24 30 80 00       	mov    0x803024,%al
  8008fc:	0f b6 c0             	movzbl %al,%eax
  8008ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800902:	8b 12                	mov    (%edx),%edx
  800904:	89 d1                	mov    %edx,%ecx
  800906:	8b 55 0c             	mov    0xc(%ebp),%edx
  800909:	83 c2 08             	add    $0x8,%edx
  80090c:	83 ec 04             	sub    $0x4,%esp
  80090f:	50                   	push   %eax
  800910:	51                   	push   %ecx
  800911:	52                   	push   %edx
  800912:	e8 3e 0e 00 00       	call   801755 <sys_cputs>
  800917:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80091a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800923:	8b 45 0c             	mov    0xc(%ebp),%eax
  800926:	8b 40 04             	mov    0x4(%eax),%eax
  800929:	8d 50 01             	lea    0x1(%eax),%edx
  80092c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800932:	90                   	nop
  800933:	c9                   	leave  
  800934:	c3                   	ret    

00800935 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800935:	55                   	push   %ebp
  800936:	89 e5                	mov    %esp,%ebp
  800938:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80093e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800945:	00 00 00 
	b.cnt = 0;
  800948:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80094f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800952:	ff 75 0c             	pushl  0xc(%ebp)
  800955:	ff 75 08             	pushl  0x8(%ebp)
  800958:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80095e:	50                   	push   %eax
  80095f:	68 cc 08 80 00       	push   $0x8008cc
  800964:	e8 11 02 00 00       	call   800b7a <vprintfmt>
  800969:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80096c:	a0 24 30 80 00       	mov    0x803024,%al
  800971:	0f b6 c0             	movzbl %al,%eax
  800974:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80097a:	83 ec 04             	sub    $0x4,%esp
  80097d:	50                   	push   %eax
  80097e:	52                   	push   %edx
  80097f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800985:	83 c0 08             	add    $0x8,%eax
  800988:	50                   	push   %eax
  800989:	e8 c7 0d 00 00       	call   801755 <sys_cputs>
  80098e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800991:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800998:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80099e:	c9                   	leave  
  80099f:	c3                   	ret    

008009a0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009a0:	55                   	push   %ebp
  8009a1:	89 e5                	mov    %esp,%ebp
  8009a3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009a6:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009ad:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b6:	83 ec 08             	sub    $0x8,%esp
  8009b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009bc:	50                   	push   %eax
  8009bd:	e8 73 ff ff ff       	call   800935 <vcprintf>
  8009c2:	83 c4 10             	add    $0x10,%esp
  8009c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009cb:	c9                   	leave  
  8009cc:	c3                   	ret    

008009cd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009cd:	55                   	push   %ebp
  8009ce:	89 e5                	mov    %esp,%ebp
  8009d0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009d3:	e8 8e 0f 00 00       	call   801966 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009d8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	83 ec 08             	sub    $0x8,%esp
  8009e4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e7:	50                   	push   %eax
  8009e8:	e8 48 ff ff ff       	call   800935 <vcprintf>
  8009ed:	83 c4 10             	add    $0x10,%esp
  8009f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009f3:	e8 88 0f 00 00       	call   801980 <sys_enable_interrupt>
	return cnt;
  8009f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009fb:	c9                   	leave  
  8009fc:	c3                   	ret    

008009fd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009fd:	55                   	push   %ebp
  8009fe:	89 e5                	mov    %esp,%ebp
  800a00:	53                   	push   %ebx
  800a01:	83 ec 14             	sub    $0x14,%esp
  800a04:	8b 45 10             	mov    0x10(%ebp),%eax
  800a07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a10:	8b 45 18             	mov    0x18(%ebp),%eax
  800a13:	ba 00 00 00 00       	mov    $0x0,%edx
  800a18:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a1b:	77 55                	ja     800a72 <printnum+0x75>
  800a1d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a20:	72 05                	jb     800a27 <printnum+0x2a>
  800a22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a25:	77 4b                	ja     800a72 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a27:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a2a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a2d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a30:	ba 00 00 00 00       	mov    $0x0,%edx
  800a35:	52                   	push   %edx
  800a36:	50                   	push   %eax
  800a37:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a3d:	e8 46 13 00 00       	call   801d88 <__udivdi3>
  800a42:	83 c4 10             	add    $0x10,%esp
  800a45:	83 ec 04             	sub    $0x4,%esp
  800a48:	ff 75 20             	pushl  0x20(%ebp)
  800a4b:	53                   	push   %ebx
  800a4c:	ff 75 18             	pushl  0x18(%ebp)
  800a4f:	52                   	push   %edx
  800a50:	50                   	push   %eax
  800a51:	ff 75 0c             	pushl  0xc(%ebp)
  800a54:	ff 75 08             	pushl  0x8(%ebp)
  800a57:	e8 a1 ff ff ff       	call   8009fd <printnum>
  800a5c:	83 c4 20             	add    $0x20,%esp
  800a5f:	eb 1a                	jmp    800a7b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a61:	83 ec 08             	sub    $0x8,%esp
  800a64:	ff 75 0c             	pushl  0xc(%ebp)
  800a67:	ff 75 20             	pushl  0x20(%ebp)
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	ff d0                	call   *%eax
  800a6f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a72:	ff 4d 1c             	decl   0x1c(%ebp)
  800a75:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a79:	7f e6                	jg     800a61 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a7b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a7e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a86:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a89:	53                   	push   %ebx
  800a8a:	51                   	push   %ecx
  800a8b:	52                   	push   %edx
  800a8c:	50                   	push   %eax
  800a8d:	e8 06 14 00 00       	call   801e98 <__umoddi3>
  800a92:	83 c4 10             	add    $0x10,%esp
  800a95:	05 74 26 80 00       	add    $0x802674,%eax
  800a9a:	8a 00                	mov    (%eax),%al
  800a9c:	0f be c0             	movsbl %al,%eax
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	ff 75 0c             	pushl  0xc(%ebp)
  800aa5:	50                   	push   %eax
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	ff d0                	call   *%eax
  800aab:	83 c4 10             	add    $0x10,%esp
}
  800aae:	90                   	nop
  800aaf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ab2:	c9                   	leave  
  800ab3:	c3                   	ret    

00800ab4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ab4:	55                   	push   %ebp
  800ab5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ab7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800abb:	7e 1c                	jle    800ad9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	8b 00                	mov    (%eax),%eax
  800ac2:	8d 50 08             	lea    0x8(%eax),%edx
  800ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac8:	89 10                	mov    %edx,(%eax)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8b 00                	mov    (%eax),%eax
  800acf:	83 e8 08             	sub    $0x8,%eax
  800ad2:	8b 50 04             	mov    0x4(%eax),%edx
  800ad5:	8b 00                	mov    (%eax),%eax
  800ad7:	eb 40                	jmp    800b19 <getuint+0x65>
	else if (lflag)
  800ad9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800add:	74 1e                	je     800afd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	8b 00                	mov    (%eax),%eax
  800ae4:	8d 50 04             	lea    0x4(%eax),%edx
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	89 10                	mov    %edx,(%eax)
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	83 e8 04             	sub    $0x4,%eax
  800af4:	8b 00                	mov    (%eax),%eax
  800af6:	ba 00 00 00 00       	mov    $0x0,%edx
  800afb:	eb 1c                	jmp    800b19 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	8d 50 04             	lea    0x4(%eax),%edx
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	89 10                	mov    %edx,(%eax)
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	83 e8 04             	sub    $0x4,%eax
  800b12:	8b 00                	mov    (%eax),%eax
  800b14:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b19:	5d                   	pop    %ebp
  800b1a:	c3                   	ret    

00800b1b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b1b:	55                   	push   %ebp
  800b1c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b1e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b22:	7e 1c                	jle    800b40 <getint+0x25>
		return va_arg(*ap, long long);
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	8d 50 08             	lea    0x8(%eax),%edx
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 10                	mov    %edx,(%eax)
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	83 e8 08             	sub    $0x8,%eax
  800b39:	8b 50 04             	mov    0x4(%eax),%edx
  800b3c:	8b 00                	mov    (%eax),%eax
  800b3e:	eb 38                	jmp    800b78 <getint+0x5d>
	else if (lflag)
  800b40:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b44:	74 1a                	je     800b60 <getint+0x45>
		return va_arg(*ap, long);
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	8d 50 04             	lea    0x4(%eax),%edx
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	89 10                	mov    %edx,(%eax)
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	8b 00                	mov    (%eax),%eax
  800b58:	83 e8 04             	sub    $0x4,%eax
  800b5b:	8b 00                	mov    (%eax),%eax
  800b5d:	99                   	cltd   
  800b5e:	eb 18                	jmp    800b78 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	8d 50 04             	lea    0x4(%eax),%edx
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	89 10                	mov    %edx,(%eax)
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	83 e8 04             	sub    $0x4,%eax
  800b75:	8b 00                	mov    (%eax),%eax
  800b77:	99                   	cltd   
}
  800b78:	5d                   	pop    %ebp
  800b79:	c3                   	ret    

00800b7a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b7a:	55                   	push   %ebp
  800b7b:	89 e5                	mov    %esp,%ebp
  800b7d:	56                   	push   %esi
  800b7e:	53                   	push   %ebx
  800b7f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b82:	eb 17                	jmp    800b9b <vprintfmt+0x21>
			if (ch == '\0')
  800b84:	85 db                	test   %ebx,%ebx
  800b86:	0f 84 af 03 00 00    	je     800f3b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b8c:	83 ec 08             	sub    $0x8,%esp
  800b8f:	ff 75 0c             	pushl  0xc(%ebp)
  800b92:	53                   	push   %ebx
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	ff d0                	call   *%eax
  800b98:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9e:	8d 50 01             	lea    0x1(%eax),%edx
  800ba1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba4:	8a 00                	mov    (%eax),%al
  800ba6:	0f b6 d8             	movzbl %al,%ebx
  800ba9:	83 fb 25             	cmp    $0x25,%ebx
  800bac:	75 d6                	jne    800b84 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bae:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bb2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bb9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bc0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bc7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bce:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd1:	8d 50 01             	lea    0x1(%eax),%edx
  800bd4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd7:	8a 00                	mov    (%eax),%al
  800bd9:	0f b6 d8             	movzbl %al,%ebx
  800bdc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bdf:	83 f8 55             	cmp    $0x55,%eax
  800be2:	0f 87 2b 03 00 00    	ja     800f13 <vprintfmt+0x399>
  800be8:	8b 04 85 98 26 80 00 	mov    0x802698(,%eax,4),%eax
  800bef:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bf1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bf5:	eb d7                	jmp    800bce <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bf7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bfb:	eb d1                	jmp    800bce <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bfd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c04:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c07:	89 d0                	mov    %edx,%eax
  800c09:	c1 e0 02             	shl    $0x2,%eax
  800c0c:	01 d0                	add    %edx,%eax
  800c0e:	01 c0                	add    %eax,%eax
  800c10:	01 d8                	add    %ebx,%eax
  800c12:	83 e8 30             	sub    $0x30,%eax
  800c15:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c18:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1b:	8a 00                	mov    (%eax),%al
  800c1d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c20:	83 fb 2f             	cmp    $0x2f,%ebx
  800c23:	7e 3e                	jle    800c63 <vprintfmt+0xe9>
  800c25:	83 fb 39             	cmp    $0x39,%ebx
  800c28:	7f 39                	jg     800c63 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c2a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c2d:	eb d5                	jmp    800c04 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c32:	83 c0 04             	add    $0x4,%eax
  800c35:	89 45 14             	mov    %eax,0x14(%ebp)
  800c38:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3b:	83 e8 04             	sub    $0x4,%eax
  800c3e:	8b 00                	mov    (%eax),%eax
  800c40:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c43:	eb 1f                	jmp    800c64 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c49:	79 83                	jns    800bce <vprintfmt+0x54>
				width = 0;
  800c4b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c52:	e9 77 ff ff ff       	jmp    800bce <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c57:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c5e:	e9 6b ff ff ff       	jmp    800bce <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c63:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c68:	0f 89 60 ff ff ff    	jns    800bce <vprintfmt+0x54>
				width = precision, precision = -1;
  800c6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c74:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c7b:	e9 4e ff ff ff       	jmp    800bce <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c80:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c83:	e9 46 ff ff ff       	jmp    800bce <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c88:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8b:	83 c0 04             	add    $0x4,%eax
  800c8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c91:	8b 45 14             	mov    0x14(%ebp),%eax
  800c94:	83 e8 04             	sub    $0x4,%eax
  800c97:	8b 00                	mov    (%eax),%eax
  800c99:	83 ec 08             	sub    $0x8,%esp
  800c9c:	ff 75 0c             	pushl  0xc(%ebp)
  800c9f:	50                   	push   %eax
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	ff d0                	call   *%eax
  800ca5:	83 c4 10             	add    $0x10,%esp
			break;
  800ca8:	e9 89 02 00 00       	jmp    800f36 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cad:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb0:	83 c0 04             	add    $0x4,%eax
  800cb3:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb9:	83 e8 04             	sub    $0x4,%eax
  800cbc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cbe:	85 db                	test   %ebx,%ebx
  800cc0:	79 02                	jns    800cc4 <vprintfmt+0x14a>
				err = -err;
  800cc2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cc4:	83 fb 64             	cmp    $0x64,%ebx
  800cc7:	7f 0b                	jg     800cd4 <vprintfmt+0x15a>
  800cc9:	8b 34 9d e0 24 80 00 	mov    0x8024e0(,%ebx,4),%esi
  800cd0:	85 f6                	test   %esi,%esi
  800cd2:	75 19                	jne    800ced <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cd4:	53                   	push   %ebx
  800cd5:	68 85 26 80 00       	push   $0x802685
  800cda:	ff 75 0c             	pushl  0xc(%ebp)
  800cdd:	ff 75 08             	pushl  0x8(%ebp)
  800ce0:	e8 5e 02 00 00       	call   800f43 <printfmt>
  800ce5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ce8:	e9 49 02 00 00       	jmp    800f36 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ced:	56                   	push   %esi
  800cee:	68 8e 26 80 00       	push   $0x80268e
  800cf3:	ff 75 0c             	pushl  0xc(%ebp)
  800cf6:	ff 75 08             	pushl  0x8(%ebp)
  800cf9:	e8 45 02 00 00       	call   800f43 <printfmt>
  800cfe:	83 c4 10             	add    $0x10,%esp
			break;
  800d01:	e9 30 02 00 00       	jmp    800f36 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d06:	8b 45 14             	mov    0x14(%ebp),%eax
  800d09:	83 c0 04             	add    $0x4,%eax
  800d0c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d12:	83 e8 04             	sub    $0x4,%eax
  800d15:	8b 30                	mov    (%eax),%esi
  800d17:	85 f6                	test   %esi,%esi
  800d19:	75 05                	jne    800d20 <vprintfmt+0x1a6>
				p = "(null)";
  800d1b:	be 91 26 80 00       	mov    $0x802691,%esi
			if (width > 0 && padc != '-')
  800d20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d24:	7e 6d                	jle    800d93 <vprintfmt+0x219>
  800d26:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d2a:	74 67                	je     800d93 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d2f:	83 ec 08             	sub    $0x8,%esp
  800d32:	50                   	push   %eax
  800d33:	56                   	push   %esi
  800d34:	e8 0c 03 00 00       	call   801045 <strnlen>
  800d39:	83 c4 10             	add    $0x10,%esp
  800d3c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d3f:	eb 16                	jmp    800d57 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d41:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	ff 75 0c             	pushl  0xc(%ebp)
  800d4b:	50                   	push   %eax
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	ff d0                	call   *%eax
  800d51:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d54:	ff 4d e4             	decl   -0x1c(%ebp)
  800d57:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5b:	7f e4                	jg     800d41 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d5d:	eb 34                	jmp    800d93 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d5f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d63:	74 1c                	je     800d81 <vprintfmt+0x207>
  800d65:	83 fb 1f             	cmp    $0x1f,%ebx
  800d68:	7e 05                	jle    800d6f <vprintfmt+0x1f5>
  800d6a:	83 fb 7e             	cmp    $0x7e,%ebx
  800d6d:	7e 12                	jle    800d81 <vprintfmt+0x207>
					putch('?', putdat);
  800d6f:	83 ec 08             	sub    $0x8,%esp
  800d72:	ff 75 0c             	pushl  0xc(%ebp)
  800d75:	6a 3f                	push   $0x3f
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	ff d0                	call   *%eax
  800d7c:	83 c4 10             	add    $0x10,%esp
  800d7f:	eb 0f                	jmp    800d90 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d81:	83 ec 08             	sub    $0x8,%esp
  800d84:	ff 75 0c             	pushl  0xc(%ebp)
  800d87:	53                   	push   %ebx
  800d88:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8b:	ff d0                	call   *%eax
  800d8d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d90:	ff 4d e4             	decl   -0x1c(%ebp)
  800d93:	89 f0                	mov    %esi,%eax
  800d95:	8d 70 01             	lea    0x1(%eax),%esi
  800d98:	8a 00                	mov    (%eax),%al
  800d9a:	0f be d8             	movsbl %al,%ebx
  800d9d:	85 db                	test   %ebx,%ebx
  800d9f:	74 24                	je     800dc5 <vprintfmt+0x24b>
  800da1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800da5:	78 b8                	js     800d5f <vprintfmt+0x1e5>
  800da7:	ff 4d e0             	decl   -0x20(%ebp)
  800daa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dae:	79 af                	jns    800d5f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800db0:	eb 13                	jmp    800dc5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800db2:	83 ec 08             	sub    $0x8,%esp
  800db5:	ff 75 0c             	pushl  0xc(%ebp)
  800db8:	6a 20                	push   $0x20
  800dba:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbd:	ff d0                	call   *%eax
  800dbf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc2:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dc9:	7f e7                	jg     800db2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dcb:	e9 66 01 00 00       	jmp    800f36 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dd0:	83 ec 08             	sub    $0x8,%esp
  800dd3:	ff 75 e8             	pushl  -0x18(%ebp)
  800dd6:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd9:	50                   	push   %eax
  800dda:	e8 3c fd ff ff       	call   800b1b <getint>
  800ddf:	83 c4 10             	add    $0x10,%esp
  800de2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800de8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800deb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dee:	85 d2                	test   %edx,%edx
  800df0:	79 23                	jns    800e15 <vprintfmt+0x29b>
				putch('-', putdat);
  800df2:	83 ec 08             	sub    $0x8,%esp
  800df5:	ff 75 0c             	pushl  0xc(%ebp)
  800df8:	6a 2d                	push   $0x2d
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	ff d0                	call   *%eax
  800dff:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e02:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e08:	f7 d8                	neg    %eax
  800e0a:	83 d2 00             	adc    $0x0,%edx
  800e0d:	f7 da                	neg    %edx
  800e0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e15:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e1c:	e9 bc 00 00 00       	jmp    800edd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e21:	83 ec 08             	sub    $0x8,%esp
  800e24:	ff 75 e8             	pushl  -0x18(%ebp)
  800e27:	8d 45 14             	lea    0x14(%ebp),%eax
  800e2a:	50                   	push   %eax
  800e2b:	e8 84 fc ff ff       	call   800ab4 <getuint>
  800e30:	83 c4 10             	add    $0x10,%esp
  800e33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e36:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e39:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e40:	e9 98 00 00 00       	jmp    800edd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	6a 58                	push   $0x58
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	ff d0                	call   *%eax
  800e52:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 58                	push   $0x58
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	6a 58                	push   $0x58
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	ff d0                	call   *%eax
  800e72:	83 c4 10             	add    $0x10,%esp
			break;
  800e75:	e9 bc 00 00 00       	jmp    800f36 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e7a:	83 ec 08             	sub    $0x8,%esp
  800e7d:	ff 75 0c             	pushl  0xc(%ebp)
  800e80:	6a 30                	push   $0x30
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e8a:	83 ec 08             	sub    $0x8,%esp
  800e8d:	ff 75 0c             	pushl  0xc(%ebp)
  800e90:	6a 78                	push   $0x78
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	ff d0                	call   *%eax
  800e97:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9d:	83 c0 04             	add    $0x4,%eax
  800ea0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ea3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea6:	83 e8 04             	sub    $0x4,%eax
  800ea9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800eab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800eb5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ebc:	eb 1f                	jmp    800edd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ebe:	83 ec 08             	sub    $0x8,%esp
  800ec1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ec4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ec7:	50                   	push   %eax
  800ec8:	e8 e7 fb ff ff       	call   800ab4 <getuint>
  800ecd:	83 c4 10             	add    $0x10,%esp
  800ed0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ed6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800edd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ee1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ee4:	83 ec 04             	sub    $0x4,%esp
  800ee7:	52                   	push   %edx
  800ee8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800eeb:	50                   	push   %eax
  800eec:	ff 75 f4             	pushl  -0xc(%ebp)
  800eef:	ff 75 f0             	pushl  -0x10(%ebp)
  800ef2:	ff 75 0c             	pushl  0xc(%ebp)
  800ef5:	ff 75 08             	pushl  0x8(%ebp)
  800ef8:	e8 00 fb ff ff       	call   8009fd <printnum>
  800efd:	83 c4 20             	add    $0x20,%esp
			break;
  800f00:	eb 34                	jmp    800f36 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f02:	83 ec 08             	sub    $0x8,%esp
  800f05:	ff 75 0c             	pushl  0xc(%ebp)
  800f08:	53                   	push   %ebx
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	ff d0                	call   *%eax
  800f0e:	83 c4 10             	add    $0x10,%esp
			break;
  800f11:	eb 23                	jmp    800f36 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f13:	83 ec 08             	sub    $0x8,%esp
  800f16:	ff 75 0c             	pushl  0xc(%ebp)
  800f19:	6a 25                	push   $0x25
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	ff d0                	call   *%eax
  800f20:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f23:	ff 4d 10             	decl   0x10(%ebp)
  800f26:	eb 03                	jmp    800f2b <vprintfmt+0x3b1>
  800f28:	ff 4d 10             	decl   0x10(%ebp)
  800f2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2e:	48                   	dec    %eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	3c 25                	cmp    $0x25,%al
  800f33:	75 f3                	jne    800f28 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f35:	90                   	nop
		}
	}
  800f36:	e9 47 fc ff ff       	jmp    800b82 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f3b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f3f:	5b                   	pop    %ebx
  800f40:	5e                   	pop    %esi
  800f41:	5d                   	pop    %ebp
  800f42:	c3                   	ret    

00800f43 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f43:	55                   	push   %ebp
  800f44:	89 e5                	mov    %esp,%ebp
  800f46:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f49:	8d 45 10             	lea    0x10(%ebp),%eax
  800f4c:	83 c0 04             	add    $0x4,%eax
  800f4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f52:	8b 45 10             	mov    0x10(%ebp),%eax
  800f55:	ff 75 f4             	pushl  -0xc(%ebp)
  800f58:	50                   	push   %eax
  800f59:	ff 75 0c             	pushl  0xc(%ebp)
  800f5c:	ff 75 08             	pushl  0x8(%ebp)
  800f5f:	e8 16 fc ff ff       	call   800b7a <vprintfmt>
  800f64:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f67:	90                   	nop
  800f68:	c9                   	leave  
  800f69:	c3                   	ret    

00800f6a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f6a:	55                   	push   %ebp
  800f6b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f70:	8b 40 08             	mov    0x8(%eax),%eax
  800f73:	8d 50 01             	lea    0x1(%eax),%edx
  800f76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f79:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7f:	8b 10                	mov    (%eax),%edx
  800f81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f84:	8b 40 04             	mov    0x4(%eax),%eax
  800f87:	39 c2                	cmp    %eax,%edx
  800f89:	73 12                	jae    800f9d <sprintputch+0x33>
		*b->buf++ = ch;
  800f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8e:	8b 00                	mov    (%eax),%eax
  800f90:	8d 48 01             	lea    0x1(%eax),%ecx
  800f93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f96:	89 0a                	mov    %ecx,(%edx)
  800f98:	8b 55 08             	mov    0x8(%ebp),%edx
  800f9b:	88 10                	mov    %dl,(%eax)
}
  800f9d:	90                   	nop
  800f9e:	5d                   	pop    %ebp
  800f9f:	c3                   	ret    

00800fa0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
  800fa3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	01 d0                	add    %edx,%eax
  800fb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fc1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fc5:	74 06                	je     800fcd <vsnprintf+0x2d>
  800fc7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fcb:	7f 07                	jg     800fd4 <vsnprintf+0x34>
		return -E_INVAL;
  800fcd:	b8 03 00 00 00       	mov    $0x3,%eax
  800fd2:	eb 20                	jmp    800ff4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fd4:	ff 75 14             	pushl  0x14(%ebp)
  800fd7:	ff 75 10             	pushl  0x10(%ebp)
  800fda:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fdd:	50                   	push   %eax
  800fde:	68 6a 0f 80 00       	push   $0x800f6a
  800fe3:	e8 92 fb ff ff       	call   800b7a <vprintfmt>
  800fe8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800feb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fee:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ffc:	8d 45 10             	lea    0x10(%ebp),%eax
  800fff:	83 c0 04             	add    $0x4,%eax
  801002:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801005:	8b 45 10             	mov    0x10(%ebp),%eax
  801008:	ff 75 f4             	pushl  -0xc(%ebp)
  80100b:	50                   	push   %eax
  80100c:	ff 75 0c             	pushl  0xc(%ebp)
  80100f:	ff 75 08             	pushl  0x8(%ebp)
  801012:	e8 89 ff ff ff       	call   800fa0 <vsnprintf>
  801017:	83 c4 10             	add    $0x10,%esp
  80101a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80101d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801020:	c9                   	leave  
  801021:	c3                   	ret    

00801022 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801022:	55                   	push   %ebp
  801023:	89 e5                	mov    %esp,%ebp
  801025:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801028:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102f:	eb 06                	jmp    801037 <strlen+0x15>
		n++;
  801031:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801034:	ff 45 08             	incl   0x8(%ebp)
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	8a 00                	mov    (%eax),%al
  80103c:	84 c0                	test   %al,%al
  80103e:	75 f1                	jne    801031 <strlen+0xf>
		n++;
	return n;
  801040:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801043:	c9                   	leave  
  801044:	c3                   	ret    

00801045 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801045:	55                   	push   %ebp
  801046:	89 e5                	mov    %esp,%ebp
  801048:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80104b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801052:	eb 09                	jmp    80105d <strnlen+0x18>
		n++;
  801054:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801057:	ff 45 08             	incl   0x8(%ebp)
  80105a:	ff 4d 0c             	decl   0xc(%ebp)
  80105d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801061:	74 09                	je     80106c <strnlen+0x27>
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	8a 00                	mov    (%eax),%al
  801068:	84 c0                	test   %al,%al
  80106a:	75 e8                	jne    801054 <strnlen+0xf>
		n++;
	return n;
  80106c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80106f:	c9                   	leave  
  801070:	c3                   	ret    

00801071 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801071:	55                   	push   %ebp
  801072:	89 e5                	mov    %esp,%ebp
  801074:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80107d:	90                   	nop
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8d 50 01             	lea    0x1(%eax),%edx
  801084:	89 55 08             	mov    %edx,0x8(%ebp)
  801087:	8b 55 0c             	mov    0xc(%ebp),%edx
  80108a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80108d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801090:	8a 12                	mov    (%edx),%dl
  801092:	88 10                	mov    %dl,(%eax)
  801094:	8a 00                	mov    (%eax),%al
  801096:	84 c0                	test   %al,%al
  801098:	75 e4                	jne    80107e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80109a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80109d:	c9                   	leave  
  80109e:	c3                   	ret    

0080109f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80109f:	55                   	push   %ebp
  8010a0:	89 e5                	mov    %esp,%ebp
  8010a2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010b2:	eb 1f                	jmp    8010d3 <strncpy+0x34>
		*dst++ = *src;
  8010b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ba:	89 55 08             	mov    %edx,0x8(%ebp)
  8010bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c0:	8a 12                	mov    (%edx),%dl
  8010c2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c7:	8a 00                	mov    (%eax),%al
  8010c9:	84 c0                	test   %al,%al
  8010cb:	74 03                	je     8010d0 <strncpy+0x31>
			src++;
  8010cd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010d0:	ff 45 fc             	incl   -0x4(%ebp)
  8010d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010d9:	72 d9                	jb     8010b4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010db:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010de:	c9                   	leave  
  8010df:	c3                   	ret    

008010e0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
  8010e3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f0:	74 30                	je     801122 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010f2:	eb 16                	jmp    80110a <strlcpy+0x2a>
			*dst++ = *src++;
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	8d 50 01             	lea    0x1(%eax),%edx
  8010fa:	89 55 08             	mov    %edx,0x8(%ebp)
  8010fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801100:	8d 4a 01             	lea    0x1(%edx),%ecx
  801103:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801106:	8a 12                	mov    (%edx),%dl
  801108:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80110a:	ff 4d 10             	decl   0x10(%ebp)
  80110d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801111:	74 09                	je     80111c <strlcpy+0x3c>
  801113:	8b 45 0c             	mov    0xc(%ebp),%eax
  801116:	8a 00                	mov    (%eax),%al
  801118:	84 c0                	test   %al,%al
  80111a:	75 d8                	jne    8010f4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
  80111f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801122:	8b 55 08             	mov    0x8(%ebp),%edx
  801125:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801128:	29 c2                	sub    %eax,%edx
  80112a:	89 d0                	mov    %edx,%eax
}
  80112c:	c9                   	leave  
  80112d:	c3                   	ret    

0080112e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80112e:	55                   	push   %ebp
  80112f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801131:	eb 06                	jmp    801139 <strcmp+0xb>
		p++, q++;
  801133:	ff 45 08             	incl   0x8(%ebp)
  801136:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	84 c0                	test   %al,%al
  801140:	74 0e                	je     801150 <strcmp+0x22>
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	8a 10                	mov    (%eax),%dl
  801147:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114a:	8a 00                	mov    (%eax),%al
  80114c:	38 c2                	cmp    %al,%dl
  80114e:	74 e3                	je     801133 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	0f b6 d0             	movzbl %al,%edx
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	0f b6 c0             	movzbl %al,%eax
  801160:	29 c2                	sub    %eax,%edx
  801162:	89 d0                	mov    %edx,%eax
}
  801164:	5d                   	pop    %ebp
  801165:	c3                   	ret    

00801166 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801169:	eb 09                	jmp    801174 <strncmp+0xe>
		n--, p++, q++;
  80116b:	ff 4d 10             	decl   0x10(%ebp)
  80116e:	ff 45 08             	incl   0x8(%ebp)
  801171:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801174:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801178:	74 17                	je     801191 <strncmp+0x2b>
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	84 c0                	test   %al,%al
  801181:	74 0e                	je     801191 <strncmp+0x2b>
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 10                	mov    (%eax),%dl
  801188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	38 c2                	cmp    %al,%dl
  80118f:	74 da                	je     80116b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801191:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801195:	75 07                	jne    80119e <strncmp+0x38>
		return 0;
  801197:	b8 00 00 00 00       	mov    $0x0,%eax
  80119c:	eb 14                	jmp    8011b2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	0f b6 d0             	movzbl %al,%edx
  8011a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	0f b6 c0             	movzbl %al,%eax
  8011ae:	29 c2                	sub    %eax,%edx
  8011b0:	89 d0                	mov    %edx,%eax
}
  8011b2:	5d                   	pop    %ebp
  8011b3:	c3                   	ret    

008011b4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
  8011b7:	83 ec 04             	sub    $0x4,%esp
  8011ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011c0:	eb 12                	jmp    8011d4 <strchr+0x20>
		if (*s == c)
  8011c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c5:	8a 00                	mov    (%eax),%al
  8011c7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ca:	75 05                	jne    8011d1 <strchr+0x1d>
			return (char *) s;
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	eb 11                	jmp    8011e2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011d1:	ff 45 08             	incl   0x8(%ebp)
  8011d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d7:	8a 00                	mov    (%eax),%al
  8011d9:	84 c0                	test   %al,%al
  8011db:	75 e5                	jne    8011c2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011e2:	c9                   	leave  
  8011e3:	c3                   	ret    

008011e4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011e4:	55                   	push   %ebp
  8011e5:	89 e5                	mov    %esp,%ebp
  8011e7:	83 ec 04             	sub    $0x4,%esp
  8011ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011f0:	eb 0d                	jmp    8011ff <strfind+0x1b>
		if (*s == c)
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011fa:	74 0e                	je     80120a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011fc:	ff 45 08             	incl   0x8(%ebp)
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	8a 00                	mov    (%eax),%al
  801204:	84 c0                	test   %al,%al
  801206:	75 ea                	jne    8011f2 <strfind+0xe>
  801208:	eb 01                	jmp    80120b <strfind+0x27>
		if (*s == c)
			break;
  80120a:	90                   	nop
	return (char *) s;
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
  801213:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80121c:	8b 45 10             	mov    0x10(%ebp),%eax
  80121f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801222:	eb 0e                	jmp    801232 <memset+0x22>
		*p++ = c;
  801224:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801227:	8d 50 01             	lea    0x1(%eax),%edx
  80122a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80122d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801230:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801232:	ff 4d f8             	decl   -0x8(%ebp)
  801235:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801239:	79 e9                	jns    801224 <memset+0x14>
		*p++ = c;

	return v;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80123e:	c9                   	leave  
  80123f:	c3                   	ret    

00801240 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801240:	55                   	push   %ebp
  801241:	89 e5                	mov    %esp,%ebp
  801243:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801252:	eb 16                	jmp    80126a <memcpy+0x2a>
		*d++ = *s++;
  801254:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801257:	8d 50 01             	lea    0x1(%eax),%edx
  80125a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80125d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801260:	8d 4a 01             	lea    0x1(%edx),%ecx
  801263:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801266:	8a 12                	mov    (%edx),%dl
  801268:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80126a:	8b 45 10             	mov    0x10(%ebp),%eax
  80126d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801270:	89 55 10             	mov    %edx,0x10(%ebp)
  801273:	85 c0                	test   %eax,%eax
  801275:	75 dd                	jne    801254 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80127a:	c9                   	leave  
  80127b:	c3                   	ret    

0080127c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80127c:	55                   	push   %ebp
  80127d:	89 e5                	mov    %esp,%ebp
  80127f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801282:	8b 45 0c             	mov    0xc(%ebp),%eax
  801285:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801288:	8b 45 08             	mov    0x8(%ebp),%eax
  80128b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80128e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801291:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801294:	73 50                	jae    8012e6 <memmove+0x6a>
  801296:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801299:	8b 45 10             	mov    0x10(%ebp),%eax
  80129c:	01 d0                	add    %edx,%eax
  80129e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012a1:	76 43                	jbe    8012e6 <memmove+0x6a>
		s += n;
  8012a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ac:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012af:	eb 10                	jmp    8012c1 <memmove+0x45>
			*--d = *--s;
  8012b1:	ff 4d f8             	decl   -0x8(%ebp)
  8012b4:	ff 4d fc             	decl   -0x4(%ebp)
  8012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ba:	8a 10                	mov    (%eax),%dl
  8012bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ca:	85 c0                	test   %eax,%eax
  8012cc:	75 e3                	jne    8012b1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012ce:	eb 23                	jmp    8012f3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d3:	8d 50 01             	lea    0x1(%eax),%edx
  8012d6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012dc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012df:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012e2:	8a 12                	mov    (%edx),%dl
  8012e4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ec:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ef:	85 c0                	test   %eax,%eax
  8012f1:	75 dd                	jne    8012d0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012f6:	c9                   	leave  
  8012f7:	c3                   	ret    

008012f8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012f8:	55                   	push   %ebp
  8012f9:	89 e5                	mov    %esp,%ebp
  8012fb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801304:	8b 45 0c             	mov    0xc(%ebp),%eax
  801307:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80130a:	eb 2a                	jmp    801336 <memcmp+0x3e>
		if (*s1 != *s2)
  80130c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130f:	8a 10                	mov    (%eax),%dl
  801311:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	38 c2                	cmp    %al,%dl
  801318:	74 16                	je     801330 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80131a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131d:	8a 00                	mov    (%eax),%al
  80131f:	0f b6 d0             	movzbl %al,%edx
  801322:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801325:	8a 00                	mov    (%eax),%al
  801327:	0f b6 c0             	movzbl %al,%eax
  80132a:	29 c2                	sub    %eax,%edx
  80132c:	89 d0                	mov    %edx,%eax
  80132e:	eb 18                	jmp    801348 <memcmp+0x50>
		s1++, s2++;
  801330:	ff 45 fc             	incl   -0x4(%ebp)
  801333:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801336:	8b 45 10             	mov    0x10(%ebp),%eax
  801339:	8d 50 ff             	lea    -0x1(%eax),%edx
  80133c:	89 55 10             	mov    %edx,0x10(%ebp)
  80133f:	85 c0                	test   %eax,%eax
  801341:	75 c9                	jne    80130c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801343:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801348:	c9                   	leave  
  801349:	c3                   	ret    

0080134a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
  80134d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801350:	8b 55 08             	mov    0x8(%ebp),%edx
  801353:	8b 45 10             	mov    0x10(%ebp),%eax
  801356:	01 d0                	add    %edx,%eax
  801358:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80135b:	eb 15                	jmp    801372 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	0f b6 d0             	movzbl %al,%edx
  801365:	8b 45 0c             	mov    0xc(%ebp),%eax
  801368:	0f b6 c0             	movzbl %al,%eax
  80136b:	39 c2                	cmp    %eax,%edx
  80136d:	74 0d                	je     80137c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80136f:	ff 45 08             	incl   0x8(%ebp)
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801378:	72 e3                	jb     80135d <memfind+0x13>
  80137a:	eb 01                	jmp    80137d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80137c:	90                   	nop
	return (void *) s;
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
  801385:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80138f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801396:	eb 03                	jmp    80139b <strtol+0x19>
		s++;
  801398:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8a 00                	mov    (%eax),%al
  8013a0:	3c 20                	cmp    $0x20,%al
  8013a2:	74 f4                	je     801398 <strtol+0x16>
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	3c 09                	cmp    $0x9,%al
  8013ab:	74 eb                	je     801398 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	8a 00                	mov    (%eax),%al
  8013b2:	3c 2b                	cmp    $0x2b,%al
  8013b4:	75 05                	jne    8013bb <strtol+0x39>
		s++;
  8013b6:	ff 45 08             	incl   0x8(%ebp)
  8013b9:	eb 13                	jmp    8013ce <strtol+0x4c>
	else if (*s == '-')
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	8a 00                	mov    (%eax),%al
  8013c0:	3c 2d                	cmp    $0x2d,%al
  8013c2:	75 0a                	jne    8013ce <strtol+0x4c>
		s++, neg = 1;
  8013c4:	ff 45 08             	incl   0x8(%ebp)
  8013c7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d2:	74 06                	je     8013da <strtol+0x58>
  8013d4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013d8:	75 20                	jne    8013fa <strtol+0x78>
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	8a 00                	mov    (%eax),%al
  8013df:	3c 30                	cmp    $0x30,%al
  8013e1:	75 17                	jne    8013fa <strtol+0x78>
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	40                   	inc    %eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	3c 78                	cmp    $0x78,%al
  8013eb:	75 0d                	jne    8013fa <strtol+0x78>
		s += 2, base = 16;
  8013ed:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013f1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013f8:	eb 28                	jmp    801422 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fe:	75 15                	jne    801415 <strtol+0x93>
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	3c 30                	cmp    $0x30,%al
  801407:	75 0c                	jne    801415 <strtol+0x93>
		s++, base = 8;
  801409:	ff 45 08             	incl   0x8(%ebp)
  80140c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801413:	eb 0d                	jmp    801422 <strtol+0xa0>
	else if (base == 0)
  801415:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801419:	75 07                	jne    801422 <strtol+0xa0>
		base = 10;
  80141b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	3c 2f                	cmp    $0x2f,%al
  801429:	7e 19                	jle    801444 <strtol+0xc2>
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	3c 39                	cmp    $0x39,%al
  801432:	7f 10                	jg     801444 <strtol+0xc2>
			dig = *s - '0';
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	0f be c0             	movsbl %al,%eax
  80143c:	83 e8 30             	sub    $0x30,%eax
  80143f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801442:	eb 42                	jmp    801486 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	3c 60                	cmp    $0x60,%al
  80144b:	7e 19                	jle    801466 <strtol+0xe4>
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	3c 7a                	cmp    $0x7a,%al
  801454:	7f 10                	jg     801466 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	0f be c0             	movsbl %al,%eax
  80145e:	83 e8 57             	sub    $0x57,%eax
  801461:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801464:	eb 20                	jmp    801486 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	3c 40                	cmp    $0x40,%al
  80146d:	7e 39                	jle    8014a8 <strtol+0x126>
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	3c 5a                	cmp    $0x5a,%al
  801476:	7f 30                	jg     8014a8 <strtol+0x126>
			dig = *s - 'A' + 10;
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	0f be c0             	movsbl %al,%eax
  801480:	83 e8 37             	sub    $0x37,%eax
  801483:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801486:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801489:	3b 45 10             	cmp    0x10(%ebp),%eax
  80148c:	7d 19                	jge    8014a7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80148e:	ff 45 08             	incl   0x8(%ebp)
  801491:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801494:	0f af 45 10          	imul   0x10(%ebp),%eax
  801498:	89 c2                	mov    %eax,%edx
  80149a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80149d:	01 d0                	add    %edx,%eax
  80149f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014a2:	e9 7b ff ff ff       	jmp    801422 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014a7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014ac:	74 08                	je     8014b6 <strtol+0x134>
		*endptr = (char *) s;
  8014ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b1:	8b 55 08             	mov    0x8(%ebp),%edx
  8014b4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014ba:	74 07                	je     8014c3 <strtol+0x141>
  8014bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014bf:	f7 d8                	neg    %eax
  8014c1:	eb 03                	jmp    8014c6 <strtol+0x144>
  8014c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <ltostr>:

void
ltostr(long value, char *str)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014e0:	79 13                	jns    8014f5 <ltostr+0x2d>
	{
		neg = 1;
  8014e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ec:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014ef:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014f2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014fd:	99                   	cltd   
  8014fe:	f7 f9                	idiv   %ecx
  801500:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801503:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801506:	8d 50 01             	lea    0x1(%eax),%edx
  801509:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80150c:	89 c2                	mov    %eax,%edx
  80150e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801511:	01 d0                	add    %edx,%eax
  801513:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801516:	83 c2 30             	add    $0x30,%edx
  801519:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80151b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80151e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801523:	f7 e9                	imul   %ecx
  801525:	c1 fa 02             	sar    $0x2,%edx
  801528:	89 c8                	mov    %ecx,%eax
  80152a:	c1 f8 1f             	sar    $0x1f,%eax
  80152d:	29 c2                	sub    %eax,%edx
  80152f:	89 d0                	mov    %edx,%eax
  801531:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801534:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801537:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80153c:	f7 e9                	imul   %ecx
  80153e:	c1 fa 02             	sar    $0x2,%edx
  801541:	89 c8                	mov    %ecx,%eax
  801543:	c1 f8 1f             	sar    $0x1f,%eax
  801546:	29 c2                	sub    %eax,%edx
  801548:	89 d0                	mov    %edx,%eax
  80154a:	c1 e0 02             	shl    $0x2,%eax
  80154d:	01 d0                	add    %edx,%eax
  80154f:	01 c0                	add    %eax,%eax
  801551:	29 c1                	sub    %eax,%ecx
  801553:	89 ca                	mov    %ecx,%edx
  801555:	85 d2                	test   %edx,%edx
  801557:	75 9c                	jne    8014f5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801559:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801560:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801563:	48                   	dec    %eax
  801564:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801567:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80156b:	74 3d                	je     8015aa <ltostr+0xe2>
		start = 1 ;
  80156d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801574:	eb 34                	jmp    8015aa <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801576:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801579:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157c:	01 d0                	add    %edx,%eax
  80157e:	8a 00                	mov    (%eax),%al
  801580:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801583:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801586:	8b 45 0c             	mov    0xc(%ebp),%eax
  801589:	01 c2                	add    %eax,%edx
  80158b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80158e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801591:	01 c8                	add    %ecx,%eax
  801593:	8a 00                	mov    (%eax),%al
  801595:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801597:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80159a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159d:	01 c2                	add    %eax,%edx
  80159f:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015a2:	88 02                	mov    %al,(%edx)
		start++ ;
  8015a4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015a7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015b0:	7c c4                	jl     801576 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b8:	01 d0                	add    %edx,%eax
  8015ba:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015bd:	90                   	nop
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
  8015c3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015c6:	ff 75 08             	pushl  0x8(%ebp)
  8015c9:	e8 54 fa ff ff       	call   801022 <strlen>
  8015ce:	83 c4 04             	add    $0x4,%esp
  8015d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015d4:	ff 75 0c             	pushl  0xc(%ebp)
  8015d7:	e8 46 fa ff ff       	call   801022 <strlen>
  8015dc:	83 c4 04             	add    $0x4,%esp
  8015df:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015f0:	eb 17                	jmp    801609 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f8:	01 c2                	add    %eax,%edx
  8015fa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801600:	01 c8                	add    %ecx,%eax
  801602:	8a 00                	mov    (%eax),%al
  801604:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801606:	ff 45 fc             	incl   -0x4(%ebp)
  801609:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80160f:	7c e1                	jl     8015f2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801611:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801618:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80161f:	eb 1f                	jmp    801640 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801621:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801624:	8d 50 01             	lea    0x1(%eax),%edx
  801627:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80162a:	89 c2                	mov    %eax,%edx
  80162c:	8b 45 10             	mov    0x10(%ebp),%eax
  80162f:	01 c2                	add    %eax,%edx
  801631:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801634:	8b 45 0c             	mov    0xc(%ebp),%eax
  801637:	01 c8                	add    %ecx,%eax
  801639:	8a 00                	mov    (%eax),%al
  80163b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80163d:	ff 45 f8             	incl   -0x8(%ebp)
  801640:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801643:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801646:	7c d9                	jl     801621 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801648:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80164b:	8b 45 10             	mov    0x10(%ebp),%eax
  80164e:	01 d0                	add    %edx,%eax
  801650:	c6 00 00             	movb   $0x0,(%eax)
}
  801653:	90                   	nop
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801659:	8b 45 14             	mov    0x14(%ebp),%eax
  80165c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801662:	8b 45 14             	mov    0x14(%ebp),%eax
  801665:	8b 00                	mov    (%eax),%eax
  801667:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	01 d0                	add    %edx,%eax
  801673:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801679:	eb 0c                	jmp    801687 <strsplit+0x31>
			*string++ = 0;
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8d 50 01             	lea    0x1(%eax),%edx
  801681:	89 55 08             	mov    %edx,0x8(%ebp)
  801684:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801687:	8b 45 08             	mov    0x8(%ebp),%eax
  80168a:	8a 00                	mov    (%eax),%al
  80168c:	84 c0                	test   %al,%al
  80168e:	74 18                	je     8016a8 <strsplit+0x52>
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	0f be c0             	movsbl %al,%eax
  801698:	50                   	push   %eax
  801699:	ff 75 0c             	pushl  0xc(%ebp)
  80169c:	e8 13 fb ff ff       	call   8011b4 <strchr>
  8016a1:	83 c4 08             	add    $0x8,%esp
  8016a4:	85 c0                	test   %eax,%eax
  8016a6:	75 d3                	jne    80167b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	84 c0                	test   %al,%al
  8016af:	74 5a                	je     80170b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b4:	8b 00                	mov    (%eax),%eax
  8016b6:	83 f8 0f             	cmp    $0xf,%eax
  8016b9:	75 07                	jne    8016c2 <strsplit+0x6c>
		{
			return 0;
  8016bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8016c0:	eb 66                	jmp    801728 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c5:	8b 00                	mov    (%eax),%eax
  8016c7:	8d 48 01             	lea    0x1(%eax),%ecx
  8016ca:	8b 55 14             	mov    0x14(%ebp),%edx
  8016cd:	89 0a                	mov    %ecx,(%edx)
  8016cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d9:	01 c2                	add    %eax,%edx
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016e0:	eb 03                	jmp    8016e5 <strsplit+0x8f>
			string++;
  8016e2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e8:	8a 00                	mov    (%eax),%al
  8016ea:	84 c0                	test   %al,%al
  8016ec:	74 8b                	je     801679 <strsplit+0x23>
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	8a 00                	mov    (%eax),%al
  8016f3:	0f be c0             	movsbl %al,%eax
  8016f6:	50                   	push   %eax
  8016f7:	ff 75 0c             	pushl  0xc(%ebp)
  8016fa:	e8 b5 fa ff ff       	call   8011b4 <strchr>
  8016ff:	83 c4 08             	add    $0x8,%esp
  801702:	85 c0                	test   %eax,%eax
  801704:	74 dc                	je     8016e2 <strsplit+0x8c>
			string++;
	}
  801706:	e9 6e ff ff ff       	jmp    801679 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80170b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80170c:	8b 45 14             	mov    0x14(%ebp),%eax
  80170f:	8b 00                	mov    (%eax),%eax
  801711:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	01 d0                	add    %edx,%eax
  80171d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801723:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801728:	c9                   	leave  
  801729:	c3                   	ret    

0080172a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80172a:	55                   	push   %ebp
  80172b:	89 e5                	mov    %esp,%ebp
  80172d:	57                   	push   %edi
  80172e:	56                   	push   %esi
  80172f:	53                   	push   %ebx
  801730:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8b 55 0c             	mov    0xc(%ebp),%edx
  801739:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80173c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80173f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801742:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801745:	cd 30                	int    $0x30
  801747:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80174a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80174d:	83 c4 10             	add    $0x10,%esp
  801750:	5b                   	pop    %ebx
  801751:	5e                   	pop    %esi
  801752:	5f                   	pop    %edi
  801753:	5d                   	pop    %ebp
  801754:	c3                   	ret    

00801755 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
  801758:	83 ec 04             	sub    $0x4,%esp
  80175b:	8b 45 10             	mov    0x10(%ebp),%eax
  80175e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801761:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	52                   	push   %edx
  80176d:	ff 75 0c             	pushl  0xc(%ebp)
  801770:	50                   	push   %eax
  801771:	6a 00                	push   $0x0
  801773:	e8 b2 ff ff ff       	call   80172a <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	90                   	nop
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_cgetc>:

int
sys_cgetc(void)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 01                	push   $0x1
  80178d:	e8 98 ff ff ff       	call   80172a <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	50                   	push   %eax
  8017a6:	6a 05                	push   $0x5
  8017a8:	e8 7d ff ff ff       	call   80172a <syscall>
  8017ad:	83 c4 18             	add    $0x18,%esp
}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 02                	push   $0x2
  8017c1:	e8 64 ff ff ff       	call   80172a <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 03                	push   $0x3
  8017da:	e8 4b ff ff ff       	call   80172a <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 04                	push   $0x4
  8017f3:	e8 32 ff ff ff       	call   80172a <syscall>
  8017f8:	83 c4 18             	add    $0x18,%esp
}
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <sys_env_exit>:


void sys_env_exit(void)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 06                	push   $0x6
  80180c:	e8 19 ff ff ff       	call   80172a <syscall>
  801811:	83 c4 18             	add    $0x18,%esp
}
  801814:	90                   	nop
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80181a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	52                   	push   %edx
  801827:	50                   	push   %eax
  801828:	6a 07                	push   $0x7
  80182a:	e8 fb fe ff ff       	call   80172a <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
  801837:	56                   	push   %esi
  801838:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801839:	8b 75 18             	mov    0x18(%ebp),%esi
  80183c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80183f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801842:	8b 55 0c             	mov    0xc(%ebp),%edx
  801845:	8b 45 08             	mov    0x8(%ebp),%eax
  801848:	56                   	push   %esi
  801849:	53                   	push   %ebx
  80184a:	51                   	push   %ecx
  80184b:	52                   	push   %edx
  80184c:	50                   	push   %eax
  80184d:	6a 08                	push   $0x8
  80184f:	e8 d6 fe ff ff       	call   80172a <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
}
  801857:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80185a:	5b                   	pop    %ebx
  80185b:	5e                   	pop    %esi
  80185c:	5d                   	pop    %ebp
  80185d:	c3                   	ret    

0080185e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80185e:	55                   	push   %ebp
  80185f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801861:	8b 55 0c             	mov    0xc(%ebp),%edx
  801864:	8b 45 08             	mov    0x8(%ebp),%eax
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	52                   	push   %edx
  80186e:	50                   	push   %eax
  80186f:	6a 09                	push   $0x9
  801871:	e8 b4 fe ff ff       	call   80172a <syscall>
  801876:	83 c4 18             	add    $0x18,%esp
}
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	ff 75 0c             	pushl  0xc(%ebp)
  801887:	ff 75 08             	pushl  0x8(%ebp)
  80188a:	6a 0a                	push   $0xa
  80188c:	e8 99 fe ff ff       	call   80172a <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 0b                	push   $0xb
  8018a5:	e8 80 fe ff ff       	call   80172a <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 0c                	push   $0xc
  8018be:	e8 67 fe ff ff       	call   80172a <syscall>
  8018c3:	83 c4 18             	add    $0x18,%esp
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 0d                	push   $0xd
  8018d7:	e8 4e fe ff ff       	call   80172a <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	ff 75 0c             	pushl  0xc(%ebp)
  8018ed:	ff 75 08             	pushl  0x8(%ebp)
  8018f0:	6a 11                	push   $0x11
  8018f2:	e8 33 fe ff ff       	call   80172a <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
	return;
  8018fa:	90                   	nop
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	ff 75 0c             	pushl  0xc(%ebp)
  801909:	ff 75 08             	pushl  0x8(%ebp)
  80190c:	6a 12                	push   $0x12
  80190e:	e8 17 fe ff ff       	call   80172a <syscall>
  801913:	83 c4 18             	add    $0x18,%esp
	return ;
  801916:	90                   	nop
}
  801917:	c9                   	leave  
  801918:	c3                   	ret    

00801919 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 0e                	push   $0xe
  801928:	e8 fd fd ff ff       	call   80172a <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	ff 75 08             	pushl  0x8(%ebp)
  801940:	6a 0f                	push   $0xf
  801942:	e8 e3 fd ff ff       	call   80172a <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
}
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 10                	push   $0x10
  80195b:	e8 ca fd ff ff       	call   80172a <syscall>
  801960:	83 c4 18             	add    $0x18,%esp
}
  801963:	90                   	nop
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 14                	push   $0x14
  801975:	e8 b0 fd ff ff       	call   80172a <syscall>
  80197a:	83 c4 18             	add    $0x18,%esp
}
  80197d:	90                   	nop
  80197e:	c9                   	leave  
  80197f:	c3                   	ret    

00801980 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801980:	55                   	push   %ebp
  801981:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 15                	push   $0x15
  80198f:	e8 96 fd ff ff       	call   80172a <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	90                   	nop
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <sys_cputc>:


void
sys_cputc(const char c)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
  80199d:	83 ec 04             	sub    $0x4,%esp
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019a6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	50                   	push   %eax
  8019b3:	6a 16                	push   $0x16
  8019b5:	e8 70 fd ff ff       	call   80172a <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
}
  8019bd:	90                   	nop
  8019be:	c9                   	leave  
  8019bf:	c3                   	ret    

008019c0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 17                	push   $0x17
  8019cf:	e8 56 fd ff ff       	call   80172a <syscall>
  8019d4:	83 c4 18             	add    $0x18,%esp
}
  8019d7:	90                   	nop
  8019d8:	c9                   	leave  
  8019d9:	c3                   	ret    

008019da <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019da:	55                   	push   %ebp
  8019db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	ff 75 0c             	pushl  0xc(%ebp)
  8019e9:	50                   	push   %eax
  8019ea:	6a 18                	push   $0x18
  8019ec:	e8 39 fd ff ff       	call   80172a <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	c9                   	leave  
  8019f5:	c3                   	ret    

008019f6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019f6:	55                   	push   %ebp
  8019f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	52                   	push   %edx
  801a06:	50                   	push   %eax
  801a07:	6a 1b                	push   $0x1b
  801a09:	e8 1c fd ff ff       	call   80172a <syscall>
  801a0e:	83 c4 18             	add    $0x18,%esp
}
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a16:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a19:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	52                   	push   %edx
  801a23:	50                   	push   %eax
  801a24:	6a 19                	push   $0x19
  801a26:	e8 ff fc ff ff       	call   80172a <syscall>
  801a2b:	83 c4 18             	add    $0x18,%esp
}
  801a2e:	90                   	nop
  801a2f:	c9                   	leave  
  801a30:	c3                   	ret    

00801a31 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a31:	55                   	push   %ebp
  801a32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a37:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	52                   	push   %edx
  801a41:	50                   	push   %eax
  801a42:	6a 1a                	push   $0x1a
  801a44:	e8 e1 fc ff ff       	call   80172a <syscall>
  801a49:	83 c4 18             	add    $0x18,%esp
}
  801a4c:	90                   	nop
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
  801a52:	83 ec 04             	sub    $0x4,%esp
  801a55:	8b 45 10             	mov    0x10(%ebp),%eax
  801a58:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a5b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a5e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a62:	8b 45 08             	mov    0x8(%ebp),%eax
  801a65:	6a 00                	push   $0x0
  801a67:	51                   	push   %ecx
  801a68:	52                   	push   %edx
  801a69:	ff 75 0c             	pushl  0xc(%ebp)
  801a6c:	50                   	push   %eax
  801a6d:	6a 1c                	push   $0x1c
  801a6f:	e8 b6 fc ff ff       	call   80172a <syscall>
  801a74:	83 c4 18             	add    $0x18,%esp
}
  801a77:	c9                   	leave  
  801a78:	c3                   	ret    

00801a79 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a79:	55                   	push   %ebp
  801a7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	52                   	push   %edx
  801a89:	50                   	push   %eax
  801a8a:	6a 1d                	push   $0x1d
  801a8c:	e8 99 fc ff ff       	call   80172a <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
}
  801a94:	c9                   	leave  
  801a95:	c3                   	ret    

00801a96 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a99:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	51                   	push   %ecx
  801aa7:	52                   	push   %edx
  801aa8:	50                   	push   %eax
  801aa9:	6a 1e                	push   $0x1e
  801aab:	e8 7a fc ff ff       	call   80172a <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	c9                   	leave  
  801ab4:	c3                   	ret    

00801ab5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ab8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801abb:	8b 45 08             	mov    0x8(%ebp),%eax
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	52                   	push   %edx
  801ac5:	50                   	push   %eax
  801ac6:	6a 1f                	push   $0x1f
  801ac8:	e8 5d fc ff ff       	call   80172a <syscall>
  801acd:	83 c4 18             	add    $0x18,%esp
}
  801ad0:	c9                   	leave  
  801ad1:	c3                   	ret    

00801ad2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ad2:	55                   	push   %ebp
  801ad3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 20                	push   $0x20
  801ae1:	e8 44 fc ff ff       	call   80172a <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
}
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801aee:	8b 45 08             	mov    0x8(%ebp),%eax
  801af1:	6a 00                	push   $0x0
  801af3:	ff 75 14             	pushl  0x14(%ebp)
  801af6:	ff 75 10             	pushl  0x10(%ebp)
  801af9:	ff 75 0c             	pushl  0xc(%ebp)
  801afc:	50                   	push   %eax
  801afd:	6a 21                	push   $0x21
  801aff:	e8 26 fc ff ff       	call   80172a <syscall>
  801b04:	83 c4 18             	add    $0x18,%esp
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	50                   	push   %eax
  801b18:	6a 22                	push   $0x22
  801b1a:	e8 0b fc ff ff       	call   80172a <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
}
  801b22:	90                   	nop
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b28:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	50                   	push   %eax
  801b34:	6a 23                	push   $0x23
  801b36:	e8 ef fb ff ff       	call   80172a <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
}
  801b3e:	90                   	nop
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
  801b44:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b47:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b4a:	8d 50 04             	lea    0x4(%eax),%edx
  801b4d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	52                   	push   %edx
  801b57:	50                   	push   %eax
  801b58:	6a 24                	push   $0x24
  801b5a:	e8 cb fb ff ff       	call   80172a <syscall>
  801b5f:	83 c4 18             	add    $0x18,%esp
	return result;
  801b62:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b68:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b6b:	89 01                	mov    %eax,(%ecx)
  801b6d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b70:	8b 45 08             	mov    0x8(%ebp),%eax
  801b73:	c9                   	leave  
  801b74:	c2 04 00             	ret    $0x4

00801b77 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	ff 75 10             	pushl  0x10(%ebp)
  801b81:	ff 75 0c             	pushl  0xc(%ebp)
  801b84:	ff 75 08             	pushl  0x8(%ebp)
  801b87:	6a 13                	push   $0x13
  801b89:	e8 9c fb ff ff       	call   80172a <syscall>
  801b8e:	83 c4 18             	add    $0x18,%esp
	return ;
  801b91:	90                   	nop
}
  801b92:	c9                   	leave  
  801b93:	c3                   	ret    

00801b94 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b94:	55                   	push   %ebp
  801b95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 25                	push   $0x25
  801ba3:	e8 82 fb ff ff       	call   80172a <syscall>
  801ba8:	83 c4 18             	add    $0x18,%esp
}
  801bab:	c9                   	leave  
  801bac:	c3                   	ret    

00801bad <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bad:	55                   	push   %ebp
  801bae:	89 e5                	mov    %esp,%ebp
  801bb0:	83 ec 04             	sub    $0x4,%esp
  801bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bb9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	50                   	push   %eax
  801bc6:	6a 26                	push   $0x26
  801bc8:	e8 5d fb ff ff       	call   80172a <syscall>
  801bcd:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd0:	90                   	nop
}
  801bd1:	c9                   	leave  
  801bd2:	c3                   	ret    

00801bd3 <rsttst>:
void rsttst()
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 28                	push   $0x28
  801be2:	e8 43 fb ff ff       	call   80172a <syscall>
  801be7:	83 c4 18             	add    $0x18,%esp
	return ;
  801bea:	90                   	nop
}
  801beb:	c9                   	leave  
  801bec:	c3                   	ret    

00801bed <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 04             	sub    $0x4,%esp
  801bf3:	8b 45 14             	mov    0x14(%ebp),%eax
  801bf6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bf9:	8b 55 18             	mov    0x18(%ebp),%edx
  801bfc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c00:	52                   	push   %edx
  801c01:	50                   	push   %eax
  801c02:	ff 75 10             	pushl  0x10(%ebp)
  801c05:	ff 75 0c             	pushl  0xc(%ebp)
  801c08:	ff 75 08             	pushl  0x8(%ebp)
  801c0b:	6a 27                	push   $0x27
  801c0d:	e8 18 fb ff ff       	call   80172a <syscall>
  801c12:	83 c4 18             	add    $0x18,%esp
	return ;
  801c15:	90                   	nop
}
  801c16:	c9                   	leave  
  801c17:	c3                   	ret    

00801c18 <chktst>:
void chktst(uint32 n)
{
  801c18:	55                   	push   %ebp
  801c19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	ff 75 08             	pushl  0x8(%ebp)
  801c26:	6a 29                	push   $0x29
  801c28:	e8 fd fa ff ff       	call   80172a <syscall>
  801c2d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c30:	90                   	nop
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <inctst>:

void inctst()
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 2a                	push   $0x2a
  801c42:	e8 e3 fa ff ff       	call   80172a <syscall>
  801c47:	83 c4 18             	add    $0x18,%esp
	return ;
  801c4a:	90                   	nop
}
  801c4b:	c9                   	leave  
  801c4c:	c3                   	ret    

00801c4d <gettst>:
uint32 gettst()
{
  801c4d:	55                   	push   %ebp
  801c4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 2b                	push   $0x2b
  801c5c:	e8 c9 fa ff ff       	call   80172a <syscall>
  801c61:	83 c4 18             	add    $0x18,%esp
}
  801c64:	c9                   	leave  
  801c65:	c3                   	ret    

00801c66 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
  801c69:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 2c                	push   $0x2c
  801c78:	e8 ad fa ff ff       	call   80172a <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
  801c80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c83:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c87:	75 07                	jne    801c90 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c89:	b8 01 00 00 00       	mov    $0x1,%eax
  801c8e:	eb 05                	jmp    801c95 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c90:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c95:	c9                   	leave  
  801c96:	c3                   	ret    

00801c97 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
  801c9a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 2c                	push   $0x2c
  801ca9:	e8 7c fa ff ff       	call   80172a <syscall>
  801cae:	83 c4 18             	add    $0x18,%esp
  801cb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cb4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cb8:	75 07                	jne    801cc1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cba:	b8 01 00 00 00       	mov    $0x1,%eax
  801cbf:	eb 05                	jmp    801cc6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cc1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cc6:	c9                   	leave  
  801cc7:	c3                   	ret    

00801cc8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cc8:	55                   	push   %ebp
  801cc9:	89 e5                	mov    %esp,%ebp
  801ccb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 2c                	push   $0x2c
  801cda:	e8 4b fa ff ff       	call   80172a <syscall>
  801cdf:	83 c4 18             	add    $0x18,%esp
  801ce2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ce5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ce9:	75 07                	jne    801cf2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ceb:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf0:	eb 05                	jmp    801cf7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cf2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cf7:	c9                   	leave  
  801cf8:	c3                   	ret    

00801cf9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
  801cfc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 2c                	push   $0x2c
  801d0b:	e8 1a fa ff ff       	call   80172a <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
  801d13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d16:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d1a:	75 07                	jne    801d23 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d1c:	b8 01 00 00 00       	mov    $0x1,%eax
  801d21:	eb 05                	jmp    801d28 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d28:	c9                   	leave  
  801d29:	c3                   	ret    

00801d2a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d2a:	55                   	push   %ebp
  801d2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	ff 75 08             	pushl  0x8(%ebp)
  801d38:	6a 2d                	push   $0x2d
  801d3a:	e8 eb f9 ff ff       	call   80172a <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d42:	90                   	nop
}
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
  801d48:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d49:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d4c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d52:	8b 45 08             	mov    0x8(%ebp),%eax
  801d55:	6a 00                	push   $0x0
  801d57:	53                   	push   %ebx
  801d58:	51                   	push   %ecx
  801d59:	52                   	push   %edx
  801d5a:	50                   	push   %eax
  801d5b:	6a 2e                	push   $0x2e
  801d5d:	e8 c8 f9 ff ff       	call   80172a <syscall>
  801d62:	83 c4 18             	add    $0x18,%esp
}
  801d65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d68:	c9                   	leave  
  801d69:	c3                   	ret    

00801d6a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d6a:	55                   	push   %ebp
  801d6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d70:	8b 45 08             	mov    0x8(%ebp),%eax
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	52                   	push   %edx
  801d7a:	50                   	push   %eax
  801d7b:	6a 2f                	push   $0x2f
  801d7d:	e8 a8 f9 ff ff       	call   80172a <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    
  801d87:	90                   	nop

00801d88 <__udivdi3>:
  801d88:	55                   	push   %ebp
  801d89:	57                   	push   %edi
  801d8a:	56                   	push   %esi
  801d8b:	53                   	push   %ebx
  801d8c:	83 ec 1c             	sub    $0x1c,%esp
  801d8f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d93:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d97:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d9b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d9f:	89 ca                	mov    %ecx,%edx
  801da1:	89 f8                	mov    %edi,%eax
  801da3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801da7:	85 f6                	test   %esi,%esi
  801da9:	75 2d                	jne    801dd8 <__udivdi3+0x50>
  801dab:	39 cf                	cmp    %ecx,%edi
  801dad:	77 65                	ja     801e14 <__udivdi3+0x8c>
  801daf:	89 fd                	mov    %edi,%ebp
  801db1:	85 ff                	test   %edi,%edi
  801db3:	75 0b                	jne    801dc0 <__udivdi3+0x38>
  801db5:	b8 01 00 00 00       	mov    $0x1,%eax
  801dba:	31 d2                	xor    %edx,%edx
  801dbc:	f7 f7                	div    %edi
  801dbe:	89 c5                	mov    %eax,%ebp
  801dc0:	31 d2                	xor    %edx,%edx
  801dc2:	89 c8                	mov    %ecx,%eax
  801dc4:	f7 f5                	div    %ebp
  801dc6:	89 c1                	mov    %eax,%ecx
  801dc8:	89 d8                	mov    %ebx,%eax
  801dca:	f7 f5                	div    %ebp
  801dcc:	89 cf                	mov    %ecx,%edi
  801dce:	89 fa                	mov    %edi,%edx
  801dd0:	83 c4 1c             	add    $0x1c,%esp
  801dd3:	5b                   	pop    %ebx
  801dd4:	5e                   	pop    %esi
  801dd5:	5f                   	pop    %edi
  801dd6:	5d                   	pop    %ebp
  801dd7:	c3                   	ret    
  801dd8:	39 ce                	cmp    %ecx,%esi
  801dda:	77 28                	ja     801e04 <__udivdi3+0x7c>
  801ddc:	0f bd fe             	bsr    %esi,%edi
  801ddf:	83 f7 1f             	xor    $0x1f,%edi
  801de2:	75 40                	jne    801e24 <__udivdi3+0x9c>
  801de4:	39 ce                	cmp    %ecx,%esi
  801de6:	72 0a                	jb     801df2 <__udivdi3+0x6a>
  801de8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801dec:	0f 87 9e 00 00 00    	ja     801e90 <__udivdi3+0x108>
  801df2:	b8 01 00 00 00       	mov    $0x1,%eax
  801df7:	89 fa                	mov    %edi,%edx
  801df9:	83 c4 1c             	add    $0x1c,%esp
  801dfc:	5b                   	pop    %ebx
  801dfd:	5e                   	pop    %esi
  801dfe:	5f                   	pop    %edi
  801dff:	5d                   	pop    %ebp
  801e00:	c3                   	ret    
  801e01:	8d 76 00             	lea    0x0(%esi),%esi
  801e04:	31 ff                	xor    %edi,%edi
  801e06:	31 c0                	xor    %eax,%eax
  801e08:	89 fa                	mov    %edi,%edx
  801e0a:	83 c4 1c             	add    $0x1c,%esp
  801e0d:	5b                   	pop    %ebx
  801e0e:	5e                   	pop    %esi
  801e0f:	5f                   	pop    %edi
  801e10:	5d                   	pop    %ebp
  801e11:	c3                   	ret    
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	89 d8                	mov    %ebx,%eax
  801e16:	f7 f7                	div    %edi
  801e18:	31 ff                	xor    %edi,%edi
  801e1a:	89 fa                	mov    %edi,%edx
  801e1c:	83 c4 1c             	add    $0x1c,%esp
  801e1f:	5b                   	pop    %ebx
  801e20:	5e                   	pop    %esi
  801e21:	5f                   	pop    %edi
  801e22:	5d                   	pop    %ebp
  801e23:	c3                   	ret    
  801e24:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e29:	89 eb                	mov    %ebp,%ebx
  801e2b:	29 fb                	sub    %edi,%ebx
  801e2d:	89 f9                	mov    %edi,%ecx
  801e2f:	d3 e6                	shl    %cl,%esi
  801e31:	89 c5                	mov    %eax,%ebp
  801e33:	88 d9                	mov    %bl,%cl
  801e35:	d3 ed                	shr    %cl,%ebp
  801e37:	89 e9                	mov    %ebp,%ecx
  801e39:	09 f1                	or     %esi,%ecx
  801e3b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e3f:	89 f9                	mov    %edi,%ecx
  801e41:	d3 e0                	shl    %cl,%eax
  801e43:	89 c5                	mov    %eax,%ebp
  801e45:	89 d6                	mov    %edx,%esi
  801e47:	88 d9                	mov    %bl,%cl
  801e49:	d3 ee                	shr    %cl,%esi
  801e4b:	89 f9                	mov    %edi,%ecx
  801e4d:	d3 e2                	shl    %cl,%edx
  801e4f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e53:	88 d9                	mov    %bl,%cl
  801e55:	d3 e8                	shr    %cl,%eax
  801e57:	09 c2                	or     %eax,%edx
  801e59:	89 d0                	mov    %edx,%eax
  801e5b:	89 f2                	mov    %esi,%edx
  801e5d:	f7 74 24 0c          	divl   0xc(%esp)
  801e61:	89 d6                	mov    %edx,%esi
  801e63:	89 c3                	mov    %eax,%ebx
  801e65:	f7 e5                	mul    %ebp
  801e67:	39 d6                	cmp    %edx,%esi
  801e69:	72 19                	jb     801e84 <__udivdi3+0xfc>
  801e6b:	74 0b                	je     801e78 <__udivdi3+0xf0>
  801e6d:	89 d8                	mov    %ebx,%eax
  801e6f:	31 ff                	xor    %edi,%edi
  801e71:	e9 58 ff ff ff       	jmp    801dce <__udivdi3+0x46>
  801e76:	66 90                	xchg   %ax,%ax
  801e78:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e7c:	89 f9                	mov    %edi,%ecx
  801e7e:	d3 e2                	shl    %cl,%edx
  801e80:	39 c2                	cmp    %eax,%edx
  801e82:	73 e9                	jae    801e6d <__udivdi3+0xe5>
  801e84:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e87:	31 ff                	xor    %edi,%edi
  801e89:	e9 40 ff ff ff       	jmp    801dce <__udivdi3+0x46>
  801e8e:	66 90                	xchg   %ax,%ax
  801e90:	31 c0                	xor    %eax,%eax
  801e92:	e9 37 ff ff ff       	jmp    801dce <__udivdi3+0x46>
  801e97:	90                   	nop

00801e98 <__umoddi3>:
  801e98:	55                   	push   %ebp
  801e99:	57                   	push   %edi
  801e9a:	56                   	push   %esi
  801e9b:	53                   	push   %ebx
  801e9c:	83 ec 1c             	sub    $0x1c,%esp
  801e9f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ea3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ea7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801eab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801eaf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801eb3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801eb7:	89 f3                	mov    %esi,%ebx
  801eb9:	89 fa                	mov    %edi,%edx
  801ebb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ebf:	89 34 24             	mov    %esi,(%esp)
  801ec2:	85 c0                	test   %eax,%eax
  801ec4:	75 1a                	jne    801ee0 <__umoddi3+0x48>
  801ec6:	39 f7                	cmp    %esi,%edi
  801ec8:	0f 86 a2 00 00 00    	jbe    801f70 <__umoddi3+0xd8>
  801ece:	89 c8                	mov    %ecx,%eax
  801ed0:	89 f2                	mov    %esi,%edx
  801ed2:	f7 f7                	div    %edi
  801ed4:	89 d0                	mov    %edx,%eax
  801ed6:	31 d2                	xor    %edx,%edx
  801ed8:	83 c4 1c             	add    $0x1c,%esp
  801edb:	5b                   	pop    %ebx
  801edc:	5e                   	pop    %esi
  801edd:	5f                   	pop    %edi
  801ede:	5d                   	pop    %ebp
  801edf:	c3                   	ret    
  801ee0:	39 f0                	cmp    %esi,%eax
  801ee2:	0f 87 ac 00 00 00    	ja     801f94 <__umoddi3+0xfc>
  801ee8:	0f bd e8             	bsr    %eax,%ebp
  801eeb:	83 f5 1f             	xor    $0x1f,%ebp
  801eee:	0f 84 ac 00 00 00    	je     801fa0 <__umoddi3+0x108>
  801ef4:	bf 20 00 00 00       	mov    $0x20,%edi
  801ef9:	29 ef                	sub    %ebp,%edi
  801efb:	89 fe                	mov    %edi,%esi
  801efd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f01:	89 e9                	mov    %ebp,%ecx
  801f03:	d3 e0                	shl    %cl,%eax
  801f05:	89 d7                	mov    %edx,%edi
  801f07:	89 f1                	mov    %esi,%ecx
  801f09:	d3 ef                	shr    %cl,%edi
  801f0b:	09 c7                	or     %eax,%edi
  801f0d:	89 e9                	mov    %ebp,%ecx
  801f0f:	d3 e2                	shl    %cl,%edx
  801f11:	89 14 24             	mov    %edx,(%esp)
  801f14:	89 d8                	mov    %ebx,%eax
  801f16:	d3 e0                	shl    %cl,%eax
  801f18:	89 c2                	mov    %eax,%edx
  801f1a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f1e:	d3 e0                	shl    %cl,%eax
  801f20:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f24:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f28:	89 f1                	mov    %esi,%ecx
  801f2a:	d3 e8                	shr    %cl,%eax
  801f2c:	09 d0                	or     %edx,%eax
  801f2e:	d3 eb                	shr    %cl,%ebx
  801f30:	89 da                	mov    %ebx,%edx
  801f32:	f7 f7                	div    %edi
  801f34:	89 d3                	mov    %edx,%ebx
  801f36:	f7 24 24             	mull   (%esp)
  801f39:	89 c6                	mov    %eax,%esi
  801f3b:	89 d1                	mov    %edx,%ecx
  801f3d:	39 d3                	cmp    %edx,%ebx
  801f3f:	0f 82 87 00 00 00    	jb     801fcc <__umoddi3+0x134>
  801f45:	0f 84 91 00 00 00    	je     801fdc <__umoddi3+0x144>
  801f4b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f4f:	29 f2                	sub    %esi,%edx
  801f51:	19 cb                	sbb    %ecx,%ebx
  801f53:	89 d8                	mov    %ebx,%eax
  801f55:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f59:	d3 e0                	shl    %cl,%eax
  801f5b:	89 e9                	mov    %ebp,%ecx
  801f5d:	d3 ea                	shr    %cl,%edx
  801f5f:	09 d0                	or     %edx,%eax
  801f61:	89 e9                	mov    %ebp,%ecx
  801f63:	d3 eb                	shr    %cl,%ebx
  801f65:	89 da                	mov    %ebx,%edx
  801f67:	83 c4 1c             	add    $0x1c,%esp
  801f6a:	5b                   	pop    %ebx
  801f6b:	5e                   	pop    %esi
  801f6c:	5f                   	pop    %edi
  801f6d:	5d                   	pop    %ebp
  801f6e:	c3                   	ret    
  801f6f:	90                   	nop
  801f70:	89 fd                	mov    %edi,%ebp
  801f72:	85 ff                	test   %edi,%edi
  801f74:	75 0b                	jne    801f81 <__umoddi3+0xe9>
  801f76:	b8 01 00 00 00       	mov    $0x1,%eax
  801f7b:	31 d2                	xor    %edx,%edx
  801f7d:	f7 f7                	div    %edi
  801f7f:	89 c5                	mov    %eax,%ebp
  801f81:	89 f0                	mov    %esi,%eax
  801f83:	31 d2                	xor    %edx,%edx
  801f85:	f7 f5                	div    %ebp
  801f87:	89 c8                	mov    %ecx,%eax
  801f89:	f7 f5                	div    %ebp
  801f8b:	89 d0                	mov    %edx,%eax
  801f8d:	e9 44 ff ff ff       	jmp    801ed6 <__umoddi3+0x3e>
  801f92:	66 90                	xchg   %ax,%ax
  801f94:	89 c8                	mov    %ecx,%eax
  801f96:	89 f2                	mov    %esi,%edx
  801f98:	83 c4 1c             	add    $0x1c,%esp
  801f9b:	5b                   	pop    %ebx
  801f9c:	5e                   	pop    %esi
  801f9d:	5f                   	pop    %edi
  801f9e:	5d                   	pop    %ebp
  801f9f:	c3                   	ret    
  801fa0:	3b 04 24             	cmp    (%esp),%eax
  801fa3:	72 06                	jb     801fab <__umoddi3+0x113>
  801fa5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fa9:	77 0f                	ja     801fba <__umoddi3+0x122>
  801fab:	89 f2                	mov    %esi,%edx
  801fad:	29 f9                	sub    %edi,%ecx
  801faf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fb3:	89 14 24             	mov    %edx,(%esp)
  801fb6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fba:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fbe:	8b 14 24             	mov    (%esp),%edx
  801fc1:	83 c4 1c             	add    $0x1c,%esp
  801fc4:	5b                   	pop    %ebx
  801fc5:	5e                   	pop    %esi
  801fc6:	5f                   	pop    %edi
  801fc7:	5d                   	pop    %ebp
  801fc8:	c3                   	ret    
  801fc9:	8d 76 00             	lea    0x0(%esi),%esi
  801fcc:	2b 04 24             	sub    (%esp),%eax
  801fcf:	19 fa                	sbb    %edi,%edx
  801fd1:	89 d1                	mov    %edx,%ecx
  801fd3:	89 c6                	mov    %eax,%esi
  801fd5:	e9 71 ff ff ff       	jmp    801f4b <__umoddi3+0xb3>
  801fda:	66 90                	xchg   %ax,%ax
  801fdc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fe0:	72 ea                	jb     801fcc <__umoddi3+0x134>
  801fe2:	89 d9                	mov    %ebx,%ecx
  801fe4:	e9 62 ff ff ff       	jmp    801f4b <__umoddi3+0xb3>
