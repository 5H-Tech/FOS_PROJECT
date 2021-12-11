
obj/user/tst_malloc_4:     file format elf32-i386


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
  800031:	e8 3e 08 00 00       	call   800874 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */
//test allocation of small sizes with large sizes
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 c4 80             	add    $0xffffff80,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;//pointer to page working set array
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
		uint8 fullWS = 1;//pointer to page working set array
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
  800088:	68 a0 23 80 00       	push   $0x8023a0
  80008d:	6a 14                	push   $0x14
  80008f:	68 bc 23 80 00       	push   $0x8023bc
  800094:	e8 20 09 00 00       	call   8009b9 <_panic>
	}

	int Mega = 1024*1024;
  800099:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a0:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	void* ptr_allocations[20] = {0};
  8000a7:	8d 55 80             	lea    -0x80(%ebp),%edx
  8000aa:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000af:	b8 00 00 00 00       	mov    $0x0,%eax
  8000b4:	89 d7                	mov    %edx,%edi
  8000b6:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 Mega
		int freeFrames = sys_calculate_free_frames() ;
  8000b8:	e8 84 1b 00 00       	call   801c41 <sys_calculate_free_frames>
  8000bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000c0:	e8 ff 1b 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8000c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000cb:	01 c0                	add    %eax,%eax
  8000cd:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	50                   	push   %eax
  8000d4:	e8 0c 19 00 00       	call   8019e5 <malloc>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START + PAGE_SIZE))
  8000df:	8b 45 80             	mov    -0x80(%ebp),%eax
  8000e2:	85 c0                	test   %eax,%eax
  8000e4:	79 0a                	jns    8000f0 <_main+0xb8>
  8000e6:	8b 45 80             	mov    -0x80(%ebp),%eax
  8000e9:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000ee:	76 14                	jbe    800104 <_main+0xcc>
		{
			panic("Wrong start address for the allocated space... ");
  8000f0:	83 ec 04             	sub    $0x4,%esp
  8000f3:	68 d0 23 80 00       	push   $0x8023d0
  8000f8:	6a 22                	push   $0x22
  8000fa:	68 bc 23 80 00       	push   $0x8023bc
  8000ff:	e8 b5 08 00 00       	call   8009b9 <_panic>
		}
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800104:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800107:	e8 35 1b 00 00       	call   801c41 <sys_calculate_free_frames>
  80010c:	29 c3                	sub    %eax,%ebx
  80010e:	89 d8                	mov    %ebx,%eax
  800110:	83 f8 01             	cmp    $0x1,%eax
  800113:	74 14                	je     800129 <_main+0xf1>
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	68 00 24 80 00       	push   $0x802400
  80011d:	6a 24                	push   $0x24
  80011f:	68 bc 23 80 00       	push   $0x8023bc
  800124:	e8 90 08 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800129:	e8 96 1b 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  80012e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800131:	3d 00 02 00 00       	cmp    $0x200,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 6c 24 80 00       	push   $0x80246c
  800140:	6a 25                	push   $0x25
  800142:	68 bc 23 80 00       	push   $0x8023bc
  800147:	e8 6d 08 00 00       	call   8009b9 <_panic>

		//2 Mega
		freeFrames = sys_calculate_free_frames() ;
  80014c:	e8 f0 1a 00 00       	call   801c41 <sys_calculate_free_frames>
  800151:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800154:	e8 6b 1b 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800159:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80015c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80015f:	01 c0                	add    %eax,%eax
  800161:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800164:	83 ec 0c             	sub    $0xc,%esp
  800167:	50                   	push   %eax
  800168:	e8 78 18 00 00       	call   8019e5 <malloc>
  80016d:	83 c4 10             	add    $0x10,%esp
  800170:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START + 2*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800173:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800176:	89 c2                	mov    %eax,%edx
  800178:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80017b:	01 c0                	add    %eax,%eax
  80017d:	05 00 00 00 80       	add    $0x80000000,%eax
  800182:	39 c2                	cmp    %eax,%edx
  800184:	72 13                	jb     800199 <_main+0x161>
  800186:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800189:	89 c2                	mov    %eax,%edx
  80018b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018e:	01 c0                	add    %eax,%eax
  800190:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800195:	39 c2                	cmp    %eax,%edx
  800197:	76 14                	jbe    8001ad <_main+0x175>
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	68 d0 23 80 00       	push   $0x8023d0
  8001a1:	6a 2b                	push   $0x2b
  8001a3:	68 bc 23 80 00       	push   $0x8023bc
  8001a8:	e8 0c 08 00 00       	call   8009b9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001ad:	e8 8f 1a 00 00       	call   801c41 <sys_calculate_free_frames>
  8001b2:	89 c2                	mov    %eax,%edx
  8001b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b7:	39 c2                	cmp    %eax,%edx
  8001b9:	74 14                	je     8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 00 24 80 00       	push   $0x802400
  8001c3:	6a 2c                	push   $0x2c
  8001c5:	68 bc 23 80 00       	push   $0x8023bc
  8001ca:	e8 ea 07 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001cf:	e8 f0 1a 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8001d4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001dc:	74 14                	je     8001f2 <_main+0x1ba>
  8001de:	83 ec 04             	sub    $0x4,%esp
  8001e1:	68 6c 24 80 00       	push   $0x80246c
  8001e6:	6a 2d                	push   $0x2d
  8001e8:	68 bc 23 80 00       	push   $0x8023bc
  8001ed:	e8 c7 07 00 00       	call   8009b9 <_panic>

		//1 KB
		//round down the addresses to the nearest page to allow for right node or left node allocation in buddy system
		freeFrames = sys_calculate_free_frames() ;
  8001f2:	e8 4a 1a 00 00       	call   801c41 <sys_calculate_free_frames>
  8001f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001fa:	e8 c5 1a 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8001ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(1*kilo);
  800202:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	50                   	push   %eax
  800209:	e8 d7 17 00 00       	call   8019e5 <malloc>
  80020e:	83 c4 10             	add    $0x10,%esp
  800211:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800214:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800217:	e8 25 1a 00 00       	call   801c41 <sys_calculate_free_frames>
  80021c:	29 c3                	sub    %eax,%ebx
  80021e:	89 d8                	mov    %ebx,%eax
  800220:	83 f8 01             	cmp    $0x1,%eax
  800223:	74 14                	je     800239 <_main+0x201>
  800225:	83 ec 04             	sub    $0x4,%esp
  800228:	68 00 24 80 00       	push   $0x802400
  80022d:	6a 34                	push   $0x34
  80022f:	68 bc 23 80 00       	push   $0x8023bc
  800234:	e8 80 07 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800239:	e8 86 1a 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  80023e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800241:	83 f8 01             	cmp    $0x1,%eax
  800244:	74 14                	je     80025a <_main+0x222>
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	68 6c 24 80 00       	push   $0x80246c
  80024e:	6a 35                	push   $0x35
  800250:	68 bc 23 80 00       	push   $0x8023bc
  800255:	e8 5f 07 00 00       	call   8009b9 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80025a:	e8 e2 19 00 00       	call   801c41 <sys_calculate_free_frames>
  80025f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800262:	e8 5d 1a 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800267:	89 45 e0             	mov    %eax,-0x20(%ebp)

		//1 KB
		ptr_allocations[3] = malloc(1*kilo);
  80026a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80026d:	83 ec 0c             	sub    $0xc,%esp
  800270:	50                   	push   %eax
  800271:	e8 6f 17 00 00       	call   8019e5 <malloc>
  800276:	83 c4 10             	add    $0x10,%esp
  800279:	89 45 8c             	mov    %eax,-0x74(%ebp)
		//swap the two addresses if the left node address is not in allocation 2
		if(ptr_allocations[2]>ptr_allocations[3])
  80027c:	8b 55 88             	mov    -0x78(%ebp),%edx
  80027f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800282:	39 c2                	cmp    %eax,%edx
  800284:	76 12                	jbe    800298 <_main+0x260>
		{
			uint32* temp =ptr_allocations[3];
  800286:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800289:	89 45 dc             	mov    %eax,-0x24(%ebp)
			ptr_allocations[3]=ptr_allocations[2];
  80028c:	8b 45 88             	mov    -0x78(%ebp),%eax
  80028f:	89 45 8c             	mov    %eax,-0x74(%ebp)
			ptr_allocations[2]=temp;
  800292:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800295:	89 45 88             	mov    %eax,-0x78(%ebp)
		}
		uint32 start_of_page = ROUNDDOWN((uint32)ptr_allocations[2], PAGE_SIZE);
  800298:	8b 45 88             	mov    -0x78(%ebp),%eax
  80029b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80029e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002a6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		//test the address of the first 1 kilo
		if ((uint32)ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8002a9:	8b 45 88             	mov    -0x78(%ebp),%eax
  8002ac:	89 c2                	mov    %eax,%edx
  8002ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002b1:	c1 e0 02             	shl    $0x2,%eax
  8002b4:	05 00 00 00 80       	add    $0x80000000,%eax
  8002b9:	39 c2                	cmp    %eax,%edx
  8002bb:	72 14                	jb     8002d1 <_main+0x299>
  8002bd:	8b 45 88             	mov    -0x78(%ebp),%eax
  8002c0:	89 c2                	mov    %eax,%edx
  8002c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c5:	c1 e0 02             	shl    $0x2,%eax
  8002c8:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002cd:	39 c2                	cmp    %eax,%edx
  8002cf:	76 14                	jbe    8002e5 <_main+0x2ad>
  8002d1:	83 ec 04             	sub    $0x4,%esp
  8002d4:	68 d0 23 80 00       	push   $0x8023d0
  8002d9:	6a 44                	push   $0x44
  8002db:	68 bc 23 80 00       	push   $0x8023bc
  8002e0:	e8 d4 06 00 00       	call   8009b9 <_panic>
		//test the address of the second 1 kilo
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega+ 1*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8002e5:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8002e8:	89 c2                	mov    %eax,%edx
  8002ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002ed:	c1 e0 02             	shl    $0x2,%eax
  8002f0:	89 c1                	mov    %eax,%ecx
  8002f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002f5:	01 c8                	add    %ecx,%eax
  8002f7:	05 00 00 00 80       	add    $0x80000000,%eax
  8002fc:	39 c2                	cmp    %eax,%edx
  8002fe:	72 14                	jb     800314 <_main+0x2dc>
  800300:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800303:	89 c2                	mov    %eax,%edx
  800305:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800308:	c1 e0 02             	shl    $0x2,%eax
  80030b:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800310:	39 c2                	cmp    %eax,%edx
  800312:	76 14                	jbe    800328 <_main+0x2f0>
  800314:	83 ec 04             	sub    $0x4,%esp
  800317:	68 d0 23 80 00       	push   $0x8023d0
  80031c:	6a 46                	push   $0x46
  80031e:	68 bc 23 80 00       	push   $0x8023bc
  800323:	e8 91 06 00 00       	call   8009b9 <_panic>

		//2 Bytes
		ptr_allocations[2] = malloc(2);
  800328:	83 ec 0c             	sub    $0xc,%esp
  80032b:	6a 02                	push   $0x2
  80032d:	e8 b3 16 00 00       	call   8019e5 <malloc>
  800332:	83 c4 10             	add    $0x10,%esp
  800335:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800338:	8b 45 88             	mov    -0x78(%ebp),%eax
  80033b:	89 c2                	mov    %eax,%edx
  80033d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800340:	c1 e0 02             	shl    $0x2,%eax
  800343:	05 00 00 00 80       	add    $0x80000000,%eax
  800348:	39 c2                	cmp    %eax,%edx
  80034a:	72 14                	jb     800360 <_main+0x328>
  80034c:	8b 45 88             	mov    -0x78(%ebp),%eax
  80034f:	89 c2                	mov    %eax,%edx
  800351:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800354:	c1 e0 02             	shl    $0x2,%eax
  800357:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80035c:	39 c2                	cmp    %eax,%edx
  80035e:	76 14                	jbe    800374 <_main+0x33c>
  800360:	83 ec 04             	sub    $0x4,%esp
  800363:	68 d0 23 80 00       	push   $0x8023d0
  800368:	6a 4a                	push   $0x4a
  80036a:	68 bc 23 80 00       	push   $0x8023bc
  80036f:	e8 45 06 00 00       	call   8009b9 <_panic>

		//1023 Bytes
		ptr_allocations[3] = malloc(1023);
  800374:	83 ec 0c             	sub    $0xc,%esp
  800377:	68 ff 03 00 00       	push   $0x3ff
  80037c:	e8 64 16 00 00       	call   8019e5 <malloc>
  800381:	83 c4 10             	add    $0x10,%esp
  800384:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800387:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80038a:	89 c2                	mov    %eax,%edx
  80038c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80038f:	c1 e0 02             	shl    $0x2,%eax
  800392:	05 00 00 00 80       	add    $0x80000000,%eax
  800397:	39 c2                	cmp    %eax,%edx
  800399:	72 14                	jb     8003af <_main+0x377>
  80039b:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80039e:	89 c2                	mov    %eax,%edx
  8003a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003a3:	c1 e0 02             	shl    $0x2,%eax
  8003a6:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8003ab:	39 c2                	cmp    %eax,%edx
  8003ad:	76 14                	jbe    8003c3 <_main+0x38b>
  8003af:	83 ec 04             	sub    $0x4,%esp
  8003b2:	68 d0 23 80 00       	push   $0x8023d0
  8003b7:	6a 4e                	push   $0x4e
  8003b9:	68 bc 23 80 00       	push   $0x8023bc
  8003be:	e8 f6 05 00 00       	call   8009b9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003c3:	e8 79 18 00 00       	call   801c41 <sys_calculate_free_frames>
  8003c8:	89 c2                	mov    %eax,%edx
  8003ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003cd:	39 c2                	cmp    %eax,%edx
  8003cf:	74 14                	je     8003e5 <_main+0x3ad>
  8003d1:	83 ec 04             	sub    $0x4,%esp
  8003d4:	68 00 24 80 00       	push   $0x802400
  8003d9:	6a 4f                	push   $0x4f
  8003db:	68 bc 23 80 00       	push   $0x8023bc
  8003e0:	e8 d4 05 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are allocated in PageFile");
  8003e5:	e8 da 18 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8003ea:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8003ed:	74 14                	je     800403 <_main+0x3cb>
  8003ef:	83 ec 04             	sub    $0x4,%esp
  8003f2:	68 6c 24 80 00       	push   $0x80246c
  8003f7:	6a 50                	push   $0x50
  8003f9:	68 bc 23 80 00       	push   $0x8023bc
  8003fe:	e8 b6 05 00 00       	call   8009b9 <_panic>

		//NEW PAGE => 2000 Bytes
		freeFrames = sys_calculate_free_frames() ;
  800403:	e8 39 18 00 00       	call   801c41 <sys_calculate_free_frames>
  800408:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80040b:	e8 b4 18 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800410:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2000);
  800413:	83 ec 0c             	sub    $0xc,%esp
  800416:	68 d0 07 00 00       	push   $0x7d0
  80041b:	e8 c5 15 00 00       	call   8019e5 <malloc>
  800420:	83 c4 10             	add    $0x10,%esp
  800423:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile %d", (freeFrames - sys_calculate_free_frames()));
  800426:	e8 16 18 00 00       	call   801c41 <sys_calculate_free_frames>
  80042b:	89 c2                	mov    %eax,%edx
  80042d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800430:	39 c2                	cmp    %eax,%edx
  800432:	74 1e                	je     800452 <_main+0x41a>
  800434:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800437:	e8 05 18 00 00       	call   801c41 <sys_calculate_free_frames>
  80043c:	29 c3                	sub    %eax,%ebx
  80043e:	89 d8                	mov    %ebx,%eax
  800440:	50                   	push   %eax
  800441:	68 9c 24 80 00       	push   $0x80249c
  800446:	6a 56                	push   $0x56
  800448:	68 bc 23 80 00       	push   $0x8023bc
  80044d:	e8 67 05 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800452:	e8 6d 18 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800457:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80045a:	83 f8 01             	cmp    $0x1,%eax
  80045d:	74 14                	je     800473 <_main+0x43b>
  80045f:	83 ec 04             	sub    $0x4,%esp
  800462:	68 6c 24 80 00       	push   $0x80246c
  800467:	6a 57                	push   $0x57
  800469:	68 bc 23 80 00       	push   $0x8023bc
  80046e:	e8 46 05 00 00       	call   8009b9 <_panic>

		//2048 Bytes
		freeFrames = sys_calculate_free_frames() ;
  800473:	e8 c9 17 00 00       	call   801c41 <sys_calculate_free_frames>
  800478:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80047b:	e8 44 18 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800480:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2048);
  800483:	83 ec 0c             	sub    $0xc,%esp
  800486:	68 00 08 00 00       	push   $0x800
  80048b:	e8 55 15 00 00       	call   8019e5 <malloc>
  800490:	83 c4 10             	add    $0x10,%esp
  800493:	89 45 8c             	mov    %eax,-0x74(%ebp)
		//swap the two addresses if the left node address is not in allocation 2
		if(ptr_allocations[2]>ptr_allocations[3])
  800496:	8b 55 88             	mov    -0x78(%ebp),%edx
  800499:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80049c:	39 c2                	cmp    %eax,%edx
  80049e:	76 12                	jbe    8004b2 <_main+0x47a>
		{
			uint32* temp =ptr_allocations[3];
  8004a0:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004a3:	89 45 d0             	mov    %eax,-0x30(%ebp)
			ptr_allocations[3]=ptr_allocations[2];
  8004a6:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004a9:	89 45 8c             	mov    %eax,-0x74(%ebp)
			ptr_allocations[2]=temp;
  8004ac:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004af:	89 45 88             	mov    %eax,-0x78(%ebp)
		}
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8004b2:	e8 8a 17 00 00       	call   801c41 <sys_calculate_free_frames>
  8004b7:	89 c2                	mov    %eax,%edx
  8004b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004bc:	39 c2                	cmp    %eax,%edx
  8004be:	74 14                	je     8004d4 <_main+0x49c>
  8004c0:	83 ec 04             	sub    $0x4,%esp
  8004c3:	68 00 24 80 00       	push   $0x802400
  8004c8:	6a 64                	push   $0x64
  8004ca:	68 bc 23 80 00       	push   $0x8023bc
  8004cf:	e8 e5 04 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are allocated in PageFile");
  8004d4:	e8 eb 17 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8004d9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8004dc:	74 14                	je     8004f2 <_main+0x4ba>
  8004de:	83 ec 04             	sub    $0x4,%esp
  8004e1:	68 6c 24 80 00       	push   $0x80246c
  8004e6:	6a 65                	push   $0x65
  8004e8:	68 bc 23 80 00       	push   $0x8023bc
  8004ed:	e8 c7 04 00 00       	call   8009b9 <_panic>
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega+ PAGE_SIZE) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8004f2:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004f5:	89 c2                	mov    %eax,%edx
  8004f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004fa:	c1 e0 02             	shl    $0x2,%eax
  8004fd:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800502:	39 c2                	cmp    %eax,%edx
  800504:	72 14                	jb     80051a <_main+0x4e2>
  800506:	8b 45 88             	mov    -0x78(%ebp),%eax
  800509:	89 c2                	mov    %eax,%edx
  80050b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80050e:	c1 e0 02             	shl    $0x2,%eax
  800511:	2d 00 e0 ff 7f       	sub    $0x7fffe000,%eax
  800516:	39 c2                	cmp    %eax,%edx
  800518:	76 14                	jbe    80052e <_main+0x4f6>
  80051a:	83 ec 04             	sub    $0x4,%esp
  80051d:	68 d0 23 80 00       	push   $0x8023d0
  800522:	6a 66                	push   $0x66
  800524:	68 bc 23 80 00       	push   $0x8023bc
  800529:	e8 8b 04 00 00       	call   8009b9 <_panic>
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega+ PAGE_SIZE + 2*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + PAGE_SIZE + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80052e:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800531:	89 c2                	mov    %eax,%edx
  800533:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800536:	c1 e0 02             	shl    $0x2,%eax
  800539:	89 c1                	mov    %eax,%ecx
  80053b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80053e:	01 c0                	add    %eax,%eax
  800540:	01 c8                	add    %ecx,%eax
  800542:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800547:	39 c2                	cmp    %eax,%edx
  800549:	72 14                	jb     80055f <_main+0x527>
  80054b:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80054e:	89 c2                	mov    %eax,%edx
  800550:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800553:	c1 e0 02             	shl    $0x2,%eax
  800556:	2d 00 e0 ff 7f       	sub    $0x7fffe000,%eax
  80055b:	39 c2                	cmp    %eax,%edx
  80055d:	76 14                	jbe    800573 <_main+0x53b>
  80055f:	83 ec 04             	sub    $0x4,%esp
  800562:	68 d0 23 80 00       	push   $0x8023d0
  800567:	6a 67                	push   $0x67
  800569:	68 bc 23 80 00       	push   $0x8023bc
  80056e:	e8 46 04 00 00       	call   8009b9 <_panic>

		//7 Kilo
		freeFrames = sys_calculate_free_frames() ;
  800573:	e8 c9 16 00 00       	call   801c41 <sys_calculate_free_frames>
  800578:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80057b:	e8 44 17 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800580:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800583:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800586:	89 d0                	mov    %edx,%eax
  800588:	01 c0                	add    %eax,%eax
  80058a:	01 d0                	add    %edx,%eax
  80058c:	01 c0                	add    %eax,%eax
  80058e:	01 d0                	add    %edx,%eax
  800590:	83 ec 0c             	sub    $0xc,%esp
  800593:	50                   	push   %eax
  800594:	e8 4c 14 00 00       	call   8019e5 <malloc>
  800599:	83 c4 10             	add    $0x10,%esp
  80059c:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 2*PAGE_SIZE) || (uint32) ptr_allocations[4] > (USER_HEAP_START + 4*Mega + 2*PAGE_SIZE + 2*PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80059f:	8b 45 90             	mov    -0x70(%ebp),%eax
  8005a2:	89 c2                	mov    %eax,%edx
  8005a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a7:	c1 e0 02             	shl    $0x2,%eax
  8005aa:	2d 00 e0 ff 7f       	sub    $0x7fffe000,%eax
  8005af:	39 c2                	cmp    %eax,%edx
  8005b1:	72 14                	jb     8005c7 <_main+0x58f>
  8005b3:	8b 45 90             	mov    -0x70(%ebp),%eax
  8005b6:	89 c2                	mov    %eax,%edx
  8005b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005bb:	c1 e0 02             	shl    $0x2,%eax
  8005be:	2d 00 c0 ff 7f       	sub    $0x7fffc000,%eax
  8005c3:	39 c2                	cmp    %eax,%edx
  8005c5:	76 14                	jbe    8005db <_main+0x5a3>
  8005c7:	83 ec 04             	sub    $0x4,%esp
  8005ca:	68 d0 23 80 00       	push   $0x8023d0
  8005cf:	6a 6d                	push   $0x6d
  8005d1:	68 bc 23 80 00       	push   $0x8023bc
  8005d6:	e8 de 03 00 00       	call   8009b9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8005db:	e8 61 16 00 00       	call   801c41 <sys_calculate_free_frames>
  8005e0:	89 c2                	mov    %eax,%edx
  8005e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005e5:	39 c2                	cmp    %eax,%edx
  8005e7:	74 14                	je     8005fd <_main+0x5c5>
  8005e9:	83 ec 04             	sub    $0x4,%esp
  8005ec:	68 00 24 80 00       	push   $0x802400
  8005f1:	6a 6e                	push   $0x6e
  8005f3:	68 bc 23 80 00       	push   $0x8023bc
  8005f8:	e8 bc 03 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8005fd:	e8 c2 16 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800602:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800605:	83 f8 02             	cmp    $0x2,%eax
  800608:	74 14                	je     80061e <_main+0x5e6>
  80060a:	83 ec 04             	sub    $0x4,%esp
  80060d:	68 6c 24 80 00       	push   $0x80246c
  800612:	6a 6f                	push   $0x6f
  800614:	68 bc 23 80 00       	push   $0x8023bc
  800619:	e8 9b 03 00 00       	call   8009b9 <_panic>

		//3 Mega
		freeFrames = sys_calculate_free_frames() ;
  80061e:	e8 1e 16 00 00       	call   801c41 <sys_calculate_free_frames>
  800623:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800626:	e8 99 16 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  80062b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  80062e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800631:	89 c2                	mov    %eax,%edx
  800633:	01 d2                	add    %edx,%edx
  800635:	01 d0                	add    %edx,%eax
  800637:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80063a:	83 ec 0c             	sub    $0xc,%esp
  80063d:	50                   	push   %eax
  80063e:	e8 a2 13 00 00       	call   8019e5 <malloc>
  800643:	83 c4 10             	add    $0x10,%esp
  800646:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800649:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80064c:	89 c2                	mov    %eax,%edx
  80064e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800651:	c1 e0 02             	shl    $0x2,%eax
  800654:	89 c1                	mov    %eax,%ecx
  800656:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800659:	c1 e0 04             	shl    $0x4,%eax
  80065c:	01 c8                	add    %ecx,%eax
  80065e:	05 00 00 00 80       	add    $0x80000000,%eax
  800663:	39 c2                	cmp    %eax,%edx
  800665:	72 25                	jb     80068c <_main+0x654>
  800667:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80066a:	89 c1                	mov    %eax,%ecx
  80066c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80066f:	89 d0                	mov    %edx,%eax
  800671:	01 c0                	add    %eax,%eax
  800673:	01 d0                	add    %edx,%eax
  800675:	01 c0                	add    %eax,%eax
  800677:	01 d0                	add    %edx,%eax
  800679:	89 c2                	mov    %eax,%edx
  80067b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80067e:	c1 e0 04             	shl    $0x4,%eax
  800681:	01 d0                	add    %edx,%eax
  800683:	05 00 00 00 80       	add    $0x80000000,%eax
  800688:	39 c1                	cmp    %eax,%ecx
  80068a:	76 14                	jbe    8006a0 <_main+0x668>
  80068c:	83 ec 04             	sub    $0x4,%esp
  80068f:	68 d0 23 80 00       	push   $0x8023d0
  800694:	6a 75                	push   $0x75
  800696:	68 bc 23 80 00       	push   $0x8023bc
  80069b:	e8 19 03 00 00       	call   8009b9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8006a0:	e8 9c 15 00 00       	call   801c41 <sys_calculate_free_frames>
  8006a5:	89 c2                	mov    %eax,%edx
  8006a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006aa:	39 c2                	cmp    %eax,%edx
  8006ac:	74 14                	je     8006c2 <_main+0x68a>
  8006ae:	83 ec 04             	sub    $0x4,%esp
  8006b1:	68 00 24 80 00       	push   $0x802400
  8006b6:	6a 76                	push   $0x76
  8006b8:	68 bc 23 80 00       	push   $0x8023bc
  8006bd:	e8 f7 02 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8006c2:	e8 fd 15 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8006c7:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8006ca:	89 c2                	mov    %eax,%edx
  8006cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006cf:	89 c1                	mov    %eax,%ecx
  8006d1:	01 c9                	add    %ecx,%ecx
  8006d3:	01 c8                	add    %ecx,%eax
  8006d5:	85 c0                	test   %eax,%eax
  8006d7:	79 05                	jns    8006de <_main+0x6a6>
  8006d9:	05 ff 0f 00 00       	add    $0xfff,%eax
  8006de:	c1 f8 0c             	sar    $0xc,%eax
  8006e1:	39 c2                	cmp    %eax,%edx
  8006e3:	74 14                	je     8006f9 <_main+0x6c1>
  8006e5:	83 ec 04             	sub    $0x4,%esp
  8006e8:	68 6c 24 80 00       	push   $0x80246c
  8006ed:	6a 77                	push   $0x77
  8006ef:	68 bc 23 80 00       	push   $0x8023bc
  8006f4:	e8 c0 02 00 00       	call   8009b9 <_panic>

		//2 Mega
		freeFrames = sys_calculate_free_frames() ;
  8006f9:	e8 43 15 00 00       	call   801c41 <sys_calculate_free_frames>
  8006fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800701:	e8 be 15 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800706:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  800709:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80070c:	01 c0                	add    %eax,%eax
  80070e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800711:	83 ec 0c             	sub    $0xc,%esp
  800714:	50                   	push   %eax
  800715:	e8 cb 12 00 00       	call   8019e5 <malloc>
  80071a:	83 c4 10             	add    $0x10,%esp
  80071d:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START + 9*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800720:	8b 45 98             	mov    -0x68(%ebp),%eax
  800723:	89 c1                	mov    %eax,%ecx
  800725:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800728:	89 d0                	mov    %edx,%eax
  80072a:	01 c0                	add    %eax,%eax
  80072c:	01 d0                	add    %edx,%eax
  80072e:	01 c0                	add    %eax,%eax
  800730:	01 d0                	add    %edx,%eax
  800732:	89 c2                	mov    %eax,%edx
  800734:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800737:	c1 e0 04             	shl    $0x4,%eax
  80073a:	01 d0                	add    %edx,%eax
  80073c:	05 00 00 00 80       	add    $0x80000000,%eax
  800741:	39 c1                	cmp    %eax,%ecx
  800743:	72 22                	jb     800767 <_main+0x72f>
  800745:	8b 45 98             	mov    -0x68(%ebp),%eax
  800748:	89 c1                	mov    %eax,%ecx
  80074a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80074d:	89 d0                	mov    %edx,%eax
  80074f:	c1 e0 03             	shl    $0x3,%eax
  800752:	01 d0                	add    %edx,%eax
  800754:	89 c2                	mov    %eax,%edx
  800756:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800759:	c1 e0 04             	shl    $0x4,%eax
  80075c:	01 d0                	add    %edx,%eax
  80075e:	05 00 00 00 80       	add    $0x80000000,%eax
  800763:	39 c1                	cmp    %eax,%ecx
  800765:	76 14                	jbe    80077b <_main+0x743>
  800767:	83 ec 04             	sub    $0x4,%esp
  80076a:	68 d0 23 80 00       	push   $0x8023d0
  80076f:	6a 7d                	push   $0x7d
  800771:	68 bc 23 80 00       	push   $0x8023bc
  800776:	e8 3e 02 00 00       	call   8009b9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80077b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80077e:	e8 be 14 00 00       	call   801c41 <sys_calculate_free_frames>
  800783:	29 c3                	sub    %eax,%ebx
  800785:	89 d8                	mov    %ebx,%eax
  800787:	83 f8 01             	cmp    $0x1,%eax
  80078a:	74 14                	je     8007a0 <_main+0x768>
  80078c:	83 ec 04             	sub    $0x4,%esp
  80078f:	68 00 24 80 00       	push   $0x802400
  800794:	6a 7e                	push   $0x7e
  800796:	68 bc 23 80 00       	push   $0x8023bc
  80079b:	e8 19 02 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8007a0:	e8 1f 15 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8007a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007a8:	3d 00 02 00 00       	cmp    $0x200,%eax
  8007ad:	74 14                	je     8007c3 <_main+0x78b>
  8007af:	83 ec 04             	sub    $0x4,%esp
  8007b2:	68 6c 24 80 00       	push   $0x80246c
  8007b7:	6a 7f                	push   $0x7f
  8007b9:	68 bc 23 80 00       	push   $0x8023bc
  8007be:	e8 f6 01 00 00       	call   8009b9 <_panic>

		//257 Bytes
		freeFrames = sys_calculate_free_frames() ;
  8007c3:	e8 79 14 00 00       	call   801c41 <sys_calculate_free_frames>
  8007c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8007cb:	e8 f4 14 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  8007d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(510);
  8007d3:	83 ec 0c             	sub    $0xc,%esp
  8007d6:	68 fe 01 00 00       	push   $0x1fe
  8007db:	e8 05 12 00 00       	call   8019e5 <malloc>
  8007e0:	83 c4 10             	add    $0x10,%esp
  8007e3:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[7] < (start_of_page) || (uint32) ptr_allocations[7] > (start_of_page + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8007e6:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8007e9:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  8007ec:	72 11                	jb     8007ff <_main+0x7c7>
  8007ee:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8007f1:	89 c2                	mov    %eax,%edx
  8007f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8007f6:	05 00 10 00 00       	add    $0x1000,%eax
  8007fb:	39 c2                	cmp    %eax,%edx
  8007fd:	76 17                	jbe    800816 <_main+0x7de>
  8007ff:	83 ec 04             	sub    $0x4,%esp
  800802:	68 d0 23 80 00       	push   $0x8023d0
  800807:	68 85 00 00 00       	push   $0x85
  80080c:	68 bc 23 80 00       	push   $0x8023bc
  800811:	e8 a3 01 00 00       	call   8009b9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800816:	e8 26 14 00 00       	call   801c41 <sys_calculate_free_frames>
  80081b:	89 c2                	mov    %eax,%edx
  80081d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800820:	39 c2                	cmp    %eax,%edx
  800822:	74 17                	je     80083b <_main+0x803>
  800824:	83 ec 04             	sub    $0x4,%esp
  800827:	68 00 24 80 00       	push   $0x802400
  80082c:	68 86 00 00 00       	push   $0x86
  800831:	68 bc 23 80 00       	push   $0x8023bc
  800836:	e8 7e 01 00 00       	call   8009b9 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are allocated in PageFile");
  80083b:	e8 84 14 00 00       	call   801cc4 <sys_pf_calculate_allocated_pages>
  800840:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800843:	74 17                	je     80085c <_main+0x824>
  800845:	83 ec 04             	sub    $0x4,%esp
  800848:	68 6c 24 80 00       	push   $0x80246c
  80084d:	68 87 00 00 00       	push   $0x87
  800852:	68 bc 23 80 00       	push   $0x8023bc
  800857:	e8 5d 01 00 00       	call   8009b9 <_panic>
	}
	cprintf("Congratulations!! test malloc (4) completed successfully.\n");
  80085c:	83 ec 0c             	sub    $0xc,%esp
  80085f:	68 0c 25 80 00       	push   $0x80250c
  800864:	e8 f2 03 00 00       	call   800c5b <cprintf>
  800869:	83 c4 10             	add    $0x10,%esp

	return;
  80086c:	90                   	nop
}
  80086d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800870:	5b                   	pop    %ebx
  800871:	5f                   	pop    %edi
  800872:	5d                   	pop    %ebp
  800873:	c3                   	ret    

00800874 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800874:	55                   	push   %ebp
  800875:	89 e5                	mov    %esp,%ebp
  800877:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80087a:	e8 f7 12 00 00       	call   801b76 <sys_getenvindex>
  80087f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800882:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800885:	89 d0                	mov    %edx,%eax
  800887:	c1 e0 03             	shl    $0x3,%eax
  80088a:	01 d0                	add    %edx,%eax
  80088c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800893:	01 c8                	add    %ecx,%eax
  800895:	01 c0                	add    %eax,%eax
  800897:	01 d0                	add    %edx,%eax
  800899:	01 c0                	add    %eax,%eax
  80089b:	01 d0                	add    %edx,%eax
  80089d:	89 c2                	mov    %eax,%edx
  80089f:	c1 e2 05             	shl    $0x5,%edx
  8008a2:	29 c2                	sub    %eax,%edx
  8008a4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8008ab:	89 c2                	mov    %eax,%edx
  8008ad:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8008b3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8008b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8008bd:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8008c3:	84 c0                	test   %al,%al
  8008c5:	74 0f                	je     8008d6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8008c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8008cc:	05 40 3c 01 00       	add    $0x13c40,%eax
  8008d1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8008d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008da:	7e 0a                	jle    8008e6 <libmain+0x72>
		binaryname = argv[0];
  8008dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008df:	8b 00                	mov    (%eax),%eax
  8008e1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8008e6:	83 ec 08             	sub    $0x8,%esp
  8008e9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ec:	ff 75 08             	pushl  0x8(%ebp)
  8008ef:	e8 44 f7 ff ff       	call   800038 <_main>
  8008f4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008f7:	e8 15 14 00 00       	call   801d11 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8008fc:	83 ec 0c             	sub    $0xc,%esp
  8008ff:	68 60 25 80 00       	push   $0x802560
  800904:	e8 52 03 00 00       	call   800c5b <cprintf>
  800909:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80090c:	a1 20 30 80 00       	mov    0x803020,%eax
  800911:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800917:	a1 20 30 80 00       	mov    0x803020,%eax
  80091c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800922:	83 ec 04             	sub    $0x4,%esp
  800925:	52                   	push   %edx
  800926:	50                   	push   %eax
  800927:	68 88 25 80 00       	push   $0x802588
  80092c:	e8 2a 03 00 00       	call   800c5b <cprintf>
  800931:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800934:	a1 20 30 80 00       	mov    0x803020,%eax
  800939:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80093f:	a1 20 30 80 00       	mov    0x803020,%eax
  800944:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80094a:	83 ec 04             	sub    $0x4,%esp
  80094d:	52                   	push   %edx
  80094e:	50                   	push   %eax
  80094f:	68 b0 25 80 00       	push   $0x8025b0
  800954:	e8 02 03 00 00       	call   800c5b <cprintf>
  800959:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80095c:	a1 20 30 80 00       	mov    0x803020,%eax
  800961:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800967:	83 ec 08             	sub    $0x8,%esp
  80096a:	50                   	push   %eax
  80096b:	68 f1 25 80 00       	push   $0x8025f1
  800970:	e8 e6 02 00 00       	call   800c5b <cprintf>
  800975:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800978:	83 ec 0c             	sub    $0xc,%esp
  80097b:	68 60 25 80 00       	push   $0x802560
  800980:	e8 d6 02 00 00       	call   800c5b <cprintf>
  800985:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800988:	e8 9e 13 00 00       	call   801d2b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80098d:	e8 19 00 00 00       	call   8009ab <exit>
}
  800992:	90                   	nop
  800993:	c9                   	leave  
  800994:	c3                   	ret    

00800995 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800995:	55                   	push   %ebp
  800996:	89 e5                	mov    %esp,%ebp
  800998:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80099b:	83 ec 0c             	sub    $0xc,%esp
  80099e:	6a 00                	push   $0x0
  8009a0:	e8 9d 11 00 00       	call   801b42 <sys_env_destroy>
  8009a5:	83 c4 10             	add    $0x10,%esp
}
  8009a8:	90                   	nop
  8009a9:	c9                   	leave  
  8009aa:	c3                   	ret    

008009ab <exit>:

void
exit(void)
{
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
  8009ae:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009b1:	e8 f2 11 00 00       	call   801ba8 <sys_env_exit>
}
  8009b6:	90                   	nop
  8009b7:	c9                   	leave  
  8009b8:	c3                   	ret    

008009b9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009b9:	55                   	push   %ebp
  8009ba:	89 e5                	mov    %esp,%ebp
  8009bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009bf:	8d 45 10             	lea    0x10(%ebp),%eax
  8009c2:	83 c0 04             	add    $0x4,%eax
  8009c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009c8:	a1 18 31 80 00       	mov    0x803118,%eax
  8009cd:	85 c0                	test   %eax,%eax
  8009cf:	74 16                	je     8009e7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009d1:	a1 18 31 80 00       	mov    0x803118,%eax
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	50                   	push   %eax
  8009da:	68 08 26 80 00       	push   $0x802608
  8009df:	e8 77 02 00 00       	call   800c5b <cprintf>
  8009e4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8009e7:	a1 00 30 80 00       	mov    0x803000,%eax
  8009ec:	ff 75 0c             	pushl  0xc(%ebp)
  8009ef:	ff 75 08             	pushl  0x8(%ebp)
  8009f2:	50                   	push   %eax
  8009f3:	68 0d 26 80 00       	push   $0x80260d
  8009f8:	e8 5e 02 00 00       	call   800c5b <cprintf>
  8009fd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a00:	8b 45 10             	mov    0x10(%ebp),%eax
  800a03:	83 ec 08             	sub    $0x8,%esp
  800a06:	ff 75 f4             	pushl  -0xc(%ebp)
  800a09:	50                   	push   %eax
  800a0a:	e8 e1 01 00 00       	call   800bf0 <vcprintf>
  800a0f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a12:	83 ec 08             	sub    $0x8,%esp
  800a15:	6a 00                	push   $0x0
  800a17:	68 29 26 80 00       	push   $0x802629
  800a1c:	e8 cf 01 00 00       	call   800bf0 <vcprintf>
  800a21:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a24:	e8 82 ff ff ff       	call   8009ab <exit>

	// should not return here
	while (1) ;
  800a29:	eb fe                	jmp    800a29 <_panic+0x70>

00800a2b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a2b:	55                   	push   %ebp
  800a2c:	89 e5                	mov    %esp,%ebp
  800a2e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a31:	a1 20 30 80 00       	mov    0x803020,%eax
  800a36:	8b 50 74             	mov    0x74(%eax),%edx
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	39 c2                	cmp    %eax,%edx
  800a3e:	74 14                	je     800a54 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a40:	83 ec 04             	sub    $0x4,%esp
  800a43:	68 2c 26 80 00       	push   $0x80262c
  800a48:	6a 26                	push   $0x26
  800a4a:	68 78 26 80 00       	push   $0x802678
  800a4f:	e8 65 ff ff ff       	call   8009b9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a5b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a62:	e9 b6 00 00 00       	jmp    800b1d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	01 d0                	add    %edx,%eax
  800a76:	8b 00                	mov    (%eax),%eax
  800a78:	85 c0                	test   %eax,%eax
  800a7a:	75 08                	jne    800a84 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a7c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a7f:	e9 96 00 00 00       	jmp    800b1a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800a84:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a8b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a92:	eb 5d                	jmp    800af1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a94:	a1 20 30 80 00       	mov    0x803020,%eax
  800a99:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a9f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800aa2:	c1 e2 04             	shl    $0x4,%edx
  800aa5:	01 d0                	add    %edx,%eax
  800aa7:	8a 40 04             	mov    0x4(%eax),%al
  800aaa:	84 c0                	test   %al,%al
  800aac:	75 40                	jne    800aee <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800aae:	a1 20 30 80 00       	mov    0x803020,%eax
  800ab3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800ab9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800abc:	c1 e2 04             	shl    $0x4,%edx
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	8b 00                	mov    (%eax),%eax
  800ac3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800ac6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ac9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ace:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ad0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	01 c8                	add    %ecx,%eax
  800adf:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ae1:	39 c2                	cmp    %eax,%edx
  800ae3:	75 09                	jne    800aee <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800ae5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800aec:	eb 12                	jmp    800b00 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aee:	ff 45 e8             	incl   -0x18(%ebp)
  800af1:	a1 20 30 80 00       	mov    0x803020,%eax
  800af6:	8b 50 74             	mov    0x74(%eax),%edx
  800af9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800afc:	39 c2                	cmp    %eax,%edx
  800afe:	77 94                	ja     800a94 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b00:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b04:	75 14                	jne    800b1a <CheckWSWithoutLastIndex+0xef>
			panic(
  800b06:	83 ec 04             	sub    $0x4,%esp
  800b09:	68 84 26 80 00       	push   $0x802684
  800b0e:	6a 3a                	push   $0x3a
  800b10:	68 78 26 80 00       	push   $0x802678
  800b15:	e8 9f fe ff ff       	call   8009b9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b1a:	ff 45 f0             	incl   -0x10(%ebp)
  800b1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b20:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b23:	0f 8c 3e ff ff ff    	jl     800a67 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b29:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b30:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b37:	eb 20                	jmp    800b59 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b39:	a1 20 30 80 00       	mov    0x803020,%eax
  800b3e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b44:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b47:	c1 e2 04             	shl    $0x4,%edx
  800b4a:	01 d0                	add    %edx,%eax
  800b4c:	8a 40 04             	mov    0x4(%eax),%al
  800b4f:	3c 01                	cmp    $0x1,%al
  800b51:	75 03                	jne    800b56 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800b53:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b56:	ff 45 e0             	incl   -0x20(%ebp)
  800b59:	a1 20 30 80 00       	mov    0x803020,%eax
  800b5e:	8b 50 74             	mov    0x74(%eax),%edx
  800b61:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b64:	39 c2                	cmp    %eax,%edx
  800b66:	77 d1                	ja     800b39 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b6b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b6e:	74 14                	je     800b84 <CheckWSWithoutLastIndex+0x159>
		panic(
  800b70:	83 ec 04             	sub    $0x4,%esp
  800b73:	68 d8 26 80 00       	push   $0x8026d8
  800b78:	6a 44                	push   $0x44
  800b7a:	68 78 26 80 00       	push   $0x802678
  800b7f:	e8 35 fe ff ff       	call   8009b9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b84:	90                   	nop
  800b85:	c9                   	leave  
  800b86:	c3                   	ret    

00800b87 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b87:	55                   	push   %ebp
  800b88:	89 e5                	mov    %esp,%ebp
  800b8a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b90:	8b 00                	mov    (%eax),%eax
  800b92:	8d 48 01             	lea    0x1(%eax),%ecx
  800b95:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b98:	89 0a                	mov    %ecx,(%edx)
  800b9a:	8b 55 08             	mov    0x8(%ebp),%edx
  800b9d:	88 d1                	mov    %dl,%cl
  800b9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba9:	8b 00                	mov    (%eax),%eax
  800bab:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bb0:	75 2c                	jne    800bde <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800bb2:	a0 24 30 80 00       	mov    0x803024,%al
  800bb7:	0f b6 c0             	movzbl %al,%eax
  800bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbd:	8b 12                	mov    (%edx),%edx
  800bbf:	89 d1                	mov    %edx,%ecx
  800bc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc4:	83 c2 08             	add    $0x8,%edx
  800bc7:	83 ec 04             	sub    $0x4,%esp
  800bca:	50                   	push   %eax
  800bcb:	51                   	push   %ecx
  800bcc:	52                   	push   %edx
  800bcd:	e8 2e 0f 00 00       	call   801b00 <sys_cputs>
  800bd2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800bde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be1:	8b 40 04             	mov    0x4(%eax),%eax
  800be4:	8d 50 01             	lea    0x1(%eax),%edx
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bed:	90                   	nop
  800bee:	c9                   	leave  
  800bef:	c3                   	ret    

00800bf0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bf0:	55                   	push   %ebp
  800bf1:	89 e5                	mov    %esp,%ebp
  800bf3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bf9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c00:	00 00 00 
	b.cnt = 0;
  800c03:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c0a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c0d:	ff 75 0c             	pushl  0xc(%ebp)
  800c10:	ff 75 08             	pushl  0x8(%ebp)
  800c13:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c19:	50                   	push   %eax
  800c1a:	68 87 0b 80 00       	push   $0x800b87
  800c1f:	e8 11 02 00 00       	call   800e35 <vprintfmt>
  800c24:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c27:	a0 24 30 80 00       	mov    0x803024,%al
  800c2c:	0f b6 c0             	movzbl %al,%eax
  800c2f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c35:	83 ec 04             	sub    $0x4,%esp
  800c38:	50                   	push   %eax
  800c39:	52                   	push   %edx
  800c3a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c40:	83 c0 08             	add    $0x8,%eax
  800c43:	50                   	push   %eax
  800c44:	e8 b7 0e 00 00       	call   801b00 <sys_cputs>
  800c49:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c4c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800c53:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c59:	c9                   	leave  
  800c5a:	c3                   	ret    

00800c5b <cprintf>:

int cprintf(const char *fmt, ...) {
  800c5b:	55                   	push   %ebp
  800c5c:	89 e5                	mov    %esp,%ebp
  800c5e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c61:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800c68:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	83 ec 08             	sub    $0x8,%esp
  800c74:	ff 75 f4             	pushl  -0xc(%ebp)
  800c77:	50                   	push   %eax
  800c78:	e8 73 ff ff ff       	call   800bf0 <vcprintf>
  800c7d:	83 c4 10             	add    $0x10,%esp
  800c80:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c83:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c86:	c9                   	leave  
  800c87:	c3                   	ret    

00800c88 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c88:	55                   	push   %ebp
  800c89:	89 e5                	mov    %esp,%ebp
  800c8b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c8e:	e8 7e 10 00 00       	call   801d11 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c93:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c96:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	83 ec 08             	sub    $0x8,%esp
  800c9f:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca2:	50                   	push   %eax
  800ca3:	e8 48 ff ff ff       	call   800bf0 <vcprintf>
  800ca8:	83 c4 10             	add    $0x10,%esp
  800cab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800cae:	e8 78 10 00 00       	call   801d2b <sys_enable_interrupt>
	return cnt;
  800cb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
  800cbb:	53                   	push   %ebx
  800cbc:	83 ec 14             	sub    $0x14,%esp
  800cbf:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ccb:	8b 45 18             	mov    0x18(%ebp),%eax
  800cce:	ba 00 00 00 00       	mov    $0x0,%edx
  800cd3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cd6:	77 55                	ja     800d2d <printnum+0x75>
  800cd8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cdb:	72 05                	jb     800ce2 <printnum+0x2a>
  800cdd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ce0:	77 4b                	ja     800d2d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ce2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ce5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ce8:	8b 45 18             	mov    0x18(%ebp),%eax
  800ceb:	ba 00 00 00 00       	mov    $0x0,%edx
  800cf0:	52                   	push   %edx
  800cf1:	50                   	push   %eax
  800cf2:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf5:	ff 75 f0             	pushl  -0x10(%ebp)
  800cf8:	e8 37 14 00 00       	call   802134 <__udivdi3>
  800cfd:	83 c4 10             	add    $0x10,%esp
  800d00:	83 ec 04             	sub    $0x4,%esp
  800d03:	ff 75 20             	pushl  0x20(%ebp)
  800d06:	53                   	push   %ebx
  800d07:	ff 75 18             	pushl  0x18(%ebp)
  800d0a:	52                   	push   %edx
  800d0b:	50                   	push   %eax
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	ff 75 08             	pushl  0x8(%ebp)
  800d12:	e8 a1 ff ff ff       	call   800cb8 <printnum>
  800d17:	83 c4 20             	add    $0x20,%esp
  800d1a:	eb 1a                	jmp    800d36 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d1c:	83 ec 08             	sub    $0x8,%esp
  800d1f:	ff 75 0c             	pushl  0xc(%ebp)
  800d22:	ff 75 20             	pushl  0x20(%ebp)
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	ff d0                	call   *%eax
  800d2a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d2d:	ff 4d 1c             	decl   0x1c(%ebp)
  800d30:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d34:	7f e6                	jg     800d1c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d36:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d39:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d41:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d44:	53                   	push   %ebx
  800d45:	51                   	push   %ecx
  800d46:	52                   	push   %edx
  800d47:	50                   	push   %eax
  800d48:	e8 f7 14 00 00       	call   802244 <__umoddi3>
  800d4d:	83 c4 10             	add    $0x10,%esp
  800d50:	05 54 29 80 00       	add    $0x802954,%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	0f be c0             	movsbl %al,%eax
  800d5a:	83 ec 08             	sub    $0x8,%esp
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	50                   	push   %eax
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	ff d0                	call   *%eax
  800d66:	83 c4 10             	add    $0x10,%esp
}
  800d69:	90                   	nop
  800d6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d6d:	c9                   	leave  
  800d6e:	c3                   	ret    

00800d6f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d6f:	55                   	push   %ebp
  800d70:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d72:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d76:	7e 1c                	jle    800d94 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	8b 00                	mov    (%eax),%eax
  800d7d:	8d 50 08             	lea    0x8(%eax),%edx
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	89 10                	mov    %edx,(%eax)
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8b 00                	mov    (%eax),%eax
  800d8a:	83 e8 08             	sub    $0x8,%eax
  800d8d:	8b 50 04             	mov    0x4(%eax),%edx
  800d90:	8b 00                	mov    (%eax),%eax
  800d92:	eb 40                	jmp    800dd4 <getuint+0x65>
	else if (lflag)
  800d94:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d98:	74 1e                	je     800db8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	8b 00                	mov    (%eax),%eax
  800d9f:	8d 50 04             	lea    0x4(%eax),%edx
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	89 10                	mov    %edx,(%eax)
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	8b 00                	mov    (%eax),%eax
  800dac:	83 e8 04             	sub    $0x4,%eax
  800daf:	8b 00                	mov    (%eax),%eax
  800db1:	ba 00 00 00 00       	mov    $0x0,%edx
  800db6:	eb 1c                	jmp    800dd4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	8b 00                	mov    (%eax),%eax
  800dbd:	8d 50 04             	lea    0x4(%eax),%edx
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	89 10                	mov    %edx,(%eax)
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	8b 00                	mov    (%eax),%eax
  800dca:	83 e8 04             	sub    $0x4,%eax
  800dcd:	8b 00                	mov    (%eax),%eax
  800dcf:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800dd4:	5d                   	pop    %ebp
  800dd5:	c3                   	ret    

00800dd6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dd9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ddd:	7e 1c                	jle    800dfb <getint+0x25>
		return va_arg(*ap, long long);
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	8b 00                	mov    (%eax),%eax
  800de4:	8d 50 08             	lea    0x8(%eax),%edx
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	89 10                	mov    %edx,(%eax)
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	8b 00                	mov    (%eax),%eax
  800df1:	83 e8 08             	sub    $0x8,%eax
  800df4:	8b 50 04             	mov    0x4(%eax),%edx
  800df7:	8b 00                	mov    (%eax),%eax
  800df9:	eb 38                	jmp    800e33 <getint+0x5d>
	else if (lflag)
  800dfb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dff:	74 1a                	je     800e1b <getint+0x45>
		return va_arg(*ap, long);
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8b 00                	mov    (%eax),%eax
  800e06:	8d 50 04             	lea    0x4(%eax),%edx
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	89 10                	mov    %edx,(%eax)
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8b 00                	mov    (%eax),%eax
  800e13:	83 e8 04             	sub    $0x4,%eax
  800e16:	8b 00                	mov    (%eax),%eax
  800e18:	99                   	cltd   
  800e19:	eb 18                	jmp    800e33 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	8b 00                	mov    (%eax),%eax
  800e20:	8d 50 04             	lea    0x4(%eax),%edx
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	89 10                	mov    %edx,(%eax)
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8b 00                	mov    (%eax),%eax
  800e2d:	83 e8 04             	sub    $0x4,%eax
  800e30:	8b 00                	mov    (%eax),%eax
  800e32:	99                   	cltd   
}
  800e33:	5d                   	pop    %ebp
  800e34:	c3                   	ret    

00800e35 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e35:	55                   	push   %ebp
  800e36:	89 e5                	mov    %esp,%ebp
  800e38:	56                   	push   %esi
  800e39:	53                   	push   %ebx
  800e3a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e3d:	eb 17                	jmp    800e56 <vprintfmt+0x21>
			if (ch == '\0')
  800e3f:	85 db                	test   %ebx,%ebx
  800e41:	0f 84 af 03 00 00    	je     8011f6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e47:	83 ec 08             	sub    $0x8,%esp
  800e4a:	ff 75 0c             	pushl  0xc(%ebp)
  800e4d:	53                   	push   %ebx
  800e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e51:	ff d0                	call   *%eax
  800e53:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e56:	8b 45 10             	mov    0x10(%ebp),%eax
  800e59:	8d 50 01             	lea    0x1(%eax),%edx
  800e5c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	0f b6 d8             	movzbl %al,%ebx
  800e64:	83 fb 25             	cmp    $0x25,%ebx
  800e67:	75 d6                	jne    800e3f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e69:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e6d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e74:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e7b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e82:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e89:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8c:	8d 50 01             	lea    0x1(%eax),%edx
  800e8f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	0f b6 d8             	movzbl %al,%ebx
  800e97:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e9a:	83 f8 55             	cmp    $0x55,%eax
  800e9d:	0f 87 2b 03 00 00    	ja     8011ce <vprintfmt+0x399>
  800ea3:	8b 04 85 78 29 80 00 	mov    0x802978(,%eax,4),%eax
  800eaa:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800eac:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800eb0:	eb d7                	jmp    800e89 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800eb2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800eb6:	eb d1                	jmp    800e89 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800eb8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ebf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ec2:	89 d0                	mov    %edx,%eax
  800ec4:	c1 e0 02             	shl    $0x2,%eax
  800ec7:	01 d0                	add    %edx,%eax
  800ec9:	01 c0                	add    %eax,%eax
  800ecb:	01 d8                	add    %ebx,%eax
  800ecd:	83 e8 30             	sub    $0x30,%eax
  800ed0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ed3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed6:	8a 00                	mov    (%eax),%al
  800ed8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800edb:	83 fb 2f             	cmp    $0x2f,%ebx
  800ede:	7e 3e                	jle    800f1e <vprintfmt+0xe9>
  800ee0:	83 fb 39             	cmp    $0x39,%ebx
  800ee3:	7f 39                	jg     800f1e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ee5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ee8:	eb d5                	jmp    800ebf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800eea:	8b 45 14             	mov    0x14(%ebp),%eax
  800eed:	83 c0 04             	add    $0x4,%eax
  800ef0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef6:	83 e8 04             	sub    $0x4,%eax
  800ef9:	8b 00                	mov    (%eax),%eax
  800efb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800efe:	eb 1f                	jmp    800f1f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f00:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f04:	79 83                	jns    800e89 <vprintfmt+0x54>
				width = 0;
  800f06:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f0d:	e9 77 ff ff ff       	jmp    800e89 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f12:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f19:	e9 6b ff ff ff       	jmp    800e89 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f1e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f1f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f23:	0f 89 60 ff ff ff    	jns    800e89 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f29:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f2c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f2f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f36:	e9 4e ff ff ff       	jmp    800e89 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f3b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f3e:	e9 46 ff ff ff       	jmp    800e89 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f43:	8b 45 14             	mov    0x14(%ebp),%eax
  800f46:	83 c0 04             	add    $0x4,%eax
  800f49:	89 45 14             	mov    %eax,0x14(%ebp)
  800f4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4f:	83 e8 04             	sub    $0x4,%eax
  800f52:	8b 00                	mov    (%eax),%eax
  800f54:	83 ec 08             	sub    $0x8,%esp
  800f57:	ff 75 0c             	pushl  0xc(%ebp)
  800f5a:	50                   	push   %eax
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	ff d0                	call   *%eax
  800f60:	83 c4 10             	add    $0x10,%esp
			break;
  800f63:	e9 89 02 00 00       	jmp    8011f1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f68:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6b:	83 c0 04             	add    $0x4,%eax
  800f6e:	89 45 14             	mov    %eax,0x14(%ebp)
  800f71:	8b 45 14             	mov    0x14(%ebp),%eax
  800f74:	83 e8 04             	sub    $0x4,%eax
  800f77:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f79:	85 db                	test   %ebx,%ebx
  800f7b:	79 02                	jns    800f7f <vprintfmt+0x14a>
				err = -err;
  800f7d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f7f:	83 fb 64             	cmp    $0x64,%ebx
  800f82:	7f 0b                	jg     800f8f <vprintfmt+0x15a>
  800f84:	8b 34 9d c0 27 80 00 	mov    0x8027c0(,%ebx,4),%esi
  800f8b:	85 f6                	test   %esi,%esi
  800f8d:	75 19                	jne    800fa8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f8f:	53                   	push   %ebx
  800f90:	68 65 29 80 00       	push   $0x802965
  800f95:	ff 75 0c             	pushl  0xc(%ebp)
  800f98:	ff 75 08             	pushl  0x8(%ebp)
  800f9b:	e8 5e 02 00 00       	call   8011fe <printfmt>
  800fa0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fa3:	e9 49 02 00 00       	jmp    8011f1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800fa8:	56                   	push   %esi
  800fa9:	68 6e 29 80 00       	push   $0x80296e
  800fae:	ff 75 0c             	pushl  0xc(%ebp)
  800fb1:	ff 75 08             	pushl  0x8(%ebp)
  800fb4:	e8 45 02 00 00       	call   8011fe <printfmt>
  800fb9:	83 c4 10             	add    $0x10,%esp
			break;
  800fbc:	e9 30 02 00 00       	jmp    8011f1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800fc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc4:	83 c0 04             	add    $0x4,%eax
  800fc7:	89 45 14             	mov    %eax,0x14(%ebp)
  800fca:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcd:	83 e8 04             	sub    $0x4,%eax
  800fd0:	8b 30                	mov    (%eax),%esi
  800fd2:	85 f6                	test   %esi,%esi
  800fd4:	75 05                	jne    800fdb <vprintfmt+0x1a6>
				p = "(null)";
  800fd6:	be 71 29 80 00       	mov    $0x802971,%esi
			if (width > 0 && padc != '-')
  800fdb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fdf:	7e 6d                	jle    80104e <vprintfmt+0x219>
  800fe1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800fe5:	74 67                	je     80104e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800fe7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fea:	83 ec 08             	sub    $0x8,%esp
  800fed:	50                   	push   %eax
  800fee:	56                   	push   %esi
  800fef:	e8 0c 03 00 00       	call   801300 <strnlen>
  800ff4:	83 c4 10             	add    $0x10,%esp
  800ff7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ffa:	eb 16                	jmp    801012 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ffc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801000:	83 ec 08             	sub    $0x8,%esp
  801003:	ff 75 0c             	pushl  0xc(%ebp)
  801006:	50                   	push   %eax
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	ff d0                	call   *%eax
  80100c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80100f:	ff 4d e4             	decl   -0x1c(%ebp)
  801012:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801016:	7f e4                	jg     800ffc <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801018:	eb 34                	jmp    80104e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80101a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80101e:	74 1c                	je     80103c <vprintfmt+0x207>
  801020:	83 fb 1f             	cmp    $0x1f,%ebx
  801023:	7e 05                	jle    80102a <vprintfmt+0x1f5>
  801025:	83 fb 7e             	cmp    $0x7e,%ebx
  801028:	7e 12                	jle    80103c <vprintfmt+0x207>
					putch('?', putdat);
  80102a:	83 ec 08             	sub    $0x8,%esp
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	6a 3f                	push   $0x3f
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	ff d0                	call   *%eax
  801037:	83 c4 10             	add    $0x10,%esp
  80103a:	eb 0f                	jmp    80104b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80103c:	83 ec 08             	sub    $0x8,%esp
  80103f:	ff 75 0c             	pushl  0xc(%ebp)
  801042:	53                   	push   %ebx
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	ff d0                	call   *%eax
  801048:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80104b:	ff 4d e4             	decl   -0x1c(%ebp)
  80104e:	89 f0                	mov    %esi,%eax
  801050:	8d 70 01             	lea    0x1(%eax),%esi
  801053:	8a 00                	mov    (%eax),%al
  801055:	0f be d8             	movsbl %al,%ebx
  801058:	85 db                	test   %ebx,%ebx
  80105a:	74 24                	je     801080 <vprintfmt+0x24b>
  80105c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801060:	78 b8                	js     80101a <vprintfmt+0x1e5>
  801062:	ff 4d e0             	decl   -0x20(%ebp)
  801065:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801069:	79 af                	jns    80101a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80106b:	eb 13                	jmp    801080 <vprintfmt+0x24b>
				putch(' ', putdat);
  80106d:	83 ec 08             	sub    $0x8,%esp
  801070:	ff 75 0c             	pushl  0xc(%ebp)
  801073:	6a 20                	push   $0x20
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	ff d0                	call   *%eax
  80107a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80107d:	ff 4d e4             	decl   -0x1c(%ebp)
  801080:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801084:	7f e7                	jg     80106d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801086:	e9 66 01 00 00       	jmp    8011f1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80108b:	83 ec 08             	sub    $0x8,%esp
  80108e:	ff 75 e8             	pushl  -0x18(%ebp)
  801091:	8d 45 14             	lea    0x14(%ebp),%eax
  801094:	50                   	push   %eax
  801095:	e8 3c fd ff ff       	call   800dd6 <getint>
  80109a:	83 c4 10             	add    $0x10,%esp
  80109d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a9:	85 d2                	test   %edx,%edx
  8010ab:	79 23                	jns    8010d0 <vprintfmt+0x29b>
				putch('-', putdat);
  8010ad:	83 ec 08             	sub    $0x8,%esp
  8010b0:	ff 75 0c             	pushl  0xc(%ebp)
  8010b3:	6a 2d                	push   $0x2d
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	ff d0                	call   *%eax
  8010ba:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8010bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c3:	f7 d8                	neg    %eax
  8010c5:	83 d2 00             	adc    $0x0,%edx
  8010c8:	f7 da                	neg    %edx
  8010ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8010d0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010d7:	e9 bc 00 00 00       	jmp    801198 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8010dc:	83 ec 08             	sub    $0x8,%esp
  8010df:	ff 75 e8             	pushl  -0x18(%ebp)
  8010e2:	8d 45 14             	lea    0x14(%ebp),%eax
  8010e5:	50                   	push   %eax
  8010e6:	e8 84 fc ff ff       	call   800d6f <getuint>
  8010eb:	83 c4 10             	add    $0x10,%esp
  8010ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010f4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010fb:	e9 98 00 00 00       	jmp    801198 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801100:	83 ec 08             	sub    $0x8,%esp
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	6a 58                	push   $0x58
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	ff d0                	call   *%eax
  80110d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801110:	83 ec 08             	sub    $0x8,%esp
  801113:	ff 75 0c             	pushl  0xc(%ebp)
  801116:	6a 58                	push   $0x58
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	ff d0                	call   *%eax
  80111d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801120:	83 ec 08             	sub    $0x8,%esp
  801123:	ff 75 0c             	pushl  0xc(%ebp)
  801126:	6a 58                	push   $0x58
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	ff d0                	call   *%eax
  80112d:	83 c4 10             	add    $0x10,%esp
			break;
  801130:	e9 bc 00 00 00       	jmp    8011f1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801135:	83 ec 08             	sub    $0x8,%esp
  801138:	ff 75 0c             	pushl  0xc(%ebp)
  80113b:	6a 30                	push   $0x30
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	ff d0                	call   *%eax
  801142:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801145:	83 ec 08             	sub    $0x8,%esp
  801148:	ff 75 0c             	pushl  0xc(%ebp)
  80114b:	6a 78                	push   $0x78
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	ff d0                	call   *%eax
  801152:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801155:	8b 45 14             	mov    0x14(%ebp),%eax
  801158:	83 c0 04             	add    $0x4,%eax
  80115b:	89 45 14             	mov    %eax,0x14(%ebp)
  80115e:	8b 45 14             	mov    0x14(%ebp),%eax
  801161:	83 e8 04             	sub    $0x4,%eax
  801164:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801166:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801169:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801170:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801177:	eb 1f                	jmp    801198 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801179:	83 ec 08             	sub    $0x8,%esp
  80117c:	ff 75 e8             	pushl  -0x18(%ebp)
  80117f:	8d 45 14             	lea    0x14(%ebp),%eax
  801182:	50                   	push   %eax
  801183:	e8 e7 fb ff ff       	call   800d6f <getuint>
  801188:	83 c4 10             	add    $0x10,%esp
  80118b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80118e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801191:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801198:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80119c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80119f:	83 ec 04             	sub    $0x4,%esp
  8011a2:	52                   	push   %edx
  8011a3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011a6:	50                   	push   %eax
  8011a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8011aa:	ff 75 f0             	pushl  -0x10(%ebp)
  8011ad:	ff 75 0c             	pushl  0xc(%ebp)
  8011b0:	ff 75 08             	pushl  0x8(%ebp)
  8011b3:	e8 00 fb ff ff       	call   800cb8 <printnum>
  8011b8:	83 c4 20             	add    $0x20,%esp
			break;
  8011bb:	eb 34                	jmp    8011f1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8011bd:	83 ec 08             	sub    $0x8,%esp
  8011c0:	ff 75 0c             	pushl  0xc(%ebp)
  8011c3:	53                   	push   %ebx
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	ff d0                	call   *%eax
  8011c9:	83 c4 10             	add    $0x10,%esp
			break;
  8011cc:	eb 23                	jmp    8011f1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8011ce:	83 ec 08             	sub    $0x8,%esp
  8011d1:	ff 75 0c             	pushl  0xc(%ebp)
  8011d4:	6a 25                	push   $0x25
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	ff d0                	call   *%eax
  8011db:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8011de:	ff 4d 10             	decl   0x10(%ebp)
  8011e1:	eb 03                	jmp    8011e6 <vprintfmt+0x3b1>
  8011e3:	ff 4d 10             	decl   0x10(%ebp)
  8011e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e9:	48                   	dec    %eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	3c 25                	cmp    $0x25,%al
  8011ee:	75 f3                	jne    8011e3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011f0:	90                   	nop
		}
	}
  8011f1:	e9 47 fc ff ff       	jmp    800e3d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011f6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8011f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011fa:	5b                   	pop    %ebx
  8011fb:	5e                   	pop    %esi
  8011fc:	5d                   	pop    %ebp
  8011fd:	c3                   	ret    

008011fe <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8011fe:	55                   	push   %ebp
  8011ff:	89 e5                	mov    %esp,%ebp
  801201:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801204:	8d 45 10             	lea    0x10(%ebp),%eax
  801207:	83 c0 04             	add    $0x4,%eax
  80120a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80120d:	8b 45 10             	mov    0x10(%ebp),%eax
  801210:	ff 75 f4             	pushl  -0xc(%ebp)
  801213:	50                   	push   %eax
  801214:	ff 75 0c             	pushl  0xc(%ebp)
  801217:	ff 75 08             	pushl  0x8(%ebp)
  80121a:	e8 16 fc ff ff       	call   800e35 <vprintfmt>
  80121f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801222:	90                   	nop
  801223:	c9                   	leave  
  801224:	c3                   	ret    

00801225 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801225:	55                   	push   %ebp
  801226:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122b:	8b 40 08             	mov    0x8(%eax),%eax
  80122e:	8d 50 01             	lea    0x1(%eax),%edx
  801231:	8b 45 0c             	mov    0xc(%ebp),%eax
  801234:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801237:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123a:	8b 10                	mov    (%eax),%edx
  80123c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123f:	8b 40 04             	mov    0x4(%eax),%eax
  801242:	39 c2                	cmp    %eax,%edx
  801244:	73 12                	jae    801258 <sprintputch+0x33>
		*b->buf++ = ch;
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	8b 00                	mov    (%eax),%eax
  80124b:	8d 48 01             	lea    0x1(%eax),%ecx
  80124e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801251:	89 0a                	mov    %ecx,(%edx)
  801253:	8b 55 08             	mov    0x8(%ebp),%edx
  801256:	88 10                	mov    %dl,(%eax)
}
  801258:	90                   	nop
  801259:	5d                   	pop    %ebp
  80125a:	c3                   	ret    

0080125b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
  80125e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	01 d0                	add    %edx,%eax
  801272:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801275:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80127c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801280:	74 06                	je     801288 <vsnprintf+0x2d>
  801282:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801286:	7f 07                	jg     80128f <vsnprintf+0x34>
		return -E_INVAL;
  801288:	b8 03 00 00 00       	mov    $0x3,%eax
  80128d:	eb 20                	jmp    8012af <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80128f:	ff 75 14             	pushl  0x14(%ebp)
  801292:	ff 75 10             	pushl  0x10(%ebp)
  801295:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801298:	50                   	push   %eax
  801299:	68 25 12 80 00       	push   $0x801225
  80129e:	e8 92 fb ff ff       	call   800e35 <vprintfmt>
  8012a3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012a9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8012ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8012af:	c9                   	leave  
  8012b0:	c3                   	ret    

008012b1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8012b1:	55                   	push   %ebp
  8012b2:	89 e5                	mov    %esp,%ebp
  8012b4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8012b7:	8d 45 10             	lea    0x10(%ebp),%eax
  8012ba:	83 c0 04             	add    $0x4,%eax
  8012bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8012c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8012c6:	50                   	push   %eax
  8012c7:	ff 75 0c             	pushl  0xc(%ebp)
  8012ca:	ff 75 08             	pushl  0x8(%ebp)
  8012cd:	e8 89 ff ff ff       	call   80125b <vsnprintf>
  8012d2:	83 c4 10             	add    $0x10,%esp
  8012d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8012d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012db:	c9                   	leave  
  8012dc:	c3                   	ret    

008012dd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012dd:	55                   	push   %ebp
  8012de:	89 e5                	mov    %esp,%ebp
  8012e0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ea:	eb 06                	jmp    8012f2 <strlen+0x15>
		n++;
  8012ec:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ef:	ff 45 08             	incl   0x8(%ebp)
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	8a 00                	mov    (%eax),%al
  8012f7:	84 c0                	test   %al,%al
  8012f9:	75 f1                	jne    8012ec <strlen+0xf>
		n++;
	return n;
  8012fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
  801303:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80130d:	eb 09                	jmp    801318 <strnlen+0x18>
		n++;
  80130f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801312:	ff 45 08             	incl   0x8(%ebp)
  801315:	ff 4d 0c             	decl   0xc(%ebp)
  801318:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80131c:	74 09                	je     801327 <strnlen+0x27>
  80131e:	8b 45 08             	mov    0x8(%ebp),%eax
  801321:	8a 00                	mov    (%eax),%al
  801323:	84 c0                	test   %al,%al
  801325:	75 e8                	jne    80130f <strnlen+0xf>
		n++;
	return n;
  801327:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
  80132f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801338:	90                   	nop
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8d 50 01             	lea    0x1(%eax),%edx
  80133f:	89 55 08             	mov    %edx,0x8(%ebp)
  801342:	8b 55 0c             	mov    0xc(%ebp),%edx
  801345:	8d 4a 01             	lea    0x1(%edx),%ecx
  801348:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80134b:	8a 12                	mov    (%edx),%dl
  80134d:	88 10                	mov    %dl,(%eax)
  80134f:	8a 00                	mov    (%eax),%al
  801351:	84 c0                	test   %al,%al
  801353:	75 e4                	jne    801339 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801355:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
  80135d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801366:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136d:	eb 1f                	jmp    80138e <strncpy+0x34>
		*dst++ = *src;
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8d 50 01             	lea    0x1(%eax),%edx
  801375:	89 55 08             	mov    %edx,0x8(%ebp)
  801378:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137b:	8a 12                	mov    (%edx),%dl
  80137d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80137f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	84 c0                	test   %al,%al
  801386:	74 03                	je     80138b <strncpy+0x31>
			src++;
  801388:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80138b:	ff 45 fc             	incl   -0x4(%ebp)
  80138e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801391:	3b 45 10             	cmp    0x10(%ebp),%eax
  801394:	72 d9                	jb     80136f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801396:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801399:	c9                   	leave  
  80139a:	c3                   	ret    

0080139b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
  80139e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ab:	74 30                	je     8013dd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013ad:	eb 16                	jmp    8013c5 <strlcpy+0x2a>
			*dst++ = *src++;
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	8d 50 01             	lea    0x1(%eax),%edx
  8013b5:	89 55 08             	mov    %edx,0x8(%ebp)
  8013b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013be:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013c1:	8a 12                	mov    (%edx),%dl
  8013c3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013c5:	ff 4d 10             	decl   0x10(%ebp)
  8013c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cc:	74 09                	je     8013d7 <strlcpy+0x3c>
  8013ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	84 c0                	test   %al,%al
  8013d5:	75 d8                	jne    8013af <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013dd:	8b 55 08             	mov    0x8(%ebp),%edx
  8013e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e3:	29 c2                	sub    %eax,%edx
  8013e5:	89 d0                	mov    %edx,%eax
}
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013ec:	eb 06                	jmp    8013f4 <strcmp+0xb>
		p++, q++;
  8013ee:	ff 45 08             	incl   0x8(%ebp)
  8013f1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8a 00                	mov    (%eax),%al
  8013f9:	84 c0                	test   %al,%al
  8013fb:	74 0e                	je     80140b <strcmp+0x22>
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 10                	mov    (%eax),%dl
  801402:	8b 45 0c             	mov    0xc(%ebp),%eax
  801405:	8a 00                	mov    (%eax),%al
  801407:	38 c2                	cmp    %al,%dl
  801409:	74 e3                	je     8013ee <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	0f b6 d0             	movzbl %al,%edx
  801413:	8b 45 0c             	mov    0xc(%ebp),%eax
  801416:	8a 00                	mov    (%eax),%al
  801418:	0f b6 c0             	movzbl %al,%eax
  80141b:	29 c2                	sub    %eax,%edx
  80141d:	89 d0                	mov    %edx,%eax
}
  80141f:	5d                   	pop    %ebp
  801420:	c3                   	ret    

00801421 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801424:	eb 09                	jmp    80142f <strncmp+0xe>
		n--, p++, q++;
  801426:	ff 4d 10             	decl   0x10(%ebp)
  801429:	ff 45 08             	incl   0x8(%ebp)
  80142c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80142f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801433:	74 17                	je     80144c <strncmp+0x2b>
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	8a 00                	mov    (%eax),%al
  80143a:	84 c0                	test   %al,%al
  80143c:	74 0e                	je     80144c <strncmp+0x2b>
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 10                	mov    (%eax),%dl
  801443:	8b 45 0c             	mov    0xc(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	38 c2                	cmp    %al,%dl
  80144a:	74 da                	je     801426 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80144c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801450:	75 07                	jne    801459 <strncmp+0x38>
		return 0;
  801452:	b8 00 00 00 00       	mov    $0x0,%eax
  801457:	eb 14                	jmp    80146d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	8a 00                	mov    (%eax),%al
  80145e:	0f b6 d0             	movzbl %al,%edx
  801461:	8b 45 0c             	mov    0xc(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	0f b6 c0             	movzbl %al,%eax
  801469:	29 c2                	sub    %eax,%edx
  80146b:	89 d0                	mov    %edx,%eax
}
  80146d:	5d                   	pop    %ebp
  80146e:	c3                   	ret    

0080146f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
  801472:	83 ec 04             	sub    $0x4,%esp
  801475:	8b 45 0c             	mov    0xc(%ebp),%eax
  801478:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80147b:	eb 12                	jmp    80148f <strchr+0x20>
		if (*s == c)
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801485:	75 05                	jne    80148c <strchr+0x1d>
			return (char *) s;
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	eb 11                	jmp    80149d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80148c:	ff 45 08             	incl   0x8(%ebp)
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	84 c0                	test   %al,%al
  801496:	75 e5                	jne    80147d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801498:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
  8014a2:	83 ec 04             	sub    $0x4,%esp
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014ab:	eb 0d                	jmp    8014ba <strfind+0x1b>
		if (*s == c)
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014b5:	74 0e                	je     8014c5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014b7:	ff 45 08             	incl   0x8(%ebp)
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	8a 00                	mov    (%eax),%al
  8014bf:	84 c0                	test   %al,%al
  8014c1:	75 ea                	jne    8014ad <strfind+0xe>
  8014c3:	eb 01                	jmp    8014c6 <strfind+0x27>
		if (*s == c)
			break;
  8014c5:	90                   	nop
	return (char *) s;
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
  8014ce:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014da:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014dd:	eb 0e                	jmp    8014ed <memset+0x22>
		*p++ = c;
  8014df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e2:	8d 50 01             	lea    0x1(%eax),%edx
  8014e5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014eb:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014ed:	ff 4d f8             	decl   -0x8(%ebp)
  8014f0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014f4:	79 e9                	jns    8014df <memset+0x14>
		*p++ = c;

	return v;
  8014f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
  8014fe:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801501:	8b 45 0c             	mov    0xc(%ebp),%eax
  801504:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80150d:	eb 16                	jmp    801525 <memcpy+0x2a>
		*d++ = *s++;
  80150f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801512:	8d 50 01             	lea    0x1(%eax),%edx
  801515:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801518:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80151b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80151e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801521:	8a 12                	mov    (%edx),%dl
  801523:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801525:	8b 45 10             	mov    0x10(%ebp),%eax
  801528:	8d 50 ff             	lea    -0x1(%eax),%edx
  80152b:	89 55 10             	mov    %edx,0x10(%ebp)
  80152e:	85 c0                	test   %eax,%eax
  801530:	75 dd                	jne    80150f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
  80153a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80153d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801540:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80154f:	73 50                	jae    8015a1 <memmove+0x6a>
  801551:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801554:	8b 45 10             	mov    0x10(%ebp),%eax
  801557:	01 d0                	add    %edx,%eax
  801559:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80155c:	76 43                	jbe    8015a1 <memmove+0x6a>
		s += n;
  80155e:	8b 45 10             	mov    0x10(%ebp),%eax
  801561:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801564:	8b 45 10             	mov    0x10(%ebp),%eax
  801567:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80156a:	eb 10                	jmp    80157c <memmove+0x45>
			*--d = *--s;
  80156c:	ff 4d f8             	decl   -0x8(%ebp)
  80156f:	ff 4d fc             	decl   -0x4(%ebp)
  801572:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801575:	8a 10                	mov    (%eax),%dl
  801577:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80157c:	8b 45 10             	mov    0x10(%ebp),%eax
  80157f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801582:	89 55 10             	mov    %edx,0x10(%ebp)
  801585:	85 c0                	test   %eax,%eax
  801587:	75 e3                	jne    80156c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801589:	eb 23                	jmp    8015ae <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80158b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158e:	8d 50 01             	lea    0x1(%eax),%edx
  801591:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801594:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801597:	8d 4a 01             	lea    0x1(%edx),%ecx
  80159a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80159d:	8a 12                	mov    (%edx),%dl
  80159f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015a7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015aa:	85 c0                	test   %eax,%eax
  8015ac:	75 dd                	jne    80158b <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
  8015b6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015c5:	eb 2a                	jmp    8015f1 <memcmp+0x3e>
		if (*s1 != *s2)
  8015c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ca:	8a 10                	mov    (%eax),%dl
  8015cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015cf:	8a 00                	mov    (%eax),%al
  8015d1:	38 c2                	cmp    %al,%dl
  8015d3:	74 16                	je     8015eb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	0f b6 d0             	movzbl %al,%edx
  8015dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e0:	8a 00                	mov    (%eax),%al
  8015e2:	0f b6 c0             	movzbl %al,%eax
  8015e5:	29 c2                	sub    %eax,%edx
  8015e7:	89 d0                	mov    %edx,%eax
  8015e9:	eb 18                	jmp    801603 <memcmp+0x50>
		s1++, s2++;
  8015eb:	ff 45 fc             	incl   -0x4(%ebp)
  8015ee:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015f7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015fa:	85 c0                	test   %eax,%eax
  8015fc:	75 c9                	jne    8015c7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
  801608:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80160b:	8b 55 08             	mov    0x8(%ebp),%edx
  80160e:	8b 45 10             	mov    0x10(%ebp),%eax
  801611:	01 d0                	add    %edx,%eax
  801613:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801616:	eb 15                	jmp    80162d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	0f b6 d0             	movzbl %al,%edx
  801620:	8b 45 0c             	mov    0xc(%ebp),%eax
  801623:	0f b6 c0             	movzbl %al,%eax
  801626:	39 c2                	cmp    %eax,%edx
  801628:	74 0d                	je     801637 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80162a:	ff 45 08             	incl   0x8(%ebp)
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801633:	72 e3                	jb     801618 <memfind+0x13>
  801635:	eb 01                	jmp    801638 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801637:	90                   	nop
	return (void *) s;
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
  801640:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801643:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80164a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801651:	eb 03                	jmp    801656 <strtol+0x19>
		s++;
  801653:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	8a 00                	mov    (%eax),%al
  80165b:	3c 20                	cmp    $0x20,%al
  80165d:	74 f4                	je     801653 <strtol+0x16>
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 09                	cmp    $0x9,%al
  801666:	74 eb                	je     801653 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 2b                	cmp    $0x2b,%al
  80166f:	75 05                	jne    801676 <strtol+0x39>
		s++;
  801671:	ff 45 08             	incl   0x8(%ebp)
  801674:	eb 13                	jmp    801689 <strtol+0x4c>
	else if (*s == '-')
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	3c 2d                	cmp    $0x2d,%al
  80167d:	75 0a                	jne    801689 <strtol+0x4c>
		s++, neg = 1;
  80167f:	ff 45 08             	incl   0x8(%ebp)
  801682:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801689:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80168d:	74 06                	je     801695 <strtol+0x58>
  80168f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801693:	75 20                	jne    8016b5 <strtol+0x78>
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	8a 00                	mov    (%eax),%al
  80169a:	3c 30                	cmp    $0x30,%al
  80169c:	75 17                	jne    8016b5 <strtol+0x78>
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	40                   	inc    %eax
  8016a2:	8a 00                	mov    (%eax),%al
  8016a4:	3c 78                	cmp    $0x78,%al
  8016a6:	75 0d                	jne    8016b5 <strtol+0x78>
		s += 2, base = 16;
  8016a8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016ac:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016b3:	eb 28                	jmp    8016dd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b9:	75 15                	jne    8016d0 <strtol+0x93>
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	3c 30                	cmp    $0x30,%al
  8016c2:	75 0c                	jne    8016d0 <strtol+0x93>
		s++, base = 8;
  8016c4:	ff 45 08             	incl   0x8(%ebp)
  8016c7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016ce:	eb 0d                	jmp    8016dd <strtol+0xa0>
	else if (base == 0)
  8016d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016d4:	75 07                	jne    8016dd <strtol+0xa0>
		base = 10;
  8016d6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	8a 00                	mov    (%eax),%al
  8016e2:	3c 2f                	cmp    $0x2f,%al
  8016e4:	7e 19                	jle    8016ff <strtol+0xc2>
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	3c 39                	cmp    $0x39,%al
  8016ed:	7f 10                	jg     8016ff <strtol+0xc2>
			dig = *s - '0';
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	0f be c0             	movsbl %al,%eax
  8016f7:	83 e8 30             	sub    $0x30,%eax
  8016fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016fd:	eb 42                	jmp    801741 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	8a 00                	mov    (%eax),%al
  801704:	3c 60                	cmp    $0x60,%al
  801706:	7e 19                	jle    801721 <strtol+0xe4>
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	8a 00                	mov    (%eax),%al
  80170d:	3c 7a                	cmp    $0x7a,%al
  80170f:	7f 10                	jg     801721 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	8a 00                	mov    (%eax),%al
  801716:	0f be c0             	movsbl %al,%eax
  801719:	83 e8 57             	sub    $0x57,%eax
  80171c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80171f:	eb 20                	jmp    801741 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	3c 40                	cmp    $0x40,%al
  801728:	7e 39                	jle    801763 <strtol+0x126>
  80172a:	8b 45 08             	mov    0x8(%ebp),%eax
  80172d:	8a 00                	mov    (%eax),%al
  80172f:	3c 5a                	cmp    $0x5a,%al
  801731:	7f 30                	jg     801763 <strtol+0x126>
			dig = *s - 'A' + 10;
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	0f be c0             	movsbl %al,%eax
  80173b:	83 e8 37             	sub    $0x37,%eax
  80173e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801741:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801744:	3b 45 10             	cmp    0x10(%ebp),%eax
  801747:	7d 19                	jge    801762 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801749:	ff 45 08             	incl   0x8(%ebp)
  80174c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80174f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801753:	89 c2                	mov    %eax,%edx
  801755:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801758:	01 d0                	add    %edx,%eax
  80175a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80175d:	e9 7b ff ff ff       	jmp    8016dd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801762:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801763:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801767:	74 08                	je     801771 <strtol+0x134>
		*endptr = (char *) s;
  801769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176c:	8b 55 08             	mov    0x8(%ebp),%edx
  80176f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801771:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801775:	74 07                	je     80177e <strtol+0x141>
  801777:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80177a:	f7 d8                	neg    %eax
  80177c:	eb 03                	jmp    801781 <strtol+0x144>
  80177e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <ltostr>:

void
ltostr(long value, char *str)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
  801786:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801789:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801790:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801797:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80179b:	79 13                	jns    8017b0 <ltostr+0x2d>
	{
		neg = 1;
  80179d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017aa:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017ad:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017b8:	99                   	cltd   
  8017b9:	f7 f9                	idiv   %ecx
  8017bb:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c1:	8d 50 01             	lea    0x1(%eax),%edx
  8017c4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017c7:	89 c2                	mov    %eax,%edx
  8017c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cc:	01 d0                	add    %edx,%eax
  8017ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017d1:	83 c2 30             	add    $0x30,%edx
  8017d4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017d9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017de:	f7 e9                	imul   %ecx
  8017e0:	c1 fa 02             	sar    $0x2,%edx
  8017e3:	89 c8                	mov    %ecx,%eax
  8017e5:	c1 f8 1f             	sar    $0x1f,%eax
  8017e8:	29 c2                	sub    %eax,%edx
  8017ea:	89 d0                	mov    %edx,%eax
  8017ec:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017f2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017f7:	f7 e9                	imul   %ecx
  8017f9:	c1 fa 02             	sar    $0x2,%edx
  8017fc:	89 c8                	mov    %ecx,%eax
  8017fe:	c1 f8 1f             	sar    $0x1f,%eax
  801801:	29 c2                	sub    %eax,%edx
  801803:	89 d0                	mov    %edx,%eax
  801805:	c1 e0 02             	shl    $0x2,%eax
  801808:	01 d0                	add    %edx,%eax
  80180a:	01 c0                	add    %eax,%eax
  80180c:	29 c1                	sub    %eax,%ecx
  80180e:	89 ca                	mov    %ecx,%edx
  801810:	85 d2                	test   %edx,%edx
  801812:	75 9c                	jne    8017b0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801814:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80181b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181e:	48                   	dec    %eax
  80181f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801822:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801826:	74 3d                	je     801865 <ltostr+0xe2>
		start = 1 ;
  801828:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80182f:	eb 34                	jmp    801865 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801831:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801834:	8b 45 0c             	mov    0xc(%ebp),%eax
  801837:	01 d0                	add    %edx,%eax
  801839:	8a 00                	mov    (%eax),%al
  80183b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80183e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801841:	8b 45 0c             	mov    0xc(%ebp),%eax
  801844:	01 c2                	add    %eax,%edx
  801846:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801849:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184c:	01 c8                	add    %ecx,%eax
  80184e:	8a 00                	mov    (%eax),%al
  801850:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801852:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801855:	8b 45 0c             	mov    0xc(%ebp),%eax
  801858:	01 c2                	add    %eax,%edx
  80185a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80185d:	88 02                	mov    %al,(%edx)
		start++ ;
  80185f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801862:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801865:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801868:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80186b:	7c c4                	jl     801831 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80186d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801870:	8b 45 0c             	mov    0xc(%ebp),%eax
  801873:	01 d0                	add    %edx,%eax
  801875:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801878:	90                   	nop
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
  80187e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801881:	ff 75 08             	pushl  0x8(%ebp)
  801884:	e8 54 fa ff ff       	call   8012dd <strlen>
  801889:	83 c4 04             	add    $0x4,%esp
  80188c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80188f:	ff 75 0c             	pushl  0xc(%ebp)
  801892:	e8 46 fa ff ff       	call   8012dd <strlen>
  801897:	83 c4 04             	add    $0x4,%esp
  80189a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80189d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018ab:	eb 17                	jmp    8018c4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8018ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b3:	01 c2                	add    %eax,%edx
  8018b5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	01 c8                	add    %ecx,%eax
  8018bd:	8a 00                	mov    (%eax),%al
  8018bf:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018c1:	ff 45 fc             	incl   -0x4(%ebp)
  8018c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018ca:	7c e1                	jl     8018ad <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018cc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018da:	eb 1f                	jmp    8018fb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018df:	8d 50 01             	lea    0x1(%eax),%edx
  8018e2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018e5:	89 c2                	mov    %eax,%edx
  8018e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ea:	01 c2                	add    %eax,%edx
  8018ec:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f2:	01 c8                	add    %ecx,%eax
  8018f4:	8a 00                	mov    (%eax),%al
  8018f6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018f8:	ff 45 f8             	incl   -0x8(%ebp)
  8018fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801901:	7c d9                	jl     8018dc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801903:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801906:	8b 45 10             	mov    0x10(%ebp),%eax
  801909:	01 d0                	add    %edx,%eax
  80190b:	c6 00 00             	movb   $0x0,(%eax)
}
  80190e:	90                   	nop
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801914:	8b 45 14             	mov    0x14(%ebp),%eax
  801917:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80191d:	8b 45 14             	mov    0x14(%ebp),%eax
  801920:	8b 00                	mov    (%eax),%eax
  801922:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801929:	8b 45 10             	mov    0x10(%ebp),%eax
  80192c:	01 d0                	add    %edx,%eax
  80192e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801934:	eb 0c                	jmp    801942 <strsplit+0x31>
			*string++ = 0;
  801936:	8b 45 08             	mov    0x8(%ebp),%eax
  801939:	8d 50 01             	lea    0x1(%eax),%edx
  80193c:	89 55 08             	mov    %edx,0x8(%ebp)
  80193f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801942:	8b 45 08             	mov    0x8(%ebp),%eax
  801945:	8a 00                	mov    (%eax),%al
  801947:	84 c0                	test   %al,%al
  801949:	74 18                	je     801963 <strsplit+0x52>
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	8a 00                	mov    (%eax),%al
  801950:	0f be c0             	movsbl %al,%eax
  801953:	50                   	push   %eax
  801954:	ff 75 0c             	pushl  0xc(%ebp)
  801957:	e8 13 fb ff ff       	call   80146f <strchr>
  80195c:	83 c4 08             	add    $0x8,%esp
  80195f:	85 c0                	test   %eax,%eax
  801961:	75 d3                	jne    801936 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	84 c0                	test   %al,%al
  80196a:	74 5a                	je     8019c6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80196c:	8b 45 14             	mov    0x14(%ebp),%eax
  80196f:	8b 00                	mov    (%eax),%eax
  801971:	83 f8 0f             	cmp    $0xf,%eax
  801974:	75 07                	jne    80197d <strsplit+0x6c>
		{
			return 0;
  801976:	b8 00 00 00 00       	mov    $0x0,%eax
  80197b:	eb 66                	jmp    8019e3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80197d:	8b 45 14             	mov    0x14(%ebp),%eax
  801980:	8b 00                	mov    (%eax),%eax
  801982:	8d 48 01             	lea    0x1(%eax),%ecx
  801985:	8b 55 14             	mov    0x14(%ebp),%edx
  801988:	89 0a                	mov    %ecx,(%edx)
  80198a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801991:	8b 45 10             	mov    0x10(%ebp),%eax
  801994:	01 c2                	add    %eax,%edx
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80199b:	eb 03                	jmp    8019a0 <strsplit+0x8f>
			string++;
  80199d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	8a 00                	mov    (%eax),%al
  8019a5:	84 c0                	test   %al,%al
  8019a7:	74 8b                	je     801934 <strsplit+0x23>
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	8a 00                	mov    (%eax),%al
  8019ae:	0f be c0             	movsbl %al,%eax
  8019b1:	50                   	push   %eax
  8019b2:	ff 75 0c             	pushl  0xc(%ebp)
  8019b5:	e8 b5 fa ff ff       	call   80146f <strchr>
  8019ba:	83 c4 08             	add    $0x8,%esp
  8019bd:	85 c0                	test   %eax,%eax
  8019bf:	74 dc                	je     80199d <strsplit+0x8c>
			string++;
	}
  8019c1:	e9 6e ff ff ff       	jmp    801934 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019c6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8019ca:	8b 00                	mov    (%eax),%eax
  8019cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d6:	01 d0                	add    %edx,%eax
  8019d8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019de:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019e3:	c9                   	leave  
  8019e4:	c3                   	ret    

008019e5 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019e5:	55                   	push   %ebp
  8019e6:	89 e5                	mov    %esp,%ebp
  8019e8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8019eb:	83 ec 04             	sub    $0x4,%esp
  8019ee:	68 d0 2a 80 00       	push   $0x802ad0
  8019f3:	6a 16                	push   $0x16
  8019f5:	68 f5 2a 80 00       	push   $0x802af5
  8019fa:	e8 ba ef ff ff       	call   8009b9 <_panic>

008019ff <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
  801a02:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a05:	83 ec 04             	sub    $0x4,%esp
  801a08:	68 04 2b 80 00       	push   $0x802b04
  801a0d:	6a 2e                	push   $0x2e
  801a0f:	68 f5 2a 80 00       	push   $0x802af5
  801a14:	e8 a0 ef ff ff       	call   8009b9 <_panic>

00801a19 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
  801a1c:	83 ec 18             	sub    $0x18,%esp
  801a1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a22:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a25:	83 ec 04             	sub    $0x4,%esp
  801a28:	68 28 2b 80 00       	push   $0x802b28
  801a2d:	6a 3b                	push   $0x3b
  801a2f:	68 f5 2a 80 00       	push   $0x802af5
  801a34:	e8 80 ef ff ff       	call   8009b9 <_panic>

00801a39 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a39:	55                   	push   %ebp
  801a3a:	89 e5                	mov    %esp,%ebp
  801a3c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a3f:	83 ec 04             	sub    $0x4,%esp
  801a42:	68 28 2b 80 00       	push   $0x802b28
  801a47:	6a 41                	push   $0x41
  801a49:	68 f5 2a 80 00       	push   $0x802af5
  801a4e:	e8 66 ef ff ff       	call   8009b9 <_panic>

00801a53 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
  801a56:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a59:	83 ec 04             	sub    $0x4,%esp
  801a5c:	68 28 2b 80 00       	push   $0x802b28
  801a61:	6a 47                	push   $0x47
  801a63:	68 f5 2a 80 00       	push   $0x802af5
  801a68:	e8 4c ef ff ff       	call   8009b9 <_panic>

00801a6d <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
  801a70:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a73:	83 ec 04             	sub    $0x4,%esp
  801a76:	68 28 2b 80 00       	push   $0x802b28
  801a7b:	6a 4c                	push   $0x4c
  801a7d:	68 f5 2a 80 00       	push   $0x802af5
  801a82:	e8 32 ef ff ff       	call   8009b9 <_panic>

00801a87 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
  801a8a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a8d:	83 ec 04             	sub    $0x4,%esp
  801a90:	68 28 2b 80 00       	push   $0x802b28
  801a95:	6a 52                	push   $0x52
  801a97:	68 f5 2a 80 00       	push   $0x802af5
  801a9c:	e8 18 ef ff ff       	call   8009b9 <_panic>

00801aa1 <shrink>:
}
void shrink(uint32 newSize)
{
  801aa1:	55                   	push   %ebp
  801aa2:	89 e5                	mov    %esp,%ebp
  801aa4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aa7:	83 ec 04             	sub    $0x4,%esp
  801aaa:	68 28 2b 80 00       	push   $0x802b28
  801aaf:	6a 56                	push   $0x56
  801ab1:	68 f5 2a 80 00       	push   $0x802af5
  801ab6:	e8 fe ee ff ff       	call   8009b9 <_panic>

00801abb <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
  801abe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ac1:	83 ec 04             	sub    $0x4,%esp
  801ac4:	68 28 2b 80 00       	push   $0x802b28
  801ac9:	6a 5b                	push   $0x5b
  801acb:	68 f5 2a 80 00       	push   $0x802af5
  801ad0:	e8 e4 ee ff ff       	call   8009b9 <_panic>

00801ad5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
  801ad8:	57                   	push   %edi
  801ad9:	56                   	push   %esi
  801ada:	53                   	push   %ebx
  801adb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ade:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ae7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aea:	8b 7d 18             	mov    0x18(%ebp),%edi
  801aed:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801af0:	cd 30                	int    $0x30
  801af2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801af8:	83 c4 10             	add    $0x10,%esp
  801afb:	5b                   	pop    %ebx
  801afc:	5e                   	pop    %esi
  801afd:	5f                   	pop    %edi
  801afe:	5d                   	pop    %ebp
  801aff:	c3                   	ret    

00801b00 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
  801b03:	83 ec 04             	sub    $0x4,%esp
  801b06:	8b 45 10             	mov    0x10(%ebp),%eax
  801b09:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b0c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b10:	8b 45 08             	mov    0x8(%ebp),%eax
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	52                   	push   %edx
  801b18:	ff 75 0c             	pushl  0xc(%ebp)
  801b1b:	50                   	push   %eax
  801b1c:	6a 00                	push   $0x0
  801b1e:	e8 b2 ff ff ff       	call   801ad5 <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
}
  801b26:	90                   	nop
  801b27:	c9                   	leave  
  801b28:	c3                   	ret    

00801b29 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 01                	push   $0x1
  801b38:	e8 98 ff ff ff       	call   801ad5 <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b45:	8b 45 08             	mov    0x8(%ebp),%eax
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	50                   	push   %eax
  801b51:	6a 05                	push   $0x5
  801b53:	e8 7d ff ff ff       	call   801ad5 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
}
  801b5b:	c9                   	leave  
  801b5c:	c3                   	ret    

00801b5d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b5d:	55                   	push   %ebp
  801b5e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	6a 02                	push   $0x2
  801b6c:	e8 64 ff ff ff       	call   801ad5 <syscall>
  801b71:	83 c4 18             	add    $0x18,%esp
}
  801b74:	c9                   	leave  
  801b75:	c3                   	ret    

00801b76 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b76:	55                   	push   %ebp
  801b77:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 03                	push   $0x3
  801b85:	e8 4b ff ff ff       	call   801ad5 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
}
  801b8d:	c9                   	leave  
  801b8e:	c3                   	ret    

00801b8f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b8f:	55                   	push   %ebp
  801b90:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 04                	push   $0x4
  801b9e:	e8 32 ff ff ff       	call   801ad5 <syscall>
  801ba3:	83 c4 18             	add    $0x18,%esp
}
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <sys_env_exit>:


void sys_env_exit(void)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 06                	push   $0x6
  801bb7:	e8 19 ff ff ff       	call   801ad5 <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
}
  801bbf:	90                   	nop
  801bc0:	c9                   	leave  
  801bc1:	c3                   	ret    

00801bc2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bc2:	55                   	push   %ebp
  801bc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	52                   	push   %edx
  801bd2:	50                   	push   %eax
  801bd3:	6a 07                	push   $0x7
  801bd5:	e8 fb fe ff ff       	call   801ad5 <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
}
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
  801be2:	56                   	push   %esi
  801be3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801be4:	8b 75 18             	mov    0x18(%ebp),%esi
  801be7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bed:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf3:	56                   	push   %esi
  801bf4:	53                   	push   %ebx
  801bf5:	51                   	push   %ecx
  801bf6:	52                   	push   %edx
  801bf7:	50                   	push   %eax
  801bf8:	6a 08                	push   $0x8
  801bfa:	e8 d6 fe ff ff       	call   801ad5 <syscall>
  801bff:	83 c4 18             	add    $0x18,%esp
}
  801c02:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c05:	5b                   	pop    %ebx
  801c06:	5e                   	pop    %esi
  801c07:	5d                   	pop    %ebp
  801c08:	c3                   	ret    

00801c09 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	52                   	push   %edx
  801c19:	50                   	push   %eax
  801c1a:	6a 09                	push   $0x9
  801c1c:	e8 b4 fe ff ff       	call   801ad5 <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	ff 75 0c             	pushl  0xc(%ebp)
  801c32:	ff 75 08             	pushl  0x8(%ebp)
  801c35:	6a 0a                	push   $0xa
  801c37:	e8 99 fe ff ff       	call   801ad5 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
}
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 0b                	push   $0xb
  801c50:	e8 80 fe ff ff       	call   801ad5 <syscall>
  801c55:	83 c4 18             	add    $0x18,%esp
}
  801c58:	c9                   	leave  
  801c59:	c3                   	ret    

00801c5a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c5a:	55                   	push   %ebp
  801c5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 0c                	push   $0xc
  801c69:	e8 67 fe ff ff       	call   801ad5 <syscall>
  801c6e:	83 c4 18             	add    $0x18,%esp
}
  801c71:	c9                   	leave  
  801c72:	c3                   	ret    

00801c73 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c73:	55                   	push   %ebp
  801c74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 0d                	push   $0xd
  801c82:	e8 4e fe ff ff       	call   801ad5 <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
}
  801c8a:	c9                   	leave  
  801c8b:	c3                   	ret    

00801c8c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	ff 75 0c             	pushl  0xc(%ebp)
  801c98:	ff 75 08             	pushl  0x8(%ebp)
  801c9b:	6a 11                	push   $0x11
  801c9d:	e8 33 fe ff ff       	call   801ad5 <syscall>
  801ca2:	83 c4 18             	add    $0x18,%esp
	return;
  801ca5:	90                   	nop
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	ff 75 0c             	pushl  0xc(%ebp)
  801cb4:	ff 75 08             	pushl  0x8(%ebp)
  801cb7:	6a 12                	push   $0x12
  801cb9:	e8 17 fe ff ff       	call   801ad5 <syscall>
  801cbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc1:	90                   	nop
}
  801cc2:	c9                   	leave  
  801cc3:	c3                   	ret    

00801cc4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cc4:	55                   	push   %ebp
  801cc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 0e                	push   $0xe
  801cd3:	e8 fd fd ff ff       	call   801ad5 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	ff 75 08             	pushl  0x8(%ebp)
  801ceb:	6a 0f                	push   $0xf
  801ced:	e8 e3 fd ff ff       	call   801ad5 <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
}
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 10                	push   $0x10
  801d06:	e8 ca fd ff ff       	call   801ad5 <syscall>
  801d0b:	83 c4 18             	add    $0x18,%esp
}
  801d0e:	90                   	nop
  801d0f:	c9                   	leave  
  801d10:	c3                   	ret    

00801d11 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d11:	55                   	push   %ebp
  801d12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 14                	push   $0x14
  801d20:	e8 b0 fd ff ff       	call   801ad5 <syscall>
  801d25:	83 c4 18             	add    $0x18,%esp
}
  801d28:	90                   	nop
  801d29:	c9                   	leave  
  801d2a:	c3                   	ret    

00801d2b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d2b:	55                   	push   %ebp
  801d2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 15                	push   $0x15
  801d3a:	e8 96 fd ff ff       	call   801ad5 <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
}
  801d42:	90                   	nop
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
  801d48:	83 ec 04             	sub    $0x4,%esp
  801d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d51:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	50                   	push   %eax
  801d5e:	6a 16                	push   $0x16
  801d60:	e8 70 fd ff ff       	call   801ad5 <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
}
  801d68:	90                   	nop
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 17                	push   $0x17
  801d7a:	e8 56 fd ff ff       	call   801ad5 <syscall>
  801d7f:	83 c4 18             	add    $0x18,%esp
}
  801d82:	90                   	nop
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d88:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	ff 75 0c             	pushl  0xc(%ebp)
  801d94:	50                   	push   %eax
  801d95:	6a 18                	push   $0x18
  801d97:	e8 39 fd ff ff       	call   801ad5 <syscall>
  801d9c:	83 c4 18             	add    $0x18,%esp
}
  801d9f:	c9                   	leave  
  801da0:	c3                   	ret    

00801da1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801da4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da7:	8b 45 08             	mov    0x8(%ebp),%eax
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	52                   	push   %edx
  801db1:	50                   	push   %eax
  801db2:	6a 1b                	push   $0x1b
  801db4:	e8 1c fd ff ff       	call   801ad5 <syscall>
  801db9:	83 c4 18             	add    $0x18,%esp
}
  801dbc:	c9                   	leave  
  801dbd:	c3                   	ret    

00801dbe <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	52                   	push   %edx
  801dce:	50                   	push   %eax
  801dcf:	6a 19                	push   $0x19
  801dd1:	e8 ff fc ff ff       	call   801ad5 <syscall>
  801dd6:	83 c4 18             	add    $0x18,%esp
}
  801dd9:	90                   	nop
  801dda:	c9                   	leave  
  801ddb:	c3                   	ret    

00801ddc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ddc:	55                   	push   %ebp
  801ddd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ddf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de2:	8b 45 08             	mov    0x8(%ebp),%eax
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	52                   	push   %edx
  801dec:	50                   	push   %eax
  801ded:	6a 1a                	push   $0x1a
  801def:	e8 e1 fc ff ff       	call   801ad5 <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
}
  801df7:	90                   	nop
  801df8:	c9                   	leave  
  801df9:	c3                   	ret    

00801dfa <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dfa:	55                   	push   %ebp
  801dfb:	89 e5                	mov    %esp,%ebp
  801dfd:	83 ec 04             	sub    $0x4,%esp
  801e00:	8b 45 10             	mov    0x10(%ebp),%eax
  801e03:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e06:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e09:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e10:	6a 00                	push   $0x0
  801e12:	51                   	push   %ecx
  801e13:	52                   	push   %edx
  801e14:	ff 75 0c             	pushl  0xc(%ebp)
  801e17:	50                   	push   %eax
  801e18:	6a 1c                	push   $0x1c
  801e1a:	e8 b6 fc ff ff       	call   801ad5 <syscall>
  801e1f:	83 c4 18             	add    $0x18,%esp
}
  801e22:	c9                   	leave  
  801e23:	c3                   	ret    

00801e24 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e24:	55                   	push   %ebp
  801e25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e27:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	52                   	push   %edx
  801e34:	50                   	push   %eax
  801e35:	6a 1d                	push   $0x1d
  801e37:	e8 99 fc ff ff       	call   801ad5 <syscall>
  801e3c:	83 c4 18             	add    $0x18,%esp
}
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e44:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	51                   	push   %ecx
  801e52:	52                   	push   %edx
  801e53:	50                   	push   %eax
  801e54:	6a 1e                	push   $0x1e
  801e56:	e8 7a fc ff ff       	call   801ad5 <syscall>
  801e5b:	83 c4 18             	add    $0x18,%esp
}
  801e5e:	c9                   	leave  
  801e5f:	c3                   	ret    

00801e60 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e60:	55                   	push   %ebp
  801e61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e63:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e66:	8b 45 08             	mov    0x8(%ebp),%eax
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	52                   	push   %edx
  801e70:	50                   	push   %eax
  801e71:	6a 1f                	push   $0x1f
  801e73:	e8 5d fc ff ff       	call   801ad5 <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
}
  801e7b:	c9                   	leave  
  801e7c:	c3                   	ret    

00801e7d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e7d:	55                   	push   %ebp
  801e7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 20                	push   $0x20
  801e8c:	e8 44 fc ff ff       	call   801ad5 <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
}
  801e94:	c9                   	leave  
  801e95:	c3                   	ret    

00801e96 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e99:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9c:	6a 00                	push   $0x0
  801e9e:	ff 75 14             	pushl  0x14(%ebp)
  801ea1:	ff 75 10             	pushl  0x10(%ebp)
  801ea4:	ff 75 0c             	pushl  0xc(%ebp)
  801ea7:	50                   	push   %eax
  801ea8:	6a 21                	push   $0x21
  801eaa:	e8 26 fc ff ff       	call   801ad5 <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	c9                   	leave  
  801eb3:	c3                   	ret    

00801eb4 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801eb4:	55                   	push   %ebp
  801eb5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	50                   	push   %eax
  801ec3:	6a 22                	push   $0x22
  801ec5:	e8 0b fc ff ff       	call   801ad5 <syscall>
  801eca:	83 c4 18             	add    $0x18,%esp
}
  801ecd:	90                   	nop
  801ece:	c9                   	leave  
  801ecf:	c3                   	ret    

00801ed0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ed0:	55                   	push   %ebp
  801ed1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	50                   	push   %eax
  801edf:	6a 23                	push   $0x23
  801ee1:	e8 ef fb ff ff       	call   801ad5 <syscall>
  801ee6:	83 c4 18             	add    $0x18,%esp
}
  801ee9:	90                   	nop
  801eea:	c9                   	leave  
  801eeb:	c3                   	ret    

00801eec <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801eec:	55                   	push   %ebp
  801eed:	89 e5                	mov    %esp,%ebp
  801eef:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ef2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ef5:	8d 50 04             	lea    0x4(%eax),%edx
  801ef8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	52                   	push   %edx
  801f02:	50                   	push   %eax
  801f03:	6a 24                	push   $0x24
  801f05:	e8 cb fb ff ff       	call   801ad5 <syscall>
  801f0a:	83 c4 18             	add    $0x18,%esp
	return result;
  801f0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f16:	89 01                	mov    %eax,(%ecx)
  801f18:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1e:	c9                   	leave  
  801f1f:	c2 04 00             	ret    $0x4

00801f22 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f22:	55                   	push   %ebp
  801f23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	ff 75 10             	pushl  0x10(%ebp)
  801f2c:	ff 75 0c             	pushl  0xc(%ebp)
  801f2f:	ff 75 08             	pushl  0x8(%ebp)
  801f32:	6a 13                	push   $0x13
  801f34:	e8 9c fb ff ff       	call   801ad5 <syscall>
  801f39:	83 c4 18             	add    $0x18,%esp
	return ;
  801f3c:	90                   	nop
}
  801f3d:	c9                   	leave  
  801f3e:	c3                   	ret    

00801f3f <sys_rcr2>:
uint32 sys_rcr2()
{
  801f3f:	55                   	push   %ebp
  801f40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 25                	push   $0x25
  801f4e:	e8 82 fb ff ff       	call   801ad5 <syscall>
  801f53:	83 c4 18             	add    $0x18,%esp
}
  801f56:	c9                   	leave  
  801f57:	c3                   	ret    

00801f58 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f58:	55                   	push   %ebp
  801f59:	89 e5                	mov    %esp,%ebp
  801f5b:	83 ec 04             	sub    $0x4,%esp
  801f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f61:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f64:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	50                   	push   %eax
  801f71:	6a 26                	push   $0x26
  801f73:	e8 5d fb ff ff       	call   801ad5 <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
	return ;
  801f7b:	90                   	nop
}
  801f7c:	c9                   	leave  
  801f7d:	c3                   	ret    

00801f7e <rsttst>:
void rsttst()
{
  801f7e:	55                   	push   %ebp
  801f7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 28                	push   $0x28
  801f8d:	e8 43 fb ff ff       	call   801ad5 <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
	return ;
  801f95:	90                   	nop
}
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
  801f9b:	83 ec 04             	sub    $0x4,%esp
  801f9e:	8b 45 14             	mov    0x14(%ebp),%eax
  801fa1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801fa4:	8b 55 18             	mov    0x18(%ebp),%edx
  801fa7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fab:	52                   	push   %edx
  801fac:	50                   	push   %eax
  801fad:	ff 75 10             	pushl  0x10(%ebp)
  801fb0:	ff 75 0c             	pushl  0xc(%ebp)
  801fb3:	ff 75 08             	pushl  0x8(%ebp)
  801fb6:	6a 27                	push   $0x27
  801fb8:	e8 18 fb ff ff       	call   801ad5 <syscall>
  801fbd:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc0:	90                   	nop
}
  801fc1:	c9                   	leave  
  801fc2:	c3                   	ret    

00801fc3 <chktst>:
void chktst(uint32 n)
{
  801fc3:	55                   	push   %ebp
  801fc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	ff 75 08             	pushl  0x8(%ebp)
  801fd1:	6a 29                	push   $0x29
  801fd3:	e8 fd fa ff ff       	call   801ad5 <syscall>
  801fd8:	83 c4 18             	add    $0x18,%esp
	return ;
  801fdb:	90                   	nop
}
  801fdc:	c9                   	leave  
  801fdd:	c3                   	ret    

00801fde <inctst>:

void inctst()
{
  801fde:	55                   	push   %ebp
  801fdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 2a                	push   $0x2a
  801fed:	e8 e3 fa ff ff       	call   801ad5 <syscall>
  801ff2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff5:	90                   	nop
}
  801ff6:	c9                   	leave  
  801ff7:	c3                   	ret    

00801ff8 <gettst>:
uint32 gettst()
{
  801ff8:	55                   	push   %ebp
  801ff9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 2b                	push   $0x2b
  802007:	e8 c9 fa ff ff       	call   801ad5 <syscall>
  80200c:	83 c4 18             	add    $0x18,%esp
}
  80200f:	c9                   	leave  
  802010:	c3                   	ret    

00802011 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
  802014:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 2c                	push   $0x2c
  802023:	e8 ad fa ff ff       	call   801ad5 <syscall>
  802028:	83 c4 18             	add    $0x18,%esp
  80202b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80202e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802032:	75 07                	jne    80203b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802034:	b8 01 00 00 00       	mov    $0x1,%eax
  802039:	eb 05                	jmp    802040 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80203b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802040:	c9                   	leave  
  802041:	c3                   	ret    

00802042 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802042:	55                   	push   %ebp
  802043:	89 e5                	mov    %esp,%ebp
  802045:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 2c                	push   $0x2c
  802054:	e8 7c fa ff ff       	call   801ad5 <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
  80205c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80205f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802063:	75 07                	jne    80206c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802065:	b8 01 00 00 00       	mov    $0x1,%eax
  80206a:	eb 05                	jmp    802071 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80206c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802071:	c9                   	leave  
  802072:	c3                   	ret    

00802073 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802073:	55                   	push   %ebp
  802074:	89 e5                	mov    %esp,%ebp
  802076:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	6a 2c                	push   $0x2c
  802085:	e8 4b fa ff ff       	call   801ad5 <syscall>
  80208a:	83 c4 18             	add    $0x18,%esp
  80208d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802090:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802094:	75 07                	jne    80209d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802096:	b8 01 00 00 00       	mov    $0x1,%eax
  80209b:	eb 05                	jmp    8020a2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80209d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020a2:	c9                   	leave  
  8020a3:	c3                   	ret    

008020a4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8020a4:	55                   	push   %ebp
  8020a5:	89 e5                	mov    %esp,%ebp
  8020a7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 2c                	push   $0x2c
  8020b6:	e8 1a fa ff ff       	call   801ad5 <syscall>
  8020bb:	83 c4 18             	add    $0x18,%esp
  8020be:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020c1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020c5:	75 07                	jne    8020ce <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020c7:	b8 01 00 00 00       	mov    $0x1,%eax
  8020cc:	eb 05                	jmp    8020d3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020d3:	c9                   	leave  
  8020d4:	c3                   	ret    

008020d5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020d5:	55                   	push   %ebp
  8020d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	ff 75 08             	pushl  0x8(%ebp)
  8020e3:	6a 2d                	push   $0x2d
  8020e5:	e8 eb f9 ff ff       	call   801ad5 <syscall>
  8020ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ed:	90                   	nop
}
  8020ee:	c9                   	leave  
  8020ef:	c3                   	ret    

008020f0 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020f0:	55                   	push   %ebp
  8020f1:	89 e5                	mov    %esp,%ebp
  8020f3:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020f4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802100:	6a 00                	push   $0x0
  802102:	53                   	push   %ebx
  802103:	51                   	push   %ecx
  802104:	52                   	push   %edx
  802105:	50                   	push   %eax
  802106:	6a 2e                	push   $0x2e
  802108:	e8 c8 f9 ff ff       	call   801ad5 <syscall>
  80210d:	83 c4 18             	add    $0x18,%esp
}
  802110:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802113:	c9                   	leave  
  802114:	c3                   	ret    

00802115 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802115:	55                   	push   %ebp
  802116:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802118:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211b:	8b 45 08             	mov    0x8(%ebp),%eax
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	52                   	push   %edx
  802125:	50                   	push   %eax
  802126:	6a 2f                	push   $0x2f
  802128:	e8 a8 f9 ff ff       	call   801ad5 <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
}
  802130:	c9                   	leave  
  802131:	c3                   	ret    
  802132:	66 90                	xchg   %ax,%ax

00802134 <__udivdi3>:
  802134:	55                   	push   %ebp
  802135:	57                   	push   %edi
  802136:	56                   	push   %esi
  802137:	53                   	push   %ebx
  802138:	83 ec 1c             	sub    $0x1c,%esp
  80213b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80213f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802143:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802147:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80214b:	89 ca                	mov    %ecx,%edx
  80214d:	89 f8                	mov    %edi,%eax
  80214f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802153:	85 f6                	test   %esi,%esi
  802155:	75 2d                	jne    802184 <__udivdi3+0x50>
  802157:	39 cf                	cmp    %ecx,%edi
  802159:	77 65                	ja     8021c0 <__udivdi3+0x8c>
  80215b:	89 fd                	mov    %edi,%ebp
  80215d:	85 ff                	test   %edi,%edi
  80215f:	75 0b                	jne    80216c <__udivdi3+0x38>
  802161:	b8 01 00 00 00       	mov    $0x1,%eax
  802166:	31 d2                	xor    %edx,%edx
  802168:	f7 f7                	div    %edi
  80216a:	89 c5                	mov    %eax,%ebp
  80216c:	31 d2                	xor    %edx,%edx
  80216e:	89 c8                	mov    %ecx,%eax
  802170:	f7 f5                	div    %ebp
  802172:	89 c1                	mov    %eax,%ecx
  802174:	89 d8                	mov    %ebx,%eax
  802176:	f7 f5                	div    %ebp
  802178:	89 cf                	mov    %ecx,%edi
  80217a:	89 fa                	mov    %edi,%edx
  80217c:	83 c4 1c             	add    $0x1c,%esp
  80217f:	5b                   	pop    %ebx
  802180:	5e                   	pop    %esi
  802181:	5f                   	pop    %edi
  802182:	5d                   	pop    %ebp
  802183:	c3                   	ret    
  802184:	39 ce                	cmp    %ecx,%esi
  802186:	77 28                	ja     8021b0 <__udivdi3+0x7c>
  802188:	0f bd fe             	bsr    %esi,%edi
  80218b:	83 f7 1f             	xor    $0x1f,%edi
  80218e:	75 40                	jne    8021d0 <__udivdi3+0x9c>
  802190:	39 ce                	cmp    %ecx,%esi
  802192:	72 0a                	jb     80219e <__udivdi3+0x6a>
  802194:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802198:	0f 87 9e 00 00 00    	ja     80223c <__udivdi3+0x108>
  80219e:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a3:	89 fa                	mov    %edi,%edx
  8021a5:	83 c4 1c             	add    $0x1c,%esp
  8021a8:	5b                   	pop    %ebx
  8021a9:	5e                   	pop    %esi
  8021aa:	5f                   	pop    %edi
  8021ab:	5d                   	pop    %ebp
  8021ac:	c3                   	ret    
  8021ad:	8d 76 00             	lea    0x0(%esi),%esi
  8021b0:	31 ff                	xor    %edi,%edi
  8021b2:	31 c0                	xor    %eax,%eax
  8021b4:	89 fa                	mov    %edi,%edx
  8021b6:	83 c4 1c             	add    $0x1c,%esp
  8021b9:	5b                   	pop    %ebx
  8021ba:	5e                   	pop    %esi
  8021bb:	5f                   	pop    %edi
  8021bc:	5d                   	pop    %ebp
  8021bd:	c3                   	ret    
  8021be:	66 90                	xchg   %ax,%ax
  8021c0:	89 d8                	mov    %ebx,%eax
  8021c2:	f7 f7                	div    %edi
  8021c4:	31 ff                	xor    %edi,%edi
  8021c6:	89 fa                	mov    %edi,%edx
  8021c8:	83 c4 1c             	add    $0x1c,%esp
  8021cb:	5b                   	pop    %ebx
  8021cc:	5e                   	pop    %esi
  8021cd:	5f                   	pop    %edi
  8021ce:	5d                   	pop    %ebp
  8021cf:	c3                   	ret    
  8021d0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021d5:	89 eb                	mov    %ebp,%ebx
  8021d7:	29 fb                	sub    %edi,%ebx
  8021d9:	89 f9                	mov    %edi,%ecx
  8021db:	d3 e6                	shl    %cl,%esi
  8021dd:	89 c5                	mov    %eax,%ebp
  8021df:	88 d9                	mov    %bl,%cl
  8021e1:	d3 ed                	shr    %cl,%ebp
  8021e3:	89 e9                	mov    %ebp,%ecx
  8021e5:	09 f1                	or     %esi,%ecx
  8021e7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021eb:	89 f9                	mov    %edi,%ecx
  8021ed:	d3 e0                	shl    %cl,%eax
  8021ef:	89 c5                	mov    %eax,%ebp
  8021f1:	89 d6                	mov    %edx,%esi
  8021f3:	88 d9                	mov    %bl,%cl
  8021f5:	d3 ee                	shr    %cl,%esi
  8021f7:	89 f9                	mov    %edi,%ecx
  8021f9:	d3 e2                	shl    %cl,%edx
  8021fb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ff:	88 d9                	mov    %bl,%cl
  802201:	d3 e8                	shr    %cl,%eax
  802203:	09 c2                	or     %eax,%edx
  802205:	89 d0                	mov    %edx,%eax
  802207:	89 f2                	mov    %esi,%edx
  802209:	f7 74 24 0c          	divl   0xc(%esp)
  80220d:	89 d6                	mov    %edx,%esi
  80220f:	89 c3                	mov    %eax,%ebx
  802211:	f7 e5                	mul    %ebp
  802213:	39 d6                	cmp    %edx,%esi
  802215:	72 19                	jb     802230 <__udivdi3+0xfc>
  802217:	74 0b                	je     802224 <__udivdi3+0xf0>
  802219:	89 d8                	mov    %ebx,%eax
  80221b:	31 ff                	xor    %edi,%edi
  80221d:	e9 58 ff ff ff       	jmp    80217a <__udivdi3+0x46>
  802222:	66 90                	xchg   %ax,%ax
  802224:	8b 54 24 08          	mov    0x8(%esp),%edx
  802228:	89 f9                	mov    %edi,%ecx
  80222a:	d3 e2                	shl    %cl,%edx
  80222c:	39 c2                	cmp    %eax,%edx
  80222e:	73 e9                	jae    802219 <__udivdi3+0xe5>
  802230:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802233:	31 ff                	xor    %edi,%edi
  802235:	e9 40 ff ff ff       	jmp    80217a <__udivdi3+0x46>
  80223a:	66 90                	xchg   %ax,%ax
  80223c:	31 c0                	xor    %eax,%eax
  80223e:	e9 37 ff ff ff       	jmp    80217a <__udivdi3+0x46>
  802243:	90                   	nop

00802244 <__umoddi3>:
  802244:	55                   	push   %ebp
  802245:	57                   	push   %edi
  802246:	56                   	push   %esi
  802247:	53                   	push   %ebx
  802248:	83 ec 1c             	sub    $0x1c,%esp
  80224b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80224f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802253:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802257:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80225b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80225f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802263:	89 f3                	mov    %esi,%ebx
  802265:	89 fa                	mov    %edi,%edx
  802267:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80226b:	89 34 24             	mov    %esi,(%esp)
  80226e:	85 c0                	test   %eax,%eax
  802270:	75 1a                	jne    80228c <__umoddi3+0x48>
  802272:	39 f7                	cmp    %esi,%edi
  802274:	0f 86 a2 00 00 00    	jbe    80231c <__umoddi3+0xd8>
  80227a:	89 c8                	mov    %ecx,%eax
  80227c:	89 f2                	mov    %esi,%edx
  80227e:	f7 f7                	div    %edi
  802280:	89 d0                	mov    %edx,%eax
  802282:	31 d2                	xor    %edx,%edx
  802284:	83 c4 1c             	add    $0x1c,%esp
  802287:	5b                   	pop    %ebx
  802288:	5e                   	pop    %esi
  802289:	5f                   	pop    %edi
  80228a:	5d                   	pop    %ebp
  80228b:	c3                   	ret    
  80228c:	39 f0                	cmp    %esi,%eax
  80228e:	0f 87 ac 00 00 00    	ja     802340 <__umoddi3+0xfc>
  802294:	0f bd e8             	bsr    %eax,%ebp
  802297:	83 f5 1f             	xor    $0x1f,%ebp
  80229a:	0f 84 ac 00 00 00    	je     80234c <__umoddi3+0x108>
  8022a0:	bf 20 00 00 00       	mov    $0x20,%edi
  8022a5:	29 ef                	sub    %ebp,%edi
  8022a7:	89 fe                	mov    %edi,%esi
  8022a9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022ad:	89 e9                	mov    %ebp,%ecx
  8022af:	d3 e0                	shl    %cl,%eax
  8022b1:	89 d7                	mov    %edx,%edi
  8022b3:	89 f1                	mov    %esi,%ecx
  8022b5:	d3 ef                	shr    %cl,%edi
  8022b7:	09 c7                	or     %eax,%edi
  8022b9:	89 e9                	mov    %ebp,%ecx
  8022bb:	d3 e2                	shl    %cl,%edx
  8022bd:	89 14 24             	mov    %edx,(%esp)
  8022c0:	89 d8                	mov    %ebx,%eax
  8022c2:	d3 e0                	shl    %cl,%eax
  8022c4:	89 c2                	mov    %eax,%edx
  8022c6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ca:	d3 e0                	shl    %cl,%eax
  8022cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022d0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022d4:	89 f1                	mov    %esi,%ecx
  8022d6:	d3 e8                	shr    %cl,%eax
  8022d8:	09 d0                	or     %edx,%eax
  8022da:	d3 eb                	shr    %cl,%ebx
  8022dc:	89 da                	mov    %ebx,%edx
  8022de:	f7 f7                	div    %edi
  8022e0:	89 d3                	mov    %edx,%ebx
  8022e2:	f7 24 24             	mull   (%esp)
  8022e5:	89 c6                	mov    %eax,%esi
  8022e7:	89 d1                	mov    %edx,%ecx
  8022e9:	39 d3                	cmp    %edx,%ebx
  8022eb:	0f 82 87 00 00 00    	jb     802378 <__umoddi3+0x134>
  8022f1:	0f 84 91 00 00 00    	je     802388 <__umoddi3+0x144>
  8022f7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022fb:	29 f2                	sub    %esi,%edx
  8022fd:	19 cb                	sbb    %ecx,%ebx
  8022ff:	89 d8                	mov    %ebx,%eax
  802301:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802305:	d3 e0                	shl    %cl,%eax
  802307:	89 e9                	mov    %ebp,%ecx
  802309:	d3 ea                	shr    %cl,%edx
  80230b:	09 d0                	or     %edx,%eax
  80230d:	89 e9                	mov    %ebp,%ecx
  80230f:	d3 eb                	shr    %cl,%ebx
  802311:	89 da                	mov    %ebx,%edx
  802313:	83 c4 1c             	add    $0x1c,%esp
  802316:	5b                   	pop    %ebx
  802317:	5e                   	pop    %esi
  802318:	5f                   	pop    %edi
  802319:	5d                   	pop    %ebp
  80231a:	c3                   	ret    
  80231b:	90                   	nop
  80231c:	89 fd                	mov    %edi,%ebp
  80231e:	85 ff                	test   %edi,%edi
  802320:	75 0b                	jne    80232d <__umoddi3+0xe9>
  802322:	b8 01 00 00 00       	mov    $0x1,%eax
  802327:	31 d2                	xor    %edx,%edx
  802329:	f7 f7                	div    %edi
  80232b:	89 c5                	mov    %eax,%ebp
  80232d:	89 f0                	mov    %esi,%eax
  80232f:	31 d2                	xor    %edx,%edx
  802331:	f7 f5                	div    %ebp
  802333:	89 c8                	mov    %ecx,%eax
  802335:	f7 f5                	div    %ebp
  802337:	89 d0                	mov    %edx,%eax
  802339:	e9 44 ff ff ff       	jmp    802282 <__umoddi3+0x3e>
  80233e:	66 90                	xchg   %ax,%ax
  802340:	89 c8                	mov    %ecx,%eax
  802342:	89 f2                	mov    %esi,%edx
  802344:	83 c4 1c             	add    $0x1c,%esp
  802347:	5b                   	pop    %ebx
  802348:	5e                   	pop    %esi
  802349:	5f                   	pop    %edi
  80234a:	5d                   	pop    %ebp
  80234b:	c3                   	ret    
  80234c:	3b 04 24             	cmp    (%esp),%eax
  80234f:	72 06                	jb     802357 <__umoddi3+0x113>
  802351:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802355:	77 0f                	ja     802366 <__umoddi3+0x122>
  802357:	89 f2                	mov    %esi,%edx
  802359:	29 f9                	sub    %edi,%ecx
  80235b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80235f:	89 14 24             	mov    %edx,(%esp)
  802362:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802366:	8b 44 24 04          	mov    0x4(%esp),%eax
  80236a:	8b 14 24             	mov    (%esp),%edx
  80236d:	83 c4 1c             	add    $0x1c,%esp
  802370:	5b                   	pop    %ebx
  802371:	5e                   	pop    %esi
  802372:	5f                   	pop    %edi
  802373:	5d                   	pop    %ebp
  802374:	c3                   	ret    
  802375:	8d 76 00             	lea    0x0(%esi),%esi
  802378:	2b 04 24             	sub    (%esp),%eax
  80237b:	19 fa                	sbb    %edi,%edx
  80237d:	89 d1                	mov    %edx,%ecx
  80237f:	89 c6                	mov    %eax,%esi
  802381:	e9 71 ff ff ff       	jmp    8022f7 <__umoddi3+0xb3>
  802386:	66 90                	xchg   %ax,%ax
  802388:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80238c:	72 ea                	jb     802378 <__umoddi3+0x134>
  80238e:	89 d9                	mov    %ebx,%ecx
  802390:	e9 62 ff ff ff       	jmp    8022f7 <__umoddi3+0xb3>
