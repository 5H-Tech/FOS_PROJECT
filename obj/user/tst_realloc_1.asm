
obj/user/tst_realloc_1:     file format elf32-i386


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
  800031:	e8 38 11 00 00       	call   80116e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 c4 80             	add    $0xffffff80,%esp
	int Mega = 1024*1024;
  800040:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)
	int kilo = 1024;
  800047:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	void* ptr_allocations[20] = {0};
  80004e:	8d 55 80             	lea    -0x80(%ebp),%edx
  800051:	b9 14 00 00 00       	mov    $0x14,%ecx
  800056:	b8 00 00 00 00       	mov    $0x0,%eax
  80005b:	89 d7                	mov    %edx,%edi
  80005d:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  80005f:	83 ec 0c             	sub    $0xc,%esp
  800062:	68 20 2f 80 00       	push   $0x802f20
  800067:	e8 e9 14 00 00       	call   801555 <cprintf>
  80006c:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80006f:	e8 51 27 00 00       	call   8027c5 <sys_calculate_free_frames>
  800074:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800077:	e8 cc 27 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80007c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  80007f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800082:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800085:	83 ec 0c             	sub    $0xc,%esp
  800088:	50                   	push   %eax
  800089:	e8 51 22 00 00       	call   8022df <malloc>
  80008e:	83 c4 10             	add    $0x10,%esp
  800091:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800094:	8b 45 80             	mov    -0x80(%ebp),%eax
  800097:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80009c:	74 14                	je     8000b2 <_main+0x7a>
  80009e:	83 ec 04             	sub    $0x4,%esp
  8000a1:	68 44 2f 80 00       	push   $0x802f44
  8000a6:	6a 11                	push   $0x11
  8000a8:	68 74 2f 80 00       	push   $0x802f74
  8000ad:	e8 01 12 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000b2:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000b5:	e8 0b 27 00 00       	call   8027c5 <sys_calculate_free_frames>
  8000ba:	29 c3                	sub    %eax,%ebx
  8000bc:	89 d8                	mov    %ebx,%eax
  8000be:	83 f8 01             	cmp    $0x1,%eax
  8000c1:	74 14                	je     8000d7 <_main+0x9f>
  8000c3:	83 ec 04             	sub    $0x4,%esp
  8000c6:	68 8c 2f 80 00       	push   $0x802f8c
  8000cb:	6a 13                	push   $0x13
  8000cd:	68 74 2f 80 00       	push   $0x802f74
  8000d2:	e8 dc 11 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256)panic("Extra or less pages are allocated in PageFile");
  8000d7:	e8 6c 27 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8000dc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8000df:	3d 00 01 00 00       	cmp    $0x100,%eax
  8000e4:	74 14                	je     8000fa <_main+0xc2>
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	68 f8 2f 80 00       	push   $0x802ff8
  8000ee:	6a 14                	push   $0x14
  8000f0:	68 74 2f 80 00       	push   $0x802f74
  8000f5:	e8 b9 11 00 00       	call   8012b3 <_panic>
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000fa:	e8 c6 26 00 00       	call   8027c5 <sys_calculate_free_frames>
  8000ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800102:	e8 41 27 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800107:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  80010a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80010d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800110:	83 ec 0c             	sub    $0xc,%esp
  800113:	50                   	push   %eax
  800114:	e8 c6 21 00 00       	call   8022df <malloc>
  800119:	83 c4 10             	add    $0x10,%esp
  80011c:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80011f:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800122:	89 c2                	mov    %eax,%edx
  800124:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800127:	05 00 00 00 80       	add    $0x80000000,%eax
  80012c:	39 c2                	cmp    %eax,%edx
  80012e:	74 14                	je     800144 <_main+0x10c>
  800130:	83 ec 04             	sub    $0x4,%esp
  800133:	68 44 2f 80 00       	push   $0x802f44
  800138:	6a 19                	push   $0x19
  80013a:	68 74 2f 80 00       	push   $0x802f74
  80013f:	e8 6f 11 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800144:	e8 7c 26 00 00       	call   8027c5 <sys_calculate_free_frames>
  800149:	89 c2                	mov    %eax,%edx
  80014b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80014e:	39 c2                	cmp    %eax,%edx
  800150:	74 14                	je     800166 <_main+0x12e>
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	68 8c 2f 80 00       	push   $0x802f8c
  80015a:	6a 1b                	push   $0x1b
  80015c:	68 74 2f 80 00       	push   $0x802f74
  800161:	e8 4d 11 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800166:	e8 dd 26 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80016b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80016e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 f8 2f 80 00       	push   $0x802ff8
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 74 2f 80 00       	push   $0x802f74
  800184:	e8 2a 11 00 00       	call   8012b3 <_panic>
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800189:	e8 37 26 00 00       	call   8027c5 <sys_calculate_free_frames>
  80018e:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800191:	e8 b2 26 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800196:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800199:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80019c:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	50                   	push   %eax
  8001a3:	e8 37 21 00 00       	call   8022df <malloc>
  8001a8:	83 c4 10             	add    $0x10,%esp
  8001ab:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  8001ae:	8b 45 88             	mov    -0x78(%ebp),%eax
  8001b1:	89 c2                	mov    %eax,%edx
  8001b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001b6:	01 c0                	add    %eax,%eax
  8001b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8001bd:	39 c2                	cmp    %eax,%edx
  8001bf:	74 14                	je     8001d5 <_main+0x19d>
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 44 2f 80 00       	push   $0x802f44
  8001c9:	6a 21                	push   $0x21
  8001cb:	68 74 2f 80 00       	push   $0x802f74
  8001d0:	e8 de 10 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001d5:	e8 eb 25 00 00       	call   8027c5 <sys_calculate_free_frames>
  8001da:	89 c2                	mov    %eax,%edx
  8001dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001df:	39 c2                	cmp    %eax,%edx
  8001e1:	74 14                	je     8001f7 <_main+0x1bf>
  8001e3:	83 ec 04             	sub    $0x4,%esp
  8001e6:	68 8c 2f 80 00       	push   $0x802f8c
  8001eb:	6a 23                	push   $0x23
  8001ed:	68 74 2f 80 00       	push   $0x802f74
  8001f2:	e8 bc 10 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  8001f7:	e8 4c 26 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8001fc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001ff:	3d 00 01 00 00       	cmp    $0x100,%eax
  800204:	74 14                	je     80021a <_main+0x1e2>
  800206:	83 ec 04             	sub    $0x4,%esp
  800209:	68 f8 2f 80 00       	push   $0x802ff8
  80020e:	6a 24                	push   $0x24
  800210:	68 74 2f 80 00       	push   $0x802f74
  800215:	e8 99 10 00 00       	call   8012b3 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80021a:	e8 a6 25 00 00       	call   8027c5 <sys_calculate_free_frames>
  80021f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800222:	e8 21 26 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80022a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80022d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	50                   	push   %eax
  800234:	e8 a6 20 00 00       	call   8022df <malloc>
  800239:	83 c4 10             	add    $0x10,%esp
  80023c:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  80023f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800242:	89 c1                	mov    %eax,%ecx
  800244:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800247:	89 c2                	mov    %eax,%edx
  800249:	01 d2                	add    %edx,%edx
  80024b:	01 d0                	add    %edx,%eax
  80024d:	05 00 00 00 80       	add    $0x80000000,%eax
  800252:	39 c1                	cmp    %eax,%ecx
  800254:	74 14                	je     80026a <_main+0x232>
  800256:	83 ec 04             	sub    $0x4,%esp
  800259:	68 44 2f 80 00       	push   $0x802f44
  80025e:	6a 2a                	push   $0x2a
  800260:	68 74 2f 80 00       	push   $0x802f74
  800265:	e8 49 10 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80026a:	e8 56 25 00 00       	call   8027c5 <sys_calculate_free_frames>
  80026f:	89 c2                	mov    %eax,%edx
  800271:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800274:	39 c2                	cmp    %eax,%edx
  800276:	74 14                	je     80028c <_main+0x254>
  800278:	83 ec 04             	sub    $0x4,%esp
  80027b:	68 8c 2f 80 00       	push   $0x802f8c
  800280:	6a 2c                	push   $0x2c
  800282:	68 74 2f 80 00       	push   $0x802f74
  800287:	e8 27 10 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  80028c:	e8 b7 25 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800291:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800294:	3d 00 01 00 00       	cmp    $0x100,%eax
  800299:	74 14                	je     8002af <_main+0x277>
  80029b:	83 ec 04             	sub    $0x4,%esp
  80029e:	68 f8 2f 80 00       	push   $0x802ff8
  8002a3:	6a 2d                	push   $0x2d
  8002a5:	68 74 2f 80 00       	push   $0x802f74
  8002aa:	e8 04 10 00 00       	call   8012b3 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8002af:	e8 11 25 00 00       	call   8027c5 <sys_calculate_free_frames>
  8002b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002b7:	e8 8c 25 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8002bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  8002bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c2:	01 c0                	add    %eax,%eax
  8002c4:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	50                   	push   %eax
  8002cb:	e8 0f 20 00 00       	call   8022df <malloc>
  8002d0:	83 c4 10             	add    $0x10,%esp
  8002d3:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8002d6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8002d9:	89 c2                	mov    %eax,%edx
  8002db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002de:	c1 e0 02             	shl    $0x2,%eax
  8002e1:	05 00 00 00 80       	add    $0x80000000,%eax
  8002e6:	39 c2                	cmp    %eax,%edx
  8002e8:	74 14                	je     8002fe <_main+0x2c6>
  8002ea:	83 ec 04             	sub    $0x4,%esp
  8002ed:	68 44 2f 80 00       	push   $0x802f44
  8002f2:	6a 33                	push   $0x33
  8002f4:	68 74 2f 80 00       	push   $0x802f74
  8002f9:	e8 b5 0f 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002fe:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800301:	e8 bf 24 00 00       	call   8027c5 <sys_calculate_free_frames>
  800306:	29 c3                	sub    %eax,%ebx
  800308:	89 d8                	mov    %ebx,%eax
  80030a:	83 f8 01             	cmp    $0x1,%eax
  80030d:	74 14                	je     800323 <_main+0x2eb>
  80030f:	83 ec 04             	sub    $0x4,%esp
  800312:	68 8c 2f 80 00       	push   $0x802f8c
  800317:	6a 35                	push   $0x35
  800319:	68 74 2f 80 00       	push   $0x802f74
  80031e:	e8 90 0f 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800323:	e8 20 25 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800328:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80032b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800330:	74 14                	je     800346 <_main+0x30e>
  800332:	83 ec 04             	sub    $0x4,%esp
  800335:	68 f8 2f 80 00       	push   $0x802ff8
  80033a:	6a 36                	push   $0x36
  80033c:	68 74 2f 80 00       	push   $0x802f74
  800341:	e8 6d 0f 00 00       	call   8012b3 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800346:	e8 7a 24 00 00       	call   8027c5 <sys_calculate_free_frames>
  80034b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034e:	e8 f5 24 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800353:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  800356:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800359:	01 c0                	add    %eax,%eax
  80035b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80035e:	83 ec 0c             	sub    $0xc,%esp
  800361:	50                   	push   %eax
  800362:	e8 78 1f 00 00       	call   8022df <malloc>
  800367:	83 c4 10             	add    $0x10,%esp
  80036a:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  80036d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800370:	89 c1                	mov    %eax,%ecx
  800372:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800375:	89 d0                	mov    %edx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	05 00 00 00 80       	add    $0x80000000,%eax
  800382:	39 c1                	cmp    %eax,%ecx
  800384:	74 14                	je     80039a <_main+0x362>
  800386:	83 ec 04             	sub    $0x4,%esp
  800389:	68 44 2f 80 00       	push   $0x802f44
  80038e:	6a 3c                	push   $0x3c
  800390:	68 74 2f 80 00       	push   $0x802f74
  800395:	e8 19 0f 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80039a:	e8 26 24 00 00       	call   8027c5 <sys_calculate_free_frames>
  80039f:	89 c2                	mov    %eax,%edx
  8003a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a4:	39 c2                	cmp    %eax,%edx
  8003a6:	74 14                	je     8003bc <_main+0x384>
  8003a8:	83 ec 04             	sub    $0x4,%esp
  8003ab:	68 8c 2f 80 00       	push   $0x802f8c
  8003b0:	6a 3e                	push   $0x3e
  8003b2:	68 74 2f 80 00       	push   $0x802f74
  8003b7:	e8 f7 0e 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8003bc:	e8 87 24 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8003c1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8003c4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003c9:	74 14                	je     8003df <_main+0x3a7>
  8003cb:	83 ec 04             	sub    $0x4,%esp
  8003ce:	68 f8 2f 80 00       	push   $0x802ff8
  8003d3:	6a 3f                	push   $0x3f
  8003d5:	68 74 2f 80 00       	push   $0x802f74
  8003da:	e8 d4 0e 00 00       	call   8012b3 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003df:	e8 e1 23 00 00       	call   8027c5 <sys_calculate_free_frames>
  8003e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003e7:	e8 5c 24 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8003ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8003ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f2:	89 c2                	mov    %eax,%edx
  8003f4:	01 d2                	add    %edx,%edx
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8003fb:	83 ec 0c             	sub    $0xc,%esp
  8003fe:	50                   	push   %eax
  8003ff:	e8 db 1e 00 00       	call   8022df <malloc>
  800404:	83 c4 10             	add    $0x10,%esp
  800407:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  80040a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80040d:	89 c2                	mov    %eax,%edx
  80040f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800412:	c1 e0 03             	shl    $0x3,%eax
  800415:	05 00 00 00 80       	add    $0x80000000,%eax
  80041a:	39 c2                	cmp    %eax,%edx
  80041c:	74 14                	je     800432 <_main+0x3fa>
  80041e:	83 ec 04             	sub    $0x4,%esp
  800421:	68 44 2f 80 00       	push   $0x802f44
  800426:	6a 45                	push   $0x45
  800428:	68 74 2f 80 00       	push   $0x802f74
  80042d:	e8 81 0e 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800432:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800435:	e8 8b 23 00 00       	call   8027c5 <sys_calculate_free_frames>
  80043a:	29 c3                	sub    %eax,%ebx
  80043c:	89 d8                	mov    %ebx,%eax
  80043e:	83 f8 01             	cmp    $0x1,%eax
  800441:	74 14                	je     800457 <_main+0x41f>
  800443:	83 ec 04             	sub    $0x4,%esp
  800446:	68 8c 2f 80 00       	push   $0x802f8c
  80044b:	6a 47                	push   $0x47
  80044d:	68 74 2f 80 00       	push   $0x802f74
  800452:	e8 5c 0e 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800457:	e8 ec 23 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80045c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80045f:	3d 00 03 00 00       	cmp    $0x300,%eax
  800464:	74 14                	je     80047a <_main+0x442>
  800466:	83 ec 04             	sub    $0x4,%esp
  800469:	68 f8 2f 80 00       	push   $0x802ff8
  80046e:	6a 48                	push   $0x48
  800470:	68 74 2f 80 00       	push   $0x802f74
  800475:	e8 39 0e 00 00       	call   8012b3 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80047a:	e8 46 23 00 00       	call   8027c5 <sys_calculate_free_frames>
  80047f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800482:	e8 c1 23 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800487:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  80048a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80048d:	89 c2                	mov    %eax,%edx
  80048f:	01 d2                	add    %edx,%edx
  800491:	01 d0                	add    %edx,%eax
  800493:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800496:	83 ec 0c             	sub    $0xc,%esp
  800499:	50                   	push   %eax
  80049a:	e8 40 1e 00 00       	call   8022df <malloc>
  80049f:	83 c4 10             	add    $0x10,%esp
  8004a2:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[7] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8004a5:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004a8:	89 c1                	mov    %eax,%ecx
  8004aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004ad:	89 d0                	mov    %edx,%eax
  8004af:	c1 e0 02             	shl    $0x2,%eax
  8004b2:	01 d0                	add    %edx,%eax
  8004b4:	01 c0                	add    %eax,%eax
  8004b6:	01 d0                	add    %edx,%eax
  8004b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8004bd:	39 c1                	cmp    %eax,%ecx
  8004bf:	74 14                	je     8004d5 <_main+0x49d>
  8004c1:	83 ec 04             	sub    $0x4,%esp
  8004c4:	68 44 2f 80 00       	push   $0x802f44
  8004c9:	6a 4e                	push   $0x4e
  8004cb:	68 74 2f 80 00       	push   $0x802f74
  8004d0:	e8 de 0d 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8004d5:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8004d8:	e8 e8 22 00 00       	call   8027c5 <sys_calculate_free_frames>
  8004dd:	29 c3                	sub    %eax,%ebx
  8004df:	89 d8                	mov    %ebx,%eax
  8004e1:	83 f8 01             	cmp    $0x1,%eax
  8004e4:	74 14                	je     8004fa <_main+0x4c2>
  8004e6:	83 ec 04             	sub    $0x4,%esp
  8004e9:	68 8c 2f 80 00       	push   $0x802f8c
  8004ee:	6a 50                	push   $0x50
  8004f0:	68 74 2f 80 00       	push   $0x802f74
  8004f5:	e8 b9 0d 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  8004fa:	e8 49 23 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8004ff:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800502:	3d 00 03 00 00       	cmp    $0x300,%eax
  800507:	74 14                	je     80051d <_main+0x4e5>
  800509:	83 ec 04             	sub    $0x4,%esp
  80050c:	68 f8 2f 80 00       	push   $0x802ff8
  800511:	6a 51                	push   $0x51
  800513:	68 74 2f 80 00       	push   $0x802f74
  800518:	e8 96 0d 00 00       	call   8012b3 <_panic>


		//NEW
		//Filling the remaining size of user heap
		freeFrames = sys_calculate_free_frames() ;
  80051d:	e8 a3 22 00 00       	call   8027c5 <sys_calculate_free_frames>
  800522:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800525:	e8 1e 23 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80052a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		uint32 remainingSpaceInUHeap = (USER_HEAP_MAX - USER_HEAP_START) - 14 * Mega;
  80052d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800530:	89 d0                	mov    %edx,%eax
  800532:	01 c0                	add    %eax,%eax
  800534:	01 d0                	add    %edx,%eax
  800536:	01 c0                	add    %eax,%eax
  800538:	01 d0                	add    %edx,%eax
  80053a:	01 c0                	add    %eax,%eax
  80053c:	f7 d8                	neg    %eax
  80053e:	05 00 00 00 20       	add    $0x20000000,%eax
  800543:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(remainingSpaceInUHeap - kilo);
  800546:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800549:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054c:	29 c2                	sub    %eax,%edx
  80054e:	89 d0                	mov    %edx,%eax
  800550:	83 ec 0c             	sub    $0xc,%esp
  800553:	50                   	push   %eax
  800554:	e8 86 1d 00 00       	call   8022df <malloc>
  800559:	83 c4 10             	add    $0x10,%esp
  80055c:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  80055f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800562:	89 c1                	mov    %eax,%ecx
  800564:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800567:	89 d0                	mov    %edx,%eax
  800569:	01 c0                	add    %eax,%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	01 c0                	add    %eax,%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	01 c0                	add    %eax,%eax
  800573:	05 00 00 00 80       	add    $0x80000000,%eax
  800578:	39 c1                	cmp    %eax,%ecx
  80057a:	74 14                	je     800590 <_main+0x558>
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 44 2f 80 00       	push   $0x802f44
  800584:	6a 5a                	push   $0x5a
  800586:	68 74 2f 80 00       	push   $0x802f74
  80058b:	e8 23 0d 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 124) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800590:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800593:	e8 2d 22 00 00       	call   8027c5 <sys_calculate_free_frames>
  800598:	29 c3                	sub    %eax,%ebx
  80059a:	89 d8                	mov    %ebx,%eax
  80059c:	83 f8 7c             	cmp    $0x7c,%eax
  80059f:	74 14                	je     8005b5 <_main+0x57d>
  8005a1:	83 ec 04             	sub    $0x4,%esp
  8005a4:	68 8c 2f 80 00       	push   $0x802f8c
  8005a9:	6a 5c                	push   $0x5c
  8005ab:	68 74 2f 80 00       	push   $0x802f74
  8005b0:	e8 fe 0c 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 127488) panic("Extra or less pages are allocated in PageFile");
  8005b5:	e8 8e 22 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8005ba:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8005bd:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  8005c2:	74 14                	je     8005d8 <_main+0x5a0>
  8005c4:	83 ec 04             	sub    $0x4,%esp
  8005c7:	68 f8 2f 80 00       	push   $0x802ff8
  8005cc:	6a 5d                	push   $0x5d
  8005ce:	68 74 2f 80 00       	push   $0x802f74
  8005d3:	e8 db 0c 00 00       	call   8012b3 <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005d8:	e8 e8 21 00 00       	call   8027c5 <sys_calculate_free_frames>
  8005dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005e0:	e8 63 22 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8005e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[1]);
  8005e8:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8005eb:	83 ec 0c             	sub    $0xc,%esp
  8005ee:	50                   	push   %eax
  8005ef:	e8 fb 1e 00 00       	call   8024ef <free>
  8005f4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  8005f7:	e8 4c 22 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8005fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8005ff:	29 c2                	sub    %eax,%edx
  800601:	89 d0                	mov    %edx,%eax
  800603:	3d 00 01 00 00       	cmp    $0x100,%eax
  800608:	74 14                	je     80061e <_main+0x5e6>
  80060a:	83 ec 04             	sub    $0x4,%esp
  80060d:	68 28 30 80 00       	push   $0x803028
  800612:	6a 68                	push   $0x68
  800614:	68 74 2f 80 00       	push   $0x802f74
  800619:	e8 95 0c 00 00       	call   8012b3 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80061e:	e8 a2 21 00 00       	call   8027c5 <sys_calculate_free_frames>
  800623:	89 c2                	mov    %eax,%edx
  800625:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800628:	39 c2                	cmp    %eax,%edx
  80062a:	74 14                	je     800640 <_main+0x608>
  80062c:	83 ec 04             	sub    $0x4,%esp
  80062f:	68 64 30 80 00       	push   $0x803064
  800634:	6a 69                	push   $0x69
  800636:	68 74 2f 80 00       	push   $0x802f74
  80063b:	e8 73 0c 00 00       	call   8012b3 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800640:	e8 80 21 00 00       	call   8027c5 <sys_calculate_free_frames>
  800645:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800648:	e8 fb 21 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80064d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[4]);
  800650:	8b 45 90             	mov    -0x70(%ebp),%eax
  800653:	83 ec 0c             	sub    $0xc,%esp
  800656:	50                   	push   %eax
  800657:	e8 93 1e 00 00       	call   8024ef <free>
  80065c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  80065f:	e8 e4 21 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800664:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800667:	29 c2                	sub    %eax,%edx
  800669:	89 d0                	mov    %edx,%eax
  80066b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800670:	74 14                	je     800686 <_main+0x64e>
  800672:	83 ec 04             	sub    $0x4,%esp
  800675:	68 28 30 80 00       	push   $0x803028
  80067a:	6a 70                	push   $0x70
  80067c:	68 74 2f 80 00       	push   $0x802f74
  800681:	e8 2d 0c 00 00       	call   8012b3 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800686:	e8 3a 21 00 00       	call   8027c5 <sys_calculate_free_frames>
  80068b:	89 c2                	mov    %eax,%edx
  80068d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800690:	39 c2                	cmp    %eax,%edx
  800692:	74 14                	je     8006a8 <_main+0x670>
  800694:	83 ec 04             	sub    $0x4,%esp
  800697:	68 64 30 80 00       	push   $0x803064
  80069c:	6a 71                	push   $0x71
  80069e:	68 74 2f 80 00       	push   $0x802f74
  8006a3:	e8 0b 0c 00 00       	call   8012b3 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8006a8:	e8 18 21 00 00       	call   8027c5 <sys_calculate_free_frames>
  8006ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006b0:	e8 93 21 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8006b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[6]);
  8006b8:	8b 45 98             	mov    -0x68(%ebp),%eax
  8006bb:	83 ec 0c             	sub    $0xc,%esp
  8006be:	50                   	push   %eax
  8006bf:	e8 2b 1e 00 00       	call   8024ef <free>
  8006c4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 768) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006c7:	e8 7c 21 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  8006cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006cf:	29 c2                	sub    %eax,%edx
  8006d1:	89 d0                	mov    %edx,%eax
  8006d3:	3d 00 03 00 00       	cmp    $0x300,%eax
  8006d8:	74 14                	je     8006ee <_main+0x6b6>
  8006da:	83 ec 04             	sub    $0x4,%esp
  8006dd:	68 28 30 80 00       	push   $0x803028
  8006e2:	6a 78                	push   $0x78
  8006e4:	68 74 2f 80 00       	push   $0x802f74
  8006e9:	e8 c5 0b 00 00       	call   8012b3 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8006ee:	e8 d2 20 00 00       	call   8027c5 <sys_calculate_free_frames>
  8006f3:	89 c2                	mov    %eax,%edx
  8006f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f8:	39 c2                	cmp    %eax,%edx
  8006fa:	74 14                	je     800710 <_main+0x6d8>
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 64 30 80 00       	push   $0x803064
  800704:	6a 79                	push   $0x79
  800706:	68 74 2f 80 00       	push   $0x802f74
  80070b:	e8 a3 0b 00 00       	call   8012b3 <_panic>

		//NEW
		//free the latest Hole (the big one)
		freeFrames = sys_calculate_free_frames() ;
  800710:	e8 b0 20 00 00       	call   8027c5 <sys_calculate_free_frames>
  800715:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800718:	e8 2b 21 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80071d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[8]);
  800720:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800723:	83 ec 0c             	sub    $0xc,%esp
  800726:	50                   	push   %eax
  800727:	e8 c3 1d 00 00       	call   8024ef <free>
  80072c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 127488) panic("Wrong free: Extra or less pages are removed from PageFile");
  80072f:	e8 14 21 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800734:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800737:	29 c2                	sub    %eax,%edx
  800739:	89 d0                	mov    %edx,%eax
  80073b:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  800740:	74 17                	je     800759 <_main+0x721>
  800742:	83 ec 04             	sub    $0x4,%esp
  800745:	68 28 30 80 00       	push   $0x803028
  80074a:	68 81 00 00 00       	push   $0x81
  80074f:	68 74 2f 80 00       	push   $0x802f74
  800754:	e8 5a 0b 00 00       	call   8012b3 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800759:	e8 67 20 00 00       	call   8027c5 <sys_calculate_free_frames>
  80075e:	89 c2                	mov    %eax,%edx
  800760:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800763:	39 c2                	cmp    %eax,%edx
  800765:	74 17                	je     80077e <_main+0x746>
  800767:	83 ec 04             	sub    $0x4,%esp
  80076a:	68 64 30 80 00       	push   $0x803064
  80076f:	68 82 00 00 00       	push   $0x82
  800774:	68 74 2f 80 00       	push   $0x802f74
  800779:	e8 35 0b 00 00       	call   8012b3 <_panic>
	}
	int cnt = 0;
  80077e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	//[3] Test Re-allocation
	{
		/*CASE1: Re-allocate that's fit in the same location*/

		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800785:	e8 3b 20 00 00       	call   8027c5 <sys_calculate_free_frames>
  80078a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80078d:	e8 b6 20 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800792:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = malloc(512*kilo - kilo);
  800795:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800798:	89 d0                	mov    %edx,%eax
  80079a:	c1 e0 09             	shl    $0x9,%eax
  80079d:	29 d0                	sub    %edx,%eax
  80079f:	83 ec 0c             	sub    $0xc,%esp
  8007a2:	50                   	push   %eax
  8007a3:	e8 37 1b 00 00       	call   8022df <malloc>
  8007a8:	83 c4 10             	add    $0x10,%esp
  8007ab:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[9] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8007ae:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8007b1:	89 c2                	mov    %eax,%edx
  8007b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b6:	05 00 00 00 80       	add    $0x80000000,%eax
  8007bb:	39 c2                	cmp    %eax,%edx
  8007bd:	74 17                	je     8007d6 <_main+0x79e>
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	68 44 2f 80 00       	push   $0x802f44
  8007c7:	68 8e 00 00 00       	push   $0x8e
  8007cc:	68 74 2f 80 00       	push   $0x802f74
  8007d1:	e8 dd 0a 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8007d6:	e8 ea 1f 00 00       	call   8027c5 <sys_calculate_free_frames>
  8007db:	89 c2                	mov    %eax,%edx
  8007dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007e0:	39 c2                	cmp    %eax,%edx
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 8c 2f 80 00       	push   $0x802f8c
  8007ec:	68 90 00 00 00       	push   $0x90
  8007f1:	68 74 2f 80 00       	push   $0x802f74
  8007f6:	e8 b8 0a 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 128) panic("Extra or less pages are allocated in PageFile");
  8007fb:	e8 48 20 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800800:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800803:	3d 80 00 00 00       	cmp    $0x80,%eax
  800808:	74 17                	je     800821 <_main+0x7e9>
  80080a:	83 ec 04             	sub    $0x4,%esp
  80080d:	68 f8 2f 80 00       	push   $0x802ff8
  800812:	68 91 00 00 00       	push   $0x91
  800817:	68 74 2f 80 00       	push   $0x802f74
  80081c:	e8 92 0a 00 00       	call   8012b3 <_panic>

		//Fill it with data
		int *intArr = (int*) ptr_allocations[9];
  800821:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800824:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int lastIndexOfInt1 = ((512)*kilo)/sizeof(int) - 1;
  800827:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80082a:	c1 e0 09             	shl    $0x9,%eax
  80082d:	c1 e8 02             	shr    $0x2,%eax
  800830:	48                   	dec    %eax
  800831:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		int i = 0;
  800834:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)



		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  80083b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800842:	eb 17                	jmp    80085b <_main+0x823>
		{
			intArr[i] = i ;
  800844:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800847:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80084e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800851:	01 c2                	add    %eax,%edx
  800853:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800856:	89 02                	mov    %eax,(%edx)



		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800858:	ff 45 f4             	incl   -0xc(%ebp)
  80085b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  80085f:	7e e3                	jle    800844 <_main+0x80c>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800861:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800864:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800867:	eb 17                	jmp    800880 <_main+0x848>
		{
			intArr[i] = i ;
  800869:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80086c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800873:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800876:	01 c2                	add    %eax,%edx
  800878:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80087b:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  80087d:	ff 4d f4             	decl   -0xc(%ebp)
  800880:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800883:	83 e8 64             	sub    $0x64,%eax
  800886:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800889:	7c de                	jl     800869 <_main+0x831>
		{
			intArr[i] = i ;
		}

		//Reallocate it [expanded in the same place]
		freeFrames = sys_calculate_free_frames() ;
  80088b:	e8 35 1f 00 00       	call   8027c5 <sys_calculate_free_frames>
  800890:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800893:	e8 b0 1f 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800898:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = realloc(ptr_allocations[9], 512*kilo + 256*kilo - kilo);
  80089b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80089e:	89 d0                	mov    %edx,%eax
  8008a0:	01 c0                	add    %eax,%eax
  8008a2:	01 d0                	add    %edx,%eax
  8008a4:	c1 e0 08             	shl    $0x8,%eax
  8008a7:	29 d0                	sub    %edx,%eax
  8008a9:	89 c2                	mov    %eax,%edx
  8008ab:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8008ae:	83 ec 08             	sub    $0x8,%esp
  8008b1:	52                   	push   %edx
  8008b2:	50                   	push   %eax
  8008b3:	e8 2d 1d 00 00       	call   8025e5 <realloc>
  8008b8:	83 c4 10             	add    $0x10,%esp
  8008bb:	89 45 a4             	mov    %eax,-0x5c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the re-allocated space... ");
  8008be:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8008c1:	89 c2                	mov    %eax,%edx
  8008c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c6:	05 00 00 00 80       	add    $0x80000000,%eax
  8008cb:	39 c2                	cmp    %eax,%edx
  8008cd:	74 17                	je     8008e6 <_main+0x8ae>
  8008cf:	83 ec 04             	sub    $0x4,%esp
  8008d2:	68 b0 30 80 00       	push   $0x8030b0
  8008d7:	68 ae 00 00 00       	push   $0xae
  8008dc:	68 74 2f 80 00       	push   $0x802f74
  8008e1:	e8 cd 09 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  8008e6:	e8 da 1e 00 00       	call   8027c5 <sys_calculate_free_frames>
  8008eb:	89 c2                	mov    %eax,%edx
  8008ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008f0:	39 c2                	cmp    %eax,%edx
  8008f2:	74 17                	je     80090b <_main+0x8d3>
  8008f4:	83 ec 04             	sub    $0x4,%esp
  8008f7:	68 e4 30 80 00       	push   $0x8030e4
  8008fc:	68 b0 00 00 00       	push   $0xb0
  800901:	68 74 2f 80 00       	push   $0x802f74
  800906:	e8 a8 09 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 64) panic("Extra or less pages are re-allocated in PageFile");
  80090b:	e8 38 1f 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800910:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800913:	83 f8 40             	cmp    $0x40,%eax
  800916:	74 17                	je     80092f <_main+0x8f7>
  800918:	83 ec 04             	sub    $0x4,%esp
  80091b:	68 54 31 80 00       	push   $0x803154
  800920:	68 b1 00 00 00       	push   $0xb1
  800925:	68 74 2f 80 00       	push   $0x802f74
  80092a:	e8 84 09 00 00       	call   8012b3 <_panic>


		//[2] test memory access
		int lastIndexOfInt2 = ((512+256)*kilo)/sizeof(int) - 1;
  80092f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800932:	89 d0                	mov    %edx,%eax
  800934:	01 c0                	add    %eax,%eax
  800936:	01 d0                	add    %edx,%eax
  800938:	c1 e0 08             	shl    $0x8,%eax
  80093b:	c1 e8 02             	shr    $0x2,%eax
  80093e:	48                   	dec    %eax
  80093f:	89 45 d0             	mov    %eax,-0x30(%ebp)

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800942:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800945:	40                   	inc    %eax
  800946:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800949:	eb 17                	jmp    800962 <_main+0x92a>
		{
			intArr[i] = i;
  80094b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80094e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800955:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800958:	01 c2                	add    %eax,%edx
  80095a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80095d:	89 02                	mov    %eax,(%edx)
		//[2] test memory access
		int lastIndexOfInt2 = ((512+256)*kilo)/sizeof(int) - 1;

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  80095f:	ff 45 f4             	incl   -0xc(%ebp)
  800962:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800965:	83 c0 65             	add    $0x65,%eax
  800968:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80096b:	7f de                	jg     80094b <_main+0x913>
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80096d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800970:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800973:	eb 17                	jmp    80098c <_main+0x954>
		{
			intArr[i] = i;
  800975:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800978:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80097f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800982:	01 c2                	add    %eax,%edx
  800984:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800987:	89 02                	mov    %eax,(%edx)
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800989:	ff 4d f4             	decl   -0xc(%ebp)
  80098c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80098f:	83 e8 64             	sub    $0x64,%eax
  800992:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800995:	7c de                	jl     800975 <_main+0x93d>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800997:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80099e:	eb 30                	jmp    8009d0 <_main+0x998>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8009ad:	01 d0                	add    %edx,%eax
  8009af:	8b 00                	mov    (%eax),%eax
  8009b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8009b4:	74 17                	je     8009cd <_main+0x995>
  8009b6:	83 ec 04             	sub    $0x4,%esp
  8009b9:	68 88 31 80 00       	push   $0x803188
  8009be:	68 c6 00 00 00       	push   $0xc6
  8009c3:	68 74 2f 80 00       	push   $0x802f74
  8009c8:	e8 e6 08 00 00       	call   8012b3 <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  8009cd:	ff 45 f4             	incl   -0xc(%ebp)
  8009d0:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  8009d4:	7e ca                	jle    8009a0 <_main+0x968>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  8009d6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8009dc:	eb 30                	jmp    800a0e <_main+0x9d6>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009e8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8009eb:	01 d0                	add    %edx,%eax
  8009ed:	8b 00                	mov    (%eax),%eax
  8009ef:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8009f2:	74 17                	je     800a0b <_main+0x9d3>
  8009f4:	83 ec 04             	sub    $0x4,%esp
  8009f7:	68 88 31 80 00       	push   $0x803188
  8009fc:	68 cc 00 00 00       	push   $0xcc
  800a01:	68 74 2f 80 00       	push   $0x802f74
  800a06:	e8 a8 08 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800a0b:	ff 4d f4             	decl   -0xc(%ebp)
  800a0e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a11:	83 e8 64             	sub    $0x64,%eax
  800a14:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a17:	7c c5                	jl     8009de <_main+0x9a6>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800a19:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a1c:	40                   	inc    %eax
  800a1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a20:	eb 30                	jmp    800a52 <_main+0xa1a>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a25:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a2c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800a2f:	01 d0                	add    %edx,%eax
  800a31:	8b 00                	mov    (%eax),%eax
  800a33:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a36:	74 17                	je     800a4f <_main+0xa17>
  800a38:	83 ec 04             	sub    $0x4,%esp
  800a3b:	68 88 31 80 00       	push   $0x803188
  800a40:	68 d2 00 00 00       	push   $0xd2
  800a45:	68 74 2f 80 00       	push   $0x802f74
  800a4a:	e8 64 08 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800a4f:	ff 45 f4             	incl   -0xc(%ebp)
  800a52:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a55:	83 c0 65             	add    $0x65,%eax
  800a58:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a5b:	7f c5                	jg     800a22 <_main+0x9ea>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800a5d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a63:	eb 30                	jmp    800a95 <_main+0xa5d>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800a72:	01 d0                	add    %edx,%eax
  800a74:	8b 00                	mov    (%eax),%eax
  800a76:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a79:	74 17                	je     800a92 <_main+0xa5a>
  800a7b:	83 ec 04             	sub    $0x4,%esp
  800a7e:	68 88 31 80 00       	push   $0x803188
  800a83:	68 d8 00 00 00       	push   $0xd8
  800a88:	68 74 2f 80 00       	push   $0x802f74
  800a8d:	e8 21 08 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800a92:	ff 4d f4             	decl   -0xc(%ebp)
  800a95:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a98:	83 e8 64             	sub    $0x64,%eax
  800a9b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a9e:	7c c5                	jl     800a65 <_main+0xa2d>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800aa0:	e8 20 1d 00 00       	call   8027c5 <sys_calculate_free_frames>
  800aa5:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800aa8:	e8 9b 1d 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800aad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[9]);
  800ab0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800ab3:	83 ec 0c             	sub    $0xc,%esp
  800ab6:	50                   	push   %eax
  800ab7:	e8 33 1a 00 00       	call   8024ef <free>
  800abc:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 192) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 192) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800abf:	e8 84 1d 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800ac4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ac7:	29 c2                	sub    %eax,%edx
  800ac9:	89 d0                	mov    %edx,%eax
  800acb:	3d c0 00 00 00       	cmp    $0xc0,%eax
  800ad0:	74 17                	je     800ae9 <_main+0xab1>
  800ad2:	83 ec 04             	sub    $0x4,%esp
  800ad5:	68 c0 31 80 00       	push   $0x8031c0
  800ada:	68 e0 00 00 00       	push   $0xe0
  800adf:	68 74 2f 80 00       	push   $0x802f74
  800ae4:	e8 ca 07 00 00       	call   8012b3 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ae9:	e8 d7 1c 00 00       	call   8027c5 <sys_calculate_free_frames>
  800aee:	89 c2                	mov    %eax,%edx
  800af0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800af3:	29 c2                	sub    %eax,%edx
  800af5:	89 d0                	mov    %edx,%eax
  800af7:	83 f8 05             	cmp    $0x5,%eax
  800afa:	74 17                	je     800b13 <_main+0xadb>
  800afc:	83 ec 04             	sub    $0x4,%esp
  800aff:	68 64 30 80 00       	push   $0x803064
  800b04:	68 e1 00 00 00       	push   $0xe1
  800b09:	68 74 2f 80 00       	push   $0x802f74
  800b0e:	e8 a0 07 00 00       	call   8012b3 <_panic>

		vcprintf("\b\b\b40%", NULL);
  800b13:	83 ec 08             	sub    $0x8,%esp
  800b16:	6a 00                	push   $0x0
  800b18:	68 14 32 80 00       	push   $0x803214
  800b1d:	e8 c8 09 00 00       	call   8014ea <vcprintf>
  800b22:	83 c4 10             	add    $0x10,%esp

		/*CASE2: Re-allocate that's not fit in the same location*/

		//Allocate 1.5 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800b25:	e8 9b 1c 00 00       	call   8027c5 <sys_calculate_free_frames>
  800b2a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b2d:	e8 16 1d 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800b32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = malloc(1*Mega + 512*kilo - kilo);
  800b35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b38:	c1 e0 09             	shl    $0x9,%eax
  800b3b:	89 c2                	mov    %eax,%edx
  800b3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b40:	01 d0                	add    %edx,%eax
  800b42:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800b45:	83 ec 0c             	sub    $0xc,%esp
  800b48:	50                   	push   %eax
  800b49:	e8 91 17 00 00       	call   8022df <malloc>
  800b4e:	83 c4 10             	add    $0x10,%esp
  800b51:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[9] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800b54:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800b57:	89 c2                	mov    %eax,%edx
  800b59:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5c:	c1 e0 02             	shl    $0x2,%eax
  800b5f:	05 00 00 00 80       	add    $0x80000000,%eax
  800b64:	39 c2                	cmp    %eax,%edx
  800b66:	74 17                	je     800b7f <_main+0xb47>
  800b68:	83 ec 04             	sub    $0x4,%esp
  800b6b:	68 44 2f 80 00       	push   $0x802f44
  800b70:	68 eb 00 00 00       	push   $0xeb
  800b75:	68 74 2f 80 00       	push   $0x802f74
  800b7a:	e8 34 07 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 384) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800b7f:	e8 41 1c 00 00       	call   8027c5 <sys_calculate_free_frames>
  800b84:	89 c2                	mov    %eax,%edx
  800b86:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b89:	39 c2                	cmp    %eax,%edx
  800b8b:	74 17                	je     800ba4 <_main+0xb6c>
  800b8d:	83 ec 04             	sub    $0x4,%esp
  800b90:	68 8c 2f 80 00       	push   $0x802f8c
  800b95:	68 ed 00 00 00       	push   $0xed
  800b9a:	68 74 2f 80 00       	push   $0x802f74
  800b9f:	e8 0f 07 00 00       	call   8012b3 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 384) panic("Extra or less pages are allocated in PageFile");
  800ba4:	e8 9f 1c 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800ba9:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800bac:	3d 80 01 00 00       	cmp    $0x180,%eax
  800bb1:	74 17                	je     800bca <_main+0xb92>
  800bb3:	83 ec 04             	sub    $0x4,%esp
  800bb6:	68 f8 2f 80 00       	push   $0x802ff8
  800bbb:	68 ee 00 00 00       	push   $0xee
  800bc0:	68 74 2f 80 00       	push   $0x802f74
  800bc5:	e8 e9 06 00 00       	call   8012b3 <_panic>

		//Fill it with data
		intArr = (int*) ptr_allocations[9];
  800bca:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800bcd:	89 45 d8             	mov    %eax,-0x28(%ebp)
		lastIndexOfInt1 = (1*Mega + 512*kilo)/sizeof(int) - 1;
  800bd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd3:	c1 e0 09             	shl    $0x9,%eax
  800bd6:	89 c2                	mov    %eax,%edx
  800bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bdb:	01 d0                	add    %edx,%eax
  800bdd:	c1 e8 02             	shr    $0x2,%eax
  800be0:	48                   	dec    %eax
  800be1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		i = 0;
  800be4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800beb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800bf2:	eb 17                	jmp    800c0b <_main+0xbd3>
		{
			intArr[i] = i ;
  800bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bf7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800bfe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c01:	01 c2                	add    %eax,%edx
  800c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c06:	89 02                	mov    %eax,(%edx)
		lastIndexOfInt1 = (1*Mega + 512*kilo)/sizeof(int) - 1;
		i = 0;

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800c08:	ff 45 f4             	incl   -0xc(%ebp)
  800c0b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800c0f:	7e e3                	jle    800bf4 <_main+0xbbc>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800c11:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800c17:	eb 17                	jmp    800c30 <_main+0xbf8>
		{
			intArr[i] = i ;
  800c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c1c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c23:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c26:	01 c2                	add    %eax,%edx
  800c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c2b:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800c2d:	ff 4d f4             	decl   -0xc(%ebp)
  800c30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c33:	83 e8 64             	sub    $0x64,%eax
  800c36:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800c39:	7c de                	jl     800c19 <_main+0xbe1>
		{
			intArr[i] = i ;
		}

		//Reallocate it to 2.5 MB [should be moved to next hole]
		freeFrames = sys_calculate_free_frames() ;
  800c3b:	e8 85 1b 00 00       	call   8027c5 <sys_calculate_free_frames>
  800c40:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c43:	e8 00 1c 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800c48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = realloc(ptr_allocations[9], 1*Mega + 512*kilo + 1*Mega - kilo);
  800c4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c4e:	c1 e0 09             	shl    $0x9,%eax
  800c51:	89 c2                	mov    %eax,%edx
  800c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c56:	01 c2                	add    %eax,%edx
  800c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5b:	01 d0                	add    %edx,%eax
  800c5d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800c60:	89 c2                	mov    %eax,%edx
  800c62:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	52                   	push   %edx
  800c69:	50                   	push   %eax
  800c6a:	e8 76 19 00 00       	call   8025e5 <realloc>
  800c6f:	83 c4 10             	add    $0x10,%esp
  800c72:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the re-allocated space... ");
  800c75:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800c78:	89 c2                	mov    %eax,%edx
  800c7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7d:	c1 e0 03             	shl    $0x3,%eax
  800c80:	05 00 00 00 80       	add    $0x80000000,%eax
  800c85:	39 c2                	cmp    %eax,%edx
  800c87:	74 17                	je     800ca0 <_main+0xc68>
  800c89:	83 ec 04             	sub    $0x4,%esp
  800c8c:	68 b0 30 80 00       	push   $0x8030b0
  800c91:	68 07 01 00 00       	push   $0x107
  800c96:	68 74 2f 80 00       	push   $0x802f74
  800c9b:	e8 13 06 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong re-allocation");

		//if((sys_calculate_free_frames() - freeFrames) != 3) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are re-allocated in PageFile");
  800ca0:	e8 a3 1b 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800ca5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800ca8:	3d 00 01 00 00       	cmp    $0x100,%eax
  800cad:	74 17                	je     800cc6 <_main+0xc8e>
  800caf:	83 ec 04             	sub    $0x4,%esp
  800cb2:	68 54 31 80 00       	push   $0x803154
  800cb7:	68 0b 01 00 00       	push   $0x10b
  800cbc:	68 74 2f 80 00       	push   $0x802f74
  800cc1:	e8 ed 05 00 00       	call   8012b3 <_panic>

		//[2] test memory access
		lastIndexOfInt2 = (2*Mega + 512*kilo)/sizeof(int) - 1;
  800cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc9:	c1 e0 08             	shl    $0x8,%eax
  800ccc:	89 c2                	mov    %eax,%edx
  800cce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd1:	01 d0                	add    %edx,%eax
  800cd3:	01 c0                	add    %eax,%eax
  800cd5:	c1 e8 02             	shr    $0x2,%eax
  800cd8:	48                   	dec    %eax
  800cd9:	89 45 d0             	mov    %eax,-0x30(%ebp)
		intArr = (int*) ptr_allocations[9];
  800cdc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800cdf:	89 45 d8             	mov    %eax,-0x28(%ebp)



		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800ce2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ce5:	40                   	inc    %eax
  800ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ce9:	eb 17                	jmp    800d02 <_main+0xcca>
		{
			intArr[i] = i;
  800ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cf5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800cf8:	01 c2                	add    %eax,%edx
  800cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cfd:	89 02                	mov    %eax,(%edx)



		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800cff:	ff 45 f4             	incl   -0xc(%ebp)
  800d02:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d05:	83 c0 65             	add    $0x65,%eax
  800d08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d0b:	7f de                	jg     800ceb <_main+0xcb3>
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800d0d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d13:	eb 17                	jmp    800d2c <_main+0xcf4>
		{
			intArr[i] = i;
  800d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d18:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d1f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d22:	01 c2                	add    %eax,%edx
  800d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d27:	89 02                	mov    %eax,(%edx)
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800d29:	ff 4d f4             	decl   -0xc(%ebp)
  800d2c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d2f:	83 e8 64             	sub    $0x64,%eax
  800d32:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d35:	7c de                	jl     800d15 <_main+0xcdd>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800d37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800d3e:	eb 30                	jmp    800d70 <_main+0xd38>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d4d:	01 d0                	add    %edx,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d54:	74 17                	je     800d6d <_main+0xd35>
  800d56:	83 ec 04             	sub    $0x4,%esp
  800d59:	68 88 31 80 00       	push   $0x803188
  800d5e:	68 22 01 00 00       	push   $0x122
  800d63:	68 74 2f 80 00       	push   $0x802f74
  800d68:	e8 46 05 00 00       	call   8012b3 <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800d6d:	ff 45 f4             	incl   -0xc(%ebp)
  800d70:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800d74:	7e ca                	jle    800d40 <_main+0xd08>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d76:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d7c:	eb 30                	jmp    800dae <_main+0xd76>
		{
			if (intArr[i] != i)
  800d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d81:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d88:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d8b:	01 d0                	add    %edx,%eax
  800d8d:	8b 00                	mov    (%eax),%eax
  800d8f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d92:	74 17                	je     800dab <_main+0xd73>
			{
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800d94:	83 ec 04             	sub    $0x4,%esp
  800d97:	68 88 31 80 00       	push   $0x803188
  800d9c:	68 2a 01 00 00       	push   $0x12a
  800da1:	68 74 2f 80 00       	push   $0x802f74
  800da6:	e8 08 05 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800dab:	ff 4d f4             	decl   -0xc(%ebp)
  800dae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800db1:	83 e8 64             	sub    $0x64,%eax
  800db4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800db7:	7c c5                	jl     800d7e <_main+0xd46>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800db9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dbc:	40                   	inc    %eax
  800dbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dc0:	eb 30                	jmp    800df2 <_main+0xdba>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dc5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800dcc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800dcf:	01 d0                	add    %edx,%eax
  800dd1:	8b 00                	mov    (%eax),%eax
  800dd3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800dd6:	74 17                	je     800def <_main+0xdb7>
  800dd8:	83 ec 04             	sub    $0x4,%esp
  800ddb:	68 88 31 80 00       	push   $0x803188
  800de0:	68 31 01 00 00       	push   $0x131
  800de5:	68 74 2f 80 00       	push   $0x802f74
  800dea:	e8 c4 04 00 00       	call   8012b3 <_panic>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800def:	ff 45 f4             	incl   -0xc(%ebp)
  800df2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800df5:	83 c0 65             	add    $0x65,%eax
  800df8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800dfb:	7f c5                	jg     800dc2 <_main+0xd8a>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800dfd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e00:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e03:	eb 30                	jmp    800e35 <_main+0xdfd>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800e0f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800e12:	01 d0                	add    %edx,%eax
  800e14:	8b 00                	mov    (%eax),%eax
  800e16:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e19:	74 17                	je     800e32 <_main+0xdfa>
  800e1b:	83 ec 04             	sub    $0x4,%esp
  800e1e:	68 88 31 80 00       	push   $0x803188
  800e23:	68 37 01 00 00       	push   $0x137
  800e28:	68 74 2f 80 00       	push   $0x802f74
  800e2d:	e8 81 04 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800e32:	ff 4d f4             	decl   -0xc(%ebp)
  800e35:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e38:	83 e8 64             	sub    $0x64,%eax
  800e3b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e3e:	7c c5                	jl     800e05 <_main+0xdcd>
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}


		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800e40:	e8 80 19 00 00       	call   8027c5 <sys_calculate_free_frames>
  800e45:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e48:	e8 fb 19 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800e4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[9]);
  800e50:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800e53:	83 ec 0c             	sub    $0xc,%esp
  800e56:	50                   	push   %eax
  800e57:	e8 93 16 00 00       	call   8024ef <free>
  800e5c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 640) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 640) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800e5f:	e8 e4 19 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800e64:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800e67:	29 c2                	sub    %eax,%edx
  800e69:	89 d0                	mov    %edx,%eax
  800e6b:	3d 80 02 00 00       	cmp    $0x280,%eax
  800e70:	74 17                	je     800e89 <_main+0xe51>
  800e72:	83 ec 04             	sub    $0x4,%esp
  800e75:	68 c0 31 80 00       	push   $0x8031c0
  800e7a:	68 40 01 00 00       	push   $0x140
  800e7f:	68 74 2f 80 00       	push   $0x802f74
  800e84:	e8 2a 04 00 00       	call   8012b3 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b70%", NULL);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	6a 00                	push   $0x0
  800e8e:	68 1b 32 80 00       	push   $0x80321b
  800e93:	e8 52 06 00 00       	call   8014ea <vcprintf>
  800e98:	83 c4 10             	add    $0x10,%esp

		/*CASE3: Re-allocate that's not fit in the same location*/

		//Fill it with data
		intArr = (int*) ptr_allocations[0];
  800e9b:	8b 45 80             	mov    -0x80(%ebp),%eax
  800e9e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;
  800ea1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea4:	c1 e8 02             	shr    $0x2,%eax
  800ea7:	48                   	dec    %eax
  800ea8:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		i = 0;
  800eab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800eb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800eb9:	eb 17                	jmp    800ed2 <_main+0xe9a>
		{
			intArr[i] = i ;
  800ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ebe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ec5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800ec8:	01 c2                	add    %eax,%edx
  800eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ecd:	89 02                	mov    %eax,(%edx)

		i = 0;

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800ecf:	ff 45 f4             	incl   -0xc(%ebp)
  800ed2:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800ed6:	7e e3                	jle    800ebb <_main+0xe83>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800ed8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800edb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ede:	eb 17                	jmp    800ef7 <_main+0xebf>
		{
			intArr[i] = i ;
  800ee0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ee3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800eea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800eed:	01 c2                	add    %eax,%edx
  800eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ef2:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800ef4:	ff 4d f4             	decl   -0xc(%ebp)
  800ef7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800efa:	83 e8 64             	sub    $0x64,%eax
  800efd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f00:	7c de                	jl     800ee0 <_main+0xea8>
			intArr[i] = i ;
		}


		//Reallocate it to 4 MB [should be moved to last hole]
		freeFrames = sys_calculate_free_frames() ;
  800f02:	e8 be 18 00 00       	call   8027c5 <sys_calculate_free_frames>
  800f07:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f0a:	e8 39 19 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800f0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 1*Mega + 3*Mega - kilo);
  800f12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f15:	c1 e0 02             	shl    $0x2,%eax
  800f18:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800f1b:	89 c2                	mov    %eax,%edx
  800f1d:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f20:	83 ec 08             	sub    $0x8,%esp
  800f23:	52                   	push   %edx
  800f24:	50                   	push   %eax
  800f25:	e8 bb 16 00 00       	call   8025e5 <realloc>
  800f2a:	83 c4 10             	add    $0x10,%esp
  800f2d:	89 45 80             	mov    %eax,-0x80(%ebp)
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the re-allocated space... ");
  800f30:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f33:	89 c1                	mov    %eax,%ecx
  800f35:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f38:	89 d0                	mov    %edx,%eax
  800f3a:	01 c0                	add    %eax,%eax
  800f3c:	01 d0                	add    %edx,%eax
  800f3e:	01 c0                	add    %eax,%eax
  800f40:	01 d0                	add    %edx,%eax
  800f42:	01 c0                	add    %eax,%eax
  800f44:	05 00 00 00 80       	add    $0x80000000,%eax
  800f49:	39 c1                	cmp    %eax,%ecx
  800f4b:	74 17                	je     800f64 <_main+0xf2c>
  800f4d:	83 ec 04             	sub    $0x4,%esp
  800f50:	68 b0 30 80 00       	push   $0x8030b0
  800f55:	68 60 01 00 00       	push   $0x160
  800f5a:	68 74 2f 80 00       	push   $0x802f74
  800f5f:	e8 4f 03 00 00       	call   8012b3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong re-allocation");
		//if((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are re-allocated in PageFile");
  800f64:	e8 df 18 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  800f69:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800f6c:	3d 00 03 00 00       	cmp    $0x300,%eax
  800f71:	74 17                	je     800f8a <_main+0xf52>
  800f73:	83 ec 04             	sub    $0x4,%esp
  800f76:	68 54 31 80 00       	push   $0x803154
  800f7b:	68 63 01 00 00       	push   $0x163
  800f80:	68 74 2f 80 00       	push   $0x802f74
  800f85:	e8 29 03 00 00       	call   8012b3 <_panic>

		//[2] test memory access
		lastIndexOfInt2 = (4*Mega)/sizeof(int) - 1;
  800f8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f8d:	c1 e0 02             	shl    $0x2,%eax
  800f90:	c1 e8 02             	shr    $0x2,%eax
  800f93:	48                   	dec    %eax
  800f94:	89 45 d0             	mov    %eax,-0x30(%ebp)
		intArr = (int*) ptr_allocations[0];
  800f97:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f9a:	89 45 d8             	mov    %eax,-0x28(%ebp)

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800f9d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800fa0:	40                   	inc    %eax
  800fa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa4:	eb 17                	jmp    800fbd <_main+0xf85>
		{
			intArr[i] = i;
  800fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800fb3:	01 c2                	add    %eax,%edx
  800fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb8:	89 02                	mov    %eax,(%edx)
		lastIndexOfInt2 = (4*Mega)/sizeof(int) - 1;
		intArr = (int*) ptr_allocations[0];

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800fba:	ff 45 f4             	incl   -0xc(%ebp)
  800fbd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800fc0:	83 c0 65             	add    $0x65,%eax
  800fc3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fc6:	7f de                	jg     800fa6 <_main+0xf6e>
		{
			intArr[i] = i;
		}

		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800fc8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fce:	eb 17                	jmp    800fe7 <_main+0xfaf>
		{
			intArr[i] = i;
  800fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fda:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800fdd:	01 c2                	add    %eax,%edx
  800fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe2:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i;
		}

		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800fe4:	ff 4d f4             	decl   -0xc(%ebp)
  800fe7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fea:	83 e8 64             	sub    $0x64,%eax
  800fed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ff0:	7c de                	jl     800fd0 <_main+0xf98>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800ff2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800ff9:	eb 30                	jmp    80102b <_main+0xff3>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801005:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801008:	01 d0                	add    %edx,%eax
  80100a:	8b 00                	mov    (%eax),%eax
  80100c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80100f:	74 17                	je     801028 <_main+0xff0>
  801011:	83 ec 04             	sub    $0x4,%esp
  801014:	68 88 31 80 00       	push   $0x803188
  801019:	68 79 01 00 00       	push   $0x179
  80101e:	68 74 2f 80 00       	push   $0x802f74
  801023:	e8 8b 02 00 00       	call   8012b3 <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  801028:	ff 45 f4             	incl   -0xc(%ebp)
  80102b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  80102f:	7e ca                	jle    800ffb <_main+0xfc3>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801031:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801034:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801037:	eb 30                	jmp    801069 <_main+0x1031>
		{
			if (intArr[i] != i)
  801039:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80103c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801043:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801046:	01 d0                	add    %edx,%eax
  801048:	8b 00                	mov    (%eax),%eax
  80104a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80104d:	74 17                	je     801066 <_main+0x102e>
			{
				panic("Wrong re-allocation: stored values are wrongly changed!");
  80104f:	83 ec 04             	sub    $0x4,%esp
  801052:	68 88 31 80 00       	push   $0x803188
  801057:	68 81 01 00 00       	push   $0x181
  80105c:	68 74 2f 80 00       	push   $0x802f74
  801061:	e8 4d 02 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801066:	ff 4d f4             	decl   -0xc(%ebp)
  801069:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80106c:	83 e8 64             	sub    $0x64,%eax
  80106f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801072:	7c c5                	jl     801039 <_main+0x1001>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  801074:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801077:	40                   	inc    %eax
  801078:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80107b:	eb 30                	jmp    8010ad <_main+0x1075>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80107d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801080:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801087:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80108a:	01 d0                	add    %edx,%eax
  80108c:	8b 00                	mov    (%eax),%eax
  80108e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801091:	74 17                	je     8010aa <_main+0x1072>
  801093:	83 ec 04             	sub    $0x4,%esp
  801096:	68 88 31 80 00       	push   $0x803188
  80109b:	68 88 01 00 00       	push   $0x188
  8010a0:	68 74 2f 80 00       	push   $0x802f74
  8010a5:	e8 09 02 00 00       	call   8012b3 <_panic>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  8010aa:	ff 45 f4             	incl   -0xc(%ebp)
  8010ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8010b0:	83 c0 65             	add    $0x65,%eax
  8010b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010b6:	7f c5                	jg     80107d <_main+0x1045>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  8010b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8010bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010be:	eb 30                	jmp    8010f0 <_main+0x10b8>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8010c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ca:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8010cd:	01 d0                	add    %edx,%eax
  8010cf:	8b 00                	mov    (%eax),%eax
  8010d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010d4:	74 17                	je     8010ed <_main+0x10b5>
  8010d6:	83 ec 04             	sub    $0x4,%esp
  8010d9:	68 88 31 80 00       	push   $0x803188
  8010de:	68 8e 01 00 00       	push   $0x18e
  8010e3:	68 74 2f 80 00       	push   $0x802f74
  8010e8:	e8 c6 01 00 00       	call   8012b3 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  8010ed:	ff 4d f4             	decl   -0xc(%ebp)
  8010f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8010f3:	83 e8 64             	sub    $0x64,%eax
  8010f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010f9:	7c c5                	jl     8010c0 <_main+0x1088>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  8010fb:	e8 c5 16 00 00       	call   8027c5 <sys_calculate_free_frames>
  801100:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801103:	e8 40 17 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  801108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[0]);
  80110b:	8b 45 80             	mov    -0x80(%ebp),%eax
  80110e:	83 ec 0c             	sub    $0xc,%esp
  801111:	50                   	push   %eax
  801112:	e8 d8 13 00 00       	call   8024ef <free>
  801117:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1024+1) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1024) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  80111a:	e8 29 17 00 00       	call   802848 <sys_pf_calculate_allocated_pages>
  80111f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801122:	29 c2                	sub    %eax,%edx
  801124:	89 d0                	mov    %edx,%eax
  801126:	3d 00 04 00 00       	cmp    $0x400,%eax
  80112b:	74 17                	je     801144 <_main+0x110c>
  80112d:	83 ec 04             	sub    $0x4,%esp
  801130:	68 c0 31 80 00       	push   $0x8031c0
  801135:	68 96 01 00 00       	push   $0x196
  80113a:	68 74 2f 80 00       	push   $0x802f74
  80113f:	e8 6f 01 00 00       	call   8012b3 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 2) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b100%\n", NULL);
  801144:	83 ec 08             	sub    $0x8,%esp
  801147:	6a 00                	push   $0x0
  801149:	68 22 32 80 00       	push   $0x803222
  80114e:	e8 97 03 00 00       	call   8014ea <vcprintf>
  801153:	83 c4 10             	add    $0x10,%esp
	}

	cprintf("Congratulations!! test realloc [1] completed successfully.\n");
  801156:	83 ec 0c             	sub    $0xc,%esp
  801159:	68 2c 32 80 00       	push   $0x80322c
  80115e:	e8 f2 03 00 00       	call   801555 <cprintf>
  801163:	83 c4 10             	add    $0x10,%esp

	return;
  801166:	90                   	nop
}
  801167:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80116a:	5b                   	pop    %ebx
  80116b:	5f                   	pop    %edi
  80116c:	5d                   	pop    %ebp
  80116d:	c3                   	ret    

0080116e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
  801171:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801174:	e8 81 15 00 00       	call   8026fa <sys_getenvindex>
  801179:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80117c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80117f:	89 d0                	mov    %edx,%eax
  801181:	c1 e0 03             	shl    $0x3,%eax
  801184:	01 d0                	add    %edx,%eax
  801186:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80118d:	01 c8                	add    %ecx,%eax
  80118f:	01 c0                	add    %eax,%eax
  801191:	01 d0                	add    %edx,%eax
  801193:	01 c0                	add    %eax,%eax
  801195:	01 d0                	add    %edx,%eax
  801197:	89 c2                	mov    %eax,%edx
  801199:	c1 e2 05             	shl    $0x5,%edx
  80119c:	29 c2                	sub    %eax,%edx
  80119e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8011a5:	89 c2                	mov    %eax,%edx
  8011a7:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8011ad:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8011b2:	a1 20 40 80 00       	mov    0x804020,%eax
  8011b7:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8011bd:	84 c0                	test   %al,%al
  8011bf:	74 0f                	je     8011d0 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8011c1:	a1 20 40 80 00       	mov    0x804020,%eax
  8011c6:	05 40 3c 01 00       	add    $0x13c40,%eax
  8011cb:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8011d0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011d4:	7e 0a                	jle    8011e0 <libmain+0x72>
		binaryname = argv[0];
  8011d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d9:	8b 00                	mov    (%eax),%eax
  8011db:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8011e0:	83 ec 08             	sub    $0x8,%esp
  8011e3:	ff 75 0c             	pushl  0xc(%ebp)
  8011e6:	ff 75 08             	pushl  0x8(%ebp)
  8011e9:	e8 4a ee ff ff       	call   800038 <_main>
  8011ee:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8011f1:	e8 9f 16 00 00       	call   802895 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8011f6:	83 ec 0c             	sub    $0xc,%esp
  8011f9:	68 80 32 80 00       	push   $0x803280
  8011fe:	e8 52 03 00 00       	call   801555 <cprintf>
  801203:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801206:	a1 20 40 80 00       	mov    0x804020,%eax
  80120b:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  801211:	a1 20 40 80 00       	mov    0x804020,%eax
  801216:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80121c:	83 ec 04             	sub    $0x4,%esp
  80121f:	52                   	push   %edx
  801220:	50                   	push   %eax
  801221:	68 a8 32 80 00       	push   $0x8032a8
  801226:	e8 2a 03 00 00       	call   801555 <cprintf>
  80122b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80122e:	a1 20 40 80 00       	mov    0x804020,%eax
  801233:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  801239:	a1 20 40 80 00       	mov    0x804020,%eax
  80123e:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  801244:	83 ec 04             	sub    $0x4,%esp
  801247:	52                   	push   %edx
  801248:	50                   	push   %eax
  801249:	68 d0 32 80 00       	push   $0x8032d0
  80124e:	e8 02 03 00 00       	call   801555 <cprintf>
  801253:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801256:	a1 20 40 80 00       	mov    0x804020,%eax
  80125b:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  801261:	83 ec 08             	sub    $0x8,%esp
  801264:	50                   	push   %eax
  801265:	68 11 33 80 00       	push   $0x803311
  80126a:	e8 e6 02 00 00       	call   801555 <cprintf>
  80126f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801272:	83 ec 0c             	sub    $0xc,%esp
  801275:	68 80 32 80 00       	push   $0x803280
  80127a:	e8 d6 02 00 00       	call   801555 <cprintf>
  80127f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801282:	e8 28 16 00 00       	call   8028af <sys_enable_interrupt>

	// exit gracefully
	exit();
  801287:	e8 19 00 00 00       	call   8012a5 <exit>
}
  80128c:	90                   	nop
  80128d:	c9                   	leave  
  80128e:	c3                   	ret    

0080128f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
  801292:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801295:	83 ec 0c             	sub    $0xc,%esp
  801298:	6a 00                	push   $0x0
  80129a:	e8 27 14 00 00       	call   8026c6 <sys_env_destroy>
  80129f:	83 c4 10             	add    $0x10,%esp
}
  8012a2:	90                   	nop
  8012a3:	c9                   	leave  
  8012a4:	c3                   	ret    

008012a5 <exit>:

void
exit(void)
{
  8012a5:	55                   	push   %ebp
  8012a6:	89 e5                	mov    %esp,%ebp
  8012a8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8012ab:	e8 7c 14 00 00       	call   80272c <sys_env_exit>
}
  8012b0:	90                   	nop
  8012b1:	c9                   	leave  
  8012b2:	c3                   	ret    

008012b3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
  8012b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8012b9:	8d 45 10             	lea    0x10(%ebp),%eax
  8012bc:	83 c0 04             	add    $0x4,%eax
  8012bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8012c2:	a1 18 41 80 00       	mov    0x804118,%eax
  8012c7:	85 c0                	test   %eax,%eax
  8012c9:	74 16                	je     8012e1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8012cb:	a1 18 41 80 00       	mov    0x804118,%eax
  8012d0:	83 ec 08             	sub    $0x8,%esp
  8012d3:	50                   	push   %eax
  8012d4:	68 28 33 80 00       	push   $0x803328
  8012d9:	e8 77 02 00 00       	call   801555 <cprintf>
  8012de:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8012e1:	a1 00 40 80 00       	mov    0x804000,%eax
  8012e6:	ff 75 0c             	pushl  0xc(%ebp)
  8012e9:	ff 75 08             	pushl  0x8(%ebp)
  8012ec:	50                   	push   %eax
  8012ed:	68 2d 33 80 00       	push   $0x80332d
  8012f2:	e8 5e 02 00 00       	call   801555 <cprintf>
  8012f7:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8012fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fd:	83 ec 08             	sub    $0x8,%esp
  801300:	ff 75 f4             	pushl  -0xc(%ebp)
  801303:	50                   	push   %eax
  801304:	e8 e1 01 00 00       	call   8014ea <vcprintf>
  801309:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80130c:	83 ec 08             	sub    $0x8,%esp
  80130f:	6a 00                	push   $0x0
  801311:	68 49 33 80 00       	push   $0x803349
  801316:	e8 cf 01 00 00       	call   8014ea <vcprintf>
  80131b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80131e:	e8 82 ff ff ff       	call   8012a5 <exit>

	// should not return here
	while (1) ;
  801323:	eb fe                	jmp    801323 <_panic+0x70>

00801325 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80132b:	a1 20 40 80 00       	mov    0x804020,%eax
  801330:	8b 50 74             	mov    0x74(%eax),%edx
  801333:	8b 45 0c             	mov    0xc(%ebp),%eax
  801336:	39 c2                	cmp    %eax,%edx
  801338:	74 14                	je     80134e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80133a:	83 ec 04             	sub    $0x4,%esp
  80133d:	68 4c 33 80 00       	push   $0x80334c
  801342:	6a 26                	push   $0x26
  801344:	68 98 33 80 00       	push   $0x803398
  801349:	e8 65 ff ff ff       	call   8012b3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80134e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801355:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80135c:	e9 b6 00 00 00       	jmp    801417 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801364:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	01 d0                	add    %edx,%eax
  801370:	8b 00                	mov    (%eax),%eax
  801372:	85 c0                	test   %eax,%eax
  801374:	75 08                	jne    80137e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801376:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801379:	e9 96 00 00 00       	jmp    801414 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80137e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801385:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80138c:	eb 5d                	jmp    8013eb <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80138e:	a1 20 40 80 00       	mov    0x804020,%eax
  801393:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801399:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80139c:	c1 e2 04             	shl    $0x4,%edx
  80139f:	01 d0                	add    %edx,%eax
  8013a1:	8a 40 04             	mov    0x4(%eax),%al
  8013a4:	84 c0                	test   %al,%al
  8013a6:	75 40                	jne    8013e8 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8013a8:	a1 20 40 80 00       	mov    0x804020,%eax
  8013ad:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8013b3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8013b6:	c1 e2 04             	shl    $0x4,%edx
  8013b9:	01 d0                	add    %edx,%eax
  8013bb:	8b 00                	mov    (%eax),%eax
  8013bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8013c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013c8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8013ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	01 c8                	add    %ecx,%eax
  8013d9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8013db:	39 c2                	cmp    %eax,%edx
  8013dd:	75 09                	jne    8013e8 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8013df:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8013e6:	eb 12                	jmp    8013fa <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8013e8:	ff 45 e8             	incl   -0x18(%ebp)
  8013eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8013f0:	8b 50 74             	mov    0x74(%eax),%edx
  8013f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013f6:	39 c2                	cmp    %eax,%edx
  8013f8:	77 94                	ja     80138e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8013fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013fe:	75 14                	jne    801414 <CheckWSWithoutLastIndex+0xef>
			panic(
  801400:	83 ec 04             	sub    $0x4,%esp
  801403:	68 a4 33 80 00       	push   $0x8033a4
  801408:	6a 3a                	push   $0x3a
  80140a:	68 98 33 80 00       	push   $0x803398
  80140f:	e8 9f fe ff ff       	call   8012b3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801414:	ff 45 f0             	incl   -0x10(%ebp)
  801417:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80141a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80141d:	0f 8c 3e ff ff ff    	jl     801361 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801423:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80142a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801431:	eb 20                	jmp    801453 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801433:	a1 20 40 80 00       	mov    0x804020,%eax
  801438:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80143e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801441:	c1 e2 04             	shl    $0x4,%edx
  801444:	01 d0                	add    %edx,%eax
  801446:	8a 40 04             	mov    0x4(%eax),%al
  801449:	3c 01                	cmp    $0x1,%al
  80144b:	75 03                	jne    801450 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80144d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801450:	ff 45 e0             	incl   -0x20(%ebp)
  801453:	a1 20 40 80 00       	mov    0x804020,%eax
  801458:	8b 50 74             	mov    0x74(%eax),%edx
  80145b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80145e:	39 c2                	cmp    %eax,%edx
  801460:	77 d1                	ja     801433 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801462:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801465:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801468:	74 14                	je     80147e <CheckWSWithoutLastIndex+0x159>
		panic(
  80146a:	83 ec 04             	sub    $0x4,%esp
  80146d:	68 f8 33 80 00       	push   $0x8033f8
  801472:	6a 44                	push   $0x44
  801474:	68 98 33 80 00       	push   $0x803398
  801479:	e8 35 fe ff ff       	call   8012b3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80147e:	90                   	nop
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
  801484:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148a:	8b 00                	mov    (%eax),%eax
  80148c:	8d 48 01             	lea    0x1(%eax),%ecx
  80148f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801492:	89 0a                	mov    %ecx,(%edx)
  801494:	8b 55 08             	mov    0x8(%ebp),%edx
  801497:	88 d1                	mov    %dl,%cl
  801499:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8014a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a3:	8b 00                	mov    (%eax),%eax
  8014a5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8014aa:	75 2c                	jne    8014d8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8014ac:	a0 24 40 80 00       	mov    0x804024,%al
  8014b1:	0f b6 c0             	movzbl %al,%eax
  8014b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b7:	8b 12                	mov    (%edx),%edx
  8014b9:	89 d1                	mov    %edx,%ecx
  8014bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014be:	83 c2 08             	add    $0x8,%edx
  8014c1:	83 ec 04             	sub    $0x4,%esp
  8014c4:	50                   	push   %eax
  8014c5:	51                   	push   %ecx
  8014c6:	52                   	push   %edx
  8014c7:	e8 b8 11 00 00       	call   802684 <sys_cputs>
  8014cc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8014cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8014d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014db:	8b 40 04             	mov    0x4(%eax),%eax
  8014de:	8d 50 01             	lea    0x1(%eax),%edx
  8014e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8014e7:	90                   	nop
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8014f3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8014fa:	00 00 00 
	b.cnt = 0;
  8014fd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801504:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801507:	ff 75 0c             	pushl  0xc(%ebp)
  80150a:	ff 75 08             	pushl  0x8(%ebp)
  80150d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801513:	50                   	push   %eax
  801514:	68 81 14 80 00       	push   $0x801481
  801519:	e8 11 02 00 00       	call   80172f <vprintfmt>
  80151e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801521:	a0 24 40 80 00       	mov    0x804024,%al
  801526:	0f b6 c0             	movzbl %al,%eax
  801529:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80152f:	83 ec 04             	sub    $0x4,%esp
  801532:	50                   	push   %eax
  801533:	52                   	push   %edx
  801534:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80153a:	83 c0 08             	add    $0x8,%eax
  80153d:	50                   	push   %eax
  80153e:	e8 41 11 00 00       	call   802684 <sys_cputs>
  801543:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801546:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80154d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <cprintf>:

int cprintf(const char *fmt, ...) {
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
  801558:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80155b:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801562:	8d 45 0c             	lea    0xc(%ebp),%eax
  801565:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	83 ec 08             	sub    $0x8,%esp
  80156e:	ff 75 f4             	pushl  -0xc(%ebp)
  801571:	50                   	push   %eax
  801572:	e8 73 ff ff ff       	call   8014ea <vcprintf>
  801577:	83 c4 10             	add    $0x10,%esp
  80157a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80157d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801588:	e8 08 13 00 00       	call   802895 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80158d:	8d 45 0c             	lea    0xc(%ebp),%eax
  801590:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	83 ec 08             	sub    $0x8,%esp
  801599:	ff 75 f4             	pushl  -0xc(%ebp)
  80159c:	50                   	push   %eax
  80159d:	e8 48 ff ff ff       	call   8014ea <vcprintf>
  8015a2:	83 c4 10             	add    $0x10,%esp
  8015a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8015a8:	e8 02 13 00 00       	call   8028af <sys_enable_interrupt>
	return cnt;
  8015ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
  8015b5:	53                   	push   %ebx
  8015b6:	83 ec 14             	sub    $0x14,%esp
  8015b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8015c5:	8b 45 18             	mov    0x18(%ebp),%eax
  8015c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8015cd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8015d0:	77 55                	ja     801627 <printnum+0x75>
  8015d2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8015d5:	72 05                	jb     8015dc <printnum+0x2a>
  8015d7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015da:	77 4b                	ja     801627 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8015dc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8015df:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8015e2:	8b 45 18             	mov    0x18(%ebp),%eax
  8015e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8015ea:	52                   	push   %edx
  8015eb:	50                   	push   %eax
  8015ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8015ef:	ff 75 f0             	pushl  -0x10(%ebp)
  8015f2:	e8 c1 16 00 00       	call   802cb8 <__udivdi3>
  8015f7:	83 c4 10             	add    $0x10,%esp
  8015fa:	83 ec 04             	sub    $0x4,%esp
  8015fd:	ff 75 20             	pushl  0x20(%ebp)
  801600:	53                   	push   %ebx
  801601:	ff 75 18             	pushl  0x18(%ebp)
  801604:	52                   	push   %edx
  801605:	50                   	push   %eax
  801606:	ff 75 0c             	pushl  0xc(%ebp)
  801609:	ff 75 08             	pushl  0x8(%ebp)
  80160c:	e8 a1 ff ff ff       	call   8015b2 <printnum>
  801611:	83 c4 20             	add    $0x20,%esp
  801614:	eb 1a                	jmp    801630 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801616:	83 ec 08             	sub    $0x8,%esp
  801619:	ff 75 0c             	pushl  0xc(%ebp)
  80161c:	ff 75 20             	pushl  0x20(%ebp)
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	ff d0                	call   *%eax
  801624:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801627:	ff 4d 1c             	decl   0x1c(%ebp)
  80162a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80162e:	7f e6                	jg     801616 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801630:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801633:	bb 00 00 00 00       	mov    $0x0,%ebx
  801638:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80163b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80163e:	53                   	push   %ebx
  80163f:	51                   	push   %ecx
  801640:	52                   	push   %edx
  801641:	50                   	push   %eax
  801642:	e8 81 17 00 00       	call   802dc8 <__umoddi3>
  801647:	83 c4 10             	add    $0x10,%esp
  80164a:	05 74 36 80 00       	add    $0x803674,%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	0f be c0             	movsbl %al,%eax
  801654:	83 ec 08             	sub    $0x8,%esp
  801657:	ff 75 0c             	pushl  0xc(%ebp)
  80165a:	50                   	push   %eax
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	ff d0                	call   *%eax
  801660:	83 c4 10             	add    $0x10,%esp
}
  801663:	90                   	nop
  801664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80166c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801670:	7e 1c                	jle    80168e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	8b 00                	mov    (%eax),%eax
  801677:	8d 50 08             	lea    0x8(%eax),%edx
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	89 10                	mov    %edx,(%eax)
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	8b 00                	mov    (%eax),%eax
  801684:	83 e8 08             	sub    $0x8,%eax
  801687:	8b 50 04             	mov    0x4(%eax),%edx
  80168a:	8b 00                	mov    (%eax),%eax
  80168c:	eb 40                	jmp    8016ce <getuint+0x65>
	else if (lflag)
  80168e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801692:	74 1e                	je     8016b2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8b 00                	mov    (%eax),%eax
  801699:	8d 50 04             	lea    0x4(%eax),%edx
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	89 10                	mov    %edx,(%eax)
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	8b 00                	mov    (%eax),%eax
  8016a6:	83 e8 04             	sub    $0x4,%eax
  8016a9:	8b 00                	mov    (%eax),%eax
  8016ab:	ba 00 00 00 00       	mov    $0x0,%edx
  8016b0:	eb 1c                	jmp    8016ce <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8b 00                	mov    (%eax),%eax
  8016b7:	8d 50 04             	lea    0x4(%eax),%edx
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	89 10                	mov    %edx,(%eax)
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	8b 00                	mov    (%eax),%eax
  8016c4:	83 e8 04             	sub    $0x4,%eax
  8016c7:	8b 00                	mov    (%eax),%eax
  8016c9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8016ce:	5d                   	pop    %ebp
  8016cf:	c3                   	ret    

008016d0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8016d3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8016d7:	7e 1c                	jle    8016f5 <getint+0x25>
		return va_arg(*ap, long long);
  8016d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dc:	8b 00                	mov    (%eax),%eax
  8016de:	8d 50 08             	lea    0x8(%eax),%edx
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	89 10                	mov    %edx,(%eax)
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	8b 00                	mov    (%eax),%eax
  8016eb:	83 e8 08             	sub    $0x8,%eax
  8016ee:	8b 50 04             	mov    0x4(%eax),%edx
  8016f1:	8b 00                	mov    (%eax),%eax
  8016f3:	eb 38                	jmp    80172d <getint+0x5d>
	else if (lflag)
  8016f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016f9:	74 1a                	je     801715 <getint+0x45>
		return va_arg(*ap, long);
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	8b 00                	mov    (%eax),%eax
  801700:	8d 50 04             	lea    0x4(%eax),%edx
  801703:	8b 45 08             	mov    0x8(%ebp),%eax
  801706:	89 10                	mov    %edx,(%eax)
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	8b 00                	mov    (%eax),%eax
  80170d:	83 e8 04             	sub    $0x4,%eax
  801710:	8b 00                	mov    (%eax),%eax
  801712:	99                   	cltd   
  801713:	eb 18                	jmp    80172d <getint+0x5d>
	else
		return va_arg(*ap, int);
  801715:	8b 45 08             	mov    0x8(%ebp),%eax
  801718:	8b 00                	mov    (%eax),%eax
  80171a:	8d 50 04             	lea    0x4(%eax),%edx
  80171d:	8b 45 08             	mov    0x8(%ebp),%eax
  801720:	89 10                	mov    %edx,(%eax)
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	8b 00                	mov    (%eax),%eax
  801727:	83 e8 04             	sub    $0x4,%eax
  80172a:	8b 00                	mov    (%eax),%eax
  80172c:	99                   	cltd   
}
  80172d:	5d                   	pop    %ebp
  80172e:	c3                   	ret    

0080172f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80172f:	55                   	push   %ebp
  801730:	89 e5                	mov    %esp,%ebp
  801732:	56                   	push   %esi
  801733:	53                   	push   %ebx
  801734:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801737:	eb 17                	jmp    801750 <vprintfmt+0x21>
			if (ch == '\0')
  801739:	85 db                	test   %ebx,%ebx
  80173b:	0f 84 af 03 00 00    	je     801af0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801741:	83 ec 08             	sub    $0x8,%esp
  801744:	ff 75 0c             	pushl  0xc(%ebp)
  801747:	53                   	push   %ebx
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	ff d0                	call   *%eax
  80174d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801750:	8b 45 10             	mov    0x10(%ebp),%eax
  801753:	8d 50 01             	lea    0x1(%eax),%edx
  801756:	89 55 10             	mov    %edx,0x10(%ebp)
  801759:	8a 00                	mov    (%eax),%al
  80175b:	0f b6 d8             	movzbl %al,%ebx
  80175e:	83 fb 25             	cmp    $0x25,%ebx
  801761:	75 d6                	jne    801739 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801763:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801767:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80176e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801775:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80177c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801783:	8b 45 10             	mov    0x10(%ebp),%eax
  801786:	8d 50 01             	lea    0x1(%eax),%edx
  801789:	89 55 10             	mov    %edx,0x10(%ebp)
  80178c:	8a 00                	mov    (%eax),%al
  80178e:	0f b6 d8             	movzbl %al,%ebx
  801791:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801794:	83 f8 55             	cmp    $0x55,%eax
  801797:	0f 87 2b 03 00 00    	ja     801ac8 <vprintfmt+0x399>
  80179d:	8b 04 85 98 36 80 00 	mov    0x803698(,%eax,4),%eax
  8017a4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8017a6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8017aa:	eb d7                	jmp    801783 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8017ac:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8017b0:	eb d1                	jmp    801783 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8017b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8017b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8017bc:	89 d0                	mov    %edx,%eax
  8017be:	c1 e0 02             	shl    $0x2,%eax
  8017c1:	01 d0                	add    %edx,%eax
  8017c3:	01 c0                	add    %eax,%eax
  8017c5:	01 d8                	add    %ebx,%eax
  8017c7:	83 e8 30             	sub    $0x30,%eax
  8017ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8017cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d0:	8a 00                	mov    (%eax),%al
  8017d2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8017d5:	83 fb 2f             	cmp    $0x2f,%ebx
  8017d8:	7e 3e                	jle    801818 <vprintfmt+0xe9>
  8017da:	83 fb 39             	cmp    $0x39,%ebx
  8017dd:	7f 39                	jg     801818 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8017df:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8017e2:	eb d5                	jmp    8017b9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8017e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8017e7:	83 c0 04             	add    $0x4,%eax
  8017ea:	89 45 14             	mov    %eax,0x14(%ebp)
  8017ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8017f0:	83 e8 04             	sub    $0x4,%eax
  8017f3:	8b 00                	mov    (%eax),%eax
  8017f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8017f8:	eb 1f                	jmp    801819 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8017fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8017fe:	79 83                	jns    801783 <vprintfmt+0x54>
				width = 0;
  801800:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801807:	e9 77 ff ff ff       	jmp    801783 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80180c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801813:	e9 6b ff ff ff       	jmp    801783 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801818:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801819:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80181d:	0f 89 60 ff ff ff    	jns    801783 <vprintfmt+0x54>
				width = precision, precision = -1;
  801823:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801826:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801829:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801830:	e9 4e ff ff ff       	jmp    801783 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801835:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801838:	e9 46 ff ff ff       	jmp    801783 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80183d:	8b 45 14             	mov    0x14(%ebp),%eax
  801840:	83 c0 04             	add    $0x4,%eax
  801843:	89 45 14             	mov    %eax,0x14(%ebp)
  801846:	8b 45 14             	mov    0x14(%ebp),%eax
  801849:	83 e8 04             	sub    $0x4,%eax
  80184c:	8b 00                	mov    (%eax),%eax
  80184e:	83 ec 08             	sub    $0x8,%esp
  801851:	ff 75 0c             	pushl  0xc(%ebp)
  801854:	50                   	push   %eax
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	ff d0                	call   *%eax
  80185a:	83 c4 10             	add    $0x10,%esp
			break;
  80185d:	e9 89 02 00 00       	jmp    801aeb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801862:	8b 45 14             	mov    0x14(%ebp),%eax
  801865:	83 c0 04             	add    $0x4,%eax
  801868:	89 45 14             	mov    %eax,0x14(%ebp)
  80186b:	8b 45 14             	mov    0x14(%ebp),%eax
  80186e:	83 e8 04             	sub    $0x4,%eax
  801871:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801873:	85 db                	test   %ebx,%ebx
  801875:	79 02                	jns    801879 <vprintfmt+0x14a>
				err = -err;
  801877:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801879:	83 fb 64             	cmp    $0x64,%ebx
  80187c:	7f 0b                	jg     801889 <vprintfmt+0x15a>
  80187e:	8b 34 9d e0 34 80 00 	mov    0x8034e0(,%ebx,4),%esi
  801885:	85 f6                	test   %esi,%esi
  801887:	75 19                	jne    8018a2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801889:	53                   	push   %ebx
  80188a:	68 85 36 80 00       	push   $0x803685
  80188f:	ff 75 0c             	pushl  0xc(%ebp)
  801892:	ff 75 08             	pushl  0x8(%ebp)
  801895:	e8 5e 02 00 00       	call   801af8 <printfmt>
  80189a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80189d:	e9 49 02 00 00       	jmp    801aeb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8018a2:	56                   	push   %esi
  8018a3:	68 8e 36 80 00       	push   $0x80368e
  8018a8:	ff 75 0c             	pushl  0xc(%ebp)
  8018ab:	ff 75 08             	pushl  0x8(%ebp)
  8018ae:	e8 45 02 00 00       	call   801af8 <printfmt>
  8018b3:	83 c4 10             	add    $0x10,%esp
			break;
  8018b6:	e9 30 02 00 00       	jmp    801aeb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8018bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8018be:	83 c0 04             	add    $0x4,%eax
  8018c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8018c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c7:	83 e8 04             	sub    $0x4,%eax
  8018ca:	8b 30                	mov    (%eax),%esi
  8018cc:	85 f6                	test   %esi,%esi
  8018ce:	75 05                	jne    8018d5 <vprintfmt+0x1a6>
				p = "(null)";
  8018d0:	be 91 36 80 00       	mov    $0x803691,%esi
			if (width > 0 && padc != '-')
  8018d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8018d9:	7e 6d                	jle    801948 <vprintfmt+0x219>
  8018db:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8018df:	74 67                	je     801948 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8018e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018e4:	83 ec 08             	sub    $0x8,%esp
  8018e7:	50                   	push   %eax
  8018e8:	56                   	push   %esi
  8018e9:	e8 0c 03 00 00       	call   801bfa <strnlen>
  8018ee:	83 c4 10             	add    $0x10,%esp
  8018f1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8018f4:	eb 16                	jmp    80190c <vprintfmt+0x1dd>
					putch(padc, putdat);
  8018f6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8018fa:	83 ec 08             	sub    $0x8,%esp
  8018fd:	ff 75 0c             	pushl  0xc(%ebp)
  801900:	50                   	push   %eax
  801901:	8b 45 08             	mov    0x8(%ebp),%eax
  801904:	ff d0                	call   *%eax
  801906:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801909:	ff 4d e4             	decl   -0x1c(%ebp)
  80190c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801910:	7f e4                	jg     8018f6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801912:	eb 34                	jmp    801948 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801914:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801918:	74 1c                	je     801936 <vprintfmt+0x207>
  80191a:	83 fb 1f             	cmp    $0x1f,%ebx
  80191d:	7e 05                	jle    801924 <vprintfmt+0x1f5>
  80191f:	83 fb 7e             	cmp    $0x7e,%ebx
  801922:	7e 12                	jle    801936 <vprintfmt+0x207>
					putch('?', putdat);
  801924:	83 ec 08             	sub    $0x8,%esp
  801927:	ff 75 0c             	pushl  0xc(%ebp)
  80192a:	6a 3f                	push   $0x3f
  80192c:	8b 45 08             	mov    0x8(%ebp),%eax
  80192f:	ff d0                	call   *%eax
  801931:	83 c4 10             	add    $0x10,%esp
  801934:	eb 0f                	jmp    801945 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801936:	83 ec 08             	sub    $0x8,%esp
  801939:	ff 75 0c             	pushl  0xc(%ebp)
  80193c:	53                   	push   %ebx
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	ff d0                	call   *%eax
  801942:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801945:	ff 4d e4             	decl   -0x1c(%ebp)
  801948:	89 f0                	mov    %esi,%eax
  80194a:	8d 70 01             	lea    0x1(%eax),%esi
  80194d:	8a 00                	mov    (%eax),%al
  80194f:	0f be d8             	movsbl %al,%ebx
  801952:	85 db                	test   %ebx,%ebx
  801954:	74 24                	je     80197a <vprintfmt+0x24b>
  801956:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80195a:	78 b8                	js     801914 <vprintfmt+0x1e5>
  80195c:	ff 4d e0             	decl   -0x20(%ebp)
  80195f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801963:	79 af                	jns    801914 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801965:	eb 13                	jmp    80197a <vprintfmt+0x24b>
				putch(' ', putdat);
  801967:	83 ec 08             	sub    $0x8,%esp
  80196a:	ff 75 0c             	pushl  0xc(%ebp)
  80196d:	6a 20                	push   $0x20
  80196f:	8b 45 08             	mov    0x8(%ebp),%eax
  801972:	ff d0                	call   *%eax
  801974:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801977:	ff 4d e4             	decl   -0x1c(%ebp)
  80197a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80197e:	7f e7                	jg     801967 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801980:	e9 66 01 00 00       	jmp    801aeb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801985:	83 ec 08             	sub    $0x8,%esp
  801988:	ff 75 e8             	pushl  -0x18(%ebp)
  80198b:	8d 45 14             	lea    0x14(%ebp),%eax
  80198e:	50                   	push   %eax
  80198f:	e8 3c fd ff ff       	call   8016d0 <getint>
  801994:	83 c4 10             	add    $0x10,%esp
  801997:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80199a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80199d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019a3:	85 d2                	test   %edx,%edx
  8019a5:	79 23                	jns    8019ca <vprintfmt+0x29b>
				putch('-', putdat);
  8019a7:	83 ec 08             	sub    $0x8,%esp
  8019aa:	ff 75 0c             	pushl  0xc(%ebp)
  8019ad:	6a 2d                	push   $0x2d
  8019af:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b2:	ff d0                	call   *%eax
  8019b4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8019b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019bd:	f7 d8                	neg    %eax
  8019bf:	83 d2 00             	adc    $0x0,%edx
  8019c2:	f7 da                	neg    %edx
  8019c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8019c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8019ca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8019d1:	e9 bc 00 00 00       	jmp    801a92 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8019d6:	83 ec 08             	sub    $0x8,%esp
  8019d9:	ff 75 e8             	pushl  -0x18(%ebp)
  8019dc:	8d 45 14             	lea    0x14(%ebp),%eax
  8019df:	50                   	push   %eax
  8019e0:	e8 84 fc ff ff       	call   801669 <getuint>
  8019e5:	83 c4 10             	add    $0x10,%esp
  8019e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8019eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8019ee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8019f5:	e9 98 00 00 00       	jmp    801a92 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8019fa:	83 ec 08             	sub    $0x8,%esp
  8019fd:	ff 75 0c             	pushl  0xc(%ebp)
  801a00:	6a 58                	push   $0x58
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	ff d0                	call   *%eax
  801a07:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801a0a:	83 ec 08             	sub    $0x8,%esp
  801a0d:	ff 75 0c             	pushl  0xc(%ebp)
  801a10:	6a 58                	push   $0x58
  801a12:	8b 45 08             	mov    0x8(%ebp),%eax
  801a15:	ff d0                	call   *%eax
  801a17:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801a1a:	83 ec 08             	sub    $0x8,%esp
  801a1d:	ff 75 0c             	pushl  0xc(%ebp)
  801a20:	6a 58                	push   $0x58
  801a22:	8b 45 08             	mov    0x8(%ebp),%eax
  801a25:	ff d0                	call   *%eax
  801a27:	83 c4 10             	add    $0x10,%esp
			break;
  801a2a:	e9 bc 00 00 00       	jmp    801aeb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801a2f:	83 ec 08             	sub    $0x8,%esp
  801a32:	ff 75 0c             	pushl  0xc(%ebp)
  801a35:	6a 30                	push   $0x30
  801a37:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3a:	ff d0                	call   *%eax
  801a3c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801a3f:	83 ec 08             	sub    $0x8,%esp
  801a42:	ff 75 0c             	pushl  0xc(%ebp)
  801a45:	6a 78                	push   $0x78
  801a47:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4a:	ff d0                	call   *%eax
  801a4c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801a4f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a52:	83 c0 04             	add    $0x4,%eax
  801a55:	89 45 14             	mov    %eax,0x14(%ebp)
  801a58:	8b 45 14             	mov    0x14(%ebp),%eax
  801a5b:	83 e8 04             	sub    $0x4,%eax
  801a5e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801a6a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801a71:	eb 1f                	jmp    801a92 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801a73:	83 ec 08             	sub    $0x8,%esp
  801a76:	ff 75 e8             	pushl  -0x18(%ebp)
  801a79:	8d 45 14             	lea    0x14(%ebp),%eax
  801a7c:	50                   	push   %eax
  801a7d:	e8 e7 fb ff ff       	call   801669 <getuint>
  801a82:	83 c4 10             	add    $0x10,%esp
  801a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a88:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801a8b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801a92:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801a96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a99:	83 ec 04             	sub    $0x4,%esp
  801a9c:	52                   	push   %edx
  801a9d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801aa0:	50                   	push   %eax
  801aa1:	ff 75 f4             	pushl  -0xc(%ebp)
  801aa4:	ff 75 f0             	pushl  -0x10(%ebp)
  801aa7:	ff 75 0c             	pushl  0xc(%ebp)
  801aaa:	ff 75 08             	pushl  0x8(%ebp)
  801aad:	e8 00 fb ff ff       	call   8015b2 <printnum>
  801ab2:	83 c4 20             	add    $0x20,%esp
			break;
  801ab5:	eb 34                	jmp    801aeb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801ab7:	83 ec 08             	sub    $0x8,%esp
  801aba:	ff 75 0c             	pushl  0xc(%ebp)
  801abd:	53                   	push   %ebx
  801abe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac1:	ff d0                	call   *%eax
  801ac3:	83 c4 10             	add    $0x10,%esp
			break;
  801ac6:	eb 23                	jmp    801aeb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801ac8:	83 ec 08             	sub    $0x8,%esp
  801acb:	ff 75 0c             	pushl  0xc(%ebp)
  801ace:	6a 25                	push   $0x25
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	ff d0                	call   *%eax
  801ad5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801ad8:	ff 4d 10             	decl   0x10(%ebp)
  801adb:	eb 03                	jmp    801ae0 <vprintfmt+0x3b1>
  801add:	ff 4d 10             	decl   0x10(%ebp)
  801ae0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae3:	48                   	dec    %eax
  801ae4:	8a 00                	mov    (%eax),%al
  801ae6:	3c 25                	cmp    $0x25,%al
  801ae8:	75 f3                	jne    801add <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801aea:	90                   	nop
		}
	}
  801aeb:	e9 47 fc ff ff       	jmp    801737 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801af0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801af1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801af4:	5b                   	pop    %ebx
  801af5:	5e                   	pop    %esi
  801af6:	5d                   	pop    %ebp
  801af7:	c3                   	ret    

00801af8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801af8:	55                   	push   %ebp
  801af9:	89 e5                	mov    %esp,%ebp
  801afb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801afe:	8d 45 10             	lea    0x10(%ebp),%eax
  801b01:	83 c0 04             	add    $0x4,%eax
  801b04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801b07:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0a:	ff 75 f4             	pushl  -0xc(%ebp)
  801b0d:	50                   	push   %eax
  801b0e:	ff 75 0c             	pushl  0xc(%ebp)
  801b11:	ff 75 08             	pushl  0x8(%ebp)
  801b14:	e8 16 fc ff ff       	call   80172f <vprintfmt>
  801b19:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801b1c:	90                   	nop
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b25:	8b 40 08             	mov    0x8(%eax),%eax
  801b28:	8d 50 01             	lea    0x1(%eax),%edx
  801b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b2e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801b31:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b34:	8b 10                	mov    (%eax),%edx
  801b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b39:	8b 40 04             	mov    0x4(%eax),%eax
  801b3c:	39 c2                	cmp    %eax,%edx
  801b3e:	73 12                	jae    801b52 <sprintputch+0x33>
		*b->buf++ = ch;
  801b40:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b43:	8b 00                	mov    (%eax),%eax
  801b45:	8d 48 01             	lea    0x1(%eax),%ecx
  801b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4b:	89 0a                	mov    %ecx,(%edx)
  801b4d:	8b 55 08             	mov    0x8(%ebp),%edx
  801b50:	88 10                	mov    %dl,(%eax)
}
  801b52:	90                   	nop
  801b53:	5d                   	pop    %ebp
  801b54:	c3                   	ret    

00801b55 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
  801b58:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b61:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b64:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	01 d0                	add    %edx,%eax
  801b6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801b76:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b7a:	74 06                	je     801b82 <vsnprintf+0x2d>
  801b7c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b80:	7f 07                	jg     801b89 <vsnprintf+0x34>
		return -E_INVAL;
  801b82:	b8 03 00 00 00       	mov    $0x3,%eax
  801b87:	eb 20                	jmp    801ba9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801b89:	ff 75 14             	pushl  0x14(%ebp)
  801b8c:	ff 75 10             	pushl  0x10(%ebp)
  801b8f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801b92:	50                   	push   %eax
  801b93:	68 1f 1b 80 00       	push   $0x801b1f
  801b98:	e8 92 fb ff ff       	call   80172f <vprintfmt>
  801b9d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801ba0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ba3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
  801bae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801bb1:	8d 45 10             	lea    0x10(%ebp),%eax
  801bb4:	83 c0 04             	add    $0x4,%eax
  801bb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801bba:	8b 45 10             	mov    0x10(%ebp),%eax
  801bbd:	ff 75 f4             	pushl  -0xc(%ebp)
  801bc0:	50                   	push   %eax
  801bc1:	ff 75 0c             	pushl  0xc(%ebp)
  801bc4:	ff 75 08             	pushl  0x8(%ebp)
  801bc7:	e8 89 ff ff ff       	call   801b55 <vsnprintf>
  801bcc:	83 c4 10             	add    $0x10,%esp
  801bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bd5:	c9                   	leave  
  801bd6:	c3                   	ret    

00801bd7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
  801bda:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801bdd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801be4:	eb 06                	jmp    801bec <strlen+0x15>
		n++;
  801be6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801be9:	ff 45 08             	incl   0x8(%ebp)
  801bec:	8b 45 08             	mov    0x8(%ebp),%eax
  801bef:	8a 00                	mov    (%eax),%al
  801bf1:	84 c0                	test   %al,%al
  801bf3:	75 f1                	jne    801be6 <strlen+0xf>
		n++;
	return n;
  801bf5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801bf8:	c9                   	leave  
  801bf9:	c3                   	ret    

00801bfa <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
  801bfd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801c00:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c07:	eb 09                	jmp    801c12 <strnlen+0x18>
		n++;
  801c09:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801c0c:	ff 45 08             	incl   0x8(%ebp)
  801c0f:	ff 4d 0c             	decl   0xc(%ebp)
  801c12:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c16:	74 09                	je     801c21 <strnlen+0x27>
  801c18:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1b:	8a 00                	mov    (%eax),%al
  801c1d:	84 c0                	test   %al,%al
  801c1f:	75 e8                	jne    801c09 <strnlen+0xf>
		n++;
	return n;
  801c21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
  801c29:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801c32:	90                   	nop
  801c33:	8b 45 08             	mov    0x8(%ebp),%eax
  801c36:	8d 50 01             	lea    0x1(%eax),%edx
  801c39:	89 55 08             	mov    %edx,0x8(%ebp)
  801c3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c3f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801c42:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801c45:	8a 12                	mov    (%edx),%dl
  801c47:	88 10                	mov    %dl,(%eax)
  801c49:	8a 00                	mov    (%eax),%al
  801c4b:	84 c0                	test   %al,%al
  801c4d:	75 e4                	jne    801c33 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801c4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c52:	c9                   	leave  
  801c53:	c3                   	ret    

00801c54 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801c54:	55                   	push   %ebp
  801c55:	89 e5                	mov    %esp,%ebp
  801c57:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801c60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c67:	eb 1f                	jmp    801c88 <strncpy+0x34>
		*dst++ = *src;
  801c69:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6c:	8d 50 01             	lea    0x1(%eax),%edx
  801c6f:	89 55 08             	mov    %edx,0x8(%ebp)
  801c72:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c75:	8a 12                	mov    (%edx),%dl
  801c77:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801c79:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c7c:	8a 00                	mov    (%eax),%al
  801c7e:	84 c0                	test   %al,%al
  801c80:	74 03                	je     801c85 <strncpy+0x31>
			src++;
  801c82:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801c85:	ff 45 fc             	incl   -0x4(%ebp)
  801c88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c8b:	3b 45 10             	cmp    0x10(%ebp),%eax
  801c8e:	72 d9                	jb     801c69 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801c90:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c93:	c9                   	leave  
  801c94:	c3                   	ret    

00801c95 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801c95:	55                   	push   %ebp
  801c96:	89 e5                	mov    %esp,%ebp
  801c98:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801ca1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ca5:	74 30                	je     801cd7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801ca7:	eb 16                	jmp    801cbf <strlcpy+0x2a>
			*dst++ = *src++;
  801ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cac:	8d 50 01             	lea    0x1(%eax),%edx
  801caf:	89 55 08             	mov    %edx,0x8(%ebp)
  801cb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  801cb8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801cbb:	8a 12                	mov    (%edx),%dl
  801cbd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801cbf:	ff 4d 10             	decl   0x10(%ebp)
  801cc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801cc6:	74 09                	je     801cd1 <strlcpy+0x3c>
  801cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ccb:	8a 00                	mov    (%eax),%al
  801ccd:	84 c0                	test   %al,%al
  801ccf:	75 d8                	jne    801ca9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801cd7:	8b 55 08             	mov    0x8(%ebp),%edx
  801cda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cdd:	29 c2                	sub    %eax,%edx
  801cdf:	89 d0                	mov    %edx,%eax
}
  801ce1:	c9                   	leave  
  801ce2:	c3                   	ret    

00801ce3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801ce3:	55                   	push   %ebp
  801ce4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801ce6:	eb 06                	jmp    801cee <strcmp+0xb>
		p++, q++;
  801ce8:	ff 45 08             	incl   0x8(%ebp)
  801ceb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801cee:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf1:	8a 00                	mov    (%eax),%al
  801cf3:	84 c0                	test   %al,%al
  801cf5:	74 0e                	je     801d05 <strcmp+0x22>
  801cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfa:	8a 10                	mov    (%eax),%dl
  801cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cff:	8a 00                	mov    (%eax),%al
  801d01:	38 c2                	cmp    %al,%dl
  801d03:	74 e3                	je     801ce8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801d05:	8b 45 08             	mov    0x8(%ebp),%eax
  801d08:	8a 00                	mov    (%eax),%al
  801d0a:	0f b6 d0             	movzbl %al,%edx
  801d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d10:	8a 00                	mov    (%eax),%al
  801d12:	0f b6 c0             	movzbl %al,%eax
  801d15:	29 c2                	sub    %eax,%edx
  801d17:	89 d0                	mov    %edx,%eax
}
  801d19:	5d                   	pop    %ebp
  801d1a:	c3                   	ret    

00801d1b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801d1e:	eb 09                	jmp    801d29 <strncmp+0xe>
		n--, p++, q++;
  801d20:	ff 4d 10             	decl   0x10(%ebp)
  801d23:	ff 45 08             	incl   0x8(%ebp)
  801d26:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801d29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d2d:	74 17                	je     801d46 <strncmp+0x2b>
  801d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d32:	8a 00                	mov    (%eax),%al
  801d34:	84 c0                	test   %al,%al
  801d36:	74 0e                	je     801d46 <strncmp+0x2b>
  801d38:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3b:	8a 10                	mov    (%eax),%dl
  801d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d40:	8a 00                	mov    (%eax),%al
  801d42:	38 c2                	cmp    %al,%dl
  801d44:	74 da                	je     801d20 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801d46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d4a:	75 07                	jne    801d53 <strncmp+0x38>
		return 0;
  801d4c:	b8 00 00 00 00       	mov    $0x0,%eax
  801d51:	eb 14                	jmp    801d67 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801d53:	8b 45 08             	mov    0x8(%ebp),%eax
  801d56:	8a 00                	mov    (%eax),%al
  801d58:	0f b6 d0             	movzbl %al,%edx
  801d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d5e:	8a 00                	mov    (%eax),%al
  801d60:	0f b6 c0             	movzbl %al,%eax
  801d63:	29 c2                	sub    %eax,%edx
  801d65:	89 d0                	mov    %edx,%eax
}
  801d67:	5d                   	pop    %ebp
  801d68:	c3                   	ret    

00801d69 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
  801d6c:	83 ec 04             	sub    $0x4,%esp
  801d6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d72:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801d75:	eb 12                	jmp    801d89 <strchr+0x20>
		if (*s == c)
  801d77:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7a:	8a 00                	mov    (%eax),%al
  801d7c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801d7f:	75 05                	jne    801d86 <strchr+0x1d>
			return (char *) s;
  801d81:	8b 45 08             	mov    0x8(%ebp),%eax
  801d84:	eb 11                	jmp    801d97 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801d86:	ff 45 08             	incl   0x8(%ebp)
  801d89:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8c:	8a 00                	mov    (%eax),%al
  801d8e:	84 c0                	test   %al,%al
  801d90:	75 e5                	jne    801d77 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801d92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d97:	c9                   	leave  
  801d98:	c3                   	ret    

00801d99 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
  801d9c:	83 ec 04             	sub    $0x4,%esp
  801d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801da2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801da5:	eb 0d                	jmp    801db4 <strfind+0x1b>
		if (*s == c)
  801da7:	8b 45 08             	mov    0x8(%ebp),%eax
  801daa:	8a 00                	mov    (%eax),%al
  801dac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801daf:	74 0e                	je     801dbf <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801db1:	ff 45 08             	incl   0x8(%ebp)
  801db4:	8b 45 08             	mov    0x8(%ebp),%eax
  801db7:	8a 00                	mov    (%eax),%al
  801db9:	84 c0                	test   %al,%al
  801dbb:	75 ea                	jne    801da7 <strfind+0xe>
  801dbd:	eb 01                	jmp    801dc0 <strfind+0x27>
		if (*s == c)
			break;
  801dbf:	90                   	nop
	return (char *) s;
  801dc0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
  801dc8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801dd1:	8b 45 10             	mov    0x10(%ebp),%eax
  801dd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801dd7:	eb 0e                	jmp    801de7 <memset+0x22>
		*p++ = c;
  801dd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ddc:	8d 50 01             	lea    0x1(%eax),%edx
  801ddf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801de2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801de7:	ff 4d f8             	decl   -0x8(%ebp)
  801dea:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801dee:	79 e9                	jns    801dd9 <memset+0x14>
		*p++ = c;

	return v;
  801df0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801df3:	c9                   	leave  
  801df4:	c3                   	ret    

00801df5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801df5:	55                   	push   %ebp
  801df6:	89 e5                	mov    %esp,%ebp
  801df8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801e01:	8b 45 08             	mov    0x8(%ebp),%eax
  801e04:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801e07:	eb 16                	jmp    801e1f <memcpy+0x2a>
		*d++ = *s++;
  801e09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e0c:	8d 50 01             	lea    0x1(%eax),%edx
  801e0f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801e12:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e15:	8d 4a 01             	lea    0x1(%edx),%ecx
  801e18:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801e1b:	8a 12                	mov    (%edx),%dl
  801e1d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801e1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e22:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e25:	89 55 10             	mov    %edx,0x10(%ebp)
  801e28:	85 c0                	test   %eax,%eax
  801e2a:	75 dd                	jne    801e09 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801e2c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801e2f:	c9                   	leave  
  801e30:	c3                   	ret    

00801e31 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
  801e34:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e40:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e46:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801e49:	73 50                	jae    801e9b <memmove+0x6a>
  801e4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  801e51:	01 d0                	add    %edx,%eax
  801e53:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801e56:	76 43                	jbe    801e9b <memmove+0x6a>
		s += n;
  801e58:	8b 45 10             	mov    0x10(%ebp),%eax
  801e5b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801e5e:	8b 45 10             	mov    0x10(%ebp),%eax
  801e61:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801e64:	eb 10                	jmp    801e76 <memmove+0x45>
			*--d = *--s;
  801e66:	ff 4d f8             	decl   -0x8(%ebp)
  801e69:	ff 4d fc             	decl   -0x4(%ebp)
  801e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e6f:	8a 10                	mov    (%eax),%dl
  801e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e74:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801e76:	8b 45 10             	mov    0x10(%ebp),%eax
  801e79:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e7c:	89 55 10             	mov    %edx,0x10(%ebp)
  801e7f:	85 c0                	test   %eax,%eax
  801e81:	75 e3                	jne    801e66 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801e83:	eb 23                	jmp    801ea8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801e85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e88:	8d 50 01             	lea    0x1(%eax),%edx
  801e8b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801e8e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e91:	8d 4a 01             	lea    0x1(%edx),%ecx
  801e94:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801e97:	8a 12                	mov    (%edx),%dl
  801e99:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  801e9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ea1:	89 55 10             	mov    %edx,0x10(%ebp)
  801ea4:	85 c0                	test   %eax,%eax
  801ea6:	75 dd                	jne    801e85 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801ea8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801eab:	c9                   	leave  
  801eac:	c3                   	ret    

00801ead <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801ead:	55                   	push   %ebp
  801eae:	89 e5                	mov    %esp,%ebp
  801eb0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ebc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801ebf:	eb 2a                	jmp    801eeb <memcmp+0x3e>
		if (*s1 != *s2)
  801ec1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ec4:	8a 10                	mov    (%eax),%dl
  801ec6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ec9:	8a 00                	mov    (%eax),%al
  801ecb:	38 c2                	cmp    %al,%dl
  801ecd:	74 16                	je     801ee5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801ecf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ed2:	8a 00                	mov    (%eax),%al
  801ed4:	0f b6 d0             	movzbl %al,%edx
  801ed7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801eda:	8a 00                	mov    (%eax),%al
  801edc:	0f b6 c0             	movzbl %al,%eax
  801edf:	29 c2                	sub    %eax,%edx
  801ee1:	89 d0                	mov    %edx,%eax
  801ee3:	eb 18                	jmp    801efd <memcmp+0x50>
		s1++, s2++;
  801ee5:	ff 45 fc             	incl   -0x4(%ebp)
  801ee8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801eeb:	8b 45 10             	mov    0x10(%ebp),%eax
  801eee:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ef1:	89 55 10             	mov    %edx,0x10(%ebp)
  801ef4:	85 c0                	test   %eax,%eax
  801ef6:	75 c9                	jne    801ec1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801ef8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801efd:	c9                   	leave  
  801efe:	c3                   	ret    

00801eff <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801eff:	55                   	push   %ebp
  801f00:	89 e5                	mov    %esp,%ebp
  801f02:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801f05:	8b 55 08             	mov    0x8(%ebp),%edx
  801f08:	8b 45 10             	mov    0x10(%ebp),%eax
  801f0b:	01 d0                	add    %edx,%eax
  801f0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801f10:	eb 15                	jmp    801f27 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801f12:	8b 45 08             	mov    0x8(%ebp),%eax
  801f15:	8a 00                	mov    (%eax),%al
  801f17:	0f b6 d0             	movzbl %al,%edx
  801f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f1d:	0f b6 c0             	movzbl %al,%eax
  801f20:	39 c2                	cmp    %eax,%edx
  801f22:	74 0d                	je     801f31 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801f24:	ff 45 08             	incl   0x8(%ebp)
  801f27:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801f2d:	72 e3                	jb     801f12 <memfind+0x13>
  801f2f:	eb 01                	jmp    801f32 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801f31:	90                   	nop
	return (void *) s;
  801f32:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f35:	c9                   	leave  
  801f36:	c3                   	ret    

00801f37 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801f37:	55                   	push   %ebp
  801f38:	89 e5                	mov    %esp,%ebp
  801f3a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801f3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801f44:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801f4b:	eb 03                	jmp    801f50 <strtol+0x19>
		s++;
  801f4d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801f50:	8b 45 08             	mov    0x8(%ebp),%eax
  801f53:	8a 00                	mov    (%eax),%al
  801f55:	3c 20                	cmp    $0x20,%al
  801f57:	74 f4                	je     801f4d <strtol+0x16>
  801f59:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5c:	8a 00                	mov    (%eax),%al
  801f5e:	3c 09                	cmp    $0x9,%al
  801f60:	74 eb                	je     801f4d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801f62:	8b 45 08             	mov    0x8(%ebp),%eax
  801f65:	8a 00                	mov    (%eax),%al
  801f67:	3c 2b                	cmp    $0x2b,%al
  801f69:	75 05                	jne    801f70 <strtol+0x39>
		s++;
  801f6b:	ff 45 08             	incl   0x8(%ebp)
  801f6e:	eb 13                	jmp    801f83 <strtol+0x4c>
	else if (*s == '-')
  801f70:	8b 45 08             	mov    0x8(%ebp),%eax
  801f73:	8a 00                	mov    (%eax),%al
  801f75:	3c 2d                	cmp    $0x2d,%al
  801f77:	75 0a                	jne    801f83 <strtol+0x4c>
		s++, neg = 1;
  801f79:	ff 45 08             	incl   0x8(%ebp)
  801f7c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801f83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f87:	74 06                	je     801f8f <strtol+0x58>
  801f89:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801f8d:	75 20                	jne    801faf <strtol+0x78>
  801f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f92:	8a 00                	mov    (%eax),%al
  801f94:	3c 30                	cmp    $0x30,%al
  801f96:	75 17                	jne    801faf <strtol+0x78>
  801f98:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9b:	40                   	inc    %eax
  801f9c:	8a 00                	mov    (%eax),%al
  801f9e:	3c 78                	cmp    $0x78,%al
  801fa0:	75 0d                	jne    801faf <strtol+0x78>
		s += 2, base = 16;
  801fa2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801fa6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801fad:	eb 28                	jmp    801fd7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801faf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fb3:	75 15                	jne    801fca <strtol+0x93>
  801fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb8:	8a 00                	mov    (%eax),%al
  801fba:	3c 30                	cmp    $0x30,%al
  801fbc:	75 0c                	jne    801fca <strtol+0x93>
		s++, base = 8;
  801fbe:	ff 45 08             	incl   0x8(%ebp)
  801fc1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801fc8:	eb 0d                	jmp    801fd7 <strtol+0xa0>
	else if (base == 0)
  801fca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fce:	75 07                	jne    801fd7 <strtol+0xa0>
		base = 10;
  801fd0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fda:	8a 00                	mov    (%eax),%al
  801fdc:	3c 2f                	cmp    $0x2f,%al
  801fde:	7e 19                	jle    801ff9 <strtol+0xc2>
  801fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe3:	8a 00                	mov    (%eax),%al
  801fe5:	3c 39                	cmp    $0x39,%al
  801fe7:	7f 10                	jg     801ff9 <strtol+0xc2>
			dig = *s - '0';
  801fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fec:	8a 00                	mov    (%eax),%al
  801fee:	0f be c0             	movsbl %al,%eax
  801ff1:	83 e8 30             	sub    $0x30,%eax
  801ff4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ff7:	eb 42                	jmp    80203b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffc:	8a 00                	mov    (%eax),%al
  801ffe:	3c 60                	cmp    $0x60,%al
  802000:	7e 19                	jle    80201b <strtol+0xe4>
  802002:	8b 45 08             	mov    0x8(%ebp),%eax
  802005:	8a 00                	mov    (%eax),%al
  802007:	3c 7a                	cmp    $0x7a,%al
  802009:	7f 10                	jg     80201b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80200b:	8b 45 08             	mov    0x8(%ebp),%eax
  80200e:	8a 00                	mov    (%eax),%al
  802010:	0f be c0             	movsbl %al,%eax
  802013:	83 e8 57             	sub    $0x57,%eax
  802016:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802019:	eb 20                	jmp    80203b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80201b:	8b 45 08             	mov    0x8(%ebp),%eax
  80201e:	8a 00                	mov    (%eax),%al
  802020:	3c 40                	cmp    $0x40,%al
  802022:	7e 39                	jle    80205d <strtol+0x126>
  802024:	8b 45 08             	mov    0x8(%ebp),%eax
  802027:	8a 00                	mov    (%eax),%al
  802029:	3c 5a                	cmp    $0x5a,%al
  80202b:	7f 30                	jg     80205d <strtol+0x126>
			dig = *s - 'A' + 10;
  80202d:	8b 45 08             	mov    0x8(%ebp),%eax
  802030:	8a 00                	mov    (%eax),%al
  802032:	0f be c0             	movsbl %al,%eax
  802035:	83 e8 37             	sub    $0x37,%eax
  802038:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80203b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80203e:	3b 45 10             	cmp    0x10(%ebp),%eax
  802041:	7d 19                	jge    80205c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802043:	ff 45 08             	incl   0x8(%ebp)
  802046:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802049:	0f af 45 10          	imul   0x10(%ebp),%eax
  80204d:	89 c2                	mov    %eax,%edx
  80204f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802052:	01 d0                	add    %edx,%eax
  802054:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802057:	e9 7b ff ff ff       	jmp    801fd7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80205c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80205d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802061:	74 08                	je     80206b <strtol+0x134>
		*endptr = (char *) s;
  802063:	8b 45 0c             	mov    0xc(%ebp),%eax
  802066:	8b 55 08             	mov    0x8(%ebp),%edx
  802069:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80206b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80206f:	74 07                	je     802078 <strtol+0x141>
  802071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802074:	f7 d8                	neg    %eax
  802076:	eb 03                	jmp    80207b <strtol+0x144>
  802078:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <ltostr>:

void
ltostr(long value, char *str)
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
  802080:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802083:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80208a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802091:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802095:	79 13                	jns    8020aa <ltostr+0x2d>
	{
		neg = 1;
  802097:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80209e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020a1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8020a4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8020a7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8020aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8020b2:	99                   	cltd   
  8020b3:	f7 f9                	idiv   %ecx
  8020b5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8020b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020bb:	8d 50 01             	lea    0x1(%eax),%edx
  8020be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8020c1:	89 c2                	mov    %eax,%edx
  8020c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020c6:	01 d0                	add    %edx,%eax
  8020c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8020cb:	83 c2 30             	add    $0x30,%edx
  8020ce:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8020d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020d3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8020d8:	f7 e9                	imul   %ecx
  8020da:	c1 fa 02             	sar    $0x2,%edx
  8020dd:	89 c8                	mov    %ecx,%eax
  8020df:	c1 f8 1f             	sar    $0x1f,%eax
  8020e2:	29 c2                	sub    %eax,%edx
  8020e4:	89 d0                	mov    %edx,%eax
  8020e6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8020e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020ec:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8020f1:	f7 e9                	imul   %ecx
  8020f3:	c1 fa 02             	sar    $0x2,%edx
  8020f6:	89 c8                	mov    %ecx,%eax
  8020f8:	c1 f8 1f             	sar    $0x1f,%eax
  8020fb:	29 c2                	sub    %eax,%edx
  8020fd:	89 d0                	mov    %edx,%eax
  8020ff:	c1 e0 02             	shl    $0x2,%eax
  802102:	01 d0                	add    %edx,%eax
  802104:	01 c0                	add    %eax,%eax
  802106:	29 c1                	sub    %eax,%ecx
  802108:	89 ca                	mov    %ecx,%edx
  80210a:	85 d2                	test   %edx,%edx
  80210c:	75 9c                	jne    8020aa <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80210e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802115:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802118:	48                   	dec    %eax
  802119:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80211c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802120:	74 3d                	je     80215f <ltostr+0xe2>
		start = 1 ;
  802122:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802129:	eb 34                	jmp    80215f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80212b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80212e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802131:	01 d0                	add    %edx,%eax
  802133:	8a 00                	mov    (%eax),%al
  802135:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802138:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80213b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80213e:	01 c2                	add    %eax,%edx
  802140:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802143:	8b 45 0c             	mov    0xc(%ebp),%eax
  802146:	01 c8                	add    %ecx,%eax
  802148:	8a 00                	mov    (%eax),%al
  80214a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80214c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80214f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802152:	01 c2                	add    %eax,%edx
  802154:	8a 45 eb             	mov    -0x15(%ebp),%al
  802157:	88 02                	mov    %al,(%edx)
		start++ ;
  802159:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80215c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80215f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802162:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802165:	7c c4                	jl     80212b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802167:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80216a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80216d:	01 d0                	add    %edx,%eax
  80216f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802172:	90                   	nop
  802173:	c9                   	leave  
  802174:	c3                   	ret    

00802175 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802175:	55                   	push   %ebp
  802176:	89 e5                	mov    %esp,%ebp
  802178:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80217b:	ff 75 08             	pushl  0x8(%ebp)
  80217e:	e8 54 fa ff ff       	call   801bd7 <strlen>
  802183:	83 c4 04             	add    $0x4,%esp
  802186:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802189:	ff 75 0c             	pushl  0xc(%ebp)
  80218c:	e8 46 fa ff ff       	call   801bd7 <strlen>
  802191:	83 c4 04             	add    $0x4,%esp
  802194:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802197:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80219e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8021a5:	eb 17                	jmp    8021be <strcconcat+0x49>
		final[s] = str1[s] ;
  8021a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8021ad:	01 c2                	add    %eax,%edx
  8021af:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8021b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b5:	01 c8                	add    %ecx,%eax
  8021b7:	8a 00                	mov    (%eax),%al
  8021b9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8021bb:	ff 45 fc             	incl   -0x4(%ebp)
  8021be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8021c4:	7c e1                	jl     8021a7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8021c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8021cd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8021d4:	eb 1f                	jmp    8021f5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8021d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021d9:	8d 50 01             	lea    0x1(%eax),%edx
  8021dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8021df:	89 c2                	mov    %eax,%edx
  8021e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8021e4:	01 c2                	add    %eax,%edx
  8021e6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8021e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021ec:	01 c8                	add    %ecx,%eax
  8021ee:	8a 00                	mov    (%eax),%al
  8021f0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8021f2:	ff 45 f8             	incl   -0x8(%ebp)
  8021f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8021fb:	7c d9                	jl     8021d6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8021fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802200:	8b 45 10             	mov    0x10(%ebp),%eax
  802203:	01 d0                	add    %edx,%eax
  802205:	c6 00 00             	movb   $0x0,(%eax)
}
  802208:	90                   	nop
  802209:	c9                   	leave  
  80220a:	c3                   	ret    

0080220b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80220b:	55                   	push   %ebp
  80220c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80220e:	8b 45 14             	mov    0x14(%ebp),%eax
  802211:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802217:	8b 45 14             	mov    0x14(%ebp),%eax
  80221a:	8b 00                	mov    (%eax),%eax
  80221c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802223:	8b 45 10             	mov    0x10(%ebp),%eax
  802226:	01 d0                	add    %edx,%eax
  802228:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80222e:	eb 0c                	jmp    80223c <strsplit+0x31>
			*string++ = 0;
  802230:	8b 45 08             	mov    0x8(%ebp),%eax
  802233:	8d 50 01             	lea    0x1(%eax),%edx
  802236:	89 55 08             	mov    %edx,0x8(%ebp)
  802239:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80223c:	8b 45 08             	mov    0x8(%ebp),%eax
  80223f:	8a 00                	mov    (%eax),%al
  802241:	84 c0                	test   %al,%al
  802243:	74 18                	je     80225d <strsplit+0x52>
  802245:	8b 45 08             	mov    0x8(%ebp),%eax
  802248:	8a 00                	mov    (%eax),%al
  80224a:	0f be c0             	movsbl %al,%eax
  80224d:	50                   	push   %eax
  80224e:	ff 75 0c             	pushl  0xc(%ebp)
  802251:	e8 13 fb ff ff       	call   801d69 <strchr>
  802256:	83 c4 08             	add    $0x8,%esp
  802259:	85 c0                	test   %eax,%eax
  80225b:	75 d3                	jne    802230 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80225d:	8b 45 08             	mov    0x8(%ebp),%eax
  802260:	8a 00                	mov    (%eax),%al
  802262:	84 c0                	test   %al,%al
  802264:	74 5a                	je     8022c0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  802266:	8b 45 14             	mov    0x14(%ebp),%eax
  802269:	8b 00                	mov    (%eax),%eax
  80226b:	83 f8 0f             	cmp    $0xf,%eax
  80226e:	75 07                	jne    802277 <strsplit+0x6c>
		{
			return 0;
  802270:	b8 00 00 00 00       	mov    $0x0,%eax
  802275:	eb 66                	jmp    8022dd <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802277:	8b 45 14             	mov    0x14(%ebp),%eax
  80227a:	8b 00                	mov    (%eax),%eax
  80227c:	8d 48 01             	lea    0x1(%eax),%ecx
  80227f:	8b 55 14             	mov    0x14(%ebp),%edx
  802282:	89 0a                	mov    %ecx,(%edx)
  802284:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80228b:	8b 45 10             	mov    0x10(%ebp),%eax
  80228e:	01 c2                	add    %eax,%edx
  802290:	8b 45 08             	mov    0x8(%ebp),%eax
  802293:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802295:	eb 03                	jmp    80229a <strsplit+0x8f>
			string++;
  802297:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80229a:	8b 45 08             	mov    0x8(%ebp),%eax
  80229d:	8a 00                	mov    (%eax),%al
  80229f:	84 c0                	test   %al,%al
  8022a1:	74 8b                	je     80222e <strsplit+0x23>
  8022a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a6:	8a 00                	mov    (%eax),%al
  8022a8:	0f be c0             	movsbl %al,%eax
  8022ab:	50                   	push   %eax
  8022ac:	ff 75 0c             	pushl  0xc(%ebp)
  8022af:	e8 b5 fa ff ff       	call   801d69 <strchr>
  8022b4:	83 c4 08             	add    $0x8,%esp
  8022b7:	85 c0                	test   %eax,%eax
  8022b9:	74 dc                	je     802297 <strsplit+0x8c>
			string++;
	}
  8022bb:	e9 6e ff ff ff       	jmp    80222e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8022c0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8022c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8022c4:	8b 00                	mov    (%eax),%eax
  8022c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8022cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8022d0:	01 d0                	add    %edx,%eax
  8022d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8022d8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
  8022e2:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8022e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e8:	c1 e8 0c             	shr    $0xc,%eax
  8022eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8022ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f1:	25 ff 0f 00 00       	and    $0xfff,%eax
  8022f6:	85 c0                	test   %eax,%eax
  8022f8:	74 03                	je     8022fd <malloc+0x1e>
			num++;
  8022fa:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8022fd:	a1 04 40 80 00       	mov    0x804004,%eax
  802302:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  802307:	75 73                	jne    80237c <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  802309:	83 ec 08             	sub    $0x8,%esp
  80230c:	ff 75 08             	pushl  0x8(%ebp)
  80230f:	68 00 00 00 80       	push   $0x80000000
  802314:	e8 13 05 00 00       	call   80282c <sys_allocateMem>
  802319:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80231c:	a1 04 40 80 00       	mov    0x804004,%eax
  802321:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  802324:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802327:	c1 e0 0c             	shl    $0xc,%eax
  80232a:	89 c2                	mov    %eax,%edx
  80232c:	a1 04 40 80 00       	mov    0x804004,%eax
  802331:	01 d0                	add    %edx,%eax
  802333:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  802338:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80233d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802340:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  802347:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80234c:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802352:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  802359:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80235e:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802365:	01 00 00 00 
			sizeofarray++;
  802369:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80236e:	40                   	inc    %eax
  80236f:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  802374:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802377:	e9 71 01 00 00       	jmp    8024ed <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  80237c:	a1 28 40 80 00       	mov    0x804028,%eax
  802381:	85 c0                	test   %eax,%eax
  802383:	75 71                	jne    8023f6 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  802385:	a1 04 40 80 00       	mov    0x804004,%eax
  80238a:	83 ec 08             	sub    $0x8,%esp
  80238d:	ff 75 08             	pushl  0x8(%ebp)
  802390:	50                   	push   %eax
  802391:	e8 96 04 00 00       	call   80282c <sys_allocateMem>
  802396:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  802399:	a1 04 40 80 00       	mov    0x804004,%eax
  80239e:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8023a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8023a4:	c1 e0 0c             	shl    $0xc,%eax
  8023a7:	89 c2                	mov    %eax,%edx
  8023a9:	a1 04 40 80 00       	mov    0x804004,%eax
  8023ae:	01 d0                	add    %edx,%eax
  8023b0:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  8023b5:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8023ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023bd:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8023c4:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8023c9:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8023cc:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  8023d3:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8023d8:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8023df:	01 00 00 00 
				sizeofarray++;
  8023e3:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8023e8:	40                   	inc    %eax
  8023e9:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  8023ee:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8023f1:	e9 f7 00 00 00       	jmp    8024ed <malloc+0x20e>
			}
			else{
				int count=0;
  8023f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8023fd:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  802404:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80240b:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  802412:	eb 7c                	jmp    802490 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  802414:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  80241b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  802422:	eb 1a                	jmp    80243e <malloc+0x15f>
					{
						if(addresses[j]==i)
  802424:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802427:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80242e:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  802431:	75 08                	jne    80243b <malloc+0x15c>
						{
							index=j;
  802433:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802436:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  802439:	eb 0d                	jmp    802448 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80243b:	ff 45 dc             	incl   -0x24(%ebp)
  80243e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802443:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  802446:	7c dc                	jl     802424 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  802448:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80244c:	75 05                	jne    802453 <malloc+0x174>
					{
						count++;
  80244e:	ff 45 f0             	incl   -0x10(%ebp)
  802451:	eb 36                	jmp    802489 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  802453:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802456:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  80245d:	85 c0                	test   %eax,%eax
  80245f:	75 05                	jne    802466 <malloc+0x187>
						{
							count++;
  802461:	ff 45 f0             	incl   -0x10(%ebp)
  802464:	eb 23                	jmp    802489 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  802466:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802469:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80246c:	7d 14                	jge    802482 <malloc+0x1a3>
  80246e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802471:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802474:	7c 0c                	jl     802482 <malloc+0x1a3>
							{
								min=count;
  802476:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802479:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  80247c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80247f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  802482:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  802489:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  802490:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  802497:	0f 86 77 ff ff ff    	jbe    802414 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  80249d:	83 ec 08             	sub    $0x8,%esp
  8024a0:	ff 75 08             	pushl  0x8(%ebp)
  8024a3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8024a6:	e8 81 03 00 00       	call   80282c <sys_allocateMem>
  8024ab:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8024ae:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8024b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8024b6:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8024bd:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8024c2:	8b 15 04 40 80 00    	mov    0x804004,%edx
  8024c8:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  8024cf:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8024d4:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8024db:	01 00 00 00 
				sizeofarray++;
  8024df:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8024e4:	40                   	inc    %eax
  8024e5:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  8024ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8024ed:	c9                   	leave  
  8024ee:	c3                   	ret    

008024ef <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8024ef:	55                   	push   %ebp
  8024f0:	89 e5                	mov    %esp,%ebp
  8024f2:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8024f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  8024fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  802502:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  802509:	eb 30                	jmp    80253b <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  80250b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80250e:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802515:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802518:	75 1e                	jne    802538 <free+0x49>
  80251a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80251d:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802524:	83 f8 01             	cmp    $0x1,%eax
  802527:	75 0f                	jne    802538 <free+0x49>
    		is_found=1;
  802529:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  802530:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802533:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  802536:	eb 0d                	jmp    802545 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  802538:	ff 45 ec             	incl   -0x14(%ebp)
  80253b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802540:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802543:	7c c6                	jl     80250b <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  802545:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802549:	75 3a                	jne    802585 <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  80254b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80254e:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  802555:	c1 e0 0c             	shl    $0xc,%eax
  802558:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  80255b:	83 ec 08             	sub    $0x8,%esp
  80255e:	ff 75 e4             	pushl  -0x1c(%ebp)
  802561:	ff 75 e8             	pushl  -0x18(%ebp)
  802564:	e8 a7 02 00 00       	call   802810 <sys_freeMem>
  802569:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  80256c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80256f:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802576:	00 00 00 00 
    	changes++;
  80257a:	a1 28 40 80 00       	mov    0x804028,%eax
  80257f:	40                   	inc    %eax
  802580:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  802585:	90                   	nop
  802586:	c9                   	leave  
  802587:	c3                   	ret    

00802588 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802588:	55                   	push   %ebp
  802589:	89 e5                	mov    %esp,%ebp
  80258b:	83 ec 18             	sub    $0x18,%esp
  80258e:	8b 45 10             	mov    0x10(%ebp),%eax
  802591:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802594:	83 ec 04             	sub    $0x4,%esp
  802597:	68 f0 37 80 00       	push   $0x8037f0
  80259c:	68 9f 00 00 00       	push   $0x9f
  8025a1:	68 13 38 80 00       	push   $0x803813
  8025a6:	e8 08 ed ff ff       	call   8012b3 <_panic>

008025ab <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8025ab:	55                   	push   %ebp
  8025ac:	89 e5                	mov    %esp,%ebp
  8025ae:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8025b1:	83 ec 04             	sub    $0x4,%esp
  8025b4:	68 f0 37 80 00       	push   $0x8037f0
  8025b9:	68 a5 00 00 00       	push   $0xa5
  8025be:	68 13 38 80 00       	push   $0x803813
  8025c3:	e8 eb ec ff ff       	call   8012b3 <_panic>

008025c8 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8025c8:	55                   	push   %ebp
  8025c9:	89 e5                	mov    %esp,%ebp
  8025cb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8025ce:	83 ec 04             	sub    $0x4,%esp
  8025d1:	68 f0 37 80 00       	push   $0x8037f0
  8025d6:	68 ab 00 00 00       	push   $0xab
  8025db:	68 13 38 80 00       	push   $0x803813
  8025e0:	e8 ce ec ff ff       	call   8012b3 <_panic>

008025e5 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8025e5:	55                   	push   %ebp
  8025e6:	89 e5                	mov    %esp,%ebp
  8025e8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8025eb:	83 ec 04             	sub    $0x4,%esp
  8025ee:	68 f0 37 80 00       	push   $0x8037f0
  8025f3:	68 b0 00 00 00       	push   $0xb0
  8025f8:	68 13 38 80 00       	push   $0x803813
  8025fd:	e8 b1 ec ff ff       	call   8012b3 <_panic>

00802602 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802602:	55                   	push   %ebp
  802603:	89 e5                	mov    %esp,%ebp
  802605:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802608:	83 ec 04             	sub    $0x4,%esp
  80260b:	68 f0 37 80 00       	push   $0x8037f0
  802610:	68 b6 00 00 00       	push   $0xb6
  802615:	68 13 38 80 00       	push   $0x803813
  80261a:	e8 94 ec ff ff       	call   8012b3 <_panic>

0080261f <shrink>:
}
void shrink(uint32 newSize)
{
  80261f:	55                   	push   %ebp
  802620:	89 e5                	mov    %esp,%ebp
  802622:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802625:	83 ec 04             	sub    $0x4,%esp
  802628:	68 f0 37 80 00       	push   $0x8037f0
  80262d:	68 ba 00 00 00       	push   $0xba
  802632:	68 13 38 80 00       	push   $0x803813
  802637:	e8 77 ec ff ff       	call   8012b3 <_panic>

0080263c <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80263c:	55                   	push   %ebp
  80263d:	89 e5                	mov    %esp,%ebp
  80263f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802642:	83 ec 04             	sub    $0x4,%esp
  802645:	68 f0 37 80 00       	push   $0x8037f0
  80264a:	68 bf 00 00 00       	push   $0xbf
  80264f:	68 13 38 80 00       	push   $0x803813
  802654:	e8 5a ec ff ff       	call   8012b3 <_panic>

00802659 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802659:	55                   	push   %ebp
  80265a:	89 e5                	mov    %esp,%ebp
  80265c:	57                   	push   %edi
  80265d:	56                   	push   %esi
  80265e:	53                   	push   %ebx
  80265f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802662:	8b 45 08             	mov    0x8(%ebp),%eax
  802665:	8b 55 0c             	mov    0xc(%ebp),%edx
  802668:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80266b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80266e:	8b 7d 18             	mov    0x18(%ebp),%edi
  802671:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802674:	cd 30                	int    $0x30
  802676:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802679:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80267c:	83 c4 10             	add    $0x10,%esp
  80267f:	5b                   	pop    %ebx
  802680:	5e                   	pop    %esi
  802681:	5f                   	pop    %edi
  802682:	5d                   	pop    %ebp
  802683:	c3                   	ret    

00802684 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802684:	55                   	push   %ebp
  802685:	89 e5                	mov    %esp,%ebp
  802687:	83 ec 04             	sub    $0x4,%esp
  80268a:	8b 45 10             	mov    0x10(%ebp),%eax
  80268d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802690:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802694:	8b 45 08             	mov    0x8(%ebp),%eax
  802697:	6a 00                	push   $0x0
  802699:	6a 00                	push   $0x0
  80269b:	52                   	push   %edx
  80269c:	ff 75 0c             	pushl  0xc(%ebp)
  80269f:	50                   	push   %eax
  8026a0:	6a 00                	push   $0x0
  8026a2:	e8 b2 ff ff ff       	call   802659 <syscall>
  8026a7:	83 c4 18             	add    $0x18,%esp
}
  8026aa:	90                   	nop
  8026ab:	c9                   	leave  
  8026ac:	c3                   	ret    

008026ad <sys_cgetc>:

int
sys_cgetc(void)
{
  8026ad:	55                   	push   %ebp
  8026ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8026b0:	6a 00                	push   $0x0
  8026b2:	6a 00                	push   $0x0
  8026b4:	6a 00                	push   $0x0
  8026b6:	6a 00                	push   $0x0
  8026b8:	6a 00                	push   $0x0
  8026ba:	6a 01                	push   $0x1
  8026bc:	e8 98 ff ff ff       	call   802659 <syscall>
  8026c1:	83 c4 18             	add    $0x18,%esp
}
  8026c4:	c9                   	leave  
  8026c5:	c3                   	ret    

008026c6 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8026c6:	55                   	push   %ebp
  8026c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8026c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026cc:	6a 00                	push   $0x0
  8026ce:	6a 00                	push   $0x0
  8026d0:	6a 00                	push   $0x0
  8026d2:	6a 00                	push   $0x0
  8026d4:	50                   	push   %eax
  8026d5:	6a 05                	push   $0x5
  8026d7:	e8 7d ff ff ff       	call   802659 <syscall>
  8026dc:	83 c4 18             	add    $0x18,%esp
}
  8026df:	c9                   	leave  
  8026e0:	c3                   	ret    

008026e1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8026e1:	55                   	push   %ebp
  8026e2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8026e4:	6a 00                	push   $0x0
  8026e6:	6a 00                	push   $0x0
  8026e8:	6a 00                	push   $0x0
  8026ea:	6a 00                	push   $0x0
  8026ec:	6a 00                	push   $0x0
  8026ee:	6a 02                	push   $0x2
  8026f0:	e8 64 ff ff ff       	call   802659 <syscall>
  8026f5:	83 c4 18             	add    $0x18,%esp
}
  8026f8:	c9                   	leave  
  8026f9:	c3                   	ret    

008026fa <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8026fa:	55                   	push   %ebp
  8026fb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8026fd:	6a 00                	push   $0x0
  8026ff:	6a 00                	push   $0x0
  802701:	6a 00                	push   $0x0
  802703:	6a 00                	push   $0x0
  802705:	6a 00                	push   $0x0
  802707:	6a 03                	push   $0x3
  802709:	e8 4b ff ff ff       	call   802659 <syscall>
  80270e:	83 c4 18             	add    $0x18,%esp
}
  802711:	c9                   	leave  
  802712:	c3                   	ret    

00802713 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802713:	55                   	push   %ebp
  802714:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802716:	6a 00                	push   $0x0
  802718:	6a 00                	push   $0x0
  80271a:	6a 00                	push   $0x0
  80271c:	6a 00                	push   $0x0
  80271e:	6a 00                	push   $0x0
  802720:	6a 04                	push   $0x4
  802722:	e8 32 ff ff ff       	call   802659 <syscall>
  802727:	83 c4 18             	add    $0x18,%esp
}
  80272a:	c9                   	leave  
  80272b:	c3                   	ret    

0080272c <sys_env_exit>:


void sys_env_exit(void)
{
  80272c:	55                   	push   %ebp
  80272d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80272f:	6a 00                	push   $0x0
  802731:	6a 00                	push   $0x0
  802733:	6a 00                	push   $0x0
  802735:	6a 00                	push   $0x0
  802737:	6a 00                	push   $0x0
  802739:	6a 06                	push   $0x6
  80273b:	e8 19 ff ff ff       	call   802659 <syscall>
  802740:	83 c4 18             	add    $0x18,%esp
}
  802743:	90                   	nop
  802744:	c9                   	leave  
  802745:	c3                   	ret    

00802746 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802746:	55                   	push   %ebp
  802747:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802749:	8b 55 0c             	mov    0xc(%ebp),%edx
  80274c:	8b 45 08             	mov    0x8(%ebp),%eax
  80274f:	6a 00                	push   $0x0
  802751:	6a 00                	push   $0x0
  802753:	6a 00                	push   $0x0
  802755:	52                   	push   %edx
  802756:	50                   	push   %eax
  802757:	6a 07                	push   $0x7
  802759:	e8 fb fe ff ff       	call   802659 <syscall>
  80275e:	83 c4 18             	add    $0x18,%esp
}
  802761:	c9                   	leave  
  802762:	c3                   	ret    

00802763 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802763:	55                   	push   %ebp
  802764:	89 e5                	mov    %esp,%ebp
  802766:	56                   	push   %esi
  802767:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802768:	8b 75 18             	mov    0x18(%ebp),%esi
  80276b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80276e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802771:	8b 55 0c             	mov    0xc(%ebp),%edx
  802774:	8b 45 08             	mov    0x8(%ebp),%eax
  802777:	56                   	push   %esi
  802778:	53                   	push   %ebx
  802779:	51                   	push   %ecx
  80277a:	52                   	push   %edx
  80277b:	50                   	push   %eax
  80277c:	6a 08                	push   $0x8
  80277e:	e8 d6 fe ff ff       	call   802659 <syscall>
  802783:	83 c4 18             	add    $0x18,%esp
}
  802786:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802789:	5b                   	pop    %ebx
  80278a:	5e                   	pop    %esi
  80278b:	5d                   	pop    %ebp
  80278c:	c3                   	ret    

0080278d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80278d:	55                   	push   %ebp
  80278e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802790:	8b 55 0c             	mov    0xc(%ebp),%edx
  802793:	8b 45 08             	mov    0x8(%ebp),%eax
  802796:	6a 00                	push   $0x0
  802798:	6a 00                	push   $0x0
  80279a:	6a 00                	push   $0x0
  80279c:	52                   	push   %edx
  80279d:	50                   	push   %eax
  80279e:	6a 09                	push   $0x9
  8027a0:	e8 b4 fe ff ff       	call   802659 <syscall>
  8027a5:	83 c4 18             	add    $0x18,%esp
}
  8027a8:	c9                   	leave  
  8027a9:	c3                   	ret    

008027aa <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8027aa:	55                   	push   %ebp
  8027ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8027ad:	6a 00                	push   $0x0
  8027af:	6a 00                	push   $0x0
  8027b1:	6a 00                	push   $0x0
  8027b3:	ff 75 0c             	pushl  0xc(%ebp)
  8027b6:	ff 75 08             	pushl  0x8(%ebp)
  8027b9:	6a 0a                	push   $0xa
  8027bb:	e8 99 fe ff ff       	call   802659 <syscall>
  8027c0:	83 c4 18             	add    $0x18,%esp
}
  8027c3:	c9                   	leave  
  8027c4:	c3                   	ret    

008027c5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8027c5:	55                   	push   %ebp
  8027c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8027c8:	6a 00                	push   $0x0
  8027ca:	6a 00                	push   $0x0
  8027cc:	6a 00                	push   $0x0
  8027ce:	6a 00                	push   $0x0
  8027d0:	6a 00                	push   $0x0
  8027d2:	6a 0b                	push   $0xb
  8027d4:	e8 80 fe ff ff       	call   802659 <syscall>
  8027d9:	83 c4 18             	add    $0x18,%esp
}
  8027dc:	c9                   	leave  
  8027dd:	c3                   	ret    

008027de <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8027de:	55                   	push   %ebp
  8027df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8027e1:	6a 00                	push   $0x0
  8027e3:	6a 00                	push   $0x0
  8027e5:	6a 00                	push   $0x0
  8027e7:	6a 00                	push   $0x0
  8027e9:	6a 00                	push   $0x0
  8027eb:	6a 0c                	push   $0xc
  8027ed:	e8 67 fe ff ff       	call   802659 <syscall>
  8027f2:	83 c4 18             	add    $0x18,%esp
}
  8027f5:	c9                   	leave  
  8027f6:	c3                   	ret    

008027f7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8027f7:	55                   	push   %ebp
  8027f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8027fa:	6a 00                	push   $0x0
  8027fc:	6a 00                	push   $0x0
  8027fe:	6a 00                	push   $0x0
  802800:	6a 00                	push   $0x0
  802802:	6a 00                	push   $0x0
  802804:	6a 0d                	push   $0xd
  802806:	e8 4e fe ff ff       	call   802659 <syscall>
  80280b:	83 c4 18             	add    $0x18,%esp
}
  80280e:	c9                   	leave  
  80280f:	c3                   	ret    

00802810 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802810:	55                   	push   %ebp
  802811:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802813:	6a 00                	push   $0x0
  802815:	6a 00                	push   $0x0
  802817:	6a 00                	push   $0x0
  802819:	ff 75 0c             	pushl  0xc(%ebp)
  80281c:	ff 75 08             	pushl  0x8(%ebp)
  80281f:	6a 11                	push   $0x11
  802821:	e8 33 fe ff ff       	call   802659 <syscall>
  802826:	83 c4 18             	add    $0x18,%esp
	return;
  802829:	90                   	nop
}
  80282a:	c9                   	leave  
  80282b:	c3                   	ret    

0080282c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80282c:	55                   	push   %ebp
  80282d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80282f:	6a 00                	push   $0x0
  802831:	6a 00                	push   $0x0
  802833:	6a 00                	push   $0x0
  802835:	ff 75 0c             	pushl  0xc(%ebp)
  802838:	ff 75 08             	pushl  0x8(%ebp)
  80283b:	6a 12                	push   $0x12
  80283d:	e8 17 fe ff ff       	call   802659 <syscall>
  802842:	83 c4 18             	add    $0x18,%esp
	return ;
  802845:	90                   	nop
}
  802846:	c9                   	leave  
  802847:	c3                   	ret    

00802848 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802848:	55                   	push   %ebp
  802849:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80284b:	6a 00                	push   $0x0
  80284d:	6a 00                	push   $0x0
  80284f:	6a 00                	push   $0x0
  802851:	6a 00                	push   $0x0
  802853:	6a 00                	push   $0x0
  802855:	6a 0e                	push   $0xe
  802857:	e8 fd fd ff ff       	call   802659 <syscall>
  80285c:	83 c4 18             	add    $0x18,%esp
}
  80285f:	c9                   	leave  
  802860:	c3                   	ret    

00802861 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802861:	55                   	push   %ebp
  802862:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802864:	6a 00                	push   $0x0
  802866:	6a 00                	push   $0x0
  802868:	6a 00                	push   $0x0
  80286a:	6a 00                	push   $0x0
  80286c:	ff 75 08             	pushl  0x8(%ebp)
  80286f:	6a 0f                	push   $0xf
  802871:	e8 e3 fd ff ff       	call   802659 <syscall>
  802876:	83 c4 18             	add    $0x18,%esp
}
  802879:	c9                   	leave  
  80287a:	c3                   	ret    

0080287b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80287b:	55                   	push   %ebp
  80287c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80287e:	6a 00                	push   $0x0
  802880:	6a 00                	push   $0x0
  802882:	6a 00                	push   $0x0
  802884:	6a 00                	push   $0x0
  802886:	6a 00                	push   $0x0
  802888:	6a 10                	push   $0x10
  80288a:	e8 ca fd ff ff       	call   802659 <syscall>
  80288f:	83 c4 18             	add    $0x18,%esp
}
  802892:	90                   	nop
  802893:	c9                   	leave  
  802894:	c3                   	ret    

00802895 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802895:	55                   	push   %ebp
  802896:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802898:	6a 00                	push   $0x0
  80289a:	6a 00                	push   $0x0
  80289c:	6a 00                	push   $0x0
  80289e:	6a 00                	push   $0x0
  8028a0:	6a 00                	push   $0x0
  8028a2:	6a 14                	push   $0x14
  8028a4:	e8 b0 fd ff ff       	call   802659 <syscall>
  8028a9:	83 c4 18             	add    $0x18,%esp
}
  8028ac:	90                   	nop
  8028ad:	c9                   	leave  
  8028ae:	c3                   	ret    

008028af <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8028af:	55                   	push   %ebp
  8028b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8028b2:	6a 00                	push   $0x0
  8028b4:	6a 00                	push   $0x0
  8028b6:	6a 00                	push   $0x0
  8028b8:	6a 00                	push   $0x0
  8028ba:	6a 00                	push   $0x0
  8028bc:	6a 15                	push   $0x15
  8028be:	e8 96 fd ff ff       	call   802659 <syscall>
  8028c3:	83 c4 18             	add    $0x18,%esp
}
  8028c6:	90                   	nop
  8028c7:	c9                   	leave  
  8028c8:	c3                   	ret    

008028c9 <sys_cputc>:


void
sys_cputc(const char c)
{
  8028c9:	55                   	push   %ebp
  8028ca:	89 e5                	mov    %esp,%ebp
  8028cc:	83 ec 04             	sub    $0x4,%esp
  8028cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8028d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8028d5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8028d9:	6a 00                	push   $0x0
  8028db:	6a 00                	push   $0x0
  8028dd:	6a 00                	push   $0x0
  8028df:	6a 00                	push   $0x0
  8028e1:	50                   	push   %eax
  8028e2:	6a 16                	push   $0x16
  8028e4:	e8 70 fd ff ff       	call   802659 <syscall>
  8028e9:	83 c4 18             	add    $0x18,%esp
}
  8028ec:	90                   	nop
  8028ed:	c9                   	leave  
  8028ee:	c3                   	ret    

008028ef <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8028ef:	55                   	push   %ebp
  8028f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8028f2:	6a 00                	push   $0x0
  8028f4:	6a 00                	push   $0x0
  8028f6:	6a 00                	push   $0x0
  8028f8:	6a 00                	push   $0x0
  8028fa:	6a 00                	push   $0x0
  8028fc:	6a 17                	push   $0x17
  8028fe:	e8 56 fd ff ff       	call   802659 <syscall>
  802903:	83 c4 18             	add    $0x18,%esp
}
  802906:	90                   	nop
  802907:	c9                   	leave  
  802908:	c3                   	ret    

00802909 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802909:	55                   	push   %ebp
  80290a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80290c:	8b 45 08             	mov    0x8(%ebp),%eax
  80290f:	6a 00                	push   $0x0
  802911:	6a 00                	push   $0x0
  802913:	6a 00                	push   $0x0
  802915:	ff 75 0c             	pushl  0xc(%ebp)
  802918:	50                   	push   %eax
  802919:	6a 18                	push   $0x18
  80291b:	e8 39 fd ff ff       	call   802659 <syscall>
  802920:	83 c4 18             	add    $0x18,%esp
}
  802923:	c9                   	leave  
  802924:	c3                   	ret    

00802925 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802925:	55                   	push   %ebp
  802926:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80292b:	8b 45 08             	mov    0x8(%ebp),%eax
  80292e:	6a 00                	push   $0x0
  802930:	6a 00                	push   $0x0
  802932:	6a 00                	push   $0x0
  802934:	52                   	push   %edx
  802935:	50                   	push   %eax
  802936:	6a 1b                	push   $0x1b
  802938:	e8 1c fd ff ff       	call   802659 <syscall>
  80293d:	83 c4 18             	add    $0x18,%esp
}
  802940:	c9                   	leave  
  802941:	c3                   	ret    

00802942 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802942:	55                   	push   %ebp
  802943:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802945:	8b 55 0c             	mov    0xc(%ebp),%edx
  802948:	8b 45 08             	mov    0x8(%ebp),%eax
  80294b:	6a 00                	push   $0x0
  80294d:	6a 00                	push   $0x0
  80294f:	6a 00                	push   $0x0
  802951:	52                   	push   %edx
  802952:	50                   	push   %eax
  802953:	6a 19                	push   $0x19
  802955:	e8 ff fc ff ff       	call   802659 <syscall>
  80295a:	83 c4 18             	add    $0x18,%esp
}
  80295d:	90                   	nop
  80295e:	c9                   	leave  
  80295f:	c3                   	ret    

00802960 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802960:	55                   	push   %ebp
  802961:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802963:	8b 55 0c             	mov    0xc(%ebp),%edx
  802966:	8b 45 08             	mov    0x8(%ebp),%eax
  802969:	6a 00                	push   $0x0
  80296b:	6a 00                	push   $0x0
  80296d:	6a 00                	push   $0x0
  80296f:	52                   	push   %edx
  802970:	50                   	push   %eax
  802971:	6a 1a                	push   $0x1a
  802973:	e8 e1 fc ff ff       	call   802659 <syscall>
  802978:	83 c4 18             	add    $0x18,%esp
}
  80297b:	90                   	nop
  80297c:	c9                   	leave  
  80297d:	c3                   	ret    

0080297e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80297e:	55                   	push   %ebp
  80297f:	89 e5                	mov    %esp,%ebp
  802981:	83 ec 04             	sub    $0x4,%esp
  802984:	8b 45 10             	mov    0x10(%ebp),%eax
  802987:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80298a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80298d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802991:	8b 45 08             	mov    0x8(%ebp),%eax
  802994:	6a 00                	push   $0x0
  802996:	51                   	push   %ecx
  802997:	52                   	push   %edx
  802998:	ff 75 0c             	pushl  0xc(%ebp)
  80299b:	50                   	push   %eax
  80299c:	6a 1c                	push   $0x1c
  80299e:	e8 b6 fc ff ff       	call   802659 <syscall>
  8029a3:	83 c4 18             	add    $0x18,%esp
}
  8029a6:	c9                   	leave  
  8029a7:	c3                   	ret    

008029a8 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8029a8:	55                   	push   %ebp
  8029a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8029ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8029b1:	6a 00                	push   $0x0
  8029b3:	6a 00                	push   $0x0
  8029b5:	6a 00                	push   $0x0
  8029b7:	52                   	push   %edx
  8029b8:	50                   	push   %eax
  8029b9:	6a 1d                	push   $0x1d
  8029bb:	e8 99 fc ff ff       	call   802659 <syscall>
  8029c0:	83 c4 18             	add    $0x18,%esp
}
  8029c3:	c9                   	leave  
  8029c4:	c3                   	ret    

008029c5 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8029c5:	55                   	push   %ebp
  8029c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8029c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8029cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8029d1:	6a 00                	push   $0x0
  8029d3:	6a 00                	push   $0x0
  8029d5:	51                   	push   %ecx
  8029d6:	52                   	push   %edx
  8029d7:	50                   	push   %eax
  8029d8:	6a 1e                	push   $0x1e
  8029da:	e8 7a fc ff ff       	call   802659 <syscall>
  8029df:	83 c4 18             	add    $0x18,%esp
}
  8029e2:	c9                   	leave  
  8029e3:	c3                   	ret    

008029e4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8029e4:	55                   	push   %ebp
  8029e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8029e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8029ed:	6a 00                	push   $0x0
  8029ef:	6a 00                	push   $0x0
  8029f1:	6a 00                	push   $0x0
  8029f3:	52                   	push   %edx
  8029f4:	50                   	push   %eax
  8029f5:	6a 1f                	push   $0x1f
  8029f7:	e8 5d fc ff ff       	call   802659 <syscall>
  8029fc:	83 c4 18             	add    $0x18,%esp
}
  8029ff:	c9                   	leave  
  802a00:	c3                   	ret    

00802a01 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802a01:	55                   	push   %ebp
  802a02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802a04:	6a 00                	push   $0x0
  802a06:	6a 00                	push   $0x0
  802a08:	6a 00                	push   $0x0
  802a0a:	6a 00                	push   $0x0
  802a0c:	6a 00                	push   $0x0
  802a0e:	6a 20                	push   $0x20
  802a10:	e8 44 fc ff ff       	call   802659 <syscall>
  802a15:	83 c4 18             	add    $0x18,%esp
}
  802a18:	c9                   	leave  
  802a19:	c3                   	ret    

00802a1a <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802a1a:	55                   	push   %ebp
  802a1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  802a20:	6a 00                	push   $0x0
  802a22:	ff 75 14             	pushl  0x14(%ebp)
  802a25:	ff 75 10             	pushl  0x10(%ebp)
  802a28:	ff 75 0c             	pushl  0xc(%ebp)
  802a2b:	50                   	push   %eax
  802a2c:	6a 21                	push   $0x21
  802a2e:	e8 26 fc ff ff       	call   802659 <syscall>
  802a33:	83 c4 18             	add    $0x18,%esp
}
  802a36:	c9                   	leave  
  802a37:	c3                   	ret    

00802a38 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802a38:	55                   	push   %ebp
  802a39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  802a3e:	6a 00                	push   $0x0
  802a40:	6a 00                	push   $0x0
  802a42:	6a 00                	push   $0x0
  802a44:	6a 00                	push   $0x0
  802a46:	50                   	push   %eax
  802a47:	6a 22                	push   $0x22
  802a49:	e8 0b fc ff ff       	call   802659 <syscall>
  802a4e:	83 c4 18             	add    $0x18,%esp
}
  802a51:	90                   	nop
  802a52:	c9                   	leave  
  802a53:	c3                   	ret    

00802a54 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802a54:	55                   	push   %ebp
  802a55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802a57:	8b 45 08             	mov    0x8(%ebp),%eax
  802a5a:	6a 00                	push   $0x0
  802a5c:	6a 00                	push   $0x0
  802a5e:	6a 00                	push   $0x0
  802a60:	6a 00                	push   $0x0
  802a62:	50                   	push   %eax
  802a63:	6a 23                	push   $0x23
  802a65:	e8 ef fb ff ff       	call   802659 <syscall>
  802a6a:	83 c4 18             	add    $0x18,%esp
}
  802a6d:	90                   	nop
  802a6e:	c9                   	leave  
  802a6f:	c3                   	ret    

00802a70 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802a70:	55                   	push   %ebp
  802a71:	89 e5                	mov    %esp,%ebp
  802a73:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802a76:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a79:	8d 50 04             	lea    0x4(%eax),%edx
  802a7c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a7f:	6a 00                	push   $0x0
  802a81:	6a 00                	push   $0x0
  802a83:	6a 00                	push   $0x0
  802a85:	52                   	push   %edx
  802a86:	50                   	push   %eax
  802a87:	6a 24                	push   $0x24
  802a89:	e8 cb fb ff ff       	call   802659 <syscall>
  802a8e:	83 c4 18             	add    $0x18,%esp
	return result;
  802a91:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802a94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802a97:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a9a:	89 01                	mov    %eax,(%ecx)
  802a9c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  802aa2:	c9                   	leave  
  802aa3:	c2 04 00             	ret    $0x4

00802aa6 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802aa6:	55                   	push   %ebp
  802aa7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802aa9:	6a 00                	push   $0x0
  802aab:	6a 00                	push   $0x0
  802aad:	ff 75 10             	pushl  0x10(%ebp)
  802ab0:	ff 75 0c             	pushl  0xc(%ebp)
  802ab3:	ff 75 08             	pushl  0x8(%ebp)
  802ab6:	6a 13                	push   $0x13
  802ab8:	e8 9c fb ff ff       	call   802659 <syscall>
  802abd:	83 c4 18             	add    $0x18,%esp
	return ;
  802ac0:	90                   	nop
}
  802ac1:	c9                   	leave  
  802ac2:	c3                   	ret    

00802ac3 <sys_rcr2>:
uint32 sys_rcr2()
{
  802ac3:	55                   	push   %ebp
  802ac4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802ac6:	6a 00                	push   $0x0
  802ac8:	6a 00                	push   $0x0
  802aca:	6a 00                	push   $0x0
  802acc:	6a 00                	push   $0x0
  802ace:	6a 00                	push   $0x0
  802ad0:	6a 25                	push   $0x25
  802ad2:	e8 82 fb ff ff       	call   802659 <syscall>
  802ad7:	83 c4 18             	add    $0x18,%esp
}
  802ada:	c9                   	leave  
  802adb:	c3                   	ret    

00802adc <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802adc:	55                   	push   %ebp
  802add:	89 e5                	mov    %esp,%ebp
  802adf:	83 ec 04             	sub    $0x4,%esp
  802ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  802ae5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802ae8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802aec:	6a 00                	push   $0x0
  802aee:	6a 00                	push   $0x0
  802af0:	6a 00                	push   $0x0
  802af2:	6a 00                	push   $0x0
  802af4:	50                   	push   %eax
  802af5:	6a 26                	push   $0x26
  802af7:	e8 5d fb ff ff       	call   802659 <syscall>
  802afc:	83 c4 18             	add    $0x18,%esp
	return ;
  802aff:	90                   	nop
}
  802b00:	c9                   	leave  
  802b01:	c3                   	ret    

00802b02 <rsttst>:
void rsttst()
{
  802b02:	55                   	push   %ebp
  802b03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802b05:	6a 00                	push   $0x0
  802b07:	6a 00                	push   $0x0
  802b09:	6a 00                	push   $0x0
  802b0b:	6a 00                	push   $0x0
  802b0d:	6a 00                	push   $0x0
  802b0f:	6a 28                	push   $0x28
  802b11:	e8 43 fb ff ff       	call   802659 <syscall>
  802b16:	83 c4 18             	add    $0x18,%esp
	return ;
  802b19:	90                   	nop
}
  802b1a:	c9                   	leave  
  802b1b:	c3                   	ret    

00802b1c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802b1c:	55                   	push   %ebp
  802b1d:	89 e5                	mov    %esp,%ebp
  802b1f:	83 ec 04             	sub    $0x4,%esp
  802b22:	8b 45 14             	mov    0x14(%ebp),%eax
  802b25:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802b28:	8b 55 18             	mov    0x18(%ebp),%edx
  802b2b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802b2f:	52                   	push   %edx
  802b30:	50                   	push   %eax
  802b31:	ff 75 10             	pushl  0x10(%ebp)
  802b34:	ff 75 0c             	pushl  0xc(%ebp)
  802b37:	ff 75 08             	pushl  0x8(%ebp)
  802b3a:	6a 27                	push   $0x27
  802b3c:	e8 18 fb ff ff       	call   802659 <syscall>
  802b41:	83 c4 18             	add    $0x18,%esp
	return ;
  802b44:	90                   	nop
}
  802b45:	c9                   	leave  
  802b46:	c3                   	ret    

00802b47 <chktst>:
void chktst(uint32 n)
{
  802b47:	55                   	push   %ebp
  802b48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802b4a:	6a 00                	push   $0x0
  802b4c:	6a 00                	push   $0x0
  802b4e:	6a 00                	push   $0x0
  802b50:	6a 00                	push   $0x0
  802b52:	ff 75 08             	pushl  0x8(%ebp)
  802b55:	6a 29                	push   $0x29
  802b57:	e8 fd fa ff ff       	call   802659 <syscall>
  802b5c:	83 c4 18             	add    $0x18,%esp
	return ;
  802b5f:	90                   	nop
}
  802b60:	c9                   	leave  
  802b61:	c3                   	ret    

00802b62 <inctst>:

void inctst()
{
  802b62:	55                   	push   %ebp
  802b63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802b65:	6a 00                	push   $0x0
  802b67:	6a 00                	push   $0x0
  802b69:	6a 00                	push   $0x0
  802b6b:	6a 00                	push   $0x0
  802b6d:	6a 00                	push   $0x0
  802b6f:	6a 2a                	push   $0x2a
  802b71:	e8 e3 fa ff ff       	call   802659 <syscall>
  802b76:	83 c4 18             	add    $0x18,%esp
	return ;
  802b79:	90                   	nop
}
  802b7a:	c9                   	leave  
  802b7b:	c3                   	ret    

00802b7c <gettst>:
uint32 gettst()
{
  802b7c:	55                   	push   %ebp
  802b7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802b7f:	6a 00                	push   $0x0
  802b81:	6a 00                	push   $0x0
  802b83:	6a 00                	push   $0x0
  802b85:	6a 00                	push   $0x0
  802b87:	6a 00                	push   $0x0
  802b89:	6a 2b                	push   $0x2b
  802b8b:	e8 c9 fa ff ff       	call   802659 <syscall>
  802b90:	83 c4 18             	add    $0x18,%esp
}
  802b93:	c9                   	leave  
  802b94:	c3                   	ret    

00802b95 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802b95:	55                   	push   %ebp
  802b96:	89 e5                	mov    %esp,%ebp
  802b98:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b9b:	6a 00                	push   $0x0
  802b9d:	6a 00                	push   $0x0
  802b9f:	6a 00                	push   $0x0
  802ba1:	6a 00                	push   $0x0
  802ba3:	6a 00                	push   $0x0
  802ba5:	6a 2c                	push   $0x2c
  802ba7:	e8 ad fa ff ff       	call   802659 <syscall>
  802bac:	83 c4 18             	add    $0x18,%esp
  802baf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802bb2:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802bb6:	75 07                	jne    802bbf <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802bb8:	b8 01 00 00 00       	mov    $0x1,%eax
  802bbd:	eb 05                	jmp    802bc4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802bbf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bc4:	c9                   	leave  
  802bc5:	c3                   	ret    

00802bc6 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802bc6:	55                   	push   %ebp
  802bc7:	89 e5                	mov    %esp,%ebp
  802bc9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802bcc:	6a 00                	push   $0x0
  802bce:	6a 00                	push   $0x0
  802bd0:	6a 00                	push   $0x0
  802bd2:	6a 00                	push   $0x0
  802bd4:	6a 00                	push   $0x0
  802bd6:	6a 2c                	push   $0x2c
  802bd8:	e8 7c fa ff ff       	call   802659 <syscall>
  802bdd:	83 c4 18             	add    $0x18,%esp
  802be0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802be3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802be7:	75 07                	jne    802bf0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802be9:	b8 01 00 00 00       	mov    $0x1,%eax
  802bee:	eb 05                	jmp    802bf5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802bf0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bf5:	c9                   	leave  
  802bf6:	c3                   	ret    

00802bf7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802bf7:	55                   	push   %ebp
  802bf8:	89 e5                	mov    %esp,%ebp
  802bfa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802bfd:	6a 00                	push   $0x0
  802bff:	6a 00                	push   $0x0
  802c01:	6a 00                	push   $0x0
  802c03:	6a 00                	push   $0x0
  802c05:	6a 00                	push   $0x0
  802c07:	6a 2c                	push   $0x2c
  802c09:	e8 4b fa ff ff       	call   802659 <syscall>
  802c0e:	83 c4 18             	add    $0x18,%esp
  802c11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802c14:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802c18:	75 07                	jne    802c21 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802c1a:	b8 01 00 00 00       	mov    $0x1,%eax
  802c1f:	eb 05                	jmp    802c26 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802c21:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c26:	c9                   	leave  
  802c27:	c3                   	ret    

00802c28 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802c28:	55                   	push   %ebp
  802c29:	89 e5                	mov    %esp,%ebp
  802c2b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802c2e:	6a 00                	push   $0x0
  802c30:	6a 00                	push   $0x0
  802c32:	6a 00                	push   $0x0
  802c34:	6a 00                	push   $0x0
  802c36:	6a 00                	push   $0x0
  802c38:	6a 2c                	push   $0x2c
  802c3a:	e8 1a fa ff ff       	call   802659 <syscall>
  802c3f:	83 c4 18             	add    $0x18,%esp
  802c42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802c45:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802c49:	75 07                	jne    802c52 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802c4b:	b8 01 00 00 00       	mov    $0x1,%eax
  802c50:	eb 05                	jmp    802c57 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802c52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c57:	c9                   	leave  
  802c58:	c3                   	ret    

00802c59 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802c59:	55                   	push   %ebp
  802c5a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802c5c:	6a 00                	push   $0x0
  802c5e:	6a 00                	push   $0x0
  802c60:	6a 00                	push   $0x0
  802c62:	6a 00                	push   $0x0
  802c64:	ff 75 08             	pushl  0x8(%ebp)
  802c67:	6a 2d                	push   $0x2d
  802c69:	e8 eb f9 ff ff       	call   802659 <syscall>
  802c6e:	83 c4 18             	add    $0x18,%esp
	return ;
  802c71:	90                   	nop
}
  802c72:	c9                   	leave  
  802c73:	c3                   	ret    

00802c74 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802c74:	55                   	push   %ebp
  802c75:	89 e5                	mov    %esp,%ebp
  802c77:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802c78:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c7b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c81:	8b 45 08             	mov    0x8(%ebp),%eax
  802c84:	6a 00                	push   $0x0
  802c86:	53                   	push   %ebx
  802c87:	51                   	push   %ecx
  802c88:	52                   	push   %edx
  802c89:	50                   	push   %eax
  802c8a:	6a 2e                	push   $0x2e
  802c8c:	e8 c8 f9 ff ff       	call   802659 <syscall>
  802c91:	83 c4 18             	add    $0x18,%esp
}
  802c94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802c97:	c9                   	leave  
  802c98:	c3                   	ret    

00802c99 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802c99:	55                   	push   %ebp
  802c9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802c9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  802ca2:	6a 00                	push   $0x0
  802ca4:	6a 00                	push   $0x0
  802ca6:	6a 00                	push   $0x0
  802ca8:	52                   	push   %edx
  802ca9:	50                   	push   %eax
  802caa:	6a 2f                	push   $0x2f
  802cac:	e8 a8 f9 ff ff       	call   802659 <syscall>
  802cb1:	83 c4 18             	add    $0x18,%esp
}
  802cb4:	c9                   	leave  
  802cb5:	c3                   	ret    
  802cb6:	66 90                	xchg   %ax,%ax

00802cb8 <__udivdi3>:
  802cb8:	55                   	push   %ebp
  802cb9:	57                   	push   %edi
  802cba:	56                   	push   %esi
  802cbb:	53                   	push   %ebx
  802cbc:	83 ec 1c             	sub    $0x1c,%esp
  802cbf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802cc3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802cc7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802ccb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802ccf:	89 ca                	mov    %ecx,%edx
  802cd1:	89 f8                	mov    %edi,%eax
  802cd3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802cd7:	85 f6                	test   %esi,%esi
  802cd9:	75 2d                	jne    802d08 <__udivdi3+0x50>
  802cdb:	39 cf                	cmp    %ecx,%edi
  802cdd:	77 65                	ja     802d44 <__udivdi3+0x8c>
  802cdf:	89 fd                	mov    %edi,%ebp
  802ce1:	85 ff                	test   %edi,%edi
  802ce3:	75 0b                	jne    802cf0 <__udivdi3+0x38>
  802ce5:	b8 01 00 00 00       	mov    $0x1,%eax
  802cea:	31 d2                	xor    %edx,%edx
  802cec:	f7 f7                	div    %edi
  802cee:	89 c5                	mov    %eax,%ebp
  802cf0:	31 d2                	xor    %edx,%edx
  802cf2:	89 c8                	mov    %ecx,%eax
  802cf4:	f7 f5                	div    %ebp
  802cf6:	89 c1                	mov    %eax,%ecx
  802cf8:	89 d8                	mov    %ebx,%eax
  802cfa:	f7 f5                	div    %ebp
  802cfc:	89 cf                	mov    %ecx,%edi
  802cfe:	89 fa                	mov    %edi,%edx
  802d00:	83 c4 1c             	add    $0x1c,%esp
  802d03:	5b                   	pop    %ebx
  802d04:	5e                   	pop    %esi
  802d05:	5f                   	pop    %edi
  802d06:	5d                   	pop    %ebp
  802d07:	c3                   	ret    
  802d08:	39 ce                	cmp    %ecx,%esi
  802d0a:	77 28                	ja     802d34 <__udivdi3+0x7c>
  802d0c:	0f bd fe             	bsr    %esi,%edi
  802d0f:	83 f7 1f             	xor    $0x1f,%edi
  802d12:	75 40                	jne    802d54 <__udivdi3+0x9c>
  802d14:	39 ce                	cmp    %ecx,%esi
  802d16:	72 0a                	jb     802d22 <__udivdi3+0x6a>
  802d18:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802d1c:	0f 87 9e 00 00 00    	ja     802dc0 <__udivdi3+0x108>
  802d22:	b8 01 00 00 00       	mov    $0x1,%eax
  802d27:	89 fa                	mov    %edi,%edx
  802d29:	83 c4 1c             	add    $0x1c,%esp
  802d2c:	5b                   	pop    %ebx
  802d2d:	5e                   	pop    %esi
  802d2e:	5f                   	pop    %edi
  802d2f:	5d                   	pop    %ebp
  802d30:	c3                   	ret    
  802d31:	8d 76 00             	lea    0x0(%esi),%esi
  802d34:	31 ff                	xor    %edi,%edi
  802d36:	31 c0                	xor    %eax,%eax
  802d38:	89 fa                	mov    %edi,%edx
  802d3a:	83 c4 1c             	add    $0x1c,%esp
  802d3d:	5b                   	pop    %ebx
  802d3e:	5e                   	pop    %esi
  802d3f:	5f                   	pop    %edi
  802d40:	5d                   	pop    %ebp
  802d41:	c3                   	ret    
  802d42:	66 90                	xchg   %ax,%ax
  802d44:	89 d8                	mov    %ebx,%eax
  802d46:	f7 f7                	div    %edi
  802d48:	31 ff                	xor    %edi,%edi
  802d4a:	89 fa                	mov    %edi,%edx
  802d4c:	83 c4 1c             	add    $0x1c,%esp
  802d4f:	5b                   	pop    %ebx
  802d50:	5e                   	pop    %esi
  802d51:	5f                   	pop    %edi
  802d52:	5d                   	pop    %ebp
  802d53:	c3                   	ret    
  802d54:	bd 20 00 00 00       	mov    $0x20,%ebp
  802d59:	89 eb                	mov    %ebp,%ebx
  802d5b:	29 fb                	sub    %edi,%ebx
  802d5d:	89 f9                	mov    %edi,%ecx
  802d5f:	d3 e6                	shl    %cl,%esi
  802d61:	89 c5                	mov    %eax,%ebp
  802d63:	88 d9                	mov    %bl,%cl
  802d65:	d3 ed                	shr    %cl,%ebp
  802d67:	89 e9                	mov    %ebp,%ecx
  802d69:	09 f1                	or     %esi,%ecx
  802d6b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802d6f:	89 f9                	mov    %edi,%ecx
  802d71:	d3 e0                	shl    %cl,%eax
  802d73:	89 c5                	mov    %eax,%ebp
  802d75:	89 d6                	mov    %edx,%esi
  802d77:	88 d9                	mov    %bl,%cl
  802d79:	d3 ee                	shr    %cl,%esi
  802d7b:	89 f9                	mov    %edi,%ecx
  802d7d:	d3 e2                	shl    %cl,%edx
  802d7f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802d83:	88 d9                	mov    %bl,%cl
  802d85:	d3 e8                	shr    %cl,%eax
  802d87:	09 c2                	or     %eax,%edx
  802d89:	89 d0                	mov    %edx,%eax
  802d8b:	89 f2                	mov    %esi,%edx
  802d8d:	f7 74 24 0c          	divl   0xc(%esp)
  802d91:	89 d6                	mov    %edx,%esi
  802d93:	89 c3                	mov    %eax,%ebx
  802d95:	f7 e5                	mul    %ebp
  802d97:	39 d6                	cmp    %edx,%esi
  802d99:	72 19                	jb     802db4 <__udivdi3+0xfc>
  802d9b:	74 0b                	je     802da8 <__udivdi3+0xf0>
  802d9d:	89 d8                	mov    %ebx,%eax
  802d9f:	31 ff                	xor    %edi,%edi
  802da1:	e9 58 ff ff ff       	jmp    802cfe <__udivdi3+0x46>
  802da6:	66 90                	xchg   %ax,%ax
  802da8:	8b 54 24 08          	mov    0x8(%esp),%edx
  802dac:	89 f9                	mov    %edi,%ecx
  802dae:	d3 e2                	shl    %cl,%edx
  802db0:	39 c2                	cmp    %eax,%edx
  802db2:	73 e9                	jae    802d9d <__udivdi3+0xe5>
  802db4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802db7:	31 ff                	xor    %edi,%edi
  802db9:	e9 40 ff ff ff       	jmp    802cfe <__udivdi3+0x46>
  802dbe:	66 90                	xchg   %ax,%ax
  802dc0:	31 c0                	xor    %eax,%eax
  802dc2:	e9 37 ff ff ff       	jmp    802cfe <__udivdi3+0x46>
  802dc7:	90                   	nop

00802dc8 <__umoddi3>:
  802dc8:	55                   	push   %ebp
  802dc9:	57                   	push   %edi
  802dca:	56                   	push   %esi
  802dcb:	53                   	push   %ebx
  802dcc:	83 ec 1c             	sub    $0x1c,%esp
  802dcf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802dd3:	8b 74 24 34          	mov    0x34(%esp),%esi
  802dd7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802ddb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802ddf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802de3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802de7:	89 f3                	mov    %esi,%ebx
  802de9:	89 fa                	mov    %edi,%edx
  802deb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802def:	89 34 24             	mov    %esi,(%esp)
  802df2:	85 c0                	test   %eax,%eax
  802df4:	75 1a                	jne    802e10 <__umoddi3+0x48>
  802df6:	39 f7                	cmp    %esi,%edi
  802df8:	0f 86 a2 00 00 00    	jbe    802ea0 <__umoddi3+0xd8>
  802dfe:	89 c8                	mov    %ecx,%eax
  802e00:	89 f2                	mov    %esi,%edx
  802e02:	f7 f7                	div    %edi
  802e04:	89 d0                	mov    %edx,%eax
  802e06:	31 d2                	xor    %edx,%edx
  802e08:	83 c4 1c             	add    $0x1c,%esp
  802e0b:	5b                   	pop    %ebx
  802e0c:	5e                   	pop    %esi
  802e0d:	5f                   	pop    %edi
  802e0e:	5d                   	pop    %ebp
  802e0f:	c3                   	ret    
  802e10:	39 f0                	cmp    %esi,%eax
  802e12:	0f 87 ac 00 00 00    	ja     802ec4 <__umoddi3+0xfc>
  802e18:	0f bd e8             	bsr    %eax,%ebp
  802e1b:	83 f5 1f             	xor    $0x1f,%ebp
  802e1e:	0f 84 ac 00 00 00    	je     802ed0 <__umoddi3+0x108>
  802e24:	bf 20 00 00 00       	mov    $0x20,%edi
  802e29:	29 ef                	sub    %ebp,%edi
  802e2b:	89 fe                	mov    %edi,%esi
  802e2d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802e31:	89 e9                	mov    %ebp,%ecx
  802e33:	d3 e0                	shl    %cl,%eax
  802e35:	89 d7                	mov    %edx,%edi
  802e37:	89 f1                	mov    %esi,%ecx
  802e39:	d3 ef                	shr    %cl,%edi
  802e3b:	09 c7                	or     %eax,%edi
  802e3d:	89 e9                	mov    %ebp,%ecx
  802e3f:	d3 e2                	shl    %cl,%edx
  802e41:	89 14 24             	mov    %edx,(%esp)
  802e44:	89 d8                	mov    %ebx,%eax
  802e46:	d3 e0                	shl    %cl,%eax
  802e48:	89 c2                	mov    %eax,%edx
  802e4a:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e4e:	d3 e0                	shl    %cl,%eax
  802e50:	89 44 24 04          	mov    %eax,0x4(%esp)
  802e54:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e58:	89 f1                	mov    %esi,%ecx
  802e5a:	d3 e8                	shr    %cl,%eax
  802e5c:	09 d0                	or     %edx,%eax
  802e5e:	d3 eb                	shr    %cl,%ebx
  802e60:	89 da                	mov    %ebx,%edx
  802e62:	f7 f7                	div    %edi
  802e64:	89 d3                	mov    %edx,%ebx
  802e66:	f7 24 24             	mull   (%esp)
  802e69:	89 c6                	mov    %eax,%esi
  802e6b:	89 d1                	mov    %edx,%ecx
  802e6d:	39 d3                	cmp    %edx,%ebx
  802e6f:	0f 82 87 00 00 00    	jb     802efc <__umoddi3+0x134>
  802e75:	0f 84 91 00 00 00    	je     802f0c <__umoddi3+0x144>
  802e7b:	8b 54 24 04          	mov    0x4(%esp),%edx
  802e7f:	29 f2                	sub    %esi,%edx
  802e81:	19 cb                	sbb    %ecx,%ebx
  802e83:	89 d8                	mov    %ebx,%eax
  802e85:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802e89:	d3 e0                	shl    %cl,%eax
  802e8b:	89 e9                	mov    %ebp,%ecx
  802e8d:	d3 ea                	shr    %cl,%edx
  802e8f:	09 d0                	or     %edx,%eax
  802e91:	89 e9                	mov    %ebp,%ecx
  802e93:	d3 eb                	shr    %cl,%ebx
  802e95:	89 da                	mov    %ebx,%edx
  802e97:	83 c4 1c             	add    $0x1c,%esp
  802e9a:	5b                   	pop    %ebx
  802e9b:	5e                   	pop    %esi
  802e9c:	5f                   	pop    %edi
  802e9d:	5d                   	pop    %ebp
  802e9e:	c3                   	ret    
  802e9f:	90                   	nop
  802ea0:	89 fd                	mov    %edi,%ebp
  802ea2:	85 ff                	test   %edi,%edi
  802ea4:	75 0b                	jne    802eb1 <__umoddi3+0xe9>
  802ea6:	b8 01 00 00 00       	mov    $0x1,%eax
  802eab:	31 d2                	xor    %edx,%edx
  802ead:	f7 f7                	div    %edi
  802eaf:	89 c5                	mov    %eax,%ebp
  802eb1:	89 f0                	mov    %esi,%eax
  802eb3:	31 d2                	xor    %edx,%edx
  802eb5:	f7 f5                	div    %ebp
  802eb7:	89 c8                	mov    %ecx,%eax
  802eb9:	f7 f5                	div    %ebp
  802ebb:	89 d0                	mov    %edx,%eax
  802ebd:	e9 44 ff ff ff       	jmp    802e06 <__umoddi3+0x3e>
  802ec2:	66 90                	xchg   %ax,%ax
  802ec4:	89 c8                	mov    %ecx,%eax
  802ec6:	89 f2                	mov    %esi,%edx
  802ec8:	83 c4 1c             	add    $0x1c,%esp
  802ecb:	5b                   	pop    %ebx
  802ecc:	5e                   	pop    %esi
  802ecd:	5f                   	pop    %edi
  802ece:	5d                   	pop    %ebp
  802ecf:	c3                   	ret    
  802ed0:	3b 04 24             	cmp    (%esp),%eax
  802ed3:	72 06                	jb     802edb <__umoddi3+0x113>
  802ed5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802ed9:	77 0f                	ja     802eea <__umoddi3+0x122>
  802edb:	89 f2                	mov    %esi,%edx
  802edd:	29 f9                	sub    %edi,%ecx
  802edf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802ee3:	89 14 24             	mov    %edx,(%esp)
  802ee6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802eea:	8b 44 24 04          	mov    0x4(%esp),%eax
  802eee:	8b 14 24             	mov    (%esp),%edx
  802ef1:	83 c4 1c             	add    $0x1c,%esp
  802ef4:	5b                   	pop    %ebx
  802ef5:	5e                   	pop    %esi
  802ef6:	5f                   	pop    %edi
  802ef7:	5d                   	pop    %ebp
  802ef8:	c3                   	ret    
  802ef9:	8d 76 00             	lea    0x0(%esi),%esi
  802efc:	2b 04 24             	sub    (%esp),%eax
  802eff:	19 fa                	sbb    %edi,%edx
  802f01:	89 d1                	mov    %edx,%ecx
  802f03:	89 c6                	mov    %eax,%esi
  802f05:	e9 71 ff ff ff       	jmp    802e7b <__umoddi3+0xb3>
  802f0a:	66 90                	xchg   %ax,%ax
  802f0c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802f10:	72 ea                	jb     802efc <__umoddi3+0x134>
  802f12:	89 d9                	mov    %ebx,%ecx
  802f14:	e9 62 ff ff ff       	jmp    802e7b <__umoddi3+0xb3>
