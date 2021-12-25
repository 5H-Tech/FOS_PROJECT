
obj/user/tst_freeHeap_2:     file format elf32-i386


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
  800031:	e8 a4 05 00 00       	call   8005da <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

char z[5*1024*1024] ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec cc 00 00 00    	sub    $0xcc,%esp
	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  		panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  80004f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800052:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800055:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  80005a:	85 c0                	test   %eax,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 40 24 80 00       	push   $0x802440
  800066:	6a 13                	push   $0x13
  800068:	68 89 24 80 00       	push   $0x802489
  80006d:	e8 ad 06 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  80007d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800080:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800083:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800088:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008d:	74 14                	je     8000a3 <_main+0x6b>
  80008f:	83 ec 04             	sub    $0x4,%esp
  800092:	68 40 24 80 00       	push   $0x802440
  800097:	6a 14                	push   $0x14
  800099:	68 89 24 80 00       	push   $0x802489
  80009e:	e8 7c 06 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a8:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  8000ae:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b4:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b9:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000be:	74 14                	je     8000d4 <_main+0x9c>
  8000c0:	83 ec 04             	sub    $0x4,%esp
  8000c3:	68 40 24 80 00       	push   $0x802440
  8000c8:	6a 15                	push   $0x15
  8000ca:	68 89 24 80 00       	push   $0x802489
  8000cf:	e8 4b 06 00 00       	call   80071f <_panic>
		if( myEnv->__ptr_tws[3].empty !=  1)  											panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d9:	8a 80 2c 39 01 00    	mov    0x1392c(%eax),%al
  8000df:	3c 01                	cmp    $0x1,%al
  8000e1:	74 14                	je     8000f7 <_main+0xbf>
  8000e3:	83 ec 04             	sub    $0x4,%esp
  8000e6:	68 40 24 80 00       	push   $0x802440
  8000eb:	6a 16                	push   $0x16
  8000ed:	68 89 24 80 00       	push   $0x802489
  8000f2:	e8 28 06 00 00       	call   80071f <_panic>

		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800102:	8b 00                	mov    (%eax),%eax
  800104:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800107:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80010a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80010f:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800114:	74 14                	je     80012a <_main+0xf2>
  800116:	83 ec 04             	sub    $0x4,%esp
  800119:	68 a0 24 80 00       	push   $0x8024a0
  80011e:	6a 18                	push   $0x18
  800120:	68 89 24 80 00       	push   $0x802489
  800125:	e8 f5 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80012a:	a1 20 30 80 00       	mov    0x803020,%eax
  80012f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800135:	83 c0 10             	add    $0x10,%eax
  800138:	8b 00                	mov    (%eax),%eax
  80013a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80013d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800140:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800145:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80014a:	74 14                	je     800160 <_main+0x128>
  80014c:	83 ec 04             	sub    $0x4,%esp
  80014f:	68 a0 24 80 00       	push   $0x8024a0
  800154:	6a 19                	push   $0x19
  800156:	68 89 24 80 00       	push   $0x802489
  80015b:	e8 bf 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800160:	a1 20 30 80 00       	mov    0x803020,%eax
  800165:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80016b:	83 c0 20             	add    $0x20,%eax
  80016e:	8b 00                	mov    (%eax),%eax
  800170:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800173:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800176:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80017b:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800180:	74 14                	je     800196 <_main+0x15e>
  800182:	83 ec 04             	sub    $0x4,%esp
  800185:	68 a0 24 80 00       	push   $0x8024a0
  80018a:	6a 1a                	push   $0x1a
  80018c:	68 89 24 80 00       	push   $0x802489
  800191:	e8 89 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800196:	a1 20 30 80 00       	mov    0x803020,%eax
  80019b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001a1:	83 c0 30             	add    $0x30,%eax
  8001a4:	8b 00                	mov    (%eax),%eax
  8001a6:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001a9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001ac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001b1:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8001b6:	74 14                	je     8001cc <_main+0x194>
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	68 a0 24 80 00       	push   $0x8024a0
  8001c0:	6a 1b                	push   $0x1b
  8001c2:	68 89 24 80 00       	push   $0x802489
  8001c7:	e8 53 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001d7:	83 c0 40             	add    $0x40,%eax
  8001da:	8b 00                	mov    (%eax),%eax
  8001dc:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001df:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001e7:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8001ec:	74 14                	je     800202 <_main+0x1ca>
  8001ee:	83 ec 04             	sub    $0x4,%esp
  8001f1:	68 a0 24 80 00       	push   $0x8024a0
  8001f6:	6a 1c                	push   $0x1c
  8001f8:	68 89 24 80 00       	push   $0x802489
  8001fd:	e8 1d 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800202:	a1 20 30 80 00       	mov    0x803020,%eax
  800207:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80020d:	83 c0 50             	add    $0x50,%eax
  800210:	8b 00                	mov    (%eax),%eax
  800212:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800215:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800218:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80021d:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800222:	74 14                	je     800238 <_main+0x200>
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	68 a0 24 80 00       	push   $0x8024a0
  80022c:	6a 1d                	push   $0x1d
  80022e:	68 89 24 80 00       	push   $0x802489
  800233:	e8 e7 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800238:	a1 20 30 80 00       	mov    0x803020,%eax
  80023d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800243:	83 c0 60             	add    $0x60,%eax
  800246:	8b 00                	mov    (%eax),%eax
  800248:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80024b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80024e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800253:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800258:	74 14                	je     80026e <_main+0x236>
  80025a:	83 ec 04             	sub    $0x4,%esp
  80025d:	68 a0 24 80 00       	push   $0x8024a0
  800262:	6a 1e                	push   $0x1e
  800264:	68 89 24 80 00       	push   $0x802489
  800269:	e8 b1 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80026e:	a1 20 30 80 00       	mov    0x803020,%eax
  800273:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800279:	83 c0 70             	add    $0x70,%eax
  80027c:	8b 00                	mov    (%eax),%eax
  80027e:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800281:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800284:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800289:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80028e:	74 14                	je     8002a4 <_main+0x26c>
  800290:	83 ec 04             	sub    $0x4,%esp
  800293:	68 a0 24 80 00       	push   $0x8024a0
  800298:	6a 1f                	push   $0x1f
  80029a:	68 89 24 80 00       	push   $0x802489
  80029f:	e8 7b 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002af:	83 e8 80             	sub    $0xffffff80,%eax
  8002b2:	8b 00                	mov    (%eax),%eax
  8002b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8002b7:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8002ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002bf:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8002c4:	74 14                	je     8002da <_main+0x2a2>
  8002c6:	83 ec 04             	sub    $0x4,%esp
  8002c9:	68 a0 24 80 00       	push   $0x8024a0
  8002ce:	6a 20                	push   $0x20
  8002d0:	68 89 24 80 00       	push   $0x802489
  8002d5:	e8 45 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002da:	a1 20 30 80 00       	mov    0x803020,%eax
  8002df:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002e5:	05 90 00 00 00       	add    $0x90,%eax
  8002ea:	8b 00                	mov    (%eax),%eax
  8002ec:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8002ef:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8002f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002f7:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002fc:	74 14                	je     800312 <_main+0x2da>
  8002fe:	83 ec 04             	sub    $0x4,%esp
  800301:	68 a0 24 80 00       	push   $0x8024a0
  800306:	6a 21                	push   $0x21
  800308:	68 89 24 80 00       	push   $0x802489
  80030d:	e8 0d 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800312:	a1 20 30 80 00       	mov    0x803020,%eax
  800317:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80031d:	05 a0 00 00 00       	add    $0xa0,%eax
  800322:	8b 00                	mov    (%eax),%eax
  800324:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800327:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80032a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80032f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800334:	74 14                	je     80034a <_main+0x312>
  800336:	83 ec 04             	sub    $0x4,%esp
  800339:	68 a0 24 80 00       	push   $0x8024a0
  80033e:	6a 22                	push   $0x22
  800340:	68 89 24 80 00       	push   $0x802489
  800345:	e8 d5 03 00 00       	call   80071f <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  80034a:	a1 20 30 80 00       	mov    0x803020,%eax
  80034f:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  800355:	85 c0                	test   %eax,%eax
  800357:	74 14                	je     80036d <_main+0x335>
  800359:	83 ec 04             	sub    $0x4,%esp
  80035c:	68 e8 24 80 00       	push   $0x8024e8
  800361:	6a 23                	push   $0x23
  800363:	68 89 24 80 00       	push   $0x802489
  800368:	e8 b2 03 00 00       	call   80071f <_panic>
	}


	int kilo = 1024;
  80036d:	c7 45 9c 00 04 00 00 	movl   $0x400,-0x64(%ebp)
	int Mega = 1024*1024;
  800374:	c7 45 98 00 00 10 00 	movl   $0x100000,-0x68(%ebp)

	/// testing freeHeap()
	{

		uint32 size = 13*Mega;
  80037b:	8b 55 98             	mov    -0x68(%ebp),%edx
  80037e:	89 d0                	mov    %edx,%eax
  800380:	01 c0                	add    %eax,%eax
  800382:	01 d0                	add    %edx,%eax
  800384:	c1 e0 02             	shl    $0x2,%eax
  800387:	01 d0                	add    %edx,%eax
  800389:	89 45 94             	mov    %eax,-0x6c(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	ff 75 94             	pushl  -0x6c(%ebp)
  800392:	e8 b4 13 00 00       	call   80174b <malloc>
  800397:	83 c4 10             	add    $0x10,%esp
  80039a:	89 45 90             	mov    %eax,-0x70(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  80039d:	83 ec 0c             	sub    $0xc,%esp
  8003a0:	ff 75 94             	pushl  -0x6c(%ebp)
  8003a3:	e8 a3 13 00 00       	call   80174b <malloc>
  8003a8:	83 c4 10             	add    $0x10,%esp
  8003ab:	89 45 8c             	mov    %eax,-0x74(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003ae:	e8 b9 19 00 00       	call   801d6c <sys_pf_calculate_allocated_pages>
  8003b3:	89 45 88             	mov    %eax,-0x78(%ebp)

		x[1]=-1;
  8003b6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003b9:	40                   	inc    %eax
  8003ba:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  8003bd:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003c0:	89 d0                	mov    %edx,%eax
  8003c2:	c1 e0 02             	shl    $0x2,%eax
  8003c5:	01 d0                	add    %edx,%eax
  8003c7:	89 c2                	mov    %eax,%edx
  8003c9:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003cc:	01 d0                	add    %edx,%eax
  8003ce:	c6 00 ff             	movb   $0xff,(%eax)

		z[4*Mega] = 'M' ;
  8003d1:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003d4:	c1 e0 02             	shl    $0x2,%eax
  8003d7:	c6 80 20 31 80 00 4d 	movb   $0x4d,0x803120(%eax)

		x[8*Mega] = -1;
  8003de:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003e1:	c1 e0 03             	shl    $0x3,%eax
  8003e4:	89 c2                	mov    %eax,%edx
  8003e6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8003ee:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003f1:	89 d0                	mov    %edx,%eax
  8003f3:	01 c0                	add    %eax,%eax
  8003f5:	01 d0                	add    %edx,%eax
  8003f7:	c1 e0 02             	shl    $0x2,%eax
  8003fa:	89 c2                	mov    %eax,%edx
  8003fc:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003ff:	01 d0                	add    %edx,%eax
  800401:	c6 00 ff             	movb   $0xff,(%eax)


		free(x);
  800404:	83 ec 0c             	sub    $0xc,%esp
  800407:	ff 75 90             	pushl  -0x70(%ebp)
  80040a:	e8 04 16 00 00       	call   801a13 <free>
  80040f:	83 c4 10             	add    $0x10,%esp
		free(y);
  800412:	83 ec 0c             	sub    $0xc,%esp
  800415:	ff 75 8c             	pushl  -0x74(%ebp)
  800418:	e8 f6 15 00 00       	call   801a13 <free>
  80041d:	83 c4 10             	add    $0x10,%esp

		int freePages = sys_calculate_free_frames();
  800420:	e8 c4 18 00 00       	call   801ce9 <sys_calculate_free_frames>
  800425:	89 45 84             	mov    %eax,-0x7c(%ebp)

		x = malloc(sizeof(char)*size) ;
  800428:	83 ec 0c             	sub    $0xc,%esp
  80042b:	ff 75 94             	pushl  -0x6c(%ebp)
  80042e:	e8 18 13 00 00       	call   80174b <malloc>
  800433:	83 c4 10             	add    $0x10,%esp
  800436:	89 45 90             	mov    %eax,-0x70(%ebp)

		x[1]=-2;
  800439:	8b 45 90             	mov    -0x70(%ebp),%eax
  80043c:	40                   	inc    %eax
  80043d:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800440:	8b 55 98             	mov    -0x68(%ebp),%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	c1 e0 02             	shl    $0x2,%eax
  800448:	01 d0                	add    %edx,%eax
  80044a:	89 c2                	mov    %eax,%edx
  80044c:	8b 45 90             	mov    -0x70(%ebp),%eax
  80044f:	01 d0                	add    %edx,%eax
  800451:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  800454:	8b 45 98             	mov    -0x68(%ebp),%eax
  800457:	c1 e0 03             	shl    $0x3,%eax
  80045a:	89 c2                	mov    %eax,%edx
  80045c:	8b 45 90             	mov    -0x70(%ebp),%eax
  80045f:	01 d0                	add    %edx,%eax
  800461:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  800464:	8b 55 98             	mov    -0x68(%ebp),%edx
  800467:	89 d0                	mov    %edx,%eax
  800469:	01 c0                	add    %eax,%eax
  80046b:	01 d0                	add    %edx,%eax
  80046d:	c1 e0 02             	shl    $0x2,%eax
  800470:	89 c2                	mov    %eax,%edx
  800472:	8b 45 90             	mov    -0x70(%ebp),%eax
  800475:	01 d0                	add    %edx,%eax
  800477:	c6 00 fe             	movb   $0xfe,(%eax)


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};
  80047a:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
  800480:	bb a0 26 80 00       	mov    $0x8026a0,%ebx
  800485:	ba 0b 00 00 00       	mov    $0xb,%edx
  80048a:	89 c7                	mov    %eax,%edi
  80048c:	89 de                	mov    %ebx,%esi
  80048e:	89 d1                	mov    %edx,%ecx
  800490:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800492:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  800499:	eb 76                	jmp    800511 <_main+0x4d9>
		{
			int found = 0 ;
  80049b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8004a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004a9:	eb 3a                	jmp    8004e5 <_main+0x4ad>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  8004ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004ae:	8b 94 85 50 ff ff ff 	mov    -0xb0(%ebp,%eax,4),%edx
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004c0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8004c3:	c1 e1 04             	shl    $0x4,%ecx
  8004c6:	01 c8                	add    %ecx,%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	89 45 80             	mov    %eax,-0x80(%ebp)
  8004cd:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d5:	39 c2                	cmp    %eax,%edx
  8004d7:	75 09                	jne    8004e2 <_main+0x4aa>
				{
					found = 1 ;
  8004d9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8004e0:	eb 12                	jmp    8004f4 <_main+0x4bc>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8004e2:	ff 45 e0             	incl   -0x20(%ebp)
  8004e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ea:	8b 50 74             	mov    0x74(%eax),%edx
  8004ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004f0:	39 c2                	cmp    %eax,%edx
  8004f2:	77 b7                	ja     8004ab <_main+0x473>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8004f4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8004f8:	75 14                	jne    80050e <_main+0x4d6>
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8004fa:	83 ec 04             	sub    $0x4,%esp
  8004fd:	68 38 25 80 00       	push   $0x802538
  800502:	6a 5f                	push   $0x5f
  800504:	68 89 24 80 00       	push   $0x802489
  800509:	e8 11 02 00 00       	call   80071f <_panic>


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  80050e:	ff 45 e4             	incl   -0x1c(%ebp)
  800511:	a1 20 30 80 00       	mov    0x803020,%eax
  800516:	8b 50 74             	mov    0x74(%eax),%edx
  800519:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80051c:	39 c2                	cmp    %eax,%edx
  80051e:	0f 87 77 ff ff ff    	ja     80049b <_main+0x463>
			}
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};
  800524:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
  80052a:	bb e0 26 80 00       	mov    $0x8026e0,%ebx
  80052f:	ba 08 00 00 00       	mov    $0x8,%edx
  800534:	89 c7                	mov    %eax,%edi
  800536:	89 de                	mov    %ebx,%esi
  800538:	89 d1                	mov    %edx,%ecx
  80053a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)


		for (i=0; i < __TWS_MAX_SIZE; i++)
  80053c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800543:	eb 76                	jmp    8005bb <_main+0x583>
		{
			int found = 0 ;
  800545:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for (j=0; j < __TWS_MAX_SIZE; j++)
  80054c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800553:	eb 43                	jmp    800598 <_main+0x560>
			{
				if (tableWSEntries[i] == ROUNDDOWN(myEnv->__ptr_tws[j].virtual_address,1024*PAGE_SIZE) )
  800555:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800558:	8b 94 85 30 ff ff ff 	mov    -0xd0(%ebp,%eax,4),%edx
  80055f:	a1 20 30 80 00       	mov    0x803020,%eax
  800564:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  800567:	81 c1 8f 13 00 00    	add    $0x138f,%ecx
  80056d:	c1 e1 04             	shl    $0x4,%ecx
  800570:	01 c8                	add    %ecx,%eax
  800572:	83 c0 08             	add    $0x8,%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80057d:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800583:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800588:	39 c2                	cmp    %eax,%edx
  80058a:	75 09                	jne    800595 <_main+0x55d>
				{
					found = 1 ;
  80058c:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
					break;
  800593:	eb 09                	jmp    80059e <_main+0x566>


		for (i=0; i < __TWS_MAX_SIZE; i++)
		{
			int found = 0 ;
			for (j=0; j < __TWS_MAX_SIZE; j++)
  800595:	ff 45 e0             	incl   -0x20(%ebp)
  800598:	83 7d e0 31          	cmpl   $0x31,-0x20(%ebp)
  80059c:	7e b7                	jle    800555 <_main+0x51d>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  80059e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8005a2:	75 14                	jne    8005b8 <_main+0x580>
				panic("TABLE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8005a4:	83 ec 04             	sub    $0x4,%esp
  8005a7:	68 bc 25 80 00       	push   $0x8025bc
  8005ac:	6a 71                	push   $0x71
  8005ae:	68 89 24 80 00       	push   $0x802489
  8005b3:	e8 67 01 00 00       	call   80071f <_panic>
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};


		for (i=0; i < __TWS_MAX_SIZE; i++)
  8005b8:	ff 45 e4             	incl   -0x1c(%ebp)
  8005bb:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
  8005bf:	7e 84                	jle    800545 <_main+0x50d>


		//if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
	}

	cprintf("Congratulations!! test freeHeap 2 [WITH REPLACEMENT] completed successfully.\n");
  8005c1:	83 ec 0c             	sub    $0xc,%esp
  8005c4:	68 40 26 80 00       	push   $0x802640
  8005c9:	e8 f3 03 00 00       	call   8009c1 <cprintf>
  8005ce:	83 c4 10             	add    $0x10,%esp


	return;
  8005d1:	90                   	nop
}
  8005d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005d5:	5b                   	pop    %ebx
  8005d6:	5e                   	pop    %esi
  8005d7:	5f                   	pop    %edi
  8005d8:	5d                   	pop    %ebp
  8005d9:	c3                   	ret    

008005da <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005da:	55                   	push   %ebp
  8005db:	89 e5                	mov    %esp,%ebp
  8005dd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e0:	e8 39 16 00 00       	call   801c1e <sys_getenvindex>
  8005e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005eb:	89 d0                	mov    %edx,%eax
  8005ed:	c1 e0 03             	shl    $0x3,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005f9:	01 c8                	add    %ecx,%eax
  8005fb:	01 c0                	add    %eax,%eax
  8005fd:	01 d0                	add    %edx,%eax
  8005ff:	01 c0                	add    %eax,%eax
  800601:	01 d0                	add    %edx,%eax
  800603:	89 c2                	mov    %eax,%edx
  800605:	c1 e2 05             	shl    $0x5,%edx
  800608:	29 c2                	sub    %eax,%edx
  80060a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800611:	89 c2                	mov    %eax,%edx
  800613:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800619:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80061e:	a1 20 30 80 00       	mov    0x803020,%eax
  800623:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800629:	84 c0                	test   %al,%al
  80062b:	74 0f                	je     80063c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80062d:	a1 20 30 80 00       	mov    0x803020,%eax
  800632:	05 40 3c 01 00       	add    $0x13c40,%eax
  800637:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80063c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800640:	7e 0a                	jle    80064c <libmain+0x72>
		binaryname = argv[0];
  800642:	8b 45 0c             	mov    0xc(%ebp),%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80064c:	83 ec 08             	sub    $0x8,%esp
  80064f:	ff 75 0c             	pushl  0xc(%ebp)
  800652:	ff 75 08             	pushl  0x8(%ebp)
  800655:	e8 de f9 ff ff       	call   800038 <_main>
  80065a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80065d:	e8 57 17 00 00       	call   801db9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800662:	83 ec 0c             	sub    $0xc,%esp
  800665:	68 18 27 80 00       	push   $0x802718
  80066a:	e8 52 03 00 00       	call   8009c1 <cprintf>
  80066f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800672:	a1 20 30 80 00       	mov    0x803020,%eax
  800677:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80067d:	a1 20 30 80 00       	mov    0x803020,%eax
  800682:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800688:	83 ec 04             	sub    $0x4,%esp
  80068b:	52                   	push   %edx
  80068c:	50                   	push   %eax
  80068d:	68 40 27 80 00       	push   $0x802740
  800692:	e8 2a 03 00 00       	call   8009c1 <cprintf>
  800697:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80069a:	a1 20 30 80 00       	mov    0x803020,%eax
  80069f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006aa:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006b0:	83 ec 04             	sub    $0x4,%esp
  8006b3:	52                   	push   %edx
  8006b4:	50                   	push   %eax
  8006b5:	68 68 27 80 00       	push   $0x802768
  8006ba:	e8 02 03 00 00       	call   8009c1 <cprintf>
  8006bf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	50                   	push   %eax
  8006d1:	68 a9 27 80 00       	push   $0x8027a9
  8006d6:	e8 e6 02 00 00       	call   8009c1 <cprintf>
  8006db:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006de:	83 ec 0c             	sub    $0xc,%esp
  8006e1:	68 18 27 80 00       	push   $0x802718
  8006e6:	e8 d6 02 00 00       	call   8009c1 <cprintf>
  8006eb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ee:	e8 e0 16 00 00       	call   801dd3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006f3:	e8 19 00 00 00       	call   800711 <exit>
}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800701:	83 ec 0c             	sub    $0xc,%esp
  800704:	6a 00                	push   $0x0
  800706:	e8 df 14 00 00       	call   801bea <sys_env_destroy>
  80070b:	83 c4 10             	add    $0x10,%esp
}
  80070e:	90                   	nop
  80070f:	c9                   	leave  
  800710:	c3                   	ret    

00800711 <exit>:

void
exit(void)
{
  800711:	55                   	push   %ebp
  800712:	89 e5                	mov    %esp,%ebp
  800714:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800717:	e8 34 15 00 00       	call   801c50 <sys_env_exit>
}
  80071c:	90                   	nop
  80071d:	c9                   	leave  
  80071e:	c3                   	ret    

0080071f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80071f:	55                   	push   %ebp
  800720:	89 e5                	mov    %esp,%ebp
  800722:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800725:	8d 45 10             	lea    0x10(%ebp),%eax
  800728:	83 c0 04             	add    $0x4,%eax
  80072b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80072e:	a1 34 31 d0 00       	mov    0xd03134,%eax
  800733:	85 c0                	test   %eax,%eax
  800735:	74 16                	je     80074d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800737:	a1 34 31 d0 00       	mov    0xd03134,%eax
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	50                   	push   %eax
  800740:	68 c0 27 80 00       	push   $0x8027c0
  800745:	e8 77 02 00 00       	call   8009c1 <cprintf>
  80074a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80074d:	a1 00 30 80 00       	mov    0x803000,%eax
  800752:	ff 75 0c             	pushl  0xc(%ebp)
  800755:	ff 75 08             	pushl  0x8(%ebp)
  800758:	50                   	push   %eax
  800759:	68 c5 27 80 00       	push   $0x8027c5
  80075e:	e8 5e 02 00 00       	call   8009c1 <cprintf>
  800763:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800766:	8b 45 10             	mov    0x10(%ebp),%eax
  800769:	83 ec 08             	sub    $0x8,%esp
  80076c:	ff 75 f4             	pushl  -0xc(%ebp)
  80076f:	50                   	push   %eax
  800770:	e8 e1 01 00 00       	call   800956 <vcprintf>
  800775:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800778:	83 ec 08             	sub    $0x8,%esp
  80077b:	6a 00                	push   $0x0
  80077d:	68 e1 27 80 00       	push   $0x8027e1
  800782:	e8 cf 01 00 00       	call   800956 <vcprintf>
  800787:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80078a:	e8 82 ff ff ff       	call   800711 <exit>

	// should not return here
	while (1) ;
  80078f:	eb fe                	jmp    80078f <_panic+0x70>

00800791 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
  800794:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800797:	a1 20 30 80 00       	mov    0x803020,%eax
  80079c:	8b 50 74             	mov    0x74(%eax),%edx
  80079f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a2:	39 c2                	cmp    %eax,%edx
  8007a4:	74 14                	je     8007ba <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007a6:	83 ec 04             	sub    $0x4,%esp
  8007a9:	68 e4 27 80 00       	push   $0x8027e4
  8007ae:	6a 26                	push   $0x26
  8007b0:	68 30 28 80 00       	push   $0x802830
  8007b5:	e8 65 ff ff ff       	call   80071f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007c8:	e9 b6 00 00 00       	jmp    800883 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	8b 00                	mov    (%eax),%eax
  8007de:	85 c0                	test   %eax,%eax
  8007e0:	75 08                	jne    8007ea <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007e2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007e5:	e9 96 00 00 00       	jmp    800880 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007f8:	eb 5d                	jmp    800857 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ff:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800805:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800808:	c1 e2 04             	shl    $0x4,%edx
  80080b:	01 d0                	add    %edx,%eax
  80080d:	8a 40 04             	mov    0x4(%eax),%al
  800810:	84 c0                	test   %al,%al
  800812:	75 40                	jne    800854 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800814:	a1 20 30 80 00       	mov    0x803020,%eax
  800819:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80081f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800822:	c1 e2 04             	shl    $0x4,%edx
  800825:	01 d0                	add    %edx,%eax
  800827:	8b 00                	mov    (%eax),%eax
  800829:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80082c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80082f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800834:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800836:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800839:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800840:	8b 45 08             	mov    0x8(%ebp),%eax
  800843:	01 c8                	add    %ecx,%eax
  800845:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800847:	39 c2                	cmp    %eax,%edx
  800849:	75 09                	jne    800854 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80084b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800852:	eb 12                	jmp    800866 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800854:	ff 45 e8             	incl   -0x18(%ebp)
  800857:	a1 20 30 80 00       	mov    0x803020,%eax
  80085c:	8b 50 74             	mov    0x74(%eax),%edx
  80085f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800862:	39 c2                	cmp    %eax,%edx
  800864:	77 94                	ja     8007fa <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800866:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80086a:	75 14                	jne    800880 <CheckWSWithoutLastIndex+0xef>
			panic(
  80086c:	83 ec 04             	sub    $0x4,%esp
  80086f:	68 3c 28 80 00       	push   $0x80283c
  800874:	6a 3a                	push   $0x3a
  800876:	68 30 28 80 00       	push   $0x802830
  80087b:	e8 9f fe ff ff       	call   80071f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800880:	ff 45 f0             	incl   -0x10(%ebp)
  800883:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800886:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800889:	0f 8c 3e ff ff ff    	jl     8007cd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80088f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800896:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80089d:	eb 20                	jmp    8008bf <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80089f:	a1 20 30 80 00       	mov    0x803020,%eax
  8008a4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ad:	c1 e2 04             	shl    $0x4,%edx
  8008b0:	01 d0                	add    %edx,%eax
  8008b2:	8a 40 04             	mov    0x4(%eax),%al
  8008b5:	3c 01                	cmp    $0x1,%al
  8008b7:	75 03                	jne    8008bc <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008b9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008bc:	ff 45 e0             	incl   -0x20(%ebp)
  8008bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8008c4:	8b 50 74             	mov    0x74(%eax),%edx
  8008c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ca:	39 c2                	cmp    %eax,%edx
  8008cc:	77 d1                	ja     80089f <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008d4:	74 14                	je     8008ea <CheckWSWithoutLastIndex+0x159>
		panic(
  8008d6:	83 ec 04             	sub    $0x4,%esp
  8008d9:	68 90 28 80 00       	push   $0x802890
  8008de:	6a 44                	push   $0x44
  8008e0:	68 30 28 80 00       	push   $0x802830
  8008e5:	e8 35 fe ff ff       	call   80071f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008ea:	90                   	nop
  8008eb:	c9                   	leave  
  8008ec:	c3                   	ret    

008008ed <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008ed:	55                   	push   %ebp
  8008ee:	89 e5                	mov    %esp,%ebp
  8008f0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f6:	8b 00                	mov    (%eax),%eax
  8008f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8008fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fe:	89 0a                	mov    %ecx,(%edx)
  800900:	8b 55 08             	mov    0x8(%ebp),%edx
  800903:	88 d1                	mov    %dl,%cl
  800905:	8b 55 0c             	mov    0xc(%ebp),%edx
  800908:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80090c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	3d ff 00 00 00       	cmp    $0xff,%eax
  800916:	75 2c                	jne    800944 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800918:	a0 24 30 80 00       	mov    0x803024,%al
  80091d:	0f b6 c0             	movzbl %al,%eax
  800920:	8b 55 0c             	mov    0xc(%ebp),%edx
  800923:	8b 12                	mov    (%edx),%edx
  800925:	89 d1                	mov    %edx,%ecx
  800927:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092a:	83 c2 08             	add    $0x8,%edx
  80092d:	83 ec 04             	sub    $0x4,%esp
  800930:	50                   	push   %eax
  800931:	51                   	push   %ecx
  800932:	52                   	push   %edx
  800933:	e8 70 12 00 00       	call   801ba8 <sys_cputs>
  800938:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80093b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800944:	8b 45 0c             	mov    0xc(%ebp),%eax
  800947:	8b 40 04             	mov    0x4(%eax),%eax
  80094a:	8d 50 01             	lea    0x1(%eax),%edx
  80094d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800950:	89 50 04             	mov    %edx,0x4(%eax)
}
  800953:	90                   	nop
  800954:	c9                   	leave  
  800955:	c3                   	ret    

00800956 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80095f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800966:	00 00 00 
	b.cnt = 0;
  800969:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800970:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800973:	ff 75 0c             	pushl  0xc(%ebp)
  800976:	ff 75 08             	pushl  0x8(%ebp)
  800979:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097f:	50                   	push   %eax
  800980:	68 ed 08 80 00       	push   $0x8008ed
  800985:	e8 11 02 00 00       	call   800b9b <vprintfmt>
  80098a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80098d:	a0 24 30 80 00       	mov    0x803024,%al
  800992:	0f b6 c0             	movzbl %al,%eax
  800995:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80099b:	83 ec 04             	sub    $0x4,%esp
  80099e:	50                   	push   %eax
  80099f:	52                   	push   %edx
  8009a0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a6:	83 c0 08             	add    $0x8,%eax
  8009a9:	50                   	push   %eax
  8009aa:	e8 f9 11 00 00       	call   801ba8 <sys_cputs>
  8009af:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009b2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009b9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009bf:	c9                   	leave  
  8009c0:	c3                   	ret    

008009c1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009ce:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 f4             	pushl  -0xc(%ebp)
  8009dd:	50                   	push   %eax
  8009de:	e8 73 ff ff ff       	call   800956 <vcprintf>
  8009e3:	83 c4 10             	add    $0x10,%esp
  8009e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ec:	c9                   	leave  
  8009ed:	c3                   	ret    

008009ee <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ee:	55                   	push   %ebp
  8009ef:	89 e5                	mov    %esp,%ebp
  8009f1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009f4:	e8 c0 13 00 00       	call   801db9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	83 ec 08             	sub    $0x8,%esp
  800a05:	ff 75 f4             	pushl  -0xc(%ebp)
  800a08:	50                   	push   %eax
  800a09:	e8 48 ff ff ff       	call   800956 <vcprintf>
  800a0e:	83 c4 10             	add    $0x10,%esp
  800a11:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a14:	e8 ba 13 00 00       	call   801dd3 <sys_enable_interrupt>
	return cnt;
  800a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a1c:	c9                   	leave  
  800a1d:	c3                   	ret    

00800a1e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a1e:	55                   	push   %ebp
  800a1f:	89 e5                	mov    %esp,%ebp
  800a21:	53                   	push   %ebx
  800a22:	83 ec 14             	sub    $0x14,%esp
  800a25:	8b 45 10             	mov    0x10(%ebp),%eax
  800a28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a31:	8b 45 18             	mov    0x18(%ebp),%eax
  800a34:	ba 00 00 00 00       	mov    $0x0,%edx
  800a39:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3c:	77 55                	ja     800a93 <printnum+0x75>
  800a3e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a41:	72 05                	jb     800a48 <printnum+0x2a>
  800a43:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a46:	77 4b                	ja     800a93 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a48:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a4b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a4e:	8b 45 18             	mov    0x18(%ebp),%eax
  800a51:	ba 00 00 00 00       	mov    $0x0,%edx
  800a56:	52                   	push   %edx
  800a57:	50                   	push   %eax
  800a58:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5b:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5e:	e8 79 17 00 00       	call   8021dc <__udivdi3>
  800a63:	83 c4 10             	add    $0x10,%esp
  800a66:	83 ec 04             	sub    $0x4,%esp
  800a69:	ff 75 20             	pushl  0x20(%ebp)
  800a6c:	53                   	push   %ebx
  800a6d:	ff 75 18             	pushl  0x18(%ebp)
  800a70:	52                   	push   %edx
  800a71:	50                   	push   %eax
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	ff 75 08             	pushl  0x8(%ebp)
  800a78:	e8 a1 ff ff ff       	call   800a1e <printnum>
  800a7d:	83 c4 20             	add    $0x20,%esp
  800a80:	eb 1a                	jmp    800a9c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a82:	83 ec 08             	sub    $0x8,%esp
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	ff 75 20             	pushl  0x20(%ebp)
  800a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8e:	ff d0                	call   *%eax
  800a90:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a93:	ff 4d 1c             	decl   0x1c(%ebp)
  800a96:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a9a:	7f e6                	jg     800a82 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a9c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a9f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aaa:	53                   	push   %ebx
  800aab:	51                   	push   %ecx
  800aac:	52                   	push   %edx
  800aad:	50                   	push   %eax
  800aae:	e8 39 18 00 00       	call   8022ec <__umoddi3>
  800ab3:	83 c4 10             	add    $0x10,%esp
  800ab6:	05 f4 2a 80 00       	add    $0x802af4,%eax
  800abb:	8a 00                	mov    (%eax),%al
  800abd:	0f be c0             	movsbl %al,%eax
  800ac0:	83 ec 08             	sub    $0x8,%esp
  800ac3:	ff 75 0c             	pushl  0xc(%ebp)
  800ac6:	50                   	push   %eax
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	ff d0                	call   *%eax
  800acc:	83 c4 10             	add    $0x10,%esp
}
  800acf:	90                   	nop
  800ad0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ad3:	c9                   	leave  
  800ad4:	c3                   	ret    

00800ad5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ad5:	55                   	push   %ebp
  800ad6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800adc:	7e 1c                	jle    800afa <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	8b 00                	mov    (%eax),%eax
  800ae3:	8d 50 08             	lea    0x8(%eax),%edx
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	89 10                	mov    %edx,(%eax)
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	83 e8 08             	sub    $0x8,%eax
  800af3:	8b 50 04             	mov    0x4(%eax),%edx
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	eb 40                	jmp    800b3a <getuint+0x65>
	else if (lflag)
  800afa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800afe:	74 1e                	je     800b1e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	8b 00                	mov    (%eax),%eax
  800b05:	8d 50 04             	lea    0x4(%eax),%edx
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	89 10                	mov    %edx,(%eax)
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	8b 00                	mov    (%eax),%eax
  800b12:	83 e8 04             	sub    $0x4,%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	ba 00 00 00 00       	mov    $0x0,%edx
  800b1c:	eb 1c                	jmp    800b3a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	8d 50 04             	lea    0x4(%eax),%edx
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	89 10                	mov    %edx,(%eax)
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	83 e8 04             	sub    $0x4,%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b3a:	5d                   	pop    %ebp
  800b3b:	c3                   	ret    

00800b3c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b3c:	55                   	push   %ebp
  800b3d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b43:	7e 1c                	jle    800b61 <getint+0x25>
		return va_arg(*ap, long long);
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	8b 00                	mov    (%eax),%eax
  800b4a:	8d 50 08             	lea    0x8(%eax),%edx
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	89 10                	mov    %edx,(%eax)
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	83 e8 08             	sub    $0x8,%eax
  800b5a:	8b 50 04             	mov    0x4(%eax),%edx
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	eb 38                	jmp    800b99 <getint+0x5d>
	else if (lflag)
  800b61:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b65:	74 1a                	je     800b81 <getint+0x45>
		return va_arg(*ap, long);
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	8b 00                	mov    (%eax),%eax
  800b6c:	8d 50 04             	lea    0x4(%eax),%edx
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	89 10                	mov    %edx,(%eax)
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	8b 00                	mov    (%eax),%eax
  800b79:	83 e8 04             	sub    $0x4,%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	99                   	cltd   
  800b7f:	eb 18                	jmp    800b99 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	8b 00                	mov    (%eax),%eax
  800b86:	8d 50 04             	lea    0x4(%eax),%edx
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	89 10                	mov    %edx,(%eax)
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	83 e8 04             	sub    $0x4,%eax
  800b96:	8b 00                	mov    (%eax),%eax
  800b98:	99                   	cltd   
}
  800b99:	5d                   	pop    %ebp
  800b9a:	c3                   	ret    

00800b9b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
  800b9e:	56                   	push   %esi
  800b9f:	53                   	push   %ebx
  800ba0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba3:	eb 17                	jmp    800bbc <vprintfmt+0x21>
			if (ch == '\0')
  800ba5:	85 db                	test   %ebx,%ebx
  800ba7:	0f 84 af 03 00 00    	je     800f5c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bad:	83 ec 08             	sub    $0x8,%esp
  800bb0:	ff 75 0c             	pushl  0xc(%ebp)
  800bb3:	53                   	push   %ebx
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	ff d0                	call   *%eax
  800bb9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbf:	8d 50 01             	lea    0x1(%eax),%edx
  800bc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	0f b6 d8             	movzbl %al,%ebx
  800bca:	83 fb 25             	cmp    $0x25,%ebx
  800bcd:	75 d6                	jne    800ba5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bcf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bd3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bda:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bef:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf2:	8d 50 01             	lea    0x1(%eax),%edx
  800bf5:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf8:	8a 00                	mov    (%eax),%al
  800bfa:	0f b6 d8             	movzbl %al,%ebx
  800bfd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c00:	83 f8 55             	cmp    $0x55,%eax
  800c03:	0f 87 2b 03 00 00    	ja     800f34 <vprintfmt+0x399>
  800c09:	8b 04 85 18 2b 80 00 	mov    0x802b18(,%eax,4),%eax
  800c10:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c12:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c16:	eb d7                	jmp    800bef <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c18:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c1c:	eb d1                	jmp    800bef <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c25:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c28:	89 d0                	mov    %edx,%eax
  800c2a:	c1 e0 02             	shl    $0x2,%eax
  800c2d:	01 d0                	add    %edx,%eax
  800c2f:	01 c0                	add    %eax,%eax
  800c31:	01 d8                	add    %ebx,%eax
  800c33:	83 e8 30             	sub    $0x30,%eax
  800c36:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c39:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3c:	8a 00                	mov    (%eax),%al
  800c3e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c41:	83 fb 2f             	cmp    $0x2f,%ebx
  800c44:	7e 3e                	jle    800c84 <vprintfmt+0xe9>
  800c46:	83 fb 39             	cmp    $0x39,%ebx
  800c49:	7f 39                	jg     800c84 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c4b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c4e:	eb d5                	jmp    800c25 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c50:	8b 45 14             	mov    0x14(%ebp),%eax
  800c53:	83 c0 04             	add    $0x4,%eax
  800c56:	89 45 14             	mov    %eax,0x14(%ebp)
  800c59:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5c:	83 e8 04             	sub    $0x4,%eax
  800c5f:	8b 00                	mov    (%eax),%eax
  800c61:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c64:	eb 1f                	jmp    800c85 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c66:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c6a:	79 83                	jns    800bef <vprintfmt+0x54>
				width = 0;
  800c6c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c73:	e9 77 ff ff ff       	jmp    800bef <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c78:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c7f:	e9 6b ff ff ff       	jmp    800bef <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c84:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c89:	0f 89 60 ff ff ff    	jns    800bef <vprintfmt+0x54>
				width = precision, precision = -1;
  800c8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c95:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c9c:	e9 4e ff ff ff       	jmp    800bef <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ca4:	e9 46 ff ff ff       	jmp    800bef <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cac:	83 c0 04             	add    $0x4,%eax
  800caf:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb5:	83 e8 04             	sub    $0x4,%eax
  800cb8:	8b 00                	mov    (%eax),%eax
  800cba:	83 ec 08             	sub    $0x8,%esp
  800cbd:	ff 75 0c             	pushl  0xc(%ebp)
  800cc0:	50                   	push   %eax
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	ff d0                	call   *%eax
  800cc6:	83 c4 10             	add    $0x10,%esp
			break;
  800cc9:	e9 89 02 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cce:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd1:	83 c0 04             	add    $0x4,%eax
  800cd4:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cda:	83 e8 04             	sub    $0x4,%eax
  800cdd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cdf:	85 db                	test   %ebx,%ebx
  800ce1:	79 02                	jns    800ce5 <vprintfmt+0x14a>
				err = -err;
  800ce3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ce5:	83 fb 64             	cmp    $0x64,%ebx
  800ce8:	7f 0b                	jg     800cf5 <vprintfmt+0x15a>
  800cea:	8b 34 9d 60 29 80 00 	mov    0x802960(,%ebx,4),%esi
  800cf1:	85 f6                	test   %esi,%esi
  800cf3:	75 19                	jne    800d0e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cf5:	53                   	push   %ebx
  800cf6:	68 05 2b 80 00       	push   $0x802b05
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	ff 75 08             	pushl  0x8(%ebp)
  800d01:	e8 5e 02 00 00       	call   800f64 <printfmt>
  800d06:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d09:	e9 49 02 00 00       	jmp    800f57 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d0e:	56                   	push   %esi
  800d0f:	68 0e 2b 80 00       	push   $0x802b0e
  800d14:	ff 75 0c             	pushl  0xc(%ebp)
  800d17:	ff 75 08             	pushl  0x8(%ebp)
  800d1a:	e8 45 02 00 00       	call   800f64 <printfmt>
  800d1f:	83 c4 10             	add    $0x10,%esp
			break;
  800d22:	e9 30 02 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d27:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2a:	83 c0 04             	add    $0x4,%eax
  800d2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800d30:	8b 45 14             	mov    0x14(%ebp),%eax
  800d33:	83 e8 04             	sub    $0x4,%eax
  800d36:	8b 30                	mov    (%eax),%esi
  800d38:	85 f6                	test   %esi,%esi
  800d3a:	75 05                	jne    800d41 <vprintfmt+0x1a6>
				p = "(null)";
  800d3c:	be 11 2b 80 00       	mov    $0x802b11,%esi
			if (width > 0 && padc != '-')
  800d41:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d45:	7e 6d                	jle    800db4 <vprintfmt+0x219>
  800d47:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d4b:	74 67                	je     800db4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d50:	83 ec 08             	sub    $0x8,%esp
  800d53:	50                   	push   %eax
  800d54:	56                   	push   %esi
  800d55:	e8 0c 03 00 00       	call   801066 <strnlen>
  800d5a:	83 c4 10             	add    $0x10,%esp
  800d5d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d60:	eb 16                	jmp    800d78 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d62:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d66:	83 ec 08             	sub    $0x8,%esp
  800d69:	ff 75 0c             	pushl  0xc(%ebp)
  800d6c:	50                   	push   %eax
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	ff d0                	call   *%eax
  800d72:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d75:	ff 4d e4             	decl   -0x1c(%ebp)
  800d78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7c:	7f e4                	jg     800d62 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7e:	eb 34                	jmp    800db4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d80:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d84:	74 1c                	je     800da2 <vprintfmt+0x207>
  800d86:	83 fb 1f             	cmp    $0x1f,%ebx
  800d89:	7e 05                	jle    800d90 <vprintfmt+0x1f5>
  800d8b:	83 fb 7e             	cmp    $0x7e,%ebx
  800d8e:	7e 12                	jle    800da2 <vprintfmt+0x207>
					putch('?', putdat);
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	6a 3f                	push   $0x3f
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
  800da0:	eb 0f                	jmp    800db1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800da2:	83 ec 08             	sub    $0x8,%esp
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	53                   	push   %ebx
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	ff d0                	call   *%eax
  800dae:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db1:	ff 4d e4             	decl   -0x1c(%ebp)
  800db4:	89 f0                	mov    %esi,%eax
  800db6:	8d 70 01             	lea    0x1(%eax),%esi
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f be d8             	movsbl %al,%ebx
  800dbe:	85 db                	test   %ebx,%ebx
  800dc0:	74 24                	je     800de6 <vprintfmt+0x24b>
  800dc2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc6:	78 b8                	js     800d80 <vprintfmt+0x1e5>
  800dc8:	ff 4d e0             	decl   -0x20(%ebp)
  800dcb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dcf:	79 af                	jns    800d80 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd1:	eb 13                	jmp    800de6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dd3:	83 ec 08             	sub    $0x8,%esp
  800dd6:	ff 75 0c             	pushl  0xc(%ebp)
  800dd9:	6a 20                	push   $0x20
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	ff d0                	call   *%eax
  800de0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de3:	ff 4d e4             	decl   -0x1c(%ebp)
  800de6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dea:	7f e7                	jg     800dd3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dec:	e9 66 01 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df1:	83 ec 08             	sub    $0x8,%esp
  800df4:	ff 75 e8             	pushl  -0x18(%ebp)
  800df7:	8d 45 14             	lea    0x14(%ebp),%eax
  800dfa:	50                   	push   %eax
  800dfb:	e8 3c fd ff ff       	call   800b3c <getint>
  800e00:	83 c4 10             	add    $0x10,%esp
  800e03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0f:	85 d2                	test   %edx,%edx
  800e11:	79 23                	jns    800e36 <vprintfmt+0x29b>
				putch('-', putdat);
  800e13:	83 ec 08             	sub    $0x8,%esp
  800e16:	ff 75 0c             	pushl  0xc(%ebp)
  800e19:	6a 2d                	push   $0x2d
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	ff d0                	call   *%eax
  800e20:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e29:	f7 d8                	neg    %eax
  800e2b:	83 d2 00             	adc    $0x0,%edx
  800e2e:	f7 da                	neg    %edx
  800e30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e36:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e3d:	e9 bc 00 00 00       	jmp    800efe <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e42:	83 ec 08             	sub    $0x8,%esp
  800e45:	ff 75 e8             	pushl  -0x18(%ebp)
  800e48:	8d 45 14             	lea    0x14(%ebp),%eax
  800e4b:	50                   	push   %eax
  800e4c:	e8 84 fc ff ff       	call   800ad5 <getuint>
  800e51:	83 c4 10             	add    $0x10,%esp
  800e54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e57:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e5a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e61:	e9 98 00 00 00       	jmp    800efe <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	ff 75 0c             	pushl  0xc(%ebp)
  800e6c:	6a 58                	push   $0x58
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	ff d0                	call   *%eax
  800e73:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 58                	push   $0x58
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e86:	83 ec 08             	sub    $0x8,%esp
  800e89:	ff 75 0c             	pushl  0xc(%ebp)
  800e8c:	6a 58                	push   $0x58
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	ff d0                	call   *%eax
  800e93:	83 c4 10             	add    $0x10,%esp
			break;
  800e96:	e9 bc 00 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e9b:	83 ec 08             	sub    $0x8,%esp
  800e9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ea1:	6a 30                	push   $0x30
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	ff d0                	call   *%eax
  800ea8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eab:	83 ec 08             	sub    $0x8,%esp
  800eae:	ff 75 0c             	pushl  0xc(%ebp)
  800eb1:	6a 78                	push   $0x78
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	ff d0                	call   *%eax
  800eb8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ebb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebe:	83 c0 04             	add    $0x4,%eax
  800ec1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec7:	83 e8 04             	sub    $0x4,%eax
  800eca:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ecc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ecf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ed6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800edd:	eb 1f                	jmp    800efe <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800edf:	83 ec 08             	sub    $0x8,%esp
  800ee2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee8:	50                   	push   %eax
  800ee9:	e8 e7 fb ff ff       	call   800ad5 <getuint>
  800eee:	83 c4 10             	add    $0x10,%esp
  800ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800efe:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f02:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f05:	83 ec 04             	sub    $0x4,%esp
  800f08:	52                   	push   %edx
  800f09:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f0c:	50                   	push   %eax
  800f0d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f10:	ff 75 f0             	pushl  -0x10(%ebp)
  800f13:	ff 75 0c             	pushl  0xc(%ebp)
  800f16:	ff 75 08             	pushl  0x8(%ebp)
  800f19:	e8 00 fb ff ff       	call   800a1e <printnum>
  800f1e:	83 c4 20             	add    $0x20,%esp
			break;
  800f21:	eb 34                	jmp    800f57 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	53                   	push   %ebx
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	ff d0                	call   *%eax
  800f2f:	83 c4 10             	add    $0x10,%esp
			break;
  800f32:	eb 23                	jmp    800f57 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f34:	83 ec 08             	sub    $0x8,%esp
  800f37:	ff 75 0c             	pushl  0xc(%ebp)
  800f3a:	6a 25                	push   $0x25
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	ff d0                	call   *%eax
  800f41:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f44:	ff 4d 10             	decl   0x10(%ebp)
  800f47:	eb 03                	jmp    800f4c <vprintfmt+0x3b1>
  800f49:	ff 4d 10             	decl   0x10(%ebp)
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	48                   	dec    %eax
  800f50:	8a 00                	mov    (%eax),%al
  800f52:	3c 25                	cmp    $0x25,%al
  800f54:	75 f3                	jne    800f49 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f56:	90                   	nop
		}
	}
  800f57:	e9 47 fc ff ff       	jmp    800ba3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f5c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f60:	5b                   	pop    %ebx
  800f61:	5e                   	pop    %esi
  800f62:	5d                   	pop    %ebp
  800f63:	c3                   	ret    

00800f64 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f64:	55                   	push   %ebp
  800f65:	89 e5                	mov    %esp,%ebp
  800f67:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f6a:	8d 45 10             	lea    0x10(%ebp),%eax
  800f6d:	83 c0 04             	add    $0x4,%eax
  800f70:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f73:	8b 45 10             	mov    0x10(%ebp),%eax
  800f76:	ff 75 f4             	pushl  -0xc(%ebp)
  800f79:	50                   	push   %eax
  800f7a:	ff 75 0c             	pushl  0xc(%ebp)
  800f7d:	ff 75 08             	pushl  0x8(%ebp)
  800f80:	e8 16 fc ff ff       	call   800b9b <vprintfmt>
  800f85:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f88:	90                   	nop
  800f89:	c9                   	leave  
  800f8a:	c3                   	ret    

00800f8b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	8b 40 08             	mov    0x8(%eax),%eax
  800f94:	8d 50 01             	lea    0x1(%eax),%edx
  800f97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa0:	8b 10                	mov    (%eax),%edx
  800fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa5:	8b 40 04             	mov    0x4(%eax),%eax
  800fa8:	39 c2                	cmp    %eax,%edx
  800faa:	73 12                	jae    800fbe <sprintputch+0x33>
		*b->buf++ = ch;
  800fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faf:	8b 00                	mov    (%eax),%eax
  800fb1:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb7:	89 0a                	mov    %ecx,(%edx)
  800fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbc:	88 10                	mov    %dl,(%eax)
}
  800fbe:	90                   	nop
  800fbf:	5d                   	pop    %ebp
  800fc0:	c3                   	ret    

00800fc1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
  800fc4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	01 d0                	add    %edx,%eax
  800fd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fe2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe6:	74 06                	je     800fee <vsnprintf+0x2d>
  800fe8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fec:	7f 07                	jg     800ff5 <vsnprintf+0x34>
		return -E_INVAL;
  800fee:	b8 03 00 00 00       	mov    $0x3,%eax
  800ff3:	eb 20                	jmp    801015 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ff5:	ff 75 14             	pushl  0x14(%ebp)
  800ff8:	ff 75 10             	pushl  0x10(%ebp)
  800ffb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ffe:	50                   	push   %eax
  800fff:	68 8b 0f 80 00       	push   $0x800f8b
  801004:	e8 92 fb ff ff       	call   800b9b <vprintfmt>
  801009:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80100c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80100f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801012:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801015:	c9                   	leave  
  801016:	c3                   	ret    

00801017 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801017:	55                   	push   %ebp
  801018:	89 e5                	mov    %esp,%ebp
  80101a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80101d:	8d 45 10             	lea    0x10(%ebp),%eax
  801020:	83 c0 04             	add    $0x4,%eax
  801023:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801026:	8b 45 10             	mov    0x10(%ebp),%eax
  801029:	ff 75 f4             	pushl  -0xc(%ebp)
  80102c:	50                   	push   %eax
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	ff 75 08             	pushl  0x8(%ebp)
  801033:	e8 89 ff ff ff       	call   800fc1 <vsnprintf>
  801038:	83 c4 10             	add    $0x10,%esp
  80103b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80103e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801041:	c9                   	leave  
  801042:	c3                   	ret    

00801043 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801043:	55                   	push   %ebp
  801044:	89 e5                	mov    %esp,%ebp
  801046:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801049:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801050:	eb 06                	jmp    801058 <strlen+0x15>
		n++;
  801052:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801055:	ff 45 08             	incl   0x8(%ebp)
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	84 c0                	test   %al,%al
  80105f:	75 f1                	jne    801052 <strlen+0xf>
		n++;
	return n;
  801061:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801064:	c9                   	leave  
  801065:	c3                   	ret    

00801066 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801066:	55                   	push   %ebp
  801067:	89 e5                	mov    %esp,%ebp
  801069:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80106c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801073:	eb 09                	jmp    80107e <strnlen+0x18>
		n++;
  801075:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801078:	ff 45 08             	incl   0x8(%ebp)
  80107b:	ff 4d 0c             	decl   0xc(%ebp)
  80107e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801082:	74 09                	je     80108d <strnlen+0x27>
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	84 c0                	test   %al,%al
  80108b:	75 e8                	jne    801075 <strnlen+0xf>
		n++;
	return n;
  80108d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
  801095:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80109e:	90                   	nop
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	8d 50 01             	lea    0x1(%eax),%edx
  8010a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010b1:	8a 12                	mov    (%edx),%dl
  8010b3:	88 10                	mov    %dl,(%eax)
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	84 c0                	test   %al,%al
  8010b9:	75 e4                	jne    80109f <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010d3:	eb 1f                	jmp    8010f4 <strncpy+0x34>
		*dst++ = *src;
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	8d 50 01             	lea    0x1(%eax),%edx
  8010db:	89 55 08             	mov    %edx,0x8(%ebp)
  8010de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e1:	8a 12                	mov    (%edx),%dl
  8010e3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e8:	8a 00                	mov    (%eax),%al
  8010ea:	84 c0                	test   %al,%al
  8010ec:	74 03                	je     8010f1 <strncpy+0x31>
			src++;
  8010ee:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010f1:	ff 45 fc             	incl   -0x4(%ebp)
  8010f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010fa:	72 d9                	jb     8010d5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ff:	c9                   	leave  
  801100:	c3                   	ret    

00801101 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801101:	55                   	push   %ebp
  801102:	89 e5                	mov    %esp,%ebp
  801104:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80110d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801111:	74 30                	je     801143 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801113:	eb 16                	jmp    80112b <strlcpy+0x2a>
			*dst++ = *src++;
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	8d 50 01             	lea    0x1(%eax),%edx
  80111b:	89 55 08             	mov    %edx,0x8(%ebp)
  80111e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801121:	8d 4a 01             	lea    0x1(%edx),%ecx
  801124:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801127:	8a 12                	mov    (%edx),%dl
  801129:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80112b:	ff 4d 10             	decl   0x10(%ebp)
  80112e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801132:	74 09                	je     80113d <strlcpy+0x3c>
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	84 c0                	test   %al,%al
  80113b:	75 d8                	jne    801115 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801143:	8b 55 08             	mov    0x8(%ebp),%edx
  801146:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801149:	29 c2                	sub    %eax,%edx
  80114b:	89 d0                	mov    %edx,%eax
}
  80114d:	c9                   	leave  
  80114e:	c3                   	ret    

0080114f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801152:	eb 06                	jmp    80115a <strcmp+0xb>
		p++, q++;
  801154:	ff 45 08             	incl   0x8(%ebp)
  801157:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	84 c0                	test   %al,%al
  801161:	74 0e                	je     801171 <strcmp+0x22>
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8a 10                	mov    (%eax),%dl
  801168:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	38 c2                	cmp    %al,%dl
  80116f:	74 e3                	je     801154 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	0f b6 d0             	movzbl %al,%edx
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	0f b6 c0             	movzbl %al,%eax
  801181:	29 c2                	sub    %eax,%edx
  801183:	89 d0                	mov    %edx,%eax
}
  801185:	5d                   	pop    %ebp
  801186:	c3                   	ret    

00801187 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80118a:	eb 09                	jmp    801195 <strncmp+0xe>
		n--, p++, q++;
  80118c:	ff 4d 10             	decl   0x10(%ebp)
  80118f:	ff 45 08             	incl   0x8(%ebp)
  801192:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801195:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801199:	74 17                	je     8011b2 <strncmp+0x2b>
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	84 c0                	test   %al,%al
  8011a2:	74 0e                	je     8011b2 <strncmp+0x2b>
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 10                	mov    (%eax),%dl
  8011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ac:	8a 00                	mov    (%eax),%al
  8011ae:	38 c2                	cmp    %al,%dl
  8011b0:	74 da                	je     80118c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b6:	75 07                	jne    8011bf <strncmp+0x38>
		return 0;
  8011b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011bd:	eb 14                	jmp    8011d3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	0f b6 d0             	movzbl %al,%edx
  8011c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	0f b6 c0             	movzbl %al,%eax
  8011cf:	29 c2                	sub    %eax,%edx
  8011d1:	89 d0                	mov    %edx,%eax
}
  8011d3:	5d                   	pop    %ebp
  8011d4:	c3                   	ret    

008011d5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011d5:	55                   	push   %ebp
  8011d6:	89 e5                	mov    %esp,%ebp
  8011d8:	83 ec 04             	sub    $0x4,%esp
  8011db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011de:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011e1:	eb 12                	jmp    8011f5 <strchr+0x20>
		if (*s == c)
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8a 00                	mov    (%eax),%al
  8011e8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011eb:	75 05                	jne    8011f2 <strchr+0x1d>
			return (char *) s;
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	eb 11                	jmp    801203 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011f2:	ff 45 08             	incl   0x8(%ebp)
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	84 c0                	test   %al,%al
  8011fc:	75 e5                	jne    8011e3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801203:	c9                   	leave  
  801204:	c3                   	ret    

00801205 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801205:	55                   	push   %ebp
  801206:	89 e5                	mov    %esp,%ebp
  801208:	83 ec 04             	sub    $0x4,%esp
  80120b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801211:	eb 0d                	jmp    801220 <strfind+0x1b>
		if (*s == c)
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80121b:	74 0e                	je     80122b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80121d:	ff 45 08             	incl   0x8(%ebp)
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	84 c0                	test   %al,%al
  801227:	75 ea                	jne    801213 <strfind+0xe>
  801229:	eb 01                	jmp    80122c <strfind+0x27>
		if (*s == c)
			break;
  80122b:	90                   	nop
	return (char *) s;
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
  801234:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801243:	eb 0e                	jmp    801253 <memset+0x22>
		*p++ = c;
  801245:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801248:	8d 50 01             	lea    0x1(%eax),%edx
  80124b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80124e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801251:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801253:	ff 4d f8             	decl   -0x8(%ebp)
  801256:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80125a:	79 e9                	jns    801245 <memset+0x14>
		*p++ = c;

	return v;
  80125c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
  801264:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801273:	eb 16                	jmp    80128b <memcpy+0x2a>
		*d++ = *s++;
  801275:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801278:	8d 50 01             	lea    0x1(%eax),%edx
  80127b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80127e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801281:	8d 4a 01             	lea    0x1(%edx),%ecx
  801284:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801287:	8a 12                	mov    (%edx),%dl
  801289:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80128b:	8b 45 10             	mov    0x10(%ebp),%eax
  80128e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801291:	89 55 10             	mov    %edx,0x10(%ebp)
  801294:	85 c0                	test   %eax,%eax
  801296:	75 dd                	jne    801275 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
  8012a0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012b5:	73 50                	jae    801307 <memmove+0x6a>
  8012b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	01 d0                	add    %edx,%eax
  8012bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012c2:	76 43                	jbe    801307 <memmove+0x6a>
		s += n;
  8012c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012d0:	eb 10                	jmp    8012e2 <memmove+0x45>
			*--d = *--s;
  8012d2:	ff 4d f8             	decl   -0x8(%ebp)
  8012d5:	ff 4d fc             	decl   -0x4(%ebp)
  8012d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012db:	8a 10                	mov    (%eax),%dl
  8012dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e8:	89 55 10             	mov    %edx,0x10(%ebp)
  8012eb:	85 c0                	test   %eax,%eax
  8012ed:	75 e3                	jne    8012d2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012ef:	eb 23                	jmp    801314 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f4:	8d 50 01             	lea    0x1(%eax),%edx
  8012f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801300:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801303:	8a 12                	mov    (%edx),%dl
  801305:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801307:	8b 45 10             	mov    0x10(%ebp),%eax
  80130a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80130d:	89 55 10             	mov    %edx,0x10(%ebp)
  801310:	85 c0                	test   %eax,%eax
  801312:	75 dd                	jne    8012f1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801317:	c9                   	leave  
  801318:	c3                   	ret    

00801319 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
  80131c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80132b:	eb 2a                	jmp    801357 <memcmp+0x3e>
		if (*s1 != *s2)
  80132d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801330:	8a 10                	mov    (%eax),%dl
  801332:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801335:	8a 00                	mov    (%eax),%al
  801337:	38 c2                	cmp    %al,%dl
  801339:	74 16                	je     801351 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80133b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	0f b6 d0             	movzbl %al,%edx
  801343:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	0f b6 c0             	movzbl %al,%eax
  80134b:	29 c2                	sub    %eax,%edx
  80134d:	89 d0                	mov    %edx,%eax
  80134f:	eb 18                	jmp    801369 <memcmp+0x50>
		s1++, s2++;
  801351:	ff 45 fc             	incl   -0x4(%ebp)
  801354:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801357:	8b 45 10             	mov    0x10(%ebp),%eax
  80135a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80135d:	89 55 10             	mov    %edx,0x10(%ebp)
  801360:	85 c0                	test   %eax,%eax
  801362:	75 c9                	jne    80132d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801364:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
  80136e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801371:	8b 55 08             	mov    0x8(%ebp),%edx
  801374:	8b 45 10             	mov    0x10(%ebp),%eax
  801377:	01 d0                	add    %edx,%eax
  801379:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80137c:	eb 15                	jmp    801393 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	0f b6 d0             	movzbl %al,%edx
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	0f b6 c0             	movzbl %al,%eax
  80138c:	39 c2                	cmp    %eax,%edx
  80138e:	74 0d                	je     80139d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801390:	ff 45 08             	incl   0x8(%ebp)
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801399:	72 e3                	jb     80137e <memfind+0x13>
  80139b:	eb 01                	jmp    80139e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80139d:	90                   	nop
	return (void *) s;
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013a1:	c9                   	leave  
  8013a2:	c3                   	ret    

008013a3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
  8013a6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b7:	eb 03                	jmp    8013bc <strtol+0x19>
		s++;
  8013b9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	8a 00                	mov    (%eax),%al
  8013c1:	3c 20                	cmp    $0x20,%al
  8013c3:	74 f4                	je     8013b9 <strtol+0x16>
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	3c 09                	cmp    $0x9,%al
  8013cc:	74 eb                	je     8013b9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	3c 2b                	cmp    $0x2b,%al
  8013d5:	75 05                	jne    8013dc <strtol+0x39>
		s++;
  8013d7:	ff 45 08             	incl   0x8(%ebp)
  8013da:	eb 13                	jmp    8013ef <strtol+0x4c>
	else if (*s == '-')
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	8a 00                	mov    (%eax),%al
  8013e1:	3c 2d                	cmp    $0x2d,%al
  8013e3:	75 0a                	jne    8013ef <strtol+0x4c>
		s++, neg = 1;
  8013e5:	ff 45 08             	incl   0x8(%ebp)
  8013e8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f3:	74 06                	je     8013fb <strtol+0x58>
  8013f5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013f9:	75 20                	jne    80141b <strtol+0x78>
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	8a 00                	mov    (%eax),%al
  801400:	3c 30                	cmp    $0x30,%al
  801402:	75 17                	jne    80141b <strtol+0x78>
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	40                   	inc    %eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	3c 78                	cmp    $0x78,%al
  80140c:	75 0d                	jne    80141b <strtol+0x78>
		s += 2, base = 16;
  80140e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801412:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801419:	eb 28                	jmp    801443 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80141b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141f:	75 15                	jne    801436 <strtol+0x93>
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	3c 30                	cmp    $0x30,%al
  801428:	75 0c                	jne    801436 <strtol+0x93>
		s++, base = 8;
  80142a:	ff 45 08             	incl   0x8(%ebp)
  80142d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801434:	eb 0d                	jmp    801443 <strtol+0xa0>
	else if (base == 0)
  801436:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80143a:	75 07                	jne    801443 <strtol+0xa0>
		base = 10;
  80143c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	3c 2f                	cmp    $0x2f,%al
  80144a:	7e 19                	jle    801465 <strtol+0xc2>
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	3c 39                	cmp    $0x39,%al
  801453:	7f 10                	jg     801465 <strtol+0xc2>
			dig = *s - '0';
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	0f be c0             	movsbl %al,%eax
  80145d:	83 e8 30             	sub    $0x30,%eax
  801460:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801463:	eb 42                	jmp    8014a7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	8a 00                	mov    (%eax),%al
  80146a:	3c 60                	cmp    $0x60,%al
  80146c:	7e 19                	jle    801487 <strtol+0xe4>
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	8a 00                	mov    (%eax),%al
  801473:	3c 7a                	cmp    $0x7a,%al
  801475:	7f 10                	jg     801487 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	0f be c0             	movsbl %al,%eax
  80147f:	83 e8 57             	sub    $0x57,%eax
  801482:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801485:	eb 20                	jmp    8014a7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	8a 00                	mov    (%eax),%al
  80148c:	3c 40                	cmp    $0x40,%al
  80148e:	7e 39                	jle    8014c9 <strtol+0x126>
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	3c 5a                	cmp    $0x5a,%al
  801497:	7f 30                	jg     8014c9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	8a 00                	mov    (%eax),%al
  80149e:	0f be c0             	movsbl %al,%eax
  8014a1:	83 e8 37             	sub    $0x37,%eax
  8014a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014aa:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ad:	7d 19                	jge    8014c8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014af:	ff 45 08             	incl   0x8(%ebp)
  8014b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014b9:	89 c2                	mov    %eax,%edx
  8014bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014be:	01 d0                	add    %edx,%eax
  8014c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014c3:	e9 7b ff ff ff       	jmp    801443 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014c8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014cd:	74 08                	je     8014d7 <strtol+0x134>
		*endptr = (char *) s;
  8014cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014db:	74 07                	je     8014e4 <strtol+0x141>
  8014dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e0:	f7 d8                	neg    %eax
  8014e2:	eb 03                	jmp    8014e7 <strtol+0x144>
  8014e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <ltostr>:

void
ltostr(long value, char *str)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801501:	79 13                	jns    801516 <ltostr+0x2d>
	{
		neg = 1;
  801503:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801510:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801513:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80151e:	99                   	cltd   
  80151f:	f7 f9                	idiv   %ecx
  801521:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801524:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801527:	8d 50 01             	lea    0x1(%eax),%edx
  80152a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80152d:	89 c2                	mov    %eax,%edx
  80152f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801532:	01 d0                	add    %edx,%eax
  801534:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801537:	83 c2 30             	add    $0x30,%edx
  80153a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80153c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80153f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801544:	f7 e9                	imul   %ecx
  801546:	c1 fa 02             	sar    $0x2,%edx
  801549:	89 c8                	mov    %ecx,%eax
  80154b:	c1 f8 1f             	sar    $0x1f,%eax
  80154e:	29 c2                	sub    %eax,%edx
  801550:	89 d0                	mov    %edx,%eax
  801552:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801555:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801558:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80155d:	f7 e9                	imul   %ecx
  80155f:	c1 fa 02             	sar    $0x2,%edx
  801562:	89 c8                	mov    %ecx,%eax
  801564:	c1 f8 1f             	sar    $0x1f,%eax
  801567:	29 c2                	sub    %eax,%edx
  801569:	89 d0                	mov    %edx,%eax
  80156b:	c1 e0 02             	shl    $0x2,%eax
  80156e:	01 d0                	add    %edx,%eax
  801570:	01 c0                	add    %eax,%eax
  801572:	29 c1                	sub    %eax,%ecx
  801574:	89 ca                	mov    %ecx,%edx
  801576:	85 d2                	test   %edx,%edx
  801578:	75 9c                	jne    801516 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80157a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801581:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801584:	48                   	dec    %eax
  801585:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801588:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80158c:	74 3d                	je     8015cb <ltostr+0xe2>
		start = 1 ;
  80158e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801595:	eb 34                	jmp    8015cb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801597:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80159a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159d:	01 d0                	add    %edx,%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015aa:	01 c2                	add    %eax,%edx
  8015ac:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b2:	01 c8                	add    %ecx,%eax
  8015b4:	8a 00                	mov    (%eax),%al
  8015b6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015be:	01 c2                	add    %eax,%edx
  8015c0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015c3:	88 02                	mov    %al,(%edx)
		start++ ;
  8015c5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015c8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015d1:	7c c4                	jl     801597 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015d3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d9:	01 d0                	add    %edx,%eax
  8015db:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015de:	90                   	nop
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
  8015e4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015e7:	ff 75 08             	pushl  0x8(%ebp)
  8015ea:	e8 54 fa ff ff       	call   801043 <strlen>
  8015ef:	83 c4 04             	add    $0x4,%esp
  8015f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015f5:	ff 75 0c             	pushl  0xc(%ebp)
  8015f8:	e8 46 fa ff ff       	call   801043 <strlen>
  8015fd:	83 c4 04             	add    $0x4,%esp
  801600:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801603:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80160a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801611:	eb 17                	jmp    80162a <strcconcat+0x49>
		final[s] = str1[s] ;
  801613:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801616:	8b 45 10             	mov    0x10(%ebp),%eax
  801619:	01 c2                	add    %eax,%edx
  80161b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	01 c8                	add    %ecx,%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801627:	ff 45 fc             	incl   -0x4(%ebp)
  80162a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801630:	7c e1                	jl     801613 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801632:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801639:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801640:	eb 1f                	jmp    801661 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801642:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801645:	8d 50 01             	lea    0x1(%eax),%edx
  801648:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80164b:	89 c2                	mov    %eax,%edx
  80164d:	8b 45 10             	mov    0x10(%ebp),%eax
  801650:	01 c2                	add    %eax,%edx
  801652:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801655:	8b 45 0c             	mov    0xc(%ebp),%eax
  801658:	01 c8                	add    %ecx,%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80165e:	ff 45 f8             	incl   -0x8(%ebp)
  801661:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801664:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801667:	7c d9                	jl     801642 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801669:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	01 d0                	add    %edx,%eax
  801671:	c6 00 00             	movb   $0x0,(%eax)
}
  801674:	90                   	nop
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80167a:	8b 45 14             	mov    0x14(%ebp),%eax
  80167d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801683:	8b 45 14             	mov    0x14(%ebp),%eax
  801686:	8b 00                	mov    (%eax),%eax
  801688:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80168f:	8b 45 10             	mov    0x10(%ebp),%eax
  801692:	01 d0                	add    %edx,%eax
  801694:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80169a:	eb 0c                	jmp    8016a8 <strsplit+0x31>
			*string++ = 0;
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	8d 50 01             	lea    0x1(%eax),%edx
  8016a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	84 c0                	test   %al,%al
  8016af:	74 18                	je     8016c9 <strsplit+0x52>
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	0f be c0             	movsbl %al,%eax
  8016b9:	50                   	push   %eax
  8016ba:	ff 75 0c             	pushl  0xc(%ebp)
  8016bd:	e8 13 fb ff ff       	call   8011d5 <strchr>
  8016c2:	83 c4 08             	add    $0x8,%esp
  8016c5:	85 c0                	test   %eax,%eax
  8016c7:	75 d3                	jne    80169c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	84 c0                	test   %al,%al
  8016d0:	74 5a                	je     80172c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d5:	8b 00                	mov    (%eax),%eax
  8016d7:	83 f8 0f             	cmp    $0xf,%eax
  8016da:	75 07                	jne    8016e3 <strsplit+0x6c>
		{
			return 0;
  8016dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8016e1:	eb 66                	jmp    801749 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e6:	8b 00                	mov    (%eax),%eax
  8016e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8016eb:	8b 55 14             	mov    0x14(%ebp),%edx
  8016ee:	89 0a                	mov    %ecx,(%edx)
  8016f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fa:	01 c2                	add    %eax,%edx
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801701:	eb 03                	jmp    801706 <strsplit+0x8f>
			string++;
  801703:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	8a 00                	mov    (%eax),%al
  80170b:	84 c0                	test   %al,%al
  80170d:	74 8b                	je     80169a <strsplit+0x23>
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	8a 00                	mov    (%eax),%al
  801714:	0f be c0             	movsbl %al,%eax
  801717:	50                   	push   %eax
  801718:	ff 75 0c             	pushl  0xc(%ebp)
  80171b:	e8 b5 fa ff ff       	call   8011d5 <strchr>
  801720:	83 c4 08             	add    $0x8,%esp
  801723:	85 c0                	test   %eax,%eax
  801725:	74 dc                	je     801703 <strsplit+0x8c>
			string++;
	}
  801727:	e9 6e ff ff ff       	jmp    80169a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80172c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80172d:	8b 45 14             	mov    0x14(%ebp),%eax
  801730:	8b 00                	mov    (%eax),%eax
  801732:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801739:	8b 45 10             	mov    0x10(%ebp),%eax
  80173c:	01 d0                	add    %edx,%eax
  80173e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801744:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801749:	c9                   	leave  
  80174a:	c3                   	ret    

0080174b <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  80174b:	55                   	push   %ebp
  80174c:	89 e5                	mov    %esp,%ebp
  80174e:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801751:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801758:	76 0a                	jbe    801764 <malloc+0x19>
		return NULL;
  80175a:	b8 00 00 00 00       	mov    $0x0,%eax
  80175f:	e9 ad 02 00 00       	jmp    801a11 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801764:	8b 45 08             	mov    0x8(%ebp),%eax
  801767:	c1 e8 0c             	shr    $0xc,%eax
  80176a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	25 ff 0f 00 00       	and    $0xfff,%eax
  801775:	85 c0                	test   %eax,%eax
  801777:	74 03                	je     80177c <malloc+0x31>
		num++;
  801779:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  80177c:	a1 28 30 80 00       	mov    0x803028,%eax
  801781:	85 c0                	test   %eax,%eax
  801783:	75 71                	jne    8017f6 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801785:	a1 04 30 80 00       	mov    0x803004,%eax
  80178a:	83 ec 08             	sub    $0x8,%esp
  80178d:	ff 75 08             	pushl  0x8(%ebp)
  801790:	50                   	push   %eax
  801791:	e8 ba 05 00 00       	call   801d50 <sys_allocateMem>
  801796:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801799:	a1 04 30 80 00       	mov    0x803004,%eax
  80179e:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  8017a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a4:	c1 e0 0c             	shl    $0xc,%eax
  8017a7:	89 c2                	mov    %eax,%edx
  8017a9:	a1 04 30 80 00       	mov    0x803004,%eax
  8017ae:	01 d0                	add    %edx,%eax
  8017b0:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8017b5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017bd:	89 14 85 c0 80 e2 00 	mov    %edx,0xe280c0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8017c4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017c9:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8017cc:	89 14 85 c0 4b d6 00 	mov    %edx,0xd64bc0(,%eax,4)
		changed[sizeofarray] = 1;
  8017d3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017d8:	c7 04 85 40 66 dc 00 	movl   $0x1,0xdc6640(,%eax,4)
  8017df:	01 00 00 00 
		sizeofarray++;
  8017e3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017e8:	40                   	inc    %eax
  8017e9:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  8017ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8017f1:	e9 1b 02 00 00       	jmp    801a11 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8017f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8017fd:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801804:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  80180b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801812:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801819:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801820:	eb 72                	jmp    801894 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801822:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801825:	8b 04 85 40 66 dc 00 	mov    0xdc6640(,%eax,4),%eax
  80182c:	85 c0                	test   %eax,%eax
  80182e:	75 12                	jne    801842 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801830:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801833:	8b 04 85 c0 80 e2 00 	mov    0xe280c0(,%eax,4),%eax
  80183a:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  80183d:	ff 45 dc             	incl   -0x24(%ebp)
  801840:	eb 4f                	jmp    801891 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801842:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801845:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801848:	7d 39                	jge    801883 <malloc+0x138>
  80184a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80184d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801850:	7c 31                	jl     801883 <malloc+0x138>
					{
						min=count;
  801852:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801855:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801858:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80185b:	8b 04 85 c0 4b d6 00 	mov    0xd64bc0(,%eax,4),%eax
  801862:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801865:	c1 e2 0c             	shl    $0xc,%edx
  801868:	29 d0                	sub    %edx,%eax
  80186a:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  80186d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801870:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801873:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801876:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  80187d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801880:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801883:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  80188a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801891:	ff 45 d4             	incl   -0x2c(%ebp)
  801894:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801899:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  80189c:	7c 84                	jl     801822 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  80189e:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  8018a2:	0f 85 e3 00 00 00    	jne    80198b <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  8018a8:	83 ec 08             	sub    $0x8,%esp
  8018ab:	ff 75 08             	pushl  0x8(%ebp)
  8018ae:	ff 75 e0             	pushl  -0x20(%ebp)
  8018b1:	e8 9a 04 00 00       	call   801d50 <sys_allocateMem>
  8018b6:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  8018b9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018be:	40                   	inc    %eax
  8018bf:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  8018c4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018c9:	48                   	dec    %eax
  8018ca:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8018cd:	eb 42                	jmp    801911 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  8018cf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018d2:	48                   	dec    %eax
  8018d3:	8b 14 85 c0 4b d6 00 	mov    0xd64bc0(,%eax,4),%edx
  8018da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018dd:	89 14 85 c0 4b d6 00 	mov    %edx,0xd64bc0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  8018e4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018e7:	48                   	dec    %eax
  8018e8:	8b 14 85 c0 80 e2 00 	mov    0xe280c0(,%eax,4),%edx
  8018ef:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018f2:	89 14 85 c0 80 e2 00 	mov    %edx,0xe280c0(,%eax,4)
					changed[i]=changed[i-1];
  8018f9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018fc:	48                   	dec    %eax
  8018fd:	8b 14 85 40 66 dc 00 	mov    0xdc6640(,%eax,4),%edx
  801904:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801907:	89 14 85 40 66 dc 00 	mov    %edx,0xdc6640(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  80190e:	ff 4d d0             	decl   -0x30(%ebp)
  801911:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801914:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801917:	7f b6                	jg     8018cf <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801919:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80191c:	40                   	inc    %eax
  80191d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801920:	8b 55 08             	mov    0x8(%ebp),%edx
  801923:	01 ca                	add    %ecx,%edx
  801925:	89 14 85 c0 4b d6 00 	mov    %edx,0xd64bc0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  80192c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80192f:	8d 50 01             	lea    0x1(%eax),%edx
  801932:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801935:	8b 04 85 c0 80 e2 00 	mov    0xe280c0(,%eax,4),%eax
  80193c:	2b 45 f4             	sub    -0xc(%ebp),%eax
  80193f:	89 04 95 c0 80 e2 00 	mov    %eax,0xe280c0(,%edx,4)
				changed[index+1]=0;
  801946:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801949:	40                   	inc    %eax
  80194a:	c7 04 85 40 66 dc 00 	movl   $0x0,0xdc6640(,%eax,4)
  801951:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801955:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801958:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80195b:	89 14 85 c0 80 e2 00 	mov    %edx,0xe280c0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801962:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801965:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801968:	eb 11                	jmp    80197b <malloc+0x230>
				{
					changed[index] = 1;
  80196a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80196d:	c7 04 85 40 66 dc 00 	movl   $0x1,0xdc6640(,%eax,4)
  801974:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801978:	ff 45 cc             	incl   -0x34(%ebp)
  80197b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80197e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801981:	7c e7                	jl     80196a <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801983:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801986:	e9 86 00 00 00       	jmp    801a11 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  80198b:	a1 04 30 80 00       	mov    0x803004,%eax
  801990:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801995:	29 c2                	sub    %eax,%edx
  801997:	89 d0                	mov    %edx,%eax
  801999:	3b 45 08             	cmp    0x8(%ebp),%eax
  80199c:	73 07                	jae    8019a5 <malloc+0x25a>
						return NULL;
  80199e:	b8 00 00 00 00       	mov    $0x0,%eax
  8019a3:	eb 6c                	jmp    801a11 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  8019a5:	a1 04 30 80 00       	mov    0x803004,%eax
  8019aa:	83 ec 08             	sub    $0x8,%esp
  8019ad:	ff 75 08             	pushl  0x8(%ebp)
  8019b0:	50                   	push   %eax
  8019b1:	e8 9a 03 00 00       	call   801d50 <sys_allocateMem>
  8019b6:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  8019b9:	a1 04 30 80 00       	mov    0x803004,%eax
  8019be:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  8019c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019c4:	c1 e0 0c             	shl    $0xc,%eax
  8019c7:	89 c2                	mov    %eax,%edx
  8019c9:	a1 04 30 80 00       	mov    0x803004,%eax
  8019ce:	01 d0                	add    %edx,%eax
  8019d0:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  8019d5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019dd:	89 14 85 c0 80 e2 00 	mov    %edx,0xe280c0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  8019e4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019e9:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8019ec:	89 14 85 c0 4b d6 00 	mov    %edx,0xd64bc0(,%eax,4)
					changed[sizeofarray] = 1;
  8019f3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019f8:	c7 04 85 40 66 dc 00 	movl   $0x1,0xdc6640(,%eax,4)
  8019ff:	01 00 00 00 
					sizeofarray++;
  801a03:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a08:	40                   	inc    %eax
  801a09:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  801a0e:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
  801a16:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801a19:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801a1f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801a26:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801a2d:	eb 30                	jmp    801a5f <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801a2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a32:	8b 04 85 c0 4b d6 00 	mov    0xd64bc0(,%eax,4),%eax
  801a39:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a3c:	75 1e                	jne    801a5c <free+0x49>
  801a3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a41:	8b 04 85 40 66 dc 00 	mov    0xdc6640(,%eax,4),%eax
  801a48:	83 f8 01             	cmp    $0x1,%eax
  801a4b:	75 0f                	jne    801a5c <free+0x49>
			is_found = 1;
  801a4d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801a54:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a57:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801a5a:	eb 0d                	jmp    801a69 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801a5c:	ff 45 ec             	incl   -0x14(%ebp)
  801a5f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a64:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801a67:	7c c6                	jl     801a2f <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801a69:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801a6d:	75 3a                	jne    801aa9 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a72:	8b 04 85 c0 80 e2 00 	mov    0xe280c0(,%eax,4),%eax
  801a79:	c1 e0 0c             	shl    $0xc,%eax
  801a7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801a7f:	83 ec 08             	sub    $0x8,%esp
  801a82:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a85:	ff 75 e8             	pushl  -0x18(%ebp)
  801a88:	e8 a7 02 00 00       	call   801d34 <sys_freeMem>
  801a8d:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a93:	c7 04 85 40 66 dc 00 	movl   $0x0,0xdc6640(,%eax,4)
  801a9a:	00 00 00 00 
		changes++;
  801a9e:	a1 28 30 80 00       	mov    0x803028,%eax
  801aa3:	40                   	inc    %eax
  801aa4:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801aa9:	90                   	nop
  801aaa:	c9                   	leave  
  801aab:	c3                   	ret    

00801aac <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801aac:	55                   	push   %ebp
  801aad:	89 e5                	mov    %esp,%ebp
  801aaf:	83 ec 18             	sub    $0x18,%esp
  801ab2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab5:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801ab8:	83 ec 04             	sub    $0x4,%esp
  801abb:	68 70 2c 80 00       	push   $0x802c70
  801ac0:	68 b6 00 00 00       	push   $0xb6
  801ac5:	68 93 2c 80 00       	push   $0x802c93
  801aca:	e8 50 ec ff ff       	call   80071f <_panic>

00801acf <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
  801ad2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad5:	83 ec 04             	sub    $0x4,%esp
  801ad8:	68 70 2c 80 00       	push   $0x802c70
  801add:	68 bb 00 00 00       	push   $0xbb
  801ae2:	68 93 2c 80 00       	push   $0x802c93
  801ae7:	e8 33 ec ff ff       	call   80071f <_panic>

00801aec <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801aec:	55                   	push   %ebp
  801aed:	89 e5                	mov    %esp,%ebp
  801aef:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801af2:	83 ec 04             	sub    $0x4,%esp
  801af5:	68 70 2c 80 00       	push   $0x802c70
  801afa:	68 c0 00 00 00       	push   $0xc0
  801aff:	68 93 2c 80 00       	push   $0x802c93
  801b04:	e8 16 ec ff ff       	call   80071f <_panic>

00801b09 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
  801b0c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b0f:	83 ec 04             	sub    $0x4,%esp
  801b12:	68 70 2c 80 00       	push   $0x802c70
  801b17:	68 c4 00 00 00       	push   $0xc4
  801b1c:	68 93 2c 80 00       	push   $0x802c93
  801b21:	e8 f9 eb ff ff       	call   80071f <_panic>

00801b26 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801b26:	55                   	push   %ebp
  801b27:	89 e5                	mov    %esp,%ebp
  801b29:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b2c:	83 ec 04             	sub    $0x4,%esp
  801b2f:	68 70 2c 80 00       	push   $0x802c70
  801b34:	68 c9 00 00 00       	push   $0xc9
  801b39:	68 93 2c 80 00       	push   $0x802c93
  801b3e:	e8 dc eb ff ff       	call   80071f <_panic>

00801b43 <shrink>:
}
void shrink(uint32 newSize) {
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
  801b46:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b49:	83 ec 04             	sub    $0x4,%esp
  801b4c:	68 70 2c 80 00       	push   $0x802c70
  801b51:	68 cc 00 00 00       	push   $0xcc
  801b56:	68 93 2c 80 00       	push   $0x802c93
  801b5b:	e8 bf eb ff ff       	call   80071f <_panic>

00801b60 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
  801b63:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b66:	83 ec 04             	sub    $0x4,%esp
  801b69:	68 70 2c 80 00       	push   $0x802c70
  801b6e:	68 d0 00 00 00       	push   $0xd0
  801b73:	68 93 2c 80 00       	push   $0x802c93
  801b78:	e8 a2 eb ff ff       	call   80071f <_panic>

00801b7d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
  801b80:	57                   	push   %edi
  801b81:	56                   	push   %esi
  801b82:	53                   	push   %ebx
  801b83:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b86:	8b 45 08             	mov    0x8(%ebp),%eax
  801b89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b8f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b92:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b95:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b98:	cd 30                	int    $0x30
  801b9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ba0:	83 c4 10             	add    $0x10,%esp
  801ba3:	5b                   	pop    %ebx
  801ba4:	5e                   	pop    %esi
  801ba5:	5f                   	pop    %edi
  801ba6:	5d                   	pop    %ebp
  801ba7:	c3                   	ret    

00801ba8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
  801bab:	83 ec 04             	sub    $0x4,%esp
  801bae:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bb4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	52                   	push   %edx
  801bc0:	ff 75 0c             	pushl  0xc(%ebp)
  801bc3:	50                   	push   %eax
  801bc4:	6a 00                	push   $0x0
  801bc6:	e8 b2 ff ff ff       	call   801b7d <syscall>
  801bcb:	83 c4 18             	add    $0x18,%esp
}
  801bce:	90                   	nop
  801bcf:	c9                   	leave  
  801bd0:	c3                   	ret    

00801bd1 <sys_cgetc>:

int
sys_cgetc(void)
{
  801bd1:	55                   	push   %ebp
  801bd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 01                	push   $0x1
  801be0:	e8 98 ff ff ff       	call   801b7d <syscall>
  801be5:	83 c4 18             	add    $0x18,%esp
}
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bed:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	50                   	push   %eax
  801bf9:	6a 05                	push   $0x5
  801bfb:	e8 7d ff ff ff       	call   801b7d <syscall>
  801c00:	83 c4 18             	add    $0x18,%esp
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 02                	push   $0x2
  801c14:	e8 64 ff ff ff       	call   801b7d <syscall>
  801c19:	83 c4 18             	add    $0x18,%esp
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 03                	push   $0x3
  801c2d:	e8 4b ff ff ff       	call   801b7d <syscall>
  801c32:	83 c4 18             	add    $0x18,%esp
}
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 04                	push   $0x4
  801c46:	e8 32 ff ff ff       	call   801b7d <syscall>
  801c4b:	83 c4 18             	add    $0x18,%esp
}
  801c4e:	c9                   	leave  
  801c4f:	c3                   	ret    

00801c50 <sys_env_exit>:


void sys_env_exit(void)
{
  801c50:	55                   	push   %ebp
  801c51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 06                	push   $0x6
  801c5f:	e8 19 ff ff ff       	call   801b7d <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
}
  801c67:	90                   	nop
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c70:	8b 45 08             	mov    0x8(%ebp),%eax
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	52                   	push   %edx
  801c7a:	50                   	push   %eax
  801c7b:	6a 07                	push   $0x7
  801c7d:	e8 fb fe ff ff       	call   801b7d <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
}
  801c85:	c9                   	leave  
  801c86:	c3                   	ret    

00801c87 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c87:	55                   	push   %ebp
  801c88:	89 e5                	mov    %esp,%ebp
  801c8a:	56                   	push   %esi
  801c8b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c8c:	8b 75 18             	mov    0x18(%ebp),%esi
  801c8f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c92:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c98:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9b:	56                   	push   %esi
  801c9c:	53                   	push   %ebx
  801c9d:	51                   	push   %ecx
  801c9e:	52                   	push   %edx
  801c9f:	50                   	push   %eax
  801ca0:	6a 08                	push   $0x8
  801ca2:	e8 d6 fe ff ff       	call   801b7d <syscall>
  801ca7:	83 c4 18             	add    $0x18,%esp
}
  801caa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cad:	5b                   	pop    %ebx
  801cae:	5e                   	pop    %esi
  801caf:	5d                   	pop    %ebp
  801cb0:	c3                   	ret    

00801cb1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	52                   	push   %edx
  801cc1:	50                   	push   %eax
  801cc2:	6a 09                	push   $0x9
  801cc4:	e8 b4 fe ff ff       	call   801b7d <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	ff 75 0c             	pushl  0xc(%ebp)
  801cda:	ff 75 08             	pushl  0x8(%ebp)
  801cdd:	6a 0a                	push   $0xa
  801cdf:	e8 99 fe ff ff       	call   801b7d <syscall>
  801ce4:	83 c4 18             	add    $0x18,%esp
}
  801ce7:	c9                   	leave  
  801ce8:	c3                   	ret    

00801ce9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ce9:	55                   	push   %ebp
  801cea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 0b                	push   $0xb
  801cf8:	e8 80 fe ff ff       	call   801b7d <syscall>
  801cfd:	83 c4 18             	add    $0x18,%esp
}
  801d00:	c9                   	leave  
  801d01:	c3                   	ret    

00801d02 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d02:	55                   	push   %ebp
  801d03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 0c                	push   $0xc
  801d11:	e8 67 fe ff ff       	call   801b7d <syscall>
  801d16:	83 c4 18             	add    $0x18,%esp
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 0d                	push   $0xd
  801d2a:	e8 4e fe ff ff       	call   801b7d <syscall>
  801d2f:	83 c4 18             	add    $0x18,%esp
}
  801d32:	c9                   	leave  
  801d33:	c3                   	ret    

00801d34 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d34:	55                   	push   %ebp
  801d35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	ff 75 0c             	pushl  0xc(%ebp)
  801d40:	ff 75 08             	pushl  0x8(%ebp)
  801d43:	6a 11                	push   $0x11
  801d45:	e8 33 fe ff ff       	call   801b7d <syscall>
  801d4a:	83 c4 18             	add    $0x18,%esp
	return;
  801d4d:	90                   	nop
}
  801d4e:	c9                   	leave  
  801d4f:	c3                   	ret    

00801d50 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d50:	55                   	push   %ebp
  801d51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	ff 75 0c             	pushl  0xc(%ebp)
  801d5c:	ff 75 08             	pushl  0x8(%ebp)
  801d5f:	6a 12                	push   $0x12
  801d61:	e8 17 fe ff ff       	call   801b7d <syscall>
  801d66:	83 c4 18             	add    $0x18,%esp
	return ;
  801d69:	90                   	nop
}
  801d6a:	c9                   	leave  
  801d6b:	c3                   	ret    

00801d6c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 0e                	push   $0xe
  801d7b:	e8 fd fd ff ff       	call   801b7d <syscall>
  801d80:	83 c4 18             	add    $0x18,%esp
}
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	ff 75 08             	pushl  0x8(%ebp)
  801d93:	6a 0f                	push   $0xf
  801d95:	e8 e3 fd ff ff       	call   801b7d <syscall>
  801d9a:	83 c4 18             	add    $0x18,%esp
}
  801d9d:	c9                   	leave  
  801d9e:	c3                   	ret    

00801d9f <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d9f:	55                   	push   %ebp
  801da0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 10                	push   $0x10
  801dae:	e8 ca fd ff ff       	call   801b7d <syscall>
  801db3:	83 c4 18             	add    $0x18,%esp
}
  801db6:	90                   	nop
  801db7:	c9                   	leave  
  801db8:	c3                   	ret    

00801db9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801db9:	55                   	push   %ebp
  801dba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 14                	push   $0x14
  801dc8:	e8 b0 fd ff ff       	call   801b7d <syscall>
  801dcd:	83 c4 18             	add    $0x18,%esp
}
  801dd0:	90                   	nop
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 15                	push   $0x15
  801de2:	e8 96 fd ff ff       	call   801b7d <syscall>
  801de7:	83 c4 18             	add    $0x18,%esp
}
  801dea:	90                   	nop
  801deb:	c9                   	leave  
  801dec:	c3                   	ret    

00801ded <sys_cputc>:


void
sys_cputc(const char c)
{
  801ded:	55                   	push   %ebp
  801dee:	89 e5                	mov    %esp,%ebp
  801df0:	83 ec 04             	sub    $0x4,%esp
  801df3:	8b 45 08             	mov    0x8(%ebp),%eax
  801df6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801df9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	50                   	push   %eax
  801e06:	6a 16                	push   $0x16
  801e08:	e8 70 fd ff ff       	call   801b7d <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
}
  801e10:	90                   	nop
  801e11:	c9                   	leave  
  801e12:	c3                   	ret    

00801e13 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e13:	55                   	push   %ebp
  801e14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 17                	push   $0x17
  801e22:	e8 56 fd ff ff       	call   801b7d <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	90                   	nop
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e30:	8b 45 08             	mov    0x8(%ebp),%eax
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	ff 75 0c             	pushl  0xc(%ebp)
  801e3c:	50                   	push   %eax
  801e3d:	6a 18                	push   $0x18
  801e3f:	e8 39 fd ff ff       	call   801b7d <syscall>
  801e44:	83 c4 18             	add    $0x18,%esp
}
  801e47:	c9                   	leave  
  801e48:	c3                   	ret    

00801e49 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e49:	55                   	push   %ebp
  801e4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	52                   	push   %edx
  801e59:	50                   	push   %eax
  801e5a:	6a 1b                	push   $0x1b
  801e5c:	e8 1c fd ff ff       	call   801b7d <syscall>
  801e61:	83 c4 18             	add    $0x18,%esp
}
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e69:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	52                   	push   %edx
  801e76:	50                   	push   %eax
  801e77:	6a 19                	push   $0x19
  801e79:	e8 ff fc ff ff       	call   801b7d <syscall>
  801e7e:	83 c4 18             	add    $0x18,%esp
}
  801e81:	90                   	nop
  801e82:	c9                   	leave  
  801e83:	c3                   	ret    

00801e84 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e84:	55                   	push   %ebp
  801e85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e87:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	52                   	push   %edx
  801e94:	50                   	push   %eax
  801e95:	6a 1a                	push   $0x1a
  801e97:	e8 e1 fc ff ff       	call   801b7d <syscall>
  801e9c:	83 c4 18             	add    $0x18,%esp
}
  801e9f:	90                   	nop
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
  801ea5:	83 ec 04             	sub    $0x4,%esp
  801ea8:	8b 45 10             	mov    0x10(%ebp),%eax
  801eab:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801eae:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801eb1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb8:	6a 00                	push   $0x0
  801eba:	51                   	push   %ecx
  801ebb:	52                   	push   %edx
  801ebc:	ff 75 0c             	pushl  0xc(%ebp)
  801ebf:	50                   	push   %eax
  801ec0:	6a 1c                	push   $0x1c
  801ec2:	e8 b6 fc ff ff       	call   801b7d <syscall>
  801ec7:	83 c4 18             	add    $0x18,%esp
}
  801eca:	c9                   	leave  
  801ecb:	c3                   	ret    

00801ecc <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ecc:	55                   	push   %ebp
  801ecd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ecf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	52                   	push   %edx
  801edc:	50                   	push   %eax
  801edd:	6a 1d                	push   $0x1d
  801edf:	e8 99 fc ff ff       	call   801b7d <syscall>
  801ee4:	83 c4 18             	add    $0x18,%esp
}
  801ee7:	c9                   	leave  
  801ee8:	c3                   	ret    

00801ee9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ee9:	55                   	push   %ebp
  801eea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801eec:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eef:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	51                   	push   %ecx
  801efa:	52                   	push   %edx
  801efb:	50                   	push   %eax
  801efc:	6a 1e                	push   $0x1e
  801efe:	e8 7a fc ff ff       	call   801b7d <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
}
  801f06:	c9                   	leave  
  801f07:	c3                   	ret    

00801f08 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f08:	55                   	push   %ebp
  801f09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	52                   	push   %edx
  801f18:	50                   	push   %eax
  801f19:	6a 1f                	push   $0x1f
  801f1b:	e8 5d fc ff ff       	call   801b7d <syscall>
  801f20:	83 c4 18             	add    $0x18,%esp
}
  801f23:	c9                   	leave  
  801f24:	c3                   	ret    

00801f25 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f25:	55                   	push   %ebp
  801f26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 20                	push   $0x20
  801f34:	e8 44 fc ff ff       	call   801b7d <syscall>
  801f39:	83 c4 18             	add    $0x18,%esp
}
  801f3c:	c9                   	leave  
  801f3d:	c3                   	ret    

00801f3e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f3e:	55                   	push   %ebp
  801f3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f41:	8b 45 08             	mov    0x8(%ebp),%eax
  801f44:	6a 00                	push   $0x0
  801f46:	ff 75 14             	pushl  0x14(%ebp)
  801f49:	ff 75 10             	pushl  0x10(%ebp)
  801f4c:	ff 75 0c             	pushl  0xc(%ebp)
  801f4f:	50                   	push   %eax
  801f50:	6a 21                	push   $0x21
  801f52:	e8 26 fc ff ff       	call   801b7d <syscall>
  801f57:	83 c4 18             	add    $0x18,%esp
}
  801f5a:	c9                   	leave  
  801f5b:	c3                   	ret    

00801f5c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f5c:	55                   	push   %ebp
  801f5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	50                   	push   %eax
  801f6b:	6a 22                	push   $0x22
  801f6d:	e8 0b fc ff ff       	call   801b7d <syscall>
  801f72:	83 c4 18             	add    $0x18,%esp
}
  801f75:	90                   	nop
  801f76:	c9                   	leave  
  801f77:	c3                   	ret    

00801f78 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f78:	55                   	push   %ebp
  801f79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	50                   	push   %eax
  801f87:	6a 23                	push   $0x23
  801f89:	e8 ef fb ff ff       	call   801b7d <syscall>
  801f8e:	83 c4 18             	add    $0x18,%esp
}
  801f91:	90                   	nop
  801f92:	c9                   	leave  
  801f93:	c3                   	ret    

00801f94 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f94:	55                   	push   %ebp
  801f95:	89 e5                	mov    %esp,%ebp
  801f97:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f9a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f9d:	8d 50 04             	lea    0x4(%eax),%edx
  801fa0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	52                   	push   %edx
  801faa:	50                   	push   %eax
  801fab:	6a 24                	push   $0x24
  801fad:	e8 cb fb ff ff       	call   801b7d <syscall>
  801fb2:	83 c4 18             	add    $0x18,%esp
	return result;
  801fb5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fb8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fbb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fbe:	89 01                	mov    %eax,(%ecx)
  801fc0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc6:	c9                   	leave  
  801fc7:	c2 04 00             	ret    $0x4

00801fca <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	ff 75 10             	pushl  0x10(%ebp)
  801fd4:	ff 75 0c             	pushl  0xc(%ebp)
  801fd7:	ff 75 08             	pushl  0x8(%ebp)
  801fda:	6a 13                	push   $0x13
  801fdc:	e8 9c fb ff ff       	call   801b7d <syscall>
  801fe1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe4:	90                   	nop
}
  801fe5:	c9                   	leave  
  801fe6:	c3                   	ret    

00801fe7 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fe7:	55                   	push   %ebp
  801fe8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 25                	push   $0x25
  801ff6:	e8 82 fb ff ff       	call   801b7d <syscall>
  801ffb:	83 c4 18             	add    $0x18,%esp
}
  801ffe:	c9                   	leave  
  801fff:	c3                   	ret    

00802000 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802000:	55                   	push   %ebp
  802001:	89 e5                	mov    %esp,%ebp
  802003:	83 ec 04             	sub    $0x4,%esp
  802006:	8b 45 08             	mov    0x8(%ebp),%eax
  802009:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80200c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	50                   	push   %eax
  802019:	6a 26                	push   $0x26
  80201b:	e8 5d fb ff ff       	call   801b7d <syscall>
  802020:	83 c4 18             	add    $0x18,%esp
	return ;
  802023:	90                   	nop
}
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <rsttst>:
void rsttst()
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 28                	push   $0x28
  802035:	e8 43 fb ff ff       	call   801b7d <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
	return ;
  80203d:	90                   	nop
}
  80203e:	c9                   	leave  
  80203f:	c3                   	ret    

00802040 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802040:	55                   	push   %ebp
  802041:	89 e5                	mov    %esp,%ebp
  802043:	83 ec 04             	sub    $0x4,%esp
  802046:	8b 45 14             	mov    0x14(%ebp),%eax
  802049:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80204c:	8b 55 18             	mov    0x18(%ebp),%edx
  80204f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802053:	52                   	push   %edx
  802054:	50                   	push   %eax
  802055:	ff 75 10             	pushl  0x10(%ebp)
  802058:	ff 75 0c             	pushl  0xc(%ebp)
  80205b:	ff 75 08             	pushl  0x8(%ebp)
  80205e:	6a 27                	push   $0x27
  802060:	e8 18 fb ff ff       	call   801b7d <syscall>
  802065:	83 c4 18             	add    $0x18,%esp
	return ;
  802068:	90                   	nop
}
  802069:	c9                   	leave  
  80206a:	c3                   	ret    

0080206b <chktst>:
void chktst(uint32 n)
{
  80206b:	55                   	push   %ebp
  80206c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	ff 75 08             	pushl  0x8(%ebp)
  802079:	6a 29                	push   $0x29
  80207b:	e8 fd fa ff ff       	call   801b7d <syscall>
  802080:	83 c4 18             	add    $0x18,%esp
	return ;
  802083:	90                   	nop
}
  802084:	c9                   	leave  
  802085:	c3                   	ret    

00802086 <inctst>:

void inctst()
{
  802086:	55                   	push   %ebp
  802087:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 2a                	push   $0x2a
  802095:	e8 e3 fa ff ff       	call   801b7d <syscall>
  80209a:	83 c4 18             	add    $0x18,%esp
	return ;
  80209d:	90                   	nop
}
  80209e:	c9                   	leave  
  80209f:	c3                   	ret    

008020a0 <gettst>:
uint32 gettst()
{
  8020a0:	55                   	push   %ebp
  8020a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 2b                	push   $0x2b
  8020af:	e8 c9 fa ff ff       	call   801b7d <syscall>
  8020b4:	83 c4 18             	add    $0x18,%esp
}
  8020b7:	c9                   	leave  
  8020b8:	c3                   	ret    

008020b9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020b9:	55                   	push   %ebp
  8020ba:	89 e5                	mov    %esp,%ebp
  8020bc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 2c                	push   $0x2c
  8020cb:	e8 ad fa ff ff       	call   801b7d <syscall>
  8020d0:	83 c4 18             	add    $0x18,%esp
  8020d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020d6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020da:	75 07                	jne    8020e3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020dc:	b8 01 00 00 00       	mov    $0x1,%eax
  8020e1:	eb 05                	jmp    8020e8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020e8:	c9                   	leave  
  8020e9:	c3                   	ret    

008020ea <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
  8020ed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 2c                	push   $0x2c
  8020fc:	e8 7c fa ff ff       	call   801b7d <syscall>
  802101:	83 c4 18             	add    $0x18,%esp
  802104:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802107:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80210b:	75 07                	jne    802114 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80210d:	b8 01 00 00 00       	mov    $0x1,%eax
  802112:	eb 05                	jmp    802119 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802114:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
  80211e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	6a 2c                	push   $0x2c
  80212d:	e8 4b fa ff ff       	call   801b7d <syscall>
  802132:	83 c4 18             	add    $0x18,%esp
  802135:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802138:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80213c:	75 07                	jne    802145 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80213e:	b8 01 00 00 00       	mov    $0x1,%eax
  802143:	eb 05                	jmp    80214a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802145:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
  80214f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 2c                	push   $0x2c
  80215e:	e8 1a fa ff ff       	call   801b7d <syscall>
  802163:	83 c4 18             	add    $0x18,%esp
  802166:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802169:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80216d:	75 07                	jne    802176 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80216f:	b8 01 00 00 00       	mov    $0x1,%eax
  802174:	eb 05                	jmp    80217b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802176:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	ff 75 08             	pushl  0x8(%ebp)
  80218b:	6a 2d                	push   $0x2d
  80218d:	e8 eb f9 ff ff       	call   801b7d <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
	return ;
  802195:	90                   	nop
}
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
  80219b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80219c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80219f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a8:	6a 00                	push   $0x0
  8021aa:	53                   	push   %ebx
  8021ab:	51                   	push   %ecx
  8021ac:	52                   	push   %edx
  8021ad:	50                   	push   %eax
  8021ae:	6a 2e                	push   $0x2e
  8021b0:	e8 c8 f9 ff ff       	call   801b7d <syscall>
  8021b5:	83 c4 18             	add    $0x18,%esp
}
  8021b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021bb:	c9                   	leave  
  8021bc:	c3                   	ret    

008021bd <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021bd:	55                   	push   %ebp
  8021be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	52                   	push   %edx
  8021cd:	50                   	push   %eax
  8021ce:	6a 2f                	push   $0x2f
  8021d0:	e8 a8 f9 ff ff       	call   801b7d <syscall>
  8021d5:	83 c4 18             	add    $0x18,%esp
}
  8021d8:	c9                   	leave  
  8021d9:	c3                   	ret    
  8021da:	66 90                	xchg   %ax,%ax

008021dc <__udivdi3>:
  8021dc:	55                   	push   %ebp
  8021dd:	57                   	push   %edi
  8021de:	56                   	push   %esi
  8021df:	53                   	push   %ebx
  8021e0:	83 ec 1c             	sub    $0x1c,%esp
  8021e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021f3:	89 ca                	mov    %ecx,%edx
  8021f5:	89 f8                	mov    %edi,%eax
  8021f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021fb:	85 f6                	test   %esi,%esi
  8021fd:	75 2d                	jne    80222c <__udivdi3+0x50>
  8021ff:	39 cf                	cmp    %ecx,%edi
  802201:	77 65                	ja     802268 <__udivdi3+0x8c>
  802203:	89 fd                	mov    %edi,%ebp
  802205:	85 ff                	test   %edi,%edi
  802207:	75 0b                	jne    802214 <__udivdi3+0x38>
  802209:	b8 01 00 00 00       	mov    $0x1,%eax
  80220e:	31 d2                	xor    %edx,%edx
  802210:	f7 f7                	div    %edi
  802212:	89 c5                	mov    %eax,%ebp
  802214:	31 d2                	xor    %edx,%edx
  802216:	89 c8                	mov    %ecx,%eax
  802218:	f7 f5                	div    %ebp
  80221a:	89 c1                	mov    %eax,%ecx
  80221c:	89 d8                	mov    %ebx,%eax
  80221e:	f7 f5                	div    %ebp
  802220:	89 cf                	mov    %ecx,%edi
  802222:	89 fa                	mov    %edi,%edx
  802224:	83 c4 1c             	add    $0x1c,%esp
  802227:	5b                   	pop    %ebx
  802228:	5e                   	pop    %esi
  802229:	5f                   	pop    %edi
  80222a:	5d                   	pop    %ebp
  80222b:	c3                   	ret    
  80222c:	39 ce                	cmp    %ecx,%esi
  80222e:	77 28                	ja     802258 <__udivdi3+0x7c>
  802230:	0f bd fe             	bsr    %esi,%edi
  802233:	83 f7 1f             	xor    $0x1f,%edi
  802236:	75 40                	jne    802278 <__udivdi3+0x9c>
  802238:	39 ce                	cmp    %ecx,%esi
  80223a:	72 0a                	jb     802246 <__udivdi3+0x6a>
  80223c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802240:	0f 87 9e 00 00 00    	ja     8022e4 <__udivdi3+0x108>
  802246:	b8 01 00 00 00       	mov    $0x1,%eax
  80224b:	89 fa                	mov    %edi,%edx
  80224d:	83 c4 1c             	add    $0x1c,%esp
  802250:	5b                   	pop    %ebx
  802251:	5e                   	pop    %esi
  802252:	5f                   	pop    %edi
  802253:	5d                   	pop    %ebp
  802254:	c3                   	ret    
  802255:	8d 76 00             	lea    0x0(%esi),%esi
  802258:	31 ff                	xor    %edi,%edi
  80225a:	31 c0                	xor    %eax,%eax
  80225c:	89 fa                	mov    %edi,%edx
  80225e:	83 c4 1c             	add    $0x1c,%esp
  802261:	5b                   	pop    %ebx
  802262:	5e                   	pop    %esi
  802263:	5f                   	pop    %edi
  802264:	5d                   	pop    %ebp
  802265:	c3                   	ret    
  802266:	66 90                	xchg   %ax,%ax
  802268:	89 d8                	mov    %ebx,%eax
  80226a:	f7 f7                	div    %edi
  80226c:	31 ff                	xor    %edi,%edi
  80226e:	89 fa                	mov    %edi,%edx
  802270:	83 c4 1c             	add    $0x1c,%esp
  802273:	5b                   	pop    %ebx
  802274:	5e                   	pop    %esi
  802275:	5f                   	pop    %edi
  802276:	5d                   	pop    %ebp
  802277:	c3                   	ret    
  802278:	bd 20 00 00 00       	mov    $0x20,%ebp
  80227d:	89 eb                	mov    %ebp,%ebx
  80227f:	29 fb                	sub    %edi,%ebx
  802281:	89 f9                	mov    %edi,%ecx
  802283:	d3 e6                	shl    %cl,%esi
  802285:	89 c5                	mov    %eax,%ebp
  802287:	88 d9                	mov    %bl,%cl
  802289:	d3 ed                	shr    %cl,%ebp
  80228b:	89 e9                	mov    %ebp,%ecx
  80228d:	09 f1                	or     %esi,%ecx
  80228f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802293:	89 f9                	mov    %edi,%ecx
  802295:	d3 e0                	shl    %cl,%eax
  802297:	89 c5                	mov    %eax,%ebp
  802299:	89 d6                	mov    %edx,%esi
  80229b:	88 d9                	mov    %bl,%cl
  80229d:	d3 ee                	shr    %cl,%esi
  80229f:	89 f9                	mov    %edi,%ecx
  8022a1:	d3 e2                	shl    %cl,%edx
  8022a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022a7:	88 d9                	mov    %bl,%cl
  8022a9:	d3 e8                	shr    %cl,%eax
  8022ab:	09 c2                	or     %eax,%edx
  8022ad:	89 d0                	mov    %edx,%eax
  8022af:	89 f2                	mov    %esi,%edx
  8022b1:	f7 74 24 0c          	divl   0xc(%esp)
  8022b5:	89 d6                	mov    %edx,%esi
  8022b7:	89 c3                	mov    %eax,%ebx
  8022b9:	f7 e5                	mul    %ebp
  8022bb:	39 d6                	cmp    %edx,%esi
  8022bd:	72 19                	jb     8022d8 <__udivdi3+0xfc>
  8022bf:	74 0b                	je     8022cc <__udivdi3+0xf0>
  8022c1:	89 d8                	mov    %ebx,%eax
  8022c3:	31 ff                	xor    %edi,%edi
  8022c5:	e9 58 ff ff ff       	jmp    802222 <__udivdi3+0x46>
  8022ca:	66 90                	xchg   %ax,%ax
  8022cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022d0:	89 f9                	mov    %edi,%ecx
  8022d2:	d3 e2                	shl    %cl,%edx
  8022d4:	39 c2                	cmp    %eax,%edx
  8022d6:	73 e9                	jae    8022c1 <__udivdi3+0xe5>
  8022d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022db:	31 ff                	xor    %edi,%edi
  8022dd:	e9 40 ff ff ff       	jmp    802222 <__udivdi3+0x46>
  8022e2:	66 90                	xchg   %ax,%ax
  8022e4:	31 c0                	xor    %eax,%eax
  8022e6:	e9 37 ff ff ff       	jmp    802222 <__udivdi3+0x46>
  8022eb:	90                   	nop

008022ec <__umoddi3>:
  8022ec:	55                   	push   %ebp
  8022ed:	57                   	push   %edi
  8022ee:	56                   	push   %esi
  8022ef:	53                   	push   %ebx
  8022f0:	83 ec 1c             	sub    $0x1c,%esp
  8022f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802303:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802307:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80230b:	89 f3                	mov    %esi,%ebx
  80230d:	89 fa                	mov    %edi,%edx
  80230f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802313:	89 34 24             	mov    %esi,(%esp)
  802316:	85 c0                	test   %eax,%eax
  802318:	75 1a                	jne    802334 <__umoddi3+0x48>
  80231a:	39 f7                	cmp    %esi,%edi
  80231c:	0f 86 a2 00 00 00    	jbe    8023c4 <__umoddi3+0xd8>
  802322:	89 c8                	mov    %ecx,%eax
  802324:	89 f2                	mov    %esi,%edx
  802326:	f7 f7                	div    %edi
  802328:	89 d0                	mov    %edx,%eax
  80232a:	31 d2                	xor    %edx,%edx
  80232c:	83 c4 1c             	add    $0x1c,%esp
  80232f:	5b                   	pop    %ebx
  802330:	5e                   	pop    %esi
  802331:	5f                   	pop    %edi
  802332:	5d                   	pop    %ebp
  802333:	c3                   	ret    
  802334:	39 f0                	cmp    %esi,%eax
  802336:	0f 87 ac 00 00 00    	ja     8023e8 <__umoddi3+0xfc>
  80233c:	0f bd e8             	bsr    %eax,%ebp
  80233f:	83 f5 1f             	xor    $0x1f,%ebp
  802342:	0f 84 ac 00 00 00    	je     8023f4 <__umoddi3+0x108>
  802348:	bf 20 00 00 00       	mov    $0x20,%edi
  80234d:	29 ef                	sub    %ebp,%edi
  80234f:	89 fe                	mov    %edi,%esi
  802351:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802355:	89 e9                	mov    %ebp,%ecx
  802357:	d3 e0                	shl    %cl,%eax
  802359:	89 d7                	mov    %edx,%edi
  80235b:	89 f1                	mov    %esi,%ecx
  80235d:	d3 ef                	shr    %cl,%edi
  80235f:	09 c7                	or     %eax,%edi
  802361:	89 e9                	mov    %ebp,%ecx
  802363:	d3 e2                	shl    %cl,%edx
  802365:	89 14 24             	mov    %edx,(%esp)
  802368:	89 d8                	mov    %ebx,%eax
  80236a:	d3 e0                	shl    %cl,%eax
  80236c:	89 c2                	mov    %eax,%edx
  80236e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802372:	d3 e0                	shl    %cl,%eax
  802374:	89 44 24 04          	mov    %eax,0x4(%esp)
  802378:	8b 44 24 08          	mov    0x8(%esp),%eax
  80237c:	89 f1                	mov    %esi,%ecx
  80237e:	d3 e8                	shr    %cl,%eax
  802380:	09 d0                	or     %edx,%eax
  802382:	d3 eb                	shr    %cl,%ebx
  802384:	89 da                	mov    %ebx,%edx
  802386:	f7 f7                	div    %edi
  802388:	89 d3                	mov    %edx,%ebx
  80238a:	f7 24 24             	mull   (%esp)
  80238d:	89 c6                	mov    %eax,%esi
  80238f:	89 d1                	mov    %edx,%ecx
  802391:	39 d3                	cmp    %edx,%ebx
  802393:	0f 82 87 00 00 00    	jb     802420 <__umoddi3+0x134>
  802399:	0f 84 91 00 00 00    	je     802430 <__umoddi3+0x144>
  80239f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023a3:	29 f2                	sub    %esi,%edx
  8023a5:	19 cb                	sbb    %ecx,%ebx
  8023a7:	89 d8                	mov    %ebx,%eax
  8023a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023ad:	d3 e0                	shl    %cl,%eax
  8023af:	89 e9                	mov    %ebp,%ecx
  8023b1:	d3 ea                	shr    %cl,%edx
  8023b3:	09 d0                	or     %edx,%eax
  8023b5:	89 e9                	mov    %ebp,%ecx
  8023b7:	d3 eb                	shr    %cl,%ebx
  8023b9:	89 da                	mov    %ebx,%edx
  8023bb:	83 c4 1c             	add    $0x1c,%esp
  8023be:	5b                   	pop    %ebx
  8023bf:	5e                   	pop    %esi
  8023c0:	5f                   	pop    %edi
  8023c1:	5d                   	pop    %ebp
  8023c2:	c3                   	ret    
  8023c3:	90                   	nop
  8023c4:	89 fd                	mov    %edi,%ebp
  8023c6:	85 ff                	test   %edi,%edi
  8023c8:	75 0b                	jne    8023d5 <__umoddi3+0xe9>
  8023ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8023cf:	31 d2                	xor    %edx,%edx
  8023d1:	f7 f7                	div    %edi
  8023d3:	89 c5                	mov    %eax,%ebp
  8023d5:	89 f0                	mov    %esi,%eax
  8023d7:	31 d2                	xor    %edx,%edx
  8023d9:	f7 f5                	div    %ebp
  8023db:	89 c8                	mov    %ecx,%eax
  8023dd:	f7 f5                	div    %ebp
  8023df:	89 d0                	mov    %edx,%eax
  8023e1:	e9 44 ff ff ff       	jmp    80232a <__umoddi3+0x3e>
  8023e6:	66 90                	xchg   %ax,%ax
  8023e8:	89 c8                	mov    %ecx,%eax
  8023ea:	89 f2                	mov    %esi,%edx
  8023ec:	83 c4 1c             	add    $0x1c,%esp
  8023ef:	5b                   	pop    %ebx
  8023f0:	5e                   	pop    %esi
  8023f1:	5f                   	pop    %edi
  8023f2:	5d                   	pop    %ebp
  8023f3:	c3                   	ret    
  8023f4:	3b 04 24             	cmp    (%esp),%eax
  8023f7:	72 06                	jb     8023ff <__umoddi3+0x113>
  8023f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023fd:	77 0f                	ja     80240e <__umoddi3+0x122>
  8023ff:	89 f2                	mov    %esi,%edx
  802401:	29 f9                	sub    %edi,%ecx
  802403:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802407:	89 14 24             	mov    %edx,(%esp)
  80240a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80240e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802412:	8b 14 24             	mov    (%esp),%edx
  802415:	83 c4 1c             	add    $0x1c,%esp
  802418:	5b                   	pop    %ebx
  802419:	5e                   	pop    %esi
  80241a:	5f                   	pop    %edi
  80241b:	5d                   	pop    %ebp
  80241c:	c3                   	ret    
  80241d:	8d 76 00             	lea    0x0(%esi),%esi
  802420:	2b 04 24             	sub    (%esp),%eax
  802423:	19 fa                	sbb    %edi,%edx
  802425:	89 d1                	mov    %edx,%ecx
  802427:	89 c6                	mov    %eax,%esi
  802429:	e9 71 ff ff ff       	jmp    80239f <__umoddi3+0xb3>
  80242e:	66 90                	xchg   %ax,%ax
  802430:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802434:	72 ea                	jb     802420 <__umoddi3+0x134>
  802436:	89 d9                	mov    %ebx,%ecx
  802438:	e9 62 ff ff ff       	jmp    80239f <__umoddi3+0xb3>
