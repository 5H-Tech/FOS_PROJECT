
obj/user/tst_malloc_1:     file format elf32-i386


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
  800031:	e8 99 05 00 00       	call   8005cf <libmain>
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
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800040:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800044:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004b:	eb 23                	jmp    800070 <_main+0x38>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004d:	a1 20 30 80 00       	mov    0x803020,%eax
  800052:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800058:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005b:	c1 e2 04             	shl    $0x4,%edx
  80005e:	01 d0                	add    %edx,%eax
  800060:	8a 40 04             	mov    0x4(%eax),%al
  800063:	84 c0                	test   %al,%al
  800065:	74 06                	je     80006d <_main+0x35>
			{
				fullWS = 0;
  800067:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006b:	eb 12                	jmp    80007f <_main+0x47>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006d:	ff 45 f0             	incl   -0x10(%ebp)
  800070:	a1 20 30 80 00       	mov    0x803020,%eax
  800075:	8b 50 74             	mov    0x74(%eax),%edx
  800078:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007b:	39 c2                	cmp    %eax,%edx
  80007d:	77 ce                	ja     80004d <_main+0x15>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007f:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800083:	74 14                	je     800099 <_main+0x61>
  800085:	83 ec 04             	sub    $0x4,%esp
  800088:	68 80 23 80 00       	push   $0x802380
  80008d:	6a 14                	push   $0x14
  80008f:	68 9c 23 80 00       	push   $0x80239c
  800094:	e8 7b 06 00 00       	call   800714 <_panic>
	}


	int Mega = 1024*1024;
  800099:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a0:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	void* ptr_allocations[20] = {0};
  8000a7:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000aa:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000af:	b8 00 00 00 00       	mov    $0x0,%eax
  8000b4:	89 d7                	mov    %edx,%edi
  8000b6:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000b8:	e8 6a 1b 00 00       	call   801c27 <sys_calculate_free_frames>
  8000bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000c0:	e8 e5 1b 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8000c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000cb:	01 c0                	add    %eax,%eax
  8000cd:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	50                   	push   %eax
  8000d4:	e8 67 16 00 00       	call   801740 <malloc>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8000df:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e2:	85 c0                	test   %eax,%eax
  8000e4:	79 0a                	jns    8000f0 <_main+0xb8>
  8000e6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e9:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000ee:	76 14                	jbe    800104 <_main+0xcc>
  8000f0:	83 ec 04             	sub    $0x4,%esp
  8000f3:	68 b0 23 80 00       	push   $0x8023b0
  8000f8:	6a 20                	push   $0x20
  8000fa:	68 9c 23 80 00       	push   $0x80239c
  8000ff:	e8 10 06 00 00       	call   800714 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800104:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800107:	e8 1b 1b 00 00       	call   801c27 <sys_calculate_free_frames>
  80010c:	29 c3                	sub    %eax,%ebx
  80010e:	89 d8                	mov    %ebx,%eax
  800110:	83 f8 01             	cmp    $0x1,%eax
  800113:	74 14                	je     800129 <_main+0xf1>
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	68 e0 23 80 00       	push   $0x8023e0
  80011d:	6a 22                	push   $0x22
  80011f:	68 9c 23 80 00       	push   $0x80239c
  800124:	e8 eb 05 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800129:	e8 7c 1b 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  80012e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800131:	3d 00 02 00 00       	cmp    $0x200,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 4c 24 80 00       	push   $0x80244c
  800140:	6a 23                	push   $0x23
  800142:	68 9c 23 80 00       	push   $0x80239c
  800147:	e8 c8 05 00 00       	call   800714 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80014c:	e8 d6 1a 00 00       	call   801c27 <sys_calculate_free_frames>
  800151:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800154:	e8 51 1b 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  800159:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80015c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80015f:	01 c0                	add    %eax,%eax
  800161:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800164:	83 ec 0c             	sub    $0xc,%esp
  800167:	50                   	push   %eax
  800168:	e8 d3 15 00 00       	call   801740 <malloc>
  80016d:	83 c4 10             	add    $0x10,%esp
  800170:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START + 2*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800173:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800176:	89 c2                	mov    %eax,%edx
  800178:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80017b:	01 c0                	add    %eax,%eax
  80017d:	05 00 00 00 80       	add    $0x80000000,%eax
  800182:	39 c2                	cmp    %eax,%edx
  800184:	72 13                	jb     800199 <_main+0x161>
  800186:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800189:	89 c2                	mov    %eax,%edx
  80018b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018e:	01 c0                	add    %eax,%eax
  800190:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800195:	39 c2                	cmp    %eax,%edx
  800197:	76 14                	jbe    8001ad <_main+0x175>
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	68 b0 23 80 00       	push   $0x8023b0
  8001a1:	6a 28                	push   $0x28
  8001a3:	68 9c 23 80 00       	push   $0x80239c
  8001a8:	e8 67 05 00 00       	call   800714 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001ad:	e8 75 1a 00 00       	call   801c27 <sys_calculate_free_frames>
  8001b2:	89 c2                	mov    %eax,%edx
  8001b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b7:	39 c2                	cmp    %eax,%edx
  8001b9:	74 14                	je     8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 e0 23 80 00       	push   $0x8023e0
  8001c3:	6a 2a                	push   $0x2a
  8001c5:	68 9c 23 80 00       	push   $0x80239c
  8001ca:	e8 45 05 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001cf:	e8 d6 1a 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8001d4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001dc:	74 14                	je     8001f2 <_main+0x1ba>
  8001de:	83 ec 04             	sub    $0x4,%esp
  8001e1:	68 4c 24 80 00       	push   $0x80244c
  8001e6:	6a 2b                	push   $0x2b
  8001e8:	68 9c 23 80 00       	push   $0x80239c
  8001ed:	e8 22 05 00 00       	call   800714 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8001f2:	e8 30 1a 00 00       	call   801c27 <sys_calculate_free_frames>
  8001f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001fa:	e8 ab 1a 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8001ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  800202:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800205:	89 c2                	mov    %eax,%edx
  800207:	01 d2                	add    %edx,%edx
  800209:	01 d0                	add    %edx,%eax
  80020b:	83 ec 0c             	sub    $0xc,%esp
  80020e:	50                   	push   %eax
  80020f:	e8 2c 15 00 00       	call   801740 <malloc>
  800214:	83 c4 10             	add    $0x10,%esp
  800217:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80021a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80021d:	89 c2                	mov    %eax,%edx
  80021f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800222:	c1 e0 02             	shl    $0x2,%eax
  800225:	05 00 00 00 80       	add    $0x80000000,%eax
  80022a:	39 c2                	cmp    %eax,%edx
  80022c:	72 14                	jb     800242 <_main+0x20a>
  80022e:	8b 45 98             	mov    -0x68(%ebp),%eax
  800231:	89 c2                	mov    %eax,%edx
  800233:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800236:	c1 e0 02             	shl    $0x2,%eax
  800239:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80023e:	39 c2                	cmp    %eax,%edx
  800240:	76 14                	jbe    800256 <_main+0x21e>
  800242:	83 ec 04             	sub    $0x4,%esp
  800245:	68 b0 23 80 00       	push   $0x8023b0
  80024a:	6a 30                	push   $0x30
  80024c:	68 9c 23 80 00       	push   $0x80239c
  800251:	e8 be 04 00 00       	call   800714 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800256:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800259:	e8 c9 19 00 00       	call   801c27 <sys_calculate_free_frames>
  80025e:	29 c3                	sub    %eax,%ebx
  800260:	89 d8                	mov    %ebx,%eax
  800262:	83 f8 01             	cmp    $0x1,%eax
  800265:	74 14                	je     80027b <_main+0x243>
  800267:	83 ec 04             	sub    $0x4,%esp
  80026a:	68 e0 23 80 00       	push   $0x8023e0
  80026f:	6a 32                	push   $0x32
  800271:	68 9c 23 80 00       	push   $0x80239c
  800276:	e8 99 04 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80027b:	e8 2a 1a 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  800280:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800283:	83 f8 01             	cmp    $0x1,%eax
  800286:	74 14                	je     80029c <_main+0x264>
  800288:	83 ec 04             	sub    $0x4,%esp
  80028b:	68 4c 24 80 00       	push   $0x80244c
  800290:	6a 33                	push   $0x33
  800292:	68 9c 23 80 00       	push   $0x80239c
  800297:	e8 78 04 00 00       	call   800714 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80029c:	e8 86 19 00 00       	call   801c27 <sys_calculate_free_frames>
  8002a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002a4:	e8 01 1a 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8002a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  8002ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002af:	89 c2                	mov    %eax,%edx
  8002b1:	01 d2                	add    %edx,%edx
  8002b3:	01 d0                	add    %edx,%eax
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	50                   	push   %eax
  8002b9:	e8 82 14 00 00       	call   801740 <malloc>
  8002be:	83 c4 10             	add    $0x10,%esp
  8002c1:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8002c4:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002c7:	89 c2                	mov    %eax,%edx
  8002c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002cc:	c1 e0 02             	shl    $0x2,%eax
  8002cf:	89 c1                	mov    %eax,%ecx
  8002d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d4:	c1 e0 02             	shl    $0x2,%eax
  8002d7:	01 c8                	add    %ecx,%eax
  8002d9:	05 00 00 00 80       	add    $0x80000000,%eax
  8002de:	39 c2                	cmp    %eax,%edx
  8002e0:	72 1e                	jb     800300 <_main+0x2c8>
  8002e2:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002e5:	89 c2                	mov    %eax,%edx
  8002e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002ea:	c1 e0 02             	shl    $0x2,%eax
  8002ed:	89 c1                	mov    %eax,%ecx
  8002ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002f2:	c1 e0 02             	shl    $0x2,%eax
  8002f5:	01 c8                	add    %ecx,%eax
  8002f7:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002fc:	39 c2                	cmp    %eax,%edx
  8002fe:	76 14                	jbe    800314 <_main+0x2dc>
  800300:	83 ec 04             	sub    $0x4,%esp
  800303:	68 b0 23 80 00       	push   $0x8023b0
  800308:	6a 38                	push   $0x38
  80030a:	68 9c 23 80 00       	push   $0x80239c
  80030f:	e8 00 04 00 00       	call   800714 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800314:	e8 0e 19 00 00       	call   801c27 <sys_calculate_free_frames>
  800319:	89 c2                	mov    %eax,%edx
  80031b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80031e:	39 c2                	cmp    %eax,%edx
  800320:	74 14                	je     800336 <_main+0x2fe>
  800322:	83 ec 04             	sub    $0x4,%esp
  800325:	68 e0 23 80 00       	push   $0x8023e0
  80032a:	6a 3a                	push   $0x3a
  80032c:	68 9c 23 80 00       	push   $0x80239c
  800331:	e8 de 03 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800336:	e8 6f 19 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  80033b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80033e:	83 f8 01             	cmp    $0x1,%eax
  800341:	74 14                	je     800357 <_main+0x31f>
  800343:	83 ec 04             	sub    $0x4,%esp
  800346:	68 4c 24 80 00       	push   $0x80244c
  80034b:	6a 3b                	push   $0x3b
  80034d:	68 9c 23 80 00       	push   $0x80239c
  800352:	e8 bd 03 00 00       	call   800714 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800357:	e8 cb 18 00 00       	call   801c27 <sys_calculate_free_frames>
  80035c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80035f:	e8 46 19 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  800364:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800367:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80036a:	89 d0                	mov    %edx,%eax
  80036c:	01 c0                	add    %eax,%eax
  80036e:	01 d0                	add    %edx,%eax
  800370:	01 c0                	add    %eax,%eax
  800372:	01 d0                	add    %edx,%eax
  800374:	83 ec 0c             	sub    $0xc,%esp
  800377:	50                   	push   %eax
  800378:	e8 c3 13 00 00       	call   801740 <malloc>
  80037d:	83 c4 10             	add    $0x10,%esp
  800380:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo) || (uint32) ptr_allocations[4] > (USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800383:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800386:	89 c2                	mov    %eax,%edx
  800388:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80038b:	c1 e0 02             	shl    $0x2,%eax
  80038e:	89 c1                	mov    %eax,%ecx
  800390:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800393:	c1 e0 03             	shl    $0x3,%eax
  800396:	01 c8                	add    %ecx,%eax
  800398:	05 00 00 00 80       	add    $0x80000000,%eax
  80039d:	39 c2                	cmp    %eax,%edx
  80039f:	72 1e                	jb     8003bf <_main+0x387>
  8003a1:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003a4:	89 c2                	mov    %eax,%edx
  8003a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003a9:	c1 e0 02             	shl    $0x2,%eax
  8003ac:	89 c1                	mov    %eax,%ecx
  8003ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003b1:	c1 e0 03             	shl    $0x3,%eax
  8003b4:	01 c8                	add    %ecx,%eax
  8003b6:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8003bb:	39 c2                	cmp    %eax,%edx
  8003bd:	76 14                	jbe    8003d3 <_main+0x39b>
  8003bf:	83 ec 04             	sub    $0x4,%esp
  8003c2:	68 b0 23 80 00       	push   $0x8023b0
  8003c7:	6a 40                	push   $0x40
  8003c9:	68 9c 23 80 00       	push   $0x80239c
  8003ce:	e8 41 03 00 00       	call   800714 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003d3:	e8 4f 18 00 00       	call   801c27 <sys_calculate_free_frames>
  8003d8:	89 c2                	mov    %eax,%edx
  8003da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003dd:	39 c2                	cmp    %eax,%edx
  8003df:	74 14                	je     8003f5 <_main+0x3bd>
  8003e1:	83 ec 04             	sub    $0x4,%esp
  8003e4:	68 e0 23 80 00       	push   $0x8023e0
  8003e9:	6a 42                	push   $0x42
  8003eb:	68 9c 23 80 00       	push   $0x80239c
  8003f0:	e8 1f 03 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8003f5:	e8 b0 18 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8003fa:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003fd:	83 f8 02             	cmp    $0x2,%eax
  800400:	74 14                	je     800416 <_main+0x3de>
  800402:	83 ec 04             	sub    $0x4,%esp
  800405:	68 4c 24 80 00       	push   $0x80244c
  80040a:	6a 43                	push   $0x43
  80040c:	68 9c 23 80 00       	push   $0x80239c
  800411:	e8 fe 02 00 00       	call   800714 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800416:	e8 0c 18 00 00       	call   801c27 <sys_calculate_free_frames>
  80041b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80041e:	e8 87 18 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  800423:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800426:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800429:	89 c2                	mov    %eax,%edx
  80042b:	01 d2                	add    %edx,%edx
  80042d:	01 d0                	add    %edx,%eax
  80042f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800432:	83 ec 0c             	sub    $0xc,%esp
  800435:	50                   	push   %eax
  800436:	e8 05 13 00 00       	call   801740 <malloc>
  80043b:	83 c4 10             	add    $0x10,%esp
  80043e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800441:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800444:	89 c2                	mov    %eax,%edx
  800446:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800449:	c1 e0 02             	shl    $0x2,%eax
  80044c:	89 c1                	mov    %eax,%ecx
  80044e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800451:	c1 e0 04             	shl    $0x4,%eax
  800454:	01 c8                	add    %ecx,%eax
  800456:	05 00 00 00 80       	add    $0x80000000,%eax
  80045b:	39 c2                	cmp    %eax,%edx
  80045d:	72 1e                	jb     80047d <_main+0x445>
  80045f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800462:	89 c2                	mov    %eax,%edx
  800464:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800467:	c1 e0 02             	shl    $0x2,%eax
  80046a:	89 c1                	mov    %eax,%ecx
  80046c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80046f:	c1 e0 04             	shl    $0x4,%eax
  800472:	01 c8                	add    %ecx,%eax
  800474:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800479:	39 c2                	cmp    %eax,%edx
  80047b:	76 14                	jbe    800491 <_main+0x459>
  80047d:	83 ec 04             	sub    $0x4,%esp
  800480:	68 b0 23 80 00       	push   $0x8023b0
  800485:	6a 48                	push   $0x48
  800487:	68 9c 23 80 00       	push   $0x80239c
  80048c:	e8 83 02 00 00       	call   800714 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800491:	e8 91 17 00 00       	call   801c27 <sys_calculate_free_frames>
  800496:	89 c2                	mov    %eax,%edx
  800498:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80049b:	39 c2                	cmp    %eax,%edx
  80049d:	74 14                	je     8004b3 <_main+0x47b>
  80049f:	83 ec 04             	sub    $0x4,%esp
  8004a2:	68 7a 24 80 00       	push   $0x80247a
  8004a7:	6a 49                	push   $0x49
  8004a9:	68 9c 23 80 00       	push   $0x80239c
  8004ae:	e8 61 02 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8004b3:	e8 f2 17 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8004b8:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004bb:	89 c2                	mov    %eax,%edx
  8004bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004c0:	89 c1                	mov    %eax,%ecx
  8004c2:	01 c9                	add    %ecx,%ecx
  8004c4:	01 c8                	add    %ecx,%eax
  8004c6:	85 c0                	test   %eax,%eax
  8004c8:	79 05                	jns    8004cf <_main+0x497>
  8004ca:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004cf:	c1 f8 0c             	sar    $0xc,%eax
  8004d2:	39 c2                	cmp    %eax,%edx
  8004d4:	74 14                	je     8004ea <_main+0x4b2>
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	68 4c 24 80 00       	push   $0x80244c
  8004de:	6a 4a                	push   $0x4a
  8004e0:	68 9c 23 80 00       	push   $0x80239c
  8004e5:	e8 2a 02 00 00       	call   800714 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004ea:	e8 38 17 00 00       	call   801c27 <sys_calculate_free_frames>
  8004ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004f2:	e8 b3 17 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  8004f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  8004fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004fd:	01 c0                	add    %eax,%eax
  8004ff:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800502:	83 ec 0c             	sub    $0xc,%esp
  800505:	50                   	push   %eax
  800506:	e8 35 12 00 00       	call   801740 <malloc>
  80050b:	83 c4 10             	add    $0x10,%esp
  80050e:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800511:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800514:	89 c1                	mov    %eax,%ecx
  800516:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800519:	89 d0                	mov    %edx,%eax
  80051b:	01 c0                	add    %eax,%eax
  80051d:	01 d0                	add    %edx,%eax
  80051f:	01 c0                	add    %eax,%eax
  800521:	01 d0                	add    %edx,%eax
  800523:	89 c2                	mov    %eax,%edx
  800525:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800528:	c1 e0 04             	shl    $0x4,%eax
  80052b:	01 d0                	add    %edx,%eax
  80052d:	05 00 00 00 80       	add    $0x80000000,%eax
  800532:	39 c1                	cmp    %eax,%ecx
  800534:	72 25                	jb     80055b <_main+0x523>
  800536:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800539:	89 c1                	mov    %eax,%ecx
  80053b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80053e:	89 d0                	mov    %edx,%eax
  800540:	01 c0                	add    %eax,%eax
  800542:	01 d0                	add    %edx,%eax
  800544:	01 c0                	add    %eax,%eax
  800546:	01 d0                	add    %edx,%eax
  800548:	89 c2                	mov    %eax,%edx
  80054a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80054d:	c1 e0 04             	shl    $0x4,%eax
  800550:	01 d0                	add    %edx,%eax
  800552:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800557:	39 c1                	cmp    %eax,%ecx
  800559:	76 14                	jbe    80056f <_main+0x537>
  80055b:	83 ec 04             	sub    $0x4,%esp
  80055e:	68 b0 23 80 00       	push   $0x8023b0
  800563:	6a 4f                	push   $0x4f
  800565:	68 9c 23 80 00       	push   $0x80239c
  80056a:	e8 a5 01 00 00       	call   800714 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  80056f:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800572:	e8 b0 16 00 00       	call   801c27 <sys_calculate_free_frames>
  800577:	29 c3                	sub    %eax,%ebx
  800579:	89 d8                	mov    %ebx,%eax
  80057b:	83 f8 01             	cmp    $0x1,%eax
  80057e:	74 14                	je     800594 <_main+0x55c>
  800580:	83 ec 04             	sub    $0x4,%esp
  800583:	68 7a 24 80 00       	push   $0x80247a
  800588:	6a 50                	push   $0x50
  80058a:	68 9c 23 80 00       	push   $0x80239c
  80058f:	e8 80 01 00 00       	call   800714 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800594:	e8 11 17 00 00       	call   801caa <sys_pf_calculate_allocated_pages>
  800599:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80059c:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005a1:	74 14                	je     8005b7 <_main+0x57f>
  8005a3:	83 ec 04             	sub    $0x4,%esp
  8005a6:	68 4c 24 80 00       	push   $0x80244c
  8005ab:	6a 51                	push   $0x51
  8005ad:	68 9c 23 80 00       	push   $0x80239c
  8005b2:	e8 5d 01 00 00       	call   800714 <_panic>
	}

	cprintf("Congratulations!! test malloc (1) completed successfully.\n");
  8005b7:	83 ec 0c             	sub    $0xc,%esp
  8005ba:	68 90 24 80 00       	push   $0x802490
  8005bf:	e8 f2 03 00 00       	call   8009b6 <cprintf>
  8005c4:	83 c4 10             	add    $0x10,%esp

	return;
  8005c7:	90                   	nop
}
  8005c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8005cb:	5b                   	pop    %ebx
  8005cc:	5f                   	pop    %edi
  8005cd:	5d                   	pop    %ebp
  8005ce:	c3                   	ret    

008005cf <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005cf:	55                   	push   %ebp
  8005d0:	89 e5                	mov    %esp,%ebp
  8005d2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005d5:	e8 82 15 00 00       	call   801b5c <sys_getenvindex>
  8005da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e0:	89 d0                	mov    %edx,%eax
  8005e2:	c1 e0 03             	shl    $0x3,%eax
  8005e5:	01 d0                	add    %edx,%eax
  8005e7:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005ee:	01 c8                	add    %ecx,%eax
  8005f0:	01 c0                	add    %eax,%eax
  8005f2:	01 d0                	add    %edx,%eax
  8005f4:	01 c0                	add    %eax,%eax
  8005f6:	01 d0                	add    %edx,%eax
  8005f8:	89 c2                	mov    %eax,%edx
  8005fa:	c1 e2 05             	shl    $0x5,%edx
  8005fd:	29 c2                	sub    %eax,%edx
  8005ff:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800606:	89 c2                	mov    %eax,%edx
  800608:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80060e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800613:	a1 20 30 80 00       	mov    0x803020,%eax
  800618:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80061e:	84 c0                	test   %al,%al
  800620:	74 0f                	je     800631 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800622:	a1 20 30 80 00       	mov    0x803020,%eax
  800627:	05 40 3c 01 00       	add    $0x13c40,%eax
  80062c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800631:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800635:	7e 0a                	jle    800641 <libmain+0x72>
		binaryname = argv[0];
  800637:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063a:	8b 00                	mov    (%eax),%eax
  80063c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800641:	83 ec 08             	sub    $0x8,%esp
  800644:	ff 75 0c             	pushl  0xc(%ebp)
  800647:	ff 75 08             	pushl  0x8(%ebp)
  80064a:	e8 e9 f9 ff ff       	call   800038 <_main>
  80064f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800652:	e8 a0 16 00 00       	call   801cf7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800657:	83 ec 0c             	sub    $0xc,%esp
  80065a:	68 e4 24 80 00       	push   $0x8024e4
  80065f:	e8 52 03 00 00       	call   8009b6 <cprintf>
  800664:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800667:	a1 20 30 80 00       	mov    0x803020,%eax
  80066c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800672:	a1 20 30 80 00       	mov    0x803020,%eax
  800677:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80067d:	83 ec 04             	sub    $0x4,%esp
  800680:	52                   	push   %edx
  800681:	50                   	push   %eax
  800682:	68 0c 25 80 00       	push   $0x80250c
  800687:	e8 2a 03 00 00       	call   8009b6 <cprintf>
  80068c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80068f:	a1 20 30 80 00       	mov    0x803020,%eax
  800694:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80069a:	a1 20 30 80 00       	mov    0x803020,%eax
  80069f:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006a5:	83 ec 04             	sub    $0x4,%esp
  8006a8:	52                   	push   %edx
  8006a9:	50                   	push   %eax
  8006aa:	68 34 25 80 00       	push   $0x802534
  8006af:	e8 02 03 00 00       	call   8009b6 <cprintf>
  8006b4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006bc:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006c2:	83 ec 08             	sub    $0x8,%esp
  8006c5:	50                   	push   %eax
  8006c6:	68 75 25 80 00       	push   $0x802575
  8006cb:	e8 e6 02 00 00       	call   8009b6 <cprintf>
  8006d0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006d3:	83 ec 0c             	sub    $0xc,%esp
  8006d6:	68 e4 24 80 00       	push   $0x8024e4
  8006db:	e8 d6 02 00 00       	call   8009b6 <cprintf>
  8006e0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006e3:	e8 29 16 00 00       	call   801d11 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006e8:	e8 19 00 00 00       	call   800706 <exit>
}
  8006ed:	90                   	nop
  8006ee:	c9                   	leave  
  8006ef:	c3                   	ret    

008006f0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006f0:	55                   	push   %ebp
  8006f1:	89 e5                	mov    %esp,%ebp
  8006f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006f6:	83 ec 0c             	sub    $0xc,%esp
  8006f9:	6a 00                	push   $0x0
  8006fb:	e8 28 14 00 00       	call   801b28 <sys_env_destroy>
  800700:	83 c4 10             	add    $0x10,%esp
}
  800703:	90                   	nop
  800704:	c9                   	leave  
  800705:	c3                   	ret    

00800706 <exit>:

void
exit(void)
{
  800706:	55                   	push   %ebp
  800707:	89 e5                	mov    %esp,%ebp
  800709:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80070c:	e8 7d 14 00 00       	call   801b8e <sys_env_exit>
}
  800711:	90                   	nop
  800712:	c9                   	leave  
  800713:	c3                   	ret    

00800714 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800714:	55                   	push   %ebp
  800715:	89 e5                	mov    %esp,%ebp
  800717:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80071a:	8d 45 10             	lea    0x10(%ebp),%eax
  80071d:	83 c0 04             	add    $0x4,%eax
  800720:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800723:	a1 18 31 80 00       	mov    0x803118,%eax
  800728:	85 c0                	test   %eax,%eax
  80072a:	74 16                	je     800742 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80072c:	a1 18 31 80 00       	mov    0x803118,%eax
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	50                   	push   %eax
  800735:	68 8c 25 80 00       	push   $0x80258c
  80073a:	e8 77 02 00 00       	call   8009b6 <cprintf>
  80073f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800742:	a1 00 30 80 00       	mov    0x803000,%eax
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	ff 75 08             	pushl  0x8(%ebp)
  80074d:	50                   	push   %eax
  80074e:	68 91 25 80 00       	push   $0x802591
  800753:	e8 5e 02 00 00       	call   8009b6 <cprintf>
  800758:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80075b:	8b 45 10             	mov    0x10(%ebp),%eax
  80075e:	83 ec 08             	sub    $0x8,%esp
  800761:	ff 75 f4             	pushl  -0xc(%ebp)
  800764:	50                   	push   %eax
  800765:	e8 e1 01 00 00       	call   80094b <vcprintf>
  80076a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	6a 00                	push   $0x0
  800772:	68 ad 25 80 00       	push   $0x8025ad
  800777:	e8 cf 01 00 00       	call   80094b <vcprintf>
  80077c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80077f:	e8 82 ff ff ff       	call   800706 <exit>

	// should not return here
	while (1) ;
  800784:	eb fe                	jmp    800784 <_panic+0x70>

00800786 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80078c:	a1 20 30 80 00       	mov    0x803020,%eax
  800791:	8b 50 74             	mov    0x74(%eax),%edx
  800794:	8b 45 0c             	mov    0xc(%ebp),%eax
  800797:	39 c2                	cmp    %eax,%edx
  800799:	74 14                	je     8007af <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80079b:	83 ec 04             	sub    $0x4,%esp
  80079e:	68 b0 25 80 00       	push   $0x8025b0
  8007a3:	6a 26                	push   $0x26
  8007a5:	68 fc 25 80 00       	push   $0x8025fc
  8007aa:	e8 65 ff ff ff       	call   800714 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007bd:	e9 b6 00 00 00       	jmp    800878 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	01 d0                	add    %edx,%eax
  8007d1:	8b 00                	mov    (%eax),%eax
  8007d3:	85 c0                	test   %eax,%eax
  8007d5:	75 08                	jne    8007df <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007d7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007da:	e9 96 00 00 00       	jmp    800875 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007e6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007ed:	eb 5d                	jmp    80084c <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8007f4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007fd:	c1 e2 04             	shl    $0x4,%edx
  800800:	01 d0                	add    %edx,%eax
  800802:	8a 40 04             	mov    0x4(%eax),%al
  800805:	84 c0                	test   %al,%al
  800807:	75 40                	jne    800849 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800809:	a1 20 30 80 00       	mov    0x803020,%eax
  80080e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800814:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800817:	c1 e2 04             	shl    $0x4,%edx
  80081a:	01 d0                	add    %edx,%eax
  80081c:	8b 00                	mov    (%eax),%eax
  80081e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800821:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800824:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800829:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80082b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	01 c8                	add    %ecx,%eax
  80083a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80083c:	39 c2                	cmp    %eax,%edx
  80083e:	75 09                	jne    800849 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800840:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800847:	eb 12                	jmp    80085b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800849:	ff 45 e8             	incl   -0x18(%ebp)
  80084c:	a1 20 30 80 00       	mov    0x803020,%eax
  800851:	8b 50 74             	mov    0x74(%eax),%edx
  800854:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800857:	39 c2                	cmp    %eax,%edx
  800859:	77 94                	ja     8007ef <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80085b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80085f:	75 14                	jne    800875 <CheckWSWithoutLastIndex+0xef>
			panic(
  800861:	83 ec 04             	sub    $0x4,%esp
  800864:	68 08 26 80 00       	push   $0x802608
  800869:	6a 3a                	push   $0x3a
  80086b:	68 fc 25 80 00       	push   $0x8025fc
  800870:	e8 9f fe ff ff       	call   800714 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800875:	ff 45 f0             	incl   -0x10(%ebp)
  800878:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80087e:	0f 8c 3e ff ff ff    	jl     8007c2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800884:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800892:	eb 20                	jmp    8008b4 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800894:	a1 20 30 80 00       	mov    0x803020,%eax
  800899:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80089f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008a2:	c1 e2 04             	shl    $0x4,%edx
  8008a5:	01 d0                	add    %edx,%eax
  8008a7:	8a 40 04             	mov    0x4(%eax),%al
  8008aa:	3c 01                	cmp    $0x1,%al
  8008ac:	75 03                	jne    8008b1 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008ae:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b1:	ff 45 e0             	incl   -0x20(%ebp)
  8008b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b9:	8b 50 74             	mov    0x74(%eax),%edx
  8008bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008bf:	39 c2                	cmp    %eax,%edx
  8008c1:	77 d1                	ja     800894 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008c6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008c9:	74 14                	je     8008df <CheckWSWithoutLastIndex+0x159>
		panic(
  8008cb:	83 ec 04             	sub    $0x4,%esp
  8008ce:	68 5c 26 80 00       	push   $0x80265c
  8008d3:	6a 44                	push   $0x44
  8008d5:	68 fc 25 80 00       	push   $0x8025fc
  8008da:	e8 35 fe ff ff       	call   800714 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008df:	90                   	nop
  8008e0:	c9                   	leave  
  8008e1:	c3                   	ret    

008008e2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e2:	55                   	push   %ebp
  8008e3:	89 e5                	mov    %esp,%ebp
  8008e5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008eb:	8b 00                	mov    (%eax),%eax
  8008ed:	8d 48 01             	lea    0x1(%eax),%ecx
  8008f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f3:	89 0a                	mov    %ecx,(%edx)
  8008f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f8:	88 d1                	mov    %dl,%cl
  8008fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800901:	8b 45 0c             	mov    0xc(%ebp),%eax
  800904:	8b 00                	mov    (%eax),%eax
  800906:	3d ff 00 00 00       	cmp    $0xff,%eax
  80090b:	75 2c                	jne    800939 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80090d:	a0 24 30 80 00       	mov    0x803024,%al
  800912:	0f b6 c0             	movzbl %al,%eax
  800915:	8b 55 0c             	mov    0xc(%ebp),%edx
  800918:	8b 12                	mov    (%edx),%edx
  80091a:	89 d1                	mov    %edx,%ecx
  80091c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091f:	83 c2 08             	add    $0x8,%edx
  800922:	83 ec 04             	sub    $0x4,%esp
  800925:	50                   	push   %eax
  800926:	51                   	push   %ecx
  800927:	52                   	push   %edx
  800928:	e8 b9 11 00 00       	call   801ae6 <sys_cputs>
  80092d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800930:	8b 45 0c             	mov    0xc(%ebp),%eax
  800933:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800939:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093c:	8b 40 04             	mov    0x4(%eax),%eax
  80093f:	8d 50 01             	lea    0x1(%eax),%edx
  800942:	8b 45 0c             	mov    0xc(%ebp),%eax
  800945:	89 50 04             	mov    %edx,0x4(%eax)
}
  800948:	90                   	nop
  800949:	c9                   	leave  
  80094a:	c3                   	ret    

0080094b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80094b:	55                   	push   %ebp
  80094c:	89 e5                	mov    %esp,%ebp
  80094e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800954:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80095b:	00 00 00 
	b.cnt = 0;
  80095e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800965:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800968:	ff 75 0c             	pushl  0xc(%ebp)
  80096b:	ff 75 08             	pushl  0x8(%ebp)
  80096e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800974:	50                   	push   %eax
  800975:	68 e2 08 80 00       	push   $0x8008e2
  80097a:	e8 11 02 00 00       	call   800b90 <vprintfmt>
  80097f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800982:	a0 24 30 80 00       	mov    0x803024,%al
  800987:	0f b6 c0             	movzbl %al,%eax
  80098a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800990:	83 ec 04             	sub    $0x4,%esp
  800993:	50                   	push   %eax
  800994:	52                   	push   %edx
  800995:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80099b:	83 c0 08             	add    $0x8,%eax
  80099e:	50                   	push   %eax
  80099f:	e8 42 11 00 00       	call   801ae6 <sys_cputs>
  8009a4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009a7:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009ae:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009b4:	c9                   	leave  
  8009b5:	c3                   	ret    

008009b6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009b6:	55                   	push   %ebp
  8009b7:	89 e5                	mov    %esp,%ebp
  8009b9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009bc:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009c3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	83 ec 08             	sub    $0x8,%esp
  8009cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d2:	50                   	push   %eax
  8009d3:	e8 73 ff ff ff       	call   80094b <vcprintf>
  8009d8:	83 c4 10             	add    $0x10,%esp
  8009db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e1:	c9                   	leave  
  8009e2:	c3                   	ret    

008009e3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009e3:	55                   	push   %ebp
  8009e4:	89 e5                	mov    %esp,%ebp
  8009e6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009e9:	e8 09 13 00 00       	call   801cf7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009ee:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fd:	50                   	push   %eax
  8009fe:	e8 48 ff ff ff       	call   80094b <vcprintf>
  800a03:	83 c4 10             	add    $0x10,%esp
  800a06:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a09:	e8 03 13 00 00       	call   801d11 <sys_enable_interrupt>
	return cnt;
  800a0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a11:	c9                   	leave  
  800a12:	c3                   	ret    

00800a13 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a13:	55                   	push   %ebp
  800a14:	89 e5                	mov    %esp,%ebp
  800a16:	53                   	push   %ebx
  800a17:	83 ec 14             	sub    $0x14,%esp
  800a1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a20:	8b 45 14             	mov    0x14(%ebp),%eax
  800a23:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a26:	8b 45 18             	mov    0x18(%ebp),%eax
  800a29:	ba 00 00 00 00       	mov    $0x0,%edx
  800a2e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a31:	77 55                	ja     800a88 <printnum+0x75>
  800a33:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a36:	72 05                	jb     800a3d <printnum+0x2a>
  800a38:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a3b:	77 4b                	ja     800a88 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a3d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a40:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a43:	8b 45 18             	mov    0x18(%ebp),%eax
  800a46:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4b:	52                   	push   %edx
  800a4c:	50                   	push   %eax
  800a4d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a50:	ff 75 f0             	pushl  -0x10(%ebp)
  800a53:	e8 c0 16 00 00       	call   802118 <__udivdi3>
  800a58:	83 c4 10             	add    $0x10,%esp
  800a5b:	83 ec 04             	sub    $0x4,%esp
  800a5e:	ff 75 20             	pushl  0x20(%ebp)
  800a61:	53                   	push   %ebx
  800a62:	ff 75 18             	pushl  0x18(%ebp)
  800a65:	52                   	push   %edx
  800a66:	50                   	push   %eax
  800a67:	ff 75 0c             	pushl  0xc(%ebp)
  800a6a:	ff 75 08             	pushl  0x8(%ebp)
  800a6d:	e8 a1 ff ff ff       	call   800a13 <printnum>
  800a72:	83 c4 20             	add    $0x20,%esp
  800a75:	eb 1a                	jmp    800a91 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	ff 75 20             	pushl  0x20(%ebp)
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	ff d0                	call   *%eax
  800a85:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a88:	ff 4d 1c             	decl   0x1c(%ebp)
  800a8b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a8f:	7f e6                	jg     800a77 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a91:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a94:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a9f:	53                   	push   %ebx
  800aa0:	51                   	push   %ecx
  800aa1:	52                   	push   %edx
  800aa2:	50                   	push   %eax
  800aa3:	e8 80 17 00 00       	call   802228 <__umoddi3>
  800aa8:	83 c4 10             	add    $0x10,%esp
  800aab:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800ab0:	8a 00                	mov    (%eax),%al
  800ab2:	0f be c0             	movsbl %al,%eax
  800ab5:	83 ec 08             	sub    $0x8,%esp
  800ab8:	ff 75 0c             	pushl  0xc(%ebp)
  800abb:	50                   	push   %eax
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	ff d0                	call   *%eax
  800ac1:	83 c4 10             	add    $0x10,%esp
}
  800ac4:	90                   	nop
  800ac5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800acd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad1:	7e 1c                	jle    800aef <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	8b 00                	mov    (%eax),%eax
  800ad8:	8d 50 08             	lea    0x8(%eax),%edx
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	89 10                	mov    %edx,(%eax)
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	8b 00                	mov    (%eax),%eax
  800ae5:	83 e8 08             	sub    $0x8,%eax
  800ae8:	8b 50 04             	mov    0x4(%eax),%edx
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	eb 40                	jmp    800b2f <getuint+0x65>
	else if (lflag)
  800aef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af3:	74 1e                	je     800b13 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8b 00                	mov    (%eax),%eax
  800afa:	8d 50 04             	lea    0x4(%eax),%edx
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	89 10                	mov    %edx,(%eax)
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	8b 00                	mov    (%eax),%eax
  800b07:	83 e8 04             	sub    $0x4,%eax
  800b0a:	8b 00                	mov    (%eax),%eax
  800b0c:	ba 00 00 00 00       	mov    $0x0,%edx
  800b11:	eb 1c                	jmp    800b2f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	8b 00                	mov    (%eax),%eax
  800b18:	8d 50 04             	lea    0x4(%eax),%edx
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	89 10                	mov    %edx,(%eax)
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	8b 00                	mov    (%eax),%eax
  800b25:	83 e8 04             	sub    $0x4,%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b2f:	5d                   	pop    %ebp
  800b30:	c3                   	ret    

00800b31 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b31:	55                   	push   %ebp
  800b32:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b34:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b38:	7e 1c                	jle    800b56 <getint+0x25>
		return va_arg(*ap, long long);
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	8b 00                	mov    (%eax),%eax
  800b3f:	8d 50 08             	lea    0x8(%eax),%edx
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	89 10                	mov    %edx,(%eax)
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	8b 00                	mov    (%eax),%eax
  800b4c:	83 e8 08             	sub    $0x8,%eax
  800b4f:	8b 50 04             	mov    0x4(%eax),%edx
  800b52:	8b 00                	mov    (%eax),%eax
  800b54:	eb 38                	jmp    800b8e <getint+0x5d>
	else if (lflag)
  800b56:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b5a:	74 1a                	je     800b76 <getint+0x45>
		return va_arg(*ap, long);
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	8b 00                	mov    (%eax),%eax
  800b61:	8d 50 04             	lea    0x4(%eax),%edx
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	89 10                	mov    %edx,(%eax)
  800b69:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6c:	8b 00                	mov    (%eax),%eax
  800b6e:	83 e8 04             	sub    $0x4,%eax
  800b71:	8b 00                	mov    (%eax),%eax
  800b73:	99                   	cltd   
  800b74:	eb 18                	jmp    800b8e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	8b 00                	mov    (%eax),%eax
  800b7b:	8d 50 04             	lea    0x4(%eax),%edx
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	89 10                	mov    %edx,(%eax)
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	8b 00                	mov    (%eax),%eax
  800b88:	83 e8 04             	sub    $0x4,%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	99                   	cltd   
}
  800b8e:	5d                   	pop    %ebp
  800b8f:	c3                   	ret    

00800b90 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b90:	55                   	push   %ebp
  800b91:	89 e5                	mov    %esp,%ebp
  800b93:	56                   	push   %esi
  800b94:	53                   	push   %ebx
  800b95:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b98:	eb 17                	jmp    800bb1 <vprintfmt+0x21>
			if (ch == '\0')
  800b9a:	85 db                	test   %ebx,%ebx
  800b9c:	0f 84 af 03 00 00    	je     800f51 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba2:	83 ec 08             	sub    $0x8,%esp
  800ba5:	ff 75 0c             	pushl  0xc(%ebp)
  800ba8:	53                   	push   %ebx
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	ff d0                	call   *%eax
  800bae:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb4:	8d 50 01             	lea    0x1(%eax),%edx
  800bb7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bba:	8a 00                	mov    (%eax),%al
  800bbc:	0f b6 d8             	movzbl %al,%ebx
  800bbf:	83 fb 25             	cmp    $0x25,%ebx
  800bc2:	75 d6                	jne    800b9a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bc4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bc8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bcf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bd6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bdd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800be4:	8b 45 10             	mov    0x10(%ebp),%eax
  800be7:	8d 50 01             	lea    0x1(%eax),%edx
  800bea:	89 55 10             	mov    %edx,0x10(%ebp)
  800bed:	8a 00                	mov    (%eax),%al
  800bef:	0f b6 d8             	movzbl %al,%ebx
  800bf2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bf5:	83 f8 55             	cmp    $0x55,%eax
  800bf8:	0f 87 2b 03 00 00    	ja     800f29 <vprintfmt+0x399>
  800bfe:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  800c05:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c07:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c0b:	eb d7                	jmp    800be4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c0d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c11:	eb d1                	jmp    800be4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c13:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c1a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c1d:	89 d0                	mov    %edx,%eax
  800c1f:	c1 e0 02             	shl    $0x2,%eax
  800c22:	01 d0                	add    %edx,%eax
  800c24:	01 c0                	add    %eax,%eax
  800c26:	01 d8                	add    %ebx,%eax
  800c28:	83 e8 30             	sub    $0x30,%eax
  800c2b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c31:	8a 00                	mov    (%eax),%al
  800c33:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c36:	83 fb 2f             	cmp    $0x2f,%ebx
  800c39:	7e 3e                	jle    800c79 <vprintfmt+0xe9>
  800c3b:	83 fb 39             	cmp    $0x39,%ebx
  800c3e:	7f 39                	jg     800c79 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c40:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c43:	eb d5                	jmp    800c1a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c45:	8b 45 14             	mov    0x14(%ebp),%eax
  800c48:	83 c0 04             	add    $0x4,%eax
  800c4b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c51:	83 e8 04             	sub    $0x4,%eax
  800c54:	8b 00                	mov    (%eax),%eax
  800c56:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c59:	eb 1f                	jmp    800c7a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c5b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c5f:	79 83                	jns    800be4 <vprintfmt+0x54>
				width = 0;
  800c61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c68:	e9 77 ff ff ff       	jmp    800be4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c6d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c74:	e9 6b ff ff ff       	jmp    800be4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c79:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c7a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7e:	0f 89 60 ff ff ff    	jns    800be4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c84:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c87:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c8a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c91:	e9 4e ff ff ff       	jmp    800be4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c96:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c99:	e9 46 ff ff ff       	jmp    800be4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca1:	83 c0 04             	add    $0x4,%eax
  800ca4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca7:	8b 45 14             	mov    0x14(%ebp),%eax
  800caa:	83 e8 04             	sub    $0x4,%eax
  800cad:	8b 00                	mov    (%eax),%eax
  800caf:	83 ec 08             	sub    $0x8,%esp
  800cb2:	ff 75 0c             	pushl  0xc(%ebp)
  800cb5:	50                   	push   %eax
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	ff d0                	call   *%eax
  800cbb:	83 c4 10             	add    $0x10,%esp
			break;
  800cbe:	e9 89 02 00 00       	jmp    800f4c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cc3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc6:	83 c0 04             	add    $0x4,%eax
  800cc9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ccc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccf:	83 e8 04             	sub    $0x4,%eax
  800cd2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cd4:	85 db                	test   %ebx,%ebx
  800cd6:	79 02                	jns    800cda <vprintfmt+0x14a>
				err = -err;
  800cd8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cda:	83 fb 64             	cmp    $0x64,%ebx
  800cdd:	7f 0b                	jg     800cea <vprintfmt+0x15a>
  800cdf:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800ce6:	85 f6                	test   %esi,%esi
  800ce8:	75 19                	jne    800d03 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cea:	53                   	push   %ebx
  800ceb:	68 e5 28 80 00       	push   $0x8028e5
  800cf0:	ff 75 0c             	pushl  0xc(%ebp)
  800cf3:	ff 75 08             	pushl  0x8(%ebp)
  800cf6:	e8 5e 02 00 00       	call   800f59 <printfmt>
  800cfb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cfe:	e9 49 02 00 00       	jmp    800f4c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d03:	56                   	push   %esi
  800d04:	68 ee 28 80 00       	push   $0x8028ee
  800d09:	ff 75 0c             	pushl  0xc(%ebp)
  800d0c:	ff 75 08             	pushl  0x8(%ebp)
  800d0f:	e8 45 02 00 00       	call   800f59 <printfmt>
  800d14:	83 c4 10             	add    $0x10,%esp
			break;
  800d17:	e9 30 02 00 00       	jmp    800f4c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1f:	83 c0 04             	add    $0x4,%eax
  800d22:	89 45 14             	mov    %eax,0x14(%ebp)
  800d25:	8b 45 14             	mov    0x14(%ebp),%eax
  800d28:	83 e8 04             	sub    $0x4,%eax
  800d2b:	8b 30                	mov    (%eax),%esi
  800d2d:	85 f6                	test   %esi,%esi
  800d2f:	75 05                	jne    800d36 <vprintfmt+0x1a6>
				p = "(null)";
  800d31:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800d36:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d3a:	7e 6d                	jle    800da9 <vprintfmt+0x219>
  800d3c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d40:	74 67                	je     800da9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d42:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	50                   	push   %eax
  800d49:	56                   	push   %esi
  800d4a:	e8 0c 03 00 00       	call   80105b <strnlen>
  800d4f:	83 c4 10             	add    $0x10,%esp
  800d52:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d55:	eb 16                	jmp    800d6d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d57:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d5b:	83 ec 08             	sub    $0x8,%esp
  800d5e:	ff 75 0c             	pushl  0xc(%ebp)
  800d61:	50                   	push   %eax
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	ff d0                	call   *%eax
  800d67:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d6a:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d71:	7f e4                	jg     800d57 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d73:	eb 34                	jmp    800da9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d75:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d79:	74 1c                	je     800d97 <vprintfmt+0x207>
  800d7b:	83 fb 1f             	cmp    $0x1f,%ebx
  800d7e:	7e 05                	jle    800d85 <vprintfmt+0x1f5>
  800d80:	83 fb 7e             	cmp    $0x7e,%ebx
  800d83:	7e 12                	jle    800d97 <vprintfmt+0x207>
					putch('?', putdat);
  800d85:	83 ec 08             	sub    $0x8,%esp
  800d88:	ff 75 0c             	pushl  0xc(%ebp)
  800d8b:	6a 3f                	push   $0x3f
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	ff d0                	call   *%eax
  800d92:	83 c4 10             	add    $0x10,%esp
  800d95:	eb 0f                	jmp    800da6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d97:	83 ec 08             	sub    $0x8,%esp
  800d9a:	ff 75 0c             	pushl  0xc(%ebp)
  800d9d:	53                   	push   %ebx
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	ff d0                	call   *%eax
  800da3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da6:	ff 4d e4             	decl   -0x1c(%ebp)
  800da9:	89 f0                	mov    %esi,%eax
  800dab:	8d 70 01             	lea    0x1(%eax),%esi
  800dae:	8a 00                	mov    (%eax),%al
  800db0:	0f be d8             	movsbl %al,%ebx
  800db3:	85 db                	test   %ebx,%ebx
  800db5:	74 24                	je     800ddb <vprintfmt+0x24b>
  800db7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dbb:	78 b8                	js     800d75 <vprintfmt+0x1e5>
  800dbd:	ff 4d e0             	decl   -0x20(%ebp)
  800dc0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc4:	79 af                	jns    800d75 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc6:	eb 13                	jmp    800ddb <vprintfmt+0x24b>
				putch(' ', putdat);
  800dc8:	83 ec 08             	sub    $0x8,%esp
  800dcb:	ff 75 0c             	pushl  0xc(%ebp)
  800dce:	6a 20                	push   $0x20
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	ff d0                	call   *%eax
  800dd5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd8:	ff 4d e4             	decl   -0x1c(%ebp)
  800ddb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ddf:	7f e7                	jg     800dc8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de1:	e9 66 01 00 00       	jmp    800f4c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800de6:	83 ec 08             	sub    $0x8,%esp
  800de9:	ff 75 e8             	pushl  -0x18(%ebp)
  800dec:	8d 45 14             	lea    0x14(%ebp),%eax
  800def:	50                   	push   %eax
  800df0:	e8 3c fd ff ff       	call   800b31 <getint>
  800df5:	83 c4 10             	add    $0x10,%esp
  800df8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e01:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e04:	85 d2                	test   %edx,%edx
  800e06:	79 23                	jns    800e2b <vprintfmt+0x29b>
				putch('-', putdat);
  800e08:	83 ec 08             	sub    $0x8,%esp
  800e0b:	ff 75 0c             	pushl  0xc(%ebp)
  800e0e:	6a 2d                	push   $0x2d
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	ff d0                	call   *%eax
  800e15:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1e:	f7 d8                	neg    %eax
  800e20:	83 d2 00             	adc    $0x0,%edx
  800e23:	f7 da                	neg    %edx
  800e25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e28:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e2b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e32:	e9 bc 00 00 00       	jmp    800ef3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e37:	83 ec 08             	sub    $0x8,%esp
  800e3a:	ff 75 e8             	pushl  -0x18(%ebp)
  800e3d:	8d 45 14             	lea    0x14(%ebp),%eax
  800e40:	50                   	push   %eax
  800e41:	e8 84 fc ff ff       	call   800aca <getuint>
  800e46:	83 c4 10             	add    $0x10,%esp
  800e49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e4f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e56:	e9 98 00 00 00       	jmp    800ef3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e5b:	83 ec 08             	sub    $0x8,%esp
  800e5e:	ff 75 0c             	pushl  0xc(%ebp)
  800e61:	6a 58                	push   $0x58
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	ff d0                	call   *%eax
  800e68:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e6b:	83 ec 08             	sub    $0x8,%esp
  800e6e:	ff 75 0c             	pushl  0xc(%ebp)
  800e71:	6a 58                	push   $0x58
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	ff d0                	call   *%eax
  800e78:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7b:	83 ec 08             	sub    $0x8,%esp
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	6a 58                	push   $0x58
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	ff d0                	call   *%eax
  800e88:	83 c4 10             	add    $0x10,%esp
			break;
  800e8b:	e9 bc 00 00 00       	jmp    800f4c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e90:	83 ec 08             	sub    $0x8,%esp
  800e93:	ff 75 0c             	pushl  0xc(%ebp)
  800e96:	6a 30                	push   $0x30
  800e98:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9b:	ff d0                	call   *%eax
  800e9d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ea0:	83 ec 08             	sub    $0x8,%esp
  800ea3:	ff 75 0c             	pushl  0xc(%ebp)
  800ea6:	6a 78                	push   $0x78
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	ff d0                	call   *%eax
  800ead:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb3:	83 c0 04             	add    $0x4,%eax
  800eb6:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebc:	83 e8 04             	sub    $0x4,%eax
  800ebf:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ecb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed2:	eb 1f                	jmp    800ef3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ed4:	83 ec 08             	sub    $0x8,%esp
  800ed7:	ff 75 e8             	pushl  -0x18(%ebp)
  800eda:	8d 45 14             	lea    0x14(%ebp),%eax
  800edd:	50                   	push   %eax
  800ede:	e8 e7 fb ff ff       	call   800aca <getuint>
  800ee3:	83 c4 10             	add    $0x10,%esp
  800ee6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eec:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ef3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ef7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800efa:	83 ec 04             	sub    $0x4,%esp
  800efd:	52                   	push   %edx
  800efe:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f01:	50                   	push   %eax
  800f02:	ff 75 f4             	pushl  -0xc(%ebp)
  800f05:	ff 75 f0             	pushl  -0x10(%ebp)
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	ff 75 08             	pushl  0x8(%ebp)
  800f0e:	e8 00 fb ff ff       	call   800a13 <printnum>
  800f13:	83 c4 20             	add    $0x20,%esp
			break;
  800f16:	eb 34                	jmp    800f4c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f18:	83 ec 08             	sub    $0x8,%esp
  800f1b:	ff 75 0c             	pushl  0xc(%ebp)
  800f1e:	53                   	push   %ebx
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	ff d0                	call   *%eax
  800f24:	83 c4 10             	add    $0x10,%esp
			break;
  800f27:	eb 23                	jmp    800f4c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 0c             	pushl  0xc(%ebp)
  800f2f:	6a 25                	push   $0x25
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	ff d0                	call   *%eax
  800f36:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f39:	ff 4d 10             	decl   0x10(%ebp)
  800f3c:	eb 03                	jmp    800f41 <vprintfmt+0x3b1>
  800f3e:	ff 4d 10             	decl   0x10(%ebp)
  800f41:	8b 45 10             	mov    0x10(%ebp),%eax
  800f44:	48                   	dec    %eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	3c 25                	cmp    $0x25,%al
  800f49:	75 f3                	jne    800f3e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f4b:	90                   	nop
		}
	}
  800f4c:	e9 47 fc ff ff       	jmp    800b98 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f51:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f55:	5b                   	pop    %ebx
  800f56:	5e                   	pop    %esi
  800f57:	5d                   	pop    %ebp
  800f58:	c3                   	ret    

00800f59 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f59:	55                   	push   %ebp
  800f5a:	89 e5                	mov    %esp,%ebp
  800f5c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f5f:	8d 45 10             	lea    0x10(%ebp),%eax
  800f62:	83 c0 04             	add    $0x4,%eax
  800f65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f68:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6b:	ff 75 f4             	pushl  -0xc(%ebp)
  800f6e:	50                   	push   %eax
  800f6f:	ff 75 0c             	pushl  0xc(%ebp)
  800f72:	ff 75 08             	pushl  0x8(%ebp)
  800f75:	e8 16 fc ff ff       	call   800b90 <vprintfmt>
  800f7a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f7d:	90                   	nop
  800f7e:	c9                   	leave  
  800f7f:	c3                   	ret    

00800f80 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f80:	55                   	push   %ebp
  800f81:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f86:	8b 40 08             	mov    0x8(%eax),%eax
  800f89:	8d 50 01             	lea    0x1(%eax),%edx
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f95:	8b 10                	mov    (%eax),%edx
  800f97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9a:	8b 40 04             	mov    0x4(%eax),%eax
  800f9d:	39 c2                	cmp    %eax,%edx
  800f9f:	73 12                	jae    800fb3 <sprintputch+0x33>
		*b->buf++ = ch;
  800fa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa4:	8b 00                	mov    (%eax),%eax
  800fa6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fac:	89 0a                	mov    %ecx,(%edx)
  800fae:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb1:	88 10                	mov    %dl,(%eax)
}
  800fb3:	90                   	nop
  800fb4:	5d                   	pop    %ebp
  800fb5:	c3                   	ret    

00800fb6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fb6:	55                   	push   %ebp
  800fb7:	89 e5                	mov    %esp,%ebp
  800fb9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	01 d0                	add    %edx,%eax
  800fcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fd7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fdb:	74 06                	je     800fe3 <vsnprintf+0x2d>
  800fdd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe1:	7f 07                	jg     800fea <vsnprintf+0x34>
		return -E_INVAL;
  800fe3:	b8 03 00 00 00       	mov    $0x3,%eax
  800fe8:	eb 20                	jmp    80100a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fea:	ff 75 14             	pushl  0x14(%ebp)
  800fed:	ff 75 10             	pushl  0x10(%ebp)
  800ff0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ff3:	50                   	push   %eax
  800ff4:	68 80 0f 80 00       	push   $0x800f80
  800ff9:	e8 92 fb ff ff       	call   800b90 <vprintfmt>
  800ffe:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801001:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801004:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801007:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80100a:	c9                   	leave  
  80100b:	c3                   	ret    

0080100c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80100c:	55                   	push   %ebp
  80100d:	89 e5                	mov    %esp,%ebp
  80100f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801012:	8d 45 10             	lea    0x10(%ebp),%eax
  801015:	83 c0 04             	add    $0x4,%eax
  801018:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80101b:	8b 45 10             	mov    0x10(%ebp),%eax
  80101e:	ff 75 f4             	pushl  -0xc(%ebp)
  801021:	50                   	push   %eax
  801022:	ff 75 0c             	pushl  0xc(%ebp)
  801025:	ff 75 08             	pushl  0x8(%ebp)
  801028:	e8 89 ff ff ff       	call   800fb6 <vsnprintf>
  80102d:	83 c4 10             	add    $0x10,%esp
  801030:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801033:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801036:	c9                   	leave  
  801037:	c3                   	ret    

00801038 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801038:	55                   	push   %ebp
  801039:	89 e5                	mov    %esp,%ebp
  80103b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80103e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801045:	eb 06                	jmp    80104d <strlen+0x15>
		n++;
  801047:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80104a:	ff 45 08             	incl   0x8(%ebp)
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	84 c0                	test   %al,%al
  801054:	75 f1                	jne    801047 <strlen+0xf>
		n++;
	return n;
  801056:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801059:	c9                   	leave  
  80105a:	c3                   	ret    

0080105b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
  80105e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801061:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801068:	eb 09                	jmp    801073 <strnlen+0x18>
		n++;
  80106a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80106d:	ff 45 08             	incl   0x8(%ebp)
  801070:	ff 4d 0c             	decl   0xc(%ebp)
  801073:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801077:	74 09                	je     801082 <strnlen+0x27>
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	8a 00                	mov    (%eax),%al
  80107e:	84 c0                	test   %al,%al
  801080:	75 e8                	jne    80106a <strnlen+0xf>
		n++;
	return n;
  801082:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801085:	c9                   	leave  
  801086:	c3                   	ret    

00801087 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801087:	55                   	push   %ebp
  801088:	89 e5                	mov    %esp,%ebp
  80108a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80108d:	8b 45 08             	mov    0x8(%ebp),%eax
  801090:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801093:	90                   	nop
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	8d 50 01             	lea    0x1(%eax),%edx
  80109a:	89 55 08             	mov    %edx,0x8(%ebp)
  80109d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010a6:	8a 12                	mov    (%edx),%dl
  8010a8:	88 10                	mov    %dl,(%eax)
  8010aa:	8a 00                	mov    (%eax),%al
  8010ac:	84 c0                	test   %al,%al
  8010ae:	75 e4                	jne    801094 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010b3:	c9                   	leave  
  8010b4:	c3                   	ret    

008010b5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010b5:	55                   	push   %ebp
  8010b6:	89 e5                	mov    %esp,%ebp
  8010b8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010c8:	eb 1f                	jmp    8010e9 <strncpy+0x34>
		*dst++ = *src;
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8d 50 01             	lea    0x1(%eax),%edx
  8010d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d6:	8a 12                	mov    (%edx),%dl
  8010d8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	84 c0                	test   %al,%al
  8010e1:	74 03                	je     8010e6 <strncpy+0x31>
			src++;
  8010e3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010e6:	ff 45 fc             	incl   -0x4(%ebp)
  8010e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ec:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010ef:	72 d9                	jb     8010ca <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010f4:	c9                   	leave  
  8010f5:	c3                   	ret    

008010f6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010f6:	55                   	push   %ebp
  8010f7:	89 e5                	mov    %esp,%ebp
  8010f9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801102:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801106:	74 30                	je     801138 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801108:	eb 16                	jmp    801120 <strlcpy+0x2a>
			*dst++ = *src++;
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	8d 50 01             	lea    0x1(%eax),%edx
  801110:	89 55 08             	mov    %edx,0x8(%ebp)
  801113:	8b 55 0c             	mov    0xc(%ebp),%edx
  801116:	8d 4a 01             	lea    0x1(%edx),%ecx
  801119:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80111c:	8a 12                	mov    (%edx),%dl
  80111e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801120:	ff 4d 10             	decl   0x10(%ebp)
  801123:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801127:	74 09                	je     801132 <strlcpy+0x3c>
  801129:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	84 c0                	test   %al,%al
  801130:	75 d8                	jne    80110a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801138:	8b 55 08             	mov    0x8(%ebp),%edx
  80113b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113e:	29 c2                	sub    %eax,%edx
  801140:	89 d0                	mov    %edx,%eax
}
  801142:	c9                   	leave  
  801143:	c3                   	ret    

00801144 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801147:	eb 06                	jmp    80114f <strcmp+0xb>
		p++, q++;
  801149:	ff 45 08             	incl   0x8(%ebp)
  80114c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8a 00                	mov    (%eax),%al
  801154:	84 c0                	test   %al,%al
  801156:	74 0e                	je     801166 <strcmp+0x22>
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	8a 10                	mov    (%eax),%dl
  80115d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801160:	8a 00                	mov    (%eax),%al
  801162:	38 c2                	cmp    %al,%dl
  801164:	74 e3                	je     801149 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	0f b6 d0             	movzbl %al,%edx
  80116e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801171:	8a 00                	mov    (%eax),%al
  801173:	0f b6 c0             	movzbl %al,%eax
  801176:	29 c2                	sub    %eax,%edx
  801178:	89 d0                	mov    %edx,%eax
}
  80117a:	5d                   	pop    %ebp
  80117b:	c3                   	ret    

0080117c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80117c:	55                   	push   %ebp
  80117d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80117f:	eb 09                	jmp    80118a <strncmp+0xe>
		n--, p++, q++;
  801181:	ff 4d 10             	decl   0x10(%ebp)
  801184:	ff 45 08             	incl   0x8(%ebp)
  801187:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80118a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118e:	74 17                	je     8011a7 <strncmp+0x2b>
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	8a 00                	mov    (%eax),%al
  801195:	84 c0                	test   %al,%al
  801197:	74 0e                	je     8011a7 <strncmp+0x2b>
  801199:	8b 45 08             	mov    0x8(%ebp),%eax
  80119c:	8a 10                	mov    (%eax),%dl
  80119e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	38 c2                	cmp    %al,%dl
  8011a5:	74 da                	je     801181 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ab:	75 07                	jne    8011b4 <strncmp+0x38>
		return 0;
  8011ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8011b2:	eb 14                	jmp    8011c8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	0f b6 d0             	movzbl %al,%edx
  8011bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	0f b6 c0             	movzbl %al,%eax
  8011c4:	29 c2                	sub    %eax,%edx
  8011c6:	89 d0                	mov    %edx,%eax
}
  8011c8:	5d                   	pop    %ebp
  8011c9:	c3                   	ret    

008011ca <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011ca:	55                   	push   %ebp
  8011cb:	89 e5                	mov    %esp,%ebp
  8011cd:	83 ec 04             	sub    $0x4,%esp
  8011d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011d6:	eb 12                	jmp    8011ea <strchr+0x20>
		if (*s == c)
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011e0:	75 05                	jne    8011e7 <strchr+0x1d>
			return (char *) s;
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	eb 11                	jmp    8011f8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011e7:	ff 45 08             	incl   0x8(%ebp)
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	8a 00                	mov    (%eax),%al
  8011ef:	84 c0                	test   %al,%al
  8011f1:	75 e5                	jne    8011d8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011f8:	c9                   	leave  
  8011f9:	c3                   	ret    

008011fa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011fa:	55                   	push   %ebp
  8011fb:	89 e5                	mov    %esp,%ebp
  8011fd:	83 ec 04             	sub    $0x4,%esp
  801200:	8b 45 0c             	mov    0xc(%ebp),%eax
  801203:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801206:	eb 0d                	jmp    801215 <strfind+0x1b>
		if (*s == c)
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801210:	74 0e                	je     801220 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801212:	ff 45 08             	incl   0x8(%ebp)
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	8a 00                	mov    (%eax),%al
  80121a:	84 c0                	test   %al,%al
  80121c:	75 ea                	jne    801208 <strfind+0xe>
  80121e:	eb 01                	jmp    801221 <strfind+0x27>
		if (*s == c)
			break;
  801220:	90                   	nop
	return (char *) s;
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
  80122f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801232:	8b 45 10             	mov    0x10(%ebp),%eax
  801235:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801238:	eb 0e                	jmp    801248 <memset+0x22>
		*p++ = c;
  80123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123d:	8d 50 01             	lea    0x1(%eax),%edx
  801240:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801243:	8b 55 0c             	mov    0xc(%ebp),%edx
  801246:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801248:	ff 4d f8             	decl   -0x8(%ebp)
  80124b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80124f:	79 e9                	jns    80123a <memset+0x14>
		*p++ = c;

	return v;
  801251:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801254:	c9                   	leave  
  801255:	c3                   	ret    

00801256 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801256:	55                   	push   %ebp
  801257:	89 e5                	mov    %esp,%ebp
  801259:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80125c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801268:	eb 16                	jmp    801280 <memcpy+0x2a>
		*d++ = *s++;
  80126a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126d:	8d 50 01             	lea    0x1(%eax),%edx
  801270:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801273:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801276:	8d 4a 01             	lea    0x1(%edx),%ecx
  801279:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80127c:	8a 12                	mov    (%edx),%dl
  80127e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801280:	8b 45 10             	mov    0x10(%ebp),%eax
  801283:	8d 50 ff             	lea    -0x1(%eax),%edx
  801286:	89 55 10             	mov    %edx,0x10(%ebp)
  801289:	85 c0                	test   %eax,%eax
  80128b:	75 dd                	jne    80126a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
  801295:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012a7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012aa:	73 50                	jae    8012fc <memmove+0x6a>
  8012ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012af:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b2:	01 d0                	add    %edx,%eax
  8012b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012b7:	76 43                	jbe    8012fc <memmove+0x6a>
		s += n;
  8012b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012c5:	eb 10                	jmp    8012d7 <memmove+0x45>
			*--d = *--s;
  8012c7:	ff 4d f8             	decl   -0x8(%ebp)
  8012ca:	ff 4d fc             	decl   -0x4(%ebp)
  8012cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d0:	8a 10                	mov    (%eax),%dl
  8012d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e0:	85 c0                	test   %eax,%eax
  8012e2:	75 e3                	jne    8012c7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012e4:	eb 23                	jmp    801309 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e9:	8d 50 01             	lea    0x1(%eax),%edx
  8012ec:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012f8:	8a 12                	mov    (%edx),%dl
  8012fa:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  801302:	89 55 10             	mov    %edx,0x10(%ebp)
  801305:	85 c0                	test   %eax,%eax
  801307:	75 dd                	jne    8012e6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
  801311:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80131a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801320:	eb 2a                	jmp    80134c <memcmp+0x3e>
		if (*s1 != *s2)
  801322:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801325:	8a 10                	mov    (%eax),%dl
  801327:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132a:	8a 00                	mov    (%eax),%al
  80132c:	38 c2                	cmp    %al,%dl
  80132e:	74 16                	je     801346 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801330:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	0f b6 d0             	movzbl %al,%edx
  801338:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	0f b6 c0             	movzbl %al,%eax
  801340:	29 c2                	sub    %eax,%edx
  801342:	89 d0                	mov    %edx,%eax
  801344:	eb 18                	jmp    80135e <memcmp+0x50>
		s1++, s2++;
  801346:	ff 45 fc             	incl   -0x4(%ebp)
  801349:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80134c:	8b 45 10             	mov    0x10(%ebp),%eax
  80134f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801352:	89 55 10             	mov    %edx,0x10(%ebp)
  801355:	85 c0                	test   %eax,%eax
  801357:	75 c9                	jne    801322 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801359:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801366:	8b 55 08             	mov    0x8(%ebp),%edx
  801369:	8b 45 10             	mov    0x10(%ebp),%eax
  80136c:	01 d0                	add    %edx,%eax
  80136e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801371:	eb 15                	jmp    801388 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	0f b6 d0             	movzbl %al,%edx
  80137b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137e:	0f b6 c0             	movzbl %al,%eax
  801381:	39 c2                	cmp    %eax,%edx
  801383:	74 0d                	je     801392 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801385:	ff 45 08             	incl   0x8(%ebp)
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80138e:	72 e3                	jb     801373 <memfind+0x13>
  801390:	eb 01                	jmp    801393 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801392:	90                   	nop
	return (void *) s;
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
  80139b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80139e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013a5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013ac:	eb 03                	jmp    8013b1 <strtol+0x19>
		s++;
  8013ae:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	3c 20                	cmp    $0x20,%al
  8013b8:	74 f4                	je     8013ae <strtol+0x16>
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	8a 00                	mov    (%eax),%al
  8013bf:	3c 09                	cmp    $0x9,%al
  8013c1:	74 eb                	je     8013ae <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	8a 00                	mov    (%eax),%al
  8013c8:	3c 2b                	cmp    $0x2b,%al
  8013ca:	75 05                	jne    8013d1 <strtol+0x39>
		s++;
  8013cc:	ff 45 08             	incl   0x8(%ebp)
  8013cf:	eb 13                	jmp    8013e4 <strtol+0x4c>
	else if (*s == '-')
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	3c 2d                	cmp    $0x2d,%al
  8013d8:	75 0a                	jne    8013e4 <strtol+0x4c>
		s++, neg = 1;
  8013da:	ff 45 08             	incl   0x8(%ebp)
  8013dd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e8:	74 06                	je     8013f0 <strtol+0x58>
  8013ea:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013ee:	75 20                	jne    801410 <strtol+0x78>
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	3c 30                	cmp    $0x30,%al
  8013f7:	75 17                	jne    801410 <strtol+0x78>
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	40                   	inc    %eax
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	3c 78                	cmp    $0x78,%al
  801401:	75 0d                	jne    801410 <strtol+0x78>
		s += 2, base = 16;
  801403:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801407:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80140e:	eb 28                	jmp    801438 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801410:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801414:	75 15                	jne    80142b <strtol+0x93>
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	3c 30                	cmp    $0x30,%al
  80141d:	75 0c                	jne    80142b <strtol+0x93>
		s++, base = 8;
  80141f:	ff 45 08             	incl   0x8(%ebp)
  801422:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801429:	eb 0d                	jmp    801438 <strtol+0xa0>
	else if (base == 0)
  80142b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142f:	75 07                	jne    801438 <strtol+0xa0>
		base = 10;
  801431:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	8a 00                	mov    (%eax),%al
  80143d:	3c 2f                	cmp    $0x2f,%al
  80143f:	7e 19                	jle    80145a <strtol+0xc2>
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	3c 39                	cmp    $0x39,%al
  801448:	7f 10                	jg     80145a <strtol+0xc2>
			dig = *s - '0';
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	8a 00                	mov    (%eax),%al
  80144f:	0f be c0             	movsbl %al,%eax
  801452:	83 e8 30             	sub    $0x30,%eax
  801455:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801458:	eb 42                	jmp    80149c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	8a 00                	mov    (%eax),%al
  80145f:	3c 60                	cmp    $0x60,%al
  801461:	7e 19                	jle    80147c <strtol+0xe4>
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	8a 00                	mov    (%eax),%al
  801468:	3c 7a                	cmp    $0x7a,%al
  80146a:	7f 10                	jg     80147c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	0f be c0             	movsbl %al,%eax
  801474:	83 e8 57             	sub    $0x57,%eax
  801477:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80147a:	eb 20                	jmp    80149c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	8a 00                	mov    (%eax),%al
  801481:	3c 40                	cmp    $0x40,%al
  801483:	7e 39                	jle    8014be <strtol+0x126>
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
  801488:	8a 00                	mov    (%eax),%al
  80148a:	3c 5a                	cmp    $0x5a,%al
  80148c:	7f 30                	jg     8014be <strtol+0x126>
			dig = *s - 'A' + 10;
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
  801491:	8a 00                	mov    (%eax),%al
  801493:	0f be c0             	movsbl %al,%eax
  801496:	83 e8 37             	sub    $0x37,%eax
  801499:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80149c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80149f:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014a2:	7d 19                	jge    8014bd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014a4:	ff 45 08             	incl   0x8(%ebp)
  8014a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014aa:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014ae:	89 c2                	mov    %eax,%edx
  8014b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014b3:	01 d0                	add    %edx,%eax
  8014b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014b8:	e9 7b ff ff ff       	jmp    801438 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014bd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014c2:	74 08                	je     8014cc <strtol+0x134>
		*endptr = (char *) s;
  8014c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c7:	8b 55 08             	mov    0x8(%ebp),%edx
  8014ca:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014d0:	74 07                	je     8014d9 <strtol+0x141>
  8014d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d5:	f7 d8                	neg    %eax
  8014d7:	eb 03                	jmp    8014dc <strtol+0x144>
  8014d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014dc:	c9                   	leave  
  8014dd:	c3                   	ret    

008014de <ltostr>:

void
ltostr(long value, char *str)
{
  8014de:	55                   	push   %ebp
  8014df:	89 e5                	mov    %esp,%ebp
  8014e1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014eb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014f2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014f6:	79 13                	jns    80150b <ltostr+0x2d>
	{
		neg = 1;
  8014f8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801502:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801505:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801508:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801513:	99                   	cltd   
  801514:	f7 f9                	idiv   %ecx
  801516:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801519:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151c:	8d 50 01             	lea    0x1(%eax),%edx
  80151f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801522:	89 c2                	mov    %eax,%edx
  801524:	8b 45 0c             	mov    0xc(%ebp),%eax
  801527:	01 d0                	add    %edx,%eax
  801529:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80152c:	83 c2 30             	add    $0x30,%edx
  80152f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801531:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801534:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801539:	f7 e9                	imul   %ecx
  80153b:	c1 fa 02             	sar    $0x2,%edx
  80153e:	89 c8                	mov    %ecx,%eax
  801540:	c1 f8 1f             	sar    $0x1f,%eax
  801543:	29 c2                	sub    %eax,%edx
  801545:	89 d0                	mov    %edx,%eax
  801547:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80154a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80154d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801552:	f7 e9                	imul   %ecx
  801554:	c1 fa 02             	sar    $0x2,%edx
  801557:	89 c8                	mov    %ecx,%eax
  801559:	c1 f8 1f             	sar    $0x1f,%eax
  80155c:	29 c2                	sub    %eax,%edx
  80155e:	89 d0                	mov    %edx,%eax
  801560:	c1 e0 02             	shl    $0x2,%eax
  801563:	01 d0                	add    %edx,%eax
  801565:	01 c0                	add    %eax,%eax
  801567:	29 c1                	sub    %eax,%ecx
  801569:	89 ca                	mov    %ecx,%edx
  80156b:	85 d2                	test   %edx,%edx
  80156d:	75 9c                	jne    80150b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80156f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801576:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801579:	48                   	dec    %eax
  80157a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80157d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801581:	74 3d                	je     8015c0 <ltostr+0xe2>
		start = 1 ;
  801583:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80158a:	eb 34                	jmp    8015c0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80158c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801592:	01 d0                	add    %edx,%eax
  801594:	8a 00                	mov    (%eax),%al
  801596:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801599:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80159c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159f:	01 c2                	add    %eax,%edx
  8015a1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a7:	01 c8                	add    %ecx,%eax
  8015a9:	8a 00                	mov    (%eax),%al
  8015ab:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015ad:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b3:	01 c2                	add    %eax,%edx
  8015b5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015b8:	88 02                	mov    %al,(%edx)
		start++ ;
  8015ba:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015bd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015c6:	7c c4                	jl     80158c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ce:	01 d0                	add    %edx,%eax
  8015d0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015d3:	90                   	nop
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
  8015d9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015dc:	ff 75 08             	pushl  0x8(%ebp)
  8015df:	e8 54 fa ff ff       	call   801038 <strlen>
  8015e4:	83 c4 04             	add    $0x4,%esp
  8015e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015ea:	ff 75 0c             	pushl  0xc(%ebp)
  8015ed:	e8 46 fa ff ff       	call   801038 <strlen>
  8015f2:	83 c4 04             	add    $0x4,%esp
  8015f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801606:	eb 17                	jmp    80161f <strcconcat+0x49>
		final[s] = str1[s] ;
  801608:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80160b:	8b 45 10             	mov    0x10(%ebp),%eax
  80160e:	01 c2                	add    %eax,%edx
  801610:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801613:	8b 45 08             	mov    0x8(%ebp),%eax
  801616:	01 c8                	add    %ecx,%eax
  801618:	8a 00                	mov    (%eax),%al
  80161a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80161c:	ff 45 fc             	incl   -0x4(%ebp)
  80161f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801622:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801625:	7c e1                	jl     801608 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801627:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80162e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801635:	eb 1f                	jmp    801656 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801637:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80163a:	8d 50 01             	lea    0x1(%eax),%edx
  80163d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801640:	89 c2                	mov    %eax,%edx
  801642:	8b 45 10             	mov    0x10(%ebp),%eax
  801645:	01 c2                	add    %eax,%edx
  801647:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80164a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164d:	01 c8                	add    %ecx,%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801653:	ff 45 f8             	incl   -0x8(%ebp)
  801656:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801659:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80165c:	7c d9                	jl     801637 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80165e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801661:	8b 45 10             	mov    0x10(%ebp),%eax
  801664:	01 d0                	add    %edx,%eax
  801666:	c6 00 00             	movb   $0x0,(%eax)
}
  801669:	90                   	nop
  80166a:	c9                   	leave  
  80166b:	c3                   	ret    

0080166c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80166c:	55                   	push   %ebp
  80166d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80166f:	8b 45 14             	mov    0x14(%ebp),%eax
  801672:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801678:	8b 45 14             	mov    0x14(%ebp),%eax
  80167b:	8b 00                	mov    (%eax),%eax
  80167d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801684:	8b 45 10             	mov    0x10(%ebp),%eax
  801687:	01 d0                	add    %edx,%eax
  801689:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80168f:	eb 0c                	jmp    80169d <strsplit+0x31>
			*string++ = 0;
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	8d 50 01             	lea    0x1(%eax),%edx
  801697:	89 55 08             	mov    %edx,0x8(%ebp)
  80169a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	84 c0                	test   %al,%al
  8016a4:	74 18                	je     8016be <strsplit+0x52>
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	8a 00                	mov    (%eax),%al
  8016ab:	0f be c0             	movsbl %al,%eax
  8016ae:	50                   	push   %eax
  8016af:	ff 75 0c             	pushl  0xc(%ebp)
  8016b2:	e8 13 fb ff ff       	call   8011ca <strchr>
  8016b7:	83 c4 08             	add    $0x8,%esp
  8016ba:	85 c0                	test   %eax,%eax
  8016bc:	75 d3                	jne    801691 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	8a 00                	mov    (%eax),%al
  8016c3:	84 c0                	test   %al,%al
  8016c5:	74 5a                	je     801721 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ca:	8b 00                	mov    (%eax),%eax
  8016cc:	83 f8 0f             	cmp    $0xf,%eax
  8016cf:	75 07                	jne    8016d8 <strsplit+0x6c>
		{
			return 0;
  8016d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8016d6:	eb 66                	jmp    80173e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8016db:	8b 00                	mov    (%eax),%eax
  8016dd:	8d 48 01             	lea    0x1(%eax),%ecx
  8016e0:	8b 55 14             	mov    0x14(%ebp),%edx
  8016e3:	89 0a                	mov    %ecx,(%edx)
  8016e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ef:	01 c2                	add    %eax,%edx
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016f6:	eb 03                	jmp    8016fb <strsplit+0x8f>
			string++;
  8016f8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	84 c0                	test   %al,%al
  801702:	74 8b                	je     80168f <strsplit+0x23>
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	8a 00                	mov    (%eax),%al
  801709:	0f be c0             	movsbl %al,%eax
  80170c:	50                   	push   %eax
  80170d:	ff 75 0c             	pushl  0xc(%ebp)
  801710:	e8 b5 fa ff ff       	call   8011ca <strchr>
  801715:	83 c4 08             	add    $0x8,%esp
  801718:	85 c0                	test   %eax,%eax
  80171a:	74 dc                	je     8016f8 <strsplit+0x8c>
			string++;
	}
  80171c:	e9 6e ff ff ff       	jmp    80168f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801721:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801722:	8b 45 14             	mov    0x14(%ebp),%eax
  801725:	8b 00                	mov    (%eax),%eax
  801727:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80172e:	8b 45 10             	mov    0x10(%ebp),%eax
  801731:	01 d0                	add    %edx,%eax
  801733:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801739:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
  801743:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	c1 e8 0c             	shr    $0xc,%eax
  80174c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	25 ff 0f 00 00       	and    $0xfff,%eax
  801757:	85 c0                	test   %eax,%eax
  801759:	74 03                	je     80175e <malloc+0x1e>
			num++;
  80175b:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80175e:	a1 04 30 80 00       	mov    0x803004,%eax
  801763:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801768:	75 73                	jne    8017dd <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80176a:	83 ec 08             	sub    $0x8,%esp
  80176d:	ff 75 08             	pushl  0x8(%ebp)
  801770:	68 00 00 00 80       	push   $0x80000000
  801775:	e8 14 05 00 00       	call   801c8e <sys_allocateMem>
  80177a:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80177d:	a1 04 30 80 00       	mov    0x803004,%eax
  801782:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801785:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801788:	c1 e0 0c             	shl    $0xc,%eax
  80178b:	89 c2                	mov    %eax,%edx
  80178d:	a1 04 30 80 00       	mov    0x803004,%eax
  801792:	01 d0                	add    %edx,%eax
  801794:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801799:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80179e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a1:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8017a8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017ad:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8017b3:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8017ba:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017bf:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8017c6:	01 00 00 00 
			sizeofarray++;
  8017ca:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017cf:	40                   	inc    %eax
  8017d0:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8017d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8017d8:	e9 71 01 00 00       	jmp    80194e <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8017dd:	a1 28 30 80 00       	mov    0x803028,%eax
  8017e2:	85 c0                	test   %eax,%eax
  8017e4:	75 71                	jne    801857 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8017e6:	a1 04 30 80 00       	mov    0x803004,%eax
  8017eb:	83 ec 08             	sub    $0x8,%esp
  8017ee:	ff 75 08             	pushl  0x8(%ebp)
  8017f1:	50                   	push   %eax
  8017f2:	e8 97 04 00 00       	call   801c8e <sys_allocateMem>
  8017f7:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8017fa:	a1 04 30 80 00       	mov    0x803004,%eax
  8017ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801802:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801805:	c1 e0 0c             	shl    $0xc,%eax
  801808:	89 c2                	mov    %eax,%edx
  80180a:	a1 04 30 80 00       	mov    0x803004,%eax
  80180f:	01 d0                	add    %edx,%eax
  801811:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801816:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80181b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80181e:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801825:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80182a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80182d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801834:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801839:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801840:	01 00 00 00 
				sizeofarray++;
  801844:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801849:	40                   	inc    %eax
  80184a:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80184f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801852:	e9 f7 00 00 00       	jmp    80194e <malloc+0x20e>
			}
			else{
				int count=0;
  801857:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80185e:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801865:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80186c:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801873:	eb 7c                	jmp    8018f1 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801875:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  80187c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801883:	eb 1a                	jmp    80189f <malloc+0x15f>
					{
						if(addresses[j]==i)
  801885:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801888:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80188f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801892:	75 08                	jne    80189c <malloc+0x15c>
						{
							index=j;
  801894:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801897:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80189a:	eb 0d                	jmp    8018a9 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80189c:	ff 45 dc             	incl   -0x24(%ebp)
  80189f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018a4:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8018a7:	7c dc                	jl     801885 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8018a9:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8018ad:	75 05                	jne    8018b4 <malloc+0x174>
					{
						count++;
  8018af:	ff 45 f0             	incl   -0x10(%ebp)
  8018b2:	eb 36                	jmp    8018ea <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8018b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018b7:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  8018be:	85 c0                	test   %eax,%eax
  8018c0:	75 05                	jne    8018c7 <malloc+0x187>
						{
							count++;
  8018c2:	ff 45 f0             	incl   -0x10(%ebp)
  8018c5:	eb 23                	jmp    8018ea <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8018c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018ca:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8018cd:	7d 14                	jge    8018e3 <malloc+0x1a3>
  8018cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018d5:	7c 0c                	jl     8018e3 <malloc+0x1a3>
							{
								min=count;
  8018d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018da:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8018dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8018e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8018ea:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8018f1:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8018f8:	0f 86 77 ff ff ff    	jbe    801875 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8018fe:	83 ec 08             	sub    $0x8,%esp
  801901:	ff 75 08             	pushl  0x8(%ebp)
  801904:	ff 75 e4             	pushl  -0x1c(%ebp)
  801907:	e8 82 03 00 00       	call   801c8e <sys_allocateMem>
  80190c:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  80190f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801914:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801917:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  80191e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801923:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801929:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801930:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801935:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80193c:	01 00 00 00 
				sizeofarray++;
  801940:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801945:	40                   	inc    %eax
  801946:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  80194b:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80194e:	c9                   	leave  
  80194f:	c3                   	ret    

00801950 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801950:	55                   	push   %ebp
  801951:	89 e5                	mov    %esp,%ebp
  801953:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
  801959:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  80195c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801963:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80196a:	eb 30                	jmp    80199c <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  80196c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80196f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801976:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801979:	75 1e                	jne    801999 <free+0x49>
  80197b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80197e:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801985:	83 f8 01             	cmp    $0x1,%eax
  801988:	75 0f                	jne    801999 <free+0x49>
    		is_found=1;
  80198a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801991:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801994:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801997:	eb 0d                	jmp    8019a6 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801999:	ff 45 ec             	incl   -0x14(%ebp)
  80199c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019a1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8019a4:	7c c6                	jl     80196c <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  8019a6:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8019aa:	75 3b                	jne    8019e7 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  8019ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019af:	8b 04 85 60 50 80 00 	mov    0x805060(,%eax,4),%eax
  8019b6:	c1 e0 0c             	shl    $0xc,%eax
  8019b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  8019bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019bf:	83 ec 08             	sub    $0x8,%esp
  8019c2:	50                   	push   %eax
  8019c3:	ff 75 e8             	pushl  -0x18(%ebp)
  8019c6:	e8 a7 02 00 00       	call   801c72 <sys_freeMem>
  8019cb:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  8019ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019d1:	c7 04 85 c0 40 80 00 	movl   $0x0,0x8040c0(,%eax,4)
  8019d8:	00 00 00 00 
    	changes++;
  8019dc:	a1 28 30 80 00       	mov    0x803028,%eax
  8019e1:	40                   	inc    %eax
  8019e2:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  8019e7:	90                   	nop
  8019e8:	c9                   	leave  
  8019e9:	c3                   	ret    

008019ea <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019ea:	55                   	push   %ebp
  8019eb:	89 e5                	mov    %esp,%ebp
  8019ed:	83 ec 18             	sub    $0x18,%esp
  8019f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f3:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8019f6:	83 ec 04             	sub    $0x4,%esp
  8019f9:	68 50 2a 80 00       	push   $0x802a50
  8019fe:	68 9f 00 00 00       	push   $0x9f
  801a03:	68 73 2a 80 00       	push   $0x802a73
  801a08:	e8 07 ed ff ff       	call   800714 <_panic>

00801a0d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
  801a10:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a13:	83 ec 04             	sub    $0x4,%esp
  801a16:	68 50 2a 80 00       	push   $0x802a50
  801a1b:	68 a5 00 00 00       	push   $0xa5
  801a20:	68 73 2a 80 00       	push   $0x802a73
  801a25:	e8 ea ec ff ff       	call   800714 <_panic>

00801a2a <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a30:	83 ec 04             	sub    $0x4,%esp
  801a33:	68 50 2a 80 00       	push   $0x802a50
  801a38:	68 ab 00 00 00       	push   $0xab
  801a3d:	68 73 2a 80 00       	push   $0x802a73
  801a42:	e8 cd ec ff ff       	call   800714 <_panic>

00801a47 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
  801a4a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a4d:	83 ec 04             	sub    $0x4,%esp
  801a50:	68 50 2a 80 00       	push   $0x802a50
  801a55:	68 b0 00 00 00       	push   $0xb0
  801a5a:	68 73 2a 80 00       	push   $0x802a73
  801a5f:	e8 b0 ec ff ff       	call   800714 <_panic>

00801a64 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
  801a67:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a6a:	83 ec 04             	sub    $0x4,%esp
  801a6d:	68 50 2a 80 00       	push   $0x802a50
  801a72:	68 b6 00 00 00       	push   $0xb6
  801a77:	68 73 2a 80 00       	push   $0x802a73
  801a7c:	e8 93 ec ff ff       	call   800714 <_panic>

00801a81 <shrink>:
}
void shrink(uint32 newSize)
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
  801a84:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a87:	83 ec 04             	sub    $0x4,%esp
  801a8a:	68 50 2a 80 00       	push   $0x802a50
  801a8f:	68 ba 00 00 00       	push   $0xba
  801a94:	68 73 2a 80 00       	push   $0x802a73
  801a99:	e8 76 ec ff ff       	call   800714 <_panic>

00801a9e <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
  801aa1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aa4:	83 ec 04             	sub    $0x4,%esp
  801aa7:	68 50 2a 80 00       	push   $0x802a50
  801aac:	68 bf 00 00 00       	push   $0xbf
  801ab1:	68 73 2a 80 00       	push   $0x802a73
  801ab6:	e8 59 ec ff ff       	call   800714 <_panic>

00801abb <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
  801abe:	57                   	push   %edi
  801abf:	56                   	push   %esi
  801ac0:	53                   	push   %ebx
  801ac1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801acd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ad0:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ad3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ad6:	cd 30                	int    $0x30
  801ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ade:	83 c4 10             	add    $0x10,%esp
  801ae1:	5b                   	pop    %ebx
  801ae2:	5e                   	pop    %esi
  801ae3:	5f                   	pop    %edi
  801ae4:	5d                   	pop    %ebp
  801ae5:	c3                   	ret    

00801ae6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ae6:	55                   	push   %ebp
  801ae7:	89 e5                	mov    %esp,%ebp
  801ae9:	83 ec 04             	sub    $0x4,%esp
  801aec:	8b 45 10             	mov    0x10(%ebp),%eax
  801aef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801af2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801af6:	8b 45 08             	mov    0x8(%ebp),%eax
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	52                   	push   %edx
  801afe:	ff 75 0c             	pushl  0xc(%ebp)
  801b01:	50                   	push   %eax
  801b02:	6a 00                	push   $0x0
  801b04:	e8 b2 ff ff ff       	call   801abb <syscall>
  801b09:	83 c4 18             	add    $0x18,%esp
}
  801b0c:	90                   	nop
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <sys_cgetc>:

int
sys_cgetc(void)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 01                	push   $0x1
  801b1e:	e8 98 ff ff ff       	call   801abb <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	50                   	push   %eax
  801b37:	6a 05                	push   $0x5
  801b39:	e8 7d ff ff ff       	call   801abb <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
}
  801b41:	c9                   	leave  
  801b42:	c3                   	ret    

00801b43 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 02                	push   $0x2
  801b52:	e8 64 ff ff ff       	call   801abb <syscall>
  801b57:	83 c4 18             	add    $0x18,%esp
}
  801b5a:	c9                   	leave  
  801b5b:	c3                   	ret    

00801b5c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b5c:	55                   	push   %ebp
  801b5d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 03                	push   $0x3
  801b6b:	e8 4b ff ff ff       	call   801abb <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 04                	push   $0x4
  801b84:	e8 32 ff ff ff       	call   801abb <syscall>
  801b89:	83 c4 18             	add    $0x18,%esp
}
  801b8c:	c9                   	leave  
  801b8d:	c3                   	ret    

00801b8e <sys_env_exit>:


void sys_env_exit(void)
{
  801b8e:	55                   	push   %ebp
  801b8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 06                	push   $0x6
  801b9d:	e8 19 ff ff ff       	call   801abb <syscall>
  801ba2:	83 c4 18             	add    $0x18,%esp
}
  801ba5:	90                   	nop
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bab:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bae:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	52                   	push   %edx
  801bb8:	50                   	push   %eax
  801bb9:	6a 07                	push   $0x7
  801bbb:	e8 fb fe ff ff       	call   801abb <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
  801bc8:	56                   	push   %esi
  801bc9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bca:	8b 75 18             	mov    0x18(%ebp),%esi
  801bcd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bd0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd9:	56                   	push   %esi
  801bda:	53                   	push   %ebx
  801bdb:	51                   	push   %ecx
  801bdc:	52                   	push   %edx
  801bdd:	50                   	push   %eax
  801bde:	6a 08                	push   $0x8
  801be0:	e8 d6 fe ff ff       	call   801abb <syscall>
  801be5:	83 c4 18             	add    $0x18,%esp
}
  801be8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801beb:	5b                   	pop    %ebx
  801bec:	5e                   	pop    %esi
  801bed:	5d                   	pop    %ebp
  801bee:	c3                   	ret    

00801bef <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bf2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	52                   	push   %edx
  801bff:	50                   	push   %eax
  801c00:	6a 09                	push   $0x9
  801c02:	e8 b4 fe ff ff       	call   801abb <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	ff 75 0c             	pushl  0xc(%ebp)
  801c18:	ff 75 08             	pushl  0x8(%ebp)
  801c1b:	6a 0a                	push   $0xa
  801c1d:	e8 99 fe ff ff       	call   801abb <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
}
  801c25:	c9                   	leave  
  801c26:	c3                   	ret    

00801c27 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c27:	55                   	push   %ebp
  801c28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 0b                	push   $0xb
  801c36:	e8 80 fe ff ff       	call   801abb <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
}
  801c3e:	c9                   	leave  
  801c3f:	c3                   	ret    

00801c40 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 0c                	push   $0xc
  801c4f:	e8 67 fe ff ff       	call   801abb <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
}
  801c57:	c9                   	leave  
  801c58:	c3                   	ret    

00801c59 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 0d                	push   $0xd
  801c68:	e8 4e fe ff ff       	call   801abb <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
}
  801c70:	c9                   	leave  
  801c71:	c3                   	ret    

00801c72 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	ff 75 0c             	pushl  0xc(%ebp)
  801c7e:	ff 75 08             	pushl  0x8(%ebp)
  801c81:	6a 11                	push   $0x11
  801c83:	e8 33 fe ff ff       	call   801abb <syscall>
  801c88:	83 c4 18             	add    $0x18,%esp
	return;
  801c8b:	90                   	nop
}
  801c8c:	c9                   	leave  
  801c8d:	c3                   	ret    

00801c8e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	ff 75 0c             	pushl  0xc(%ebp)
  801c9a:	ff 75 08             	pushl  0x8(%ebp)
  801c9d:	6a 12                	push   $0x12
  801c9f:	e8 17 fe ff ff       	call   801abb <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ca7:	90                   	nop
}
  801ca8:	c9                   	leave  
  801ca9:	c3                   	ret    

00801caa <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801caa:	55                   	push   %ebp
  801cab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 0e                	push   $0xe
  801cb9:	e8 fd fd ff ff       	call   801abb <syscall>
  801cbe:	83 c4 18             	add    $0x18,%esp
}
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	ff 75 08             	pushl  0x8(%ebp)
  801cd1:	6a 0f                	push   $0xf
  801cd3:	e8 e3 fd ff ff       	call   801abb <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 10                	push   $0x10
  801cec:	e8 ca fd ff ff       	call   801abb <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
}
  801cf4:	90                   	nop
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 14                	push   $0x14
  801d06:	e8 b0 fd ff ff       	call   801abb <syscall>
  801d0b:	83 c4 18             	add    $0x18,%esp
}
  801d0e:	90                   	nop
  801d0f:	c9                   	leave  
  801d10:	c3                   	ret    

00801d11 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d11:	55                   	push   %ebp
  801d12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 15                	push   $0x15
  801d20:	e8 96 fd ff ff       	call   801abb <syscall>
  801d25:	83 c4 18             	add    $0x18,%esp
}
  801d28:	90                   	nop
  801d29:	c9                   	leave  
  801d2a:	c3                   	ret    

00801d2b <sys_cputc>:


void
sys_cputc(const char c)
{
  801d2b:	55                   	push   %ebp
  801d2c:	89 e5                	mov    %esp,%ebp
  801d2e:	83 ec 04             	sub    $0x4,%esp
  801d31:	8b 45 08             	mov    0x8(%ebp),%eax
  801d34:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d37:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	50                   	push   %eax
  801d44:	6a 16                	push   $0x16
  801d46:	e8 70 fd ff ff       	call   801abb <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
}
  801d4e:	90                   	nop
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 17                	push   $0x17
  801d60:	e8 56 fd ff ff       	call   801abb <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
}
  801d68:	90                   	nop
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	ff 75 0c             	pushl  0xc(%ebp)
  801d7a:	50                   	push   %eax
  801d7b:	6a 18                	push   $0x18
  801d7d:	e8 39 fd ff ff       	call   801abb <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	52                   	push   %edx
  801d97:	50                   	push   %eax
  801d98:	6a 1b                	push   $0x1b
  801d9a:	e8 1c fd ff ff       	call   801abb <syscall>
  801d9f:	83 c4 18             	add    $0x18,%esp
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801da7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	52                   	push   %edx
  801db4:	50                   	push   %eax
  801db5:	6a 19                	push   $0x19
  801db7:	e8 ff fc ff ff       	call   801abb <syscall>
  801dbc:	83 c4 18             	add    $0x18,%esp
}
  801dbf:	90                   	nop
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	52                   	push   %edx
  801dd2:	50                   	push   %eax
  801dd3:	6a 1a                	push   $0x1a
  801dd5:	e8 e1 fc ff ff       	call   801abb <syscall>
  801dda:	83 c4 18             	add    $0x18,%esp
}
  801ddd:	90                   	nop
  801dde:	c9                   	leave  
  801ddf:	c3                   	ret    

00801de0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801de0:	55                   	push   %ebp
  801de1:	89 e5                	mov    %esp,%ebp
  801de3:	83 ec 04             	sub    $0x4,%esp
  801de6:	8b 45 10             	mov    0x10(%ebp),%eax
  801de9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801dec:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801def:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801df3:	8b 45 08             	mov    0x8(%ebp),%eax
  801df6:	6a 00                	push   $0x0
  801df8:	51                   	push   %ecx
  801df9:	52                   	push   %edx
  801dfa:	ff 75 0c             	pushl  0xc(%ebp)
  801dfd:	50                   	push   %eax
  801dfe:	6a 1c                	push   $0x1c
  801e00:	e8 b6 fc ff ff       	call   801abb <syscall>
  801e05:	83 c4 18             	add    $0x18,%esp
}
  801e08:	c9                   	leave  
  801e09:	c3                   	ret    

00801e0a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e0a:	55                   	push   %ebp
  801e0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	52                   	push   %edx
  801e1a:	50                   	push   %eax
  801e1b:	6a 1d                	push   $0x1d
  801e1d:	e8 99 fc ff ff       	call   801abb <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
}
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e2a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e30:	8b 45 08             	mov    0x8(%ebp),%eax
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	51                   	push   %ecx
  801e38:	52                   	push   %edx
  801e39:	50                   	push   %eax
  801e3a:	6a 1e                	push   $0x1e
  801e3c:	e8 7a fc ff ff       	call   801abb <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e49:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	52                   	push   %edx
  801e56:	50                   	push   %eax
  801e57:	6a 1f                	push   $0x1f
  801e59:	e8 5d fc ff ff       	call   801abb <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 20                	push   $0x20
  801e72:	e8 44 fc ff ff       	call   801abb <syscall>
  801e77:	83 c4 18             	add    $0x18,%esp
}
  801e7a:	c9                   	leave  
  801e7b:	c3                   	ret    

00801e7c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e7c:	55                   	push   %ebp
  801e7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e82:	6a 00                	push   $0x0
  801e84:	ff 75 14             	pushl  0x14(%ebp)
  801e87:	ff 75 10             	pushl  0x10(%ebp)
  801e8a:	ff 75 0c             	pushl  0xc(%ebp)
  801e8d:	50                   	push   %eax
  801e8e:	6a 21                	push   $0x21
  801e90:	e8 26 fc ff ff       	call   801abb <syscall>
  801e95:	83 c4 18             	add    $0x18,%esp
}
  801e98:	c9                   	leave  
  801e99:	c3                   	ret    

00801e9a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e9a:	55                   	push   %ebp
  801e9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	50                   	push   %eax
  801ea9:	6a 22                	push   $0x22
  801eab:	e8 0b fc ff ff       	call   801abb <syscall>
  801eb0:	83 c4 18             	add    $0x18,%esp
}
  801eb3:	90                   	nop
  801eb4:	c9                   	leave  
  801eb5:	c3                   	ret    

00801eb6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801eb6:	55                   	push   %ebp
  801eb7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	50                   	push   %eax
  801ec5:	6a 23                	push   $0x23
  801ec7:	e8 ef fb ff ff       	call   801abb <syscall>
  801ecc:	83 c4 18             	add    $0x18,%esp
}
  801ecf:	90                   	nop
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
  801ed5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ed8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801edb:	8d 50 04             	lea    0x4(%eax),%edx
  801ede:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	52                   	push   %edx
  801ee8:	50                   	push   %eax
  801ee9:	6a 24                	push   $0x24
  801eeb:	e8 cb fb ff ff       	call   801abb <syscall>
  801ef0:	83 c4 18             	add    $0x18,%esp
	return result;
  801ef3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ef6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ef9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801efc:	89 01                	mov    %eax,(%ecx)
  801efe:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f01:	8b 45 08             	mov    0x8(%ebp),%eax
  801f04:	c9                   	leave  
  801f05:	c2 04 00             	ret    $0x4

00801f08 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f08:	55                   	push   %ebp
  801f09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	ff 75 10             	pushl  0x10(%ebp)
  801f12:	ff 75 0c             	pushl  0xc(%ebp)
  801f15:	ff 75 08             	pushl  0x8(%ebp)
  801f18:	6a 13                	push   $0x13
  801f1a:	e8 9c fb ff ff       	call   801abb <syscall>
  801f1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801f22:	90                   	nop
}
  801f23:	c9                   	leave  
  801f24:	c3                   	ret    

00801f25 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f25:	55                   	push   %ebp
  801f26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 25                	push   $0x25
  801f34:	e8 82 fb ff ff       	call   801abb <syscall>
  801f39:	83 c4 18             	add    $0x18,%esp
}
  801f3c:	c9                   	leave  
  801f3d:	c3                   	ret    

00801f3e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f3e:	55                   	push   %ebp
  801f3f:	89 e5                	mov    %esp,%ebp
  801f41:	83 ec 04             	sub    $0x4,%esp
  801f44:	8b 45 08             	mov    0x8(%ebp),%eax
  801f47:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f4a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	50                   	push   %eax
  801f57:	6a 26                	push   $0x26
  801f59:	e8 5d fb ff ff       	call   801abb <syscall>
  801f5e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f61:	90                   	nop
}
  801f62:	c9                   	leave  
  801f63:	c3                   	ret    

00801f64 <rsttst>:
void rsttst()
{
  801f64:	55                   	push   %ebp
  801f65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 28                	push   $0x28
  801f73:	e8 43 fb ff ff       	call   801abb <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
	return ;
  801f7b:	90                   	nop
}
  801f7c:	c9                   	leave  
  801f7d:	c3                   	ret    

00801f7e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f7e:	55                   	push   %ebp
  801f7f:	89 e5                	mov    %esp,%ebp
  801f81:	83 ec 04             	sub    $0x4,%esp
  801f84:	8b 45 14             	mov    0x14(%ebp),%eax
  801f87:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f8a:	8b 55 18             	mov    0x18(%ebp),%edx
  801f8d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f91:	52                   	push   %edx
  801f92:	50                   	push   %eax
  801f93:	ff 75 10             	pushl  0x10(%ebp)
  801f96:	ff 75 0c             	pushl  0xc(%ebp)
  801f99:	ff 75 08             	pushl  0x8(%ebp)
  801f9c:	6a 27                	push   $0x27
  801f9e:	e8 18 fb ff ff       	call   801abb <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa6:	90                   	nop
}
  801fa7:	c9                   	leave  
  801fa8:	c3                   	ret    

00801fa9 <chktst>:
void chktst(uint32 n)
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	ff 75 08             	pushl  0x8(%ebp)
  801fb7:	6a 29                	push   $0x29
  801fb9:	e8 fd fa ff ff       	call   801abb <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc1:	90                   	nop
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <inctst>:

void inctst()
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 2a                	push   $0x2a
  801fd3:	e8 e3 fa ff ff       	call   801abb <syscall>
  801fd8:	83 c4 18             	add    $0x18,%esp
	return ;
  801fdb:	90                   	nop
}
  801fdc:	c9                   	leave  
  801fdd:	c3                   	ret    

00801fde <gettst>:
uint32 gettst()
{
  801fde:	55                   	push   %ebp
  801fdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 2b                	push   $0x2b
  801fed:	e8 c9 fa ff ff       	call   801abb <syscall>
  801ff2:	83 c4 18             	add    $0x18,%esp
}
  801ff5:	c9                   	leave  
  801ff6:	c3                   	ret    

00801ff7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ff7:	55                   	push   %ebp
  801ff8:	89 e5                	mov    %esp,%ebp
  801ffa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 2c                	push   $0x2c
  802009:	e8 ad fa ff ff       	call   801abb <syscall>
  80200e:	83 c4 18             	add    $0x18,%esp
  802011:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802014:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802018:	75 07                	jne    802021 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80201a:	b8 01 00 00 00       	mov    $0x1,%eax
  80201f:	eb 05                	jmp    802026 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802021:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802026:	c9                   	leave  
  802027:	c3                   	ret    

00802028 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802028:	55                   	push   %ebp
  802029:	89 e5                	mov    %esp,%ebp
  80202b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 2c                	push   $0x2c
  80203a:	e8 7c fa ff ff       	call   801abb <syscall>
  80203f:	83 c4 18             	add    $0x18,%esp
  802042:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802045:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802049:	75 07                	jne    802052 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80204b:	b8 01 00 00 00       	mov    $0x1,%eax
  802050:	eb 05                	jmp    802057 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802052:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802057:	c9                   	leave  
  802058:	c3                   	ret    

00802059 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
  80205c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 2c                	push   $0x2c
  80206b:	e8 4b fa ff ff       	call   801abb <syscall>
  802070:	83 c4 18             	add    $0x18,%esp
  802073:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802076:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80207a:	75 07                	jne    802083 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80207c:	b8 01 00 00 00       	mov    $0x1,%eax
  802081:	eb 05                	jmp    802088 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802083:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802088:	c9                   	leave  
  802089:	c3                   	ret    

0080208a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80208a:	55                   	push   %ebp
  80208b:	89 e5                	mov    %esp,%ebp
  80208d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 00                	push   $0x0
  80209a:	6a 2c                	push   $0x2c
  80209c:	e8 1a fa ff ff       	call   801abb <syscall>
  8020a1:	83 c4 18             	add    $0x18,%esp
  8020a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020a7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020ab:	75 07                	jne    8020b4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8020b2:	eb 05                	jmp    8020b9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020b9:	c9                   	leave  
  8020ba:	c3                   	ret    

008020bb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020bb:	55                   	push   %ebp
  8020bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	ff 75 08             	pushl  0x8(%ebp)
  8020c9:	6a 2d                	push   $0x2d
  8020cb:	e8 eb f9 ff ff       	call   801abb <syscall>
  8020d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d3:	90                   	nop
}
  8020d4:	c9                   	leave  
  8020d5:	c3                   	ret    

008020d6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020d6:	55                   	push   %ebp
  8020d7:	89 e5                	mov    %esp,%ebp
  8020d9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e6:	6a 00                	push   $0x0
  8020e8:	53                   	push   %ebx
  8020e9:	51                   	push   %ecx
  8020ea:	52                   	push   %edx
  8020eb:	50                   	push   %eax
  8020ec:	6a 2e                	push   $0x2e
  8020ee:	e8 c8 f9 ff ff       	call   801abb <syscall>
  8020f3:	83 c4 18             	add    $0x18,%esp
}
  8020f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8020f9:	c9                   	leave  
  8020fa:	c3                   	ret    

008020fb <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8020fb:	55                   	push   %ebp
  8020fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8020fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802101:	8b 45 08             	mov    0x8(%ebp),%eax
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	52                   	push   %edx
  80210b:	50                   	push   %eax
  80210c:	6a 2f                	push   $0x2f
  80210e:	e8 a8 f9 ff ff       	call   801abb <syscall>
  802113:	83 c4 18             	add    $0x18,%esp
}
  802116:	c9                   	leave  
  802117:	c3                   	ret    

00802118 <__udivdi3>:
  802118:	55                   	push   %ebp
  802119:	57                   	push   %edi
  80211a:	56                   	push   %esi
  80211b:	53                   	push   %ebx
  80211c:	83 ec 1c             	sub    $0x1c,%esp
  80211f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802123:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802127:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80212b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80212f:	89 ca                	mov    %ecx,%edx
  802131:	89 f8                	mov    %edi,%eax
  802133:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802137:	85 f6                	test   %esi,%esi
  802139:	75 2d                	jne    802168 <__udivdi3+0x50>
  80213b:	39 cf                	cmp    %ecx,%edi
  80213d:	77 65                	ja     8021a4 <__udivdi3+0x8c>
  80213f:	89 fd                	mov    %edi,%ebp
  802141:	85 ff                	test   %edi,%edi
  802143:	75 0b                	jne    802150 <__udivdi3+0x38>
  802145:	b8 01 00 00 00       	mov    $0x1,%eax
  80214a:	31 d2                	xor    %edx,%edx
  80214c:	f7 f7                	div    %edi
  80214e:	89 c5                	mov    %eax,%ebp
  802150:	31 d2                	xor    %edx,%edx
  802152:	89 c8                	mov    %ecx,%eax
  802154:	f7 f5                	div    %ebp
  802156:	89 c1                	mov    %eax,%ecx
  802158:	89 d8                	mov    %ebx,%eax
  80215a:	f7 f5                	div    %ebp
  80215c:	89 cf                	mov    %ecx,%edi
  80215e:	89 fa                	mov    %edi,%edx
  802160:	83 c4 1c             	add    $0x1c,%esp
  802163:	5b                   	pop    %ebx
  802164:	5e                   	pop    %esi
  802165:	5f                   	pop    %edi
  802166:	5d                   	pop    %ebp
  802167:	c3                   	ret    
  802168:	39 ce                	cmp    %ecx,%esi
  80216a:	77 28                	ja     802194 <__udivdi3+0x7c>
  80216c:	0f bd fe             	bsr    %esi,%edi
  80216f:	83 f7 1f             	xor    $0x1f,%edi
  802172:	75 40                	jne    8021b4 <__udivdi3+0x9c>
  802174:	39 ce                	cmp    %ecx,%esi
  802176:	72 0a                	jb     802182 <__udivdi3+0x6a>
  802178:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80217c:	0f 87 9e 00 00 00    	ja     802220 <__udivdi3+0x108>
  802182:	b8 01 00 00 00       	mov    $0x1,%eax
  802187:	89 fa                	mov    %edi,%edx
  802189:	83 c4 1c             	add    $0x1c,%esp
  80218c:	5b                   	pop    %ebx
  80218d:	5e                   	pop    %esi
  80218e:	5f                   	pop    %edi
  80218f:	5d                   	pop    %ebp
  802190:	c3                   	ret    
  802191:	8d 76 00             	lea    0x0(%esi),%esi
  802194:	31 ff                	xor    %edi,%edi
  802196:	31 c0                	xor    %eax,%eax
  802198:	89 fa                	mov    %edi,%edx
  80219a:	83 c4 1c             	add    $0x1c,%esp
  80219d:	5b                   	pop    %ebx
  80219e:	5e                   	pop    %esi
  80219f:	5f                   	pop    %edi
  8021a0:	5d                   	pop    %ebp
  8021a1:	c3                   	ret    
  8021a2:	66 90                	xchg   %ax,%ax
  8021a4:	89 d8                	mov    %ebx,%eax
  8021a6:	f7 f7                	div    %edi
  8021a8:	31 ff                	xor    %edi,%edi
  8021aa:	89 fa                	mov    %edi,%edx
  8021ac:	83 c4 1c             	add    $0x1c,%esp
  8021af:	5b                   	pop    %ebx
  8021b0:	5e                   	pop    %esi
  8021b1:	5f                   	pop    %edi
  8021b2:	5d                   	pop    %ebp
  8021b3:	c3                   	ret    
  8021b4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021b9:	89 eb                	mov    %ebp,%ebx
  8021bb:	29 fb                	sub    %edi,%ebx
  8021bd:	89 f9                	mov    %edi,%ecx
  8021bf:	d3 e6                	shl    %cl,%esi
  8021c1:	89 c5                	mov    %eax,%ebp
  8021c3:	88 d9                	mov    %bl,%cl
  8021c5:	d3 ed                	shr    %cl,%ebp
  8021c7:	89 e9                	mov    %ebp,%ecx
  8021c9:	09 f1                	or     %esi,%ecx
  8021cb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021cf:	89 f9                	mov    %edi,%ecx
  8021d1:	d3 e0                	shl    %cl,%eax
  8021d3:	89 c5                	mov    %eax,%ebp
  8021d5:	89 d6                	mov    %edx,%esi
  8021d7:	88 d9                	mov    %bl,%cl
  8021d9:	d3 ee                	shr    %cl,%esi
  8021db:	89 f9                	mov    %edi,%ecx
  8021dd:	d3 e2                	shl    %cl,%edx
  8021df:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e3:	88 d9                	mov    %bl,%cl
  8021e5:	d3 e8                	shr    %cl,%eax
  8021e7:	09 c2                	or     %eax,%edx
  8021e9:	89 d0                	mov    %edx,%eax
  8021eb:	89 f2                	mov    %esi,%edx
  8021ed:	f7 74 24 0c          	divl   0xc(%esp)
  8021f1:	89 d6                	mov    %edx,%esi
  8021f3:	89 c3                	mov    %eax,%ebx
  8021f5:	f7 e5                	mul    %ebp
  8021f7:	39 d6                	cmp    %edx,%esi
  8021f9:	72 19                	jb     802214 <__udivdi3+0xfc>
  8021fb:	74 0b                	je     802208 <__udivdi3+0xf0>
  8021fd:	89 d8                	mov    %ebx,%eax
  8021ff:	31 ff                	xor    %edi,%edi
  802201:	e9 58 ff ff ff       	jmp    80215e <__udivdi3+0x46>
  802206:	66 90                	xchg   %ax,%ax
  802208:	8b 54 24 08          	mov    0x8(%esp),%edx
  80220c:	89 f9                	mov    %edi,%ecx
  80220e:	d3 e2                	shl    %cl,%edx
  802210:	39 c2                	cmp    %eax,%edx
  802212:	73 e9                	jae    8021fd <__udivdi3+0xe5>
  802214:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802217:	31 ff                	xor    %edi,%edi
  802219:	e9 40 ff ff ff       	jmp    80215e <__udivdi3+0x46>
  80221e:	66 90                	xchg   %ax,%ax
  802220:	31 c0                	xor    %eax,%eax
  802222:	e9 37 ff ff ff       	jmp    80215e <__udivdi3+0x46>
  802227:	90                   	nop

00802228 <__umoddi3>:
  802228:	55                   	push   %ebp
  802229:	57                   	push   %edi
  80222a:	56                   	push   %esi
  80222b:	53                   	push   %ebx
  80222c:	83 ec 1c             	sub    $0x1c,%esp
  80222f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802233:	8b 74 24 34          	mov    0x34(%esp),%esi
  802237:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80223b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80223f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802243:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802247:	89 f3                	mov    %esi,%ebx
  802249:	89 fa                	mov    %edi,%edx
  80224b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80224f:	89 34 24             	mov    %esi,(%esp)
  802252:	85 c0                	test   %eax,%eax
  802254:	75 1a                	jne    802270 <__umoddi3+0x48>
  802256:	39 f7                	cmp    %esi,%edi
  802258:	0f 86 a2 00 00 00    	jbe    802300 <__umoddi3+0xd8>
  80225e:	89 c8                	mov    %ecx,%eax
  802260:	89 f2                	mov    %esi,%edx
  802262:	f7 f7                	div    %edi
  802264:	89 d0                	mov    %edx,%eax
  802266:	31 d2                	xor    %edx,%edx
  802268:	83 c4 1c             	add    $0x1c,%esp
  80226b:	5b                   	pop    %ebx
  80226c:	5e                   	pop    %esi
  80226d:	5f                   	pop    %edi
  80226e:	5d                   	pop    %ebp
  80226f:	c3                   	ret    
  802270:	39 f0                	cmp    %esi,%eax
  802272:	0f 87 ac 00 00 00    	ja     802324 <__umoddi3+0xfc>
  802278:	0f bd e8             	bsr    %eax,%ebp
  80227b:	83 f5 1f             	xor    $0x1f,%ebp
  80227e:	0f 84 ac 00 00 00    	je     802330 <__umoddi3+0x108>
  802284:	bf 20 00 00 00       	mov    $0x20,%edi
  802289:	29 ef                	sub    %ebp,%edi
  80228b:	89 fe                	mov    %edi,%esi
  80228d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802291:	89 e9                	mov    %ebp,%ecx
  802293:	d3 e0                	shl    %cl,%eax
  802295:	89 d7                	mov    %edx,%edi
  802297:	89 f1                	mov    %esi,%ecx
  802299:	d3 ef                	shr    %cl,%edi
  80229b:	09 c7                	or     %eax,%edi
  80229d:	89 e9                	mov    %ebp,%ecx
  80229f:	d3 e2                	shl    %cl,%edx
  8022a1:	89 14 24             	mov    %edx,(%esp)
  8022a4:	89 d8                	mov    %ebx,%eax
  8022a6:	d3 e0                	shl    %cl,%eax
  8022a8:	89 c2                	mov    %eax,%edx
  8022aa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ae:	d3 e0                	shl    %cl,%eax
  8022b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022b4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022b8:	89 f1                	mov    %esi,%ecx
  8022ba:	d3 e8                	shr    %cl,%eax
  8022bc:	09 d0                	or     %edx,%eax
  8022be:	d3 eb                	shr    %cl,%ebx
  8022c0:	89 da                	mov    %ebx,%edx
  8022c2:	f7 f7                	div    %edi
  8022c4:	89 d3                	mov    %edx,%ebx
  8022c6:	f7 24 24             	mull   (%esp)
  8022c9:	89 c6                	mov    %eax,%esi
  8022cb:	89 d1                	mov    %edx,%ecx
  8022cd:	39 d3                	cmp    %edx,%ebx
  8022cf:	0f 82 87 00 00 00    	jb     80235c <__umoddi3+0x134>
  8022d5:	0f 84 91 00 00 00    	je     80236c <__umoddi3+0x144>
  8022db:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022df:	29 f2                	sub    %esi,%edx
  8022e1:	19 cb                	sbb    %ecx,%ebx
  8022e3:	89 d8                	mov    %ebx,%eax
  8022e5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022e9:	d3 e0                	shl    %cl,%eax
  8022eb:	89 e9                	mov    %ebp,%ecx
  8022ed:	d3 ea                	shr    %cl,%edx
  8022ef:	09 d0                	or     %edx,%eax
  8022f1:	89 e9                	mov    %ebp,%ecx
  8022f3:	d3 eb                	shr    %cl,%ebx
  8022f5:	89 da                	mov    %ebx,%edx
  8022f7:	83 c4 1c             	add    $0x1c,%esp
  8022fa:	5b                   	pop    %ebx
  8022fb:	5e                   	pop    %esi
  8022fc:	5f                   	pop    %edi
  8022fd:	5d                   	pop    %ebp
  8022fe:	c3                   	ret    
  8022ff:	90                   	nop
  802300:	89 fd                	mov    %edi,%ebp
  802302:	85 ff                	test   %edi,%edi
  802304:	75 0b                	jne    802311 <__umoddi3+0xe9>
  802306:	b8 01 00 00 00       	mov    $0x1,%eax
  80230b:	31 d2                	xor    %edx,%edx
  80230d:	f7 f7                	div    %edi
  80230f:	89 c5                	mov    %eax,%ebp
  802311:	89 f0                	mov    %esi,%eax
  802313:	31 d2                	xor    %edx,%edx
  802315:	f7 f5                	div    %ebp
  802317:	89 c8                	mov    %ecx,%eax
  802319:	f7 f5                	div    %ebp
  80231b:	89 d0                	mov    %edx,%eax
  80231d:	e9 44 ff ff ff       	jmp    802266 <__umoddi3+0x3e>
  802322:	66 90                	xchg   %ax,%ax
  802324:	89 c8                	mov    %ecx,%eax
  802326:	89 f2                	mov    %esi,%edx
  802328:	83 c4 1c             	add    $0x1c,%esp
  80232b:	5b                   	pop    %ebx
  80232c:	5e                   	pop    %esi
  80232d:	5f                   	pop    %edi
  80232e:	5d                   	pop    %ebp
  80232f:	c3                   	ret    
  802330:	3b 04 24             	cmp    (%esp),%eax
  802333:	72 06                	jb     80233b <__umoddi3+0x113>
  802335:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802339:	77 0f                	ja     80234a <__umoddi3+0x122>
  80233b:	89 f2                	mov    %esi,%edx
  80233d:	29 f9                	sub    %edi,%ecx
  80233f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802343:	89 14 24             	mov    %edx,(%esp)
  802346:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80234a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80234e:	8b 14 24             	mov    (%esp),%edx
  802351:	83 c4 1c             	add    $0x1c,%esp
  802354:	5b                   	pop    %ebx
  802355:	5e                   	pop    %esi
  802356:	5f                   	pop    %edi
  802357:	5d                   	pop    %ebp
  802358:	c3                   	ret    
  802359:	8d 76 00             	lea    0x0(%esi),%esi
  80235c:	2b 04 24             	sub    (%esp),%eax
  80235f:	19 fa                	sbb    %edi,%edx
  802361:	89 d1                	mov    %edx,%ecx
  802363:	89 c6                	mov    %eax,%esi
  802365:	e9 71 ff ff ff       	jmp    8022db <__umoddi3+0xb3>
  80236a:	66 90                	xchg   %ax,%ax
  80236c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802370:	72 ea                	jb     80235c <__umoddi3+0x134>
  802372:	89 d9                	mov    %ebx,%ecx
  802374:	e9 62 ff ff ff       	jmp    8022db <__umoddi3+0xb3>
