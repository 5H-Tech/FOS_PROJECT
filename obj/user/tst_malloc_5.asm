
obj/user/tst_malloc_5:     file format elf32-i386


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
  800031:	e8 69 03 00 00       	call   80039f <libmain>
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
  80003c:	81 ec 94 00 00 00    	sub    $0x94,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800042:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800046:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004d:	eb 23                	jmp    800072 <_main+0x3a>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004f:	a1 20 30 80 00       	mov    0x803020,%eax
  800054:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80005a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005d:	c1 e2 04             	shl    $0x4,%edx
  800060:	01 d0                	add    %edx,%eax
  800062:	8a 40 04             	mov    0x4(%eax),%al
  800065:	84 c0                	test   %al,%al
  800067:	74 06                	je     80006f <_main+0x37>
			{
				fullWS = 0;
  800069:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006d:	eb 12                	jmp    800081 <_main+0x49>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006f:	ff 45 f0             	incl   -0x10(%ebp)
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 50 74             	mov    0x74(%eax),%edx
  80007a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007d:	39 c2                	cmp    %eax,%edx
  80007f:	77 ce                	ja     80004f <_main+0x17>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800081:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800085:	74 14                	je     80009b <_main+0x63>
  800087:	83 ec 04             	sub    $0x4,%esp
  80008a:	68 60 21 80 00       	push   $0x802160
  80008f:	6a 1a                	push   $0x1a
  800091:	68 7c 21 80 00       	push   $0x80217c
  800096:	e8 49 04 00 00       	call   8004e4 <_panic>
	}


	int Mega = 1024*1024;
  80009b:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a2:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	char minByte = 1<<7;
  8000a9:	c6 45 e7 80          	movb   $0x80,-0x19(%ebp)
	char maxByte = 0x7F;
  8000ad:	c6 45 e6 7f          	movb   $0x7f,-0x1a(%ebp)
	short minShort = 1<<15 ;
  8000b1:	66 c7 45 e4 00 80    	movw   $0x8000,-0x1c(%ebp)
	short maxShort = 0x7FFF;
  8000b7:	66 c7 45 e2 ff 7f    	movw   $0x7fff,-0x1e(%ebp)
	int minInt = 1<<31 ;
  8000bd:	c7 45 dc 00 00 00 80 	movl   $0x80000000,-0x24(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000c4:	c7 45 d8 ff ff ff 7f 	movl   $0x7fffffff,-0x28(%ebp)

	void* ptr_allocations[20] = {0};
  8000cb:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
  8000d1:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8000db:	89 d7                	mov    %edx,%edi
  8000dd:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	01 c0                	add    %eax,%eax
  8000e4:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e7:	83 ec 0c             	sub    $0xc,%esp
  8000ea:	50                   	push   %eax
  8000eb:	e8 20 14 00 00       	call   801510 <malloc>
  8000f0:	83 c4 10             	add    $0x10,%esp
  8000f3:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  8000f9:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  8000ff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800102:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800105:	01 c0                	add    %eax,%eax
  800107:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80010a:	48                   	dec    %eax
  80010b:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = minByte ;
  80010e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800111:	8a 55 e7             	mov    -0x19(%ebp),%dl
  800114:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800116:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800119:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80011c:	01 c2                	add    %eax,%edx
  80011e:	8a 45 e6             	mov    -0x1a(%ebp),%al
  800121:	88 02                	mov    %al,(%edx)

		ptr_allocations[1] = malloc(2*Mega-kilo);
  800123:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800126:	01 c0                	add    %eax,%eax
  800128:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80012b:	83 ec 0c             	sub    $0xc,%esp
  80012e:	50                   	push   %eax
  80012f:	e8 dc 13 00 00       	call   801510 <malloc>
  800134:	83 c4 10             	add    $0x10,%esp
  800137:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  80013d:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800143:	89 45 cc             	mov    %eax,-0x34(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800146:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800149:	01 c0                	add    %eax,%eax
  80014b:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80014e:	d1 e8                	shr    %eax
  800150:	48                   	dec    %eax
  800151:	89 45 c8             	mov    %eax,-0x38(%ebp)
		shortArr[0] = minShort;
  800154:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800157:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80015a:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  80015d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800160:	01 c0                	add    %eax,%eax
  800162:	89 c2                	mov    %eax,%edx
  800164:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800167:	01 c2                	add    %eax,%edx
  800169:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
  80016d:	66 89 02             	mov    %ax,(%edx)

		ptr_allocations[2] = malloc(2*kilo);
  800170:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800173:	01 c0                	add    %eax,%eax
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	50                   	push   %eax
  800179:	e8 92 13 00 00       	call   801510 <malloc>
  80017e:	83 c4 10             	add    $0x10,%esp
  800181:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  800187:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80018d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800190:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800193:	01 c0                	add    %eax,%eax
  800195:	c1 e8 02             	shr    $0x2,%eax
  800198:	48                   	dec    %eax
  800199:	89 45 c0             	mov    %eax,-0x40(%ebp)
		intArr[0] = minInt;
  80019c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80019f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8001a2:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8001a4:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001ae:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001b1:	01 c2                	add    %eax,%edx
  8001b3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001b6:	89 02                	mov    %eax,(%edx)

		ptr_allocations[3] = malloc(7*kilo);
  8001b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001bb:	89 d0                	mov    %edx,%eax
  8001bd:	01 c0                	add    %eax,%eax
  8001bf:	01 d0                	add    %edx,%eax
  8001c1:	01 c0                	add    %eax,%eax
  8001c3:	01 d0                	add    %edx,%eax
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	50                   	push   %eax
  8001c9:	e8 42 13 00 00       	call   801510 <malloc>
  8001ce:	83 c4 10             	add    $0x10,%esp
  8001d1:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  8001d7:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8001dd:	89 45 bc             	mov    %eax,-0x44(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  8001e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001e3:	89 d0                	mov    %edx,%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	01 d0                	add    %edx,%eax
  8001e9:	01 c0                	add    %eax,%eax
  8001eb:	01 d0                	add    %edx,%eax
  8001ed:	c1 e8 03             	shr    $0x3,%eax
  8001f0:	48                   	dec    %eax
  8001f1:	89 45 b8             	mov    %eax,-0x48(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8001f4:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001f7:	8a 55 e7             	mov    -0x19(%ebp),%dl
  8001fa:	88 10                	mov    %dl,(%eax)
  8001fc:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8001ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800202:	66 89 42 02          	mov    %ax,0x2(%edx)
  800206:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800209:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80020c:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  80020f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800212:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800219:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80021c:	01 c2                	add    %eax,%edx
  80021e:	8a 45 e6             	mov    -0x1a(%ebp),%al
  800221:	88 02                	mov    %al,(%edx)
  800223:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800226:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80022d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800230:	01 c2                	add    %eax,%edx
  800232:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
  800236:	66 89 42 02          	mov    %ax,0x2(%edx)
  80023a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80023d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800244:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800247:	01 c2                	add    %eax,%edx
  800249:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80024c:	89 42 04             	mov    %eax,0x4(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  80024f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800252:	8a 00                	mov    (%eax),%al
  800254:	3a 45 e7             	cmp    -0x19(%ebp),%al
  800257:	75 0f                	jne    800268 <_main+0x230>
  800259:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80025c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80025f:	01 d0                	add    %edx,%eax
  800261:	8a 00                	mov    (%eax),%al
  800263:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  800266:	74 14                	je     80027c <_main+0x244>
  800268:	83 ec 04             	sub    $0x4,%esp
  80026b:	68 90 21 80 00       	push   $0x802190
  800270:	6a 42                	push   $0x42
  800272:	68 7c 21 80 00       	push   $0x80217c
  800277:	e8 68 02 00 00       	call   8004e4 <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  80027c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80027f:	66 8b 00             	mov    (%eax),%ax
  800282:	66 3b 45 e4          	cmp    -0x1c(%ebp),%ax
  800286:	75 15                	jne    80029d <_main+0x265>
  800288:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80028b:	01 c0                	add    %eax,%eax
  80028d:	89 c2                	mov    %eax,%edx
  80028f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800292:	01 d0                	add    %edx,%eax
  800294:	66 8b 00             	mov    (%eax),%ax
  800297:	66 3b 45 e2          	cmp    -0x1e(%ebp),%ax
  80029b:	74 14                	je     8002b1 <_main+0x279>
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	68 90 21 80 00       	push   $0x802190
  8002a5:	6a 43                	push   $0x43
  8002a7:	68 7c 21 80 00       	push   $0x80217c
  8002ac:	e8 33 02 00 00       	call   8004e4 <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  8002b1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002b4:	8b 00                	mov    (%eax),%eax
  8002b6:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8002b9:	75 16                	jne    8002d1 <_main+0x299>
  8002bb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002c8:	01 d0                	add    %edx,%eax
  8002ca:	8b 00                	mov    (%eax),%eax
  8002cc:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8002cf:	74 14                	je     8002e5 <_main+0x2ad>
  8002d1:	83 ec 04             	sub    $0x4,%esp
  8002d4:	68 90 21 80 00       	push   $0x802190
  8002d9:	6a 44                	push   $0x44
  8002db:	68 7c 21 80 00       	push   $0x80217c
  8002e0:	e8 ff 01 00 00       	call   8004e4 <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002e5:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002e8:	8a 00                	mov    (%eax),%al
  8002ea:	3a 45 e7             	cmp    -0x19(%ebp),%al
  8002ed:	75 16                	jne    800305 <_main+0x2cd>
  8002ef:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002f9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002fc:	01 d0                	add    %edx,%eax
  8002fe:	8a 00                	mov    (%eax),%al
  800300:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  800303:	74 14                	je     800319 <_main+0x2e1>
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	68 90 21 80 00       	push   $0x802190
  80030d:	6a 46                	push   $0x46
  80030f:	68 7c 21 80 00       	push   $0x80217c
  800314:	e8 cb 01 00 00       	call   8004e4 <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  800319:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80031c:	66 8b 40 02          	mov    0x2(%eax),%ax
  800320:	66 3b 45 e4          	cmp    -0x1c(%ebp),%ax
  800324:	75 19                	jne    80033f <_main+0x307>
  800326:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800329:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800330:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800333:	01 d0                	add    %edx,%eax
  800335:	66 8b 40 02          	mov    0x2(%eax),%ax
  800339:	66 3b 45 e2          	cmp    -0x1e(%ebp),%ax
  80033d:	74 14                	je     800353 <_main+0x31b>
  80033f:	83 ec 04             	sub    $0x4,%esp
  800342:	68 90 21 80 00       	push   $0x802190
  800347:	6a 47                	push   $0x47
  800349:	68 7c 21 80 00       	push   $0x80217c
  80034e:	e8 91 01 00 00       	call   8004e4 <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  800353:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800356:	8b 40 04             	mov    0x4(%eax),%eax
  800359:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80035c:	75 17                	jne    800375 <_main+0x33d>
  80035e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800361:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800368:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80036b:	01 d0                	add    %edx,%eax
  80036d:	8b 40 04             	mov    0x4(%eax),%eax
  800370:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800373:	74 14                	je     800389 <_main+0x351>
  800375:	83 ec 04             	sub    $0x4,%esp
  800378:	68 90 21 80 00       	push   $0x802190
  80037d:	6a 48                	push   $0x48
  80037f:	68 7c 21 80 00       	push   $0x80217c
  800384:	e8 5b 01 00 00       	call   8004e4 <_panic>


	}

	cprintf("Congratulations!! test malloc (5) completed successfully.\n");
  800389:	83 ec 0c             	sub    $0xc,%esp
  80038c:	68 c8 21 80 00       	push   $0x8021c8
  800391:	e8 f0 03 00 00       	call   800786 <cprintf>
  800396:	83 c4 10             	add    $0x10,%esp

	return;
  800399:	90                   	nop
}
  80039a:	8b 7d fc             	mov    -0x4(%ebp),%edi
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003a5:	e8 82 15 00 00       	call   80192c <sys_getenvindex>
  8003aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b0:	89 d0                	mov    %edx,%eax
  8003b2:	c1 e0 03             	shl    $0x3,%eax
  8003b5:	01 d0                	add    %edx,%eax
  8003b7:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8003be:	01 c8                	add    %ecx,%eax
  8003c0:	01 c0                	add    %eax,%eax
  8003c2:	01 d0                	add    %edx,%eax
  8003c4:	01 c0                	add    %eax,%eax
  8003c6:	01 d0                	add    %edx,%eax
  8003c8:	89 c2                	mov    %eax,%edx
  8003ca:	c1 e2 05             	shl    $0x5,%edx
  8003cd:	29 c2                	sub    %eax,%edx
  8003cf:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8003d6:	89 c2                	mov    %eax,%edx
  8003d8:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8003de:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e8:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003ee:	84 c0                	test   %al,%al
  8003f0:	74 0f                	je     800401 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f7:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003fc:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800401:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800405:	7e 0a                	jle    800411 <libmain+0x72>
		binaryname = argv[0];
  800407:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800411:	83 ec 08             	sub    $0x8,%esp
  800414:	ff 75 0c             	pushl  0xc(%ebp)
  800417:	ff 75 08             	pushl  0x8(%ebp)
  80041a:	e8 19 fc ff ff       	call   800038 <_main>
  80041f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800422:	e8 a0 16 00 00       	call   801ac7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800427:	83 ec 0c             	sub    $0xc,%esp
  80042a:	68 1c 22 80 00       	push   $0x80221c
  80042f:	e8 52 03 00 00       	call   800786 <cprintf>
  800434:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800437:	a1 20 30 80 00       	mov    0x803020,%eax
  80043c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800442:	a1 20 30 80 00       	mov    0x803020,%eax
  800447:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80044d:	83 ec 04             	sub    $0x4,%esp
  800450:	52                   	push   %edx
  800451:	50                   	push   %eax
  800452:	68 44 22 80 00       	push   $0x802244
  800457:	e8 2a 03 00 00       	call   800786 <cprintf>
  80045c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80045f:	a1 20 30 80 00       	mov    0x803020,%eax
  800464:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80046a:	a1 20 30 80 00       	mov    0x803020,%eax
  80046f:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800475:	83 ec 04             	sub    $0x4,%esp
  800478:	52                   	push   %edx
  800479:	50                   	push   %eax
  80047a:	68 6c 22 80 00       	push   $0x80226c
  80047f:	e8 02 03 00 00       	call   800786 <cprintf>
  800484:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800487:	a1 20 30 80 00       	mov    0x803020,%eax
  80048c:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 ad 22 80 00       	push   $0x8022ad
  80049b:	e8 e6 02 00 00       	call   800786 <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004a3:	83 ec 0c             	sub    $0xc,%esp
  8004a6:	68 1c 22 80 00       	push   $0x80221c
  8004ab:	e8 d6 02 00 00       	call   800786 <cprintf>
  8004b0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004b3:	e8 29 16 00 00       	call   801ae1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004b8:	e8 19 00 00 00       	call   8004d6 <exit>
}
  8004bd:	90                   	nop
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004c6:	83 ec 0c             	sub    $0xc,%esp
  8004c9:	6a 00                	push   $0x0
  8004cb:	e8 28 14 00 00       	call   8018f8 <sys_env_destroy>
  8004d0:	83 c4 10             	add    $0x10,%esp
}
  8004d3:	90                   	nop
  8004d4:	c9                   	leave  
  8004d5:	c3                   	ret    

008004d6 <exit>:

void
exit(void)
{
  8004d6:	55                   	push   %ebp
  8004d7:	89 e5                	mov    %esp,%ebp
  8004d9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004dc:	e8 7d 14 00 00       	call   80195e <sys_env_exit>
}
  8004e1:	90                   	nop
  8004e2:	c9                   	leave  
  8004e3:	c3                   	ret    

008004e4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004e4:	55                   	push   %ebp
  8004e5:	89 e5                	mov    %esp,%ebp
  8004e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8004ed:	83 c0 04             	add    $0x4,%eax
  8004f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004f3:	a1 18 31 80 00       	mov    0x803118,%eax
  8004f8:	85 c0                	test   %eax,%eax
  8004fa:	74 16                	je     800512 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004fc:	a1 18 31 80 00       	mov    0x803118,%eax
  800501:	83 ec 08             	sub    $0x8,%esp
  800504:	50                   	push   %eax
  800505:	68 c4 22 80 00       	push   $0x8022c4
  80050a:	e8 77 02 00 00       	call   800786 <cprintf>
  80050f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800512:	a1 00 30 80 00       	mov    0x803000,%eax
  800517:	ff 75 0c             	pushl  0xc(%ebp)
  80051a:	ff 75 08             	pushl  0x8(%ebp)
  80051d:	50                   	push   %eax
  80051e:	68 c9 22 80 00       	push   $0x8022c9
  800523:	e8 5e 02 00 00       	call   800786 <cprintf>
  800528:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80052b:	8b 45 10             	mov    0x10(%ebp),%eax
  80052e:	83 ec 08             	sub    $0x8,%esp
  800531:	ff 75 f4             	pushl  -0xc(%ebp)
  800534:	50                   	push   %eax
  800535:	e8 e1 01 00 00       	call   80071b <vcprintf>
  80053a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80053d:	83 ec 08             	sub    $0x8,%esp
  800540:	6a 00                	push   $0x0
  800542:	68 e5 22 80 00       	push   $0x8022e5
  800547:	e8 cf 01 00 00       	call   80071b <vcprintf>
  80054c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80054f:	e8 82 ff ff ff       	call   8004d6 <exit>

	// should not return here
	while (1) ;
  800554:	eb fe                	jmp    800554 <_panic+0x70>

00800556 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800556:	55                   	push   %ebp
  800557:	89 e5                	mov    %esp,%ebp
  800559:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80055c:	a1 20 30 80 00       	mov    0x803020,%eax
  800561:	8b 50 74             	mov    0x74(%eax),%edx
  800564:	8b 45 0c             	mov    0xc(%ebp),%eax
  800567:	39 c2                	cmp    %eax,%edx
  800569:	74 14                	je     80057f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80056b:	83 ec 04             	sub    $0x4,%esp
  80056e:	68 e8 22 80 00       	push   $0x8022e8
  800573:	6a 26                	push   $0x26
  800575:	68 34 23 80 00       	push   $0x802334
  80057a:	e8 65 ff ff ff       	call   8004e4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80057f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800586:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80058d:	e9 b6 00 00 00       	jmp    800648 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800592:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800595:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059c:	8b 45 08             	mov    0x8(%ebp),%eax
  80059f:	01 d0                	add    %edx,%eax
  8005a1:	8b 00                	mov    (%eax),%eax
  8005a3:	85 c0                	test   %eax,%eax
  8005a5:	75 08                	jne    8005af <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005a7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005aa:	e9 96 00 00 00       	jmp    800645 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8005af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005b6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005bd:	eb 5d                	jmp    80061c <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005ca:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005cd:	c1 e2 04             	shl    $0x4,%edx
  8005d0:	01 d0                	add    %edx,%eax
  8005d2:	8a 40 04             	mov    0x4(%eax),%al
  8005d5:	84 c0                	test   %al,%al
  8005d7:	75 40                	jne    800619 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005de:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005e7:	c1 e2 04             	shl    $0x4,%edx
  8005ea:	01 d0                	add    %edx,%eax
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005f9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800605:	8b 45 08             	mov    0x8(%ebp),%eax
  800608:	01 c8                	add    %ecx,%eax
  80060a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80060c:	39 c2                	cmp    %eax,%edx
  80060e:	75 09                	jne    800619 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800610:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800617:	eb 12                	jmp    80062b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800619:	ff 45 e8             	incl   -0x18(%ebp)
  80061c:	a1 20 30 80 00       	mov    0x803020,%eax
  800621:	8b 50 74             	mov    0x74(%eax),%edx
  800624:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800627:	39 c2                	cmp    %eax,%edx
  800629:	77 94                	ja     8005bf <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80062b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80062f:	75 14                	jne    800645 <CheckWSWithoutLastIndex+0xef>
			panic(
  800631:	83 ec 04             	sub    $0x4,%esp
  800634:	68 40 23 80 00       	push   $0x802340
  800639:	6a 3a                	push   $0x3a
  80063b:	68 34 23 80 00       	push   $0x802334
  800640:	e8 9f fe ff ff       	call   8004e4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800645:	ff 45 f0             	incl   -0x10(%ebp)
  800648:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80064b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80064e:	0f 8c 3e ff ff ff    	jl     800592 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800654:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80065b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800662:	eb 20                	jmp    800684 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800664:	a1 20 30 80 00       	mov    0x803020,%eax
  800669:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80066f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800672:	c1 e2 04             	shl    $0x4,%edx
  800675:	01 d0                	add    %edx,%eax
  800677:	8a 40 04             	mov    0x4(%eax),%al
  80067a:	3c 01                	cmp    $0x1,%al
  80067c:	75 03                	jne    800681 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80067e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800681:	ff 45 e0             	incl   -0x20(%ebp)
  800684:	a1 20 30 80 00       	mov    0x803020,%eax
  800689:	8b 50 74             	mov    0x74(%eax),%edx
  80068c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80068f:	39 c2                	cmp    %eax,%edx
  800691:	77 d1                	ja     800664 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800693:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800696:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800699:	74 14                	je     8006af <CheckWSWithoutLastIndex+0x159>
		panic(
  80069b:	83 ec 04             	sub    $0x4,%esp
  80069e:	68 94 23 80 00       	push   $0x802394
  8006a3:	6a 44                	push   $0x44
  8006a5:	68 34 23 80 00       	push   $0x802334
  8006aa:	e8 35 fe ff ff       	call   8004e4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006af:	90                   	nop
  8006b0:	c9                   	leave  
  8006b1:	c3                   	ret    

008006b2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006b2:	55                   	push   %ebp
  8006b3:	89 e5                	mov    %esp,%ebp
  8006b5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006bb:	8b 00                	mov    (%eax),%eax
  8006bd:	8d 48 01             	lea    0x1(%eax),%ecx
  8006c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c3:	89 0a                	mov    %ecx,(%edx)
  8006c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8006c8:	88 d1                	mov    %dl,%cl
  8006ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006cd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006db:	75 2c                	jne    800709 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006dd:	a0 24 30 80 00       	mov    0x803024,%al
  8006e2:	0f b6 c0             	movzbl %al,%eax
  8006e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e8:	8b 12                	mov    (%edx),%edx
  8006ea:	89 d1                	mov    %edx,%ecx
  8006ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ef:	83 c2 08             	add    $0x8,%edx
  8006f2:	83 ec 04             	sub    $0x4,%esp
  8006f5:	50                   	push   %eax
  8006f6:	51                   	push   %ecx
  8006f7:	52                   	push   %edx
  8006f8:	e8 b9 11 00 00       	call   8018b6 <sys_cputs>
  8006fd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800700:	8b 45 0c             	mov    0xc(%ebp),%eax
  800703:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800709:	8b 45 0c             	mov    0xc(%ebp),%eax
  80070c:	8b 40 04             	mov    0x4(%eax),%eax
  80070f:	8d 50 01             	lea    0x1(%eax),%edx
  800712:	8b 45 0c             	mov    0xc(%ebp),%eax
  800715:	89 50 04             	mov    %edx,0x4(%eax)
}
  800718:	90                   	nop
  800719:	c9                   	leave  
  80071a:	c3                   	ret    

0080071b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80071b:	55                   	push   %ebp
  80071c:	89 e5                	mov    %esp,%ebp
  80071e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800724:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80072b:	00 00 00 
	b.cnt = 0;
  80072e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800735:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800738:	ff 75 0c             	pushl  0xc(%ebp)
  80073b:	ff 75 08             	pushl  0x8(%ebp)
  80073e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800744:	50                   	push   %eax
  800745:	68 b2 06 80 00       	push   $0x8006b2
  80074a:	e8 11 02 00 00       	call   800960 <vprintfmt>
  80074f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800752:	a0 24 30 80 00       	mov    0x803024,%al
  800757:	0f b6 c0             	movzbl %al,%eax
  80075a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800760:	83 ec 04             	sub    $0x4,%esp
  800763:	50                   	push   %eax
  800764:	52                   	push   %edx
  800765:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80076b:	83 c0 08             	add    $0x8,%eax
  80076e:	50                   	push   %eax
  80076f:	e8 42 11 00 00       	call   8018b6 <sys_cputs>
  800774:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800777:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80077e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800784:	c9                   	leave  
  800785:	c3                   	ret    

00800786 <cprintf>:

int cprintf(const char *fmt, ...) {
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80078c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800793:	8d 45 0c             	lea    0xc(%ebp),%eax
  800796:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800799:	8b 45 08             	mov    0x8(%ebp),%eax
  80079c:	83 ec 08             	sub    $0x8,%esp
  80079f:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a2:	50                   	push   %eax
  8007a3:	e8 73 ff ff ff       	call   80071b <vcprintf>
  8007a8:	83 c4 10             	add    $0x10,%esp
  8007ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007b1:	c9                   	leave  
  8007b2:	c3                   	ret    

008007b3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007b3:	55                   	push   %ebp
  8007b4:	89 e5                	mov    %esp,%ebp
  8007b6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007b9:	e8 09 13 00 00       	call   801ac7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c7:	83 ec 08             	sub    $0x8,%esp
  8007ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cd:	50                   	push   %eax
  8007ce:	e8 48 ff ff ff       	call   80071b <vcprintf>
  8007d3:	83 c4 10             	add    $0x10,%esp
  8007d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007d9:	e8 03 13 00 00       	call   801ae1 <sys_enable_interrupt>
	return cnt;
  8007de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007e1:	c9                   	leave  
  8007e2:	c3                   	ret    

008007e3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007e3:	55                   	push   %ebp
  8007e4:	89 e5                	mov    %esp,%ebp
  8007e6:	53                   	push   %ebx
  8007e7:	83 ec 14             	sub    $0x14,%esp
  8007ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007f6:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f9:	ba 00 00 00 00       	mov    $0x0,%edx
  8007fe:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800801:	77 55                	ja     800858 <printnum+0x75>
  800803:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800806:	72 05                	jb     80080d <printnum+0x2a>
  800808:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80080b:	77 4b                	ja     800858 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80080d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800810:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800813:	8b 45 18             	mov    0x18(%ebp),%eax
  800816:	ba 00 00 00 00       	mov    $0x0,%edx
  80081b:	52                   	push   %edx
  80081c:	50                   	push   %eax
  80081d:	ff 75 f4             	pushl  -0xc(%ebp)
  800820:	ff 75 f0             	pushl  -0x10(%ebp)
  800823:	e8 c0 16 00 00       	call   801ee8 <__udivdi3>
  800828:	83 c4 10             	add    $0x10,%esp
  80082b:	83 ec 04             	sub    $0x4,%esp
  80082e:	ff 75 20             	pushl  0x20(%ebp)
  800831:	53                   	push   %ebx
  800832:	ff 75 18             	pushl  0x18(%ebp)
  800835:	52                   	push   %edx
  800836:	50                   	push   %eax
  800837:	ff 75 0c             	pushl  0xc(%ebp)
  80083a:	ff 75 08             	pushl  0x8(%ebp)
  80083d:	e8 a1 ff ff ff       	call   8007e3 <printnum>
  800842:	83 c4 20             	add    $0x20,%esp
  800845:	eb 1a                	jmp    800861 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800847:	83 ec 08             	sub    $0x8,%esp
  80084a:	ff 75 0c             	pushl  0xc(%ebp)
  80084d:	ff 75 20             	pushl  0x20(%ebp)
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	ff d0                	call   *%eax
  800855:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800858:	ff 4d 1c             	decl   0x1c(%ebp)
  80085b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80085f:	7f e6                	jg     800847 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800861:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800864:	bb 00 00 00 00       	mov    $0x0,%ebx
  800869:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80086f:	53                   	push   %ebx
  800870:	51                   	push   %ecx
  800871:	52                   	push   %edx
  800872:	50                   	push   %eax
  800873:	e8 80 17 00 00       	call   801ff8 <__umoddi3>
  800878:	83 c4 10             	add    $0x10,%esp
  80087b:	05 f4 25 80 00       	add    $0x8025f4,%eax
  800880:	8a 00                	mov    (%eax),%al
  800882:	0f be c0             	movsbl %al,%eax
  800885:	83 ec 08             	sub    $0x8,%esp
  800888:	ff 75 0c             	pushl  0xc(%ebp)
  80088b:	50                   	push   %eax
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	ff d0                	call   *%eax
  800891:	83 c4 10             	add    $0x10,%esp
}
  800894:	90                   	nop
  800895:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800898:	c9                   	leave  
  800899:	c3                   	ret    

0080089a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80089a:	55                   	push   %ebp
  80089b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80089d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008a1:	7e 1c                	jle    8008bf <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	8b 00                	mov    (%eax),%eax
  8008a8:	8d 50 08             	lea    0x8(%eax),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	89 10                	mov    %edx,(%eax)
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	83 e8 08             	sub    $0x8,%eax
  8008b8:	8b 50 04             	mov    0x4(%eax),%edx
  8008bb:	8b 00                	mov    (%eax),%eax
  8008bd:	eb 40                	jmp    8008ff <getuint+0x65>
	else if (lflag)
  8008bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c3:	74 1e                	je     8008e3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	8b 00                	mov    (%eax),%eax
  8008ca:	8d 50 04             	lea    0x4(%eax),%edx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	89 10                	mov    %edx,(%eax)
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	83 e8 04             	sub    $0x4,%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	ba 00 00 00 00       	mov    $0x0,%edx
  8008e1:	eb 1c                	jmp    8008ff <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	8b 00                	mov    (%eax),%eax
  8008e8:	8d 50 04             	lea    0x4(%eax),%edx
  8008eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ee:	89 10                	mov    %edx,(%eax)
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	8b 00                	mov    (%eax),%eax
  8008f5:	83 e8 04             	sub    $0x4,%eax
  8008f8:	8b 00                	mov    (%eax),%eax
  8008fa:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008ff:	5d                   	pop    %ebp
  800900:	c3                   	ret    

00800901 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800901:	55                   	push   %ebp
  800902:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800904:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800908:	7e 1c                	jle    800926 <getint+0x25>
		return va_arg(*ap, long long);
  80090a:	8b 45 08             	mov    0x8(%ebp),%eax
  80090d:	8b 00                	mov    (%eax),%eax
  80090f:	8d 50 08             	lea    0x8(%eax),%edx
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	89 10                	mov    %edx,(%eax)
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	8b 00                	mov    (%eax),%eax
  80091c:	83 e8 08             	sub    $0x8,%eax
  80091f:	8b 50 04             	mov    0x4(%eax),%edx
  800922:	8b 00                	mov    (%eax),%eax
  800924:	eb 38                	jmp    80095e <getint+0x5d>
	else if (lflag)
  800926:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80092a:	74 1a                	je     800946 <getint+0x45>
		return va_arg(*ap, long);
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	8b 00                	mov    (%eax),%eax
  800931:	8d 50 04             	lea    0x4(%eax),%edx
  800934:	8b 45 08             	mov    0x8(%ebp),%eax
  800937:	89 10                	mov    %edx,(%eax)
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	8b 00                	mov    (%eax),%eax
  80093e:	83 e8 04             	sub    $0x4,%eax
  800941:	8b 00                	mov    (%eax),%eax
  800943:	99                   	cltd   
  800944:	eb 18                	jmp    80095e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	8b 00                	mov    (%eax),%eax
  80094b:	8d 50 04             	lea    0x4(%eax),%edx
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	89 10                	mov    %edx,(%eax)
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	8b 00                	mov    (%eax),%eax
  800958:	83 e8 04             	sub    $0x4,%eax
  80095b:	8b 00                	mov    (%eax),%eax
  80095d:	99                   	cltd   
}
  80095e:	5d                   	pop    %ebp
  80095f:	c3                   	ret    

00800960 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800960:	55                   	push   %ebp
  800961:	89 e5                	mov    %esp,%ebp
  800963:	56                   	push   %esi
  800964:	53                   	push   %ebx
  800965:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800968:	eb 17                	jmp    800981 <vprintfmt+0x21>
			if (ch == '\0')
  80096a:	85 db                	test   %ebx,%ebx
  80096c:	0f 84 af 03 00 00    	je     800d21 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 0c             	pushl  0xc(%ebp)
  800978:	53                   	push   %ebx
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	ff d0                	call   *%eax
  80097e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800981:	8b 45 10             	mov    0x10(%ebp),%eax
  800984:	8d 50 01             	lea    0x1(%eax),%edx
  800987:	89 55 10             	mov    %edx,0x10(%ebp)
  80098a:	8a 00                	mov    (%eax),%al
  80098c:	0f b6 d8             	movzbl %al,%ebx
  80098f:	83 fb 25             	cmp    $0x25,%ebx
  800992:	75 d6                	jne    80096a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800994:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800998:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80099f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009a6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b7:	8d 50 01             	lea    0x1(%eax),%edx
  8009ba:	89 55 10             	mov    %edx,0x10(%ebp)
  8009bd:	8a 00                	mov    (%eax),%al
  8009bf:	0f b6 d8             	movzbl %al,%ebx
  8009c2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009c5:	83 f8 55             	cmp    $0x55,%eax
  8009c8:	0f 87 2b 03 00 00    	ja     800cf9 <vprintfmt+0x399>
  8009ce:	8b 04 85 18 26 80 00 	mov    0x802618(,%eax,4),%eax
  8009d5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009d7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009db:	eb d7                	jmp    8009b4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009dd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009e1:	eb d1                	jmp    8009b4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009e3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009ea:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ed:	89 d0                	mov    %edx,%eax
  8009ef:	c1 e0 02             	shl    $0x2,%eax
  8009f2:	01 d0                	add    %edx,%eax
  8009f4:	01 c0                	add    %eax,%eax
  8009f6:	01 d8                	add    %ebx,%eax
  8009f8:	83 e8 30             	sub    $0x30,%eax
  8009fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800a01:	8a 00                	mov    (%eax),%al
  800a03:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a06:	83 fb 2f             	cmp    $0x2f,%ebx
  800a09:	7e 3e                	jle    800a49 <vprintfmt+0xe9>
  800a0b:	83 fb 39             	cmp    $0x39,%ebx
  800a0e:	7f 39                	jg     800a49 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a10:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a13:	eb d5                	jmp    8009ea <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a15:	8b 45 14             	mov    0x14(%ebp),%eax
  800a18:	83 c0 04             	add    $0x4,%eax
  800a1b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a1e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a21:	83 e8 04             	sub    $0x4,%eax
  800a24:	8b 00                	mov    (%eax),%eax
  800a26:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a29:	eb 1f                	jmp    800a4a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2f:	79 83                	jns    8009b4 <vprintfmt+0x54>
				width = 0;
  800a31:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a38:	e9 77 ff ff ff       	jmp    8009b4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a3d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a44:	e9 6b ff ff ff       	jmp    8009b4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a49:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a4a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a4e:	0f 89 60 ff ff ff    	jns    8009b4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a54:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a5a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a61:	e9 4e ff ff ff       	jmp    8009b4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a66:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a69:	e9 46 ff ff ff       	jmp    8009b4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a71:	83 c0 04             	add    $0x4,%eax
  800a74:	89 45 14             	mov    %eax,0x14(%ebp)
  800a77:	8b 45 14             	mov    0x14(%ebp),%eax
  800a7a:	83 e8 04             	sub    $0x4,%eax
  800a7d:	8b 00                	mov    (%eax),%eax
  800a7f:	83 ec 08             	sub    $0x8,%esp
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	50                   	push   %eax
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
			break;
  800a8e:	e9 89 02 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a93:	8b 45 14             	mov    0x14(%ebp),%eax
  800a96:	83 c0 04             	add    $0x4,%eax
  800a99:	89 45 14             	mov    %eax,0x14(%ebp)
  800a9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9f:	83 e8 04             	sub    $0x4,%eax
  800aa2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800aa4:	85 db                	test   %ebx,%ebx
  800aa6:	79 02                	jns    800aaa <vprintfmt+0x14a>
				err = -err;
  800aa8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800aaa:	83 fb 64             	cmp    $0x64,%ebx
  800aad:	7f 0b                	jg     800aba <vprintfmt+0x15a>
  800aaf:	8b 34 9d 60 24 80 00 	mov    0x802460(,%ebx,4),%esi
  800ab6:	85 f6                	test   %esi,%esi
  800ab8:	75 19                	jne    800ad3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800aba:	53                   	push   %ebx
  800abb:	68 05 26 80 00       	push   $0x802605
  800ac0:	ff 75 0c             	pushl  0xc(%ebp)
  800ac3:	ff 75 08             	pushl  0x8(%ebp)
  800ac6:	e8 5e 02 00 00       	call   800d29 <printfmt>
  800acb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ace:	e9 49 02 00 00       	jmp    800d1c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ad3:	56                   	push   %esi
  800ad4:	68 0e 26 80 00       	push   $0x80260e
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	ff 75 08             	pushl  0x8(%ebp)
  800adf:	e8 45 02 00 00       	call   800d29 <printfmt>
  800ae4:	83 c4 10             	add    $0x10,%esp
			break;
  800ae7:	e9 30 02 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800aec:	8b 45 14             	mov    0x14(%ebp),%eax
  800aef:	83 c0 04             	add    $0x4,%eax
  800af2:	89 45 14             	mov    %eax,0x14(%ebp)
  800af5:	8b 45 14             	mov    0x14(%ebp),%eax
  800af8:	83 e8 04             	sub    $0x4,%eax
  800afb:	8b 30                	mov    (%eax),%esi
  800afd:	85 f6                	test   %esi,%esi
  800aff:	75 05                	jne    800b06 <vprintfmt+0x1a6>
				p = "(null)";
  800b01:	be 11 26 80 00       	mov    $0x802611,%esi
			if (width > 0 && padc != '-')
  800b06:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b0a:	7e 6d                	jle    800b79 <vprintfmt+0x219>
  800b0c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b10:	74 67                	je     800b79 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	50                   	push   %eax
  800b19:	56                   	push   %esi
  800b1a:	e8 0c 03 00 00       	call   800e2b <strnlen>
  800b1f:	83 c4 10             	add    $0x10,%esp
  800b22:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b25:	eb 16                	jmp    800b3d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b27:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b2b:	83 ec 08             	sub    $0x8,%esp
  800b2e:	ff 75 0c             	pushl  0xc(%ebp)
  800b31:	50                   	push   %eax
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	ff d0                	call   *%eax
  800b37:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b3a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b41:	7f e4                	jg     800b27 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b43:	eb 34                	jmp    800b79 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b45:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b49:	74 1c                	je     800b67 <vprintfmt+0x207>
  800b4b:	83 fb 1f             	cmp    $0x1f,%ebx
  800b4e:	7e 05                	jle    800b55 <vprintfmt+0x1f5>
  800b50:	83 fb 7e             	cmp    $0x7e,%ebx
  800b53:	7e 12                	jle    800b67 <vprintfmt+0x207>
					putch('?', putdat);
  800b55:	83 ec 08             	sub    $0x8,%esp
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	6a 3f                	push   $0x3f
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	ff d0                	call   *%eax
  800b62:	83 c4 10             	add    $0x10,%esp
  800b65:	eb 0f                	jmp    800b76 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	53                   	push   %ebx
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b76:	ff 4d e4             	decl   -0x1c(%ebp)
  800b79:	89 f0                	mov    %esi,%eax
  800b7b:	8d 70 01             	lea    0x1(%eax),%esi
  800b7e:	8a 00                	mov    (%eax),%al
  800b80:	0f be d8             	movsbl %al,%ebx
  800b83:	85 db                	test   %ebx,%ebx
  800b85:	74 24                	je     800bab <vprintfmt+0x24b>
  800b87:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b8b:	78 b8                	js     800b45 <vprintfmt+0x1e5>
  800b8d:	ff 4d e0             	decl   -0x20(%ebp)
  800b90:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b94:	79 af                	jns    800b45 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b96:	eb 13                	jmp    800bab <vprintfmt+0x24b>
				putch(' ', putdat);
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 0c             	pushl  0xc(%ebp)
  800b9e:	6a 20                	push   $0x20
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	ff d0                	call   *%eax
  800ba5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ba8:	ff 4d e4             	decl   -0x1c(%ebp)
  800bab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800baf:	7f e7                	jg     800b98 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800bb1:	e9 66 01 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bb6:	83 ec 08             	sub    $0x8,%esp
  800bb9:	ff 75 e8             	pushl  -0x18(%ebp)
  800bbc:	8d 45 14             	lea    0x14(%ebp),%eax
  800bbf:	50                   	push   %eax
  800bc0:	e8 3c fd ff ff       	call   800901 <getint>
  800bc5:	83 c4 10             	add    $0x10,%esp
  800bc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bcb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bd4:	85 d2                	test   %edx,%edx
  800bd6:	79 23                	jns    800bfb <vprintfmt+0x29b>
				putch('-', putdat);
  800bd8:	83 ec 08             	sub    $0x8,%esp
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	6a 2d                	push   $0x2d
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	ff d0                	call   *%eax
  800be5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800beb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bee:	f7 d8                	neg    %eax
  800bf0:	83 d2 00             	adc    $0x0,%edx
  800bf3:	f7 da                	neg    %edx
  800bf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bfb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c02:	e9 bc 00 00 00       	jmp    800cc3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c07:	83 ec 08             	sub    $0x8,%esp
  800c0a:	ff 75 e8             	pushl  -0x18(%ebp)
  800c0d:	8d 45 14             	lea    0x14(%ebp),%eax
  800c10:	50                   	push   %eax
  800c11:	e8 84 fc ff ff       	call   80089a <getuint>
  800c16:	83 c4 10             	add    $0x10,%esp
  800c19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c1f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c26:	e9 98 00 00 00       	jmp    800cc3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c2b:	83 ec 08             	sub    $0x8,%esp
  800c2e:	ff 75 0c             	pushl  0xc(%ebp)
  800c31:	6a 58                	push   $0x58
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	ff d0                	call   *%eax
  800c38:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c3b:	83 ec 08             	sub    $0x8,%esp
  800c3e:	ff 75 0c             	pushl  0xc(%ebp)
  800c41:	6a 58                	push   $0x58
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	ff d0                	call   *%eax
  800c48:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c4b:	83 ec 08             	sub    $0x8,%esp
  800c4e:	ff 75 0c             	pushl  0xc(%ebp)
  800c51:	6a 58                	push   $0x58
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	ff d0                	call   *%eax
  800c58:	83 c4 10             	add    $0x10,%esp
			break;
  800c5b:	e9 bc 00 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	ff 75 0c             	pushl  0xc(%ebp)
  800c66:	6a 30                	push   $0x30
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	ff d0                	call   *%eax
  800c6d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c70:	83 ec 08             	sub    $0x8,%esp
  800c73:	ff 75 0c             	pushl  0xc(%ebp)
  800c76:	6a 78                	push   $0x78
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	ff d0                	call   *%eax
  800c7d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c80:	8b 45 14             	mov    0x14(%ebp),%eax
  800c83:	83 c0 04             	add    $0x4,%eax
  800c86:	89 45 14             	mov    %eax,0x14(%ebp)
  800c89:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8c:	83 e8 04             	sub    $0x4,%eax
  800c8f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c9b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ca2:	eb 1f                	jmp    800cc3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ca4:	83 ec 08             	sub    $0x8,%esp
  800ca7:	ff 75 e8             	pushl  -0x18(%ebp)
  800caa:	8d 45 14             	lea    0x14(%ebp),%eax
  800cad:	50                   	push   %eax
  800cae:	e8 e7 fb ff ff       	call   80089a <getuint>
  800cb3:	83 c4 10             	add    $0x10,%esp
  800cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cb9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cbc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cc3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cca:	83 ec 04             	sub    $0x4,%esp
  800ccd:	52                   	push   %edx
  800cce:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cd1:	50                   	push   %eax
  800cd2:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd5:	ff 75 f0             	pushl  -0x10(%ebp)
  800cd8:	ff 75 0c             	pushl  0xc(%ebp)
  800cdb:	ff 75 08             	pushl  0x8(%ebp)
  800cde:	e8 00 fb ff ff       	call   8007e3 <printnum>
  800ce3:	83 c4 20             	add    $0x20,%esp
			break;
  800ce6:	eb 34                	jmp    800d1c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ce8:	83 ec 08             	sub    $0x8,%esp
  800ceb:	ff 75 0c             	pushl  0xc(%ebp)
  800cee:	53                   	push   %ebx
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	ff d0                	call   *%eax
  800cf4:	83 c4 10             	add    $0x10,%esp
			break;
  800cf7:	eb 23                	jmp    800d1c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cf9:	83 ec 08             	sub    $0x8,%esp
  800cfc:	ff 75 0c             	pushl  0xc(%ebp)
  800cff:	6a 25                	push   $0x25
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	ff d0                	call   *%eax
  800d06:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d09:	ff 4d 10             	decl   0x10(%ebp)
  800d0c:	eb 03                	jmp    800d11 <vprintfmt+0x3b1>
  800d0e:	ff 4d 10             	decl   0x10(%ebp)
  800d11:	8b 45 10             	mov    0x10(%ebp),%eax
  800d14:	48                   	dec    %eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	3c 25                	cmp    $0x25,%al
  800d19:	75 f3                	jne    800d0e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d1b:	90                   	nop
		}
	}
  800d1c:	e9 47 fc ff ff       	jmp    800968 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d21:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d22:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d25:	5b                   	pop    %ebx
  800d26:	5e                   	pop    %esi
  800d27:	5d                   	pop    %ebp
  800d28:	c3                   	ret    

00800d29 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d29:	55                   	push   %ebp
  800d2a:	89 e5                	mov    %esp,%ebp
  800d2c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d2f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d32:	83 c0 04             	add    $0x4,%eax
  800d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d38:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3e:	50                   	push   %eax
  800d3f:	ff 75 0c             	pushl  0xc(%ebp)
  800d42:	ff 75 08             	pushl  0x8(%ebp)
  800d45:	e8 16 fc ff ff       	call   800960 <vprintfmt>
  800d4a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d4d:	90                   	nop
  800d4e:	c9                   	leave  
  800d4f:	c3                   	ret    

00800d50 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d50:	55                   	push   %ebp
  800d51:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d56:	8b 40 08             	mov    0x8(%eax),%eax
  800d59:	8d 50 01             	lea    0x1(%eax),%edx
  800d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d65:	8b 10                	mov    (%eax),%edx
  800d67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6a:	8b 40 04             	mov    0x4(%eax),%eax
  800d6d:	39 c2                	cmp    %eax,%edx
  800d6f:	73 12                	jae    800d83 <sprintputch+0x33>
		*b->buf++ = ch;
  800d71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d74:	8b 00                	mov    (%eax),%eax
  800d76:	8d 48 01             	lea    0x1(%eax),%ecx
  800d79:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d7c:	89 0a                	mov    %ecx,(%edx)
  800d7e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d81:	88 10                	mov    %dl,(%eax)
}
  800d83:	90                   	nop
  800d84:	5d                   	pop    %ebp
  800d85:	c3                   	ret    

00800d86 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d86:	55                   	push   %ebp
  800d87:	89 e5                	mov    %esp,%ebp
  800d89:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d95:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	01 d0                	add    %edx,%eax
  800d9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800da0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800da7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dab:	74 06                	je     800db3 <vsnprintf+0x2d>
  800dad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db1:	7f 07                	jg     800dba <vsnprintf+0x34>
		return -E_INVAL;
  800db3:	b8 03 00 00 00       	mov    $0x3,%eax
  800db8:	eb 20                	jmp    800dda <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800dba:	ff 75 14             	pushl  0x14(%ebp)
  800dbd:	ff 75 10             	pushl  0x10(%ebp)
  800dc0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800dc3:	50                   	push   %eax
  800dc4:	68 50 0d 80 00       	push   $0x800d50
  800dc9:	e8 92 fb ff ff       	call   800960 <vprintfmt>
  800dce:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dd1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dd4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
  800ddf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800de2:	8d 45 10             	lea    0x10(%ebp),%eax
  800de5:	83 c0 04             	add    $0x4,%eax
  800de8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800deb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dee:	ff 75 f4             	pushl  -0xc(%ebp)
  800df1:	50                   	push   %eax
  800df2:	ff 75 0c             	pushl  0xc(%ebp)
  800df5:	ff 75 08             	pushl  0x8(%ebp)
  800df8:	e8 89 ff ff ff       	call   800d86 <vsnprintf>
  800dfd:	83 c4 10             	add    $0x10,%esp
  800e00:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e03:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e06:	c9                   	leave  
  800e07:	c3                   	ret    

00800e08 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e08:	55                   	push   %ebp
  800e09:	89 e5                	mov    %esp,%ebp
  800e0b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e15:	eb 06                	jmp    800e1d <strlen+0x15>
		n++;
  800e17:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e1a:	ff 45 08             	incl   0x8(%ebp)
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8a 00                	mov    (%eax),%al
  800e22:	84 c0                	test   %al,%al
  800e24:	75 f1                	jne    800e17 <strlen+0xf>
		n++;
	return n;
  800e26:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e29:	c9                   	leave  
  800e2a:	c3                   	ret    

00800e2b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e2b:	55                   	push   %ebp
  800e2c:	89 e5                	mov    %esp,%ebp
  800e2e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e38:	eb 09                	jmp    800e43 <strnlen+0x18>
		n++;
  800e3a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e3d:	ff 45 08             	incl   0x8(%ebp)
  800e40:	ff 4d 0c             	decl   0xc(%ebp)
  800e43:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e47:	74 09                	je     800e52 <strnlen+0x27>
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	8a 00                	mov    (%eax),%al
  800e4e:	84 c0                	test   %al,%al
  800e50:	75 e8                	jne    800e3a <strnlen+0xf>
		n++;
	return n;
  800e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e55:	c9                   	leave  
  800e56:	c3                   	ret    

00800e57 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e57:	55                   	push   %ebp
  800e58:	89 e5                	mov    %esp,%ebp
  800e5a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e63:	90                   	nop
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8d 50 01             	lea    0x1(%eax),%edx
  800e6a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e73:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e76:	8a 12                	mov    (%edx),%dl
  800e78:	88 10                	mov    %dl,(%eax)
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	84 c0                	test   %al,%al
  800e7e:	75 e4                	jne    800e64 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e83:	c9                   	leave  
  800e84:	c3                   	ret    

00800e85 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e85:	55                   	push   %ebp
  800e86:	89 e5                	mov    %esp,%ebp
  800e88:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e98:	eb 1f                	jmp    800eb9 <strncpy+0x34>
		*dst++ = *src;
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8d 50 01             	lea    0x1(%eax),%edx
  800ea0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ea3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea6:	8a 12                	mov    (%edx),%dl
  800ea8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	84 c0                	test   %al,%al
  800eb1:	74 03                	je     800eb6 <strncpy+0x31>
			src++;
  800eb3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800eb6:	ff 45 fc             	incl   -0x4(%ebp)
  800eb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebc:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ebf:	72 d9                	jb     800e9a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ec1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ec4:	c9                   	leave  
  800ec5:	c3                   	ret    

00800ec6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ec6:	55                   	push   %ebp
  800ec7:	89 e5                	mov    %esp,%ebp
  800ec9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ed2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed6:	74 30                	je     800f08 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ed8:	eb 16                	jmp    800ef0 <strlcpy+0x2a>
			*dst++ = *src++;
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	8d 50 01             	lea    0x1(%eax),%edx
  800ee0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ee3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ee9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eec:	8a 12                	mov    (%edx),%dl
  800eee:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ef0:	ff 4d 10             	decl   0x10(%ebp)
  800ef3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef7:	74 09                	je     800f02 <strlcpy+0x3c>
  800ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	84 c0                	test   %al,%al
  800f00:	75 d8                	jne    800eda <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f08:	8b 55 08             	mov    0x8(%ebp),%edx
  800f0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0e:	29 c2                	sub    %eax,%edx
  800f10:	89 d0                	mov    %edx,%eax
}
  800f12:	c9                   	leave  
  800f13:	c3                   	ret    

00800f14 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f14:	55                   	push   %ebp
  800f15:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f17:	eb 06                	jmp    800f1f <strcmp+0xb>
		p++, q++;
  800f19:	ff 45 08             	incl   0x8(%ebp)
  800f1c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	84 c0                	test   %al,%al
  800f26:	74 0e                	je     800f36 <strcmp+0x22>
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 10                	mov    (%eax),%dl
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	38 c2                	cmp    %al,%dl
  800f34:	74 e3                	je     800f19 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	0f b6 d0             	movzbl %al,%edx
  800f3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	0f b6 c0             	movzbl %al,%eax
  800f46:	29 c2                	sub    %eax,%edx
  800f48:	89 d0                	mov    %edx,%eax
}
  800f4a:	5d                   	pop    %ebp
  800f4b:	c3                   	ret    

00800f4c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f4f:	eb 09                	jmp    800f5a <strncmp+0xe>
		n--, p++, q++;
  800f51:	ff 4d 10             	decl   0x10(%ebp)
  800f54:	ff 45 08             	incl   0x8(%ebp)
  800f57:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5e:	74 17                	je     800f77 <strncmp+0x2b>
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	84 c0                	test   %al,%al
  800f67:	74 0e                	je     800f77 <strncmp+0x2b>
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8a 10                	mov    (%eax),%dl
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	38 c2                	cmp    %al,%dl
  800f75:	74 da                	je     800f51 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f7b:	75 07                	jne    800f84 <strncmp+0x38>
		return 0;
  800f7d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f82:	eb 14                	jmp    800f98 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	0f b6 d0             	movzbl %al,%edx
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	0f b6 c0             	movzbl %al,%eax
  800f94:	29 c2                	sub    %eax,%edx
  800f96:	89 d0                	mov    %edx,%eax
}
  800f98:	5d                   	pop    %ebp
  800f99:	c3                   	ret    

00800f9a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f9a:	55                   	push   %ebp
  800f9b:	89 e5                	mov    %esp,%ebp
  800f9d:	83 ec 04             	sub    $0x4,%esp
  800fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fa6:	eb 12                	jmp    800fba <strchr+0x20>
		if (*s == c)
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fb0:	75 05                	jne    800fb7 <strchr+0x1d>
			return (char *) s;
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	eb 11                	jmp    800fc8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fb7:	ff 45 08             	incl   0x8(%ebp)
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	84 c0                	test   %al,%al
  800fc1:	75 e5                	jne    800fa8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fc3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fc8:	c9                   	leave  
  800fc9:	c3                   	ret    

00800fca <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fca:	55                   	push   %ebp
  800fcb:	89 e5                	mov    %esp,%ebp
  800fcd:	83 ec 04             	sub    $0x4,%esp
  800fd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fd6:	eb 0d                	jmp    800fe5 <strfind+0x1b>
		if (*s == c)
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fe0:	74 0e                	je     800ff0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fe2:	ff 45 08             	incl   0x8(%ebp)
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	84 c0                	test   %al,%al
  800fec:	75 ea                	jne    800fd8 <strfind+0xe>
  800fee:	eb 01                	jmp    800ff1 <strfind+0x27>
		if (*s == c)
			break;
  800ff0:	90                   	nop
	return (char *) s;
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801002:	8b 45 10             	mov    0x10(%ebp),%eax
  801005:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801008:	eb 0e                	jmp    801018 <memset+0x22>
		*p++ = c;
  80100a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100d:	8d 50 01             	lea    0x1(%eax),%edx
  801010:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801013:	8b 55 0c             	mov    0xc(%ebp),%edx
  801016:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801018:	ff 4d f8             	decl   -0x8(%ebp)
  80101b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80101f:	79 e9                	jns    80100a <memset+0x14>
		*p++ = c;

	return v;
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801024:	c9                   	leave  
  801025:	c3                   	ret    

00801026 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801026:	55                   	push   %ebp
  801027:	89 e5                	mov    %esp,%ebp
  801029:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80102c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801038:	eb 16                	jmp    801050 <memcpy+0x2a>
		*d++ = *s++;
  80103a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103d:	8d 50 01             	lea    0x1(%eax),%edx
  801040:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801043:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801046:	8d 4a 01             	lea    0x1(%edx),%ecx
  801049:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80104c:	8a 12                	mov    (%edx),%dl
  80104e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801050:	8b 45 10             	mov    0x10(%ebp),%eax
  801053:	8d 50 ff             	lea    -0x1(%eax),%edx
  801056:	89 55 10             	mov    %edx,0x10(%ebp)
  801059:	85 c0                	test   %eax,%eax
  80105b:	75 dd                	jne    80103a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801060:	c9                   	leave  
  801061:	c3                   	ret    

00801062 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
  801065:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801068:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801074:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801077:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80107a:	73 50                	jae    8010cc <memmove+0x6a>
  80107c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80107f:	8b 45 10             	mov    0x10(%ebp),%eax
  801082:	01 d0                	add    %edx,%eax
  801084:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801087:	76 43                	jbe    8010cc <memmove+0x6a>
		s += n;
  801089:	8b 45 10             	mov    0x10(%ebp),%eax
  80108c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80108f:	8b 45 10             	mov    0x10(%ebp),%eax
  801092:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801095:	eb 10                	jmp    8010a7 <memmove+0x45>
			*--d = *--s;
  801097:	ff 4d f8             	decl   -0x8(%ebp)
  80109a:	ff 4d fc             	decl   -0x4(%ebp)
  80109d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a0:	8a 10                	mov    (%eax),%dl
  8010a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b0:	85 c0                	test   %eax,%eax
  8010b2:	75 e3                	jne    801097 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010b4:	eb 23                	jmp    8010d9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b9:	8d 50 01             	lea    0x1(%eax),%edx
  8010bc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010c8:	8a 12                	mov    (%edx),%dl
  8010ca:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d5:	85 c0                	test   %eax,%eax
  8010d7:	75 dd                	jne    8010b6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010dc:	c9                   	leave  
  8010dd:	c3                   	ret    

008010de <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010de:	55                   	push   %ebp
  8010df:	89 e5                	mov    %esp,%ebp
  8010e1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010f0:	eb 2a                	jmp    80111c <memcmp+0x3e>
		if (*s1 != *s2)
  8010f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f5:	8a 10                	mov    (%eax),%dl
  8010f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	38 c2                	cmp    %al,%dl
  8010fe:	74 16                	je     801116 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801100:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801103:	8a 00                	mov    (%eax),%al
  801105:	0f b6 d0             	movzbl %al,%edx
  801108:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110b:	8a 00                	mov    (%eax),%al
  80110d:	0f b6 c0             	movzbl %al,%eax
  801110:	29 c2                	sub    %eax,%edx
  801112:	89 d0                	mov    %edx,%eax
  801114:	eb 18                	jmp    80112e <memcmp+0x50>
		s1++, s2++;
  801116:	ff 45 fc             	incl   -0x4(%ebp)
  801119:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80111c:	8b 45 10             	mov    0x10(%ebp),%eax
  80111f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801122:	89 55 10             	mov    %edx,0x10(%ebp)
  801125:	85 c0                	test   %eax,%eax
  801127:	75 c9                	jne    8010f2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801129:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80112e:	c9                   	leave  
  80112f:	c3                   	ret    

00801130 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
  801133:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801136:	8b 55 08             	mov    0x8(%ebp),%edx
  801139:	8b 45 10             	mov    0x10(%ebp),%eax
  80113c:	01 d0                	add    %edx,%eax
  80113e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801141:	eb 15                	jmp    801158 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	0f b6 d0             	movzbl %al,%edx
  80114b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114e:	0f b6 c0             	movzbl %al,%eax
  801151:	39 c2                	cmp    %eax,%edx
  801153:	74 0d                	je     801162 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801155:	ff 45 08             	incl   0x8(%ebp)
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80115e:	72 e3                	jb     801143 <memfind+0x13>
  801160:	eb 01                	jmp    801163 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801162:	90                   	nop
	return (void *) s;
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
  80116b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80116e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801175:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80117c:	eb 03                	jmp    801181 <strtol+0x19>
		s++;
  80117e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	3c 20                	cmp    $0x20,%al
  801188:	74 f4                	je     80117e <strtol+0x16>
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	3c 09                	cmp    $0x9,%al
  801191:	74 eb                	je     80117e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	8a 00                	mov    (%eax),%al
  801198:	3c 2b                	cmp    $0x2b,%al
  80119a:	75 05                	jne    8011a1 <strtol+0x39>
		s++;
  80119c:	ff 45 08             	incl   0x8(%ebp)
  80119f:	eb 13                	jmp    8011b4 <strtol+0x4c>
	else if (*s == '-')
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	3c 2d                	cmp    $0x2d,%al
  8011a8:	75 0a                	jne    8011b4 <strtol+0x4c>
		s++, neg = 1;
  8011aa:	ff 45 08             	incl   0x8(%ebp)
  8011ad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b8:	74 06                	je     8011c0 <strtol+0x58>
  8011ba:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011be:	75 20                	jne    8011e0 <strtol+0x78>
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 30                	cmp    $0x30,%al
  8011c7:	75 17                	jne    8011e0 <strtol+0x78>
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	40                   	inc    %eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	3c 78                	cmp    $0x78,%al
  8011d1:	75 0d                	jne    8011e0 <strtol+0x78>
		s += 2, base = 16;
  8011d3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011d7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011de:	eb 28                	jmp    801208 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e4:	75 15                	jne    8011fb <strtol+0x93>
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	3c 30                	cmp    $0x30,%al
  8011ed:	75 0c                	jne    8011fb <strtol+0x93>
		s++, base = 8;
  8011ef:	ff 45 08             	incl   0x8(%ebp)
  8011f2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011f9:	eb 0d                	jmp    801208 <strtol+0xa0>
	else if (base == 0)
  8011fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ff:	75 07                	jne    801208 <strtol+0xa0>
		base = 10;
  801201:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	3c 2f                	cmp    $0x2f,%al
  80120f:	7e 19                	jle    80122a <strtol+0xc2>
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	3c 39                	cmp    $0x39,%al
  801218:	7f 10                	jg     80122a <strtol+0xc2>
			dig = *s - '0';
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	0f be c0             	movsbl %al,%eax
  801222:	83 e8 30             	sub    $0x30,%eax
  801225:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801228:	eb 42                	jmp    80126c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	8a 00                	mov    (%eax),%al
  80122f:	3c 60                	cmp    $0x60,%al
  801231:	7e 19                	jle    80124c <strtol+0xe4>
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	3c 7a                	cmp    $0x7a,%al
  80123a:	7f 10                	jg     80124c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	8a 00                	mov    (%eax),%al
  801241:	0f be c0             	movsbl %al,%eax
  801244:	83 e8 57             	sub    $0x57,%eax
  801247:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80124a:	eb 20                	jmp    80126c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	8a 00                	mov    (%eax),%al
  801251:	3c 40                	cmp    $0x40,%al
  801253:	7e 39                	jle    80128e <strtol+0x126>
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	8a 00                	mov    (%eax),%al
  80125a:	3c 5a                	cmp    $0x5a,%al
  80125c:	7f 30                	jg     80128e <strtol+0x126>
			dig = *s - 'A' + 10;
  80125e:	8b 45 08             	mov    0x8(%ebp),%eax
  801261:	8a 00                	mov    (%eax),%al
  801263:	0f be c0             	movsbl %al,%eax
  801266:	83 e8 37             	sub    $0x37,%eax
  801269:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80126c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801272:	7d 19                	jge    80128d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801274:	ff 45 08             	incl   0x8(%ebp)
  801277:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80127e:	89 c2                	mov    %eax,%edx
  801280:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801283:	01 d0                	add    %edx,%eax
  801285:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801288:	e9 7b ff ff ff       	jmp    801208 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80128d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80128e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801292:	74 08                	je     80129c <strtol+0x134>
		*endptr = (char *) s;
  801294:	8b 45 0c             	mov    0xc(%ebp),%eax
  801297:	8b 55 08             	mov    0x8(%ebp),%edx
  80129a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80129c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012a0:	74 07                	je     8012a9 <strtol+0x141>
  8012a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a5:	f7 d8                	neg    %eax
  8012a7:	eb 03                	jmp    8012ac <strtol+0x144>
  8012a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <ltostr>:

void
ltostr(long value, char *str)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c6:	79 13                	jns    8012db <ltostr+0x2d>
	{
		neg = 1;
  8012c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012d5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012d8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012e3:	99                   	cltd   
  8012e4:	f7 f9                	idiv   %ecx
  8012e6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ec:	8d 50 01             	lea    0x1(%eax),%edx
  8012ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012f2:	89 c2                	mov    %eax,%edx
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	01 d0                	add    %edx,%eax
  8012f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012fc:	83 c2 30             	add    $0x30,%edx
  8012ff:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801301:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801304:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801309:	f7 e9                	imul   %ecx
  80130b:	c1 fa 02             	sar    $0x2,%edx
  80130e:	89 c8                	mov    %ecx,%eax
  801310:	c1 f8 1f             	sar    $0x1f,%eax
  801313:	29 c2                	sub    %eax,%edx
  801315:	89 d0                	mov    %edx,%eax
  801317:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80131a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80131d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801322:	f7 e9                	imul   %ecx
  801324:	c1 fa 02             	sar    $0x2,%edx
  801327:	89 c8                	mov    %ecx,%eax
  801329:	c1 f8 1f             	sar    $0x1f,%eax
  80132c:	29 c2                	sub    %eax,%edx
  80132e:	89 d0                	mov    %edx,%eax
  801330:	c1 e0 02             	shl    $0x2,%eax
  801333:	01 d0                	add    %edx,%eax
  801335:	01 c0                	add    %eax,%eax
  801337:	29 c1                	sub    %eax,%ecx
  801339:	89 ca                	mov    %ecx,%edx
  80133b:	85 d2                	test   %edx,%edx
  80133d:	75 9c                	jne    8012db <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80133f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801346:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801349:	48                   	dec    %eax
  80134a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80134d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801351:	74 3d                	je     801390 <ltostr+0xe2>
		start = 1 ;
  801353:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80135a:	eb 34                	jmp    801390 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80135c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801362:	01 d0                	add    %edx,%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801369:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80136c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136f:	01 c2                	add    %eax,%edx
  801371:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801374:	8b 45 0c             	mov    0xc(%ebp),%eax
  801377:	01 c8                	add    %ecx,%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80137d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801380:	8b 45 0c             	mov    0xc(%ebp),%eax
  801383:	01 c2                	add    %eax,%edx
  801385:	8a 45 eb             	mov    -0x15(%ebp),%al
  801388:	88 02                	mov    %al,(%edx)
		start++ ;
  80138a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80138d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801390:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801393:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801396:	7c c4                	jl     80135c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801398:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80139b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139e:	01 d0                	add    %edx,%eax
  8013a0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013a3:	90                   	nop
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
  8013a9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013ac:	ff 75 08             	pushl  0x8(%ebp)
  8013af:	e8 54 fa ff ff       	call   800e08 <strlen>
  8013b4:	83 c4 04             	add    $0x4,%esp
  8013b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013ba:	ff 75 0c             	pushl  0xc(%ebp)
  8013bd:	e8 46 fa ff ff       	call   800e08 <strlen>
  8013c2:	83 c4 04             	add    $0x4,%esp
  8013c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013d6:	eb 17                	jmp    8013ef <strcconcat+0x49>
		final[s] = str1[s] ;
  8013d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013db:	8b 45 10             	mov    0x10(%ebp),%eax
  8013de:	01 c2                	add    %eax,%edx
  8013e0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	01 c8                	add    %ecx,%eax
  8013e8:	8a 00                	mov    (%eax),%al
  8013ea:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013ec:	ff 45 fc             	incl   -0x4(%ebp)
  8013ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013f5:	7c e1                	jl     8013d8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013f7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801405:	eb 1f                	jmp    801426 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140a:	8d 50 01             	lea    0x1(%eax),%edx
  80140d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801410:	89 c2                	mov    %eax,%edx
  801412:	8b 45 10             	mov    0x10(%ebp),%eax
  801415:	01 c2                	add    %eax,%edx
  801417:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80141a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141d:	01 c8                	add    %ecx,%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801423:	ff 45 f8             	incl   -0x8(%ebp)
  801426:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801429:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80142c:	7c d9                	jl     801407 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80142e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801431:	8b 45 10             	mov    0x10(%ebp),%eax
  801434:	01 d0                	add    %edx,%eax
  801436:	c6 00 00             	movb   $0x0,(%eax)
}
  801439:	90                   	nop
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80143f:	8b 45 14             	mov    0x14(%ebp),%eax
  801442:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801448:	8b 45 14             	mov    0x14(%ebp),%eax
  80144b:	8b 00                	mov    (%eax),%eax
  80144d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801454:	8b 45 10             	mov    0x10(%ebp),%eax
  801457:	01 d0                	add    %edx,%eax
  801459:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80145f:	eb 0c                	jmp    80146d <strsplit+0x31>
			*string++ = 0;
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8d 50 01             	lea    0x1(%eax),%edx
  801467:	89 55 08             	mov    %edx,0x8(%ebp)
  80146a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	84 c0                	test   %al,%al
  801474:	74 18                	je     80148e <strsplit+0x52>
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	8a 00                	mov    (%eax),%al
  80147b:	0f be c0             	movsbl %al,%eax
  80147e:	50                   	push   %eax
  80147f:	ff 75 0c             	pushl  0xc(%ebp)
  801482:	e8 13 fb ff ff       	call   800f9a <strchr>
  801487:	83 c4 08             	add    $0x8,%esp
  80148a:	85 c0                	test   %eax,%eax
  80148c:	75 d3                	jne    801461 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
  801491:	8a 00                	mov    (%eax),%al
  801493:	84 c0                	test   %al,%al
  801495:	74 5a                	je     8014f1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801497:	8b 45 14             	mov    0x14(%ebp),%eax
  80149a:	8b 00                	mov    (%eax),%eax
  80149c:	83 f8 0f             	cmp    $0xf,%eax
  80149f:	75 07                	jne    8014a8 <strsplit+0x6c>
		{
			return 0;
  8014a1:	b8 00 00 00 00       	mov    $0x0,%eax
  8014a6:	eb 66                	jmp    80150e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ab:	8b 00                	mov    (%eax),%eax
  8014ad:	8d 48 01             	lea    0x1(%eax),%ecx
  8014b0:	8b 55 14             	mov    0x14(%ebp),%edx
  8014b3:	89 0a                	mov    %ecx,(%edx)
  8014b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bf:	01 c2                	add    %eax,%edx
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c6:	eb 03                	jmp    8014cb <strsplit+0x8f>
			string++;
  8014c8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	84 c0                	test   %al,%al
  8014d2:	74 8b                	je     80145f <strsplit+0x23>
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	0f be c0             	movsbl %al,%eax
  8014dc:	50                   	push   %eax
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	e8 b5 fa ff ff       	call   800f9a <strchr>
  8014e5:	83 c4 08             	add    $0x8,%esp
  8014e8:	85 c0                	test   %eax,%eax
  8014ea:	74 dc                	je     8014c8 <strsplit+0x8c>
			string++;
	}
  8014ec:	e9 6e ff ff ff       	jmp    80145f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014f1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f5:	8b 00                	mov    (%eax),%eax
  8014f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801509:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
  801513:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	c1 e8 0c             	shr    $0xc,%eax
  80151c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	25 ff 0f 00 00       	and    $0xfff,%eax
  801527:	85 c0                	test   %eax,%eax
  801529:	74 03                	je     80152e <malloc+0x1e>
			num++;
  80152b:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80152e:	a1 04 30 80 00       	mov    0x803004,%eax
  801533:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801538:	75 73                	jne    8015ad <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80153a:	83 ec 08             	sub    $0x8,%esp
  80153d:	ff 75 08             	pushl  0x8(%ebp)
  801540:	68 00 00 00 80       	push   $0x80000000
  801545:	e8 14 05 00 00       	call   801a5e <sys_allocateMem>
  80154a:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80154d:	a1 04 30 80 00       	mov    0x803004,%eax
  801552:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801555:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801558:	c1 e0 0c             	shl    $0xc,%eax
  80155b:	89 c2                	mov    %eax,%edx
  80155d:	a1 04 30 80 00       	mov    0x803004,%eax
  801562:	01 d0                	add    %edx,%eax
  801564:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801569:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80156e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801571:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801578:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80157d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801583:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80158a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80158f:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801596:	01 00 00 00 
			sizeofarray++;
  80159a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80159f:	40                   	inc    %eax
  8015a0:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8015a5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015a8:	e9 71 01 00 00       	jmp    80171e <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8015ad:	a1 28 30 80 00       	mov    0x803028,%eax
  8015b2:	85 c0                	test   %eax,%eax
  8015b4:	75 71                	jne    801627 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8015b6:	a1 04 30 80 00       	mov    0x803004,%eax
  8015bb:	83 ec 08             	sub    $0x8,%esp
  8015be:	ff 75 08             	pushl  0x8(%ebp)
  8015c1:	50                   	push   %eax
  8015c2:	e8 97 04 00 00       	call   801a5e <sys_allocateMem>
  8015c7:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8015ca:	a1 04 30 80 00       	mov    0x803004,%eax
  8015cf:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8015d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015d5:	c1 e0 0c             	shl    $0xc,%eax
  8015d8:	89 c2                	mov    %eax,%edx
  8015da:	a1 04 30 80 00       	mov    0x803004,%eax
  8015df:	01 d0                	add    %edx,%eax
  8015e1:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  8015e6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ee:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8015f5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015fa:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8015fd:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801604:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801609:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801610:	01 00 00 00 
				sizeofarray++;
  801614:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801619:	40                   	inc    %eax
  80161a:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80161f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801622:	e9 f7 00 00 00       	jmp    80171e <malloc+0x20e>
			}
			else{
				int count=0;
  801627:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80162e:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801635:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80163c:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801643:	eb 7c                	jmp    8016c1 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801645:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  80164c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801653:	eb 1a                	jmp    80166f <malloc+0x15f>
					{
						if(addresses[j]==i)
  801655:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801658:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80165f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801662:	75 08                	jne    80166c <malloc+0x15c>
						{
							index=j;
  801664:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801667:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80166a:	eb 0d                	jmp    801679 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80166c:	ff 45 dc             	incl   -0x24(%ebp)
  80166f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801674:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801677:	7c dc                	jl     801655 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801679:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80167d:	75 05                	jne    801684 <malloc+0x174>
					{
						count++;
  80167f:	ff 45 f0             	incl   -0x10(%ebp)
  801682:	eb 36                	jmp    8016ba <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801684:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801687:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  80168e:	85 c0                	test   %eax,%eax
  801690:	75 05                	jne    801697 <malloc+0x187>
						{
							count++;
  801692:	ff 45 f0             	incl   -0x10(%ebp)
  801695:	eb 23                	jmp    8016ba <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801697:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80169a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80169d:	7d 14                	jge    8016b3 <malloc+0x1a3>
  80169f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016a5:	7c 0c                	jl     8016b3 <malloc+0x1a3>
							{
								min=count;
  8016a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8016ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8016b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8016ba:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8016c1:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8016c8:	0f 86 77 ff ff ff    	jbe    801645 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8016ce:	83 ec 08             	sub    $0x8,%esp
  8016d1:	ff 75 08             	pushl  0x8(%ebp)
  8016d4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016d7:	e8 82 03 00 00       	call   801a5e <sys_allocateMem>
  8016dc:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8016df:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016e7:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8016ee:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016f3:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8016f9:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801700:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801705:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80170c:	01 00 00 00 
				sizeofarray++;
  801710:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801715:	40                   	inc    %eax
  801716:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  80171b:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80171e:	c9                   	leave  
  80171f:	c3                   	ret    

00801720 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
  801723:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801726:	8b 45 08             	mov    0x8(%ebp),%eax
  801729:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  80172c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801733:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80173a:	eb 30                	jmp    80176c <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  80173c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80173f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801746:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801749:	75 1e                	jne    801769 <free+0x49>
  80174b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80174e:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801755:	83 f8 01             	cmp    $0x1,%eax
  801758:	75 0f                	jne    801769 <free+0x49>
    		is_found=1;
  80175a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801761:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801764:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801767:	eb 0d                	jmp    801776 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801769:	ff 45 ec             	incl   -0x14(%ebp)
  80176c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801771:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801774:	7c c6                	jl     80173c <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801776:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  80177a:	75 3b                	jne    8017b7 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  80177c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80177f:	8b 04 85 60 50 80 00 	mov    0x805060(,%eax,4),%eax
  801786:	c1 e0 0c             	shl    $0xc,%eax
  801789:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  80178c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80178f:	83 ec 08             	sub    $0x8,%esp
  801792:	50                   	push   %eax
  801793:	ff 75 e8             	pushl  -0x18(%ebp)
  801796:	e8 a7 02 00 00       	call   801a42 <sys_freeMem>
  80179b:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  80179e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017a1:	c7 04 85 c0 40 80 00 	movl   $0x0,0x8040c0(,%eax,4)
  8017a8:	00 00 00 00 
    	changes++;
  8017ac:	a1 28 30 80 00       	mov    0x803028,%eax
  8017b1:	40                   	inc    %eax
  8017b2:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  8017b7:	90                   	nop
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
  8017bd:	83 ec 18             	sub    $0x18,%esp
  8017c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c3:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8017c6:	83 ec 04             	sub    $0x4,%esp
  8017c9:	68 70 27 80 00       	push   $0x802770
  8017ce:	68 9f 00 00 00       	push   $0x9f
  8017d3:	68 93 27 80 00       	push   $0x802793
  8017d8:	e8 07 ed ff ff       	call   8004e4 <_panic>

008017dd <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
  8017e0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017e3:	83 ec 04             	sub    $0x4,%esp
  8017e6:	68 70 27 80 00       	push   $0x802770
  8017eb:	68 a5 00 00 00       	push   $0xa5
  8017f0:	68 93 27 80 00       	push   $0x802793
  8017f5:	e8 ea ec ff ff       	call   8004e4 <_panic>

008017fa <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
  8017fd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801800:	83 ec 04             	sub    $0x4,%esp
  801803:	68 70 27 80 00       	push   $0x802770
  801808:	68 ab 00 00 00       	push   $0xab
  80180d:	68 93 27 80 00       	push   $0x802793
  801812:	e8 cd ec ff ff       	call   8004e4 <_panic>

00801817 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
  80181a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80181d:	83 ec 04             	sub    $0x4,%esp
  801820:	68 70 27 80 00       	push   $0x802770
  801825:	68 b0 00 00 00       	push   $0xb0
  80182a:	68 93 27 80 00       	push   $0x802793
  80182f:	e8 b0 ec ff ff       	call   8004e4 <_panic>

00801834 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
  801837:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80183a:	83 ec 04             	sub    $0x4,%esp
  80183d:	68 70 27 80 00       	push   $0x802770
  801842:	68 b6 00 00 00       	push   $0xb6
  801847:	68 93 27 80 00       	push   $0x802793
  80184c:	e8 93 ec ff ff       	call   8004e4 <_panic>

00801851 <shrink>:
}
void shrink(uint32 newSize)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
  801854:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801857:	83 ec 04             	sub    $0x4,%esp
  80185a:	68 70 27 80 00       	push   $0x802770
  80185f:	68 ba 00 00 00       	push   $0xba
  801864:	68 93 27 80 00       	push   $0x802793
  801869:	e8 76 ec ff ff       	call   8004e4 <_panic>

0080186e <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
  801871:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801874:	83 ec 04             	sub    $0x4,%esp
  801877:	68 70 27 80 00       	push   $0x802770
  80187c:	68 bf 00 00 00       	push   $0xbf
  801881:	68 93 27 80 00       	push   $0x802793
  801886:	e8 59 ec ff ff       	call   8004e4 <_panic>

0080188b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
  80188e:	57                   	push   %edi
  80188f:	56                   	push   %esi
  801890:	53                   	push   %ebx
  801891:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801894:	8b 45 08             	mov    0x8(%ebp),%eax
  801897:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80189d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018a0:	8b 7d 18             	mov    0x18(%ebp),%edi
  8018a3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8018a6:	cd 30                	int    $0x30
  8018a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8018ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018ae:	83 c4 10             	add    $0x10,%esp
  8018b1:	5b                   	pop    %ebx
  8018b2:	5e                   	pop    %esi
  8018b3:	5f                   	pop    %edi
  8018b4:	5d                   	pop    %ebp
  8018b5:	c3                   	ret    

008018b6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
  8018b9:	83 ec 04             	sub    $0x4,%esp
  8018bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018c2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	52                   	push   %edx
  8018ce:	ff 75 0c             	pushl  0xc(%ebp)
  8018d1:	50                   	push   %eax
  8018d2:	6a 00                	push   $0x0
  8018d4:	e8 b2 ff ff ff       	call   80188b <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	90                   	nop
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_cgetc>:

int
sys_cgetc(void)
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 01                	push   $0x1
  8018ee:	e8 98 ff ff ff       	call   80188b <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	50                   	push   %eax
  801907:	6a 05                	push   $0x5
  801909:	e8 7d ff ff ff       	call   80188b <syscall>
  80190e:	83 c4 18             	add    $0x18,%esp
}
  801911:	c9                   	leave  
  801912:	c3                   	ret    

00801913 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801913:	55                   	push   %ebp
  801914:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 02                	push   $0x2
  801922:	e8 64 ff ff ff       	call   80188b <syscall>
  801927:	83 c4 18             	add    $0x18,%esp
}
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 03                	push   $0x3
  80193b:	e8 4b ff ff ff       	call   80188b <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 04                	push   $0x4
  801954:	e8 32 ff ff ff       	call   80188b <syscall>
  801959:	83 c4 18             	add    $0x18,%esp
}
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <sys_env_exit>:


void sys_env_exit(void)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 06                	push   $0x6
  80196d:	e8 19 ff ff ff       	call   80188b <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
}
  801975:	90                   	nop
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80197b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	52                   	push   %edx
  801988:	50                   	push   %eax
  801989:	6a 07                	push   $0x7
  80198b:	e8 fb fe ff ff       	call   80188b <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
  801998:	56                   	push   %esi
  801999:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80199a:	8b 75 18             	mov    0x18(%ebp),%esi
  80199d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a9:	56                   	push   %esi
  8019aa:	53                   	push   %ebx
  8019ab:	51                   	push   %ecx
  8019ac:	52                   	push   %edx
  8019ad:	50                   	push   %eax
  8019ae:	6a 08                	push   $0x8
  8019b0:	e8 d6 fe ff ff       	call   80188b <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019bb:	5b                   	pop    %ebx
  8019bc:	5e                   	pop    %esi
  8019bd:	5d                   	pop    %ebp
  8019be:	c3                   	ret    

008019bf <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019bf:	55                   	push   %ebp
  8019c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	52                   	push   %edx
  8019cf:	50                   	push   %eax
  8019d0:	6a 09                	push   $0x9
  8019d2:	e8 b4 fe ff ff       	call   80188b <syscall>
  8019d7:	83 c4 18             	add    $0x18,%esp
}
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	ff 75 0c             	pushl  0xc(%ebp)
  8019e8:	ff 75 08             	pushl  0x8(%ebp)
  8019eb:	6a 0a                	push   $0xa
  8019ed:	e8 99 fe ff ff       	call   80188b <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
}
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 0b                	push   $0xb
  801a06:	e8 80 fe ff ff       	call   80188b <syscall>
  801a0b:	83 c4 18             	add    $0x18,%esp
}
  801a0e:	c9                   	leave  
  801a0f:	c3                   	ret    

00801a10 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 0c                	push   $0xc
  801a1f:	e8 67 fe ff ff       	call   80188b <syscall>
  801a24:	83 c4 18             	add    $0x18,%esp
}
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 0d                	push   $0xd
  801a38:	e8 4e fe ff ff       	call   80188b <syscall>
  801a3d:	83 c4 18             	add    $0x18,%esp
}
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	ff 75 0c             	pushl  0xc(%ebp)
  801a4e:	ff 75 08             	pushl  0x8(%ebp)
  801a51:	6a 11                	push   $0x11
  801a53:	e8 33 fe ff ff       	call   80188b <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
	return;
  801a5b:	90                   	nop
}
  801a5c:	c9                   	leave  
  801a5d:	c3                   	ret    

00801a5e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	ff 75 0c             	pushl  0xc(%ebp)
  801a6a:	ff 75 08             	pushl  0x8(%ebp)
  801a6d:	6a 12                	push   $0x12
  801a6f:	e8 17 fe ff ff       	call   80188b <syscall>
  801a74:	83 c4 18             	add    $0x18,%esp
	return ;
  801a77:	90                   	nop
}
  801a78:	c9                   	leave  
  801a79:	c3                   	ret    

00801a7a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 0e                	push   $0xe
  801a89:	e8 fd fd ff ff       	call   80188b <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
}
  801a91:	c9                   	leave  
  801a92:	c3                   	ret    

00801a93 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	ff 75 08             	pushl  0x8(%ebp)
  801aa1:	6a 0f                	push   $0xf
  801aa3:	e8 e3 fd ff ff       	call   80188b <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <sys_scarce_memory>:

void sys_scarce_memory()
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 10                	push   $0x10
  801abc:	e8 ca fd ff ff       	call   80188b <syscall>
  801ac1:	83 c4 18             	add    $0x18,%esp
}
  801ac4:	90                   	nop
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 14                	push   $0x14
  801ad6:	e8 b0 fd ff ff       	call   80188b <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	90                   	nop
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 15                	push   $0x15
  801af0:	e8 96 fd ff ff       	call   80188b <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	90                   	nop
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_cputc>:


void
sys_cputc(const char c)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
  801afe:	83 ec 04             	sub    $0x4,%esp
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b07:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	50                   	push   %eax
  801b14:	6a 16                	push   $0x16
  801b16:	e8 70 fd ff ff       	call   80188b <syscall>
  801b1b:	83 c4 18             	add    $0x18,%esp
}
  801b1e:	90                   	nop
  801b1f:	c9                   	leave  
  801b20:	c3                   	ret    

00801b21 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b21:	55                   	push   %ebp
  801b22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 17                	push   $0x17
  801b30:	e8 56 fd ff ff       	call   80188b <syscall>
  801b35:	83 c4 18             	add    $0x18,%esp
}
  801b38:	90                   	nop
  801b39:	c9                   	leave  
  801b3a:	c3                   	ret    

00801b3b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b3b:	55                   	push   %ebp
  801b3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	ff 75 0c             	pushl  0xc(%ebp)
  801b4a:	50                   	push   %eax
  801b4b:	6a 18                	push   $0x18
  801b4d:	e8 39 fd ff ff       	call   80188b <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
}
  801b55:	c9                   	leave  
  801b56:	c3                   	ret    

00801b57 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	52                   	push   %edx
  801b67:	50                   	push   %eax
  801b68:	6a 1b                	push   $0x1b
  801b6a:	e8 1c fd ff ff       	call   80188b <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	52                   	push   %edx
  801b84:	50                   	push   %eax
  801b85:	6a 19                	push   $0x19
  801b87:	e8 ff fc ff ff       	call   80188b <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
}
  801b8f:	90                   	nop
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b98:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	52                   	push   %edx
  801ba2:	50                   	push   %eax
  801ba3:	6a 1a                	push   $0x1a
  801ba5:	e8 e1 fc ff ff       	call   80188b <syscall>
  801baa:	83 c4 18             	add    $0x18,%esp
}
  801bad:	90                   	nop
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801bb0:	55                   	push   %ebp
  801bb1:	89 e5                	mov    %esp,%ebp
  801bb3:	83 ec 04             	sub    $0x4,%esp
  801bb6:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801bbc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801bbf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc6:	6a 00                	push   $0x0
  801bc8:	51                   	push   %ecx
  801bc9:	52                   	push   %edx
  801bca:	ff 75 0c             	pushl  0xc(%ebp)
  801bcd:	50                   	push   %eax
  801bce:	6a 1c                	push   $0x1c
  801bd0:	e8 b6 fc ff ff       	call   80188b <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
}
  801bd8:	c9                   	leave  
  801bd9:	c3                   	ret    

00801bda <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801bdd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be0:	8b 45 08             	mov    0x8(%ebp),%eax
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	52                   	push   %edx
  801bea:	50                   	push   %eax
  801beb:	6a 1d                	push   $0x1d
  801bed:	e8 99 fc ff ff       	call   80188b <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801bfa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	51                   	push   %ecx
  801c08:	52                   	push   %edx
  801c09:	50                   	push   %eax
  801c0a:	6a 1e                	push   $0x1e
  801c0c:	e8 7a fc ff ff       	call   80188b <syscall>
  801c11:	83 c4 18             	add    $0x18,%esp
}
  801c14:	c9                   	leave  
  801c15:	c3                   	ret    

00801c16 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c16:	55                   	push   %ebp
  801c17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	52                   	push   %edx
  801c26:	50                   	push   %eax
  801c27:	6a 1f                	push   $0x1f
  801c29:	e8 5d fc ff ff       	call   80188b <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 20                	push   $0x20
  801c42:	e8 44 fc ff ff       	call   80188b <syscall>
  801c47:	83 c4 18             	add    $0x18,%esp
}
  801c4a:	c9                   	leave  
  801c4b:	c3                   	ret    

00801c4c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c52:	6a 00                	push   $0x0
  801c54:	ff 75 14             	pushl  0x14(%ebp)
  801c57:	ff 75 10             	pushl  0x10(%ebp)
  801c5a:	ff 75 0c             	pushl  0xc(%ebp)
  801c5d:	50                   	push   %eax
  801c5e:	6a 21                	push   $0x21
  801c60:	e8 26 fc ff ff       	call   80188b <syscall>
  801c65:	83 c4 18             	add    $0x18,%esp
}
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	50                   	push   %eax
  801c79:	6a 22                	push   $0x22
  801c7b:	e8 0b fc ff ff       	call   80188b <syscall>
  801c80:	83 c4 18             	add    $0x18,%esp
}
  801c83:	90                   	nop
  801c84:	c9                   	leave  
  801c85:	c3                   	ret    

00801c86 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c86:	55                   	push   %ebp
  801c87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c89:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	50                   	push   %eax
  801c95:	6a 23                	push   $0x23
  801c97:	e8 ef fb ff ff       	call   80188b <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	90                   	nop
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
  801ca5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ca8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cab:	8d 50 04             	lea    0x4(%eax),%edx
  801cae:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	52                   	push   %edx
  801cb8:	50                   	push   %eax
  801cb9:	6a 24                	push   $0x24
  801cbb:	e8 cb fb ff ff       	call   80188b <syscall>
  801cc0:	83 c4 18             	add    $0x18,%esp
	return result;
  801cc3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801cc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cc9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ccc:	89 01                	mov    %eax,(%ecx)
  801cce:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	c9                   	leave  
  801cd5:	c2 04 00             	ret    $0x4

00801cd8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801cd8:	55                   	push   %ebp
  801cd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	ff 75 10             	pushl  0x10(%ebp)
  801ce2:	ff 75 0c             	pushl  0xc(%ebp)
  801ce5:	ff 75 08             	pushl  0x8(%ebp)
  801ce8:	6a 13                	push   $0x13
  801cea:	e8 9c fb ff ff       	call   80188b <syscall>
  801cef:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf2:	90                   	nop
}
  801cf3:	c9                   	leave  
  801cf4:	c3                   	ret    

00801cf5 <sys_rcr2>:
uint32 sys_rcr2()
{
  801cf5:	55                   	push   %ebp
  801cf6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 25                	push   $0x25
  801d04:	e8 82 fb ff ff       	call   80188b <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
}
  801d0c:	c9                   	leave  
  801d0d:	c3                   	ret    

00801d0e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d0e:	55                   	push   %ebp
  801d0f:	89 e5                	mov    %esp,%ebp
  801d11:	83 ec 04             	sub    $0x4,%esp
  801d14:	8b 45 08             	mov    0x8(%ebp),%eax
  801d17:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d1a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	50                   	push   %eax
  801d27:	6a 26                	push   $0x26
  801d29:	e8 5d fb ff ff       	call   80188b <syscall>
  801d2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801d31:	90                   	nop
}
  801d32:	c9                   	leave  
  801d33:	c3                   	ret    

00801d34 <rsttst>:
void rsttst()
{
  801d34:	55                   	push   %ebp
  801d35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 28                	push   $0x28
  801d43:	e8 43 fb ff ff       	call   80188b <syscall>
  801d48:	83 c4 18             	add    $0x18,%esp
	return ;
  801d4b:	90                   	nop
}
  801d4c:	c9                   	leave  
  801d4d:	c3                   	ret    

00801d4e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d4e:	55                   	push   %ebp
  801d4f:	89 e5                	mov    %esp,%ebp
  801d51:	83 ec 04             	sub    $0x4,%esp
  801d54:	8b 45 14             	mov    0x14(%ebp),%eax
  801d57:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d5a:	8b 55 18             	mov    0x18(%ebp),%edx
  801d5d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d61:	52                   	push   %edx
  801d62:	50                   	push   %eax
  801d63:	ff 75 10             	pushl  0x10(%ebp)
  801d66:	ff 75 0c             	pushl  0xc(%ebp)
  801d69:	ff 75 08             	pushl  0x8(%ebp)
  801d6c:	6a 27                	push   $0x27
  801d6e:	e8 18 fb ff ff       	call   80188b <syscall>
  801d73:	83 c4 18             	add    $0x18,%esp
	return ;
  801d76:	90                   	nop
}
  801d77:	c9                   	leave  
  801d78:	c3                   	ret    

00801d79 <chktst>:
void chktst(uint32 n)
{
  801d79:	55                   	push   %ebp
  801d7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	ff 75 08             	pushl  0x8(%ebp)
  801d87:	6a 29                	push   $0x29
  801d89:	e8 fd fa ff ff       	call   80188b <syscall>
  801d8e:	83 c4 18             	add    $0x18,%esp
	return ;
  801d91:	90                   	nop
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <inctst>:

void inctst()
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 2a                	push   $0x2a
  801da3:	e8 e3 fa ff ff       	call   80188b <syscall>
  801da8:	83 c4 18             	add    $0x18,%esp
	return ;
  801dab:	90                   	nop
}
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <gettst>:
uint32 gettst()
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 2b                	push   $0x2b
  801dbd:	e8 c9 fa ff ff       	call   80188b <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
  801dca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 2c                	push   $0x2c
  801dd9:	e8 ad fa ff ff       	call   80188b <syscall>
  801dde:	83 c4 18             	add    $0x18,%esp
  801de1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801de4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801de8:	75 07                	jne    801df1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801dea:	b8 01 00 00 00       	mov    $0x1,%eax
  801def:	eb 05                	jmp    801df6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801df1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801df6:	c9                   	leave  
  801df7:	c3                   	ret    

00801df8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801df8:	55                   	push   %ebp
  801df9:	89 e5                	mov    %esp,%ebp
  801dfb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 2c                	push   $0x2c
  801e0a:	e8 7c fa ff ff       	call   80188b <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
  801e12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e15:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e19:	75 07                	jne    801e22 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e1b:	b8 01 00 00 00       	mov    $0x1,%eax
  801e20:	eb 05                	jmp    801e27 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
  801e2c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 2c                	push   $0x2c
  801e3b:	e8 4b fa ff ff       	call   80188b <syscall>
  801e40:	83 c4 18             	add    $0x18,%esp
  801e43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e46:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e4a:	75 07                	jne    801e53 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e4c:	b8 01 00 00 00       	mov    $0x1,%eax
  801e51:	eb 05                	jmp    801e58 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e58:	c9                   	leave  
  801e59:	c3                   	ret    

00801e5a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e5a:	55                   	push   %ebp
  801e5b:	89 e5                	mov    %esp,%ebp
  801e5d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 2c                	push   $0x2c
  801e6c:	e8 1a fa ff ff       	call   80188b <syscall>
  801e71:	83 c4 18             	add    $0x18,%esp
  801e74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e77:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e7b:	75 07                	jne    801e84 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e7d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e82:	eb 05                	jmp    801e89 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e84:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	ff 75 08             	pushl  0x8(%ebp)
  801e99:	6a 2d                	push   $0x2d
  801e9b:	e8 eb f9 ff ff       	call   80188b <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea3:	90                   	nop
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
  801ea9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801eaa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ead:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb6:	6a 00                	push   $0x0
  801eb8:	53                   	push   %ebx
  801eb9:	51                   	push   %ecx
  801eba:	52                   	push   %edx
  801ebb:	50                   	push   %eax
  801ebc:	6a 2e                	push   $0x2e
  801ebe:	e8 c8 f9 ff ff       	call   80188b <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ec9:	c9                   	leave  
  801eca:	c3                   	ret    

00801ecb <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ecb:	55                   	push   %ebp
  801ecc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ece:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	52                   	push   %edx
  801edb:	50                   	push   %eax
  801edc:	6a 2f                	push   $0x2f
  801ede:	e8 a8 f9 ff ff       	call   80188b <syscall>
  801ee3:	83 c4 18             	add    $0x18,%esp
}
  801ee6:	c9                   	leave  
  801ee7:	c3                   	ret    

00801ee8 <__udivdi3>:
  801ee8:	55                   	push   %ebp
  801ee9:	57                   	push   %edi
  801eea:	56                   	push   %esi
  801eeb:	53                   	push   %ebx
  801eec:	83 ec 1c             	sub    $0x1c,%esp
  801eef:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ef3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ef7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801efb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801eff:	89 ca                	mov    %ecx,%edx
  801f01:	89 f8                	mov    %edi,%eax
  801f03:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f07:	85 f6                	test   %esi,%esi
  801f09:	75 2d                	jne    801f38 <__udivdi3+0x50>
  801f0b:	39 cf                	cmp    %ecx,%edi
  801f0d:	77 65                	ja     801f74 <__udivdi3+0x8c>
  801f0f:	89 fd                	mov    %edi,%ebp
  801f11:	85 ff                	test   %edi,%edi
  801f13:	75 0b                	jne    801f20 <__udivdi3+0x38>
  801f15:	b8 01 00 00 00       	mov    $0x1,%eax
  801f1a:	31 d2                	xor    %edx,%edx
  801f1c:	f7 f7                	div    %edi
  801f1e:	89 c5                	mov    %eax,%ebp
  801f20:	31 d2                	xor    %edx,%edx
  801f22:	89 c8                	mov    %ecx,%eax
  801f24:	f7 f5                	div    %ebp
  801f26:	89 c1                	mov    %eax,%ecx
  801f28:	89 d8                	mov    %ebx,%eax
  801f2a:	f7 f5                	div    %ebp
  801f2c:	89 cf                	mov    %ecx,%edi
  801f2e:	89 fa                	mov    %edi,%edx
  801f30:	83 c4 1c             	add    $0x1c,%esp
  801f33:	5b                   	pop    %ebx
  801f34:	5e                   	pop    %esi
  801f35:	5f                   	pop    %edi
  801f36:	5d                   	pop    %ebp
  801f37:	c3                   	ret    
  801f38:	39 ce                	cmp    %ecx,%esi
  801f3a:	77 28                	ja     801f64 <__udivdi3+0x7c>
  801f3c:	0f bd fe             	bsr    %esi,%edi
  801f3f:	83 f7 1f             	xor    $0x1f,%edi
  801f42:	75 40                	jne    801f84 <__udivdi3+0x9c>
  801f44:	39 ce                	cmp    %ecx,%esi
  801f46:	72 0a                	jb     801f52 <__udivdi3+0x6a>
  801f48:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f4c:	0f 87 9e 00 00 00    	ja     801ff0 <__udivdi3+0x108>
  801f52:	b8 01 00 00 00       	mov    $0x1,%eax
  801f57:	89 fa                	mov    %edi,%edx
  801f59:	83 c4 1c             	add    $0x1c,%esp
  801f5c:	5b                   	pop    %ebx
  801f5d:	5e                   	pop    %esi
  801f5e:	5f                   	pop    %edi
  801f5f:	5d                   	pop    %ebp
  801f60:	c3                   	ret    
  801f61:	8d 76 00             	lea    0x0(%esi),%esi
  801f64:	31 ff                	xor    %edi,%edi
  801f66:	31 c0                	xor    %eax,%eax
  801f68:	89 fa                	mov    %edi,%edx
  801f6a:	83 c4 1c             	add    $0x1c,%esp
  801f6d:	5b                   	pop    %ebx
  801f6e:	5e                   	pop    %esi
  801f6f:	5f                   	pop    %edi
  801f70:	5d                   	pop    %ebp
  801f71:	c3                   	ret    
  801f72:	66 90                	xchg   %ax,%ax
  801f74:	89 d8                	mov    %ebx,%eax
  801f76:	f7 f7                	div    %edi
  801f78:	31 ff                	xor    %edi,%edi
  801f7a:	89 fa                	mov    %edi,%edx
  801f7c:	83 c4 1c             	add    $0x1c,%esp
  801f7f:	5b                   	pop    %ebx
  801f80:	5e                   	pop    %esi
  801f81:	5f                   	pop    %edi
  801f82:	5d                   	pop    %ebp
  801f83:	c3                   	ret    
  801f84:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f89:	89 eb                	mov    %ebp,%ebx
  801f8b:	29 fb                	sub    %edi,%ebx
  801f8d:	89 f9                	mov    %edi,%ecx
  801f8f:	d3 e6                	shl    %cl,%esi
  801f91:	89 c5                	mov    %eax,%ebp
  801f93:	88 d9                	mov    %bl,%cl
  801f95:	d3 ed                	shr    %cl,%ebp
  801f97:	89 e9                	mov    %ebp,%ecx
  801f99:	09 f1                	or     %esi,%ecx
  801f9b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f9f:	89 f9                	mov    %edi,%ecx
  801fa1:	d3 e0                	shl    %cl,%eax
  801fa3:	89 c5                	mov    %eax,%ebp
  801fa5:	89 d6                	mov    %edx,%esi
  801fa7:	88 d9                	mov    %bl,%cl
  801fa9:	d3 ee                	shr    %cl,%esi
  801fab:	89 f9                	mov    %edi,%ecx
  801fad:	d3 e2                	shl    %cl,%edx
  801faf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fb3:	88 d9                	mov    %bl,%cl
  801fb5:	d3 e8                	shr    %cl,%eax
  801fb7:	09 c2                	or     %eax,%edx
  801fb9:	89 d0                	mov    %edx,%eax
  801fbb:	89 f2                	mov    %esi,%edx
  801fbd:	f7 74 24 0c          	divl   0xc(%esp)
  801fc1:	89 d6                	mov    %edx,%esi
  801fc3:	89 c3                	mov    %eax,%ebx
  801fc5:	f7 e5                	mul    %ebp
  801fc7:	39 d6                	cmp    %edx,%esi
  801fc9:	72 19                	jb     801fe4 <__udivdi3+0xfc>
  801fcb:	74 0b                	je     801fd8 <__udivdi3+0xf0>
  801fcd:	89 d8                	mov    %ebx,%eax
  801fcf:	31 ff                	xor    %edi,%edi
  801fd1:	e9 58 ff ff ff       	jmp    801f2e <__udivdi3+0x46>
  801fd6:	66 90                	xchg   %ax,%ax
  801fd8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fdc:	89 f9                	mov    %edi,%ecx
  801fde:	d3 e2                	shl    %cl,%edx
  801fe0:	39 c2                	cmp    %eax,%edx
  801fe2:	73 e9                	jae    801fcd <__udivdi3+0xe5>
  801fe4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fe7:	31 ff                	xor    %edi,%edi
  801fe9:	e9 40 ff ff ff       	jmp    801f2e <__udivdi3+0x46>
  801fee:	66 90                	xchg   %ax,%ax
  801ff0:	31 c0                	xor    %eax,%eax
  801ff2:	e9 37 ff ff ff       	jmp    801f2e <__udivdi3+0x46>
  801ff7:	90                   	nop

00801ff8 <__umoddi3>:
  801ff8:	55                   	push   %ebp
  801ff9:	57                   	push   %edi
  801ffa:	56                   	push   %esi
  801ffb:	53                   	push   %ebx
  801ffc:	83 ec 1c             	sub    $0x1c,%esp
  801fff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802003:	8b 74 24 34          	mov    0x34(%esp),%esi
  802007:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80200b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80200f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802013:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802017:	89 f3                	mov    %esi,%ebx
  802019:	89 fa                	mov    %edi,%edx
  80201b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80201f:	89 34 24             	mov    %esi,(%esp)
  802022:	85 c0                	test   %eax,%eax
  802024:	75 1a                	jne    802040 <__umoddi3+0x48>
  802026:	39 f7                	cmp    %esi,%edi
  802028:	0f 86 a2 00 00 00    	jbe    8020d0 <__umoddi3+0xd8>
  80202e:	89 c8                	mov    %ecx,%eax
  802030:	89 f2                	mov    %esi,%edx
  802032:	f7 f7                	div    %edi
  802034:	89 d0                	mov    %edx,%eax
  802036:	31 d2                	xor    %edx,%edx
  802038:	83 c4 1c             	add    $0x1c,%esp
  80203b:	5b                   	pop    %ebx
  80203c:	5e                   	pop    %esi
  80203d:	5f                   	pop    %edi
  80203e:	5d                   	pop    %ebp
  80203f:	c3                   	ret    
  802040:	39 f0                	cmp    %esi,%eax
  802042:	0f 87 ac 00 00 00    	ja     8020f4 <__umoddi3+0xfc>
  802048:	0f bd e8             	bsr    %eax,%ebp
  80204b:	83 f5 1f             	xor    $0x1f,%ebp
  80204e:	0f 84 ac 00 00 00    	je     802100 <__umoddi3+0x108>
  802054:	bf 20 00 00 00       	mov    $0x20,%edi
  802059:	29 ef                	sub    %ebp,%edi
  80205b:	89 fe                	mov    %edi,%esi
  80205d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802061:	89 e9                	mov    %ebp,%ecx
  802063:	d3 e0                	shl    %cl,%eax
  802065:	89 d7                	mov    %edx,%edi
  802067:	89 f1                	mov    %esi,%ecx
  802069:	d3 ef                	shr    %cl,%edi
  80206b:	09 c7                	or     %eax,%edi
  80206d:	89 e9                	mov    %ebp,%ecx
  80206f:	d3 e2                	shl    %cl,%edx
  802071:	89 14 24             	mov    %edx,(%esp)
  802074:	89 d8                	mov    %ebx,%eax
  802076:	d3 e0                	shl    %cl,%eax
  802078:	89 c2                	mov    %eax,%edx
  80207a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80207e:	d3 e0                	shl    %cl,%eax
  802080:	89 44 24 04          	mov    %eax,0x4(%esp)
  802084:	8b 44 24 08          	mov    0x8(%esp),%eax
  802088:	89 f1                	mov    %esi,%ecx
  80208a:	d3 e8                	shr    %cl,%eax
  80208c:	09 d0                	or     %edx,%eax
  80208e:	d3 eb                	shr    %cl,%ebx
  802090:	89 da                	mov    %ebx,%edx
  802092:	f7 f7                	div    %edi
  802094:	89 d3                	mov    %edx,%ebx
  802096:	f7 24 24             	mull   (%esp)
  802099:	89 c6                	mov    %eax,%esi
  80209b:	89 d1                	mov    %edx,%ecx
  80209d:	39 d3                	cmp    %edx,%ebx
  80209f:	0f 82 87 00 00 00    	jb     80212c <__umoddi3+0x134>
  8020a5:	0f 84 91 00 00 00    	je     80213c <__umoddi3+0x144>
  8020ab:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020af:	29 f2                	sub    %esi,%edx
  8020b1:	19 cb                	sbb    %ecx,%ebx
  8020b3:	89 d8                	mov    %ebx,%eax
  8020b5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020b9:	d3 e0                	shl    %cl,%eax
  8020bb:	89 e9                	mov    %ebp,%ecx
  8020bd:	d3 ea                	shr    %cl,%edx
  8020bf:	09 d0                	or     %edx,%eax
  8020c1:	89 e9                	mov    %ebp,%ecx
  8020c3:	d3 eb                	shr    %cl,%ebx
  8020c5:	89 da                	mov    %ebx,%edx
  8020c7:	83 c4 1c             	add    $0x1c,%esp
  8020ca:	5b                   	pop    %ebx
  8020cb:	5e                   	pop    %esi
  8020cc:	5f                   	pop    %edi
  8020cd:	5d                   	pop    %ebp
  8020ce:	c3                   	ret    
  8020cf:	90                   	nop
  8020d0:	89 fd                	mov    %edi,%ebp
  8020d2:	85 ff                	test   %edi,%edi
  8020d4:	75 0b                	jne    8020e1 <__umoddi3+0xe9>
  8020d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020db:	31 d2                	xor    %edx,%edx
  8020dd:	f7 f7                	div    %edi
  8020df:	89 c5                	mov    %eax,%ebp
  8020e1:	89 f0                	mov    %esi,%eax
  8020e3:	31 d2                	xor    %edx,%edx
  8020e5:	f7 f5                	div    %ebp
  8020e7:	89 c8                	mov    %ecx,%eax
  8020e9:	f7 f5                	div    %ebp
  8020eb:	89 d0                	mov    %edx,%eax
  8020ed:	e9 44 ff ff ff       	jmp    802036 <__umoddi3+0x3e>
  8020f2:	66 90                	xchg   %ax,%ax
  8020f4:	89 c8                	mov    %ecx,%eax
  8020f6:	89 f2                	mov    %esi,%edx
  8020f8:	83 c4 1c             	add    $0x1c,%esp
  8020fb:	5b                   	pop    %ebx
  8020fc:	5e                   	pop    %esi
  8020fd:	5f                   	pop    %edi
  8020fe:	5d                   	pop    %ebp
  8020ff:	c3                   	ret    
  802100:	3b 04 24             	cmp    (%esp),%eax
  802103:	72 06                	jb     80210b <__umoddi3+0x113>
  802105:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802109:	77 0f                	ja     80211a <__umoddi3+0x122>
  80210b:	89 f2                	mov    %esi,%edx
  80210d:	29 f9                	sub    %edi,%ecx
  80210f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802113:	89 14 24             	mov    %edx,(%esp)
  802116:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80211a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80211e:	8b 14 24             	mov    (%esp),%edx
  802121:	83 c4 1c             	add    $0x1c,%esp
  802124:	5b                   	pop    %ebx
  802125:	5e                   	pop    %esi
  802126:	5f                   	pop    %edi
  802127:	5d                   	pop    %ebp
  802128:	c3                   	ret    
  802129:	8d 76 00             	lea    0x0(%esi),%esi
  80212c:	2b 04 24             	sub    (%esp),%eax
  80212f:	19 fa                	sbb    %edi,%edx
  802131:	89 d1                	mov    %edx,%ecx
  802133:	89 c6                	mov    %eax,%esi
  802135:	e9 71 ff ff ff       	jmp    8020ab <__umoddi3+0xb3>
  80213a:	66 90                	xchg   %ax,%ax
  80213c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802140:	72 ea                	jb     80212c <__umoddi3+0x134>
  802142:	89 d9                	mov    %ebx,%ecx
  802144:	e9 62 ff ff ff       	jmp    8020ab <__umoddi3+0xb3>
