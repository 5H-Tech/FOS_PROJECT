
obj/user/tst2:     file format elf32-i386


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
  800031:	e8 12 03 00 00       	call   800348 <libmain>
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
	

	rsttst();
  800042:	e8 bc 1b 00 00       	call   801c03 <rsttst>
	
	

	int Mega = 1024*1024;
  800047:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  80004e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	char minByte = 1<<7;
  800055:	c6 45 ef 80          	movb   $0x80,-0x11(%ebp)
	char maxByte = 0x7F;
  800059:	c6 45 ee 7f          	movb   $0x7f,-0x12(%ebp)
	short minShort = 1<<15 ;
  80005d:	66 c7 45 ec 00 80    	movw   $0x8000,-0x14(%ebp)
	short maxShort = 0x7FFF;
  800063:	66 c7 45 ea ff 7f    	movw   $0x7fff,-0x16(%ebp)
	int minInt = 1<<31 ;
  800069:	c7 45 e4 00 00 00 80 	movl   $0x80000000,-0x1c(%ebp)
	int maxInt = 0x7FFFFFFF;
  800070:	c7 45 e0 ff ff ff 7f 	movl   $0x7fffffff,-0x20(%ebp)

	void* ptr_allocations[20] = {0};
  800077:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
  80007d:	b9 14 00 00 00       	mov    $0x14,%ecx
  800082:	b8 00 00 00 00       	mov    $0x0,%eax
  800087:	89 d7                	mov    %edx,%edi
  800089:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		ptr_allocations[0] = malloc(2*Mega-kilo);
  80008b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80008e:	01 c0                	add    %eax,%eax
  800090:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 1d 14 00 00       	call   8014b9 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  8000a5:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8000ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  8000ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b1:	01 c0                	add    %eax,%eax
  8000b3:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000b6:	48                   	dec    %eax
  8000b7:	89 45 d8             	mov    %eax,-0x28(%ebp)
		byteArr[0] = minByte ;
  8000ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000bd:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8000c0:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  8000c2:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8000c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000c8:	01 c2                	add    %eax,%edx
  8000ca:	8a 45 ee             	mov    -0x12(%ebp),%al
  8000cd:	88 02                	mov    %al,(%edx)

		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d2:	01 c0                	add    %eax,%eax
  8000d4:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	50                   	push   %eax
  8000db:	e8 d9 13 00 00       	call   8014b9 <malloc>
  8000e0:	83 c4 10             	add    $0x10,%esp
  8000e3:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  8000e9:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8000ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  8000f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000f5:	01 c0                	add    %eax,%eax
  8000f7:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000fa:	d1 e8                	shr    %eax
  8000fc:	48                   	dec    %eax
  8000fd:	89 45 d0             	mov    %eax,-0x30(%ebp)
		shortArr[0] = minShort;
  800100:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800103:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800106:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800109:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	89 c2                	mov    %eax,%edx
  800110:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800113:	01 c2                	add    %eax,%edx
  800115:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  800119:	66 89 02             	mov    %ax,(%edx)

		ptr_allocations[2] = malloc(2*kilo);
  80011c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80011f:	01 c0                	add    %eax,%eax
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	50                   	push   %eax
  800125:	e8 8f 13 00 00       	call   8014b9 <malloc>
  80012a:	83 c4 10             	add    $0x10,%esp
  80012d:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  800133:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800139:	89 45 cc             	mov    %eax,-0x34(%ebp)
		int lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  80013c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80013f:	01 c0                	add    %eax,%eax
  800141:	c1 e8 02             	shr    $0x2,%eax
  800144:	48                   	dec    %eax
  800145:	89 45 c8             	mov    %eax,-0x38(%ebp)
		intArr[0] = minInt;
  800148:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80014b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80014e:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800150:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800153:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80015a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80015d:	01 c2                	add    %eax,%edx
  80015f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800162:	89 02                	mov    %eax,(%edx)

		ptr_allocations[3] = malloc(7*kilo);
  800164:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800167:	89 d0                	mov    %edx,%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	01 d0                	add    %edx,%eax
  80016d:	01 c0                	add    %eax,%eax
  80016f:	01 d0                	add    %edx,%eax
  800171:	83 ec 0c             	sub    $0xc,%esp
  800174:	50                   	push   %eax
  800175:	e8 3f 13 00 00       	call   8014b9 <malloc>
  80017a:	83 c4 10             	add    $0x10,%esp
  80017d:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  800183:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800189:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  80018c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80018f:	89 d0                	mov    %edx,%eax
  800191:	01 c0                	add    %eax,%eax
  800193:	01 d0                	add    %edx,%eax
  800195:	01 c0                	add    %eax,%eax
  800197:	01 d0                	add    %edx,%eax
  800199:	c1 e8 03             	shr    $0x3,%eax
  80019c:	48                   	dec    %eax
  80019d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8001a0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001a3:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8001a6:	88 10                	mov    %dl,(%eax)
  8001a8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  8001ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001ae:	66 89 42 02          	mov    %ax,0x2(%edx)
  8001b2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8001b8:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  8001bb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001be:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8001c5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001c8:	01 c2                	add    %eax,%edx
  8001ca:	8a 45 ee             	mov    -0x12(%ebp),%al
  8001cd:	88 02                	mov    %al,(%edx)
  8001cf:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8001d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001dc:	01 c2                	add    %eax,%edx
  8001de:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  8001e2:	66 89 42 02          	mov    %ax,0x2(%edx)
  8001e6:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001e9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8001f0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001f3:	01 c2                	add    %eax,%edx
  8001f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001f8:	89 42 04             	mov    %eax,0x4(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  8001fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001fe:	8a 00                	mov    (%eax),%al
  800200:	3a 45 ef             	cmp    -0x11(%ebp),%al
  800203:	75 0f                	jne    800214 <_main+0x1dc>
  800205:	8b 55 d8             	mov    -0x28(%ebp),%edx
  800208:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80020b:	01 d0                	add    %edx,%eax
  80020d:	8a 00                	mov    (%eax),%al
  80020f:	3a 45 ee             	cmp    -0x12(%ebp),%al
  800212:	74 14                	je     800228 <_main+0x1f0>
  800214:	83 ec 04             	sub    $0x4,%esp
  800217:	68 20 20 80 00       	push   $0x802020
  80021c:	6a 35                	push   $0x35
  80021e:	68 55 20 80 00       	push   $0x802055
  800223:	e8 65 02 00 00       	call   80048d <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  800228:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80022b:	66 8b 00             	mov    (%eax),%ax
  80022e:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  800232:	75 15                	jne    800249 <_main+0x211>
  800234:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800237:	01 c0                	add    %eax,%eax
  800239:	89 c2                	mov    %eax,%edx
  80023b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80023e:	01 d0                	add    %edx,%eax
  800240:	66 8b 00             	mov    (%eax),%ax
  800243:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 20 20 80 00       	push   $0x802020
  800251:	6a 36                	push   $0x36
  800253:	68 55 20 80 00       	push   $0x802055
  800258:	e8 30 02 00 00       	call   80048d <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  80025d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800260:	8b 00                	mov    (%eax),%eax
  800262:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800265:	75 16                	jne    80027d <_main+0x245>
  800267:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800271:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800274:	01 d0                	add    %edx,%eax
  800276:	8b 00                	mov    (%eax),%eax
  800278:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80027b:	74 14                	je     800291 <_main+0x259>
  80027d:	83 ec 04             	sub    $0x4,%esp
  800280:	68 20 20 80 00       	push   $0x802020
  800285:	6a 37                	push   $0x37
  800287:	68 55 20 80 00       	push   $0x802055
  80028c:	e8 fc 01 00 00       	call   80048d <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  800291:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800294:	8a 00                	mov    (%eax),%al
  800296:	3a 45 ef             	cmp    -0x11(%ebp),%al
  800299:	75 16                	jne    8002b1 <_main+0x279>
  80029b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80029e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002a5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002a8:	01 d0                	add    %edx,%eax
  8002aa:	8a 00                	mov    (%eax),%al
  8002ac:	3a 45 ee             	cmp    -0x12(%ebp),%al
  8002af:	74 14                	je     8002c5 <_main+0x28d>
  8002b1:	83 ec 04             	sub    $0x4,%esp
  8002b4:	68 20 20 80 00       	push   $0x802020
  8002b9:	6a 39                	push   $0x39
  8002bb:	68 55 20 80 00       	push   $0x802055
  8002c0:	e8 c8 01 00 00       	call   80048d <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002c5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002c8:	66 8b 40 02          	mov    0x2(%eax),%ax
  8002cc:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  8002d0:	75 19                	jne    8002eb <_main+0x2b3>
  8002d2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002dc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002df:	01 d0                	add    %edx,%eax
  8002e1:	66 8b 40 02          	mov    0x2(%eax),%ax
  8002e5:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 20 20 80 00       	push   $0x802020
  8002f3:	6a 3a                	push   $0x3a
  8002f5:	68 55 20 80 00       	push   $0x802055
  8002fa:	e8 8e 01 00 00       	call   80048d <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800302:	8b 40 04             	mov    0x4(%eax),%eax
  800305:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800308:	75 17                	jne    800321 <_main+0x2e9>
  80030a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80030d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800314:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800317:	01 d0                	add    %edx,%eax
  800319:	8b 40 04             	mov    0x4(%eax),%eax
  80031c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80031f:	74 14                	je     800335 <_main+0x2fd>
  800321:	83 ec 04             	sub    $0x4,%esp
  800324:	68 20 20 80 00       	push   $0x802020
  800329:	6a 3b                	push   $0x3b
  80032b:	68 55 20 80 00       	push   $0x802055
  800330:	e8 58 01 00 00       	call   80048d <_panic>


	}

	chktst(0);
  800335:	83 ec 0c             	sub    $0xc,%esp
  800338:	6a 00                	push   $0x0
  80033a:	e8 09 19 00 00       	call   801c48 <chktst>
  80033f:	83 c4 10             	add    $0x10,%esp
	return;
  800342:	90                   	nop
}
  800343:	8b 7d fc             	mov    -0x4(%ebp),%edi
  800346:	c9                   	leave  
  800347:	c3                   	ret    

00800348 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800348:	55                   	push   %ebp
  800349:	89 e5                	mov    %esp,%ebp
  80034b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80034e:	e8 a8 14 00 00       	call   8017fb <sys_getenvindex>
  800353:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800356:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800359:	89 d0                	mov    %edx,%eax
  80035b:	c1 e0 03             	shl    $0x3,%eax
  80035e:	01 d0                	add    %edx,%eax
  800360:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800367:	01 c8                	add    %ecx,%eax
  800369:	01 c0                	add    %eax,%eax
  80036b:	01 d0                	add    %edx,%eax
  80036d:	01 c0                	add    %eax,%eax
  80036f:	01 d0                	add    %edx,%eax
  800371:	89 c2                	mov    %eax,%edx
  800373:	c1 e2 05             	shl    $0x5,%edx
  800376:	29 c2                	sub    %eax,%edx
  800378:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800387:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80038c:	a1 20 30 80 00       	mov    0x803020,%eax
  800391:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800397:	84 c0                	test   %al,%al
  800399:	74 0f                	je     8003aa <libmain+0x62>
		binaryname = myEnv->prog_name;
  80039b:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a0:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003a5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003ae:	7e 0a                	jle    8003ba <libmain+0x72>
		binaryname = argv[0];
  8003b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b3:	8b 00                	mov    (%eax),%eax
  8003b5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003ba:	83 ec 08             	sub    $0x8,%esp
  8003bd:	ff 75 0c             	pushl  0xc(%ebp)
  8003c0:	ff 75 08             	pushl  0x8(%ebp)
  8003c3:	e8 70 fc ff ff       	call   800038 <_main>
  8003c8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003cb:	e8 c6 15 00 00       	call   801996 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003d0:	83 ec 0c             	sub    $0xc,%esp
  8003d3:	68 7c 20 80 00       	push   $0x80207c
  8003d8:	e8 52 03 00 00       	call   80072f <cprintf>
  8003dd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e5:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f0:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8003f6:	83 ec 04             	sub    $0x4,%esp
  8003f9:	52                   	push   %edx
  8003fa:	50                   	push   %eax
  8003fb:	68 a4 20 80 00       	push   $0x8020a4
  800400:	e8 2a 03 00 00       	call   80072f <cprintf>
  800405:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800408:	a1 20 30 80 00       	mov    0x803020,%eax
  80040d:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800413:	a1 20 30 80 00       	mov    0x803020,%eax
  800418:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80041e:	83 ec 04             	sub    $0x4,%esp
  800421:	52                   	push   %edx
  800422:	50                   	push   %eax
  800423:	68 cc 20 80 00       	push   $0x8020cc
  800428:	e8 02 03 00 00       	call   80072f <cprintf>
  80042d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800430:	a1 20 30 80 00       	mov    0x803020,%eax
  800435:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80043b:	83 ec 08             	sub    $0x8,%esp
  80043e:	50                   	push   %eax
  80043f:	68 0d 21 80 00       	push   $0x80210d
  800444:	e8 e6 02 00 00       	call   80072f <cprintf>
  800449:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80044c:	83 ec 0c             	sub    $0xc,%esp
  80044f:	68 7c 20 80 00       	push   $0x80207c
  800454:	e8 d6 02 00 00       	call   80072f <cprintf>
  800459:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80045c:	e8 4f 15 00 00       	call   8019b0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800461:	e8 19 00 00 00       	call   80047f <exit>
}
  800466:	90                   	nop
  800467:	c9                   	leave  
  800468:	c3                   	ret    

00800469 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800469:	55                   	push   %ebp
  80046a:	89 e5                	mov    %esp,%ebp
  80046c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80046f:	83 ec 0c             	sub    $0xc,%esp
  800472:	6a 00                	push   $0x0
  800474:	e8 4e 13 00 00       	call   8017c7 <sys_env_destroy>
  800479:	83 c4 10             	add    $0x10,%esp
}
  80047c:	90                   	nop
  80047d:	c9                   	leave  
  80047e:	c3                   	ret    

0080047f <exit>:

void
exit(void)
{
  80047f:	55                   	push   %ebp
  800480:	89 e5                	mov    %esp,%ebp
  800482:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800485:	e8 a3 13 00 00       	call   80182d <sys_env_exit>
}
  80048a:	90                   	nop
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800493:	8d 45 10             	lea    0x10(%ebp),%eax
  800496:	83 c0 04             	add    $0x4,%eax
  800499:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80049c:	a1 18 31 80 00       	mov    0x803118,%eax
  8004a1:	85 c0                	test   %eax,%eax
  8004a3:	74 16                	je     8004bb <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004a5:	a1 18 31 80 00       	mov    0x803118,%eax
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	50                   	push   %eax
  8004ae:	68 24 21 80 00       	push   $0x802124
  8004b3:	e8 77 02 00 00       	call   80072f <cprintf>
  8004b8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004bb:	a1 00 30 80 00       	mov    0x803000,%eax
  8004c0:	ff 75 0c             	pushl  0xc(%ebp)
  8004c3:	ff 75 08             	pushl  0x8(%ebp)
  8004c6:	50                   	push   %eax
  8004c7:	68 29 21 80 00       	push   $0x802129
  8004cc:	e8 5e 02 00 00       	call   80072f <cprintf>
  8004d1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d7:	83 ec 08             	sub    $0x8,%esp
  8004da:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dd:	50                   	push   %eax
  8004de:	e8 e1 01 00 00       	call   8006c4 <vcprintf>
  8004e3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004e6:	83 ec 08             	sub    $0x8,%esp
  8004e9:	6a 00                	push   $0x0
  8004eb:	68 45 21 80 00       	push   $0x802145
  8004f0:	e8 cf 01 00 00       	call   8006c4 <vcprintf>
  8004f5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004f8:	e8 82 ff ff ff       	call   80047f <exit>

	// should not return here
	while (1) ;
  8004fd:	eb fe                	jmp    8004fd <_panic+0x70>

008004ff <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004ff:	55                   	push   %ebp
  800500:	89 e5                	mov    %esp,%ebp
  800502:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800505:	a1 20 30 80 00       	mov    0x803020,%eax
  80050a:	8b 50 74             	mov    0x74(%eax),%edx
  80050d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800510:	39 c2                	cmp    %eax,%edx
  800512:	74 14                	je     800528 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800514:	83 ec 04             	sub    $0x4,%esp
  800517:	68 48 21 80 00       	push   $0x802148
  80051c:	6a 26                	push   $0x26
  80051e:	68 94 21 80 00       	push   $0x802194
  800523:	e8 65 ff ff ff       	call   80048d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800528:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80052f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800536:	e9 b6 00 00 00       	jmp    8005f1 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80053b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800545:	8b 45 08             	mov    0x8(%ebp),%eax
  800548:	01 d0                	add    %edx,%eax
  80054a:	8b 00                	mov    (%eax),%eax
  80054c:	85 c0                	test   %eax,%eax
  80054e:	75 08                	jne    800558 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800550:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800553:	e9 96 00 00 00       	jmp    8005ee <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800558:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80055f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800566:	eb 5d                	jmp    8005c5 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800568:	a1 20 30 80 00       	mov    0x803020,%eax
  80056d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800573:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800576:	c1 e2 04             	shl    $0x4,%edx
  800579:	01 d0                	add    %edx,%eax
  80057b:	8a 40 04             	mov    0x4(%eax),%al
  80057e:	84 c0                	test   %al,%al
  800580:	75 40                	jne    8005c2 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800582:	a1 20 30 80 00       	mov    0x803020,%eax
  800587:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80058d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800590:	c1 e2 04             	shl    $0x4,%edx
  800593:	01 d0                	add    %edx,%eax
  800595:	8b 00                	mov    (%eax),%eax
  800597:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80059a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80059d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005a2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b1:	01 c8                	add    %ecx,%eax
  8005b3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005b5:	39 c2                	cmp    %eax,%edx
  8005b7:	75 09                	jne    8005c2 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005b9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005c0:	eb 12                	jmp    8005d4 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005c2:	ff 45 e8             	incl   -0x18(%ebp)
  8005c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ca:	8b 50 74             	mov    0x74(%eax),%edx
  8005cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d0:	39 c2                	cmp    %eax,%edx
  8005d2:	77 94                	ja     800568 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005d8:	75 14                	jne    8005ee <CheckWSWithoutLastIndex+0xef>
			panic(
  8005da:	83 ec 04             	sub    $0x4,%esp
  8005dd:	68 a0 21 80 00       	push   $0x8021a0
  8005e2:	6a 3a                	push   $0x3a
  8005e4:	68 94 21 80 00       	push   $0x802194
  8005e9:	e8 9f fe ff ff       	call   80048d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005ee:	ff 45 f0             	incl   -0x10(%ebp)
  8005f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005f7:	0f 8c 3e ff ff ff    	jl     80053b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800604:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80060b:	eb 20                	jmp    80062d <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80060d:	a1 20 30 80 00       	mov    0x803020,%eax
  800612:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800618:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80061b:	c1 e2 04             	shl    $0x4,%edx
  80061e:	01 d0                	add    %edx,%eax
  800620:	8a 40 04             	mov    0x4(%eax),%al
  800623:	3c 01                	cmp    $0x1,%al
  800625:	75 03                	jne    80062a <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800627:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80062a:	ff 45 e0             	incl   -0x20(%ebp)
  80062d:	a1 20 30 80 00       	mov    0x803020,%eax
  800632:	8b 50 74             	mov    0x74(%eax),%edx
  800635:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800638:	39 c2                	cmp    %eax,%edx
  80063a:	77 d1                	ja     80060d <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80063c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80063f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800642:	74 14                	je     800658 <CheckWSWithoutLastIndex+0x159>
		panic(
  800644:	83 ec 04             	sub    $0x4,%esp
  800647:	68 f4 21 80 00       	push   $0x8021f4
  80064c:	6a 44                	push   $0x44
  80064e:	68 94 21 80 00       	push   $0x802194
  800653:	e8 35 fe ff ff       	call   80048d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800658:	90                   	nop
  800659:	c9                   	leave  
  80065a:	c3                   	ret    

0080065b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80065b:	55                   	push   %ebp
  80065c:	89 e5                	mov    %esp,%ebp
  80065e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800661:	8b 45 0c             	mov    0xc(%ebp),%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	8d 48 01             	lea    0x1(%eax),%ecx
  800669:	8b 55 0c             	mov    0xc(%ebp),%edx
  80066c:	89 0a                	mov    %ecx,(%edx)
  80066e:	8b 55 08             	mov    0x8(%ebp),%edx
  800671:	88 d1                	mov    %dl,%cl
  800673:	8b 55 0c             	mov    0xc(%ebp),%edx
  800676:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80067a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800684:	75 2c                	jne    8006b2 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800686:	a0 24 30 80 00       	mov    0x803024,%al
  80068b:	0f b6 c0             	movzbl %al,%eax
  80068e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800691:	8b 12                	mov    (%edx),%edx
  800693:	89 d1                	mov    %edx,%ecx
  800695:	8b 55 0c             	mov    0xc(%ebp),%edx
  800698:	83 c2 08             	add    $0x8,%edx
  80069b:	83 ec 04             	sub    $0x4,%esp
  80069e:	50                   	push   %eax
  80069f:	51                   	push   %ecx
  8006a0:	52                   	push   %edx
  8006a1:	e8 df 10 00 00       	call   801785 <sys_cputs>
  8006a6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b5:	8b 40 04             	mov    0x4(%eax),%eax
  8006b8:	8d 50 01             	lea    0x1(%eax),%edx
  8006bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006be:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006c1:	90                   	nop
  8006c2:	c9                   	leave  
  8006c3:	c3                   	ret    

008006c4 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006c4:	55                   	push   %ebp
  8006c5:	89 e5                	mov    %esp,%ebp
  8006c7:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006cd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006d4:	00 00 00 
	b.cnt = 0;
  8006d7:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006de:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006e1:	ff 75 0c             	pushl  0xc(%ebp)
  8006e4:	ff 75 08             	pushl  0x8(%ebp)
  8006e7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006ed:	50                   	push   %eax
  8006ee:	68 5b 06 80 00       	push   $0x80065b
  8006f3:	e8 11 02 00 00       	call   800909 <vprintfmt>
  8006f8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006fb:	a0 24 30 80 00       	mov    0x803024,%al
  800700:	0f b6 c0             	movzbl %al,%eax
  800703:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800709:	83 ec 04             	sub    $0x4,%esp
  80070c:	50                   	push   %eax
  80070d:	52                   	push   %edx
  80070e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800714:	83 c0 08             	add    $0x8,%eax
  800717:	50                   	push   %eax
  800718:	e8 68 10 00 00       	call   801785 <sys_cputs>
  80071d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800720:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800727:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80072d:	c9                   	leave  
  80072e:	c3                   	ret    

0080072f <cprintf>:

int cprintf(const char *fmt, ...) {
  80072f:	55                   	push   %ebp
  800730:	89 e5                	mov    %esp,%ebp
  800732:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800735:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80073c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80073f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	83 ec 08             	sub    $0x8,%esp
  800748:	ff 75 f4             	pushl  -0xc(%ebp)
  80074b:	50                   	push   %eax
  80074c:	e8 73 ff ff ff       	call   8006c4 <vcprintf>
  800751:	83 c4 10             	add    $0x10,%esp
  800754:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800757:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80075a:	c9                   	leave  
  80075b:	c3                   	ret    

0080075c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80075c:	55                   	push   %ebp
  80075d:	89 e5                	mov    %esp,%ebp
  80075f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800762:	e8 2f 12 00 00       	call   801996 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800767:	8d 45 0c             	lea    0xc(%ebp),%eax
  80076a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 f4             	pushl  -0xc(%ebp)
  800776:	50                   	push   %eax
  800777:	e8 48 ff ff ff       	call   8006c4 <vcprintf>
  80077c:	83 c4 10             	add    $0x10,%esp
  80077f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800782:	e8 29 12 00 00       	call   8019b0 <sys_enable_interrupt>
	return cnt;
  800787:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80078a:	c9                   	leave  
  80078b:	c3                   	ret    

0080078c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80078c:	55                   	push   %ebp
  80078d:	89 e5                	mov    %esp,%ebp
  80078f:	53                   	push   %ebx
  800790:	83 ec 14             	sub    $0x14,%esp
  800793:	8b 45 10             	mov    0x10(%ebp),%eax
  800796:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800799:	8b 45 14             	mov    0x14(%ebp),%eax
  80079c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80079f:	8b 45 18             	mov    0x18(%ebp),%eax
  8007a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8007a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007aa:	77 55                	ja     800801 <printnum+0x75>
  8007ac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007af:	72 05                	jb     8007b6 <printnum+0x2a>
  8007b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007b4:	77 4b                	ja     800801 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007b6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007b9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007bc:	8b 45 18             	mov    0x18(%ebp),%eax
  8007bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8007c4:	52                   	push   %edx
  8007c5:	50                   	push   %eax
  8007c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8007cc:	e8 e7 15 00 00       	call   801db8 <__udivdi3>
  8007d1:	83 c4 10             	add    $0x10,%esp
  8007d4:	83 ec 04             	sub    $0x4,%esp
  8007d7:	ff 75 20             	pushl  0x20(%ebp)
  8007da:	53                   	push   %ebx
  8007db:	ff 75 18             	pushl  0x18(%ebp)
  8007de:	52                   	push   %edx
  8007df:	50                   	push   %eax
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	ff 75 08             	pushl  0x8(%ebp)
  8007e6:	e8 a1 ff ff ff       	call   80078c <printnum>
  8007eb:	83 c4 20             	add    $0x20,%esp
  8007ee:	eb 1a                	jmp    80080a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007f0:	83 ec 08             	sub    $0x8,%esp
  8007f3:	ff 75 0c             	pushl  0xc(%ebp)
  8007f6:	ff 75 20             	pushl  0x20(%ebp)
  8007f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fc:	ff d0                	call   *%eax
  8007fe:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800801:	ff 4d 1c             	decl   0x1c(%ebp)
  800804:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800808:	7f e6                	jg     8007f0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80080a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80080d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800812:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800815:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800818:	53                   	push   %ebx
  800819:	51                   	push   %ecx
  80081a:	52                   	push   %edx
  80081b:	50                   	push   %eax
  80081c:	e8 a7 16 00 00       	call   801ec8 <__umoddi3>
  800821:	83 c4 10             	add    $0x10,%esp
  800824:	05 54 24 80 00       	add    $0x802454,%eax
  800829:	8a 00                	mov    (%eax),%al
  80082b:	0f be c0             	movsbl %al,%eax
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	ff 75 0c             	pushl  0xc(%ebp)
  800834:	50                   	push   %eax
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	ff d0                	call   *%eax
  80083a:	83 c4 10             	add    $0x10,%esp
}
  80083d:	90                   	nop
  80083e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800841:	c9                   	leave  
  800842:	c3                   	ret    

00800843 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800843:	55                   	push   %ebp
  800844:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800846:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80084a:	7e 1c                	jle    800868 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	8d 50 08             	lea    0x8(%eax),%edx
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	89 10                	mov    %edx,(%eax)
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	83 e8 08             	sub    $0x8,%eax
  800861:	8b 50 04             	mov    0x4(%eax),%edx
  800864:	8b 00                	mov    (%eax),%eax
  800866:	eb 40                	jmp    8008a8 <getuint+0x65>
	else if (lflag)
  800868:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80086c:	74 1e                	je     80088c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	8b 00                	mov    (%eax),%eax
  800873:	8d 50 04             	lea    0x4(%eax),%edx
  800876:	8b 45 08             	mov    0x8(%ebp),%eax
  800879:	89 10                	mov    %edx,(%eax)
  80087b:	8b 45 08             	mov    0x8(%ebp),%eax
  80087e:	8b 00                	mov    (%eax),%eax
  800880:	83 e8 04             	sub    $0x4,%eax
  800883:	8b 00                	mov    (%eax),%eax
  800885:	ba 00 00 00 00       	mov    $0x0,%edx
  80088a:	eb 1c                	jmp    8008a8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	8b 00                	mov    (%eax),%eax
  800891:	8d 50 04             	lea    0x4(%eax),%edx
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	89 10                	mov    %edx,(%eax)
  800899:	8b 45 08             	mov    0x8(%ebp),%eax
  80089c:	8b 00                	mov    (%eax),%eax
  80089e:	83 e8 04             	sub    $0x4,%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008a8:	5d                   	pop    %ebp
  8008a9:	c3                   	ret    

008008aa <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008ad:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008b1:	7e 1c                	jle    8008cf <getint+0x25>
		return va_arg(*ap, long long);
  8008b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	8d 50 08             	lea    0x8(%eax),%edx
  8008bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008be:	89 10                	mov    %edx,(%eax)
  8008c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c3:	8b 00                	mov    (%eax),%eax
  8008c5:	83 e8 08             	sub    $0x8,%eax
  8008c8:	8b 50 04             	mov    0x4(%eax),%edx
  8008cb:	8b 00                	mov    (%eax),%eax
  8008cd:	eb 38                	jmp    800907 <getint+0x5d>
	else if (lflag)
  8008cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008d3:	74 1a                	je     8008ef <getint+0x45>
		return va_arg(*ap, long);
  8008d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d8:	8b 00                	mov    (%eax),%eax
  8008da:	8d 50 04             	lea    0x4(%eax),%edx
  8008dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e0:	89 10                	mov    %edx,(%eax)
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	8b 00                	mov    (%eax),%eax
  8008e7:	83 e8 04             	sub    $0x4,%eax
  8008ea:	8b 00                	mov    (%eax),%eax
  8008ec:	99                   	cltd   
  8008ed:	eb 18                	jmp    800907 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f2:	8b 00                	mov    (%eax),%eax
  8008f4:	8d 50 04             	lea    0x4(%eax),%edx
  8008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fa:	89 10                	mov    %edx,(%eax)
  8008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ff:	8b 00                	mov    (%eax),%eax
  800901:	83 e8 04             	sub    $0x4,%eax
  800904:	8b 00                	mov    (%eax),%eax
  800906:	99                   	cltd   
}
  800907:	5d                   	pop    %ebp
  800908:	c3                   	ret    

00800909 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800909:	55                   	push   %ebp
  80090a:	89 e5                	mov    %esp,%ebp
  80090c:	56                   	push   %esi
  80090d:	53                   	push   %ebx
  80090e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800911:	eb 17                	jmp    80092a <vprintfmt+0x21>
			if (ch == '\0')
  800913:	85 db                	test   %ebx,%ebx
  800915:	0f 84 af 03 00 00    	je     800cca <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80091b:	83 ec 08             	sub    $0x8,%esp
  80091e:	ff 75 0c             	pushl  0xc(%ebp)
  800921:	53                   	push   %ebx
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	ff d0                	call   *%eax
  800927:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80092a:	8b 45 10             	mov    0x10(%ebp),%eax
  80092d:	8d 50 01             	lea    0x1(%eax),%edx
  800930:	89 55 10             	mov    %edx,0x10(%ebp)
  800933:	8a 00                	mov    (%eax),%al
  800935:	0f b6 d8             	movzbl %al,%ebx
  800938:	83 fb 25             	cmp    $0x25,%ebx
  80093b:	75 d6                	jne    800913 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80093d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800941:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800948:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80094f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800956:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80095d:	8b 45 10             	mov    0x10(%ebp),%eax
  800960:	8d 50 01             	lea    0x1(%eax),%edx
  800963:	89 55 10             	mov    %edx,0x10(%ebp)
  800966:	8a 00                	mov    (%eax),%al
  800968:	0f b6 d8             	movzbl %al,%ebx
  80096b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80096e:	83 f8 55             	cmp    $0x55,%eax
  800971:	0f 87 2b 03 00 00    	ja     800ca2 <vprintfmt+0x399>
  800977:	8b 04 85 78 24 80 00 	mov    0x802478(,%eax,4),%eax
  80097e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800980:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800984:	eb d7                	jmp    80095d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800986:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80098a:	eb d1                	jmp    80095d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80098c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800993:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800996:	89 d0                	mov    %edx,%eax
  800998:	c1 e0 02             	shl    $0x2,%eax
  80099b:	01 d0                	add    %edx,%eax
  80099d:	01 c0                	add    %eax,%eax
  80099f:	01 d8                	add    %ebx,%eax
  8009a1:	83 e8 30             	sub    $0x30,%eax
  8009a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009aa:	8a 00                	mov    (%eax),%al
  8009ac:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009af:	83 fb 2f             	cmp    $0x2f,%ebx
  8009b2:	7e 3e                	jle    8009f2 <vprintfmt+0xe9>
  8009b4:	83 fb 39             	cmp    $0x39,%ebx
  8009b7:	7f 39                	jg     8009f2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009b9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009bc:	eb d5                	jmp    800993 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009be:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c1:	83 c0 04             	add    $0x4,%eax
  8009c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ca:	83 e8 04             	sub    $0x4,%eax
  8009cd:	8b 00                	mov    (%eax),%eax
  8009cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009d2:	eb 1f                	jmp    8009f3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009d8:	79 83                	jns    80095d <vprintfmt+0x54>
				width = 0;
  8009da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009e1:	e9 77 ff ff ff       	jmp    80095d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009e6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009ed:	e9 6b ff ff ff       	jmp    80095d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009f2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009f7:	0f 89 60 ff ff ff    	jns    80095d <vprintfmt+0x54>
				width = precision, precision = -1;
  8009fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a00:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a03:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a0a:	e9 4e ff ff ff       	jmp    80095d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a0f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a12:	e9 46 ff ff ff       	jmp    80095d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a17:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1a:	83 c0 04             	add    $0x4,%eax
  800a1d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a20:	8b 45 14             	mov    0x14(%ebp),%eax
  800a23:	83 e8 04             	sub    $0x4,%eax
  800a26:	8b 00                	mov    (%eax),%eax
  800a28:	83 ec 08             	sub    $0x8,%esp
  800a2b:	ff 75 0c             	pushl  0xc(%ebp)
  800a2e:	50                   	push   %eax
  800a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a32:	ff d0                	call   *%eax
  800a34:	83 c4 10             	add    $0x10,%esp
			break;
  800a37:	e9 89 02 00 00       	jmp    800cc5 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a3f:	83 c0 04             	add    $0x4,%eax
  800a42:	89 45 14             	mov    %eax,0x14(%ebp)
  800a45:	8b 45 14             	mov    0x14(%ebp),%eax
  800a48:	83 e8 04             	sub    $0x4,%eax
  800a4b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a4d:	85 db                	test   %ebx,%ebx
  800a4f:	79 02                	jns    800a53 <vprintfmt+0x14a>
				err = -err;
  800a51:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a53:	83 fb 64             	cmp    $0x64,%ebx
  800a56:	7f 0b                	jg     800a63 <vprintfmt+0x15a>
  800a58:	8b 34 9d c0 22 80 00 	mov    0x8022c0(,%ebx,4),%esi
  800a5f:	85 f6                	test   %esi,%esi
  800a61:	75 19                	jne    800a7c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a63:	53                   	push   %ebx
  800a64:	68 65 24 80 00       	push   $0x802465
  800a69:	ff 75 0c             	pushl  0xc(%ebp)
  800a6c:	ff 75 08             	pushl  0x8(%ebp)
  800a6f:	e8 5e 02 00 00       	call   800cd2 <printfmt>
  800a74:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a77:	e9 49 02 00 00       	jmp    800cc5 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a7c:	56                   	push   %esi
  800a7d:	68 6e 24 80 00       	push   $0x80246e
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	ff 75 08             	pushl  0x8(%ebp)
  800a88:	e8 45 02 00 00       	call   800cd2 <printfmt>
  800a8d:	83 c4 10             	add    $0x10,%esp
			break;
  800a90:	e9 30 02 00 00       	jmp    800cc5 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a95:	8b 45 14             	mov    0x14(%ebp),%eax
  800a98:	83 c0 04             	add    $0x4,%eax
  800a9b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa1:	83 e8 04             	sub    $0x4,%eax
  800aa4:	8b 30                	mov    (%eax),%esi
  800aa6:	85 f6                	test   %esi,%esi
  800aa8:	75 05                	jne    800aaf <vprintfmt+0x1a6>
				p = "(null)";
  800aaa:	be 71 24 80 00       	mov    $0x802471,%esi
			if (width > 0 && padc != '-')
  800aaf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab3:	7e 6d                	jle    800b22 <vprintfmt+0x219>
  800ab5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ab9:	74 67                	je     800b22 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800abb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	50                   	push   %eax
  800ac2:	56                   	push   %esi
  800ac3:	e8 0c 03 00 00       	call   800dd4 <strnlen>
  800ac8:	83 c4 10             	add    $0x10,%esp
  800acb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ace:	eb 16                	jmp    800ae6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ad0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ad4:	83 ec 08             	sub    $0x8,%esp
  800ad7:	ff 75 0c             	pushl  0xc(%ebp)
  800ada:	50                   	push   %eax
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	ff d0                	call   *%eax
  800ae0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ae3:	ff 4d e4             	decl   -0x1c(%ebp)
  800ae6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aea:	7f e4                	jg     800ad0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aec:	eb 34                	jmp    800b22 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800aee:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800af2:	74 1c                	je     800b10 <vprintfmt+0x207>
  800af4:	83 fb 1f             	cmp    $0x1f,%ebx
  800af7:	7e 05                	jle    800afe <vprintfmt+0x1f5>
  800af9:	83 fb 7e             	cmp    $0x7e,%ebx
  800afc:	7e 12                	jle    800b10 <vprintfmt+0x207>
					putch('?', putdat);
  800afe:	83 ec 08             	sub    $0x8,%esp
  800b01:	ff 75 0c             	pushl  0xc(%ebp)
  800b04:	6a 3f                	push   $0x3f
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
  800b09:	ff d0                	call   *%eax
  800b0b:	83 c4 10             	add    $0x10,%esp
  800b0e:	eb 0f                	jmp    800b1f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b10:	83 ec 08             	sub    $0x8,%esp
  800b13:	ff 75 0c             	pushl  0xc(%ebp)
  800b16:	53                   	push   %ebx
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	ff d0                	call   *%eax
  800b1c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b1f:	ff 4d e4             	decl   -0x1c(%ebp)
  800b22:	89 f0                	mov    %esi,%eax
  800b24:	8d 70 01             	lea    0x1(%eax),%esi
  800b27:	8a 00                	mov    (%eax),%al
  800b29:	0f be d8             	movsbl %al,%ebx
  800b2c:	85 db                	test   %ebx,%ebx
  800b2e:	74 24                	je     800b54 <vprintfmt+0x24b>
  800b30:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b34:	78 b8                	js     800aee <vprintfmt+0x1e5>
  800b36:	ff 4d e0             	decl   -0x20(%ebp)
  800b39:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b3d:	79 af                	jns    800aee <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b3f:	eb 13                	jmp    800b54 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	6a 20                	push   $0x20
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	ff d0                	call   *%eax
  800b4e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b51:	ff 4d e4             	decl   -0x1c(%ebp)
  800b54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b58:	7f e7                	jg     800b41 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b5a:	e9 66 01 00 00       	jmp    800cc5 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 e8             	pushl  -0x18(%ebp)
  800b65:	8d 45 14             	lea    0x14(%ebp),%eax
  800b68:	50                   	push   %eax
  800b69:	e8 3c fd ff ff       	call   8008aa <getint>
  800b6e:	83 c4 10             	add    $0x10,%esp
  800b71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b74:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b7d:	85 d2                	test   %edx,%edx
  800b7f:	79 23                	jns    800ba4 <vprintfmt+0x29b>
				putch('-', putdat);
  800b81:	83 ec 08             	sub    $0x8,%esp
  800b84:	ff 75 0c             	pushl  0xc(%ebp)
  800b87:	6a 2d                	push   $0x2d
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	ff d0                	call   *%eax
  800b8e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b97:	f7 d8                	neg    %eax
  800b99:	83 d2 00             	adc    $0x0,%edx
  800b9c:	f7 da                	neg    %edx
  800b9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ba4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bab:	e9 bc 00 00 00       	jmp    800c6c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bb0:	83 ec 08             	sub    $0x8,%esp
  800bb3:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb6:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb9:	50                   	push   %eax
  800bba:	e8 84 fc ff ff       	call   800843 <getuint>
  800bbf:	83 c4 10             	add    $0x10,%esp
  800bc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bc8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bcf:	e9 98 00 00 00       	jmp    800c6c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bd4:	83 ec 08             	sub    $0x8,%esp
  800bd7:	ff 75 0c             	pushl  0xc(%ebp)
  800bda:	6a 58                	push   $0x58
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	ff d0                	call   *%eax
  800be1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800be4:	83 ec 08             	sub    $0x8,%esp
  800be7:	ff 75 0c             	pushl  0xc(%ebp)
  800bea:	6a 58                	push   $0x58
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	ff d0                	call   *%eax
  800bf1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bf4:	83 ec 08             	sub    $0x8,%esp
  800bf7:	ff 75 0c             	pushl  0xc(%ebp)
  800bfa:	6a 58                	push   $0x58
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	ff d0                	call   *%eax
  800c01:	83 c4 10             	add    $0x10,%esp
			break;
  800c04:	e9 bc 00 00 00       	jmp    800cc5 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c09:	83 ec 08             	sub    $0x8,%esp
  800c0c:	ff 75 0c             	pushl  0xc(%ebp)
  800c0f:	6a 30                	push   $0x30
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	ff d0                	call   *%eax
  800c16:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c19:	83 ec 08             	sub    $0x8,%esp
  800c1c:	ff 75 0c             	pushl  0xc(%ebp)
  800c1f:	6a 78                	push   $0x78
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	ff d0                	call   *%eax
  800c26:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c29:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2c:	83 c0 04             	add    $0x4,%eax
  800c2f:	89 45 14             	mov    %eax,0x14(%ebp)
  800c32:	8b 45 14             	mov    0x14(%ebp),%eax
  800c35:	83 e8 04             	sub    $0x4,%eax
  800c38:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c44:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c4b:	eb 1f                	jmp    800c6c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c4d:	83 ec 08             	sub    $0x8,%esp
  800c50:	ff 75 e8             	pushl  -0x18(%ebp)
  800c53:	8d 45 14             	lea    0x14(%ebp),%eax
  800c56:	50                   	push   %eax
  800c57:	e8 e7 fb ff ff       	call   800843 <getuint>
  800c5c:	83 c4 10             	add    $0x10,%esp
  800c5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c62:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c65:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c6c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c73:	83 ec 04             	sub    $0x4,%esp
  800c76:	52                   	push   %edx
  800c77:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c7a:	50                   	push   %eax
  800c7b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c7e:	ff 75 f0             	pushl  -0x10(%ebp)
  800c81:	ff 75 0c             	pushl  0xc(%ebp)
  800c84:	ff 75 08             	pushl  0x8(%ebp)
  800c87:	e8 00 fb ff ff       	call   80078c <printnum>
  800c8c:	83 c4 20             	add    $0x20,%esp
			break;
  800c8f:	eb 34                	jmp    800cc5 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c91:	83 ec 08             	sub    $0x8,%esp
  800c94:	ff 75 0c             	pushl  0xc(%ebp)
  800c97:	53                   	push   %ebx
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	ff d0                	call   *%eax
  800c9d:	83 c4 10             	add    $0x10,%esp
			break;
  800ca0:	eb 23                	jmp    800cc5 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ca2:	83 ec 08             	sub    $0x8,%esp
  800ca5:	ff 75 0c             	pushl  0xc(%ebp)
  800ca8:	6a 25                	push   $0x25
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	ff d0                	call   *%eax
  800caf:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cb2:	ff 4d 10             	decl   0x10(%ebp)
  800cb5:	eb 03                	jmp    800cba <vprintfmt+0x3b1>
  800cb7:	ff 4d 10             	decl   0x10(%ebp)
  800cba:	8b 45 10             	mov    0x10(%ebp),%eax
  800cbd:	48                   	dec    %eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	3c 25                	cmp    $0x25,%al
  800cc2:	75 f3                	jne    800cb7 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cc4:	90                   	nop
		}
	}
  800cc5:	e9 47 fc ff ff       	jmp    800911 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cca:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ccb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cce:	5b                   	pop    %ebx
  800ccf:	5e                   	pop    %esi
  800cd0:	5d                   	pop    %ebp
  800cd1:	c3                   	ret    

00800cd2 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cd2:	55                   	push   %ebp
  800cd3:	89 e5                	mov    %esp,%ebp
  800cd5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cd8:	8d 45 10             	lea    0x10(%ebp),%eax
  800cdb:	83 c0 04             	add    $0x4,%eax
  800cde:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ce1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce7:	50                   	push   %eax
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	ff 75 08             	pushl  0x8(%ebp)
  800cee:	e8 16 fc ff ff       	call   800909 <vprintfmt>
  800cf3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cf6:	90                   	nop
  800cf7:	c9                   	leave  
  800cf8:	c3                   	ret    

00800cf9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cff:	8b 40 08             	mov    0x8(%eax),%eax
  800d02:	8d 50 01             	lea    0x1(%eax),%edx
  800d05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d08:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0e:	8b 10                	mov    (%eax),%edx
  800d10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d13:	8b 40 04             	mov    0x4(%eax),%eax
  800d16:	39 c2                	cmp    %eax,%edx
  800d18:	73 12                	jae    800d2c <sprintputch+0x33>
		*b->buf++ = ch;
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	8b 00                	mov    (%eax),%eax
  800d1f:	8d 48 01             	lea    0x1(%eax),%ecx
  800d22:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d25:	89 0a                	mov    %ecx,(%edx)
  800d27:	8b 55 08             	mov    0x8(%ebp),%edx
  800d2a:	88 10                	mov    %dl,(%eax)
}
  800d2c:	90                   	nop
  800d2d:	5d                   	pop    %ebp
  800d2e:	c3                   	ret    

00800d2f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d2f:	55                   	push   %ebp
  800d30:	89 e5                	mov    %esp,%ebp
  800d32:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	01 d0                	add    %edx,%eax
  800d46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d49:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d50:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d54:	74 06                	je     800d5c <vsnprintf+0x2d>
  800d56:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d5a:	7f 07                	jg     800d63 <vsnprintf+0x34>
		return -E_INVAL;
  800d5c:	b8 03 00 00 00       	mov    $0x3,%eax
  800d61:	eb 20                	jmp    800d83 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d63:	ff 75 14             	pushl  0x14(%ebp)
  800d66:	ff 75 10             	pushl  0x10(%ebp)
  800d69:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d6c:	50                   	push   %eax
  800d6d:	68 f9 0c 80 00       	push   $0x800cf9
  800d72:	e8 92 fb ff ff       	call   800909 <vprintfmt>
  800d77:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d7d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d80:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d83:	c9                   	leave  
  800d84:	c3                   	ret    

00800d85 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d85:	55                   	push   %ebp
  800d86:	89 e5                	mov    %esp,%ebp
  800d88:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d8b:	8d 45 10             	lea    0x10(%ebp),%eax
  800d8e:	83 c0 04             	add    $0x4,%eax
  800d91:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d94:	8b 45 10             	mov    0x10(%ebp),%eax
  800d97:	ff 75 f4             	pushl  -0xc(%ebp)
  800d9a:	50                   	push   %eax
  800d9b:	ff 75 0c             	pushl  0xc(%ebp)
  800d9e:	ff 75 08             	pushl  0x8(%ebp)
  800da1:	e8 89 ff ff ff       	call   800d2f <vsnprintf>
  800da6:	83 c4 10             	add    $0x10,%esp
  800da9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800daf:	c9                   	leave  
  800db0:	c3                   	ret    

00800db1 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800db1:	55                   	push   %ebp
  800db2:	89 e5                	mov    %esp,%ebp
  800db4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800db7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dbe:	eb 06                	jmp    800dc6 <strlen+0x15>
		n++;
  800dc0:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dc3:	ff 45 08             	incl   0x8(%ebp)
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	84 c0                	test   %al,%al
  800dcd:	75 f1                	jne    800dc0 <strlen+0xf>
		n++;
	return n;
  800dcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dd2:	c9                   	leave  
  800dd3:	c3                   	ret    

00800dd4 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dd4:	55                   	push   %ebp
  800dd5:	89 e5                	mov    %esp,%ebp
  800dd7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800de1:	eb 09                	jmp    800dec <strnlen+0x18>
		n++;
  800de3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800de6:	ff 45 08             	incl   0x8(%ebp)
  800de9:	ff 4d 0c             	decl   0xc(%ebp)
  800dec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df0:	74 09                	je     800dfb <strnlen+0x27>
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	84 c0                	test   %al,%al
  800df9:	75 e8                	jne    800de3 <strnlen+0xf>
		n++;
	return n;
  800dfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dfe:	c9                   	leave  
  800dff:	c3                   	ret    

00800e00 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e06:	8b 45 08             	mov    0x8(%ebp),%eax
  800e09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e0c:	90                   	nop
  800e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e10:	8d 50 01             	lea    0x1(%eax),%edx
  800e13:	89 55 08             	mov    %edx,0x8(%ebp)
  800e16:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e19:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e1c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e1f:	8a 12                	mov    (%edx),%dl
  800e21:	88 10                	mov    %dl,(%eax)
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	84 c0                	test   %al,%al
  800e27:	75 e4                	jne    800e0d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e29:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e2c:	c9                   	leave  
  800e2d:	c3                   	ret    

00800e2e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e2e:	55                   	push   %ebp
  800e2f:	89 e5                	mov    %esp,%ebp
  800e31:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e3a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e41:	eb 1f                	jmp    800e62 <strncpy+0x34>
		*dst++ = *src;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8d 50 01             	lea    0x1(%eax),%edx
  800e49:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e4f:	8a 12                	mov    (%edx),%dl
  800e51:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	84 c0                	test   %al,%al
  800e5a:	74 03                	je     800e5f <strncpy+0x31>
			src++;
  800e5c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e5f:	ff 45 fc             	incl   -0x4(%ebp)
  800e62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e65:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e68:	72 d9                	jb     800e43 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e6d:	c9                   	leave  
  800e6e:	c3                   	ret    

00800e6f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e6f:	55                   	push   %ebp
  800e70:	89 e5                	mov    %esp,%ebp
  800e72:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e7f:	74 30                	je     800eb1 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e81:	eb 16                	jmp    800e99 <strlcpy+0x2a>
			*dst++ = *src++;
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	8d 50 01             	lea    0x1(%eax),%edx
  800e89:	89 55 08             	mov    %edx,0x8(%ebp)
  800e8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e8f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e92:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e95:	8a 12                	mov    (%edx),%dl
  800e97:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e99:	ff 4d 10             	decl   0x10(%ebp)
  800e9c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea0:	74 09                	je     800eab <strlcpy+0x3c>
  800ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	84 c0                	test   %al,%al
  800ea9:	75 d8                	jne    800e83 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800eb1:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb7:	29 c2                	sub    %eax,%edx
  800eb9:	89 d0                	mov    %edx,%eax
}
  800ebb:	c9                   	leave  
  800ebc:	c3                   	ret    

00800ebd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ebd:	55                   	push   %ebp
  800ebe:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ec0:	eb 06                	jmp    800ec8 <strcmp+0xb>
		p++, q++;
  800ec2:	ff 45 08             	incl   0x8(%ebp)
  800ec5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	84 c0                	test   %al,%al
  800ecf:	74 0e                	je     800edf <strcmp+0x22>
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	8a 10                	mov    (%eax),%dl
  800ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed9:	8a 00                	mov    (%eax),%al
  800edb:	38 c2                	cmp    %al,%dl
  800edd:	74 e3                	je     800ec2 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	0f b6 d0             	movzbl %al,%edx
  800ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	0f b6 c0             	movzbl %al,%eax
  800eef:	29 c2                	sub    %eax,%edx
  800ef1:	89 d0                	mov    %edx,%eax
}
  800ef3:	5d                   	pop    %ebp
  800ef4:	c3                   	ret    

00800ef5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ef5:	55                   	push   %ebp
  800ef6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ef8:	eb 09                	jmp    800f03 <strncmp+0xe>
		n--, p++, q++;
  800efa:	ff 4d 10             	decl   0x10(%ebp)
  800efd:	ff 45 08             	incl   0x8(%ebp)
  800f00:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f07:	74 17                	je     800f20 <strncmp+0x2b>
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	8a 00                	mov    (%eax),%al
  800f0e:	84 c0                	test   %al,%al
  800f10:	74 0e                	je     800f20 <strncmp+0x2b>
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8a 10                	mov    (%eax),%dl
  800f17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	38 c2                	cmp    %al,%dl
  800f1e:	74 da                	je     800efa <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f24:	75 07                	jne    800f2d <strncmp+0x38>
		return 0;
  800f26:	b8 00 00 00 00       	mov    $0x0,%eax
  800f2b:	eb 14                	jmp    800f41 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	0f b6 d0             	movzbl %al,%edx
  800f35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	0f b6 c0             	movzbl %al,%eax
  800f3d:	29 c2                	sub    %eax,%edx
  800f3f:	89 d0                	mov    %edx,%eax
}
  800f41:	5d                   	pop    %ebp
  800f42:	c3                   	ret    

00800f43 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f43:	55                   	push   %ebp
  800f44:	89 e5                	mov    %esp,%ebp
  800f46:	83 ec 04             	sub    $0x4,%esp
  800f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f4f:	eb 12                	jmp    800f63 <strchr+0x20>
		if (*s == c)
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f59:	75 05                	jne    800f60 <strchr+0x1d>
			return (char *) s;
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	eb 11                	jmp    800f71 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f60:	ff 45 08             	incl   0x8(%ebp)
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	84 c0                	test   %al,%al
  800f6a:	75 e5                	jne    800f51 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f71:	c9                   	leave  
  800f72:	c3                   	ret    

00800f73 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 04             	sub    $0x4,%esp
  800f79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f7f:	eb 0d                	jmp    800f8e <strfind+0x1b>
		if (*s == c)
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f89:	74 0e                	je     800f99 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f8b:	ff 45 08             	incl   0x8(%ebp)
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	84 c0                	test   %al,%al
  800f95:	75 ea                	jne    800f81 <strfind+0xe>
  800f97:	eb 01                	jmp    800f9a <strfind+0x27>
		if (*s == c)
			break;
  800f99:	90                   	nop
	return (char *) s;
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9d:	c9                   	leave  
  800f9e:	c3                   	ret    

00800f9f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f9f:	55                   	push   %ebp
  800fa0:	89 e5                	mov    %esp,%ebp
  800fa2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fab:	8b 45 10             	mov    0x10(%ebp),%eax
  800fae:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fb1:	eb 0e                	jmp    800fc1 <memset+0x22>
		*p++ = c;
  800fb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb6:	8d 50 01             	lea    0x1(%eax),%edx
  800fb9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fbf:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fc1:	ff 4d f8             	decl   -0x8(%ebp)
  800fc4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fc8:	79 e9                	jns    800fb3 <memset+0x14>
		*p++ = c;

	return v;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fcd:	c9                   	leave  
  800fce:	c3                   	ret    

00800fcf <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fcf:	55                   	push   %ebp
  800fd0:	89 e5                	mov    %esp,%ebp
  800fd2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fe1:	eb 16                	jmp    800ff9 <memcpy+0x2a>
		*d++ = *s++;
  800fe3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe6:	8d 50 01             	lea    0x1(%eax),%edx
  800fe9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fef:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ff2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ff5:	8a 12                	mov    (%edx),%dl
  800ff7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ff9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fff:	89 55 10             	mov    %edx,0x10(%ebp)
  801002:	85 c0                	test   %eax,%eax
  801004:	75 dd                	jne    800fe3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801009:	c9                   	leave  
  80100a:	c3                   	ret    

0080100b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
  80100e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801011:	8b 45 0c             	mov    0xc(%ebp),%eax
  801014:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80101d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801020:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801023:	73 50                	jae    801075 <memmove+0x6a>
  801025:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801028:	8b 45 10             	mov    0x10(%ebp),%eax
  80102b:	01 d0                	add    %edx,%eax
  80102d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801030:	76 43                	jbe    801075 <memmove+0x6a>
		s += n;
  801032:	8b 45 10             	mov    0x10(%ebp),%eax
  801035:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801038:	8b 45 10             	mov    0x10(%ebp),%eax
  80103b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80103e:	eb 10                	jmp    801050 <memmove+0x45>
			*--d = *--s;
  801040:	ff 4d f8             	decl   -0x8(%ebp)
  801043:	ff 4d fc             	decl   -0x4(%ebp)
  801046:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801049:	8a 10                	mov    (%eax),%dl
  80104b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801050:	8b 45 10             	mov    0x10(%ebp),%eax
  801053:	8d 50 ff             	lea    -0x1(%eax),%edx
  801056:	89 55 10             	mov    %edx,0x10(%ebp)
  801059:	85 c0                	test   %eax,%eax
  80105b:	75 e3                	jne    801040 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80105d:	eb 23                	jmp    801082 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80105f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801062:	8d 50 01             	lea    0x1(%eax),%edx
  801065:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801068:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80106b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80106e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801071:	8a 12                	mov    (%edx),%dl
  801073:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801075:	8b 45 10             	mov    0x10(%ebp),%eax
  801078:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107b:	89 55 10             	mov    %edx,0x10(%ebp)
  80107e:	85 c0                	test   %eax,%eax
  801080:	75 dd                	jne    80105f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801085:	c9                   	leave  
  801086:	c3                   	ret    

00801087 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801087:	55                   	push   %ebp
  801088:	89 e5                	mov    %esp,%ebp
  80108a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80108d:	8b 45 08             	mov    0x8(%ebp),%eax
  801090:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801093:	8b 45 0c             	mov    0xc(%ebp),%eax
  801096:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801099:	eb 2a                	jmp    8010c5 <memcmp+0x3e>
		if (*s1 != *s2)
  80109b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80109e:	8a 10                	mov    (%eax),%dl
  8010a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a3:	8a 00                	mov    (%eax),%al
  8010a5:	38 c2                	cmp    %al,%dl
  8010a7:	74 16                	je     8010bf <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ac:	8a 00                	mov    (%eax),%al
  8010ae:	0f b6 d0             	movzbl %al,%edx
  8010b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b4:	8a 00                	mov    (%eax),%al
  8010b6:	0f b6 c0             	movzbl %al,%eax
  8010b9:	29 c2                	sub    %eax,%edx
  8010bb:	89 d0                	mov    %edx,%eax
  8010bd:	eb 18                	jmp    8010d7 <memcmp+0x50>
		s1++, s2++;
  8010bf:	ff 45 fc             	incl   -0x4(%ebp)
  8010c2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010cb:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ce:	85 c0                	test   %eax,%eax
  8010d0:	75 c9                	jne    80109b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010d7:	c9                   	leave  
  8010d8:	c3                   	ret    

008010d9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010d9:	55                   	push   %ebp
  8010da:	89 e5                	mov    %esp,%ebp
  8010dc:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010df:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e5:	01 d0                	add    %edx,%eax
  8010e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010ea:	eb 15                	jmp    801101 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	0f b6 d0             	movzbl %al,%edx
  8010f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f7:	0f b6 c0             	movzbl %al,%eax
  8010fa:	39 c2                	cmp    %eax,%edx
  8010fc:	74 0d                	je     80110b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010fe:	ff 45 08             	incl   0x8(%ebp)
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801107:	72 e3                	jb     8010ec <memfind+0x13>
  801109:	eb 01                	jmp    80110c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80110b:	90                   	nop
	return (void *) s;
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80110f:	c9                   	leave  
  801110:	c3                   	ret    

00801111 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
  801114:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801117:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80111e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801125:	eb 03                	jmp    80112a <strtol+0x19>
		s++;
  801127:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 20                	cmp    $0x20,%al
  801131:	74 f4                	je     801127 <strtol+0x16>
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	3c 09                	cmp    $0x9,%al
  80113a:	74 eb                	je     801127 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	3c 2b                	cmp    $0x2b,%al
  801143:	75 05                	jne    80114a <strtol+0x39>
		s++;
  801145:	ff 45 08             	incl   0x8(%ebp)
  801148:	eb 13                	jmp    80115d <strtol+0x4c>
	else if (*s == '-')
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	3c 2d                	cmp    $0x2d,%al
  801151:	75 0a                	jne    80115d <strtol+0x4c>
		s++, neg = 1;
  801153:	ff 45 08             	incl   0x8(%ebp)
  801156:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80115d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801161:	74 06                	je     801169 <strtol+0x58>
  801163:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801167:	75 20                	jne    801189 <strtol+0x78>
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	3c 30                	cmp    $0x30,%al
  801170:	75 17                	jne    801189 <strtol+0x78>
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	40                   	inc    %eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	3c 78                	cmp    $0x78,%al
  80117a:	75 0d                	jne    801189 <strtol+0x78>
		s += 2, base = 16;
  80117c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801180:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801187:	eb 28                	jmp    8011b1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801189:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118d:	75 15                	jne    8011a4 <strtol+0x93>
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	8a 00                	mov    (%eax),%al
  801194:	3c 30                	cmp    $0x30,%al
  801196:	75 0c                	jne    8011a4 <strtol+0x93>
		s++, base = 8;
  801198:	ff 45 08             	incl   0x8(%ebp)
  80119b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011a2:	eb 0d                	jmp    8011b1 <strtol+0xa0>
	else if (base == 0)
  8011a4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a8:	75 07                	jne    8011b1 <strtol+0xa0>
		base = 10;
  8011aa:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	3c 2f                	cmp    $0x2f,%al
  8011b8:	7e 19                	jle    8011d3 <strtol+0xc2>
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	3c 39                	cmp    $0x39,%al
  8011c1:	7f 10                	jg     8011d3 <strtol+0xc2>
			dig = *s - '0';
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	0f be c0             	movsbl %al,%eax
  8011cb:	83 e8 30             	sub    $0x30,%eax
  8011ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011d1:	eb 42                	jmp    801215 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d6:	8a 00                	mov    (%eax),%al
  8011d8:	3c 60                	cmp    $0x60,%al
  8011da:	7e 19                	jle    8011f5 <strtol+0xe4>
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	3c 7a                	cmp    $0x7a,%al
  8011e3:	7f 10                	jg     8011f5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	0f be c0             	movsbl %al,%eax
  8011ed:	83 e8 57             	sub    $0x57,%eax
  8011f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011f3:	eb 20                	jmp    801215 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	3c 40                	cmp    $0x40,%al
  8011fc:	7e 39                	jle    801237 <strtol+0x126>
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	3c 5a                	cmp    $0x5a,%al
  801205:	7f 30                	jg     801237 <strtol+0x126>
			dig = *s - 'A' + 10;
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	0f be c0             	movsbl %al,%eax
  80120f:	83 e8 37             	sub    $0x37,%eax
  801212:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801215:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801218:	3b 45 10             	cmp    0x10(%ebp),%eax
  80121b:	7d 19                	jge    801236 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80121d:	ff 45 08             	incl   0x8(%ebp)
  801220:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801223:	0f af 45 10          	imul   0x10(%ebp),%eax
  801227:	89 c2                	mov    %eax,%edx
  801229:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80122c:	01 d0                	add    %edx,%eax
  80122e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801231:	e9 7b ff ff ff       	jmp    8011b1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801236:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801237:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80123b:	74 08                	je     801245 <strtol+0x134>
		*endptr = (char *) s;
  80123d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801240:	8b 55 08             	mov    0x8(%ebp),%edx
  801243:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801245:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801249:	74 07                	je     801252 <strtol+0x141>
  80124b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124e:	f7 d8                	neg    %eax
  801250:	eb 03                	jmp    801255 <strtol+0x144>
  801252:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801255:	c9                   	leave  
  801256:	c3                   	ret    

00801257 <ltostr>:

void
ltostr(long value, char *str)
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
  80125a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80125d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801264:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80126b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80126f:	79 13                	jns    801284 <ltostr+0x2d>
	{
		neg = 1;
  801271:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801278:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80127e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801281:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80128c:	99                   	cltd   
  80128d:	f7 f9                	idiv   %ecx
  80128f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801292:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801295:	8d 50 01             	lea    0x1(%eax),%edx
  801298:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80129b:	89 c2                	mov    %eax,%edx
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	01 d0                	add    %edx,%eax
  8012a2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a5:	83 c2 30             	add    $0x30,%edx
  8012a8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012ad:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012b2:	f7 e9                	imul   %ecx
  8012b4:	c1 fa 02             	sar    $0x2,%edx
  8012b7:	89 c8                	mov    %ecx,%eax
  8012b9:	c1 f8 1f             	sar    $0x1f,%eax
  8012bc:	29 c2                	sub    %eax,%edx
  8012be:	89 d0                	mov    %edx,%eax
  8012c0:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012c6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012cb:	f7 e9                	imul   %ecx
  8012cd:	c1 fa 02             	sar    $0x2,%edx
  8012d0:	89 c8                	mov    %ecx,%eax
  8012d2:	c1 f8 1f             	sar    $0x1f,%eax
  8012d5:	29 c2                	sub    %eax,%edx
  8012d7:	89 d0                	mov    %edx,%eax
  8012d9:	c1 e0 02             	shl    $0x2,%eax
  8012dc:	01 d0                	add    %edx,%eax
  8012de:	01 c0                	add    %eax,%eax
  8012e0:	29 c1                	sub    %eax,%ecx
  8012e2:	89 ca                	mov    %ecx,%edx
  8012e4:	85 d2                	test   %edx,%edx
  8012e6:	75 9c                	jne    801284 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f2:	48                   	dec    %eax
  8012f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012fa:	74 3d                	je     801339 <ltostr+0xe2>
		start = 1 ;
  8012fc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801303:	eb 34                	jmp    801339 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801305:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130b:	01 d0                	add    %edx,%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801312:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801315:	8b 45 0c             	mov    0xc(%ebp),%eax
  801318:	01 c2                	add    %eax,%edx
  80131a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80131d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801320:	01 c8                	add    %ecx,%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801326:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801329:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132c:	01 c2                	add    %eax,%edx
  80132e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801331:	88 02                	mov    %al,(%edx)
		start++ ;
  801333:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801336:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801339:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80133f:	7c c4                	jl     801305 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801341:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801344:	8b 45 0c             	mov    0xc(%ebp),%eax
  801347:	01 d0                	add    %edx,%eax
  801349:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80134c:	90                   	nop
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
  801352:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801355:	ff 75 08             	pushl  0x8(%ebp)
  801358:	e8 54 fa ff ff       	call   800db1 <strlen>
  80135d:	83 c4 04             	add    $0x4,%esp
  801360:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801363:	ff 75 0c             	pushl  0xc(%ebp)
  801366:	e8 46 fa ff ff       	call   800db1 <strlen>
  80136b:	83 c4 04             	add    $0x4,%esp
  80136e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801371:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801378:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80137f:	eb 17                	jmp    801398 <strcconcat+0x49>
		final[s] = str1[s] ;
  801381:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801384:	8b 45 10             	mov    0x10(%ebp),%eax
  801387:	01 c2                	add    %eax,%edx
  801389:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80138c:	8b 45 08             	mov    0x8(%ebp),%eax
  80138f:	01 c8                	add    %ecx,%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801395:	ff 45 fc             	incl   -0x4(%ebp)
  801398:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80139e:	7c e1                	jl     801381 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013a7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013ae:	eb 1f                	jmp    8013cf <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b3:	8d 50 01             	lea    0x1(%eax),%edx
  8013b6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013b9:	89 c2                	mov    %eax,%edx
  8013bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013be:	01 c2                	add    %eax,%edx
  8013c0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c6:	01 c8                	add    %ecx,%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013cc:	ff 45 f8             	incl   -0x8(%ebp)
  8013cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013d5:	7c d9                	jl     8013b0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013da:	8b 45 10             	mov    0x10(%ebp),%eax
  8013dd:	01 d0                	add    %edx,%eax
  8013df:	c6 00 00             	movb   $0x0,(%eax)
}
  8013e2:	90                   	nop
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013eb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013f4:	8b 00                	mov    (%eax),%eax
  8013f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801400:	01 d0                	add    %edx,%eax
  801402:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801408:	eb 0c                	jmp    801416 <strsplit+0x31>
			*string++ = 0;
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8d 50 01             	lea    0x1(%eax),%edx
  801410:	89 55 08             	mov    %edx,0x8(%ebp)
  801413:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	84 c0                	test   %al,%al
  80141d:	74 18                	je     801437 <strsplit+0x52>
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	0f be c0             	movsbl %al,%eax
  801427:	50                   	push   %eax
  801428:	ff 75 0c             	pushl  0xc(%ebp)
  80142b:	e8 13 fb ff ff       	call   800f43 <strchr>
  801430:	83 c4 08             	add    $0x8,%esp
  801433:	85 c0                	test   %eax,%eax
  801435:	75 d3                	jne    80140a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	8a 00                	mov    (%eax),%al
  80143c:	84 c0                	test   %al,%al
  80143e:	74 5a                	je     80149a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801440:	8b 45 14             	mov    0x14(%ebp),%eax
  801443:	8b 00                	mov    (%eax),%eax
  801445:	83 f8 0f             	cmp    $0xf,%eax
  801448:	75 07                	jne    801451 <strsplit+0x6c>
		{
			return 0;
  80144a:	b8 00 00 00 00       	mov    $0x0,%eax
  80144f:	eb 66                	jmp    8014b7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801451:	8b 45 14             	mov    0x14(%ebp),%eax
  801454:	8b 00                	mov    (%eax),%eax
  801456:	8d 48 01             	lea    0x1(%eax),%ecx
  801459:	8b 55 14             	mov    0x14(%ebp),%edx
  80145c:	89 0a                	mov    %ecx,(%edx)
  80145e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801465:	8b 45 10             	mov    0x10(%ebp),%eax
  801468:	01 c2                	add    %eax,%edx
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80146f:	eb 03                	jmp    801474 <strsplit+0x8f>
			string++;
  801471:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	8a 00                	mov    (%eax),%al
  801479:	84 c0                	test   %al,%al
  80147b:	74 8b                	je     801408 <strsplit+0x23>
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	0f be c0             	movsbl %al,%eax
  801485:	50                   	push   %eax
  801486:	ff 75 0c             	pushl  0xc(%ebp)
  801489:	e8 b5 fa ff ff       	call   800f43 <strchr>
  80148e:	83 c4 08             	add    $0x8,%esp
  801491:	85 c0                	test   %eax,%eax
  801493:	74 dc                	je     801471 <strsplit+0x8c>
			string++;
	}
  801495:	e9 6e ff ff ff       	jmp    801408 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80149a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80149b:	8b 45 14             	mov    0x14(%ebp),%eax
  80149e:	8b 00                	mov    (%eax),%eax
  8014a0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014aa:	01 d0                	add    %edx,%eax
  8014ac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014b2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
  8014bc:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8014bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c2:	c1 e8 0c             	shr    $0xc,%eax
  8014c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	25 ff 0f 00 00       	and    $0xfff,%eax
  8014d0:	85 c0                	test   %eax,%eax
  8014d2:	74 03                	je     8014d7 <malloc+0x1e>
			num++;
  8014d4:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8014d7:	a1 04 30 80 00       	mov    0x803004,%eax
  8014dc:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8014e1:	75 64                	jne    801547 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8014e3:	83 ec 08             	sub    $0x8,%esp
  8014e6:	ff 75 08             	pushl  0x8(%ebp)
  8014e9:	68 00 00 00 80       	push   $0x80000000
  8014ee:	e8 3a 04 00 00       	call   80192d <sys_allocateMem>
  8014f3:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8014f6:	a1 04 30 80 00       	mov    0x803004,%eax
  8014fb:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8014fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801501:	c1 e0 0c             	shl    $0xc,%eax
  801504:	89 c2                	mov    %eax,%edx
  801506:	a1 04 30 80 00       	mov    0x803004,%eax
  80150b:	01 d0                	add    %edx,%eax
  80150d:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  801512:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801517:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80151d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801524:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801529:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801530:	01 00 00 00 
			sizeofarray++;
  801534:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801539:	40                   	inc    %eax
  80153a:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80153f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801542:	e9 26 01 00 00       	jmp    80166d <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  801547:	a1 28 30 80 00       	mov    0x803028,%eax
  80154c:	85 c0                	test   %eax,%eax
  80154e:	75 62                	jne    8015b2 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  801550:	a1 04 30 80 00       	mov    0x803004,%eax
  801555:	83 ec 08             	sub    $0x8,%esp
  801558:	ff 75 08             	pushl  0x8(%ebp)
  80155b:	50                   	push   %eax
  80155c:	e8 cc 03 00 00       	call   80192d <sys_allocateMem>
  801561:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801564:	a1 04 30 80 00       	mov    0x803004,%eax
  801569:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80156c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80156f:	c1 e0 0c             	shl    $0xc,%eax
  801572:	89 c2                	mov    %eax,%edx
  801574:	a1 04 30 80 00       	mov    0x803004,%eax
  801579:	01 d0                	add    %edx,%eax
  80157b:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  801580:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801585:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801588:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80158f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801594:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  80159b:	01 00 00 00 
				sizeofarray++;
  80159f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015a4:	40                   	inc    %eax
  8015a5:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8015aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015ad:	e9 bb 00 00 00       	jmp    80166d <malloc+0x1b4>
			}
			else{
				int count=0;
  8015b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8015b9:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8015c0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8015c7:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8015ce:	eb 7c                	jmp    80164c <malloc+0x193>
				{
					uint32 *pg=NULL;
  8015d0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8015d7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8015de:	eb 1a                	jmp    8015fa <malloc+0x141>
					{
						if(addresses[j]==i)
  8015e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015e3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015ea:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8015ed:	75 08                	jne    8015f7 <malloc+0x13e>
						{
							index=j;
  8015ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8015f5:	eb 0d                	jmp    801604 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8015f7:	ff 45 dc             	incl   -0x24(%ebp)
  8015fa:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015ff:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801602:	7c dc                	jl     8015e0 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  801604:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801608:	75 05                	jne    80160f <malloc+0x156>
					{
						count++;
  80160a:	ff 45 f0             	incl   -0x10(%ebp)
  80160d:	eb 36                	jmp    801645 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  80160f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801612:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801619:	85 c0                	test   %eax,%eax
  80161b:	75 05                	jne    801622 <malloc+0x169>
						{
							count++;
  80161d:	ff 45 f0             	incl   -0x10(%ebp)
  801620:	eb 23                	jmp    801645 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  801622:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801625:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801628:	7d 14                	jge    80163e <malloc+0x185>
  80162a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80162d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801630:	7c 0c                	jl     80163e <malloc+0x185>
							{
								min=count;
  801632:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801635:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801638:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80163b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80163e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801645:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80164c:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801653:	0f 86 77 ff ff ff    	jbe    8015d0 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  801659:	83 ec 08             	sub    $0x8,%esp
  80165c:	ff 75 08             	pushl  0x8(%ebp)
  80165f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801662:	e8 c6 02 00 00       	call   80192d <sys_allocateMem>
  801667:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  80166a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
  801672:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801675:	83 ec 04             	sub    $0x4,%esp
  801678:	68 d0 25 80 00       	push   $0x8025d0
  80167d:	6a 7b                	push   $0x7b
  80167f:	68 f3 25 80 00       	push   $0x8025f3
  801684:	e8 04 ee ff ff       	call   80048d <_panic>

00801689 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
  80168c:	83 ec 18             	sub    $0x18,%esp
  80168f:	8b 45 10             	mov    0x10(%ebp),%eax
  801692:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801695:	83 ec 04             	sub    $0x4,%esp
  801698:	68 00 26 80 00       	push   $0x802600
  80169d:	68 88 00 00 00       	push   $0x88
  8016a2:	68 f3 25 80 00       	push   $0x8025f3
  8016a7:	e8 e1 ed ff ff       	call   80048d <_panic>

008016ac <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
  8016af:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016b2:	83 ec 04             	sub    $0x4,%esp
  8016b5:	68 00 26 80 00       	push   $0x802600
  8016ba:	68 8e 00 00 00       	push   $0x8e
  8016bf:	68 f3 25 80 00       	push   $0x8025f3
  8016c4:	e8 c4 ed ff ff       	call   80048d <_panic>

008016c9 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016cf:	83 ec 04             	sub    $0x4,%esp
  8016d2:	68 00 26 80 00       	push   $0x802600
  8016d7:	68 94 00 00 00       	push   $0x94
  8016dc:	68 f3 25 80 00       	push   $0x8025f3
  8016e1:	e8 a7 ed ff ff       	call   80048d <_panic>

008016e6 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
  8016e9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016ec:	83 ec 04             	sub    $0x4,%esp
  8016ef:	68 00 26 80 00       	push   $0x802600
  8016f4:	68 99 00 00 00       	push   $0x99
  8016f9:	68 f3 25 80 00       	push   $0x8025f3
  8016fe:	e8 8a ed ff ff       	call   80048d <_panic>

00801703 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
  801706:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801709:	83 ec 04             	sub    $0x4,%esp
  80170c:	68 00 26 80 00       	push   $0x802600
  801711:	68 9f 00 00 00       	push   $0x9f
  801716:	68 f3 25 80 00       	push   $0x8025f3
  80171b:	e8 6d ed ff ff       	call   80048d <_panic>

00801720 <shrink>:
}
void shrink(uint32 newSize)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
  801723:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801726:	83 ec 04             	sub    $0x4,%esp
  801729:	68 00 26 80 00       	push   $0x802600
  80172e:	68 a3 00 00 00       	push   $0xa3
  801733:	68 f3 25 80 00       	push   $0x8025f3
  801738:	e8 50 ed ff ff       	call   80048d <_panic>

0080173d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
  801740:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801743:	83 ec 04             	sub    $0x4,%esp
  801746:	68 00 26 80 00       	push   $0x802600
  80174b:	68 a8 00 00 00       	push   $0xa8
  801750:	68 f3 25 80 00       	push   $0x8025f3
  801755:	e8 33 ed ff ff       	call   80048d <_panic>

0080175a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
  80175d:	57                   	push   %edi
  80175e:	56                   	push   %esi
  80175f:	53                   	push   %ebx
  801760:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	8b 55 0c             	mov    0xc(%ebp),%edx
  801769:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80176c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80176f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801772:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801775:	cd 30                	int    $0x30
  801777:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80177a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80177d:	83 c4 10             	add    $0x10,%esp
  801780:	5b                   	pop    %ebx
  801781:	5e                   	pop    %esi
  801782:	5f                   	pop    %edi
  801783:	5d                   	pop    %ebp
  801784:	c3                   	ret    

00801785 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
  801788:	83 ec 04             	sub    $0x4,%esp
  80178b:	8b 45 10             	mov    0x10(%ebp),%eax
  80178e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801791:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801795:	8b 45 08             	mov    0x8(%ebp),%eax
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	52                   	push   %edx
  80179d:	ff 75 0c             	pushl  0xc(%ebp)
  8017a0:	50                   	push   %eax
  8017a1:	6a 00                	push   $0x0
  8017a3:	e8 b2 ff ff ff       	call   80175a <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
}
  8017ab:	90                   	nop
  8017ac:	c9                   	leave  
  8017ad:	c3                   	ret    

008017ae <sys_cgetc>:

int
sys_cgetc(void)
{
  8017ae:	55                   	push   %ebp
  8017af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 01                	push   $0x1
  8017bd:	e8 98 ff ff ff       	call   80175a <syscall>
  8017c2:	83 c4 18             	add    $0x18,%esp
}
  8017c5:	c9                   	leave  
  8017c6:	c3                   	ret    

008017c7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	50                   	push   %eax
  8017d6:	6a 05                	push   $0x5
  8017d8:	e8 7d ff ff ff       	call   80175a <syscall>
  8017dd:	83 c4 18             	add    $0x18,%esp
}
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 02                	push   $0x2
  8017f1:	e8 64 ff ff ff       	call   80175a <syscall>
  8017f6:	83 c4 18             	add    $0x18,%esp
}
  8017f9:	c9                   	leave  
  8017fa:	c3                   	ret    

008017fb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 03                	push   $0x3
  80180a:	e8 4b ff ff ff       	call   80175a <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
}
  801812:	c9                   	leave  
  801813:	c3                   	ret    

00801814 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801814:	55                   	push   %ebp
  801815:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 04                	push   $0x4
  801823:	e8 32 ff ff ff       	call   80175a <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <sys_env_exit>:


void sys_env_exit(void)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 06                	push   $0x6
  80183c:	e8 19 ff ff ff       	call   80175a <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	90                   	nop
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80184a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184d:	8b 45 08             	mov    0x8(%ebp),%eax
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	52                   	push   %edx
  801857:	50                   	push   %eax
  801858:	6a 07                	push   $0x7
  80185a:	e8 fb fe ff ff       	call   80175a <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	56                   	push   %esi
  801868:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801869:	8b 75 18             	mov    0x18(%ebp),%esi
  80186c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80186f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801872:	8b 55 0c             	mov    0xc(%ebp),%edx
  801875:	8b 45 08             	mov    0x8(%ebp),%eax
  801878:	56                   	push   %esi
  801879:	53                   	push   %ebx
  80187a:	51                   	push   %ecx
  80187b:	52                   	push   %edx
  80187c:	50                   	push   %eax
  80187d:	6a 08                	push   $0x8
  80187f:	e8 d6 fe ff ff       	call   80175a <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80188a:	5b                   	pop    %ebx
  80188b:	5e                   	pop    %esi
  80188c:	5d                   	pop    %ebp
  80188d:	c3                   	ret    

0080188e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801891:	8b 55 0c             	mov    0xc(%ebp),%edx
  801894:	8b 45 08             	mov    0x8(%ebp),%eax
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	52                   	push   %edx
  80189e:	50                   	push   %eax
  80189f:	6a 09                	push   $0x9
  8018a1:	e8 b4 fe ff ff       	call   80175a <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
}
  8018a9:	c9                   	leave  
  8018aa:	c3                   	ret    

008018ab <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018ab:	55                   	push   %ebp
  8018ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	ff 75 0c             	pushl  0xc(%ebp)
  8018b7:	ff 75 08             	pushl  0x8(%ebp)
  8018ba:	6a 0a                	push   $0xa
  8018bc:	e8 99 fe ff ff       	call   80175a <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
}
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 0b                	push   $0xb
  8018d5:	e8 80 fe ff ff       	call   80175a <syscall>
  8018da:	83 c4 18             	add    $0x18,%esp
}
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 0c                	push   $0xc
  8018ee:	e8 67 fe ff ff       	call   80175a <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 0d                	push   $0xd
  801907:	e8 4e fe ff ff       	call   80175a <syscall>
  80190c:	83 c4 18             	add    $0x18,%esp
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	ff 75 0c             	pushl  0xc(%ebp)
  80191d:	ff 75 08             	pushl  0x8(%ebp)
  801920:	6a 11                	push   $0x11
  801922:	e8 33 fe ff ff       	call   80175a <syscall>
  801927:	83 c4 18             	add    $0x18,%esp
	return;
  80192a:	90                   	nop
}
  80192b:	c9                   	leave  
  80192c:	c3                   	ret    

0080192d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80192d:	55                   	push   %ebp
  80192e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	ff 75 0c             	pushl  0xc(%ebp)
  801939:	ff 75 08             	pushl  0x8(%ebp)
  80193c:	6a 12                	push   $0x12
  80193e:	e8 17 fe ff ff       	call   80175a <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
	return ;
  801946:	90                   	nop
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 0e                	push   $0xe
  801958:	e8 fd fd ff ff       	call   80175a <syscall>
  80195d:	83 c4 18             	add    $0x18,%esp
}
  801960:	c9                   	leave  
  801961:	c3                   	ret    

00801962 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	ff 75 08             	pushl  0x8(%ebp)
  801970:	6a 0f                	push   $0xf
  801972:	e8 e3 fd ff ff       	call   80175a <syscall>
  801977:	83 c4 18             	add    $0x18,%esp
}
  80197a:	c9                   	leave  
  80197b:	c3                   	ret    

0080197c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 10                	push   $0x10
  80198b:	e8 ca fd ff ff       	call   80175a <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
}
  801993:	90                   	nop
  801994:	c9                   	leave  
  801995:	c3                   	ret    

00801996 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801996:	55                   	push   %ebp
  801997:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 14                	push   $0x14
  8019a5:	e8 b0 fd ff ff       	call   80175a <syscall>
  8019aa:	83 c4 18             	add    $0x18,%esp
}
  8019ad:	90                   	nop
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 15                	push   $0x15
  8019bf:	e8 96 fd ff ff       	call   80175a <syscall>
  8019c4:	83 c4 18             	add    $0x18,%esp
}
  8019c7:	90                   	nop
  8019c8:	c9                   	leave  
  8019c9:	c3                   	ret    

008019ca <sys_cputc>:


void
sys_cputc(const char c)
{
  8019ca:	55                   	push   %ebp
  8019cb:	89 e5                	mov    %esp,%ebp
  8019cd:	83 ec 04             	sub    $0x4,%esp
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019d6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	50                   	push   %eax
  8019e3:	6a 16                	push   $0x16
  8019e5:	e8 70 fd ff ff       	call   80175a <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
}
  8019ed:	90                   	nop
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 17                	push   $0x17
  8019ff:	e8 56 fd ff ff       	call   80175a <syscall>
  801a04:	83 c4 18             	add    $0x18,%esp
}
  801a07:	90                   	nop
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	ff 75 0c             	pushl  0xc(%ebp)
  801a19:	50                   	push   %eax
  801a1a:	6a 18                	push   $0x18
  801a1c:	e8 39 fd ff ff       	call   80175a <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a29:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	52                   	push   %edx
  801a36:	50                   	push   %eax
  801a37:	6a 1b                	push   $0x1b
  801a39:	e8 1c fd ff ff       	call   80175a <syscall>
  801a3e:	83 c4 18             	add    $0x18,%esp
}
  801a41:	c9                   	leave  
  801a42:	c3                   	ret    

00801a43 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a49:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	52                   	push   %edx
  801a53:	50                   	push   %eax
  801a54:	6a 19                	push   $0x19
  801a56:	e8 ff fc ff ff       	call   80175a <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
}
  801a5e:	90                   	nop
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a64:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a67:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	52                   	push   %edx
  801a71:	50                   	push   %eax
  801a72:	6a 1a                	push   $0x1a
  801a74:	e8 e1 fc ff ff       	call   80175a <syscall>
  801a79:	83 c4 18             	add    $0x18,%esp
}
  801a7c:	90                   	nop
  801a7d:	c9                   	leave  
  801a7e:	c3                   	ret    

00801a7f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
  801a82:	83 ec 04             	sub    $0x4,%esp
  801a85:	8b 45 10             	mov    0x10(%ebp),%eax
  801a88:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a8b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a8e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a92:	8b 45 08             	mov    0x8(%ebp),%eax
  801a95:	6a 00                	push   $0x0
  801a97:	51                   	push   %ecx
  801a98:	52                   	push   %edx
  801a99:	ff 75 0c             	pushl  0xc(%ebp)
  801a9c:	50                   	push   %eax
  801a9d:	6a 1c                	push   $0x1c
  801a9f:	e8 b6 fc ff ff       	call   80175a <syscall>
  801aa4:	83 c4 18             	add    $0x18,%esp
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801aac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	52                   	push   %edx
  801ab9:	50                   	push   %eax
  801aba:	6a 1d                	push   $0x1d
  801abc:	e8 99 fc ff ff       	call   80175a <syscall>
  801ac1:	83 c4 18             	add    $0x18,%esp
}
  801ac4:	c9                   	leave  
  801ac5:	c3                   	ret    

00801ac6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ac9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801acc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801acf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	51                   	push   %ecx
  801ad7:	52                   	push   %edx
  801ad8:	50                   	push   %eax
  801ad9:	6a 1e                	push   $0x1e
  801adb:	e8 7a fc ff ff       	call   80175a <syscall>
  801ae0:	83 c4 18             	add    $0x18,%esp
}
  801ae3:	c9                   	leave  
  801ae4:	c3                   	ret    

00801ae5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ae5:	55                   	push   %ebp
  801ae6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	52                   	push   %edx
  801af5:	50                   	push   %eax
  801af6:	6a 1f                	push   $0x1f
  801af8:	e8 5d fc ff ff       	call   80175a <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	c9                   	leave  
  801b01:	c3                   	ret    

00801b02 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 20                	push   $0x20
  801b11:	e8 44 fc ff ff       	call   80175a <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b21:	6a 00                	push   $0x0
  801b23:	ff 75 14             	pushl  0x14(%ebp)
  801b26:	ff 75 10             	pushl  0x10(%ebp)
  801b29:	ff 75 0c             	pushl  0xc(%ebp)
  801b2c:	50                   	push   %eax
  801b2d:	6a 21                	push   $0x21
  801b2f:	e8 26 fc ff ff       	call   80175a <syscall>
  801b34:	83 c4 18             	add    $0x18,%esp
}
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	50                   	push   %eax
  801b48:	6a 22                	push   $0x22
  801b4a:	e8 0b fc ff ff       	call   80175a <syscall>
  801b4f:	83 c4 18             	add    $0x18,%esp
}
  801b52:	90                   	nop
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b58:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	50                   	push   %eax
  801b64:	6a 23                	push   $0x23
  801b66:	e8 ef fb ff ff       	call   80175a <syscall>
  801b6b:	83 c4 18             	add    $0x18,%esp
}
  801b6e:	90                   	nop
  801b6f:	c9                   	leave  
  801b70:	c3                   	ret    

00801b71 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
  801b74:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b77:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b7a:	8d 50 04             	lea    0x4(%eax),%edx
  801b7d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	52                   	push   %edx
  801b87:	50                   	push   %eax
  801b88:	6a 24                	push   $0x24
  801b8a:	e8 cb fb ff ff       	call   80175a <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
	return result;
  801b92:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b98:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b9b:	89 01                	mov    %eax,(%ecx)
  801b9d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	c9                   	leave  
  801ba4:	c2 04 00             	ret    $0x4

00801ba7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ba7:	55                   	push   %ebp
  801ba8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	ff 75 10             	pushl  0x10(%ebp)
  801bb1:	ff 75 0c             	pushl  0xc(%ebp)
  801bb4:	ff 75 08             	pushl  0x8(%ebp)
  801bb7:	6a 13                	push   $0x13
  801bb9:	e8 9c fb ff ff       	call   80175a <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc1:	90                   	nop
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <sys_rcr2>:
uint32 sys_rcr2()
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 25                	push   $0x25
  801bd3:	e8 82 fb ff ff       	call   80175a <syscall>
  801bd8:	83 c4 18             	add    $0x18,%esp
}
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
  801be0:	83 ec 04             	sub    $0x4,%esp
  801be3:	8b 45 08             	mov    0x8(%ebp),%eax
  801be6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801be9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	50                   	push   %eax
  801bf6:	6a 26                	push   $0x26
  801bf8:	e8 5d fb ff ff       	call   80175a <syscall>
  801bfd:	83 c4 18             	add    $0x18,%esp
	return ;
  801c00:	90                   	nop
}
  801c01:	c9                   	leave  
  801c02:	c3                   	ret    

00801c03 <rsttst>:
void rsttst()
{
  801c03:	55                   	push   %ebp
  801c04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 28                	push   $0x28
  801c12:	e8 43 fb ff ff       	call   80175a <syscall>
  801c17:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1a:	90                   	nop
}
  801c1b:	c9                   	leave  
  801c1c:	c3                   	ret    

00801c1d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c1d:	55                   	push   %ebp
  801c1e:	89 e5                	mov    %esp,%ebp
  801c20:	83 ec 04             	sub    $0x4,%esp
  801c23:	8b 45 14             	mov    0x14(%ebp),%eax
  801c26:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c29:	8b 55 18             	mov    0x18(%ebp),%edx
  801c2c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c30:	52                   	push   %edx
  801c31:	50                   	push   %eax
  801c32:	ff 75 10             	pushl  0x10(%ebp)
  801c35:	ff 75 0c             	pushl  0xc(%ebp)
  801c38:	ff 75 08             	pushl  0x8(%ebp)
  801c3b:	6a 27                	push   $0x27
  801c3d:	e8 18 fb ff ff       	call   80175a <syscall>
  801c42:	83 c4 18             	add    $0x18,%esp
	return ;
  801c45:	90                   	nop
}
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <chktst>:
void chktst(uint32 n)
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	ff 75 08             	pushl  0x8(%ebp)
  801c56:	6a 29                	push   $0x29
  801c58:	e8 fd fa ff ff       	call   80175a <syscall>
  801c5d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c60:	90                   	nop
}
  801c61:	c9                   	leave  
  801c62:	c3                   	ret    

00801c63 <inctst>:

void inctst()
{
  801c63:	55                   	push   %ebp
  801c64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 2a                	push   $0x2a
  801c72:	e8 e3 fa ff ff       	call   80175a <syscall>
  801c77:	83 c4 18             	add    $0x18,%esp
	return ;
  801c7a:	90                   	nop
}
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <gettst>:
uint32 gettst()
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 2b                	push   $0x2b
  801c8c:	e8 c9 fa ff ff       	call   80175a <syscall>
  801c91:	83 c4 18             	add    $0x18,%esp
}
  801c94:	c9                   	leave  
  801c95:	c3                   	ret    

00801c96 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c96:	55                   	push   %ebp
  801c97:	89 e5                	mov    %esp,%ebp
  801c99:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 2c                	push   $0x2c
  801ca8:	e8 ad fa ff ff       	call   80175a <syscall>
  801cad:	83 c4 18             	add    $0x18,%esp
  801cb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801cb3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801cb7:	75 07                	jne    801cc0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801cb9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cbe:	eb 05                	jmp    801cc5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801cc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cc5:	c9                   	leave  
  801cc6:	c3                   	ret    

00801cc7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
  801cca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 2c                	push   $0x2c
  801cd9:	e8 7c fa ff ff       	call   80175a <syscall>
  801cde:	83 c4 18             	add    $0x18,%esp
  801ce1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ce4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ce8:	75 07                	jne    801cf1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cea:	b8 01 00 00 00       	mov    $0x1,%eax
  801cef:	eb 05                	jmp    801cf6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cf1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cf6:	c9                   	leave  
  801cf7:	c3                   	ret    

00801cf8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cf8:	55                   	push   %ebp
  801cf9:	89 e5                	mov    %esp,%ebp
  801cfb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 2c                	push   $0x2c
  801d0a:	e8 4b fa ff ff       	call   80175a <syscall>
  801d0f:	83 c4 18             	add    $0x18,%esp
  801d12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d15:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d19:	75 07                	jne    801d22 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d1b:	b8 01 00 00 00       	mov    $0x1,%eax
  801d20:	eb 05                	jmp    801d27 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
  801d2c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 2c                	push   $0x2c
  801d3b:	e8 1a fa ff ff       	call   80175a <syscall>
  801d40:	83 c4 18             	add    $0x18,%esp
  801d43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d46:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d4a:	75 07                	jne    801d53 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d4c:	b8 01 00 00 00       	mov    $0x1,%eax
  801d51:	eb 05                	jmp    801d58 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d58:	c9                   	leave  
  801d59:	c3                   	ret    

00801d5a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	ff 75 08             	pushl  0x8(%ebp)
  801d68:	6a 2d                	push   $0x2d
  801d6a:	e8 eb f9 ff ff       	call   80175a <syscall>
  801d6f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d72:	90                   	nop
}
  801d73:	c9                   	leave  
  801d74:	c3                   	ret    

00801d75 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d75:	55                   	push   %ebp
  801d76:	89 e5                	mov    %esp,%ebp
  801d78:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d79:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d7c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d82:	8b 45 08             	mov    0x8(%ebp),%eax
  801d85:	6a 00                	push   $0x0
  801d87:	53                   	push   %ebx
  801d88:	51                   	push   %ecx
  801d89:	52                   	push   %edx
  801d8a:	50                   	push   %eax
  801d8b:	6a 2e                	push   $0x2e
  801d8d:	e8 c8 f9 ff ff       	call   80175a <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d98:	c9                   	leave  
  801d99:	c3                   	ret    

00801d9a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da0:	8b 45 08             	mov    0x8(%ebp),%eax
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	52                   	push   %edx
  801daa:	50                   	push   %eax
  801dab:	6a 2f                	push   $0x2f
  801dad:	e8 a8 f9 ff ff       	call   80175a <syscall>
  801db2:	83 c4 18             	add    $0x18,%esp
}
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    
  801db7:	90                   	nop

00801db8 <__udivdi3>:
  801db8:	55                   	push   %ebp
  801db9:	57                   	push   %edi
  801dba:	56                   	push   %esi
  801dbb:	53                   	push   %ebx
  801dbc:	83 ec 1c             	sub    $0x1c,%esp
  801dbf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dc3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dc7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dcb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dcf:	89 ca                	mov    %ecx,%edx
  801dd1:	89 f8                	mov    %edi,%eax
  801dd3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dd7:	85 f6                	test   %esi,%esi
  801dd9:	75 2d                	jne    801e08 <__udivdi3+0x50>
  801ddb:	39 cf                	cmp    %ecx,%edi
  801ddd:	77 65                	ja     801e44 <__udivdi3+0x8c>
  801ddf:	89 fd                	mov    %edi,%ebp
  801de1:	85 ff                	test   %edi,%edi
  801de3:	75 0b                	jne    801df0 <__udivdi3+0x38>
  801de5:	b8 01 00 00 00       	mov    $0x1,%eax
  801dea:	31 d2                	xor    %edx,%edx
  801dec:	f7 f7                	div    %edi
  801dee:	89 c5                	mov    %eax,%ebp
  801df0:	31 d2                	xor    %edx,%edx
  801df2:	89 c8                	mov    %ecx,%eax
  801df4:	f7 f5                	div    %ebp
  801df6:	89 c1                	mov    %eax,%ecx
  801df8:	89 d8                	mov    %ebx,%eax
  801dfa:	f7 f5                	div    %ebp
  801dfc:	89 cf                	mov    %ecx,%edi
  801dfe:	89 fa                	mov    %edi,%edx
  801e00:	83 c4 1c             	add    $0x1c,%esp
  801e03:	5b                   	pop    %ebx
  801e04:	5e                   	pop    %esi
  801e05:	5f                   	pop    %edi
  801e06:	5d                   	pop    %ebp
  801e07:	c3                   	ret    
  801e08:	39 ce                	cmp    %ecx,%esi
  801e0a:	77 28                	ja     801e34 <__udivdi3+0x7c>
  801e0c:	0f bd fe             	bsr    %esi,%edi
  801e0f:	83 f7 1f             	xor    $0x1f,%edi
  801e12:	75 40                	jne    801e54 <__udivdi3+0x9c>
  801e14:	39 ce                	cmp    %ecx,%esi
  801e16:	72 0a                	jb     801e22 <__udivdi3+0x6a>
  801e18:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e1c:	0f 87 9e 00 00 00    	ja     801ec0 <__udivdi3+0x108>
  801e22:	b8 01 00 00 00       	mov    $0x1,%eax
  801e27:	89 fa                	mov    %edi,%edx
  801e29:	83 c4 1c             	add    $0x1c,%esp
  801e2c:	5b                   	pop    %ebx
  801e2d:	5e                   	pop    %esi
  801e2e:	5f                   	pop    %edi
  801e2f:	5d                   	pop    %ebp
  801e30:	c3                   	ret    
  801e31:	8d 76 00             	lea    0x0(%esi),%esi
  801e34:	31 ff                	xor    %edi,%edi
  801e36:	31 c0                	xor    %eax,%eax
  801e38:	89 fa                	mov    %edi,%edx
  801e3a:	83 c4 1c             	add    $0x1c,%esp
  801e3d:	5b                   	pop    %ebx
  801e3e:	5e                   	pop    %esi
  801e3f:	5f                   	pop    %edi
  801e40:	5d                   	pop    %ebp
  801e41:	c3                   	ret    
  801e42:	66 90                	xchg   %ax,%ax
  801e44:	89 d8                	mov    %ebx,%eax
  801e46:	f7 f7                	div    %edi
  801e48:	31 ff                	xor    %edi,%edi
  801e4a:	89 fa                	mov    %edi,%edx
  801e4c:	83 c4 1c             	add    $0x1c,%esp
  801e4f:	5b                   	pop    %ebx
  801e50:	5e                   	pop    %esi
  801e51:	5f                   	pop    %edi
  801e52:	5d                   	pop    %ebp
  801e53:	c3                   	ret    
  801e54:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e59:	89 eb                	mov    %ebp,%ebx
  801e5b:	29 fb                	sub    %edi,%ebx
  801e5d:	89 f9                	mov    %edi,%ecx
  801e5f:	d3 e6                	shl    %cl,%esi
  801e61:	89 c5                	mov    %eax,%ebp
  801e63:	88 d9                	mov    %bl,%cl
  801e65:	d3 ed                	shr    %cl,%ebp
  801e67:	89 e9                	mov    %ebp,%ecx
  801e69:	09 f1                	or     %esi,%ecx
  801e6b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e6f:	89 f9                	mov    %edi,%ecx
  801e71:	d3 e0                	shl    %cl,%eax
  801e73:	89 c5                	mov    %eax,%ebp
  801e75:	89 d6                	mov    %edx,%esi
  801e77:	88 d9                	mov    %bl,%cl
  801e79:	d3 ee                	shr    %cl,%esi
  801e7b:	89 f9                	mov    %edi,%ecx
  801e7d:	d3 e2                	shl    %cl,%edx
  801e7f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e83:	88 d9                	mov    %bl,%cl
  801e85:	d3 e8                	shr    %cl,%eax
  801e87:	09 c2                	or     %eax,%edx
  801e89:	89 d0                	mov    %edx,%eax
  801e8b:	89 f2                	mov    %esi,%edx
  801e8d:	f7 74 24 0c          	divl   0xc(%esp)
  801e91:	89 d6                	mov    %edx,%esi
  801e93:	89 c3                	mov    %eax,%ebx
  801e95:	f7 e5                	mul    %ebp
  801e97:	39 d6                	cmp    %edx,%esi
  801e99:	72 19                	jb     801eb4 <__udivdi3+0xfc>
  801e9b:	74 0b                	je     801ea8 <__udivdi3+0xf0>
  801e9d:	89 d8                	mov    %ebx,%eax
  801e9f:	31 ff                	xor    %edi,%edi
  801ea1:	e9 58 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ea6:	66 90                	xchg   %ax,%ax
  801ea8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801eac:	89 f9                	mov    %edi,%ecx
  801eae:	d3 e2                	shl    %cl,%edx
  801eb0:	39 c2                	cmp    %eax,%edx
  801eb2:	73 e9                	jae    801e9d <__udivdi3+0xe5>
  801eb4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801eb7:	31 ff                	xor    %edi,%edi
  801eb9:	e9 40 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ebe:	66 90                	xchg   %ax,%ax
  801ec0:	31 c0                	xor    %eax,%eax
  801ec2:	e9 37 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ec7:	90                   	nop

00801ec8 <__umoddi3>:
  801ec8:	55                   	push   %ebp
  801ec9:	57                   	push   %edi
  801eca:	56                   	push   %esi
  801ecb:	53                   	push   %ebx
  801ecc:	83 ec 1c             	sub    $0x1c,%esp
  801ecf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ed3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ed7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801edb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801edf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ee3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ee7:	89 f3                	mov    %esi,%ebx
  801ee9:	89 fa                	mov    %edi,%edx
  801eeb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eef:	89 34 24             	mov    %esi,(%esp)
  801ef2:	85 c0                	test   %eax,%eax
  801ef4:	75 1a                	jne    801f10 <__umoddi3+0x48>
  801ef6:	39 f7                	cmp    %esi,%edi
  801ef8:	0f 86 a2 00 00 00    	jbe    801fa0 <__umoddi3+0xd8>
  801efe:	89 c8                	mov    %ecx,%eax
  801f00:	89 f2                	mov    %esi,%edx
  801f02:	f7 f7                	div    %edi
  801f04:	89 d0                	mov    %edx,%eax
  801f06:	31 d2                	xor    %edx,%edx
  801f08:	83 c4 1c             	add    $0x1c,%esp
  801f0b:	5b                   	pop    %ebx
  801f0c:	5e                   	pop    %esi
  801f0d:	5f                   	pop    %edi
  801f0e:	5d                   	pop    %ebp
  801f0f:	c3                   	ret    
  801f10:	39 f0                	cmp    %esi,%eax
  801f12:	0f 87 ac 00 00 00    	ja     801fc4 <__umoddi3+0xfc>
  801f18:	0f bd e8             	bsr    %eax,%ebp
  801f1b:	83 f5 1f             	xor    $0x1f,%ebp
  801f1e:	0f 84 ac 00 00 00    	je     801fd0 <__umoddi3+0x108>
  801f24:	bf 20 00 00 00       	mov    $0x20,%edi
  801f29:	29 ef                	sub    %ebp,%edi
  801f2b:	89 fe                	mov    %edi,%esi
  801f2d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f31:	89 e9                	mov    %ebp,%ecx
  801f33:	d3 e0                	shl    %cl,%eax
  801f35:	89 d7                	mov    %edx,%edi
  801f37:	89 f1                	mov    %esi,%ecx
  801f39:	d3 ef                	shr    %cl,%edi
  801f3b:	09 c7                	or     %eax,%edi
  801f3d:	89 e9                	mov    %ebp,%ecx
  801f3f:	d3 e2                	shl    %cl,%edx
  801f41:	89 14 24             	mov    %edx,(%esp)
  801f44:	89 d8                	mov    %ebx,%eax
  801f46:	d3 e0                	shl    %cl,%eax
  801f48:	89 c2                	mov    %eax,%edx
  801f4a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f4e:	d3 e0                	shl    %cl,%eax
  801f50:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f54:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f58:	89 f1                	mov    %esi,%ecx
  801f5a:	d3 e8                	shr    %cl,%eax
  801f5c:	09 d0                	or     %edx,%eax
  801f5e:	d3 eb                	shr    %cl,%ebx
  801f60:	89 da                	mov    %ebx,%edx
  801f62:	f7 f7                	div    %edi
  801f64:	89 d3                	mov    %edx,%ebx
  801f66:	f7 24 24             	mull   (%esp)
  801f69:	89 c6                	mov    %eax,%esi
  801f6b:	89 d1                	mov    %edx,%ecx
  801f6d:	39 d3                	cmp    %edx,%ebx
  801f6f:	0f 82 87 00 00 00    	jb     801ffc <__umoddi3+0x134>
  801f75:	0f 84 91 00 00 00    	je     80200c <__umoddi3+0x144>
  801f7b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f7f:	29 f2                	sub    %esi,%edx
  801f81:	19 cb                	sbb    %ecx,%ebx
  801f83:	89 d8                	mov    %ebx,%eax
  801f85:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f89:	d3 e0                	shl    %cl,%eax
  801f8b:	89 e9                	mov    %ebp,%ecx
  801f8d:	d3 ea                	shr    %cl,%edx
  801f8f:	09 d0                	or     %edx,%eax
  801f91:	89 e9                	mov    %ebp,%ecx
  801f93:	d3 eb                	shr    %cl,%ebx
  801f95:	89 da                	mov    %ebx,%edx
  801f97:	83 c4 1c             	add    $0x1c,%esp
  801f9a:	5b                   	pop    %ebx
  801f9b:	5e                   	pop    %esi
  801f9c:	5f                   	pop    %edi
  801f9d:	5d                   	pop    %ebp
  801f9e:	c3                   	ret    
  801f9f:	90                   	nop
  801fa0:	89 fd                	mov    %edi,%ebp
  801fa2:	85 ff                	test   %edi,%edi
  801fa4:	75 0b                	jne    801fb1 <__umoddi3+0xe9>
  801fa6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fab:	31 d2                	xor    %edx,%edx
  801fad:	f7 f7                	div    %edi
  801faf:	89 c5                	mov    %eax,%ebp
  801fb1:	89 f0                	mov    %esi,%eax
  801fb3:	31 d2                	xor    %edx,%edx
  801fb5:	f7 f5                	div    %ebp
  801fb7:	89 c8                	mov    %ecx,%eax
  801fb9:	f7 f5                	div    %ebp
  801fbb:	89 d0                	mov    %edx,%eax
  801fbd:	e9 44 ff ff ff       	jmp    801f06 <__umoddi3+0x3e>
  801fc2:	66 90                	xchg   %ax,%ax
  801fc4:	89 c8                	mov    %ecx,%eax
  801fc6:	89 f2                	mov    %esi,%edx
  801fc8:	83 c4 1c             	add    $0x1c,%esp
  801fcb:	5b                   	pop    %ebx
  801fcc:	5e                   	pop    %esi
  801fcd:	5f                   	pop    %edi
  801fce:	5d                   	pop    %ebp
  801fcf:	c3                   	ret    
  801fd0:	3b 04 24             	cmp    (%esp),%eax
  801fd3:	72 06                	jb     801fdb <__umoddi3+0x113>
  801fd5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fd9:	77 0f                	ja     801fea <__umoddi3+0x122>
  801fdb:	89 f2                	mov    %esi,%edx
  801fdd:	29 f9                	sub    %edi,%ecx
  801fdf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fe3:	89 14 24             	mov    %edx,(%esp)
  801fe6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fea:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fee:	8b 14 24             	mov    (%esp),%edx
  801ff1:	83 c4 1c             	add    $0x1c,%esp
  801ff4:	5b                   	pop    %ebx
  801ff5:	5e                   	pop    %esi
  801ff6:	5f                   	pop    %edi
  801ff7:	5d                   	pop    %ebp
  801ff8:	c3                   	ret    
  801ff9:	8d 76 00             	lea    0x0(%esi),%esi
  801ffc:	2b 04 24             	sub    (%esp),%eax
  801fff:	19 fa                	sbb    %edi,%edx
  802001:	89 d1                	mov    %edx,%ecx
  802003:	89 c6                	mov    %eax,%esi
  802005:	e9 71 ff ff ff       	jmp    801f7b <__umoddi3+0xb3>
  80200a:	66 90                	xchg   %ax,%ax
  80200c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802010:	72 ea                	jb     801ffc <__umoddi3+0x134>
  802012:	89 d9                	mov    %ebx,%ecx
  802014:	e9 62 ff ff ff       	jmp    801f7b <__umoddi3+0xb3>
