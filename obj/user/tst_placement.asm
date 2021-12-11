
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 db 05 00 00       	call   800611 <libmain>
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
  80003e:	81 ec bc 00 00 01    	sub    $0x10000bc,%esp

	//	cprintf("envID = %d\n",envID);
	char arr[PAGE_SIZE*1024*4];

	uint32 actual_active_list[2] = {0x1,0x2};
  800044:	c7 85 9c ff ff fe 01 	movl   $0x1,-0x1000064(%ebp)
  80004b:	00 00 00 
  80004e:	c7 85 a0 ff ff fe 02 	movl   $0x2,-0x1000060(%ebp)
  800055:	00 00 00 
	uint32 actual_second_list[3] = {0x3,0x4, 0x5};
  800058:	8d 85 90 ff ff fe    	lea    -0x1000070(%ebp),%eax
  80005e:	bb c0 22 80 00       	mov    $0x8022c0,%ebx
  800063:	ba 03 00 00 00       	mov    $0x3,%edx
  800068:	89 c7                	mov    %eax,%edi
  80006a:	89 de                	mov    %ebx,%esi
  80006c:	89 d1                	mov    %edx,%ecx
  80006e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 2, 3);
  800070:	6a 03                	push   $0x3
  800072:	6a 02                	push   $0x2
  800074:	8d 85 90 ff ff fe    	lea    -0x1000070(%ebp),%eax
  80007a:	50                   	push   %eax
  80007b:	8d 85 9c ff ff fe    	lea    -0x1000064(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 16 1d 00 00       	call   801d9d <sys_check_LRU_lists>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(check == 0)
  80008d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800091:	75 14                	jne    8000a7 <_main+0x6f>
		panic("LRU lists entries are not correct, check your logic again!!");
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 60 20 80 00       	push   $0x802060
  80009b:	6a 11                	push   $0x11
  80009d:	68 9c 20 80 00       	push   $0x80209c
  8000a2:	e8 af 06 00 00       	call   800756 <_panic>
	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b2:	8b 00                	mov    (%eax),%eax
  8000b4:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000bf:	3d 00 00 20 00       	cmp    $0x200000,%eax
  8000c4:	74 14                	je     8000da <_main+0xa2>
  8000c6:	83 ec 04             	sub    $0x4,%esp
  8000c9:	68 b4 20 80 00       	push   $0x8020b4
  8000ce:	6a 14                	push   $0x14
  8000d0:	68 9c 20 80 00       	push   $0x80209c
  8000d5:	e8 7c 06 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000da:	a1 20 30 80 00       	mov    0x803020,%eax
  8000df:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e5:	83 c0 10             	add    $0x10,%eax
  8000e8:	8b 00                	mov    (%eax),%eax
  8000ea:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f5:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000fa:	74 14                	je     800110 <_main+0xd8>
  8000fc:	83 ec 04             	sub    $0x4,%esp
  8000ff:	68 b4 20 80 00       	push   $0x8020b4
  800104:	6a 15                	push   $0x15
  800106:	68 9c 20 80 00       	push   $0x80209c
  80010b:	e8 46 06 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800110:	a1 20 30 80 00       	mov    0x803020,%eax
  800115:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011b:	83 c0 20             	add    $0x20,%eax
  80011e:	8b 00                	mov    (%eax),%eax
  800120:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800123:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800126:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012b:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800130:	74 14                	je     800146 <_main+0x10e>
  800132:	83 ec 04             	sub    $0x4,%esp
  800135:	68 b4 20 80 00       	push   $0x8020b4
  80013a:	6a 16                	push   $0x16
  80013c:	68 9c 20 80 00       	push   $0x80209c
  800141:	e8 10 06 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800146:	a1 20 30 80 00       	mov    0x803020,%eax
  80014b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800151:	83 c0 30             	add    $0x30,%eax
  800154:	8b 00                	mov    (%eax),%eax
  800156:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800159:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80015c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800161:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800166:	74 14                	je     80017c <_main+0x144>
  800168:	83 ec 04             	sub    $0x4,%esp
  80016b:	68 b4 20 80 00       	push   $0x8020b4
  800170:	6a 17                	push   $0x17
  800172:	68 9c 20 80 00       	push   $0x80209c
  800177:	e8 da 05 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017c:	a1 20 30 80 00       	mov    0x803020,%eax
  800181:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800187:	83 c0 40             	add    $0x40,%eax
  80018a:	8b 00                	mov    (%eax),%eax
  80018c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80018f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800192:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800197:	3d 00 40 20 00       	cmp    $0x204000,%eax
  80019c:	74 14                	je     8001b2 <_main+0x17a>
  80019e:	83 ec 04             	sub    $0x4,%esp
  8001a1:	68 b4 20 80 00       	push   $0x8020b4
  8001a6:	6a 18                	push   $0x18
  8001a8:	68 9c 20 80 00       	push   $0x80209c
  8001ad:	e8 a4 05 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001bd:	83 c0 50             	add    $0x50,%eax
  8001c0:	8b 00                	mov    (%eax),%eax
  8001c2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8001c5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001cd:	3d 00 50 20 00       	cmp    $0x205000,%eax
  8001d2:	74 14                	je     8001e8 <_main+0x1b0>
  8001d4:	83 ec 04             	sub    $0x4,%esp
  8001d7:	68 b4 20 80 00       	push   $0x8020b4
  8001dc:	6a 19                	push   $0x19
  8001de:	68 9c 20 80 00       	push   $0x80209c
  8001e3:	e8 6e 05 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x206000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ed:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f3:	83 c0 60             	add    $0x60,%eax
  8001f6:	8b 00                	mov    (%eax),%eax
  8001f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001fb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001fe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800203:	3d 00 60 20 00       	cmp    $0x206000,%eax
  800208:	74 14                	je     80021e <_main+0x1e6>
  80020a:	83 ec 04             	sub    $0x4,%esp
  80020d:	68 b4 20 80 00       	push   $0x8020b4
  800212:	6a 1a                	push   $0x1a
  800214:	68 9c 20 80 00       	push   $0x80209c
  800219:	e8 38 05 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80021e:	a1 20 30 80 00       	mov    0x803020,%eax
  800223:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800229:	83 c0 70             	add    $0x70,%eax
  80022c:	8b 00                	mov    (%eax),%eax
  80022e:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800231:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800234:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800239:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80023e:	74 14                	je     800254 <_main+0x21c>
  800240:	83 ec 04             	sub    $0x4,%esp
  800243:	68 b4 20 80 00       	push   $0x8020b4
  800248:	6a 1b                	push   $0x1b
  80024a:	68 9c 20 80 00       	push   $0x80209c
  80024f:	e8 02 05 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800254:	a1 20 30 80 00       	mov    0x803020,%eax
  800259:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80025f:	83 e8 80             	sub    $0xffffff80,%eax
  800262:	8b 00                	mov    (%eax),%eax
  800264:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800267:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80026a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80026f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800274:	74 14                	je     80028a <_main+0x252>
  800276:	83 ec 04             	sub    $0x4,%esp
  800279:	68 b4 20 80 00       	push   $0x8020b4
  80027e:	6a 1c                	push   $0x1c
  800280:	68 9c 20 80 00       	push   $0x80209c
  800285:	e8 cc 04 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80028a:	a1 20 30 80 00       	mov    0x803020,%eax
  80028f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800295:	05 90 00 00 00       	add    $0x90,%eax
  80029a:	8b 00                	mov    (%eax),%eax
  80029c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80029f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8002a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002a7:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8002ac:	74 14                	je     8002c2 <_main+0x28a>
  8002ae:	83 ec 04             	sub    $0x4,%esp
  8002b1:	68 b4 20 80 00       	push   $0x8020b4
  8002b6:	6a 1d                	push   $0x1d
  8002b8:	68 9c 20 80 00       	push   $0x80209c
  8002bd:	e8 94 04 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002cd:	05 a0 00 00 00       	add    $0xa0,%eax
  8002d2:	8b 00                	mov    (%eax),%eax
  8002d4:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002d7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002df:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 b4 20 80 00       	push   $0x8020b4
  8002ee:	6a 1e                	push   $0x1e
  8002f0:	68 9c 20 80 00       	push   $0x80209c
  8002f5:	e8 5c 04 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ff:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800305:	05 b0 00 00 00       	add    $0xb0,%eax
  80030a:	8b 00                	mov    (%eax),%eax
  80030c:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80030f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800312:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800317:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80031c:	74 14                	je     800332 <_main+0x2fa>
  80031e:	83 ec 04             	sub    $0x4,%esp
  800321:	68 b4 20 80 00       	push   $0x8020b4
  800326:	6a 1f                	push   $0x1f
  800328:	68 9c 20 80 00       	push   $0x80209c
  80032d:	e8 24 04 00 00       	call   800756 <_panic>

		for (int k = 12; k < 20; k++)
  800332:	c7 45 e4 0c 00 00 00 	movl   $0xc,-0x1c(%ebp)
  800339:	eb 31                	jmp    80036c <_main+0x334>
			if( myEnv->__uptr_pws[k].empty !=  1)
  80033b:	a1 20 30 80 00       	mov    0x803020,%eax
  800340:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800346:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800349:	c1 e2 04             	shl    $0x4,%edx
  80034c:	01 d0                	add    %edx,%eax
  80034e:	8a 40 04             	mov    0x4(%eax),%al
  800351:	3c 01                	cmp    $0x1,%al
  800353:	74 14                	je     800369 <_main+0x331>
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800355:	83 ec 04             	sub    $0x4,%esp
  800358:	68 b4 20 80 00       	push   $0x8020b4
  80035d:	6a 23                	push   $0x23
  80035f:	68 9c 20 80 00       	push   $0x80209c
  800364:	e8 ed 03 00 00       	call   800756 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		for (int k = 12; k < 20; k++)
  800369:	ff 45 e4             	incl   -0x1c(%ebp)
  80036c:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  800370:	7e c9                	jle    80033b <_main+0x303>
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if( myEnv->page_last_WS_index !=  12)  											panic("INITIAL PAGE last index checking failed! Review size of the WS..!!");
		/*====================================*/
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800372:	e8 fa 15 00 00       	call   801971 <sys_pf_calculate_allocated_pages>
  800377:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int freePages = sys_calculate_free_frames();
  80037a:	e8 6f 15 00 00       	call   8018ee <sys_calculate_free_frames>
  80037f:	89 45 a4             	mov    %eax,-0x5c(%ebp)

	int i=0;
  800382:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800389:	eb 11                	jmp    80039c <_main+0x364>
	{
		arr[i] = -1;
  80038b:	8d 95 a4 ff ff fe    	lea    -0x100005c(%ebp),%edx
  800391:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800394:	01 d0                	add    %edx,%eax
  800396:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800399:	ff 45 e0             	incl   -0x20(%ebp)
  80039c:	81 7d e0 00 10 00 00 	cmpl   $0x1000,-0x20(%ebp)
  8003a3:	7e e6                	jle    80038b <_main+0x353>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  8003a5:	c7 45 e0 00 00 40 00 	movl   $0x400000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  8003ac:	eb 11                	jmp    8003bf <_main+0x387>
	{
		arr[i] = -1;
  8003ae:	8d 95 a4 ff ff fe    	lea    -0x100005c(%ebp),%edx
  8003b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b7:	01 d0                	add    %edx,%eax
  8003b9:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  8003bc:	ff 45 e0             	incl   -0x20(%ebp)
  8003bf:	81 7d e0 00 10 40 00 	cmpl   $0x401000,-0x20(%ebp)
  8003c6:	7e e6                	jle    8003ae <_main+0x376>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  8003c8:	c7 45 e0 00 00 80 00 	movl   $0x800000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  8003cf:	eb 11                	jmp    8003e2 <_main+0x3aa>
	{
		arr[i] = -1;
  8003d1:	8d 95 a4 ff ff fe    	lea    -0x100005c(%ebp),%edx
  8003d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003da:	01 d0                	add    %edx,%eax
  8003dc:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  8003df:	ff 45 e0             	incl   -0x20(%ebp)
  8003e2:	81 7d e0 00 10 80 00 	cmpl   $0x801000,-0x20(%ebp)
  8003e9:	7e e6                	jle    8003d1 <_main+0x399>
		arr[i] = -1;
	}



	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  8003eb:	83 ec 0c             	sub    $0xc,%esp
  8003ee:	68 f8 20 80 00       	push   $0x8020f8
  8003f3:	e8 00 06 00 00       	call   8009f8 <cprintf>
  8003f8:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  8003fb:	8a 85 a4 ff ff fe    	mov    -0x100005c(%ebp),%al
  800401:	3c ff                	cmp    $0xff,%al
  800403:	74 14                	je     800419 <_main+0x3e1>
  800405:	83 ec 04             	sub    $0x4,%esp
  800408:	68 28 21 80 00       	push   $0x802128
  80040d:	6a 43                	push   $0x43
  80040f:	68 9c 20 80 00       	push   $0x80209c
  800414:	e8 3d 03 00 00       	call   800756 <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800419:	8a 85 a4 0f 00 ff    	mov    -0xfff05c(%ebp),%al
  80041f:	3c ff                	cmp    $0xff,%al
  800421:	74 14                	je     800437 <_main+0x3ff>
  800423:	83 ec 04             	sub    $0x4,%esp
  800426:	68 28 21 80 00       	push   $0x802128
  80042b:	6a 44                	push   $0x44
  80042d:	68 9c 20 80 00       	push   $0x80209c
  800432:	e8 1f 03 00 00       	call   800756 <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  800437:	8a 85 a4 ff 3f ff    	mov    -0xc0005c(%ebp),%al
  80043d:	3c ff                	cmp    $0xff,%al
  80043f:	74 14                	je     800455 <_main+0x41d>
  800441:	83 ec 04             	sub    $0x4,%esp
  800444:	68 28 21 80 00       	push   $0x802128
  800449:	6a 46                	push   $0x46
  80044b:	68 9c 20 80 00       	push   $0x80209c
  800450:	e8 01 03 00 00       	call   800756 <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  800455:	8a 85 a4 0f 40 ff    	mov    -0xbff05c(%ebp),%al
  80045b:	3c ff                	cmp    $0xff,%al
  80045d:	74 14                	je     800473 <_main+0x43b>
  80045f:	83 ec 04             	sub    $0x4,%esp
  800462:	68 28 21 80 00       	push   $0x802128
  800467:	6a 47                	push   $0x47
  800469:	68 9c 20 80 00       	push   $0x80209c
  80046e:	e8 e3 02 00 00       	call   800756 <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  800473:	8a 85 a4 ff 7f ff    	mov    -0x80005c(%ebp),%al
  800479:	3c ff                	cmp    $0xff,%al
  80047b:	74 14                	je     800491 <_main+0x459>
  80047d:	83 ec 04             	sub    $0x4,%esp
  800480:	68 28 21 80 00       	push   $0x802128
  800485:	6a 49                	push   $0x49
  800487:	68 9c 20 80 00       	push   $0x80209c
  80048c:	e8 c5 02 00 00       	call   800756 <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800491:	8a 85 a4 0f 80 ff    	mov    -0x7ff05c(%ebp),%al
  800497:	3c ff                	cmp    $0xff,%al
  800499:	74 14                	je     8004af <_main+0x477>
  80049b:	83 ec 04             	sub    $0x4,%esp
  80049e:	68 28 21 80 00       	push   $0x802128
  8004a3:	6a 4a                	push   $0x4a
  8004a5:	68 9c 20 80 00       	push   $0x80209c
  8004aa:	e8 a7 02 00 00       	call   800756 <_panic>


		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  8004af:	e8 bd 14 00 00       	call   801971 <sys_pf_calculate_allocated_pages>
  8004b4:	2b 45 a8             	sub    -0x58(%ebp),%eax
  8004b7:	83 f8 05             	cmp    $0x5,%eax
  8004ba:	74 14                	je     8004d0 <_main+0x498>
  8004bc:	83 ec 04             	sub    $0x4,%esp
  8004bf:	68 48 21 80 00       	push   $0x802148
  8004c4:	6a 4d                	push   $0x4d
  8004c6:	68 9c 20 80 00       	push   $0x80209c
  8004cb:	e8 86 02 00 00       	call   800756 <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  8004d0:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
  8004d3:	e8 16 14 00 00       	call   8018ee <sys_calculate_free_frames>
  8004d8:	29 c3                	sub    %eax,%ebx
  8004da:	89 d8                	mov    %ebx,%eax
  8004dc:	83 f8 09             	cmp    $0x9,%eax
  8004df:	74 14                	je     8004f5 <_main+0x4bd>
  8004e1:	83 ec 04             	sub    $0x4,%esp
  8004e4:	68 78 21 80 00       	push   $0x802178
  8004e9:	6a 4f                	push   $0x4f
  8004eb:	68 9c 20 80 00       	push   $0x80209c
  8004f0:	e8 61 02 00 00       	call   800756 <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  8004f5:	83 ec 0c             	sub    $0xc,%esp
  8004f8:	68 98 21 80 00       	push   $0x802198
  8004fd:	e8 f6 04 00 00       	call   8009f8 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp


	uint32 expectedPages[20] = {0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000, 0, 0};
  800505:	8d 85 40 ff ff fe    	lea    -0x10000c0(%ebp),%eax
  80050b:	bb e0 22 80 00       	mov    $0x8022e0,%ebx
  800510:	ba 14 00 00 00       	mov    $0x14,%edx
  800515:	89 c7                	mov    %eax,%edi
  800517:	89 de                	mov    %ebx,%esi
  800519:	89 d1                	mov    %edx,%ecx
  80051b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	cprintf("STEP B: checking WS entries ...\n");
  80051d:	83 ec 0c             	sub    $0xc,%esp
  800520:	68 cc 21 80 00       	push   $0x8021cc
  800525:	e8 ce 04 00 00       	call   8009f8 <cprintf>
  80052a:	83 c4 10             	add    $0x10,%esp
	{
		CheckWSWithoutLastIndex(expectedPages, 20);
  80052d:	83 ec 08             	sub    $0x8,%esp
  800530:	6a 14                	push   $0x14
  800532:	8d 85 40 ff ff fe    	lea    -0x10000c0(%ebp),%eax
  800538:	50                   	push   %eax
  800539:	e8 8a 02 00 00       	call   8007c8 <CheckWSWithoutLastIndex>
  80053e:	83 c4 10             	add    $0x10,%esp
	//		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=  0xedffd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xedffe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=  0xee3fd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=  0xee3fe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
}
cprintf("STEP B passed: WS entries test are correct\n\n\n");
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	68 f0 21 80 00       	push   $0x8021f0
  800549:	e8 aa 04 00 00       	call   8009f8 <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp

cprintf("STEP C: checking working sets WHEN BECOMES FULL...\n");
  800551:	83 ec 0c             	sub    $0xc,%esp
  800554:	68 20 22 80 00       	push   $0x802220
  800559:	e8 9a 04 00 00       	call   8009f8 <cprintf>
  80055e:	83 c4 10             	add    $0x10,%esp
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
  800561:	c7 45 e0 00 00 c0 00 	movl   $0xc00000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800568:	eb 11                	jmp    80057b <_main+0x543>
	{
		arr[i] = -1;
  80056a:	8d 95 a4 ff ff fe    	lea    -0x100005c(%ebp),%edx
  800570:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800573:	01 d0                	add    %edx,%eax
  800575:	c6 00 ff             	movb   $0xff,(%eax)
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800578:	ff 45 e0             	incl   -0x20(%ebp)
  80057b:	81 7d e0 00 10 c0 00 	cmpl   $0xc01000,-0x20(%ebp)
  800582:	7e e6                	jle    80056a <_main+0x532>
	{
		arr[i] = -1;
	}

	if( arr[PAGE_SIZE*1024*3] !=  -1)  panic("PLACEMENT of stack page failed");
  800584:	8a 85 a4 ff bf ff    	mov    -0x40005c(%ebp),%al
  80058a:	3c ff                	cmp    $0xff,%al
  80058c:	74 14                	je     8005a2 <_main+0x56a>
  80058e:	83 ec 04             	sub    $0x4,%esp
  800591:	68 28 21 80 00       	push   $0x802128
  800596:	6a 78                	push   $0x78
  800598:	68 9c 20 80 00       	push   $0x80209c
  80059d:	e8 b4 01 00 00       	call   800756 <_panic>
	if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8005a2:	8a 85 a4 0f c0 ff    	mov    -0x3ff05c(%ebp),%al
  8005a8:	3c ff                	cmp    $0xff,%al
  8005aa:	74 14                	je     8005c0 <_main+0x588>
  8005ac:	83 ec 04             	sub    $0x4,%esp
  8005af:	68 28 21 80 00       	push   $0x802128
  8005b4:	6a 79                	push   $0x79
  8005b6:	68 9c 20 80 00       	push   $0x80209c
  8005bb:	e8 96 01 00 00       	call   800756 <_panic>

	expectedPages[18] = 0xee7fd000;
  8005c0:	c7 85 88 ff ff fe 00 	movl   $0xee7fd000,-0x1000078(%ebp)
  8005c7:	d0 7f ee 
	expectedPages[19] = 0xee7fe000;
  8005ca:	c7 85 8c ff ff fe 00 	movl   $0xee7fe000,-0x1000074(%ebp)
  8005d1:	e0 7f ee 

	CheckWSWithoutLastIndex(expectedPages, 20);
  8005d4:	83 ec 08             	sub    $0x8,%esp
  8005d7:	6a 14                	push   $0x14
  8005d9:	8d 85 40 ff ff fe    	lea    -0x10000c0(%ebp),%eax
  8005df:	50                   	push   %eax
  8005e0:	e8 e3 01 00 00       	call   8007c8 <CheckWSWithoutLastIndex>
  8005e5:	83 c4 10             	add    $0x10,%esp

	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 0) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

}
cprintf("STEP C passed: WS is FULL now\n\n\n");
  8005e8:	83 ec 0c             	sub    $0xc,%esp
  8005eb:	68 54 22 80 00       	push   $0x802254
  8005f0:	e8 03 04 00 00       	call   8009f8 <cprintf>
  8005f5:	83 c4 10             	add    $0x10,%esp

cprintf("Congratulations!! Test of PAGE PLACEMENT completed successfully!!\n\n\n");
  8005f8:	83 ec 0c             	sub    $0xc,%esp
  8005fb:	68 78 22 80 00       	push   $0x802278
  800600:	e8 f3 03 00 00       	call   8009f8 <cprintf>
  800605:	83 c4 10             	add    $0x10,%esp
return;
  800608:	90                   	nop
}
  800609:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80060c:	5b                   	pop    %ebx
  80060d:	5e                   	pop    %esi
  80060e:	5f                   	pop    %edi
  80060f:	5d                   	pop    %ebp
  800610:	c3                   	ret    

00800611 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800611:	55                   	push   %ebp
  800612:	89 e5                	mov    %esp,%ebp
  800614:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800617:	e8 07 12 00 00       	call   801823 <sys_getenvindex>
  80061c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80061f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800622:	89 d0                	mov    %edx,%eax
  800624:	c1 e0 03             	shl    $0x3,%eax
  800627:	01 d0                	add    %edx,%eax
  800629:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800630:	01 c8                	add    %ecx,%eax
  800632:	01 c0                	add    %eax,%eax
  800634:	01 d0                	add    %edx,%eax
  800636:	01 c0                	add    %eax,%eax
  800638:	01 d0                	add    %edx,%eax
  80063a:	89 c2                	mov    %eax,%edx
  80063c:	c1 e2 05             	shl    $0x5,%edx
  80063f:	29 c2                	sub    %eax,%edx
  800641:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800648:	89 c2                	mov    %eax,%edx
  80064a:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800650:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800655:	a1 20 30 80 00       	mov    0x803020,%eax
  80065a:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800660:	84 c0                	test   %al,%al
  800662:	74 0f                	je     800673 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800664:	a1 20 30 80 00       	mov    0x803020,%eax
  800669:	05 40 3c 01 00       	add    $0x13c40,%eax
  80066e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800673:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800677:	7e 0a                	jle    800683 <libmain+0x72>
		binaryname = argv[0];
  800679:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800683:	83 ec 08             	sub    $0x8,%esp
  800686:	ff 75 0c             	pushl  0xc(%ebp)
  800689:	ff 75 08             	pushl  0x8(%ebp)
  80068c:	e8 a7 f9 ff ff       	call   800038 <_main>
  800691:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800694:	e8 25 13 00 00       	call   8019be <sys_disable_interrupt>
	cprintf("**************************************\n");
  800699:	83 ec 0c             	sub    $0xc,%esp
  80069c:	68 48 23 80 00       	push   $0x802348
  8006a1:	e8 52 03 00 00       	call   8009f8 <cprintf>
  8006a6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ae:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8006b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b9:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006bf:	83 ec 04             	sub    $0x4,%esp
  8006c2:	52                   	push   %edx
  8006c3:	50                   	push   %eax
  8006c4:	68 70 23 80 00       	push   $0x802370
  8006c9:	e8 2a 03 00 00       	call   8009f8 <cprintf>
  8006ce:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d6:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e1:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006e7:	83 ec 04             	sub    $0x4,%esp
  8006ea:	52                   	push   %edx
  8006eb:	50                   	push   %eax
  8006ec:	68 98 23 80 00       	push   $0x802398
  8006f1:	e8 02 03 00 00       	call   8009f8 <cprintf>
  8006f6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006fe:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800704:	83 ec 08             	sub    $0x8,%esp
  800707:	50                   	push   %eax
  800708:	68 d9 23 80 00       	push   $0x8023d9
  80070d:	e8 e6 02 00 00       	call   8009f8 <cprintf>
  800712:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800715:	83 ec 0c             	sub    $0xc,%esp
  800718:	68 48 23 80 00       	push   $0x802348
  80071d:	e8 d6 02 00 00       	call   8009f8 <cprintf>
  800722:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800725:	e8 ae 12 00 00       	call   8019d8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80072a:	e8 19 00 00 00       	call   800748 <exit>
}
  80072f:	90                   	nop
  800730:	c9                   	leave  
  800731:	c3                   	ret    

00800732 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800732:	55                   	push   %ebp
  800733:	89 e5                	mov    %esp,%ebp
  800735:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800738:	83 ec 0c             	sub    $0xc,%esp
  80073b:	6a 00                	push   $0x0
  80073d:	e8 ad 10 00 00       	call   8017ef <sys_env_destroy>
  800742:	83 c4 10             	add    $0x10,%esp
}
  800745:	90                   	nop
  800746:	c9                   	leave  
  800747:	c3                   	ret    

00800748 <exit>:

void
exit(void)
{
  800748:	55                   	push   %ebp
  800749:	89 e5                	mov    %esp,%ebp
  80074b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80074e:	e8 02 11 00 00       	call   801855 <sys_env_exit>
}
  800753:	90                   	nop
  800754:	c9                   	leave  
  800755:	c3                   	ret    

00800756 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800756:	55                   	push   %ebp
  800757:	89 e5                	mov    %esp,%ebp
  800759:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80075c:	8d 45 10             	lea    0x10(%ebp),%eax
  80075f:	83 c0 04             	add    $0x4,%eax
  800762:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800765:	a1 18 31 80 00       	mov    0x803118,%eax
  80076a:	85 c0                	test   %eax,%eax
  80076c:	74 16                	je     800784 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80076e:	a1 18 31 80 00       	mov    0x803118,%eax
  800773:	83 ec 08             	sub    $0x8,%esp
  800776:	50                   	push   %eax
  800777:	68 f0 23 80 00       	push   $0x8023f0
  80077c:	e8 77 02 00 00       	call   8009f8 <cprintf>
  800781:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800784:	a1 00 30 80 00       	mov    0x803000,%eax
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	ff 75 08             	pushl  0x8(%ebp)
  80078f:	50                   	push   %eax
  800790:	68 f5 23 80 00       	push   $0x8023f5
  800795:	e8 5e 02 00 00       	call   8009f8 <cprintf>
  80079a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80079d:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a0:	83 ec 08             	sub    $0x8,%esp
  8007a3:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a6:	50                   	push   %eax
  8007a7:	e8 e1 01 00 00       	call   80098d <vcprintf>
  8007ac:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	6a 00                	push   $0x0
  8007b4:	68 11 24 80 00       	push   $0x802411
  8007b9:	e8 cf 01 00 00       	call   80098d <vcprintf>
  8007be:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007c1:	e8 82 ff ff ff       	call   800748 <exit>

	// should not return here
	while (1) ;
  8007c6:	eb fe                	jmp    8007c6 <_panic+0x70>

008007c8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007c8:	55                   	push   %ebp
  8007c9:	89 e5                	mov    %esp,%ebp
  8007cb:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d3:	8b 50 74             	mov    0x74(%eax),%edx
  8007d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d9:	39 c2                	cmp    %eax,%edx
  8007db:	74 14                	je     8007f1 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007dd:	83 ec 04             	sub    $0x4,%esp
  8007e0:	68 14 24 80 00       	push   $0x802414
  8007e5:	6a 26                	push   $0x26
  8007e7:	68 60 24 80 00       	push   $0x802460
  8007ec:	e8 65 ff ff ff       	call   800756 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007f8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007ff:	e9 b6 00 00 00       	jmp    8008ba <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800804:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800807:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80080e:	8b 45 08             	mov    0x8(%ebp),%eax
  800811:	01 d0                	add    %edx,%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	85 c0                	test   %eax,%eax
  800817:	75 08                	jne    800821 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800819:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80081c:	e9 96 00 00 00       	jmp    8008b7 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800821:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800828:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80082f:	eb 5d                	jmp    80088e <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800831:	a1 20 30 80 00       	mov    0x803020,%eax
  800836:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80083c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80083f:	c1 e2 04             	shl    $0x4,%edx
  800842:	01 d0                	add    %edx,%eax
  800844:	8a 40 04             	mov    0x4(%eax),%al
  800847:	84 c0                	test   %al,%al
  800849:	75 40                	jne    80088b <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80084b:	a1 20 30 80 00       	mov    0x803020,%eax
  800850:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800856:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800859:	c1 e2 04             	shl    $0x4,%edx
  80085c:	01 d0                	add    %edx,%eax
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800863:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800866:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80086b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80086d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800870:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	01 c8                	add    %ecx,%eax
  80087c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80087e:	39 c2                	cmp    %eax,%edx
  800880:	75 09                	jne    80088b <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800882:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800889:	eb 12                	jmp    80089d <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088b:	ff 45 e8             	incl   -0x18(%ebp)
  80088e:	a1 20 30 80 00       	mov    0x803020,%eax
  800893:	8b 50 74             	mov    0x74(%eax),%edx
  800896:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800899:	39 c2                	cmp    %eax,%edx
  80089b:	77 94                	ja     800831 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80089d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008a1:	75 14                	jne    8008b7 <CheckWSWithoutLastIndex+0xef>
			panic(
  8008a3:	83 ec 04             	sub    $0x4,%esp
  8008a6:	68 6c 24 80 00       	push   $0x80246c
  8008ab:	6a 3a                	push   $0x3a
  8008ad:	68 60 24 80 00       	push   $0x802460
  8008b2:	e8 9f fe ff ff       	call   800756 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008b7:	ff 45 f0             	incl   -0x10(%ebp)
  8008ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008bd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008c0:	0f 8c 3e ff ff ff    	jl     800804 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008c6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008cd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008d4:	eb 20                	jmp    8008f6 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8008db:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008e1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008e4:	c1 e2 04             	shl    $0x4,%edx
  8008e7:	01 d0                	add    %edx,%eax
  8008e9:	8a 40 04             	mov    0x4(%eax),%al
  8008ec:	3c 01                	cmp    $0x1,%al
  8008ee:	75 03                	jne    8008f3 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008f0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f3:	ff 45 e0             	incl   -0x20(%ebp)
  8008f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8008fb:	8b 50 74             	mov    0x74(%eax),%edx
  8008fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800901:	39 c2                	cmp    %eax,%edx
  800903:	77 d1                	ja     8008d6 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800905:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800908:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80090b:	74 14                	je     800921 <CheckWSWithoutLastIndex+0x159>
		panic(
  80090d:	83 ec 04             	sub    $0x4,%esp
  800910:	68 c0 24 80 00       	push   $0x8024c0
  800915:	6a 44                	push   $0x44
  800917:	68 60 24 80 00       	push   $0x802460
  80091c:	e8 35 fe ff ff       	call   800756 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800921:	90                   	nop
  800922:	c9                   	leave  
  800923:	c3                   	ret    

00800924 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800924:	55                   	push   %ebp
  800925:	89 e5                	mov    %esp,%ebp
  800927:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80092a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	8d 48 01             	lea    0x1(%eax),%ecx
  800932:	8b 55 0c             	mov    0xc(%ebp),%edx
  800935:	89 0a                	mov    %ecx,(%edx)
  800937:	8b 55 08             	mov    0x8(%ebp),%edx
  80093a:	88 d1                	mov    %dl,%cl
  80093c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800943:	8b 45 0c             	mov    0xc(%ebp),%eax
  800946:	8b 00                	mov    (%eax),%eax
  800948:	3d ff 00 00 00       	cmp    $0xff,%eax
  80094d:	75 2c                	jne    80097b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80094f:	a0 24 30 80 00       	mov    0x803024,%al
  800954:	0f b6 c0             	movzbl %al,%eax
  800957:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095a:	8b 12                	mov    (%edx),%edx
  80095c:	89 d1                	mov    %edx,%ecx
  80095e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800961:	83 c2 08             	add    $0x8,%edx
  800964:	83 ec 04             	sub    $0x4,%esp
  800967:	50                   	push   %eax
  800968:	51                   	push   %ecx
  800969:	52                   	push   %edx
  80096a:	e8 3e 0e 00 00       	call   8017ad <sys_cputs>
  80096f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800972:	8b 45 0c             	mov    0xc(%ebp),%eax
  800975:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80097b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097e:	8b 40 04             	mov    0x4(%eax),%eax
  800981:	8d 50 01             	lea    0x1(%eax),%edx
  800984:	8b 45 0c             	mov    0xc(%ebp),%eax
  800987:	89 50 04             	mov    %edx,0x4(%eax)
}
  80098a:	90                   	nop
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
  800990:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800996:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80099d:	00 00 00 
	b.cnt = 0;
  8009a0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009a7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	ff 75 08             	pushl  0x8(%ebp)
  8009b0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009b6:	50                   	push   %eax
  8009b7:	68 24 09 80 00       	push   $0x800924
  8009bc:	e8 11 02 00 00       	call   800bd2 <vprintfmt>
  8009c1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009c4:	a0 24 30 80 00       	mov    0x803024,%al
  8009c9:	0f b6 c0             	movzbl %al,%eax
  8009cc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009d2:	83 ec 04             	sub    $0x4,%esp
  8009d5:	50                   	push   %eax
  8009d6:	52                   	push   %edx
  8009d7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009dd:	83 c0 08             	add    $0x8,%eax
  8009e0:	50                   	push   %eax
  8009e1:	e8 c7 0d 00 00       	call   8017ad <sys_cputs>
  8009e6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009e9:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009f0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009f6:	c9                   	leave  
  8009f7:	c3                   	ret    

008009f8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009f8:	55                   	push   %ebp
  8009f9:	89 e5                	mov    %esp,%ebp
  8009fb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009fe:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800a05:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a08:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	83 ec 08             	sub    $0x8,%esp
  800a11:	ff 75 f4             	pushl  -0xc(%ebp)
  800a14:	50                   	push   %eax
  800a15:	e8 73 ff ff ff       	call   80098d <vcprintf>
  800a1a:	83 c4 10             	add    $0x10,%esp
  800a1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a23:	c9                   	leave  
  800a24:	c3                   	ret    

00800a25 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a25:	55                   	push   %ebp
  800a26:	89 e5                	mov    %esp,%ebp
  800a28:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a2b:	e8 8e 0f 00 00       	call   8019be <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a30:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	83 ec 08             	sub    $0x8,%esp
  800a3c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3f:	50                   	push   %eax
  800a40:	e8 48 ff ff ff       	call   80098d <vcprintf>
  800a45:	83 c4 10             	add    $0x10,%esp
  800a48:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a4b:	e8 88 0f 00 00       	call   8019d8 <sys_enable_interrupt>
	return cnt;
  800a50:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a53:	c9                   	leave  
  800a54:	c3                   	ret    

00800a55 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a55:	55                   	push   %ebp
  800a56:	89 e5                	mov    %esp,%ebp
  800a58:	53                   	push   %ebx
  800a59:	83 ec 14             	sub    $0x14,%esp
  800a5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a62:	8b 45 14             	mov    0x14(%ebp),%eax
  800a65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a68:	8b 45 18             	mov    0x18(%ebp),%eax
  800a6b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a70:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a73:	77 55                	ja     800aca <printnum+0x75>
  800a75:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a78:	72 05                	jb     800a7f <printnum+0x2a>
  800a7a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a7d:	77 4b                	ja     800aca <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a7f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a82:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a85:	8b 45 18             	mov    0x18(%ebp),%eax
  800a88:	ba 00 00 00 00       	mov    $0x0,%edx
  800a8d:	52                   	push   %edx
  800a8e:	50                   	push   %eax
  800a8f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a92:	ff 75 f0             	pushl  -0x10(%ebp)
  800a95:	e8 46 13 00 00       	call   801de0 <__udivdi3>
  800a9a:	83 c4 10             	add    $0x10,%esp
  800a9d:	83 ec 04             	sub    $0x4,%esp
  800aa0:	ff 75 20             	pushl  0x20(%ebp)
  800aa3:	53                   	push   %ebx
  800aa4:	ff 75 18             	pushl  0x18(%ebp)
  800aa7:	52                   	push   %edx
  800aa8:	50                   	push   %eax
  800aa9:	ff 75 0c             	pushl  0xc(%ebp)
  800aac:	ff 75 08             	pushl  0x8(%ebp)
  800aaf:	e8 a1 ff ff ff       	call   800a55 <printnum>
  800ab4:	83 c4 20             	add    $0x20,%esp
  800ab7:	eb 1a                	jmp    800ad3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ab9:	83 ec 08             	sub    $0x8,%esp
  800abc:	ff 75 0c             	pushl  0xc(%ebp)
  800abf:	ff 75 20             	pushl  0x20(%ebp)
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	ff d0                	call   *%eax
  800ac7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aca:	ff 4d 1c             	decl   0x1c(%ebp)
  800acd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ad1:	7f e6                	jg     800ab9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ad3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ad6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ade:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ae1:	53                   	push   %ebx
  800ae2:	51                   	push   %ecx
  800ae3:	52                   	push   %edx
  800ae4:	50                   	push   %eax
  800ae5:	e8 06 14 00 00       	call   801ef0 <__umoddi3>
  800aea:	83 c4 10             	add    $0x10,%esp
  800aed:	05 34 27 80 00       	add    $0x802734,%eax
  800af2:	8a 00                	mov    (%eax),%al
  800af4:	0f be c0             	movsbl %al,%eax
  800af7:	83 ec 08             	sub    $0x8,%esp
  800afa:	ff 75 0c             	pushl  0xc(%ebp)
  800afd:	50                   	push   %eax
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	ff d0                	call   *%eax
  800b03:	83 c4 10             	add    $0x10,%esp
}
  800b06:	90                   	nop
  800b07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b0a:	c9                   	leave  
  800b0b:	c3                   	ret    

00800b0c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b0c:	55                   	push   %ebp
  800b0d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b0f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b13:	7e 1c                	jle    800b31 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	8b 00                	mov    (%eax),%eax
  800b1a:	8d 50 08             	lea    0x8(%eax),%edx
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	89 10                	mov    %edx,(%eax)
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	8b 00                	mov    (%eax),%eax
  800b27:	83 e8 08             	sub    $0x8,%eax
  800b2a:	8b 50 04             	mov    0x4(%eax),%edx
  800b2d:	8b 00                	mov    (%eax),%eax
  800b2f:	eb 40                	jmp    800b71 <getuint+0x65>
	else if (lflag)
  800b31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b35:	74 1e                	je     800b55 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	8d 50 04             	lea    0x4(%eax),%edx
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	89 10                	mov    %edx,(%eax)
  800b44:	8b 45 08             	mov    0x8(%ebp),%eax
  800b47:	8b 00                	mov    (%eax),%eax
  800b49:	83 e8 04             	sub    $0x4,%eax
  800b4c:	8b 00                	mov    (%eax),%eax
  800b4e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b53:	eb 1c                	jmp    800b71 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	8d 50 04             	lea    0x4(%eax),%edx
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	89 10                	mov    %edx,(%eax)
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	83 e8 04             	sub    $0x4,%eax
  800b6a:	8b 00                	mov    (%eax),%eax
  800b6c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b71:	5d                   	pop    %ebp
  800b72:	c3                   	ret    

00800b73 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b73:	55                   	push   %ebp
  800b74:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b76:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b7a:	7e 1c                	jle    800b98 <getint+0x25>
		return va_arg(*ap, long long);
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8b 00                	mov    (%eax),%eax
  800b81:	8d 50 08             	lea    0x8(%eax),%edx
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	89 10                	mov    %edx,(%eax)
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	8b 00                	mov    (%eax),%eax
  800b8e:	83 e8 08             	sub    $0x8,%eax
  800b91:	8b 50 04             	mov    0x4(%eax),%edx
  800b94:	8b 00                	mov    (%eax),%eax
  800b96:	eb 38                	jmp    800bd0 <getint+0x5d>
	else if (lflag)
  800b98:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9c:	74 1a                	je     800bb8 <getint+0x45>
		return va_arg(*ap, long);
  800b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba1:	8b 00                	mov    (%eax),%eax
  800ba3:	8d 50 04             	lea    0x4(%eax),%edx
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	89 10                	mov    %edx,(%eax)
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	8b 00                	mov    (%eax),%eax
  800bb0:	83 e8 04             	sub    $0x4,%eax
  800bb3:	8b 00                	mov    (%eax),%eax
  800bb5:	99                   	cltd   
  800bb6:	eb 18                	jmp    800bd0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	8d 50 04             	lea    0x4(%eax),%edx
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	89 10                	mov    %edx,(%eax)
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	8b 00                	mov    (%eax),%eax
  800bca:	83 e8 04             	sub    $0x4,%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	99                   	cltd   
}
  800bd0:	5d                   	pop    %ebp
  800bd1:	c3                   	ret    

00800bd2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	56                   	push   %esi
  800bd6:	53                   	push   %ebx
  800bd7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bda:	eb 17                	jmp    800bf3 <vprintfmt+0x21>
			if (ch == '\0')
  800bdc:	85 db                	test   %ebx,%ebx
  800bde:	0f 84 af 03 00 00    	je     800f93 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800be4:	83 ec 08             	sub    $0x8,%esp
  800be7:	ff 75 0c             	pushl  0xc(%ebp)
  800bea:	53                   	push   %ebx
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	ff d0                	call   *%eax
  800bf0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf6:	8d 50 01             	lea    0x1(%eax),%edx
  800bf9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	0f b6 d8             	movzbl %al,%ebx
  800c01:	83 fb 25             	cmp    $0x25,%ebx
  800c04:	75 d6                	jne    800bdc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c06:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c0a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c11:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c18:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c1f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c26:	8b 45 10             	mov    0x10(%ebp),%eax
  800c29:	8d 50 01             	lea    0x1(%eax),%edx
  800c2c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	0f b6 d8             	movzbl %al,%ebx
  800c34:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c37:	83 f8 55             	cmp    $0x55,%eax
  800c3a:	0f 87 2b 03 00 00    	ja     800f6b <vprintfmt+0x399>
  800c40:	8b 04 85 58 27 80 00 	mov    0x802758(,%eax,4),%eax
  800c47:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c49:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c4d:	eb d7                	jmp    800c26 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c4f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c53:	eb d1                	jmp    800c26 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c55:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c5f:	89 d0                	mov    %edx,%eax
  800c61:	c1 e0 02             	shl    $0x2,%eax
  800c64:	01 d0                	add    %edx,%eax
  800c66:	01 c0                	add    %eax,%eax
  800c68:	01 d8                	add    %ebx,%eax
  800c6a:	83 e8 30             	sub    $0x30,%eax
  800c6d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c70:	8b 45 10             	mov    0x10(%ebp),%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c78:	83 fb 2f             	cmp    $0x2f,%ebx
  800c7b:	7e 3e                	jle    800cbb <vprintfmt+0xe9>
  800c7d:	83 fb 39             	cmp    $0x39,%ebx
  800c80:	7f 39                	jg     800cbb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c82:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c85:	eb d5                	jmp    800c5c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c87:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8a:	83 c0 04             	add    $0x4,%eax
  800c8d:	89 45 14             	mov    %eax,0x14(%ebp)
  800c90:	8b 45 14             	mov    0x14(%ebp),%eax
  800c93:	83 e8 04             	sub    $0x4,%eax
  800c96:	8b 00                	mov    (%eax),%eax
  800c98:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c9b:	eb 1f                	jmp    800cbc <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ca1:	79 83                	jns    800c26 <vprintfmt+0x54>
				width = 0;
  800ca3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800caa:	e9 77 ff ff ff       	jmp    800c26 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800caf:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cb6:	e9 6b ff ff ff       	jmp    800c26 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cbb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cbc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cc0:	0f 89 60 ff ff ff    	jns    800c26 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cc9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ccc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cd3:	e9 4e ff ff ff       	jmp    800c26 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cd8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cdb:	e9 46 ff ff ff       	jmp    800c26 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ce0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce3:	83 c0 04             	add    $0x4,%eax
  800ce6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cec:	83 e8 04             	sub    $0x4,%eax
  800cef:	8b 00                	mov    (%eax),%eax
  800cf1:	83 ec 08             	sub    $0x8,%esp
  800cf4:	ff 75 0c             	pushl  0xc(%ebp)
  800cf7:	50                   	push   %eax
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	ff d0                	call   *%eax
  800cfd:	83 c4 10             	add    $0x10,%esp
			break;
  800d00:	e9 89 02 00 00       	jmp    800f8e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d05:	8b 45 14             	mov    0x14(%ebp),%eax
  800d08:	83 c0 04             	add    $0x4,%eax
  800d0b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d11:	83 e8 04             	sub    $0x4,%eax
  800d14:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d16:	85 db                	test   %ebx,%ebx
  800d18:	79 02                	jns    800d1c <vprintfmt+0x14a>
				err = -err;
  800d1a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d1c:	83 fb 64             	cmp    $0x64,%ebx
  800d1f:	7f 0b                	jg     800d2c <vprintfmt+0x15a>
  800d21:	8b 34 9d a0 25 80 00 	mov    0x8025a0(,%ebx,4),%esi
  800d28:	85 f6                	test   %esi,%esi
  800d2a:	75 19                	jne    800d45 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d2c:	53                   	push   %ebx
  800d2d:	68 45 27 80 00       	push   $0x802745
  800d32:	ff 75 0c             	pushl  0xc(%ebp)
  800d35:	ff 75 08             	pushl  0x8(%ebp)
  800d38:	e8 5e 02 00 00       	call   800f9b <printfmt>
  800d3d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d40:	e9 49 02 00 00       	jmp    800f8e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d45:	56                   	push   %esi
  800d46:	68 4e 27 80 00       	push   $0x80274e
  800d4b:	ff 75 0c             	pushl  0xc(%ebp)
  800d4e:	ff 75 08             	pushl  0x8(%ebp)
  800d51:	e8 45 02 00 00       	call   800f9b <printfmt>
  800d56:	83 c4 10             	add    $0x10,%esp
			break;
  800d59:	e9 30 02 00 00       	jmp    800f8e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d61:	83 c0 04             	add    $0x4,%eax
  800d64:	89 45 14             	mov    %eax,0x14(%ebp)
  800d67:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6a:	83 e8 04             	sub    $0x4,%eax
  800d6d:	8b 30                	mov    (%eax),%esi
  800d6f:	85 f6                	test   %esi,%esi
  800d71:	75 05                	jne    800d78 <vprintfmt+0x1a6>
				p = "(null)";
  800d73:	be 51 27 80 00       	mov    $0x802751,%esi
			if (width > 0 && padc != '-')
  800d78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7c:	7e 6d                	jle    800deb <vprintfmt+0x219>
  800d7e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d82:	74 67                	je     800deb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d84:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d87:	83 ec 08             	sub    $0x8,%esp
  800d8a:	50                   	push   %eax
  800d8b:	56                   	push   %esi
  800d8c:	e8 0c 03 00 00       	call   80109d <strnlen>
  800d91:	83 c4 10             	add    $0x10,%esp
  800d94:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d97:	eb 16                	jmp    800daf <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d99:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d9d:	83 ec 08             	sub    $0x8,%esp
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	50                   	push   %eax
  800da4:	8b 45 08             	mov    0x8(%ebp),%eax
  800da7:	ff d0                	call   *%eax
  800da9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dac:	ff 4d e4             	decl   -0x1c(%ebp)
  800daf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db3:	7f e4                	jg     800d99 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db5:	eb 34                	jmp    800deb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800db7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dbb:	74 1c                	je     800dd9 <vprintfmt+0x207>
  800dbd:	83 fb 1f             	cmp    $0x1f,%ebx
  800dc0:	7e 05                	jle    800dc7 <vprintfmt+0x1f5>
  800dc2:	83 fb 7e             	cmp    $0x7e,%ebx
  800dc5:	7e 12                	jle    800dd9 <vprintfmt+0x207>
					putch('?', putdat);
  800dc7:	83 ec 08             	sub    $0x8,%esp
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	6a 3f                	push   $0x3f
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	ff d0                	call   *%eax
  800dd4:	83 c4 10             	add    $0x10,%esp
  800dd7:	eb 0f                	jmp    800de8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dd9:	83 ec 08             	sub    $0x8,%esp
  800ddc:	ff 75 0c             	pushl  0xc(%ebp)
  800ddf:	53                   	push   %ebx
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	ff d0                	call   *%eax
  800de5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800de8:	ff 4d e4             	decl   -0x1c(%ebp)
  800deb:	89 f0                	mov    %esi,%eax
  800ded:	8d 70 01             	lea    0x1(%eax),%esi
  800df0:	8a 00                	mov    (%eax),%al
  800df2:	0f be d8             	movsbl %al,%ebx
  800df5:	85 db                	test   %ebx,%ebx
  800df7:	74 24                	je     800e1d <vprintfmt+0x24b>
  800df9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dfd:	78 b8                	js     800db7 <vprintfmt+0x1e5>
  800dff:	ff 4d e0             	decl   -0x20(%ebp)
  800e02:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e06:	79 af                	jns    800db7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e08:	eb 13                	jmp    800e1d <vprintfmt+0x24b>
				putch(' ', putdat);
  800e0a:	83 ec 08             	sub    $0x8,%esp
  800e0d:	ff 75 0c             	pushl  0xc(%ebp)
  800e10:	6a 20                	push   $0x20
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	ff d0                	call   *%eax
  800e17:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e1a:	ff 4d e4             	decl   -0x1c(%ebp)
  800e1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e21:	7f e7                	jg     800e0a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e23:	e9 66 01 00 00       	jmp    800f8e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e28:	83 ec 08             	sub    $0x8,%esp
  800e2b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e2e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e31:	50                   	push   %eax
  800e32:	e8 3c fd ff ff       	call   800b73 <getint>
  800e37:	83 c4 10             	add    $0x10,%esp
  800e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e3d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e43:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e46:	85 d2                	test   %edx,%edx
  800e48:	79 23                	jns    800e6d <vprintfmt+0x29b>
				putch('-', putdat);
  800e4a:	83 ec 08             	sub    $0x8,%esp
  800e4d:	ff 75 0c             	pushl  0xc(%ebp)
  800e50:	6a 2d                	push   $0x2d
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	ff d0                	call   *%eax
  800e57:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e60:	f7 d8                	neg    %eax
  800e62:	83 d2 00             	adc    $0x0,%edx
  800e65:	f7 da                	neg    %edx
  800e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e6d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e74:	e9 bc 00 00 00       	jmp    800f35 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e79:	83 ec 08             	sub    $0x8,%esp
  800e7c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e7f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e82:	50                   	push   %eax
  800e83:	e8 84 fc ff ff       	call   800b0c <getuint>
  800e88:	83 c4 10             	add    $0x10,%esp
  800e8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e8e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e91:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e98:	e9 98 00 00 00       	jmp    800f35 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e9d:	83 ec 08             	sub    $0x8,%esp
  800ea0:	ff 75 0c             	pushl  0xc(%ebp)
  800ea3:	6a 58                	push   $0x58
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	ff d0                	call   *%eax
  800eaa:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	6a 58                	push   $0x58
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	ff d0                	call   *%eax
  800eba:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 58                	push   $0x58
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			break;
  800ecd:	e9 bc 00 00 00       	jmp    800f8e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ed2:	83 ec 08             	sub    $0x8,%esp
  800ed5:	ff 75 0c             	pushl  0xc(%ebp)
  800ed8:	6a 30                	push   $0x30
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	ff d0                	call   *%eax
  800edf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ee2:	83 ec 08             	sub    $0x8,%esp
  800ee5:	ff 75 0c             	pushl  0xc(%ebp)
  800ee8:	6a 78                	push   $0x78
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	ff d0                	call   *%eax
  800eef:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ef2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef5:	83 c0 04             	add    $0x4,%eax
  800ef8:	89 45 14             	mov    %eax,0x14(%ebp)
  800efb:	8b 45 14             	mov    0x14(%ebp),%eax
  800efe:	83 e8 04             	sub    $0x4,%eax
  800f01:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f0d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f14:	eb 1f                	jmp    800f35 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f16:	83 ec 08             	sub    $0x8,%esp
  800f19:	ff 75 e8             	pushl  -0x18(%ebp)
  800f1c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f1f:	50                   	push   %eax
  800f20:	e8 e7 fb ff ff       	call   800b0c <getuint>
  800f25:	83 c4 10             	add    $0x10,%esp
  800f28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f2e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f35:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f39:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f3c:	83 ec 04             	sub    $0x4,%esp
  800f3f:	52                   	push   %edx
  800f40:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f43:	50                   	push   %eax
  800f44:	ff 75 f4             	pushl  -0xc(%ebp)
  800f47:	ff 75 f0             	pushl  -0x10(%ebp)
  800f4a:	ff 75 0c             	pushl  0xc(%ebp)
  800f4d:	ff 75 08             	pushl  0x8(%ebp)
  800f50:	e8 00 fb ff ff       	call   800a55 <printnum>
  800f55:	83 c4 20             	add    $0x20,%esp
			break;
  800f58:	eb 34                	jmp    800f8e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f5a:	83 ec 08             	sub    $0x8,%esp
  800f5d:	ff 75 0c             	pushl  0xc(%ebp)
  800f60:	53                   	push   %ebx
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	ff d0                	call   *%eax
  800f66:	83 c4 10             	add    $0x10,%esp
			break;
  800f69:	eb 23                	jmp    800f8e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f6b:	83 ec 08             	sub    $0x8,%esp
  800f6e:	ff 75 0c             	pushl  0xc(%ebp)
  800f71:	6a 25                	push   $0x25
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	ff d0                	call   *%eax
  800f78:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f7b:	ff 4d 10             	decl   0x10(%ebp)
  800f7e:	eb 03                	jmp    800f83 <vprintfmt+0x3b1>
  800f80:	ff 4d 10             	decl   0x10(%ebp)
  800f83:	8b 45 10             	mov    0x10(%ebp),%eax
  800f86:	48                   	dec    %eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	3c 25                	cmp    $0x25,%al
  800f8b:	75 f3                	jne    800f80 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f8d:	90                   	nop
		}
	}
  800f8e:	e9 47 fc ff ff       	jmp    800bda <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f93:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f94:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f97:	5b                   	pop    %ebx
  800f98:	5e                   	pop    %esi
  800f99:	5d                   	pop    %ebp
  800f9a:	c3                   	ret    

00800f9b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f9b:	55                   	push   %ebp
  800f9c:	89 e5                	mov    %esp,%ebp
  800f9e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fa1:	8d 45 10             	lea    0x10(%ebp),%eax
  800fa4:	83 c0 04             	add    $0x4,%eax
  800fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800faa:	8b 45 10             	mov    0x10(%ebp),%eax
  800fad:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb0:	50                   	push   %eax
  800fb1:	ff 75 0c             	pushl  0xc(%ebp)
  800fb4:	ff 75 08             	pushl  0x8(%ebp)
  800fb7:	e8 16 fc ff ff       	call   800bd2 <vprintfmt>
  800fbc:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fbf:	90                   	nop
  800fc0:	c9                   	leave  
  800fc1:	c3                   	ret    

00800fc2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fc2:	55                   	push   %ebp
  800fc3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc8:	8b 40 08             	mov    0x8(%eax),%eax
  800fcb:	8d 50 01             	lea    0x1(%eax),%edx
  800fce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd7:	8b 10                	mov    (%eax),%edx
  800fd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdc:	8b 40 04             	mov    0x4(%eax),%eax
  800fdf:	39 c2                	cmp    %eax,%edx
  800fe1:	73 12                	jae    800ff5 <sprintputch+0x33>
		*b->buf++ = ch;
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	8b 00                	mov    (%eax),%eax
  800fe8:	8d 48 01             	lea    0x1(%eax),%ecx
  800feb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fee:	89 0a                	mov    %ecx,(%edx)
  800ff0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ff3:	88 10                	mov    %dl,(%eax)
}
  800ff5:	90                   	nop
  800ff6:	5d                   	pop    %ebp
  800ff7:	c3                   	ret    

00800ff8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ff8:	55                   	push   %ebp
  800ff9:	89 e5                	mov    %esp,%ebp
  800ffb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801004:	8b 45 0c             	mov    0xc(%ebp),%eax
  801007:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	01 d0                	add    %edx,%eax
  80100f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801012:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801019:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80101d:	74 06                	je     801025 <vsnprintf+0x2d>
  80101f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801023:	7f 07                	jg     80102c <vsnprintf+0x34>
		return -E_INVAL;
  801025:	b8 03 00 00 00       	mov    $0x3,%eax
  80102a:	eb 20                	jmp    80104c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80102c:	ff 75 14             	pushl  0x14(%ebp)
  80102f:	ff 75 10             	pushl  0x10(%ebp)
  801032:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801035:	50                   	push   %eax
  801036:	68 c2 0f 80 00       	push   $0x800fc2
  80103b:	e8 92 fb ff ff       	call   800bd2 <vprintfmt>
  801040:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801043:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801046:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801049:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80104c:	c9                   	leave  
  80104d:	c3                   	ret    

0080104e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80104e:	55                   	push   %ebp
  80104f:	89 e5                	mov    %esp,%ebp
  801051:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801054:	8d 45 10             	lea    0x10(%ebp),%eax
  801057:	83 c0 04             	add    $0x4,%eax
  80105a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80105d:	8b 45 10             	mov    0x10(%ebp),%eax
  801060:	ff 75 f4             	pushl  -0xc(%ebp)
  801063:	50                   	push   %eax
  801064:	ff 75 0c             	pushl  0xc(%ebp)
  801067:	ff 75 08             	pushl  0x8(%ebp)
  80106a:	e8 89 ff ff ff       	call   800ff8 <vsnprintf>
  80106f:	83 c4 10             	add    $0x10,%esp
  801072:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801075:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801078:	c9                   	leave  
  801079:	c3                   	ret    

0080107a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80107a:	55                   	push   %ebp
  80107b:	89 e5                	mov    %esp,%ebp
  80107d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801080:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801087:	eb 06                	jmp    80108f <strlen+0x15>
		n++;
  801089:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80108c:	ff 45 08             	incl   0x8(%ebp)
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	84 c0                	test   %al,%al
  801096:	75 f1                	jne    801089 <strlen+0xf>
		n++;
	return n;
  801098:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80109b:	c9                   	leave  
  80109c:	c3                   	ret    

0080109d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80109d:	55                   	push   %ebp
  80109e:	89 e5                	mov    %esp,%ebp
  8010a0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010aa:	eb 09                	jmp    8010b5 <strnlen+0x18>
		n++;
  8010ac:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010af:	ff 45 08             	incl   0x8(%ebp)
  8010b2:	ff 4d 0c             	decl   0xc(%ebp)
  8010b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010b9:	74 09                	je     8010c4 <strnlen+0x27>
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	84 c0                	test   %al,%al
  8010c2:	75 e8                	jne    8010ac <strnlen+0xf>
		n++;
	return n;
  8010c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010c7:	c9                   	leave  
  8010c8:	c3                   	ret    

008010c9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010c9:	55                   	push   %ebp
  8010ca:	89 e5                	mov    %esp,%ebp
  8010cc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010d5:	90                   	nop
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	8d 50 01             	lea    0x1(%eax),%edx
  8010dc:	89 55 08             	mov    %edx,0x8(%ebp)
  8010df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010e5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010e8:	8a 12                	mov    (%edx),%dl
  8010ea:	88 10                	mov    %dl,(%eax)
  8010ec:	8a 00                	mov    (%eax),%al
  8010ee:	84 c0                	test   %al,%al
  8010f0:	75 e4                	jne    8010d6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010f5:	c9                   	leave  
  8010f6:	c3                   	ret    

008010f7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010f7:	55                   	push   %ebp
  8010f8:	89 e5                	mov    %esp,%ebp
  8010fa:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801103:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80110a:	eb 1f                	jmp    80112b <strncpy+0x34>
		*dst++ = *src;
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
  80110f:	8d 50 01             	lea    0x1(%eax),%edx
  801112:	89 55 08             	mov    %edx,0x8(%ebp)
  801115:	8b 55 0c             	mov    0xc(%ebp),%edx
  801118:	8a 12                	mov    (%edx),%dl
  80111a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80111c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	84 c0                	test   %al,%al
  801123:	74 03                	je     801128 <strncpy+0x31>
			src++;
  801125:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801128:	ff 45 fc             	incl   -0x4(%ebp)
  80112b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801131:	72 d9                	jb     80110c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801133:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801136:	c9                   	leave  
  801137:	c3                   	ret    

00801138 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801138:	55                   	push   %ebp
  801139:	89 e5                	mov    %esp,%ebp
  80113b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801144:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801148:	74 30                	je     80117a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80114a:	eb 16                	jmp    801162 <strlcpy+0x2a>
			*dst++ = *src++;
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
  80114f:	8d 50 01             	lea    0x1(%eax),%edx
  801152:	89 55 08             	mov    %edx,0x8(%ebp)
  801155:	8b 55 0c             	mov    0xc(%ebp),%edx
  801158:	8d 4a 01             	lea    0x1(%edx),%ecx
  80115b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80115e:	8a 12                	mov    (%edx),%dl
  801160:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801162:	ff 4d 10             	decl   0x10(%ebp)
  801165:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801169:	74 09                	je     801174 <strlcpy+0x3c>
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	84 c0                	test   %al,%al
  801172:	75 d8                	jne    80114c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80117a:	8b 55 08             	mov    0x8(%ebp),%edx
  80117d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801180:	29 c2                	sub    %eax,%edx
  801182:	89 d0                	mov    %edx,%eax
}
  801184:	c9                   	leave  
  801185:	c3                   	ret    

00801186 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801186:	55                   	push   %ebp
  801187:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801189:	eb 06                	jmp    801191 <strcmp+0xb>
		p++, q++;
  80118b:	ff 45 08             	incl   0x8(%ebp)
  80118e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	8a 00                	mov    (%eax),%al
  801196:	84 c0                	test   %al,%al
  801198:	74 0e                	je     8011a8 <strcmp+0x22>
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 10                	mov    (%eax),%dl
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	8a 00                	mov    (%eax),%al
  8011a4:	38 c2                	cmp    %al,%dl
  8011a6:	74 e3                	je     80118b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	0f b6 d0             	movzbl %al,%edx
  8011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b3:	8a 00                	mov    (%eax),%al
  8011b5:	0f b6 c0             	movzbl %al,%eax
  8011b8:	29 c2                	sub    %eax,%edx
  8011ba:	89 d0                	mov    %edx,%eax
}
  8011bc:	5d                   	pop    %ebp
  8011bd:	c3                   	ret    

008011be <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8011be:	55                   	push   %ebp
  8011bf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8011c1:	eb 09                	jmp    8011cc <strncmp+0xe>
		n--, p++, q++;
  8011c3:	ff 4d 10             	decl   0x10(%ebp)
  8011c6:	ff 45 08             	incl   0x8(%ebp)
  8011c9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d0:	74 17                	je     8011e9 <strncmp+0x2b>
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	84 c0                	test   %al,%al
  8011d9:	74 0e                	je     8011e9 <strncmp+0x2b>
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 10                	mov    (%eax),%dl
  8011e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	38 c2                	cmp    %al,%dl
  8011e7:	74 da                	je     8011c3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ed:	75 07                	jne    8011f6 <strncmp+0x38>
		return 0;
  8011ef:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f4:	eb 14                	jmp    80120a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f9:	8a 00                	mov    (%eax),%al
  8011fb:	0f b6 d0             	movzbl %al,%edx
  8011fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	0f b6 c0             	movzbl %al,%eax
  801206:	29 c2                	sub    %eax,%edx
  801208:	89 d0                	mov    %edx,%eax
}
  80120a:	5d                   	pop    %ebp
  80120b:	c3                   	ret    

0080120c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80120c:	55                   	push   %ebp
  80120d:	89 e5                	mov    %esp,%ebp
  80120f:	83 ec 04             	sub    $0x4,%esp
  801212:	8b 45 0c             	mov    0xc(%ebp),%eax
  801215:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801218:	eb 12                	jmp    80122c <strchr+0x20>
		if (*s == c)
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801222:	75 05                	jne    801229 <strchr+0x1d>
			return (char *) s;
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	eb 11                	jmp    80123a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801229:	ff 45 08             	incl   0x8(%ebp)
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
  80122f:	8a 00                	mov    (%eax),%al
  801231:	84 c0                	test   %al,%al
  801233:	75 e5                	jne    80121a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801235:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80123a:	c9                   	leave  
  80123b:	c3                   	ret    

0080123c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80123c:	55                   	push   %ebp
  80123d:	89 e5                	mov    %esp,%ebp
  80123f:	83 ec 04             	sub    $0x4,%esp
  801242:	8b 45 0c             	mov    0xc(%ebp),%eax
  801245:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801248:	eb 0d                	jmp    801257 <strfind+0x1b>
		if (*s == c)
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	8a 00                	mov    (%eax),%al
  80124f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801252:	74 0e                	je     801262 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801254:	ff 45 08             	incl   0x8(%ebp)
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	84 c0                	test   %al,%al
  80125e:	75 ea                	jne    80124a <strfind+0xe>
  801260:	eb 01                	jmp    801263 <strfind+0x27>
		if (*s == c)
			break;
  801262:	90                   	nop
	return (char *) s;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
  80126b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80127a:	eb 0e                	jmp    80128a <memset+0x22>
		*p++ = c;
  80127c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127f:	8d 50 01             	lea    0x1(%eax),%edx
  801282:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801285:	8b 55 0c             	mov    0xc(%ebp),%edx
  801288:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80128a:	ff 4d f8             	decl   -0x8(%ebp)
  80128d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801291:	79 e9                	jns    80127c <memset+0x14>
		*p++ = c;

	return v;
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801296:	c9                   	leave  
  801297:	c3                   	ret    

00801298 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801298:	55                   	push   %ebp
  801299:	89 e5                	mov    %esp,%ebp
  80129b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8012aa:	eb 16                	jmp    8012c2 <memcpy+0x2a>
		*d++ = *s++;
  8012ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012af:	8d 50 01             	lea    0x1(%eax),%edx
  8012b2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012bb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012be:	8a 12                	mov    (%edx),%dl
  8012c0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8012c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c8:	89 55 10             	mov    %edx,0x10(%ebp)
  8012cb:	85 c0                	test   %eax,%eax
  8012cd:	75 dd                	jne    8012ac <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012d2:	c9                   	leave  
  8012d3:	c3                   	ret    

008012d4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
  8012d7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012ec:	73 50                	jae    80133e <memmove+0x6a>
  8012ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f4:	01 d0                	add    %edx,%eax
  8012f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012f9:	76 43                	jbe    80133e <memmove+0x6a>
		s += n;
  8012fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fe:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801301:	8b 45 10             	mov    0x10(%ebp),%eax
  801304:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801307:	eb 10                	jmp    801319 <memmove+0x45>
			*--d = *--s;
  801309:	ff 4d f8             	decl   -0x8(%ebp)
  80130c:	ff 4d fc             	decl   -0x4(%ebp)
  80130f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801312:	8a 10                	mov    (%eax),%dl
  801314:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801317:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80131f:	89 55 10             	mov    %edx,0x10(%ebp)
  801322:	85 c0                	test   %eax,%eax
  801324:	75 e3                	jne    801309 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801326:	eb 23                	jmp    80134b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801328:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132b:	8d 50 01             	lea    0x1(%eax),%edx
  80132e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801331:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801334:	8d 4a 01             	lea    0x1(%edx),%ecx
  801337:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80133a:	8a 12                	mov    (%edx),%dl
  80133c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80133e:	8b 45 10             	mov    0x10(%ebp),%eax
  801341:	8d 50 ff             	lea    -0x1(%eax),%edx
  801344:	89 55 10             	mov    %edx,0x10(%ebp)
  801347:	85 c0                	test   %eax,%eax
  801349:	75 dd                	jne    801328 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80134e:	c9                   	leave  
  80134f:	c3                   	ret    

00801350 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801350:	55                   	push   %ebp
  801351:	89 e5                	mov    %esp,%ebp
  801353:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80135c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801362:	eb 2a                	jmp    80138e <memcmp+0x3e>
		if (*s1 != *s2)
  801364:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801367:	8a 10                	mov    (%eax),%dl
  801369:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80136c:	8a 00                	mov    (%eax),%al
  80136e:	38 c2                	cmp    %al,%dl
  801370:	74 16                	je     801388 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801372:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	0f b6 d0             	movzbl %al,%edx
  80137a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80137d:	8a 00                	mov    (%eax),%al
  80137f:	0f b6 c0             	movzbl %al,%eax
  801382:	29 c2                	sub    %eax,%edx
  801384:	89 d0                	mov    %edx,%eax
  801386:	eb 18                	jmp    8013a0 <memcmp+0x50>
		s1++, s2++;
  801388:	ff 45 fc             	incl   -0x4(%ebp)
  80138b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	8d 50 ff             	lea    -0x1(%eax),%edx
  801394:	89 55 10             	mov    %edx,0x10(%ebp)
  801397:	85 c0                	test   %eax,%eax
  801399:	75 c9                	jne    801364 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80139b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013a0:	c9                   	leave  
  8013a1:	c3                   	ret    

008013a2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8013a2:	55                   	push   %ebp
  8013a3:	89 e5                	mov    %esp,%ebp
  8013a5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8013a8:	8b 55 08             	mov    0x8(%ebp),%edx
  8013ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ae:	01 d0                	add    %edx,%eax
  8013b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8013b3:	eb 15                	jmp    8013ca <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	0f b6 d0             	movzbl %al,%edx
  8013bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c0:	0f b6 c0             	movzbl %al,%eax
  8013c3:	39 c2                	cmp    %eax,%edx
  8013c5:	74 0d                	je     8013d4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013c7:	ff 45 08             	incl   0x8(%ebp)
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013d0:	72 e3                	jb     8013b5 <memfind+0x13>
  8013d2:	eb 01                	jmp    8013d5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013d4:	90                   	nop
	return (void *) s;
  8013d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
  8013dd:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013ee:	eb 03                	jmp    8013f3 <strtol+0x19>
		s++;
  8013f0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	8a 00                	mov    (%eax),%al
  8013f8:	3c 20                	cmp    $0x20,%al
  8013fa:	74 f4                	je     8013f0 <strtol+0x16>
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	8a 00                	mov    (%eax),%al
  801401:	3c 09                	cmp    $0x9,%al
  801403:	74 eb                	je     8013f0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	3c 2b                	cmp    $0x2b,%al
  80140c:	75 05                	jne    801413 <strtol+0x39>
		s++;
  80140e:	ff 45 08             	incl   0x8(%ebp)
  801411:	eb 13                	jmp    801426 <strtol+0x4c>
	else if (*s == '-')
  801413:	8b 45 08             	mov    0x8(%ebp),%eax
  801416:	8a 00                	mov    (%eax),%al
  801418:	3c 2d                	cmp    $0x2d,%al
  80141a:	75 0a                	jne    801426 <strtol+0x4c>
		s++, neg = 1;
  80141c:	ff 45 08             	incl   0x8(%ebp)
  80141f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801426:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142a:	74 06                	je     801432 <strtol+0x58>
  80142c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801430:	75 20                	jne    801452 <strtol+0x78>
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	8a 00                	mov    (%eax),%al
  801437:	3c 30                	cmp    $0x30,%al
  801439:	75 17                	jne    801452 <strtol+0x78>
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	40                   	inc    %eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	3c 78                	cmp    $0x78,%al
  801443:	75 0d                	jne    801452 <strtol+0x78>
		s += 2, base = 16;
  801445:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801449:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801450:	eb 28                	jmp    80147a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801452:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801456:	75 15                	jne    80146d <strtol+0x93>
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	3c 30                	cmp    $0x30,%al
  80145f:	75 0c                	jne    80146d <strtol+0x93>
		s++, base = 8;
  801461:	ff 45 08             	incl   0x8(%ebp)
  801464:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80146b:	eb 0d                	jmp    80147a <strtol+0xa0>
	else if (base == 0)
  80146d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801471:	75 07                	jne    80147a <strtol+0xa0>
		base = 10;
  801473:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	8a 00                	mov    (%eax),%al
  80147f:	3c 2f                	cmp    $0x2f,%al
  801481:	7e 19                	jle    80149c <strtol+0xc2>
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	8a 00                	mov    (%eax),%al
  801488:	3c 39                	cmp    $0x39,%al
  80148a:	7f 10                	jg     80149c <strtol+0xc2>
			dig = *s - '0';
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	8a 00                	mov    (%eax),%al
  801491:	0f be c0             	movsbl %al,%eax
  801494:	83 e8 30             	sub    $0x30,%eax
  801497:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80149a:	eb 42                	jmp    8014de <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8a 00                	mov    (%eax),%al
  8014a1:	3c 60                	cmp    $0x60,%al
  8014a3:	7e 19                	jle    8014be <strtol+0xe4>
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	8a 00                	mov    (%eax),%al
  8014aa:	3c 7a                	cmp    $0x7a,%al
  8014ac:	7f 10                	jg     8014be <strtol+0xe4>
			dig = *s - 'a' + 10;
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b1:	8a 00                	mov    (%eax),%al
  8014b3:	0f be c0             	movsbl %al,%eax
  8014b6:	83 e8 57             	sub    $0x57,%eax
  8014b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014bc:	eb 20                	jmp    8014de <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	8a 00                	mov    (%eax),%al
  8014c3:	3c 40                	cmp    $0x40,%al
  8014c5:	7e 39                	jle    801500 <strtol+0x126>
  8014c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ca:	8a 00                	mov    (%eax),%al
  8014cc:	3c 5a                	cmp    $0x5a,%al
  8014ce:	7f 30                	jg     801500 <strtol+0x126>
			dig = *s - 'A' + 10;
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	8a 00                	mov    (%eax),%al
  8014d5:	0f be c0             	movsbl %al,%eax
  8014d8:	83 e8 37             	sub    $0x37,%eax
  8014db:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014e1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014e4:	7d 19                	jge    8014ff <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014e6:	ff 45 08             	incl   0x8(%ebp)
  8014e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ec:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014f0:	89 c2                	mov    %eax,%edx
  8014f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014f5:	01 d0                	add    %edx,%eax
  8014f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014fa:	e9 7b ff ff ff       	jmp    80147a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014ff:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801500:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801504:	74 08                	je     80150e <strtol+0x134>
		*endptr = (char *) s;
  801506:	8b 45 0c             	mov    0xc(%ebp),%eax
  801509:	8b 55 08             	mov    0x8(%ebp),%edx
  80150c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80150e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801512:	74 07                	je     80151b <strtol+0x141>
  801514:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801517:	f7 d8                	neg    %eax
  801519:	eb 03                	jmp    80151e <strtol+0x144>
  80151b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <ltostr>:

void
ltostr(long value, char *str)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
  801523:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801526:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80152d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801534:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801538:	79 13                	jns    80154d <ltostr+0x2d>
	{
		neg = 1;
  80153a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801541:	8b 45 0c             	mov    0xc(%ebp),%eax
  801544:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801547:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80154a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80154d:	8b 45 08             	mov    0x8(%ebp),%eax
  801550:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801555:	99                   	cltd   
  801556:	f7 f9                	idiv   %ecx
  801558:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80155b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155e:	8d 50 01             	lea    0x1(%eax),%edx
  801561:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801564:	89 c2                	mov    %eax,%edx
  801566:	8b 45 0c             	mov    0xc(%ebp),%eax
  801569:	01 d0                	add    %edx,%eax
  80156b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80156e:	83 c2 30             	add    $0x30,%edx
  801571:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801573:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801576:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80157b:	f7 e9                	imul   %ecx
  80157d:	c1 fa 02             	sar    $0x2,%edx
  801580:	89 c8                	mov    %ecx,%eax
  801582:	c1 f8 1f             	sar    $0x1f,%eax
  801585:	29 c2                	sub    %eax,%edx
  801587:	89 d0                	mov    %edx,%eax
  801589:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80158c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80158f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801594:	f7 e9                	imul   %ecx
  801596:	c1 fa 02             	sar    $0x2,%edx
  801599:	89 c8                	mov    %ecx,%eax
  80159b:	c1 f8 1f             	sar    $0x1f,%eax
  80159e:	29 c2                	sub    %eax,%edx
  8015a0:	89 d0                	mov    %edx,%eax
  8015a2:	c1 e0 02             	shl    $0x2,%eax
  8015a5:	01 d0                	add    %edx,%eax
  8015a7:	01 c0                	add    %eax,%eax
  8015a9:	29 c1                	sub    %eax,%ecx
  8015ab:	89 ca                	mov    %ecx,%edx
  8015ad:	85 d2                	test   %edx,%edx
  8015af:	75 9c                	jne    80154d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8015b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8015b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015bb:	48                   	dec    %eax
  8015bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8015bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015c3:	74 3d                	je     801602 <ltostr+0xe2>
		start = 1 ;
  8015c5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015cc:	eb 34                	jmp    801602 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d4:	01 d0                	add    %edx,%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e1:	01 c2                	add    %eax,%edx
  8015e3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e9:	01 c8                	add    %ecx,%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f5:	01 c2                	add    %eax,%edx
  8015f7:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015fa:	88 02                	mov    %al,(%edx)
		start++ ;
  8015fc:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015ff:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801602:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801605:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801608:	7c c4                	jl     8015ce <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80160a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80160d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801610:	01 d0                	add    %edx,%eax
  801612:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801615:	90                   	nop
  801616:	c9                   	leave  
  801617:	c3                   	ret    

00801618 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801618:	55                   	push   %ebp
  801619:	89 e5                	mov    %esp,%ebp
  80161b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80161e:	ff 75 08             	pushl  0x8(%ebp)
  801621:	e8 54 fa ff ff       	call   80107a <strlen>
  801626:	83 c4 04             	add    $0x4,%esp
  801629:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80162c:	ff 75 0c             	pushl  0xc(%ebp)
  80162f:	e8 46 fa ff ff       	call   80107a <strlen>
  801634:	83 c4 04             	add    $0x4,%esp
  801637:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80163a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801641:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801648:	eb 17                	jmp    801661 <strcconcat+0x49>
		final[s] = str1[s] ;
  80164a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80164d:	8b 45 10             	mov    0x10(%ebp),%eax
  801650:	01 c2                	add    %eax,%edx
  801652:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	01 c8                	add    %ecx,%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80165e:	ff 45 fc             	incl   -0x4(%ebp)
  801661:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801664:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801667:	7c e1                	jl     80164a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801669:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801670:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801677:	eb 1f                	jmp    801698 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801679:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167c:	8d 50 01             	lea    0x1(%eax),%edx
  80167f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801682:	89 c2                	mov    %eax,%edx
  801684:	8b 45 10             	mov    0x10(%ebp),%eax
  801687:	01 c2                	add    %eax,%edx
  801689:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80168c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168f:	01 c8                	add    %ecx,%eax
  801691:	8a 00                	mov    (%eax),%al
  801693:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801695:	ff 45 f8             	incl   -0x8(%ebp)
  801698:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80169b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80169e:	7c d9                	jl     801679 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8016a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a6:	01 d0                	add    %edx,%eax
  8016a8:	c6 00 00             	movb   $0x0,(%eax)
}
  8016ab:	90                   	nop
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8016b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8016ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8016bd:	8b 00                	mov    (%eax),%eax
  8016bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c9:	01 d0                	add    %edx,%eax
  8016cb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016d1:	eb 0c                	jmp    8016df <strsplit+0x31>
			*string++ = 0;
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	8d 50 01             	lea    0x1(%eax),%edx
  8016d9:	89 55 08             	mov    %edx,0x8(%ebp)
  8016dc:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	8a 00                	mov    (%eax),%al
  8016e4:	84 c0                	test   %al,%al
  8016e6:	74 18                	je     801700 <strsplit+0x52>
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	8a 00                	mov    (%eax),%al
  8016ed:	0f be c0             	movsbl %al,%eax
  8016f0:	50                   	push   %eax
  8016f1:	ff 75 0c             	pushl  0xc(%ebp)
  8016f4:	e8 13 fb ff ff       	call   80120c <strchr>
  8016f9:	83 c4 08             	add    $0x8,%esp
  8016fc:	85 c0                	test   %eax,%eax
  8016fe:	75 d3                	jne    8016d3 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	84 c0                	test   %al,%al
  801707:	74 5a                	je     801763 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801709:	8b 45 14             	mov    0x14(%ebp),%eax
  80170c:	8b 00                	mov    (%eax),%eax
  80170e:	83 f8 0f             	cmp    $0xf,%eax
  801711:	75 07                	jne    80171a <strsplit+0x6c>
		{
			return 0;
  801713:	b8 00 00 00 00       	mov    $0x0,%eax
  801718:	eb 66                	jmp    801780 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80171a:	8b 45 14             	mov    0x14(%ebp),%eax
  80171d:	8b 00                	mov    (%eax),%eax
  80171f:	8d 48 01             	lea    0x1(%eax),%ecx
  801722:	8b 55 14             	mov    0x14(%ebp),%edx
  801725:	89 0a                	mov    %ecx,(%edx)
  801727:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80172e:	8b 45 10             	mov    0x10(%ebp),%eax
  801731:	01 c2                	add    %eax,%edx
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801738:	eb 03                	jmp    80173d <strsplit+0x8f>
			string++;
  80173a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80173d:	8b 45 08             	mov    0x8(%ebp),%eax
  801740:	8a 00                	mov    (%eax),%al
  801742:	84 c0                	test   %al,%al
  801744:	74 8b                	je     8016d1 <strsplit+0x23>
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	8a 00                	mov    (%eax),%al
  80174b:	0f be c0             	movsbl %al,%eax
  80174e:	50                   	push   %eax
  80174f:	ff 75 0c             	pushl  0xc(%ebp)
  801752:	e8 b5 fa ff ff       	call   80120c <strchr>
  801757:	83 c4 08             	add    $0x8,%esp
  80175a:	85 c0                	test   %eax,%eax
  80175c:	74 dc                	je     80173a <strsplit+0x8c>
			string++;
	}
  80175e:	e9 6e ff ff ff       	jmp    8016d1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801763:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801764:	8b 45 14             	mov    0x14(%ebp),%eax
  801767:	8b 00                	mov    (%eax),%eax
  801769:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801770:	8b 45 10             	mov    0x10(%ebp),%eax
  801773:	01 d0                	add    %edx,%eax
  801775:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80177b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801780:	c9                   	leave  
  801781:	c3                   	ret    

00801782 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801782:	55                   	push   %ebp
  801783:	89 e5                	mov    %esp,%ebp
  801785:	57                   	push   %edi
  801786:	56                   	push   %esi
  801787:	53                   	push   %ebx
  801788:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80178b:	8b 45 08             	mov    0x8(%ebp),%eax
  80178e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801791:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801794:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801797:	8b 7d 18             	mov    0x18(%ebp),%edi
  80179a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80179d:	cd 30                	int    $0x30
  80179f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017a5:	83 c4 10             	add    $0x10,%esp
  8017a8:	5b                   	pop    %ebx
  8017a9:	5e                   	pop    %esi
  8017aa:	5f                   	pop    %edi
  8017ab:	5d                   	pop    %ebp
  8017ac:	c3                   	ret    

008017ad <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
  8017b0:	83 ec 04             	sub    $0x4,%esp
  8017b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017b9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	52                   	push   %edx
  8017c5:	ff 75 0c             	pushl  0xc(%ebp)
  8017c8:	50                   	push   %eax
  8017c9:	6a 00                	push   $0x0
  8017cb:	e8 b2 ff ff ff       	call   801782 <syscall>
  8017d0:	83 c4 18             	add    $0x18,%esp
}
  8017d3:	90                   	nop
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <sys_cgetc>:

int
sys_cgetc(void)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 01                	push   $0x1
  8017e5:	e8 98 ff ff ff       	call   801782 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	50                   	push   %eax
  8017fe:	6a 05                	push   $0x5
  801800:	e8 7d ff ff ff       	call   801782 <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 02                	push   $0x2
  801819:	e8 64 ff ff ff       	call   801782 <syscall>
  80181e:	83 c4 18             	add    $0x18,%esp
}
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 03                	push   $0x3
  801832:	e8 4b ff ff ff       	call   801782 <syscall>
  801837:	83 c4 18             	add    $0x18,%esp
}
  80183a:	c9                   	leave  
  80183b:	c3                   	ret    

0080183c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 04                	push   $0x4
  80184b:	e8 32 ff ff ff       	call   801782 <syscall>
  801850:	83 c4 18             	add    $0x18,%esp
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <sys_env_exit>:


void sys_env_exit(void)
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 06                	push   $0x6
  801864:	e8 19 ff ff ff       	call   801782 <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
}
  80186c:	90                   	nop
  80186d:	c9                   	leave  
  80186e:	c3                   	ret    

0080186f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80186f:	55                   	push   %ebp
  801870:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801872:	8b 55 0c             	mov    0xc(%ebp),%edx
  801875:	8b 45 08             	mov    0x8(%ebp),%eax
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	52                   	push   %edx
  80187f:	50                   	push   %eax
  801880:	6a 07                	push   $0x7
  801882:	e8 fb fe ff ff       	call   801782 <syscall>
  801887:	83 c4 18             	add    $0x18,%esp
}
  80188a:	c9                   	leave  
  80188b:	c3                   	ret    

0080188c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80188c:	55                   	push   %ebp
  80188d:	89 e5                	mov    %esp,%ebp
  80188f:	56                   	push   %esi
  801890:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801891:	8b 75 18             	mov    0x18(%ebp),%esi
  801894:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801897:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80189a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189d:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a0:	56                   	push   %esi
  8018a1:	53                   	push   %ebx
  8018a2:	51                   	push   %ecx
  8018a3:	52                   	push   %edx
  8018a4:	50                   	push   %eax
  8018a5:	6a 08                	push   $0x8
  8018a7:	e8 d6 fe ff ff       	call   801782 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
}
  8018af:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018b2:	5b                   	pop    %ebx
  8018b3:	5e                   	pop    %esi
  8018b4:	5d                   	pop    %ebp
  8018b5:	c3                   	ret    

008018b6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	52                   	push   %edx
  8018c6:	50                   	push   %eax
  8018c7:	6a 09                	push   $0x9
  8018c9:	e8 b4 fe ff ff       	call   801782 <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	ff 75 0c             	pushl  0xc(%ebp)
  8018df:	ff 75 08             	pushl  0x8(%ebp)
  8018e2:	6a 0a                	push   $0xa
  8018e4:	e8 99 fe ff ff       	call   801782 <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 0b                	push   $0xb
  8018fd:	e8 80 fe ff ff       	call   801782 <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 0c                	push   $0xc
  801916:	e8 67 fe ff ff       	call   801782 <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 0d                	push   $0xd
  80192f:	e8 4e fe ff ff       	call   801782 <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
}
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	ff 75 0c             	pushl  0xc(%ebp)
  801945:	ff 75 08             	pushl  0x8(%ebp)
  801948:	6a 11                	push   $0x11
  80194a:	e8 33 fe ff ff       	call   801782 <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
	return;
  801952:	90                   	nop
}
  801953:	c9                   	leave  
  801954:	c3                   	ret    

00801955 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	ff 75 0c             	pushl  0xc(%ebp)
  801961:	ff 75 08             	pushl  0x8(%ebp)
  801964:	6a 12                	push   $0x12
  801966:	e8 17 fe ff ff       	call   801782 <syscall>
  80196b:	83 c4 18             	add    $0x18,%esp
	return ;
  80196e:	90                   	nop
}
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 0e                	push   $0xe
  801980:	e8 fd fd ff ff       	call   801782 <syscall>
  801985:	83 c4 18             	add    $0x18,%esp
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	ff 75 08             	pushl  0x8(%ebp)
  801998:	6a 0f                	push   $0xf
  80199a:	e8 e3 fd ff ff       	call   801782 <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 10                	push   $0x10
  8019b3:	e8 ca fd ff ff       	call   801782 <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	90                   	nop
  8019bc:	c9                   	leave  
  8019bd:	c3                   	ret    

008019be <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8019be:	55                   	push   %ebp
  8019bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 14                	push   $0x14
  8019cd:	e8 b0 fd ff ff       	call   801782 <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
}
  8019d5:	90                   	nop
  8019d6:	c9                   	leave  
  8019d7:	c3                   	ret    

008019d8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019d8:	55                   	push   %ebp
  8019d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 15                	push   $0x15
  8019e7:	e8 96 fd ff ff       	call   801782 <syscall>
  8019ec:	83 c4 18             	add    $0x18,%esp
}
  8019ef:	90                   	nop
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
  8019f5:	83 ec 04             	sub    $0x4,%esp
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019fe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	50                   	push   %eax
  801a0b:	6a 16                	push   $0x16
  801a0d:	e8 70 fd ff ff       	call   801782 <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
}
  801a15:	90                   	nop
  801a16:	c9                   	leave  
  801a17:	c3                   	ret    

00801a18 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a18:	55                   	push   %ebp
  801a19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 17                	push   $0x17
  801a27:	e8 56 fd ff ff       	call   801782 <syscall>
  801a2c:	83 c4 18             	add    $0x18,%esp
}
  801a2f:	90                   	nop
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    

00801a32 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a32:	55                   	push   %ebp
  801a33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a35:	8b 45 08             	mov    0x8(%ebp),%eax
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	ff 75 0c             	pushl  0xc(%ebp)
  801a41:	50                   	push   %eax
  801a42:	6a 18                	push   $0x18
  801a44:	e8 39 fd ff ff       	call   801782 <syscall>
  801a49:	83 c4 18             	add    $0x18,%esp
}
  801a4c:	c9                   	leave  
  801a4d:	c3                   	ret    

00801a4e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a4e:	55                   	push   %ebp
  801a4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a54:	8b 45 08             	mov    0x8(%ebp),%eax
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	52                   	push   %edx
  801a5e:	50                   	push   %eax
  801a5f:	6a 1b                	push   $0x1b
  801a61:	e8 1c fd ff ff       	call   801782 <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
}
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	52                   	push   %edx
  801a7b:	50                   	push   %eax
  801a7c:	6a 19                	push   $0x19
  801a7e:	e8 ff fc ff ff       	call   801782 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	90                   	nop
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	52                   	push   %edx
  801a99:	50                   	push   %eax
  801a9a:	6a 1a                	push   $0x1a
  801a9c:	e8 e1 fc ff ff       	call   801782 <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	90                   	nop
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
  801aaa:	83 ec 04             	sub    $0x4,%esp
  801aad:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ab3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ab6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801aba:	8b 45 08             	mov    0x8(%ebp),%eax
  801abd:	6a 00                	push   $0x0
  801abf:	51                   	push   %ecx
  801ac0:	52                   	push   %edx
  801ac1:	ff 75 0c             	pushl  0xc(%ebp)
  801ac4:	50                   	push   %eax
  801ac5:	6a 1c                	push   $0x1c
  801ac7:	e8 b6 fc ff ff       	call   801782 <syscall>
  801acc:	83 c4 18             	add    $0x18,%esp
}
  801acf:	c9                   	leave  
  801ad0:	c3                   	ret    

00801ad1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ad1:	55                   	push   %ebp
  801ad2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ad4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	52                   	push   %edx
  801ae1:	50                   	push   %eax
  801ae2:	6a 1d                	push   $0x1d
  801ae4:	e8 99 fc ff ff       	call   801782 <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
}
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801af1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801af4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	51                   	push   %ecx
  801aff:	52                   	push   %edx
  801b00:	50                   	push   %eax
  801b01:	6a 1e                	push   $0x1e
  801b03:	e8 7a fc ff ff       	call   801782 <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
}
  801b0b:	c9                   	leave  
  801b0c:	c3                   	ret    

00801b0d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b0d:	55                   	push   %ebp
  801b0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b13:	8b 45 08             	mov    0x8(%ebp),%eax
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	52                   	push   %edx
  801b1d:	50                   	push   %eax
  801b1e:	6a 1f                	push   $0x1f
  801b20:	e8 5d fc ff ff       	call   801782 <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	c9                   	leave  
  801b29:	c3                   	ret    

00801b2a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b2a:	55                   	push   %ebp
  801b2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 20                	push   $0x20
  801b39:	e8 44 fc ff ff       	call   801782 <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
}
  801b41:	c9                   	leave  
  801b42:	c3                   	ret    

00801b43 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b46:	8b 45 08             	mov    0x8(%ebp),%eax
  801b49:	6a 00                	push   $0x0
  801b4b:	ff 75 14             	pushl  0x14(%ebp)
  801b4e:	ff 75 10             	pushl  0x10(%ebp)
  801b51:	ff 75 0c             	pushl  0xc(%ebp)
  801b54:	50                   	push   %eax
  801b55:	6a 21                	push   $0x21
  801b57:	e8 26 fc ff ff       	call   801782 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	50                   	push   %eax
  801b70:	6a 22                	push   $0x22
  801b72:	e8 0b fc ff ff       	call   801782 <syscall>
  801b77:	83 c4 18             	add    $0x18,%esp
}
  801b7a:	90                   	nop
  801b7b:	c9                   	leave  
  801b7c:	c3                   	ret    

00801b7d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b80:	8b 45 08             	mov    0x8(%ebp),%eax
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	50                   	push   %eax
  801b8c:	6a 23                	push   $0x23
  801b8e:	e8 ef fb ff ff       	call   801782 <syscall>
  801b93:	83 c4 18             	add    $0x18,%esp
}
  801b96:	90                   	nop
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
  801b9c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b9f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ba2:	8d 50 04             	lea    0x4(%eax),%edx
  801ba5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	52                   	push   %edx
  801baf:	50                   	push   %eax
  801bb0:	6a 24                	push   $0x24
  801bb2:	e8 cb fb ff ff       	call   801782 <syscall>
  801bb7:	83 c4 18             	add    $0x18,%esp
	return result;
  801bba:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801bbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bc0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bc3:	89 01                	mov    %eax,(%ecx)
  801bc5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	c9                   	leave  
  801bcc:	c2 04 00             	ret    $0x4

00801bcf <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801bcf:	55                   	push   %ebp
  801bd0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	ff 75 10             	pushl  0x10(%ebp)
  801bd9:	ff 75 0c             	pushl  0xc(%ebp)
  801bdc:	ff 75 08             	pushl  0x8(%ebp)
  801bdf:	6a 13                	push   $0x13
  801be1:	e8 9c fb ff ff       	call   801782 <syscall>
  801be6:	83 c4 18             	add    $0x18,%esp
	return ;
  801be9:	90                   	nop
}
  801bea:	c9                   	leave  
  801beb:	c3                   	ret    

00801bec <sys_rcr2>:
uint32 sys_rcr2()
{
  801bec:	55                   	push   %ebp
  801bed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 25                	push   $0x25
  801bfb:	e8 82 fb ff ff       	call   801782 <syscall>
  801c00:	83 c4 18             	add    $0x18,%esp
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	83 ec 04             	sub    $0x4,%esp
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c11:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	50                   	push   %eax
  801c1e:	6a 26                	push   $0x26
  801c20:	e8 5d fb ff ff       	call   801782 <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
	return ;
  801c28:	90                   	nop
}
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <rsttst>:
void rsttst()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 28                	push   $0x28
  801c3a:	e8 43 fb ff ff       	call   801782 <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801c42:	90                   	nop
}
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
  801c48:	83 ec 04             	sub    $0x4,%esp
  801c4b:	8b 45 14             	mov    0x14(%ebp),%eax
  801c4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c51:	8b 55 18             	mov    0x18(%ebp),%edx
  801c54:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c58:	52                   	push   %edx
  801c59:	50                   	push   %eax
  801c5a:	ff 75 10             	pushl  0x10(%ebp)
  801c5d:	ff 75 0c             	pushl  0xc(%ebp)
  801c60:	ff 75 08             	pushl  0x8(%ebp)
  801c63:	6a 27                	push   $0x27
  801c65:	e8 18 fb ff ff       	call   801782 <syscall>
  801c6a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c6d:	90                   	nop
}
  801c6e:	c9                   	leave  
  801c6f:	c3                   	ret    

00801c70 <chktst>:
void chktst(uint32 n)
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	ff 75 08             	pushl  0x8(%ebp)
  801c7e:	6a 29                	push   $0x29
  801c80:	e8 fd fa ff ff       	call   801782 <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
	return ;
  801c88:	90                   	nop
}
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    

00801c8b <inctst>:

void inctst()
{
  801c8b:	55                   	push   %ebp
  801c8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 2a                	push   $0x2a
  801c9a:	e8 e3 fa ff ff       	call   801782 <syscall>
  801c9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801ca2:	90                   	nop
}
  801ca3:	c9                   	leave  
  801ca4:	c3                   	ret    

00801ca5 <gettst>:
uint32 gettst()
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 2b                	push   $0x2b
  801cb4:	e8 c9 fa ff ff       	call   801782 <syscall>
  801cb9:	83 c4 18             	add    $0x18,%esp
}
  801cbc:	c9                   	leave  
  801cbd:	c3                   	ret    

00801cbe <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
  801cc1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 2c                	push   $0x2c
  801cd0:	e8 ad fa ff ff       	call   801782 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
  801cd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801cdb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801cdf:	75 07                	jne    801ce8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ce1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce6:	eb 05                	jmp    801ced <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ce8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ced:	c9                   	leave  
  801cee:	c3                   	ret    

00801cef <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
  801cf2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 2c                	push   $0x2c
  801d01:	e8 7c fa ff ff       	call   801782 <syscall>
  801d06:	83 c4 18             	add    $0x18,%esp
  801d09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d0c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d10:	75 07                	jne    801d19 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d12:	b8 01 00 00 00       	mov    $0x1,%eax
  801d17:	eb 05                	jmp    801d1e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d19:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d1e:	c9                   	leave  
  801d1f:	c3                   	ret    

00801d20 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
  801d23:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 2c                	push   $0x2c
  801d32:	e8 4b fa ff ff       	call   801782 <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
  801d3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d3d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d41:	75 07                	jne    801d4a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d43:	b8 01 00 00 00       	mov    $0x1,%eax
  801d48:	eb 05                	jmp    801d4f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
  801d54:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 2c                	push   $0x2c
  801d63:	e8 1a fa ff ff       	call   801782 <syscall>
  801d68:	83 c4 18             	add    $0x18,%esp
  801d6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d6e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d72:	75 07                	jne    801d7b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d74:	b8 01 00 00 00       	mov    $0x1,%eax
  801d79:	eb 05                	jmp    801d80 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d7b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d80:	c9                   	leave  
  801d81:	c3                   	ret    

00801d82 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d82:	55                   	push   %ebp
  801d83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	ff 75 08             	pushl  0x8(%ebp)
  801d90:	6a 2d                	push   $0x2d
  801d92:	e8 eb f9 ff ff       	call   801782 <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
	return ;
  801d9a:	90                   	nop
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
  801da0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801da1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801da4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801da7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	6a 00                	push   $0x0
  801daf:	53                   	push   %ebx
  801db0:	51                   	push   %ecx
  801db1:	52                   	push   %edx
  801db2:	50                   	push   %eax
  801db3:	6a 2e                	push   $0x2e
  801db5:	e8 c8 f9 ff ff       	call   801782 <syscall>
  801dba:	83 c4 18             	add    $0x18,%esp
}
  801dbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801dc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	52                   	push   %edx
  801dd2:	50                   	push   %eax
  801dd3:	6a 2f                	push   $0x2f
  801dd5:	e8 a8 f9 ff ff       	call   801782 <syscall>
  801dda:	83 c4 18             	add    $0x18,%esp
}
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    
  801ddf:	90                   	nop

00801de0 <__udivdi3>:
  801de0:	55                   	push   %ebp
  801de1:	57                   	push   %edi
  801de2:	56                   	push   %esi
  801de3:	53                   	push   %ebx
  801de4:	83 ec 1c             	sub    $0x1c,%esp
  801de7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801deb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801def:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801df3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801df7:	89 ca                	mov    %ecx,%edx
  801df9:	89 f8                	mov    %edi,%eax
  801dfb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dff:	85 f6                	test   %esi,%esi
  801e01:	75 2d                	jne    801e30 <__udivdi3+0x50>
  801e03:	39 cf                	cmp    %ecx,%edi
  801e05:	77 65                	ja     801e6c <__udivdi3+0x8c>
  801e07:	89 fd                	mov    %edi,%ebp
  801e09:	85 ff                	test   %edi,%edi
  801e0b:	75 0b                	jne    801e18 <__udivdi3+0x38>
  801e0d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e12:	31 d2                	xor    %edx,%edx
  801e14:	f7 f7                	div    %edi
  801e16:	89 c5                	mov    %eax,%ebp
  801e18:	31 d2                	xor    %edx,%edx
  801e1a:	89 c8                	mov    %ecx,%eax
  801e1c:	f7 f5                	div    %ebp
  801e1e:	89 c1                	mov    %eax,%ecx
  801e20:	89 d8                	mov    %ebx,%eax
  801e22:	f7 f5                	div    %ebp
  801e24:	89 cf                	mov    %ecx,%edi
  801e26:	89 fa                	mov    %edi,%edx
  801e28:	83 c4 1c             	add    $0x1c,%esp
  801e2b:	5b                   	pop    %ebx
  801e2c:	5e                   	pop    %esi
  801e2d:	5f                   	pop    %edi
  801e2e:	5d                   	pop    %ebp
  801e2f:	c3                   	ret    
  801e30:	39 ce                	cmp    %ecx,%esi
  801e32:	77 28                	ja     801e5c <__udivdi3+0x7c>
  801e34:	0f bd fe             	bsr    %esi,%edi
  801e37:	83 f7 1f             	xor    $0x1f,%edi
  801e3a:	75 40                	jne    801e7c <__udivdi3+0x9c>
  801e3c:	39 ce                	cmp    %ecx,%esi
  801e3e:	72 0a                	jb     801e4a <__udivdi3+0x6a>
  801e40:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e44:	0f 87 9e 00 00 00    	ja     801ee8 <__udivdi3+0x108>
  801e4a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e4f:	89 fa                	mov    %edi,%edx
  801e51:	83 c4 1c             	add    $0x1c,%esp
  801e54:	5b                   	pop    %ebx
  801e55:	5e                   	pop    %esi
  801e56:	5f                   	pop    %edi
  801e57:	5d                   	pop    %ebp
  801e58:	c3                   	ret    
  801e59:	8d 76 00             	lea    0x0(%esi),%esi
  801e5c:	31 ff                	xor    %edi,%edi
  801e5e:	31 c0                	xor    %eax,%eax
  801e60:	89 fa                	mov    %edi,%edx
  801e62:	83 c4 1c             	add    $0x1c,%esp
  801e65:	5b                   	pop    %ebx
  801e66:	5e                   	pop    %esi
  801e67:	5f                   	pop    %edi
  801e68:	5d                   	pop    %ebp
  801e69:	c3                   	ret    
  801e6a:	66 90                	xchg   %ax,%ax
  801e6c:	89 d8                	mov    %ebx,%eax
  801e6e:	f7 f7                	div    %edi
  801e70:	31 ff                	xor    %edi,%edi
  801e72:	89 fa                	mov    %edi,%edx
  801e74:	83 c4 1c             	add    $0x1c,%esp
  801e77:	5b                   	pop    %ebx
  801e78:	5e                   	pop    %esi
  801e79:	5f                   	pop    %edi
  801e7a:	5d                   	pop    %ebp
  801e7b:	c3                   	ret    
  801e7c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e81:	89 eb                	mov    %ebp,%ebx
  801e83:	29 fb                	sub    %edi,%ebx
  801e85:	89 f9                	mov    %edi,%ecx
  801e87:	d3 e6                	shl    %cl,%esi
  801e89:	89 c5                	mov    %eax,%ebp
  801e8b:	88 d9                	mov    %bl,%cl
  801e8d:	d3 ed                	shr    %cl,%ebp
  801e8f:	89 e9                	mov    %ebp,%ecx
  801e91:	09 f1                	or     %esi,%ecx
  801e93:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e97:	89 f9                	mov    %edi,%ecx
  801e99:	d3 e0                	shl    %cl,%eax
  801e9b:	89 c5                	mov    %eax,%ebp
  801e9d:	89 d6                	mov    %edx,%esi
  801e9f:	88 d9                	mov    %bl,%cl
  801ea1:	d3 ee                	shr    %cl,%esi
  801ea3:	89 f9                	mov    %edi,%ecx
  801ea5:	d3 e2                	shl    %cl,%edx
  801ea7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eab:	88 d9                	mov    %bl,%cl
  801ead:	d3 e8                	shr    %cl,%eax
  801eaf:	09 c2                	or     %eax,%edx
  801eb1:	89 d0                	mov    %edx,%eax
  801eb3:	89 f2                	mov    %esi,%edx
  801eb5:	f7 74 24 0c          	divl   0xc(%esp)
  801eb9:	89 d6                	mov    %edx,%esi
  801ebb:	89 c3                	mov    %eax,%ebx
  801ebd:	f7 e5                	mul    %ebp
  801ebf:	39 d6                	cmp    %edx,%esi
  801ec1:	72 19                	jb     801edc <__udivdi3+0xfc>
  801ec3:	74 0b                	je     801ed0 <__udivdi3+0xf0>
  801ec5:	89 d8                	mov    %ebx,%eax
  801ec7:	31 ff                	xor    %edi,%edi
  801ec9:	e9 58 ff ff ff       	jmp    801e26 <__udivdi3+0x46>
  801ece:	66 90                	xchg   %ax,%ax
  801ed0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ed4:	89 f9                	mov    %edi,%ecx
  801ed6:	d3 e2                	shl    %cl,%edx
  801ed8:	39 c2                	cmp    %eax,%edx
  801eda:	73 e9                	jae    801ec5 <__udivdi3+0xe5>
  801edc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801edf:	31 ff                	xor    %edi,%edi
  801ee1:	e9 40 ff ff ff       	jmp    801e26 <__udivdi3+0x46>
  801ee6:	66 90                	xchg   %ax,%ax
  801ee8:	31 c0                	xor    %eax,%eax
  801eea:	e9 37 ff ff ff       	jmp    801e26 <__udivdi3+0x46>
  801eef:	90                   	nop

00801ef0 <__umoddi3>:
  801ef0:	55                   	push   %ebp
  801ef1:	57                   	push   %edi
  801ef2:	56                   	push   %esi
  801ef3:	53                   	push   %ebx
  801ef4:	83 ec 1c             	sub    $0x1c,%esp
  801ef7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801efb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801eff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f03:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f07:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f0b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f0f:	89 f3                	mov    %esi,%ebx
  801f11:	89 fa                	mov    %edi,%edx
  801f13:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f17:	89 34 24             	mov    %esi,(%esp)
  801f1a:	85 c0                	test   %eax,%eax
  801f1c:	75 1a                	jne    801f38 <__umoddi3+0x48>
  801f1e:	39 f7                	cmp    %esi,%edi
  801f20:	0f 86 a2 00 00 00    	jbe    801fc8 <__umoddi3+0xd8>
  801f26:	89 c8                	mov    %ecx,%eax
  801f28:	89 f2                	mov    %esi,%edx
  801f2a:	f7 f7                	div    %edi
  801f2c:	89 d0                	mov    %edx,%eax
  801f2e:	31 d2                	xor    %edx,%edx
  801f30:	83 c4 1c             	add    $0x1c,%esp
  801f33:	5b                   	pop    %ebx
  801f34:	5e                   	pop    %esi
  801f35:	5f                   	pop    %edi
  801f36:	5d                   	pop    %ebp
  801f37:	c3                   	ret    
  801f38:	39 f0                	cmp    %esi,%eax
  801f3a:	0f 87 ac 00 00 00    	ja     801fec <__umoddi3+0xfc>
  801f40:	0f bd e8             	bsr    %eax,%ebp
  801f43:	83 f5 1f             	xor    $0x1f,%ebp
  801f46:	0f 84 ac 00 00 00    	je     801ff8 <__umoddi3+0x108>
  801f4c:	bf 20 00 00 00       	mov    $0x20,%edi
  801f51:	29 ef                	sub    %ebp,%edi
  801f53:	89 fe                	mov    %edi,%esi
  801f55:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f59:	89 e9                	mov    %ebp,%ecx
  801f5b:	d3 e0                	shl    %cl,%eax
  801f5d:	89 d7                	mov    %edx,%edi
  801f5f:	89 f1                	mov    %esi,%ecx
  801f61:	d3 ef                	shr    %cl,%edi
  801f63:	09 c7                	or     %eax,%edi
  801f65:	89 e9                	mov    %ebp,%ecx
  801f67:	d3 e2                	shl    %cl,%edx
  801f69:	89 14 24             	mov    %edx,(%esp)
  801f6c:	89 d8                	mov    %ebx,%eax
  801f6e:	d3 e0                	shl    %cl,%eax
  801f70:	89 c2                	mov    %eax,%edx
  801f72:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f76:	d3 e0                	shl    %cl,%eax
  801f78:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f7c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f80:	89 f1                	mov    %esi,%ecx
  801f82:	d3 e8                	shr    %cl,%eax
  801f84:	09 d0                	or     %edx,%eax
  801f86:	d3 eb                	shr    %cl,%ebx
  801f88:	89 da                	mov    %ebx,%edx
  801f8a:	f7 f7                	div    %edi
  801f8c:	89 d3                	mov    %edx,%ebx
  801f8e:	f7 24 24             	mull   (%esp)
  801f91:	89 c6                	mov    %eax,%esi
  801f93:	89 d1                	mov    %edx,%ecx
  801f95:	39 d3                	cmp    %edx,%ebx
  801f97:	0f 82 87 00 00 00    	jb     802024 <__umoddi3+0x134>
  801f9d:	0f 84 91 00 00 00    	je     802034 <__umoddi3+0x144>
  801fa3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fa7:	29 f2                	sub    %esi,%edx
  801fa9:	19 cb                	sbb    %ecx,%ebx
  801fab:	89 d8                	mov    %ebx,%eax
  801fad:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fb1:	d3 e0                	shl    %cl,%eax
  801fb3:	89 e9                	mov    %ebp,%ecx
  801fb5:	d3 ea                	shr    %cl,%edx
  801fb7:	09 d0                	or     %edx,%eax
  801fb9:	89 e9                	mov    %ebp,%ecx
  801fbb:	d3 eb                	shr    %cl,%ebx
  801fbd:	89 da                	mov    %ebx,%edx
  801fbf:	83 c4 1c             	add    $0x1c,%esp
  801fc2:	5b                   	pop    %ebx
  801fc3:	5e                   	pop    %esi
  801fc4:	5f                   	pop    %edi
  801fc5:	5d                   	pop    %ebp
  801fc6:	c3                   	ret    
  801fc7:	90                   	nop
  801fc8:	89 fd                	mov    %edi,%ebp
  801fca:	85 ff                	test   %edi,%edi
  801fcc:	75 0b                	jne    801fd9 <__umoddi3+0xe9>
  801fce:	b8 01 00 00 00       	mov    $0x1,%eax
  801fd3:	31 d2                	xor    %edx,%edx
  801fd5:	f7 f7                	div    %edi
  801fd7:	89 c5                	mov    %eax,%ebp
  801fd9:	89 f0                	mov    %esi,%eax
  801fdb:	31 d2                	xor    %edx,%edx
  801fdd:	f7 f5                	div    %ebp
  801fdf:	89 c8                	mov    %ecx,%eax
  801fe1:	f7 f5                	div    %ebp
  801fe3:	89 d0                	mov    %edx,%eax
  801fe5:	e9 44 ff ff ff       	jmp    801f2e <__umoddi3+0x3e>
  801fea:	66 90                	xchg   %ax,%ax
  801fec:	89 c8                	mov    %ecx,%eax
  801fee:	89 f2                	mov    %esi,%edx
  801ff0:	83 c4 1c             	add    $0x1c,%esp
  801ff3:	5b                   	pop    %ebx
  801ff4:	5e                   	pop    %esi
  801ff5:	5f                   	pop    %edi
  801ff6:	5d                   	pop    %ebp
  801ff7:	c3                   	ret    
  801ff8:	3b 04 24             	cmp    (%esp),%eax
  801ffb:	72 06                	jb     802003 <__umoddi3+0x113>
  801ffd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802001:	77 0f                	ja     802012 <__umoddi3+0x122>
  802003:	89 f2                	mov    %esi,%edx
  802005:	29 f9                	sub    %edi,%ecx
  802007:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80200b:	89 14 24             	mov    %edx,(%esp)
  80200e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802012:	8b 44 24 04          	mov    0x4(%esp),%eax
  802016:	8b 14 24             	mov    (%esp),%edx
  802019:	83 c4 1c             	add    $0x1c,%esp
  80201c:	5b                   	pop    %ebx
  80201d:	5e                   	pop    %esi
  80201e:	5f                   	pop    %edi
  80201f:	5d                   	pop    %ebp
  802020:	c3                   	ret    
  802021:	8d 76 00             	lea    0x0(%esi),%esi
  802024:	2b 04 24             	sub    (%esp),%eax
  802027:	19 fa                	sbb    %edi,%edx
  802029:	89 d1                	mov    %edx,%ecx
  80202b:	89 c6                	mov    %eax,%esi
  80202d:	e9 71 ff ff ff       	jmp    801fa3 <__umoddi3+0xb3>
  802032:	66 90                	xchg   %ax,%ax
  802034:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802038:	72 ea                	jb     802024 <__umoddi3+0x134>
  80203a:	89 d9                	mov    %ebx,%ecx
  80203c:	e9 62 ff ff ff       	jmp    801fa3 <__umoddi3+0xb3>
