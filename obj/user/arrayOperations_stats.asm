
obj/user/arrayOperations_stats:     file format elf32-i386


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
  800031:	e8 f7 04 00 00       	call   80052d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var, int *min, int *max, int *med);
int KthElement(int *Elements, int NumOfElements, int k);
int QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex, int kIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 5e 18 00 00       	call   8018a1 <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 88 18 00 00       	call   8018d3 <sys_getparentenvid>
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  80004e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int *sharedArray = NULL;
  800055:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	sharedArray = sget(parentenvID,"arr") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 c0 22 80 00       	push   $0x8022c0
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 ff 16 00 00       	call   80176b <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 c4 22 80 00       	push   $0x8022c4
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 e9 16 00 00       	call   80176b <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 cc 22 80 00       	push   $0x8022cc
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 cc 16 00 00       	call   80176b <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int max ;
	int med ;

	//take a copy from the original array
	int *tmpArray;
	tmpArray = smalloc("tmpArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 da 22 80 00       	push   $0x8022da
  8000b8:	e8 8b 16 00 00       	call   801748 <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		tmpArray[i] = sharedArray[i];
  8000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000d9:	01 c2                	add    %eax,%edx
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e8:	01 c8                	add    %ecx,%eax
  8000ea:	8b 00                	mov    (%eax),%eax
  8000ec:	89 02                	mov    %eax,(%edx)

	//take a copy from the original array
	int *tmpArray;
	tmpArray = smalloc("tmpArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		tmpArray[i] = sharedArray[i];
	}

	ArrayStats(tmpArray ,*numOfElements, &mean, &var, &min, &max, &med);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	8d 55 b4             	lea    -0x4c(%ebp),%edx
  800106:	52                   	push   %edx
  800107:	8d 55 b8             	lea    -0x48(%ebp),%edx
  80010a:	52                   	push   %edx
  80010b:	8d 55 bc             	lea    -0x44(%ebp),%edx
  80010e:	52                   	push   %edx
  80010f:	8d 55 c0             	lea    -0x40(%ebp),%edx
  800112:	52                   	push   %edx
  800113:	8d 55 c4             	lea    -0x3c(%ebp),%edx
  800116:	52                   	push   %edx
  800117:	50                   	push   %eax
  800118:	ff 75 dc             	pushl  -0x24(%ebp)
  80011b:	e8 55 02 00 00       	call   800375 <ArrayStats>
  800120:	83 c4 20             	add    $0x20,%esp
	cprintf("Stats Calculations are Finished!!!!\n") ;
  800123:	83 ec 0c             	sub    $0xc,%esp
  800126:	68 e4 22 80 00       	push   $0x8022e4
  80012b:	e8 16 06 00 00       	call   800746 <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	int *shMean, *shVar, *shMin, *shMax, *shMed;
	shMean = smalloc("mean", sizeof(int), 0) ; *shMean = mean;
  800133:	83 ec 04             	sub    $0x4,%esp
  800136:	6a 00                	push   $0x0
  800138:	6a 04                	push   $0x4
  80013a:	68 09 23 80 00       	push   $0x802309
  80013f:	e8 04 16 00 00       	call   801748 <smalloc>
  800144:	83 c4 10             	add    $0x10,%esp
  800147:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80014a:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  80014d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800150:	89 10                	mov    %edx,(%eax)
	shVar = smalloc("var", sizeof(int), 0) ; *shVar = var;
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	6a 00                	push   $0x0
  800157:	6a 04                	push   $0x4
  800159:	68 0e 23 80 00       	push   $0x80230e
  80015e:	e8 e5 15 00 00       	call   801748 <smalloc>
  800163:	83 c4 10             	add    $0x10,%esp
  800166:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800169:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80016c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80016f:	89 10                	mov    %edx,(%eax)
	shMin = smalloc("min", sizeof(int), 0) ; *shMin = min;
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	6a 00                	push   $0x0
  800176:	6a 04                	push   $0x4
  800178:	68 12 23 80 00       	push   $0x802312
  80017d:	e8 c6 15 00 00       	call   801748 <smalloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800188:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80018b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80018e:	89 10                	mov    %edx,(%eax)
	shMax = smalloc("max", sizeof(int), 0) ; *shMax = max;
  800190:	83 ec 04             	sub    $0x4,%esp
  800193:	6a 00                	push   $0x0
  800195:	6a 04                	push   $0x4
  800197:	68 16 23 80 00       	push   $0x802316
  80019c:	e8 a7 15 00 00       	call   801748 <smalloc>
  8001a1:	83 c4 10             	add    $0x10,%esp
  8001a4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001a7:	8b 55 b8             	mov    -0x48(%ebp),%edx
  8001aa:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ad:	89 10                	mov    %edx,(%eax)
	shMed = smalloc("med", sizeof(int), 0) ; *shMed = med;
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	6a 00                	push   $0x0
  8001b4:	6a 04                	push   $0x4
  8001b6:	68 1a 23 80 00       	push   $0x80231a
  8001bb:	e8 88 15 00 00       	call   801748 <smalloc>
  8001c0:	83 c4 10             	add    $0x10,%esp
  8001c3:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8001c6:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  8001c9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001cc:	89 10                	mov    %edx,(%eax)

	(*finishedCount)++ ;
  8001ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d1:	8b 00                	mov    (%eax),%eax
  8001d3:	8d 50 01             	lea    0x1(%eax),%edx
  8001d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d9:	89 10                	mov    %edx,(%eax)

}
  8001db:	90                   	nop
  8001dc:	c9                   	leave  
  8001dd:	c3                   	ret    

008001de <KthElement>:



///Kth Element
int KthElement(int *Elements, int NumOfElements, int k)
{
  8001de:	55                   	push   %ebp
  8001df:	89 e5                	mov    %esp,%ebp
  8001e1:	83 ec 08             	sub    $0x8,%esp
	return QSort(Elements, NumOfElements, 0, NumOfElements-1, k-1) ;
  8001e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8001e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8001ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ed:	48                   	dec    %eax
  8001ee:	83 ec 0c             	sub    $0xc,%esp
  8001f1:	52                   	push   %edx
  8001f2:	50                   	push   %eax
  8001f3:	6a 00                	push   $0x0
  8001f5:	ff 75 0c             	pushl  0xc(%ebp)
  8001f8:	ff 75 08             	pushl  0x8(%ebp)
  8001fb:	e8 05 00 00 00       	call   800205 <QSort>
  800200:	83 c4 20             	add    $0x20,%esp
}
  800203:	c9                   	leave  
  800204:	c3                   	ret    

00800205 <QSort>:


int QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex, int kIndex)
{
  800205:	55                   	push   %ebp
  800206:	89 e5                	mov    %esp,%ebp
  800208:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return Elements[finalIndex];
  80020b:	8b 45 10             	mov    0x10(%ebp),%eax
  80020e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800211:	7c 16                	jl     800229 <QSort+0x24>
  800213:	8b 45 14             	mov    0x14(%ebp),%eax
  800216:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80021d:	8b 45 08             	mov    0x8(%ebp),%eax
  800220:	01 d0                	add    %edx,%eax
  800222:	8b 00                	mov    (%eax),%eax
  800224:	e9 4a 01 00 00       	jmp    800373 <QSort+0x16e>

	int pvtIndex = RAND(startIndex, finalIndex) ;
  800229:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	50                   	push   %eax
  800230:	e8 fb 19 00 00       	call   801c30 <sys_get_virtual_time>
  800235:	83 c4 0c             	add    $0xc,%esp
  800238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80023b:	8b 55 14             	mov    0x14(%ebp),%edx
  80023e:	2b 55 10             	sub    0x10(%ebp),%edx
  800241:	89 d1                	mov    %edx,%ecx
  800243:	ba 00 00 00 00       	mov    $0x0,%edx
  800248:	f7 f1                	div    %ecx
  80024a:	8b 45 10             	mov    0x10(%ebp),%eax
  80024d:	01 d0                	add    %edx,%eax
  80024f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	ff 75 ec             	pushl  -0x14(%ebp)
  800258:	ff 75 10             	pushl  0x10(%ebp)
  80025b:	ff 75 08             	pushl  0x8(%ebp)
  80025e:	e8 77 02 00 00       	call   8004da <Swap>
  800263:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  800266:	8b 45 10             	mov    0x10(%ebp),%eax
  800269:	40                   	inc    %eax
  80026a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80026d:	8b 45 14             	mov    0x14(%ebp),%eax
  800270:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800273:	e9 80 00 00 00       	jmp    8002f8 <QSort+0xf3>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800278:	ff 45 f4             	incl   -0xc(%ebp)
  80027b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800281:	7f 2b                	jg     8002ae <QSort+0xa9>
  800283:	8b 45 10             	mov    0x10(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 10                	mov    (%eax),%edx
  800294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800297:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80029e:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a1:	01 c8                	add    %ecx,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	39 c2                	cmp    %eax,%edx
  8002a7:	7d cf                	jge    800278 <QSort+0x73>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002a9:	eb 03                	jmp    8002ae <QSort+0xa9>
  8002ab:	ff 4d f0             	decl   -0x10(%ebp)
  8002ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002b4:	7e 26                	jle    8002dc <QSort+0xd7>
  8002b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	8b 10                	mov    (%eax),%edx
  8002c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d4:	01 c8                	add    %ecx,%eax
  8002d6:	8b 00                	mov    (%eax),%eax
  8002d8:	39 c2                	cmp    %eax,%edx
  8002da:	7e cf                	jle    8002ab <QSort+0xa6>

		if (i <= j)
  8002dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e2:	7f 14                	jg     8002f8 <QSort+0xf3>
		{
			Swap(Elements, i, j);
  8002e4:	83 ec 04             	sub    $0x4,%esp
  8002e7:	ff 75 f0             	pushl  -0x10(%ebp)
  8002ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ed:	ff 75 08             	pushl  0x8(%ebp)
  8002f0:	e8 e5 01 00 00       	call   8004da <Swap>
  8002f5:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8002f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fe:	0f 8e 77 ff ff ff    	jle    80027b <QSort+0x76>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800304:	83 ec 04             	sub    $0x4,%esp
  800307:	ff 75 f0             	pushl  -0x10(%ebp)
  80030a:	ff 75 10             	pushl  0x10(%ebp)
  80030d:	ff 75 08             	pushl  0x8(%ebp)
  800310:	e8 c5 01 00 00       	call   8004da <Swap>
  800315:	83 c4 10             	add    $0x10,%esp

	if (kIndex == j)
  800318:	8b 45 18             	mov    0x18(%ebp),%eax
  80031b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031e:	75 13                	jne    800333 <QSort+0x12e>
		return Elements[kIndex] ;
  800320:	8b 45 18             	mov    0x18(%ebp),%eax
  800323:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 d0                	add    %edx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	eb 40                	jmp    800373 <QSort+0x16e>
	else if (kIndex < j)
  800333:	8b 45 18             	mov    0x18(%ebp),%eax
  800336:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800339:	7d 1e                	jge    800359 <QSort+0x154>
		return QSort(Elements, NumOfElements, startIndex, j - 1, kIndex);
  80033b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033e:	48                   	dec    %eax
  80033f:	83 ec 0c             	sub    $0xc,%esp
  800342:	ff 75 18             	pushl  0x18(%ebp)
  800345:	50                   	push   %eax
  800346:	ff 75 10             	pushl  0x10(%ebp)
  800349:	ff 75 0c             	pushl  0xc(%ebp)
  80034c:	ff 75 08             	pushl  0x8(%ebp)
  80034f:	e8 b1 fe ff ff       	call   800205 <QSort>
  800354:	83 c4 20             	add    $0x20,%esp
  800357:	eb 1a                	jmp    800373 <QSort+0x16e>
	else
		return QSort(Elements, NumOfElements, i, finalIndex, kIndex);
  800359:	83 ec 0c             	sub    $0xc,%esp
  80035c:	ff 75 18             	pushl  0x18(%ebp)
  80035f:	ff 75 14             	pushl  0x14(%ebp)
  800362:	ff 75 f4             	pushl  -0xc(%ebp)
  800365:	ff 75 0c             	pushl  0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	e8 95 fe ff ff       	call   800205 <QSort>
  800370:	83 c4 20             	add    $0x20,%esp
}
  800373:	c9                   	leave  
  800374:	c3                   	ret    

00800375 <ArrayStats>:

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var, int *min, int *max, int *med)
{
  800375:	55                   	push   %ebp
  800376:	89 e5                	mov    %esp,%ebp
  800378:	53                   	push   %ebx
  800379:	83 ec 14             	sub    $0x14,%esp
	int i ;
	*mean =0 ;
  80037c:	8b 45 10             	mov    0x10(%ebp),%eax
  80037f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	*min = 0x7FFFFFFF ;
  800385:	8b 45 18             	mov    0x18(%ebp),%eax
  800388:	c7 00 ff ff ff 7f    	movl   $0x7fffffff,(%eax)
	*max = 0x80000000 ;
  80038e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800391:	c7 00 00 00 00 80    	movl   $0x80000000,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  800397:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80039e:	e9 80 00 00 00       	jmp    800423 <ArrayStats+0xae>
	{
		(*mean) += Elements[i];
  8003a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a6:	8b 10                	mov    (%eax),%edx
  8003a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	01 c8                	add    %ecx,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	01 c2                	add    %eax,%edx
  8003bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003be:	89 10                	mov    %edx,(%eax)
		if (Elements[i] < (*min))
  8003c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	8b 10                	mov    (%eax),%edx
  8003d1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	39 c2                	cmp    %eax,%edx
  8003d8:	7d 16                	jge    8003f0 <ArrayStats+0x7b>
		{
			(*min) = Elements[i];
  8003da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8b 10                	mov    (%eax),%edx
  8003eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ee:	89 10                	mov    %edx,(%eax)
		}
		if (Elements[i] > (*max))
  8003f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	01 d0                	add    %edx,%eax
  8003ff:	8b 10                	mov    (%eax),%edx
  800401:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	39 c2                	cmp    %eax,%edx
  800408:	7e 16                	jle    800420 <ArrayStats+0xab>
		{
			(*max) = Elements[i];
  80040a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80040d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	01 d0                	add    %edx,%eax
  800419:	8b 10                	mov    (%eax),%edx
  80041b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80041e:	89 10                	mov    %edx,(%eax)
{
	int i ;
	*mean =0 ;
	*min = 0x7FFFFFFF ;
	*max = 0x80000000 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 f4             	incl   -0xc(%ebp)
  800423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	0f 8c 74 ff ff ff    	jl     8003a3 <ArrayStats+0x2e>
		{
			(*max) = Elements[i];
		}
	}

	(*med) = KthElement(Elements, NumOfElements, NumOfElements/2);
  80042f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800432:	89 c2                	mov    %eax,%edx
  800434:	c1 ea 1f             	shr    $0x1f,%edx
  800437:	01 d0                	add    %edx,%eax
  800439:	d1 f8                	sar    %eax
  80043b:	83 ec 04             	sub    $0x4,%esp
  80043e:	50                   	push   %eax
  80043f:	ff 75 0c             	pushl  0xc(%ebp)
  800442:	ff 75 08             	pushl  0x8(%ebp)
  800445:	e8 94 fd ff ff       	call   8001de <KthElement>
  80044a:	83 c4 10             	add    $0x10,%esp
  80044d:	89 c2                	mov    %eax,%edx
  80044f:	8b 45 20             	mov    0x20(%ebp),%eax
  800452:	89 10                	mov    %edx,(%eax)

	(*mean) /= NumOfElements;
  800454:	8b 45 10             	mov    0x10(%ebp),%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	99                   	cltd   
  80045a:	f7 7d 0c             	idivl  0xc(%ebp)
  80045d:	89 c2                	mov    %eax,%edx
  80045f:	8b 45 10             	mov    0x10(%ebp),%eax
  800462:	89 10                	mov    %edx,(%eax)
	(*var) = 0;
  800464:	8b 45 14             	mov    0x14(%ebp),%eax
  800467:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  80046d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800474:	eb 46                	jmp    8004bc <ArrayStats+0x147>
	{
		(*var) += (Elements[i] - (*mean))*(Elements[i] - (*mean));
  800476:	8b 45 14             	mov    0x14(%ebp),%eax
  800479:	8b 10                	mov    (%eax),%edx
  80047b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80047e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	01 c8                	add    %ecx,%eax
  80048a:	8b 08                	mov    (%eax),%ecx
  80048c:	8b 45 10             	mov    0x10(%ebp),%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	89 cb                	mov    %ecx,%ebx
  800493:	29 c3                	sub    %eax,%ebx
  800495:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800498:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	01 c8                	add    %ecx,%eax
  8004a4:	8b 08                	mov    (%eax),%ecx
  8004a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	29 c1                	sub    %eax,%ecx
  8004ad:	89 c8                	mov    %ecx,%eax
  8004af:	0f af c3             	imul   %ebx,%eax
  8004b2:	01 c2                	add    %eax,%edx
  8004b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8004b7:	89 10                	mov    %edx,(%eax)

	(*med) = KthElement(Elements, NumOfElements, NumOfElements/2);

	(*mean) /= NumOfElements;
	(*var) = 0;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b9:	ff 45 f4             	incl   -0xc(%ebp)
  8004bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c2:	7c b2                	jl     800476 <ArrayStats+0x101>
	{
		(*var) += (Elements[i] - (*mean))*(Elements[i] - (*mean));
	}
	(*var) /= NumOfElements;
  8004c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	99                   	cltd   
  8004ca:	f7 7d 0c             	idivl  0xc(%ebp)
  8004cd:	89 c2                	mov    %eax,%edx
  8004cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d2:	89 10                	mov    %edx,(%eax)
}
  8004d4:	90                   	nop
  8004d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004d8:	c9                   	leave  
  8004d9:	c3                   	ret    

008004da <Swap>:

///Private Functions
void Swap(int *Elements, int First, int Second)
{
  8004da:	55                   	push   %ebp
  8004db:	89 e5                	mov    %esp,%ebp
  8004dd:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	8b 00                	mov    (%eax),%eax
  8004f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	01 c2                	add    %eax,%edx
  800503:	8b 45 10             	mov    0x10(%ebp),%eax
  800506:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c8                	add    %ecx,%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800516:	8b 45 10             	mov    0x10(%ebp),%eax
  800519:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	01 c2                	add    %eax,%edx
  800525:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800528:	89 02                	mov    %eax,(%edx)
}
  80052a:	90                   	nop
  80052b:	c9                   	leave  
  80052c:	c3                   	ret    

0080052d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80052d:	55                   	push   %ebp
  80052e:	89 e5                	mov    %esp,%ebp
  800530:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800533:	e8 82 13 00 00       	call   8018ba <sys_getenvindex>
  800538:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80053b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80053e:	89 d0                	mov    %edx,%eax
  800540:	c1 e0 03             	shl    $0x3,%eax
  800543:	01 d0                	add    %edx,%eax
  800545:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80054c:	01 c8                	add    %ecx,%eax
  80054e:	01 c0                	add    %eax,%eax
  800550:	01 d0                	add    %edx,%eax
  800552:	01 c0                	add    %eax,%eax
  800554:	01 d0                	add    %edx,%eax
  800556:	89 c2                	mov    %eax,%edx
  800558:	c1 e2 05             	shl    $0x5,%edx
  80055b:	29 c2                	sub    %eax,%edx
  80055d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800564:	89 c2                	mov    %eax,%edx
  800566:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80056c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800571:	a1 20 30 80 00       	mov    0x803020,%eax
  800576:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80057c:	84 c0                	test   %al,%al
  80057e:	74 0f                	je     80058f <libmain+0x62>
		binaryname = myEnv->prog_name;
  800580:	a1 20 30 80 00       	mov    0x803020,%eax
  800585:	05 40 3c 01 00       	add    $0x13c40,%eax
  80058a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80058f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800593:	7e 0a                	jle    80059f <libmain+0x72>
		binaryname = argv[0];
  800595:	8b 45 0c             	mov    0xc(%ebp),%eax
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80059f:	83 ec 08             	sub    $0x8,%esp
  8005a2:	ff 75 0c             	pushl  0xc(%ebp)
  8005a5:	ff 75 08             	pushl  0x8(%ebp)
  8005a8:	e8 8b fa ff ff       	call   800038 <_main>
  8005ad:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005b0:	e8 a0 14 00 00       	call   801a55 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005b5:	83 ec 0c             	sub    $0xc,%esp
  8005b8:	68 38 23 80 00       	push   $0x802338
  8005bd:	e8 84 01 00 00       	call   800746 <cprintf>
  8005c2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ca:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8005d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d5:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8005db:	83 ec 04             	sub    $0x4,%esp
  8005de:	52                   	push   %edx
  8005df:	50                   	push   %eax
  8005e0:	68 60 23 80 00       	push   $0x802360
  8005e5:	e8 5c 01 00 00       	call   800746 <cprintf>
  8005ea:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8005ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f2:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8005f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fd:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800603:	83 ec 04             	sub    $0x4,%esp
  800606:	52                   	push   %edx
  800607:	50                   	push   %eax
  800608:	68 88 23 80 00       	push   $0x802388
  80060d:	e8 34 01 00 00       	call   800746 <cprintf>
  800612:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800615:	a1 20 30 80 00       	mov    0x803020,%eax
  80061a:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800620:	83 ec 08             	sub    $0x8,%esp
  800623:	50                   	push   %eax
  800624:	68 c9 23 80 00       	push   $0x8023c9
  800629:	e8 18 01 00 00       	call   800746 <cprintf>
  80062e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800631:	83 ec 0c             	sub    $0xc,%esp
  800634:	68 38 23 80 00       	push   $0x802338
  800639:	e8 08 01 00 00       	call   800746 <cprintf>
  80063e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800641:	e8 29 14 00 00       	call   801a6f <sys_enable_interrupt>

	// exit gracefully
	exit();
  800646:	e8 19 00 00 00       	call   800664 <exit>
}
  80064b:	90                   	nop
  80064c:	c9                   	leave  
  80064d:	c3                   	ret    

0080064e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80064e:	55                   	push   %ebp
  80064f:	89 e5                	mov    %esp,%ebp
  800651:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800654:	83 ec 0c             	sub    $0xc,%esp
  800657:	6a 00                	push   $0x0
  800659:	e8 28 12 00 00       	call   801886 <sys_env_destroy>
  80065e:	83 c4 10             	add    $0x10,%esp
}
  800661:	90                   	nop
  800662:	c9                   	leave  
  800663:	c3                   	ret    

00800664 <exit>:

void
exit(void)
{
  800664:	55                   	push   %ebp
  800665:	89 e5                	mov    %esp,%ebp
  800667:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80066a:	e8 7d 12 00 00       	call   8018ec <sys_env_exit>
}
  80066f:	90                   	nop
  800670:	c9                   	leave  
  800671:	c3                   	ret    

00800672 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800672:	55                   	push   %ebp
  800673:	89 e5                	mov    %esp,%ebp
  800675:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800678:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067b:	8b 00                	mov    (%eax),%eax
  80067d:	8d 48 01             	lea    0x1(%eax),%ecx
  800680:	8b 55 0c             	mov    0xc(%ebp),%edx
  800683:	89 0a                	mov    %ecx,(%edx)
  800685:	8b 55 08             	mov    0x8(%ebp),%edx
  800688:	88 d1                	mov    %dl,%cl
  80068a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80068d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800691:	8b 45 0c             	mov    0xc(%ebp),%eax
  800694:	8b 00                	mov    (%eax),%eax
  800696:	3d ff 00 00 00       	cmp    $0xff,%eax
  80069b:	75 2c                	jne    8006c9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80069d:	a0 24 30 80 00       	mov    0x803024,%al
  8006a2:	0f b6 c0             	movzbl %al,%eax
  8006a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a8:	8b 12                	mov    (%edx),%edx
  8006aa:	89 d1                	mov    %edx,%ecx
  8006ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006af:	83 c2 08             	add    $0x8,%edx
  8006b2:	83 ec 04             	sub    $0x4,%esp
  8006b5:	50                   	push   %eax
  8006b6:	51                   	push   %ecx
  8006b7:	52                   	push   %edx
  8006b8:	e8 87 11 00 00       	call   801844 <sys_cputs>
  8006bd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006cc:	8b 40 04             	mov    0x4(%eax),%eax
  8006cf:	8d 50 01             	lea    0x1(%eax),%edx
  8006d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006d8:	90                   	nop
  8006d9:	c9                   	leave  
  8006da:	c3                   	ret    

008006db <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006db:	55                   	push   %ebp
  8006dc:	89 e5                	mov    %esp,%ebp
  8006de:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006e4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006eb:	00 00 00 
	b.cnt = 0;
  8006ee:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006f5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006f8:	ff 75 0c             	pushl  0xc(%ebp)
  8006fb:	ff 75 08             	pushl  0x8(%ebp)
  8006fe:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800704:	50                   	push   %eax
  800705:	68 72 06 80 00       	push   $0x800672
  80070a:	e8 11 02 00 00       	call   800920 <vprintfmt>
  80070f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800712:	a0 24 30 80 00       	mov    0x803024,%al
  800717:	0f b6 c0             	movzbl %al,%eax
  80071a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800720:	83 ec 04             	sub    $0x4,%esp
  800723:	50                   	push   %eax
  800724:	52                   	push   %edx
  800725:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80072b:	83 c0 08             	add    $0x8,%eax
  80072e:	50                   	push   %eax
  80072f:	e8 10 11 00 00       	call   801844 <sys_cputs>
  800734:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800737:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80073e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800744:	c9                   	leave  
  800745:	c3                   	ret    

00800746 <cprintf>:

int cprintf(const char *fmt, ...) {
  800746:	55                   	push   %ebp
  800747:	89 e5                	mov    %esp,%ebp
  800749:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80074c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800753:	8d 45 0c             	lea    0xc(%ebp),%eax
  800756:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	83 ec 08             	sub    $0x8,%esp
  80075f:	ff 75 f4             	pushl  -0xc(%ebp)
  800762:	50                   	push   %eax
  800763:	e8 73 ff ff ff       	call   8006db <vcprintf>
  800768:	83 c4 10             	add    $0x10,%esp
  80076b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80076e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800771:	c9                   	leave  
  800772:	c3                   	ret    

00800773 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800779:	e8 d7 12 00 00       	call   801a55 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80077e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800781:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	83 ec 08             	sub    $0x8,%esp
  80078a:	ff 75 f4             	pushl  -0xc(%ebp)
  80078d:	50                   	push   %eax
  80078e:	e8 48 ff ff ff       	call   8006db <vcprintf>
  800793:	83 c4 10             	add    $0x10,%esp
  800796:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800799:	e8 d1 12 00 00       	call   801a6f <sys_enable_interrupt>
	return cnt;
  80079e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007a1:	c9                   	leave  
  8007a2:	c3                   	ret    

008007a3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007a3:	55                   	push   %ebp
  8007a4:	89 e5                	mov    %esp,%ebp
  8007a6:	53                   	push   %ebx
  8007a7:	83 ec 14             	sub    $0x14,%esp
  8007aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007b6:	8b 45 18             	mov    0x18(%ebp),%eax
  8007b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8007be:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007c1:	77 55                	ja     800818 <printnum+0x75>
  8007c3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007c6:	72 05                	jb     8007cd <printnum+0x2a>
  8007c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007cb:	77 4b                	ja     800818 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007cd:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007d0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007d3:	8b 45 18             	mov    0x18(%ebp),%eax
  8007d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8007db:	52                   	push   %edx
  8007dc:	50                   	push   %eax
  8007dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e0:	ff 75 f0             	pushl  -0x10(%ebp)
  8007e3:	e8 5c 18 00 00       	call   802044 <__udivdi3>
  8007e8:	83 c4 10             	add    $0x10,%esp
  8007eb:	83 ec 04             	sub    $0x4,%esp
  8007ee:	ff 75 20             	pushl  0x20(%ebp)
  8007f1:	53                   	push   %ebx
  8007f2:	ff 75 18             	pushl  0x18(%ebp)
  8007f5:	52                   	push   %edx
  8007f6:	50                   	push   %eax
  8007f7:	ff 75 0c             	pushl  0xc(%ebp)
  8007fa:	ff 75 08             	pushl  0x8(%ebp)
  8007fd:	e8 a1 ff ff ff       	call   8007a3 <printnum>
  800802:	83 c4 20             	add    $0x20,%esp
  800805:	eb 1a                	jmp    800821 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800807:	83 ec 08             	sub    $0x8,%esp
  80080a:	ff 75 0c             	pushl  0xc(%ebp)
  80080d:	ff 75 20             	pushl  0x20(%ebp)
  800810:	8b 45 08             	mov    0x8(%ebp),%eax
  800813:	ff d0                	call   *%eax
  800815:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800818:	ff 4d 1c             	decl   0x1c(%ebp)
  80081b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80081f:	7f e6                	jg     800807 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800821:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800824:	bb 00 00 00 00       	mov    $0x0,%ebx
  800829:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80082f:	53                   	push   %ebx
  800830:	51                   	push   %ecx
  800831:	52                   	push   %edx
  800832:	50                   	push   %eax
  800833:	e8 1c 19 00 00       	call   802154 <__umoddi3>
  800838:	83 c4 10             	add    $0x10,%esp
  80083b:	05 f4 25 80 00       	add    $0x8025f4,%eax
  800840:	8a 00                	mov    (%eax),%al
  800842:	0f be c0             	movsbl %al,%eax
  800845:	83 ec 08             	sub    $0x8,%esp
  800848:	ff 75 0c             	pushl  0xc(%ebp)
  80084b:	50                   	push   %eax
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	ff d0                	call   *%eax
  800851:	83 c4 10             	add    $0x10,%esp
}
  800854:	90                   	nop
  800855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800858:	c9                   	leave  
  800859:	c3                   	ret    

0080085a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80085a:	55                   	push   %ebp
  80085b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80085d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800861:	7e 1c                	jle    80087f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	8b 00                	mov    (%eax),%eax
  800868:	8d 50 08             	lea    0x8(%eax),%edx
  80086b:	8b 45 08             	mov    0x8(%ebp),%eax
  80086e:	89 10                	mov    %edx,(%eax)
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	83 e8 08             	sub    $0x8,%eax
  800878:	8b 50 04             	mov    0x4(%eax),%edx
  80087b:	8b 00                	mov    (%eax),%eax
  80087d:	eb 40                	jmp    8008bf <getuint+0x65>
	else if (lflag)
  80087f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800883:	74 1e                	je     8008a3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	8b 00                	mov    (%eax),%eax
  80088a:	8d 50 04             	lea    0x4(%eax),%edx
  80088d:	8b 45 08             	mov    0x8(%ebp),%eax
  800890:	89 10                	mov    %edx,(%eax)
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	8b 00                	mov    (%eax),%eax
  800897:	83 e8 04             	sub    $0x4,%eax
  80089a:	8b 00                	mov    (%eax),%eax
  80089c:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a1:	eb 1c                	jmp    8008bf <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	8b 00                	mov    (%eax),%eax
  8008a8:	8d 50 04             	lea    0x4(%eax),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	89 10                	mov    %edx,(%eax)
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	83 e8 04             	sub    $0x4,%eax
  8008b8:	8b 00                	mov    (%eax),%eax
  8008ba:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008bf:	5d                   	pop    %ebp
  8008c0:	c3                   	ret    

008008c1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008c1:	55                   	push   %ebp
  8008c2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008c4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008c8:	7e 1c                	jle    8008e6 <getint+0x25>
		return va_arg(*ap, long long);
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	8d 50 08             	lea    0x8(%eax),%edx
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	89 10                	mov    %edx,(%eax)
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	83 e8 08             	sub    $0x8,%eax
  8008df:	8b 50 04             	mov    0x4(%eax),%edx
  8008e2:	8b 00                	mov    (%eax),%eax
  8008e4:	eb 38                	jmp    80091e <getint+0x5d>
	else if (lflag)
  8008e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ea:	74 1a                	je     800906 <getint+0x45>
		return va_arg(*ap, long);
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	8d 50 04             	lea    0x4(%eax),%edx
  8008f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f7:	89 10                	mov    %edx,(%eax)
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	83 e8 04             	sub    $0x4,%eax
  800901:	8b 00                	mov    (%eax),%eax
  800903:	99                   	cltd   
  800904:	eb 18                	jmp    80091e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	8b 00                	mov    (%eax),%eax
  80090b:	8d 50 04             	lea    0x4(%eax),%edx
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	89 10                	mov    %edx,(%eax)
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	8b 00                	mov    (%eax),%eax
  800918:	83 e8 04             	sub    $0x4,%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	99                   	cltd   
}
  80091e:	5d                   	pop    %ebp
  80091f:	c3                   	ret    

00800920 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800920:	55                   	push   %ebp
  800921:	89 e5                	mov    %esp,%ebp
  800923:	56                   	push   %esi
  800924:	53                   	push   %ebx
  800925:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800928:	eb 17                	jmp    800941 <vprintfmt+0x21>
			if (ch == '\0')
  80092a:	85 db                	test   %ebx,%ebx
  80092c:	0f 84 af 03 00 00    	je     800ce1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	ff 75 0c             	pushl  0xc(%ebp)
  800938:	53                   	push   %ebx
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	ff d0                	call   *%eax
  80093e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800941:	8b 45 10             	mov    0x10(%ebp),%eax
  800944:	8d 50 01             	lea    0x1(%eax),%edx
  800947:	89 55 10             	mov    %edx,0x10(%ebp)
  80094a:	8a 00                	mov    (%eax),%al
  80094c:	0f b6 d8             	movzbl %al,%ebx
  80094f:	83 fb 25             	cmp    $0x25,%ebx
  800952:	75 d6                	jne    80092a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800954:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800958:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80095f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800966:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80096d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800974:	8b 45 10             	mov    0x10(%ebp),%eax
  800977:	8d 50 01             	lea    0x1(%eax),%edx
  80097a:	89 55 10             	mov    %edx,0x10(%ebp)
  80097d:	8a 00                	mov    (%eax),%al
  80097f:	0f b6 d8             	movzbl %al,%ebx
  800982:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800985:	83 f8 55             	cmp    $0x55,%eax
  800988:	0f 87 2b 03 00 00    	ja     800cb9 <vprintfmt+0x399>
  80098e:	8b 04 85 18 26 80 00 	mov    0x802618(,%eax,4),%eax
  800995:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800997:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80099b:	eb d7                	jmp    800974 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80099d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009a1:	eb d1                	jmp    800974 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009a3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ad:	89 d0                	mov    %edx,%eax
  8009af:	c1 e0 02             	shl    $0x2,%eax
  8009b2:	01 d0                	add    %edx,%eax
  8009b4:	01 c0                	add    %eax,%eax
  8009b6:	01 d8                	add    %ebx,%eax
  8009b8:	83 e8 30             	sub    $0x30,%eax
  8009bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009be:	8b 45 10             	mov    0x10(%ebp),%eax
  8009c1:	8a 00                	mov    (%eax),%al
  8009c3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009c6:	83 fb 2f             	cmp    $0x2f,%ebx
  8009c9:	7e 3e                	jle    800a09 <vprintfmt+0xe9>
  8009cb:	83 fb 39             	cmp    $0x39,%ebx
  8009ce:	7f 39                	jg     800a09 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009d0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009d3:	eb d5                	jmp    8009aa <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d8:	83 c0 04             	add    $0x4,%eax
  8009db:	89 45 14             	mov    %eax,0x14(%ebp)
  8009de:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e1:	83 e8 04             	sub    $0x4,%eax
  8009e4:	8b 00                	mov    (%eax),%eax
  8009e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009e9:	eb 1f                	jmp    800a0a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ef:	79 83                	jns    800974 <vprintfmt+0x54>
				width = 0;
  8009f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009f8:	e9 77 ff ff ff       	jmp    800974 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009fd:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a04:	e9 6b ff ff ff       	jmp    800974 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a09:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a0a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a0e:	0f 89 60 ff ff ff    	jns    800974 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a14:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a17:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a1a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a21:	e9 4e ff ff ff       	jmp    800974 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a26:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a29:	e9 46 ff ff ff       	jmp    800974 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a31:	83 c0 04             	add    $0x4,%eax
  800a34:	89 45 14             	mov    %eax,0x14(%ebp)
  800a37:	8b 45 14             	mov    0x14(%ebp),%eax
  800a3a:	83 e8 04             	sub    $0x4,%eax
  800a3d:	8b 00                	mov    (%eax),%eax
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	50                   	push   %eax
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	ff d0                	call   *%eax
  800a4b:	83 c4 10             	add    $0x10,%esp
			break;
  800a4e:	e9 89 02 00 00       	jmp    800cdc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a53:	8b 45 14             	mov    0x14(%ebp),%eax
  800a56:	83 c0 04             	add    $0x4,%eax
  800a59:	89 45 14             	mov    %eax,0x14(%ebp)
  800a5c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5f:	83 e8 04             	sub    $0x4,%eax
  800a62:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a64:	85 db                	test   %ebx,%ebx
  800a66:	79 02                	jns    800a6a <vprintfmt+0x14a>
				err = -err;
  800a68:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a6a:	83 fb 64             	cmp    $0x64,%ebx
  800a6d:	7f 0b                	jg     800a7a <vprintfmt+0x15a>
  800a6f:	8b 34 9d 60 24 80 00 	mov    0x802460(,%ebx,4),%esi
  800a76:	85 f6                	test   %esi,%esi
  800a78:	75 19                	jne    800a93 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a7a:	53                   	push   %ebx
  800a7b:	68 05 26 80 00       	push   $0x802605
  800a80:	ff 75 0c             	pushl  0xc(%ebp)
  800a83:	ff 75 08             	pushl  0x8(%ebp)
  800a86:	e8 5e 02 00 00       	call   800ce9 <printfmt>
  800a8b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a8e:	e9 49 02 00 00       	jmp    800cdc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a93:	56                   	push   %esi
  800a94:	68 0e 26 80 00       	push   $0x80260e
  800a99:	ff 75 0c             	pushl  0xc(%ebp)
  800a9c:	ff 75 08             	pushl  0x8(%ebp)
  800a9f:	e8 45 02 00 00       	call   800ce9 <printfmt>
  800aa4:	83 c4 10             	add    $0x10,%esp
			break;
  800aa7:	e9 30 02 00 00       	jmp    800cdc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800aac:	8b 45 14             	mov    0x14(%ebp),%eax
  800aaf:	83 c0 04             	add    $0x4,%eax
  800ab2:	89 45 14             	mov    %eax,0x14(%ebp)
  800ab5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab8:	83 e8 04             	sub    $0x4,%eax
  800abb:	8b 30                	mov    (%eax),%esi
  800abd:	85 f6                	test   %esi,%esi
  800abf:	75 05                	jne    800ac6 <vprintfmt+0x1a6>
				p = "(null)";
  800ac1:	be 11 26 80 00       	mov    $0x802611,%esi
			if (width > 0 && padc != '-')
  800ac6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aca:	7e 6d                	jle    800b39 <vprintfmt+0x219>
  800acc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ad0:	74 67                	je     800b39 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ad2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ad5:	83 ec 08             	sub    $0x8,%esp
  800ad8:	50                   	push   %eax
  800ad9:	56                   	push   %esi
  800ada:	e8 0c 03 00 00       	call   800deb <strnlen>
  800adf:	83 c4 10             	add    $0x10,%esp
  800ae2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ae5:	eb 16                	jmp    800afd <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ae7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800aeb:	83 ec 08             	sub    $0x8,%esp
  800aee:	ff 75 0c             	pushl  0xc(%ebp)
  800af1:	50                   	push   %eax
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
  800af5:	ff d0                	call   *%eax
  800af7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800afa:	ff 4d e4             	decl   -0x1c(%ebp)
  800afd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b01:	7f e4                	jg     800ae7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b03:	eb 34                	jmp    800b39 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b05:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b09:	74 1c                	je     800b27 <vprintfmt+0x207>
  800b0b:	83 fb 1f             	cmp    $0x1f,%ebx
  800b0e:	7e 05                	jle    800b15 <vprintfmt+0x1f5>
  800b10:	83 fb 7e             	cmp    $0x7e,%ebx
  800b13:	7e 12                	jle    800b27 <vprintfmt+0x207>
					putch('?', putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	6a 3f                	push   $0x3f
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	ff d0                	call   *%eax
  800b22:	83 c4 10             	add    $0x10,%esp
  800b25:	eb 0f                	jmp    800b36 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b27:	83 ec 08             	sub    $0x8,%esp
  800b2a:	ff 75 0c             	pushl  0xc(%ebp)
  800b2d:	53                   	push   %ebx
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	ff d0                	call   *%eax
  800b33:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b36:	ff 4d e4             	decl   -0x1c(%ebp)
  800b39:	89 f0                	mov    %esi,%eax
  800b3b:	8d 70 01             	lea    0x1(%eax),%esi
  800b3e:	8a 00                	mov    (%eax),%al
  800b40:	0f be d8             	movsbl %al,%ebx
  800b43:	85 db                	test   %ebx,%ebx
  800b45:	74 24                	je     800b6b <vprintfmt+0x24b>
  800b47:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b4b:	78 b8                	js     800b05 <vprintfmt+0x1e5>
  800b4d:	ff 4d e0             	decl   -0x20(%ebp)
  800b50:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b54:	79 af                	jns    800b05 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b56:	eb 13                	jmp    800b6b <vprintfmt+0x24b>
				putch(' ', putdat);
  800b58:	83 ec 08             	sub    $0x8,%esp
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	6a 20                	push   $0x20
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	ff d0                	call   *%eax
  800b65:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b68:	ff 4d e4             	decl   -0x1c(%ebp)
  800b6b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b6f:	7f e7                	jg     800b58 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b71:	e9 66 01 00 00       	jmp    800cdc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b76:	83 ec 08             	sub    $0x8,%esp
  800b79:	ff 75 e8             	pushl  -0x18(%ebp)
  800b7c:	8d 45 14             	lea    0x14(%ebp),%eax
  800b7f:	50                   	push   %eax
  800b80:	e8 3c fd ff ff       	call   8008c1 <getint>
  800b85:	83 c4 10             	add    $0x10,%esp
  800b88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b94:	85 d2                	test   %edx,%edx
  800b96:	79 23                	jns    800bbb <vprintfmt+0x29b>
				putch('-', putdat);
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 0c             	pushl  0xc(%ebp)
  800b9e:	6a 2d                	push   $0x2d
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	ff d0                	call   *%eax
  800ba5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bae:	f7 d8                	neg    %eax
  800bb0:	83 d2 00             	adc    $0x0,%edx
  800bb3:	f7 da                	neg    %edx
  800bb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bbb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bc2:	e9 bc 00 00 00       	jmp    800c83 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bc7:	83 ec 08             	sub    $0x8,%esp
  800bca:	ff 75 e8             	pushl  -0x18(%ebp)
  800bcd:	8d 45 14             	lea    0x14(%ebp),%eax
  800bd0:	50                   	push   %eax
  800bd1:	e8 84 fc ff ff       	call   80085a <getuint>
  800bd6:	83 c4 10             	add    $0x10,%esp
  800bd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bdc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bdf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800be6:	e9 98 00 00 00       	jmp    800c83 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800beb:	83 ec 08             	sub    $0x8,%esp
  800bee:	ff 75 0c             	pushl  0xc(%ebp)
  800bf1:	6a 58                	push   $0x58
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	ff d0                	call   *%eax
  800bf8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bfb:	83 ec 08             	sub    $0x8,%esp
  800bfe:	ff 75 0c             	pushl  0xc(%ebp)
  800c01:	6a 58                	push   $0x58
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	ff d0                	call   *%eax
  800c08:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c0b:	83 ec 08             	sub    $0x8,%esp
  800c0e:	ff 75 0c             	pushl  0xc(%ebp)
  800c11:	6a 58                	push   $0x58
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	ff d0                	call   *%eax
  800c18:	83 c4 10             	add    $0x10,%esp
			break;
  800c1b:	e9 bc 00 00 00       	jmp    800cdc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c20:	83 ec 08             	sub    $0x8,%esp
  800c23:	ff 75 0c             	pushl  0xc(%ebp)
  800c26:	6a 30                	push   $0x30
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	ff d0                	call   *%eax
  800c2d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c30:	83 ec 08             	sub    $0x8,%esp
  800c33:	ff 75 0c             	pushl  0xc(%ebp)
  800c36:	6a 78                	push   $0x78
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	ff d0                	call   *%eax
  800c3d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c40:	8b 45 14             	mov    0x14(%ebp),%eax
  800c43:	83 c0 04             	add    $0x4,%eax
  800c46:	89 45 14             	mov    %eax,0x14(%ebp)
  800c49:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4c:	83 e8 04             	sub    $0x4,%eax
  800c4f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c51:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c5b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c62:	eb 1f                	jmp    800c83 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c64:	83 ec 08             	sub    $0x8,%esp
  800c67:	ff 75 e8             	pushl  -0x18(%ebp)
  800c6a:	8d 45 14             	lea    0x14(%ebp),%eax
  800c6d:	50                   	push   %eax
  800c6e:	e8 e7 fb ff ff       	call   80085a <getuint>
  800c73:	83 c4 10             	add    $0x10,%esp
  800c76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c79:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c7c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c83:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c87:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c8a:	83 ec 04             	sub    $0x4,%esp
  800c8d:	52                   	push   %edx
  800c8e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c91:	50                   	push   %eax
  800c92:	ff 75 f4             	pushl  -0xc(%ebp)
  800c95:	ff 75 f0             	pushl  -0x10(%ebp)
  800c98:	ff 75 0c             	pushl  0xc(%ebp)
  800c9b:	ff 75 08             	pushl  0x8(%ebp)
  800c9e:	e8 00 fb ff ff       	call   8007a3 <printnum>
  800ca3:	83 c4 20             	add    $0x20,%esp
			break;
  800ca6:	eb 34                	jmp    800cdc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ca8:	83 ec 08             	sub    $0x8,%esp
  800cab:	ff 75 0c             	pushl  0xc(%ebp)
  800cae:	53                   	push   %ebx
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	ff d0                	call   *%eax
  800cb4:	83 c4 10             	add    $0x10,%esp
			break;
  800cb7:	eb 23                	jmp    800cdc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cb9:	83 ec 08             	sub    $0x8,%esp
  800cbc:	ff 75 0c             	pushl  0xc(%ebp)
  800cbf:	6a 25                	push   $0x25
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	ff d0                	call   *%eax
  800cc6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cc9:	ff 4d 10             	decl   0x10(%ebp)
  800ccc:	eb 03                	jmp    800cd1 <vprintfmt+0x3b1>
  800cce:	ff 4d 10             	decl   0x10(%ebp)
  800cd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd4:	48                   	dec    %eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	3c 25                	cmp    $0x25,%al
  800cd9:	75 f3                	jne    800cce <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cdb:	90                   	nop
		}
	}
  800cdc:	e9 47 fc ff ff       	jmp    800928 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ce1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ce2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ce5:	5b                   	pop    %ebx
  800ce6:	5e                   	pop    %esi
  800ce7:	5d                   	pop    %ebp
  800ce8:	c3                   	ret    

00800ce9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ce9:	55                   	push   %ebp
  800cea:	89 e5                	mov    %esp,%ebp
  800cec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cef:	8d 45 10             	lea    0x10(%ebp),%eax
  800cf2:	83 c0 04             	add    $0x4,%eax
  800cf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cf8:	8b 45 10             	mov    0x10(%ebp),%eax
  800cfb:	ff 75 f4             	pushl  -0xc(%ebp)
  800cfe:	50                   	push   %eax
  800cff:	ff 75 0c             	pushl  0xc(%ebp)
  800d02:	ff 75 08             	pushl  0x8(%ebp)
  800d05:	e8 16 fc ff ff       	call   800920 <vprintfmt>
  800d0a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d0d:	90                   	nop
  800d0e:	c9                   	leave  
  800d0f:	c3                   	ret    

00800d10 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d10:	55                   	push   %ebp
  800d11:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d16:	8b 40 08             	mov    0x8(%eax),%eax
  800d19:	8d 50 01             	lea    0x1(%eax),%edx
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	8b 10                	mov    (%eax),%edx
  800d27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2a:	8b 40 04             	mov    0x4(%eax),%eax
  800d2d:	39 c2                	cmp    %eax,%edx
  800d2f:	73 12                	jae    800d43 <sprintputch+0x33>
		*b->buf++ = ch;
  800d31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d34:	8b 00                	mov    (%eax),%eax
  800d36:	8d 48 01             	lea    0x1(%eax),%ecx
  800d39:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d3c:	89 0a                	mov    %ecx,(%edx)
  800d3e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d41:	88 10                	mov    %dl,(%eax)
}
  800d43:	90                   	nop
  800d44:	5d                   	pop    %ebp
  800d45:	c3                   	ret    

00800d46 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d46:	55                   	push   %ebp
  800d47:	89 e5                	mov    %esp,%ebp
  800d49:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	01 d0                	add    %edx,%eax
  800d5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d67:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d6b:	74 06                	je     800d73 <vsnprintf+0x2d>
  800d6d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d71:	7f 07                	jg     800d7a <vsnprintf+0x34>
		return -E_INVAL;
  800d73:	b8 03 00 00 00       	mov    $0x3,%eax
  800d78:	eb 20                	jmp    800d9a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d7a:	ff 75 14             	pushl  0x14(%ebp)
  800d7d:	ff 75 10             	pushl  0x10(%ebp)
  800d80:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d83:	50                   	push   %eax
  800d84:	68 10 0d 80 00       	push   $0x800d10
  800d89:	e8 92 fb ff ff       	call   800920 <vprintfmt>
  800d8e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d91:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d94:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d97:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d9a:	c9                   	leave  
  800d9b:	c3                   	ret    

00800d9c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d9c:	55                   	push   %ebp
  800d9d:	89 e5                	mov    %esp,%ebp
  800d9f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800da2:	8d 45 10             	lea    0x10(%ebp),%eax
  800da5:	83 c0 04             	add    $0x4,%eax
  800da8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dab:	8b 45 10             	mov    0x10(%ebp),%eax
  800dae:	ff 75 f4             	pushl  -0xc(%ebp)
  800db1:	50                   	push   %eax
  800db2:	ff 75 0c             	pushl  0xc(%ebp)
  800db5:	ff 75 08             	pushl  0x8(%ebp)
  800db8:	e8 89 ff ff ff       	call   800d46 <vsnprintf>
  800dbd:	83 c4 10             	add    $0x10,%esp
  800dc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dc6:	c9                   	leave  
  800dc7:	c3                   	ret    

00800dc8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dc8:	55                   	push   %ebp
  800dc9:	89 e5                	mov    %esp,%ebp
  800dcb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800dce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dd5:	eb 06                	jmp    800ddd <strlen+0x15>
		n++;
  800dd7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dda:	ff 45 08             	incl   0x8(%ebp)
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	84 c0                	test   %al,%al
  800de4:	75 f1                	jne    800dd7 <strlen+0xf>
		n++;
	return n;
  800de6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800df1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df8:	eb 09                	jmp    800e03 <strnlen+0x18>
		n++;
  800dfa:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dfd:	ff 45 08             	incl   0x8(%ebp)
  800e00:	ff 4d 0c             	decl   0xc(%ebp)
  800e03:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e07:	74 09                	je     800e12 <strnlen+0x27>
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	84 c0                	test   %al,%al
  800e10:	75 e8                	jne    800dfa <strnlen+0xf>
		n++;
	return n;
  800e12:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e15:	c9                   	leave  
  800e16:	c3                   	ret    

00800e17 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e17:	55                   	push   %ebp
  800e18:	89 e5                	mov    %esp,%ebp
  800e1a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e23:	90                   	nop
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	8d 50 01             	lea    0x1(%eax),%edx
  800e2a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e30:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e33:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e36:	8a 12                	mov    (%edx),%dl
  800e38:	88 10                	mov    %dl,(%eax)
  800e3a:	8a 00                	mov    (%eax),%al
  800e3c:	84 c0                	test   %al,%al
  800e3e:	75 e4                	jne    800e24 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e40:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e43:	c9                   	leave  
  800e44:	c3                   	ret    

00800e45 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e45:	55                   	push   %ebp
  800e46:	89 e5                	mov    %esp,%ebp
  800e48:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e58:	eb 1f                	jmp    800e79 <strncpy+0x34>
		*dst++ = *src;
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8d 50 01             	lea    0x1(%eax),%edx
  800e60:	89 55 08             	mov    %edx,0x8(%ebp)
  800e63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e66:	8a 12                	mov    (%edx),%dl
  800e68:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6d:	8a 00                	mov    (%eax),%al
  800e6f:	84 c0                	test   %al,%al
  800e71:	74 03                	je     800e76 <strncpy+0x31>
			src++;
  800e73:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e76:	ff 45 fc             	incl   -0x4(%ebp)
  800e79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e7f:	72 d9                	jb     800e5a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e81:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e84:	c9                   	leave  
  800e85:	c3                   	ret    

00800e86 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e86:	55                   	push   %ebp
  800e87:	89 e5                	mov    %esp,%ebp
  800e89:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e96:	74 30                	je     800ec8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e98:	eb 16                	jmp    800eb0 <strlcpy+0x2a>
			*dst++ = *src++;
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8d 50 01             	lea    0x1(%eax),%edx
  800ea0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ea3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ea9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eac:	8a 12                	mov    (%edx),%dl
  800eae:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800eb0:	ff 4d 10             	decl   0x10(%ebp)
  800eb3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb7:	74 09                	je     800ec2 <strlcpy+0x3c>
  800eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebc:	8a 00                	mov    (%eax),%al
  800ebe:	84 c0                	test   %al,%al
  800ec0:	75 d8                	jne    800e9a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ec8:	8b 55 08             	mov    0x8(%ebp),%edx
  800ecb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ece:	29 c2                	sub    %eax,%edx
  800ed0:	89 d0                	mov    %edx,%eax
}
  800ed2:	c9                   	leave  
  800ed3:	c3                   	ret    

00800ed4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ed4:	55                   	push   %ebp
  800ed5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ed7:	eb 06                	jmp    800edf <strcmp+0xb>
		p++, q++;
  800ed9:	ff 45 08             	incl   0x8(%ebp)
  800edc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	84 c0                	test   %al,%al
  800ee6:	74 0e                	je     800ef6 <strcmp+0x22>
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8a 10                	mov    (%eax),%dl
  800eed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	38 c2                	cmp    %al,%dl
  800ef4:	74 e3                	je     800ed9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	0f b6 d0             	movzbl %al,%edx
  800efe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	0f b6 c0             	movzbl %al,%eax
  800f06:	29 c2                	sub    %eax,%edx
  800f08:	89 d0                	mov    %edx,%eax
}
  800f0a:	5d                   	pop    %ebp
  800f0b:	c3                   	ret    

00800f0c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f0c:	55                   	push   %ebp
  800f0d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f0f:	eb 09                	jmp    800f1a <strncmp+0xe>
		n--, p++, q++;
  800f11:	ff 4d 10             	decl   0x10(%ebp)
  800f14:	ff 45 08             	incl   0x8(%ebp)
  800f17:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f1e:	74 17                	je     800f37 <strncmp+0x2b>
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	84 c0                	test   %al,%al
  800f27:	74 0e                	je     800f37 <strncmp+0x2b>
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	8a 10                	mov    (%eax),%dl
  800f2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	38 c2                	cmp    %al,%dl
  800f35:	74 da                	je     800f11 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3b:	75 07                	jne    800f44 <strncmp+0x38>
		return 0;
  800f3d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f42:	eb 14                	jmp    800f58 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	0f b6 d0             	movzbl %al,%edx
  800f4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	0f b6 c0             	movzbl %al,%eax
  800f54:	29 c2                	sub    %eax,%edx
  800f56:	89 d0                	mov    %edx,%eax
}
  800f58:	5d                   	pop    %ebp
  800f59:	c3                   	ret    

00800f5a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f5a:	55                   	push   %ebp
  800f5b:	89 e5                	mov    %esp,%ebp
  800f5d:	83 ec 04             	sub    $0x4,%esp
  800f60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f63:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f66:	eb 12                	jmp    800f7a <strchr+0x20>
		if (*s == c)
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f70:	75 05                	jne    800f77 <strchr+0x1d>
			return (char *) s;
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	eb 11                	jmp    800f88 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f77:	ff 45 08             	incl   0x8(%ebp)
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	84 c0                	test   %al,%al
  800f81:	75 e5                	jne    800f68 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f88:	c9                   	leave  
  800f89:	c3                   	ret    

00800f8a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f8a:	55                   	push   %ebp
  800f8b:	89 e5                	mov    %esp,%ebp
  800f8d:	83 ec 04             	sub    $0x4,%esp
  800f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f93:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f96:	eb 0d                	jmp    800fa5 <strfind+0x1b>
		if (*s == c)
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fa0:	74 0e                	je     800fb0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fa2:	ff 45 08             	incl   0x8(%ebp)
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	84 c0                	test   %al,%al
  800fac:	75 ea                	jne    800f98 <strfind+0xe>
  800fae:	eb 01                	jmp    800fb1 <strfind+0x27>
		if (*s == c)
			break;
  800fb0:	90                   	nop
	return (char *) s;
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb4:	c9                   	leave  
  800fb5:	c3                   	ret    

00800fb6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fb6:	55                   	push   %ebp
  800fb7:	89 e5                	mov    %esp,%ebp
  800fb9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fc8:	eb 0e                	jmp    800fd8 <memset+0x22>
		*p++ = c;
  800fca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fcd:	8d 50 01             	lea    0x1(%eax),%edx
  800fd0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fd6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fd8:	ff 4d f8             	decl   -0x8(%ebp)
  800fdb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fdf:	79 e9                	jns    800fca <memset+0x14>
		*p++ = c;

	return v;
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe4:	c9                   	leave  
  800fe5:	c3                   	ret    

00800fe6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ff8:	eb 16                	jmp    801010 <memcpy+0x2a>
		*d++ = *s++;
  800ffa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffd:	8d 50 01             	lea    0x1(%eax),%edx
  801000:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801003:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801006:	8d 4a 01             	lea    0x1(%edx),%ecx
  801009:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80100c:	8a 12                	mov    (%edx),%dl
  80100e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801010:	8b 45 10             	mov    0x10(%ebp),%eax
  801013:	8d 50 ff             	lea    -0x1(%eax),%edx
  801016:	89 55 10             	mov    %edx,0x10(%ebp)
  801019:	85 c0                	test   %eax,%eax
  80101b:	75 dd                	jne    800ffa <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801020:	c9                   	leave  
  801021:	c3                   	ret    

00801022 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801022:	55                   	push   %ebp
  801023:	89 e5                	mov    %esp,%ebp
  801025:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801028:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801034:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801037:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80103a:	73 50                	jae    80108c <memmove+0x6a>
  80103c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80103f:	8b 45 10             	mov    0x10(%ebp),%eax
  801042:	01 d0                	add    %edx,%eax
  801044:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801047:	76 43                	jbe    80108c <memmove+0x6a>
		s += n;
  801049:	8b 45 10             	mov    0x10(%ebp),%eax
  80104c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80104f:	8b 45 10             	mov    0x10(%ebp),%eax
  801052:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801055:	eb 10                	jmp    801067 <memmove+0x45>
			*--d = *--s;
  801057:	ff 4d f8             	decl   -0x8(%ebp)
  80105a:	ff 4d fc             	decl   -0x4(%ebp)
  80105d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801060:	8a 10                	mov    (%eax),%dl
  801062:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801065:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801067:	8b 45 10             	mov    0x10(%ebp),%eax
  80106a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80106d:	89 55 10             	mov    %edx,0x10(%ebp)
  801070:	85 c0                	test   %eax,%eax
  801072:	75 e3                	jne    801057 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801074:	eb 23                	jmp    801099 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801076:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801079:	8d 50 01             	lea    0x1(%eax),%edx
  80107c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80107f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801082:	8d 4a 01             	lea    0x1(%edx),%ecx
  801085:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801088:	8a 12                	mov    (%edx),%dl
  80108a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80108c:	8b 45 10             	mov    0x10(%ebp),%eax
  80108f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801092:	89 55 10             	mov    %edx,0x10(%ebp)
  801095:	85 c0                	test   %eax,%eax
  801097:	75 dd                	jne    801076 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80109c:	c9                   	leave  
  80109d:	c3                   	ret    

0080109e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80109e:	55                   	push   %ebp
  80109f:	89 e5                	mov    %esp,%ebp
  8010a1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ad:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010b0:	eb 2a                	jmp    8010dc <memcmp+0x3e>
		if (*s1 != *s2)
  8010b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b5:	8a 10                	mov    (%eax),%dl
  8010b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ba:	8a 00                	mov    (%eax),%al
  8010bc:	38 c2                	cmp    %al,%dl
  8010be:	74 16                	je     8010d6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	0f b6 d0             	movzbl %al,%edx
  8010c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010cb:	8a 00                	mov    (%eax),%al
  8010cd:	0f b6 c0             	movzbl %al,%eax
  8010d0:	29 c2                	sub    %eax,%edx
  8010d2:	89 d0                	mov    %edx,%eax
  8010d4:	eb 18                	jmp    8010ee <memcmp+0x50>
		s1++, s2++;
  8010d6:	ff 45 fc             	incl   -0x4(%ebp)
  8010d9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010e5:	85 c0                	test   %eax,%eax
  8010e7:	75 c9                	jne    8010b2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010e9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010ee:	c9                   	leave  
  8010ef:	c3                   	ret    

008010f0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010f0:	55                   	push   %ebp
  8010f1:	89 e5                	mov    %esp,%ebp
  8010f3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010f6:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fc:	01 d0                	add    %edx,%eax
  8010fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801101:	eb 15                	jmp    801118 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	0f b6 d0             	movzbl %al,%edx
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	0f b6 c0             	movzbl %al,%eax
  801111:	39 c2                	cmp    %eax,%edx
  801113:	74 0d                	je     801122 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801115:	ff 45 08             	incl   0x8(%ebp)
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80111e:	72 e3                	jb     801103 <memfind+0x13>
  801120:	eb 01                	jmp    801123 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801122:	90                   	nop
	return (void *) s;
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801126:	c9                   	leave  
  801127:	c3                   	ret    

00801128 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
  80112b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80112e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801135:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80113c:	eb 03                	jmp    801141 <strtol+0x19>
		s++;
  80113e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	8a 00                	mov    (%eax),%al
  801146:	3c 20                	cmp    $0x20,%al
  801148:	74 f4                	je     80113e <strtol+0x16>
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	3c 09                	cmp    $0x9,%al
  801151:	74 eb                	je     80113e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	3c 2b                	cmp    $0x2b,%al
  80115a:	75 05                	jne    801161 <strtol+0x39>
		s++;
  80115c:	ff 45 08             	incl   0x8(%ebp)
  80115f:	eb 13                	jmp    801174 <strtol+0x4c>
	else if (*s == '-')
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	8a 00                	mov    (%eax),%al
  801166:	3c 2d                	cmp    $0x2d,%al
  801168:	75 0a                	jne    801174 <strtol+0x4c>
		s++, neg = 1;
  80116a:	ff 45 08             	incl   0x8(%ebp)
  80116d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801174:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801178:	74 06                	je     801180 <strtol+0x58>
  80117a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80117e:	75 20                	jne    8011a0 <strtol+0x78>
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	8a 00                	mov    (%eax),%al
  801185:	3c 30                	cmp    $0x30,%al
  801187:	75 17                	jne    8011a0 <strtol+0x78>
  801189:	8b 45 08             	mov    0x8(%ebp),%eax
  80118c:	40                   	inc    %eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	3c 78                	cmp    $0x78,%al
  801191:	75 0d                	jne    8011a0 <strtol+0x78>
		s += 2, base = 16;
  801193:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801197:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80119e:	eb 28                	jmp    8011c8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a4:	75 15                	jne    8011bb <strtol+0x93>
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	3c 30                	cmp    $0x30,%al
  8011ad:	75 0c                	jne    8011bb <strtol+0x93>
		s++, base = 8;
  8011af:	ff 45 08             	incl   0x8(%ebp)
  8011b2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011b9:	eb 0d                	jmp    8011c8 <strtol+0xa0>
	else if (base == 0)
  8011bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011bf:	75 07                	jne    8011c8 <strtol+0xa0>
		base = 10;
  8011c1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8a 00                	mov    (%eax),%al
  8011cd:	3c 2f                	cmp    $0x2f,%al
  8011cf:	7e 19                	jle    8011ea <strtol+0xc2>
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d4:	8a 00                	mov    (%eax),%al
  8011d6:	3c 39                	cmp    $0x39,%al
  8011d8:	7f 10                	jg     8011ea <strtol+0xc2>
			dig = *s - '0';
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	8a 00                	mov    (%eax),%al
  8011df:	0f be c0             	movsbl %al,%eax
  8011e2:	83 e8 30             	sub    $0x30,%eax
  8011e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011e8:	eb 42                	jmp    80122c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	8a 00                	mov    (%eax),%al
  8011ef:	3c 60                	cmp    $0x60,%al
  8011f1:	7e 19                	jle    80120c <strtol+0xe4>
  8011f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f6:	8a 00                	mov    (%eax),%al
  8011f8:	3c 7a                	cmp    $0x7a,%al
  8011fa:	7f 10                	jg     80120c <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	0f be c0             	movsbl %al,%eax
  801204:	83 e8 57             	sub    $0x57,%eax
  801207:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80120a:	eb 20                	jmp    80122c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	8a 00                	mov    (%eax),%al
  801211:	3c 40                	cmp    $0x40,%al
  801213:	7e 39                	jle    80124e <strtol+0x126>
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	8a 00                	mov    (%eax),%al
  80121a:	3c 5a                	cmp    $0x5a,%al
  80121c:	7f 30                	jg     80124e <strtol+0x126>
			dig = *s - 'A' + 10;
  80121e:	8b 45 08             	mov    0x8(%ebp),%eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	0f be c0             	movsbl %al,%eax
  801226:	83 e8 37             	sub    $0x37,%eax
  801229:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80122c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80122f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801232:	7d 19                	jge    80124d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801234:	ff 45 08             	incl   0x8(%ebp)
  801237:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80123e:	89 c2                	mov    %eax,%edx
  801240:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801243:	01 d0                	add    %edx,%eax
  801245:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801248:	e9 7b ff ff ff       	jmp    8011c8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80124d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80124e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801252:	74 08                	je     80125c <strtol+0x134>
		*endptr = (char *) s;
  801254:	8b 45 0c             	mov    0xc(%ebp),%eax
  801257:	8b 55 08             	mov    0x8(%ebp),%edx
  80125a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80125c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801260:	74 07                	je     801269 <strtol+0x141>
  801262:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801265:	f7 d8                	neg    %eax
  801267:	eb 03                	jmp    80126c <strtol+0x144>
  801269:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <ltostr>:

void
ltostr(long value, char *str)
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
  801271:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801274:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80127b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801282:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801286:	79 13                	jns    80129b <ltostr+0x2d>
	{
		neg = 1;
  801288:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80128f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801292:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801295:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801298:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012a3:	99                   	cltd   
  8012a4:	f7 f9                	idiv   %ecx
  8012a6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ac:	8d 50 01             	lea    0x1(%eax),%edx
  8012af:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b2:	89 c2                	mov    %eax,%edx
  8012b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b7:	01 d0                	add    %edx,%eax
  8012b9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012bc:	83 c2 30             	add    $0x30,%edx
  8012bf:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012c4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012c9:	f7 e9                	imul   %ecx
  8012cb:	c1 fa 02             	sar    $0x2,%edx
  8012ce:	89 c8                	mov    %ecx,%eax
  8012d0:	c1 f8 1f             	sar    $0x1f,%eax
  8012d3:	29 c2                	sub    %eax,%edx
  8012d5:	89 d0                	mov    %edx,%eax
  8012d7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012da:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012dd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012e2:	f7 e9                	imul   %ecx
  8012e4:	c1 fa 02             	sar    $0x2,%edx
  8012e7:	89 c8                	mov    %ecx,%eax
  8012e9:	c1 f8 1f             	sar    $0x1f,%eax
  8012ec:	29 c2                	sub    %eax,%edx
  8012ee:	89 d0                	mov    %edx,%eax
  8012f0:	c1 e0 02             	shl    $0x2,%eax
  8012f3:	01 d0                	add    %edx,%eax
  8012f5:	01 c0                	add    %eax,%eax
  8012f7:	29 c1                	sub    %eax,%ecx
  8012f9:	89 ca                	mov    %ecx,%edx
  8012fb:	85 d2                	test   %edx,%edx
  8012fd:	75 9c                	jne    80129b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801306:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801309:	48                   	dec    %eax
  80130a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80130d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801311:	74 3d                	je     801350 <ltostr+0xe2>
		start = 1 ;
  801313:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80131a:	eb 34                	jmp    801350 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80131c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80131f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801322:	01 d0                	add    %edx,%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801329:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80132c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132f:	01 c2                	add    %eax,%edx
  801331:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801334:	8b 45 0c             	mov    0xc(%ebp),%eax
  801337:	01 c8                	add    %ecx,%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80133d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801340:	8b 45 0c             	mov    0xc(%ebp),%eax
  801343:	01 c2                	add    %eax,%edx
  801345:	8a 45 eb             	mov    -0x15(%ebp),%al
  801348:	88 02                	mov    %al,(%edx)
		start++ ;
  80134a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80134d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801350:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801353:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801356:	7c c4                	jl     80131c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801358:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80135b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135e:	01 d0                	add    %edx,%eax
  801360:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801363:	90                   	nop
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
  801369:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80136c:	ff 75 08             	pushl  0x8(%ebp)
  80136f:	e8 54 fa ff ff       	call   800dc8 <strlen>
  801374:	83 c4 04             	add    $0x4,%esp
  801377:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80137a:	ff 75 0c             	pushl  0xc(%ebp)
  80137d:	e8 46 fa ff ff       	call   800dc8 <strlen>
  801382:	83 c4 04             	add    $0x4,%esp
  801385:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80138f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801396:	eb 17                	jmp    8013af <strcconcat+0x49>
		final[s] = str1[s] ;
  801398:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80139b:	8b 45 10             	mov    0x10(%ebp),%eax
  80139e:	01 c2                	add    %eax,%edx
  8013a0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a6:	01 c8                	add    %ecx,%eax
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013ac:	ff 45 fc             	incl   -0x4(%ebp)
  8013af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013b5:	7c e1                	jl     801398 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013be:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013c5:	eb 1f                	jmp    8013e6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ca:	8d 50 01             	lea    0x1(%eax),%edx
  8013cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013d0:	89 c2                	mov    %eax,%edx
  8013d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d5:	01 c2                	add    %eax,%edx
  8013d7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dd:	01 c8                	add    %ecx,%eax
  8013df:	8a 00                	mov    (%eax),%al
  8013e1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013e3:	ff 45 f8             	incl   -0x8(%ebp)
  8013e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013ec:	7c d9                	jl     8013c7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f4:	01 d0                	add    %edx,%eax
  8013f6:	c6 00 00             	movb   $0x0,(%eax)
}
  8013f9:	90                   	nop
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801402:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801408:	8b 45 14             	mov    0x14(%ebp),%eax
  80140b:	8b 00                	mov    (%eax),%eax
  80140d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801414:	8b 45 10             	mov    0x10(%ebp),%eax
  801417:	01 d0                	add    %edx,%eax
  801419:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80141f:	eb 0c                	jmp    80142d <strsplit+0x31>
			*string++ = 0;
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8d 50 01             	lea    0x1(%eax),%edx
  801427:	89 55 08             	mov    %edx,0x8(%ebp)
  80142a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	84 c0                	test   %al,%al
  801434:	74 18                	je     80144e <strsplit+0x52>
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	8a 00                	mov    (%eax),%al
  80143b:	0f be c0             	movsbl %al,%eax
  80143e:	50                   	push   %eax
  80143f:	ff 75 0c             	pushl  0xc(%ebp)
  801442:	e8 13 fb ff ff       	call   800f5a <strchr>
  801447:	83 c4 08             	add    $0x8,%esp
  80144a:	85 c0                	test   %eax,%eax
  80144c:	75 d3                	jne    801421 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	84 c0                	test   %al,%al
  801455:	74 5a                	je     8014b1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801457:	8b 45 14             	mov    0x14(%ebp),%eax
  80145a:	8b 00                	mov    (%eax),%eax
  80145c:	83 f8 0f             	cmp    $0xf,%eax
  80145f:	75 07                	jne    801468 <strsplit+0x6c>
		{
			return 0;
  801461:	b8 00 00 00 00       	mov    $0x0,%eax
  801466:	eb 66                	jmp    8014ce <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801468:	8b 45 14             	mov    0x14(%ebp),%eax
  80146b:	8b 00                	mov    (%eax),%eax
  80146d:	8d 48 01             	lea    0x1(%eax),%ecx
  801470:	8b 55 14             	mov    0x14(%ebp),%edx
  801473:	89 0a                	mov    %ecx,(%edx)
  801475:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147c:	8b 45 10             	mov    0x10(%ebp),%eax
  80147f:	01 c2                	add    %eax,%edx
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801486:	eb 03                	jmp    80148b <strsplit+0x8f>
			string++;
  801488:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	8a 00                	mov    (%eax),%al
  801490:	84 c0                	test   %al,%al
  801492:	74 8b                	je     80141f <strsplit+0x23>
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	8a 00                	mov    (%eax),%al
  801499:	0f be c0             	movsbl %al,%eax
  80149c:	50                   	push   %eax
  80149d:	ff 75 0c             	pushl  0xc(%ebp)
  8014a0:	e8 b5 fa ff ff       	call   800f5a <strchr>
  8014a5:	83 c4 08             	add    $0x8,%esp
  8014a8:	85 c0                	test   %eax,%eax
  8014aa:	74 dc                	je     801488 <strsplit+0x8c>
			string++;
	}
  8014ac:	e9 6e ff ff ff       	jmp    80141f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014b1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b5:	8b 00                	mov    (%eax),%eax
  8014b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014be:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c1:	01 d0                	add    %edx,%eax
  8014c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014c9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
  8014d3:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	c1 e8 0c             	shr    $0xc,%eax
  8014dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e2:	25 ff 0f 00 00       	and    $0xfff,%eax
  8014e7:	85 c0                	test   %eax,%eax
  8014e9:	74 03                	je     8014ee <malloc+0x1e>
		num++;
  8014eb:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  8014ee:	a1 28 30 80 00       	mov    0x803028,%eax
  8014f3:	85 c0                	test   %eax,%eax
  8014f5:	75 71                	jne    801568 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  8014f7:	a1 04 30 80 00       	mov    0x803004,%eax
  8014fc:	83 ec 08             	sub    $0x8,%esp
  8014ff:	ff 75 08             	pushl  0x8(%ebp)
  801502:	50                   	push   %eax
  801503:	e8 e4 04 00 00       	call   8019ec <sys_allocateMem>
  801508:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  80150b:	a1 04 30 80 00       	mov    0x803004,%eax
  801510:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801513:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801516:	c1 e0 0c             	shl    $0xc,%eax
  801519:	89 c2                	mov    %eax,%edx
  80151b:	a1 04 30 80 00       	mov    0x803004,%eax
  801520:	01 d0                	add    %edx,%eax
  801522:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801527:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80152c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80152f:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801536:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80153b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80153e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801545:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80154a:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801551:	01 00 00 00 
		sizeofarray++;
  801555:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80155a:	40                   	inc    %eax
  80155b:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  801560:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801563:	e9 f7 00 00 00       	jmp    80165f <malloc+0x18f>
	} else {
		int count = 0;
  801568:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  80156f:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801576:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80157d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801584:	eb 7c                	jmp    801602 <malloc+0x132>
		{
			uint32 *pg = NULL;
  801586:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  80158d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801594:	eb 1a                	jmp    8015b0 <malloc+0xe0>
				if (addresses[j] == i) {
  801596:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801599:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015a0:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8015a3:	75 08                	jne    8015ad <malloc+0xdd>
					index = j;
  8015a5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  8015ab:	eb 0d                	jmp    8015ba <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  8015ad:	ff 45 dc             	incl   -0x24(%ebp)
  8015b0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015b5:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8015b8:	7c dc                	jl     801596 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  8015ba:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8015be:	75 05                	jne    8015c5 <malloc+0xf5>
				count++;
  8015c0:	ff 45 f0             	incl   -0x10(%ebp)
  8015c3:	eb 36                	jmp    8015fb <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  8015c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015c8:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8015cf:	85 c0                	test   %eax,%eax
  8015d1:	75 05                	jne    8015d8 <malloc+0x108>
					count++;
  8015d3:	ff 45 f0             	incl   -0x10(%ebp)
  8015d6:	eb 23                	jmp    8015fb <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  8015d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015db:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8015de:	7d 14                	jge    8015f4 <malloc+0x124>
  8015e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015e6:	7c 0c                	jl     8015f4 <malloc+0x124>
						min = count;
  8015e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  8015ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  8015f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  8015fb:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801602:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801609:	0f 86 77 ff ff ff    	jbe    801586 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  80160f:	83 ec 08             	sub    $0x8,%esp
  801612:	ff 75 08             	pushl  0x8(%ebp)
  801615:	ff 75 e4             	pushl  -0x1c(%ebp)
  801618:	e8 cf 03 00 00       	call   8019ec <sys_allocateMem>
  80161d:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  801620:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801625:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801628:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  80162f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801634:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80163a:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801641:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801646:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80164d:	01 00 00 00 
		sizeofarray++;
  801651:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801656:	40                   	inc    %eax
  801657:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) min_addresss;
  80165c:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  80166d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801674:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80167b:	eb 30                	jmp    8016ad <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  80167d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801680:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801687:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80168a:	75 1e                	jne    8016aa <free+0x49>
  80168c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80168f:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801696:	83 f8 01             	cmp    $0x1,%eax
  801699:	75 0f                	jne    8016aa <free+0x49>
			is_found = 1;
  80169b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8016a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8016a8:	eb 0d                	jmp    8016b7 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8016aa:	ff 45 ec             	incl   -0x14(%ebp)
  8016ad:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016b2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8016b5:	7c c6                	jl     80167d <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8016b7:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8016bb:	75 4f                	jne    80170c <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  8016bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016c0:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8016c7:	c1 e0 0c             	shl    $0xc,%eax
  8016ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  8016cd:	83 ec 08             	sub    $0x8,%esp
  8016d0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016d3:	68 70 27 80 00       	push   $0x802770
  8016d8:	e8 69 f0 ff ff       	call   800746 <cprintf>
  8016dd:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  8016e0:	83 ec 08             	sub    $0x8,%esp
  8016e3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8016e9:	e8 e2 02 00 00       	call   8019d0 <sys_freeMem>
  8016ee:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  8016f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f4:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  8016fb:	00 00 00 00 
		changes++;
  8016ff:	a1 28 30 80 00       	mov    0x803028,%eax
  801704:	40                   	inc    %eax
  801705:	a3 28 30 80 00       	mov    %eax,0x803028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  80170a:	eb 39                	jmp    801745 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  80170c:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801713:	83 ec 08             	sub    $0x8,%esp
  801716:	ff 75 e4             	pushl  -0x1c(%ebp)
  801719:	68 70 27 80 00       	push   $0x802770
  80171e:	e8 23 f0 ff ff       	call   800746 <cprintf>
  801723:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801726:	83 ec 08             	sub    $0x8,%esp
  801729:	ff 75 e4             	pushl  -0x1c(%ebp)
  80172c:	ff 75 e8             	pushl  -0x18(%ebp)
  80172f:	e8 9c 02 00 00       	call   8019d0 <sys_freeMem>
  801734:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801737:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80173a:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801741:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801745:	90                   	nop
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
  80174b:	83 ec 18             	sub    $0x18,%esp
  80174e:	8b 45 10             	mov    0x10(%ebp),%eax
  801751:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801754:	83 ec 04             	sub    $0x4,%esp
  801757:	68 90 27 80 00       	push   $0x802790
  80175c:	68 9d 00 00 00       	push   $0x9d
  801761:	68 b3 27 80 00       	push   $0x8027b3
  801766:	e8 0b 07 00 00       	call   801e76 <_panic>

0080176b <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  80176b:	55                   	push   %ebp
  80176c:	89 e5                	mov    %esp,%ebp
  80176e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801771:	83 ec 04             	sub    $0x4,%esp
  801774:	68 90 27 80 00       	push   $0x802790
  801779:	68 a2 00 00 00       	push   $0xa2
  80177e:	68 b3 27 80 00       	push   $0x8027b3
  801783:	e8 ee 06 00 00       	call   801e76 <_panic>

00801788 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801788:	55                   	push   %ebp
  801789:	89 e5                	mov    %esp,%ebp
  80178b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80178e:	83 ec 04             	sub    $0x4,%esp
  801791:	68 90 27 80 00       	push   $0x802790
  801796:	68 a7 00 00 00       	push   $0xa7
  80179b:	68 b3 27 80 00       	push   $0x8027b3
  8017a0:	e8 d1 06 00 00       	call   801e76 <_panic>

008017a5 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
  8017a8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017ab:	83 ec 04             	sub    $0x4,%esp
  8017ae:	68 90 27 80 00       	push   $0x802790
  8017b3:	68 ab 00 00 00       	push   $0xab
  8017b8:	68 b3 27 80 00       	push   $0x8027b3
  8017bd:	e8 b4 06 00 00       	call   801e76 <_panic>

008017c2 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
  8017c5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017c8:	83 ec 04             	sub    $0x4,%esp
  8017cb:	68 90 27 80 00       	push   $0x802790
  8017d0:	68 b0 00 00 00       	push   $0xb0
  8017d5:	68 b3 27 80 00       	push   $0x8027b3
  8017da:	e8 97 06 00 00       	call   801e76 <_panic>

008017df <shrink>:
}
void shrink(uint32 newSize) {
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
  8017e2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017e5:	83 ec 04             	sub    $0x4,%esp
  8017e8:	68 90 27 80 00       	push   $0x802790
  8017ed:	68 b3 00 00 00       	push   $0xb3
  8017f2:	68 b3 27 80 00       	push   $0x8027b3
  8017f7:	e8 7a 06 00 00       	call   801e76 <_panic>

008017fc <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8017fc:	55                   	push   %ebp
  8017fd:	89 e5                	mov    %esp,%ebp
  8017ff:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801802:	83 ec 04             	sub    $0x4,%esp
  801805:	68 90 27 80 00       	push   $0x802790
  80180a:	68 b7 00 00 00       	push   $0xb7
  80180f:	68 b3 27 80 00       	push   $0x8027b3
  801814:	e8 5d 06 00 00       	call   801e76 <_panic>

00801819 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
  80181c:	57                   	push   %edi
  80181d:	56                   	push   %esi
  80181e:	53                   	push   %ebx
  80181f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801822:	8b 45 08             	mov    0x8(%ebp),%eax
  801825:	8b 55 0c             	mov    0xc(%ebp),%edx
  801828:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80182b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80182e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801831:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801834:	cd 30                	int    $0x30
  801836:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801839:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80183c:	83 c4 10             	add    $0x10,%esp
  80183f:	5b                   	pop    %ebx
  801840:	5e                   	pop    %esi
  801841:	5f                   	pop    %edi
  801842:	5d                   	pop    %ebp
  801843:	c3                   	ret    

00801844 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801844:	55                   	push   %ebp
  801845:	89 e5                	mov    %esp,%ebp
  801847:	83 ec 04             	sub    $0x4,%esp
  80184a:	8b 45 10             	mov    0x10(%ebp),%eax
  80184d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801850:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	52                   	push   %edx
  80185c:	ff 75 0c             	pushl  0xc(%ebp)
  80185f:	50                   	push   %eax
  801860:	6a 00                	push   $0x0
  801862:	e8 b2 ff ff ff       	call   801819 <syscall>
  801867:	83 c4 18             	add    $0x18,%esp
}
  80186a:	90                   	nop
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_cgetc>:

int
sys_cgetc(void)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 01                	push   $0x1
  80187c:	e8 98 ff ff ff       	call   801819 <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801889:	8b 45 08             	mov    0x8(%ebp),%eax
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	50                   	push   %eax
  801895:	6a 05                	push   $0x5
  801897:	e8 7d ff ff ff       	call   801819 <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
}
  80189f:	c9                   	leave  
  8018a0:	c3                   	ret    

008018a1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 02                	push   $0x2
  8018b0:	e8 64 ff ff ff       	call   801819 <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
}
  8018b8:	c9                   	leave  
  8018b9:	c3                   	ret    

008018ba <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018ba:	55                   	push   %ebp
  8018bb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 03                	push   $0x3
  8018c9:	e8 4b ff ff ff       	call   801819 <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 04                	push   $0x4
  8018e2:	e8 32 ff ff ff       	call   801819 <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_env_exit>:


void sys_env_exit(void)
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 06                	push   $0x6
  8018fb:	e8 19 ff ff ff       	call   801819 <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	90                   	nop
  801904:	c9                   	leave  
  801905:	c3                   	ret    

00801906 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801906:	55                   	push   %ebp
  801907:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801909:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190c:	8b 45 08             	mov    0x8(%ebp),%eax
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	52                   	push   %edx
  801916:	50                   	push   %eax
  801917:	6a 07                	push   $0x7
  801919:	e8 fb fe ff ff       	call   801819 <syscall>
  80191e:	83 c4 18             	add    $0x18,%esp
}
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
  801926:	56                   	push   %esi
  801927:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801928:	8b 75 18             	mov    0x18(%ebp),%esi
  80192b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80192e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801931:	8b 55 0c             	mov    0xc(%ebp),%edx
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	56                   	push   %esi
  801938:	53                   	push   %ebx
  801939:	51                   	push   %ecx
  80193a:	52                   	push   %edx
  80193b:	50                   	push   %eax
  80193c:	6a 08                	push   $0x8
  80193e:	e8 d6 fe ff ff       	call   801819 <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801949:	5b                   	pop    %ebx
  80194a:	5e                   	pop    %esi
  80194b:	5d                   	pop    %ebp
  80194c:	c3                   	ret    

0080194d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801950:	8b 55 0c             	mov    0xc(%ebp),%edx
  801953:	8b 45 08             	mov    0x8(%ebp),%eax
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	52                   	push   %edx
  80195d:	50                   	push   %eax
  80195e:	6a 09                	push   $0x9
  801960:	e8 b4 fe ff ff       	call   801819 <syscall>
  801965:	83 c4 18             	add    $0x18,%esp
}
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	ff 75 0c             	pushl  0xc(%ebp)
  801976:	ff 75 08             	pushl  0x8(%ebp)
  801979:	6a 0a                	push   $0xa
  80197b:	e8 99 fe ff ff       	call   801819 <syscall>
  801980:	83 c4 18             	add    $0x18,%esp
}
  801983:	c9                   	leave  
  801984:	c3                   	ret    

00801985 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801985:	55                   	push   %ebp
  801986:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 0b                	push   $0xb
  801994:	e8 80 fe ff ff       	call   801819 <syscall>
  801999:	83 c4 18             	add    $0x18,%esp
}
  80199c:	c9                   	leave  
  80199d:	c3                   	ret    

0080199e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80199e:	55                   	push   %ebp
  80199f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 0c                	push   $0xc
  8019ad:	e8 67 fe ff ff       	call   801819 <syscall>
  8019b2:	83 c4 18             	add    $0x18,%esp
}
  8019b5:	c9                   	leave  
  8019b6:	c3                   	ret    

008019b7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019b7:	55                   	push   %ebp
  8019b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 0d                	push   $0xd
  8019c6:	e8 4e fe ff ff       	call   801819 <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
}
  8019ce:	c9                   	leave  
  8019cf:	c3                   	ret    

008019d0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	ff 75 0c             	pushl  0xc(%ebp)
  8019dc:	ff 75 08             	pushl  0x8(%ebp)
  8019df:	6a 11                	push   $0x11
  8019e1:	e8 33 fe ff ff       	call   801819 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
	return;
  8019e9:	90                   	nop
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	ff 75 0c             	pushl  0xc(%ebp)
  8019f8:	ff 75 08             	pushl  0x8(%ebp)
  8019fb:	6a 12                	push   $0x12
  8019fd:	e8 17 fe ff ff       	call   801819 <syscall>
  801a02:	83 c4 18             	add    $0x18,%esp
	return ;
  801a05:	90                   	nop
}
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 0e                	push   $0xe
  801a17:	e8 fd fd ff ff       	call   801819 <syscall>
  801a1c:	83 c4 18             	add    $0x18,%esp
}
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    

00801a21 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a21:	55                   	push   %ebp
  801a22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	ff 75 08             	pushl  0x8(%ebp)
  801a2f:	6a 0f                	push   $0xf
  801a31:	e8 e3 fd ff ff       	call   801819 <syscall>
  801a36:	83 c4 18             	add    $0x18,%esp
}
  801a39:	c9                   	leave  
  801a3a:	c3                   	ret    

00801a3b <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a3b:	55                   	push   %ebp
  801a3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 10                	push   $0x10
  801a4a:	e8 ca fd ff ff       	call   801819 <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
}
  801a52:	90                   	nop
  801a53:	c9                   	leave  
  801a54:	c3                   	ret    

00801a55 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 14                	push   $0x14
  801a64:	e8 b0 fd ff ff       	call   801819 <syscall>
  801a69:	83 c4 18             	add    $0x18,%esp
}
  801a6c:	90                   	nop
  801a6d:	c9                   	leave  
  801a6e:	c3                   	ret    

00801a6f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 15                	push   $0x15
  801a7e:	e8 96 fd ff ff       	call   801819 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	90                   	nop
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
  801a8c:	83 ec 04             	sub    $0x4,%esp
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a92:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a95:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	50                   	push   %eax
  801aa2:	6a 16                	push   $0x16
  801aa4:	e8 70 fd ff ff       	call   801819 <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
}
  801aac:	90                   	nop
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 17                	push   $0x17
  801abe:	e8 56 fd ff ff       	call   801819 <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
}
  801ac6:	90                   	nop
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801acc:	8b 45 08             	mov    0x8(%ebp),%eax
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	ff 75 0c             	pushl  0xc(%ebp)
  801ad8:	50                   	push   %eax
  801ad9:	6a 18                	push   $0x18
  801adb:	e8 39 fd ff ff       	call   801819 <syscall>
  801ae0:	83 c4 18             	add    $0x18,%esp
}
  801ae3:	c9                   	leave  
  801ae4:	c3                   	ret    

00801ae5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ae5:	55                   	push   %ebp
  801ae6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	52                   	push   %edx
  801af5:	50                   	push   %eax
  801af6:	6a 1b                	push   $0x1b
  801af8:	e8 1c fd ff ff       	call   801819 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	c9                   	leave  
  801b01:	c3                   	ret    

00801b02 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b08:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	52                   	push   %edx
  801b12:	50                   	push   %eax
  801b13:	6a 19                	push   $0x19
  801b15:	e8 ff fc ff ff       	call   801819 <syscall>
  801b1a:	83 c4 18             	add    $0x18,%esp
}
  801b1d:	90                   	nop
  801b1e:	c9                   	leave  
  801b1f:	c3                   	ret    

00801b20 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b20:	55                   	push   %ebp
  801b21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b26:	8b 45 08             	mov    0x8(%ebp),%eax
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	52                   	push   %edx
  801b30:	50                   	push   %eax
  801b31:	6a 1a                	push   $0x1a
  801b33:	e8 e1 fc ff ff       	call   801819 <syscall>
  801b38:	83 c4 18             	add    $0x18,%esp
}
  801b3b:	90                   	nop
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    

00801b3e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
  801b41:	83 ec 04             	sub    $0x4,%esp
  801b44:	8b 45 10             	mov    0x10(%ebp),%eax
  801b47:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b4a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b4d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b51:	8b 45 08             	mov    0x8(%ebp),%eax
  801b54:	6a 00                	push   $0x0
  801b56:	51                   	push   %ecx
  801b57:	52                   	push   %edx
  801b58:	ff 75 0c             	pushl  0xc(%ebp)
  801b5b:	50                   	push   %eax
  801b5c:	6a 1c                	push   $0x1c
  801b5e:	e8 b6 fc ff ff       	call   801819 <syscall>
  801b63:	83 c4 18             	add    $0x18,%esp
}
  801b66:	c9                   	leave  
  801b67:	c3                   	ret    

00801b68 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b68:	55                   	push   %ebp
  801b69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	52                   	push   %edx
  801b78:	50                   	push   %eax
  801b79:	6a 1d                	push   $0x1d
  801b7b:	e8 99 fc ff ff       	call   801819 <syscall>
  801b80:	83 c4 18             	add    $0x18,%esp
}
  801b83:	c9                   	leave  
  801b84:	c3                   	ret    

00801b85 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b88:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	51                   	push   %ecx
  801b96:	52                   	push   %edx
  801b97:	50                   	push   %eax
  801b98:	6a 1e                	push   $0x1e
  801b9a:	e8 7a fc ff ff       	call   801819 <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
}
  801ba2:	c9                   	leave  
  801ba3:	c3                   	ret    

00801ba4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ba4:	55                   	push   %ebp
  801ba5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ba7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801baa:	8b 45 08             	mov    0x8(%ebp),%eax
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	52                   	push   %edx
  801bb4:	50                   	push   %eax
  801bb5:	6a 1f                	push   $0x1f
  801bb7:	e8 5d fc ff ff       	call   801819 <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
}
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 20                	push   $0x20
  801bd0:	e8 44 fc ff ff       	call   801819 <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
}
  801bd8:	c9                   	leave  
  801bd9:	c3                   	ret    

00801bda <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801be0:	6a 00                	push   $0x0
  801be2:	ff 75 14             	pushl  0x14(%ebp)
  801be5:	ff 75 10             	pushl  0x10(%ebp)
  801be8:	ff 75 0c             	pushl  0xc(%ebp)
  801beb:	50                   	push   %eax
  801bec:	6a 21                	push   $0x21
  801bee:	e8 26 fc ff ff       	call   801819 <syscall>
  801bf3:	83 c4 18             	add    $0x18,%esp
}
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	50                   	push   %eax
  801c07:	6a 22                	push   $0x22
  801c09:	e8 0b fc ff ff       	call   801819 <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	90                   	nop
  801c12:	c9                   	leave  
  801c13:	c3                   	ret    

00801c14 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c17:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	50                   	push   %eax
  801c23:	6a 23                	push   $0x23
  801c25:	e8 ef fb ff ff       	call   801819 <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
}
  801c2d:	90                   	nop
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
  801c33:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c36:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c39:	8d 50 04             	lea    0x4(%eax),%edx
  801c3c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	52                   	push   %edx
  801c46:	50                   	push   %eax
  801c47:	6a 24                	push   $0x24
  801c49:	e8 cb fb ff ff       	call   801819 <syscall>
  801c4e:	83 c4 18             	add    $0x18,%esp
	return result;
  801c51:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c57:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c5a:	89 01                	mov    %eax,(%ecx)
  801c5c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c62:	c9                   	leave  
  801c63:	c2 04 00             	ret    $0x4

00801c66 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	ff 75 10             	pushl  0x10(%ebp)
  801c70:	ff 75 0c             	pushl  0xc(%ebp)
  801c73:	ff 75 08             	pushl  0x8(%ebp)
  801c76:	6a 13                	push   $0x13
  801c78:	e8 9c fb ff ff       	call   801819 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c80:	90                   	nop
}
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 25                	push   $0x25
  801c92:	e8 82 fb ff ff       	call   801819 <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
}
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
  801c9f:	83 ec 04             	sub    $0x4,%esp
  801ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ca8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	50                   	push   %eax
  801cb5:	6a 26                	push   $0x26
  801cb7:	e8 5d fb ff ff       	call   801819 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
	return ;
  801cbf:	90                   	nop
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <rsttst>:
void rsttst()
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 28                	push   $0x28
  801cd1:	e8 43 fb ff ff       	call   801819 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
	return ;
  801cd9:	90                   	nop
}
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cdc:	55                   	push   %ebp
  801cdd:	89 e5                	mov    %esp,%ebp
  801cdf:	83 ec 04             	sub    $0x4,%esp
  801ce2:	8b 45 14             	mov    0x14(%ebp),%eax
  801ce5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ce8:	8b 55 18             	mov    0x18(%ebp),%edx
  801ceb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cef:	52                   	push   %edx
  801cf0:	50                   	push   %eax
  801cf1:	ff 75 10             	pushl  0x10(%ebp)
  801cf4:	ff 75 0c             	pushl  0xc(%ebp)
  801cf7:	ff 75 08             	pushl  0x8(%ebp)
  801cfa:	6a 27                	push   $0x27
  801cfc:	e8 18 fb ff ff       	call   801819 <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
	return ;
  801d04:	90                   	nop
}
  801d05:	c9                   	leave  
  801d06:	c3                   	ret    

00801d07 <chktst>:
void chktst(uint32 n)
{
  801d07:	55                   	push   %ebp
  801d08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	ff 75 08             	pushl  0x8(%ebp)
  801d15:	6a 29                	push   $0x29
  801d17:	e8 fd fa ff ff       	call   801819 <syscall>
  801d1c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d1f:	90                   	nop
}
  801d20:	c9                   	leave  
  801d21:	c3                   	ret    

00801d22 <inctst>:

void inctst()
{
  801d22:	55                   	push   %ebp
  801d23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 2a                	push   $0x2a
  801d31:	e8 e3 fa ff ff       	call   801819 <syscall>
  801d36:	83 c4 18             	add    $0x18,%esp
	return ;
  801d39:	90                   	nop
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <gettst>:
uint32 gettst()
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 2b                	push   $0x2b
  801d4b:	e8 c9 fa ff ff       	call   801819 <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
  801d58:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 2c                	push   $0x2c
  801d67:	e8 ad fa ff ff       	call   801819 <syscall>
  801d6c:	83 c4 18             	add    $0x18,%esp
  801d6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d72:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d76:	75 07                	jne    801d7f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d78:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7d:	eb 05                	jmp    801d84 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d84:	c9                   	leave  
  801d85:	c3                   	ret    

00801d86 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d86:	55                   	push   %ebp
  801d87:	89 e5                	mov    %esp,%ebp
  801d89:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 2c                	push   $0x2c
  801d98:	e8 7c fa ff ff       	call   801819 <syscall>
  801d9d:	83 c4 18             	add    $0x18,%esp
  801da0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801da3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801da7:	75 07                	jne    801db0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801da9:	b8 01 00 00 00       	mov    $0x1,%eax
  801dae:	eb 05                	jmp    801db5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801db0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
  801dba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 2c                	push   $0x2c
  801dc9:	e8 4b fa ff ff       	call   801819 <syscall>
  801dce:	83 c4 18             	add    $0x18,%esp
  801dd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801dd4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801dd8:	75 07                	jne    801de1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801dda:	b8 01 00 00 00       	mov    $0x1,%eax
  801ddf:	eb 05                	jmp    801de6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801de1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
  801deb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 2c                	push   $0x2c
  801dfa:	e8 1a fa ff ff       	call   801819 <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
  801e02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e05:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e09:	75 07                	jne    801e12 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e0b:	b8 01 00 00 00       	mov    $0x1,%eax
  801e10:	eb 05                	jmp    801e17 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e17:	c9                   	leave  
  801e18:	c3                   	ret    

00801e19 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e19:	55                   	push   %ebp
  801e1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	ff 75 08             	pushl  0x8(%ebp)
  801e27:	6a 2d                	push   $0x2d
  801e29:	e8 eb f9 ff ff       	call   801819 <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801e31:	90                   	nop
}
  801e32:	c9                   	leave  
  801e33:	c3                   	ret    

00801e34 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e34:	55                   	push   %ebp
  801e35:	89 e5                	mov    %esp,%ebp
  801e37:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e38:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e41:	8b 45 08             	mov    0x8(%ebp),%eax
  801e44:	6a 00                	push   $0x0
  801e46:	53                   	push   %ebx
  801e47:	51                   	push   %ecx
  801e48:	52                   	push   %edx
  801e49:	50                   	push   %eax
  801e4a:	6a 2e                	push   $0x2e
  801e4c:	e8 c8 f9 ff ff       	call   801819 <syscall>
  801e51:	83 c4 18             	add    $0x18,%esp
}
  801e54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e57:	c9                   	leave  
  801e58:	c3                   	ret    

00801e59 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e59:	55                   	push   %ebp
  801e5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	52                   	push   %edx
  801e69:	50                   	push   %eax
  801e6a:	6a 2f                	push   $0x2f
  801e6c:	e8 a8 f9 ff ff       	call   801819 <syscall>
  801e71:	83 c4 18             	add    $0x18,%esp
}
  801e74:	c9                   	leave  
  801e75:	c3                   	ret    

00801e76 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801e76:	55                   	push   %ebp
  801e77:	89 e5                	mov    %esp,%ebp
  801e79:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801e7c:	8d 45 10             	lea    0x10(%ebp),%eax
  801e7f:	83 c0 04             	add    $0x4,%eax
  801e82:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801e85:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801e8a:	85 c0                	test   %eax,%eax
  801e8c:	74 16                	je     801ea4 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801e8e:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801e93:	83 ec 08             	sub    $0x8,%esp
  801e96:	50                   	push   %eax
  801e97:	68 c0 27 80 00       	push   $0x8027c0
  801e9c:	e8 a5 e8 ff ff       	call   800746 <cprintf>
  801ea1:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801ea4:	a1 00 30 80 00       	mov    0x803000,%eax
  801ea9:	ff 75 0c             	pushl  0xc(%ebp)
  801eac:	ff 75 08             	pushl  0x8(%ebp)
  801eaf:	50                   	push   %eax
  801eb0:	68 c5 27 80 00       	push   $0x8027c5
  801eb5:	e8 8c e8 ff ff       	call   800746 <cprintf>
  801eba:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801ebd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ec0:	83 ec 08             	sub    $0x8,%esp
  801ec3:	ff 75 f4             	pushl  -0xc(%ebp)
  801ec6:	50                   	push   %eax
  801ec7:	e8 0f e8 ff ff       	call   8006db <vcprintf>
  801ecc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801ecf:	83 ec 08             	sub    $0x8,%esp
  801ed2:	6a 00                	push   $0x0
  801ed4:	68 e1 27 80 00       	push   $0x8027e1
  801ed9:	e8 fd e7 ff ff       	call   8006db <vcprintf>
  801ede:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801ee1:	e8 7e e7 ff ff       	call   800664 <exit>

	// should not return here
	while (1) ;
  801ee6:	eb fe                	jmp    801ee6 <_panic+0x70>

00801ee8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801ee8:	55                   	push   %ebp
  801ee9:	89 e5                	mov    %esp,%ebp
  801eeb:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801eee:	a1 20 30 80 00       	mov    0x803020,%eax
  801ef3:	8b 50 74             	mov    0x74(%eax),%edx
  801ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ef9:	39 c2                	cmp    %eax,%edx
  801efb:	74 14                	je     801f11 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801efd:	83 ec 04             	sub    $0x4,%esp
  801f00:	68 e4 27 80 00       	push   $0x8027e4
  801f05:	6a 26                	push   $0x26
  801f07:	68 30 28 80 00       	push   $0x802830
  801f0c:	e8 65 ff ff ff       	call   801e76 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801f11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801f18:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801f1f:	e9 b6 00 00 00       	jmp    801fda <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801f24:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f27:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f31:	01 d0                	add    %edx,%eax
  801f33:	8b 00                	mov    (%eax),%eax
  801f35:	85 c0                	test   %eax,%eax
  801f37:	75 08                	jne    801f41 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801f39:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801f3c:	e9 96 00 00 00       	jmp    801fd7 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801f41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f48:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801f4f:	eb 5d                	jmp    801fae <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801f51:	a1 20 30 80 00       	mov    0x803020,%eax
  801f56:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801f5c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f5f:	c1 e2 04             	shl    $0x4,%edx
  801f62:	01 d0                	add    %edx,%eax
  801f64:	8a 40 04             	mov    0x4(%eax),%al
  801f67:	84 c0                	test   %al,%al
  801f69:	75 40                	jne    801fab <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f6b:	a1 20 30 80 00       	mov    0x803020,%eax
  801f70:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801f76:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f79:	c1 e2 04             	shl    $0x4,%edx
  801f7c:	01 d0                	add    %edx,%eax
  801f7e:	8b 00                	mov    (%eax),%eax
  801f80:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801f83:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801f86:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801f8b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801f8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f90:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801f97:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9a:	01 c8                	add    %ecx,%eax
  801f9c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f9e:	39 c2                	cmp    %eax,%edx
  801fa0:	75 09                	jne    801fab <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801fa2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801fa9:	eb 12                	jmp    801fbd <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fab:	ff 45 e8             	incl   -0x18(%ebp)
  801fae:	a1 20 30 80 00       	mov    0x803020,%eax
  801fb3:	8b 50 74             	mov    0x74(%eax),%edx
  801fb6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801fb9:	39 c2                	cmp    %eax,%edx
  801fbb:	77 94                	ja     801f51 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801fbd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801fc1:	75 14                	jne    801fd7 <CheckWSWithoutLastIndex+0xef>
			panic(
  801fc3:	83 ec 04             	sub    $0x4,%esp
  801fc6:	68 3c 28 80 00       	push   $0x80283c
  801fcb:	6a 3a                	push   $0x3a
  801fcd:	68 30 28 80 00       	push   $0x802830
  801fd2:	e8 9f fe ff ff       	call   801e76 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801fd7:	ff 45 f0             	incl   -0x10(%ebp)
  801fda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fdd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801fe0:	0f 8c 3e ff ff ff    	jl     801f24 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801fe6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fed:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ff4:	eb 20                	jmp    802016 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ff6:	a1 20 30 80 00       	mov    0x803020,%eax
  801ffb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  802001:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802004:	c1 e2 04             	shl    $0x4,%edx
  802007:	01 d0                	add    %edx,%eax
  802009:	8a 40 04             	mov    0x4(%eax),%al
  80200c:	3c 01                	cmp    $0x1,%al
  80200e:	75 03                	jne    802013 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  802010:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802013:	ff 45 e0             	incl   -0x20(%ebp)
  802016:	a1 20 30 80 00       	mov    0x803020,%eax
  80201b:	8b 50 74             	mov    0x74(%eax),%edx
  80201e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802021:	39 c2                	cmp    %eax,%edx
  802023:	77 d1                	ja     801ff6 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802025:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802028:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80202b:	74 14                	je     802041 <CheckWSWithoutLastIndex+0x159>
		panic(
  80202d:	83 ec 04             	sub    $0x4,%esp
  802030:	68 90 28 80 00       	push   $0x802890
  802035:	6a 44                	push   $0x44
  802037:	68 30 28 80 00       	push   $0x802830
  80203c:	e8 35 fe ff ff       	call   801e76 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  802041:	90                   	nop
  802042:	c9                   	leave  
  802043:	c3                   	ret    

00802044 <__udivdi3>:
  802044:	55                   	push   %ebp
  802045:	57                   	push   %edi
  802046:	56                   	push   %esi
  802047:	53                   	push   %ebx
  802048:	83 ec 1c             	sub    $0x1c,%esp
  80204b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80204f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802053:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802057:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80205b:	89 ca                	mov    %ecx,%edx
  80205d:	89 f8                	mov    %edi,%eax
  80205f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802063:	85 f6                	test   %esi,%esi
  802065:	75 2d                	jne    802094 <__udivdi3+0x50>
  802067:	39 cf                	cmp    %ecx,%edi
  802069:	77 65                	ja     8020d0 <__udivdi3+0x8c>
  80206b:	89 fd                	mov    %edi,%ebp
  80206d:	85 ff                	test   %edi,%edi
  80206f:	75 0b                	jne    80207c <__udivdi3+0x38>
  802071:	b8 01 00 00 00       	mov    $0x1,%eax
  802076:	31 d2                	xor    %edx,%edx
  802078:	f7 f7                	div    %edi
  80207a:	89 c5                	mov    %eax,%ebp
  80207c:	31 d2                	xor    %edx,%edx
  80207e:	89 c8                	mov    %ecx,%eax
  802080:	f7 f5                	div    %ebp
  802082:	89 c1                	mov    %eax,%ecx
  802084:	89 d8                	mov    %ebx,%eax
  802086:	f7 f5                	div    %ebp
  802088:	89 cf                	mov    %ecx,%edi
  80208a:	89 fa                	mov    %edi,%edx
  80208c:	83 c4 1c             	add    $0x1c,%esp
  80208f:	5b                   	pop    %ebx
  802090:	5e                   	pop    %esi
  802091:	5f                   	pop    %edi
  802092:	5d                   	pop    %ebp
  802093:	c3                   	ret    
  802094:	39 ce                	cmp    %ecx,%esi
  802096:	77 28                	ja     8020c0 <__udivdi3+0x7c>
  802098:	0f bd fe             	bsr    %esi,%edi
  80209b:	83 f7 1f             	xor    $0x1f,%edi
  80209e:	75 40                	jne    8020e0 <__udivdi3+0x9c>
  8020a0:	39 ce                	cmp    %ecx,%esi
  8020a2:	72 0a                	jb     8020ae <__udivdi3+0x6a>
  8020a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020a8:	0f 87 9e 00 00 00    	ja     80214c <__udivdi3+0x108>
  8020ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8020b3:	89 fa                	mov    %edi,%edx
  8020b5:	83 c4 1c             	add    $0x1c,%esp
  8020b8:	5b                   	pop    %ebx
  8020b9:	5e                   	pop    %esi
  8020ba:	5f                   	pop    %edi
  8020bb:	5d                   	pop    %ebp
  8020bc:	c3                   	ret    
  8020bd:	8d 76 00             	lea    0x0(%esi),%esi
  8020c0:	31 ff                	xor    %edi,%edi
  8020c2:	31 c0                	xor    %eax,%eax
  8020c4:	89 fa                	mov    %edi,%edx
  8020c6:	83 c4 1c             	add    $0x1c,%esp
  8020c9:	5b                   	pop    %ebx
  8020ca:	5e                   	pop    %esi
  8020cb:	5f                   	pop    %edi
  8020cc:	5d                   	pop    %ebp
  8020cd:	c3                   	ret    
  8020ce:	66 90                	xchg   %ax,%ax
  8020d0:	89 d8                	mov    %ebx,%eax
  8020d2:	f7 f7                	div    %edi
  8020d4:	31 ff                	xor    %edi,%edi
  8020d6:	89 fa                	mov    %edi,%edx
  8020d8:	83 c4 1c             	add    $0x1c,%esp
  8020db:	5b                   	pop    %ebx
  8020dc:	5e                   	pop    %esi
  8020dd:	5f                   	pop    %edi
  8020de:	5d                   	pop    %ebp
  8020df:	c3                   	ret    
  8020e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020e5:	89 eb                	mov    %ebp,%ebx
  8020e7:	29 fb                	sub    %edi,%ebx
  8020e9:	89 f9                	mov    %edi,%ecx
  8020eb:	d3 e6                	shl    %cl,%esi
  8020ed:	89 c5                	mov    %eax,%ebp
  8020ef:	88 d9                	mov    %bl,%cl
  8020f1:	d3 ed                	shr    %cl,%ebp
  8020f3:	89 e9                	mov    %ebp,%ecx
  8020f5:	09 f1                	or     %esi,%ecx
  8020f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020fb:	89 f9                	mov    %edi,%ecx
  8020fd:	d3 e0                	shl    %cl,%eax
  8020ff:	89 c5                	mov    %eax,%ebp
  802101:	89 d6                	mov    %edx,%esi
  802103:	88 d9                	mov    %bl,%cl
  802105:	d3 ee                	shr    %cl,%esi
  802107:	89 f9                	mov    %edi,%ecx
  802109:	d3 e2                	shl    %cl,%edx
  80210b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80210f:	88 d9                	mov    %bl,%cl
  802111:	d3 e8                	shr    %cl,%eax
  802113:	09 c2                	or     %eax,%edx
  802115:	89 d0                	mov    %edx,%eax
  802117:	89 f2                	mov    %esi,%edx
  802119:	f7 74 24 0c          	divl   0xc(%esp)
  80211d:	89 d6                	mov    %edx,%esi
  80211f:	89 c3                	mov    %eax,%ebx
  802121:	f7 e5                	mul    %ebp
  802123:	39 d6                	cmp    %edx,%esi
  802125:	72 19                	jb     802140 <__udivdi3+0xfc>
  802127:	74 0b                	je     802134 <__udivdi3+0xf0>
  802129:	89 d8                	mov    %ebx,%eax
  80212b:	31 ff                	xor    %edi,%edi
  80212d:	e9 58 ff ff ff       	jmp    80208a <__udivdi3+0x46>
  802132:	66 90                	xchg   %ax,%ax
  802134:	8b 54 24 08          	mov    0x8(%esp),%edx
  802138:	89 f9                	mov    %edi,%ecx
  80213a:	d3 e2                	shl    %cl,%edx
  80213c:	39 c2                	cmp    %eax,%edx
  80213e:	73 e9                	jae    802129 <__udivdi3+0xe5>
  802140:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802143:	31 ff                	xor    %edi,%edi
  802145:	e9 40 ff ff ff       	jmp    80208a <__udivdi3+0x46>
  80214a:	66 90                	xchg   %ax,%ax
  80214c:	31 c0                	xor    %eax,%eax
  80214e:	e9 37 ff ff ff       	jmp    80208a <__udivdi3+0x46>
  802153:	90                   	nop

00802154 <__umoddi3>:
  802154:	55                   	push   %ebp
  802155:	57                   	push   %edi
  802156:	56                   	push   %esi
  802157:	53                   	push   %ebx
  802158:	83 ec 1c             	sub    $0x1c,%esp
  80215b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80215f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802163:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802167:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80216b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80216f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802173:	89 f3                	mov    %esi,%ebx
  802175:	89 fa                	mov    %edi,%edx
  802177:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80217b:	89 34 24             	mov    %esi,(%esp)
  80217e:	85 c0                	test   %eax,%eax
  802180:	75 1a                	jne    80219c <__umoddi3+0x48>
  802182:	39 f7                	cmp    %esi,%edi
  802184:	0f 86 a2 00 00 00    	jbe    80222c <__umoddi3+0xd8>
  80218a:	89 c8                	mov    %ecx,%eax
  80218c:	89 f2                	mov    %esi,%edx
  80218e:	f7 f7                	div    %edi
  802190:	89 d0                	mov    %edx,%eax
  802192:	31 d2                	xor    %edx,%edx
  802194:	83 c4 1c             	add    $0x1c,%esp
  802197:	5b                   	pop    %ebx
  802198:	5e                   	pop    %esi
  802199:	5f                   	pop    %edi
  80219a:	5d                   	pop    %ebp
  80219b:	c3                   	ret    
  80219c:	39 f0                	cmp    %esi,%eax
  80219e:	0f 87 ac 00 00 00    	ja     802250 <__umoddi3+0xfc>
  8021a4:	0f bd e8             	bsr    %eax,%ebp
  8021a7:	83 f5 1f             	xor    $0x1f,%ebp
  8021aa:	0f 84 ac 00 00 00    	je     80225c <__umoddi3+0x108>
  8021b0:	bf 20 00 00 00       	mov    $0x20,%edi
  8021b5:	29 ef                	sub    %ebp,%edi
  8021b7:	89 fe                	mov    %edi,%esi
  8021b9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021bd:	89 e9                	mov    %ebp,%ecx
  8021bf:	d3 e0                	shl    %cl,%eax
  8021c1:	89 d7                	mov    %edx,%edi
  8021c3:	89 f1                	mov    %esi,%ecx
  8021c5:	d3 ef                	shr    %cl,%edi
  8021c7:	09 c7                	or     %eax,%edi
  8021c9:	89 e9                	mov    %ebp,%ecx
  8021cb:	d3 e2                	shl    %cl,%edx
  8021cd:	89 14 24             	mov    %edx,(%esp)
  8021d0:	89 d8                	mov    %ebx,%eax
  8021d2:	d3 e0                	shl    %cl,%eax
  8021d4:	89 c2                	mov    %eax,%edx
  8021d6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021da:	d3 e0                	shl    %cl,%eax
  8021dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021e0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e4:	89 f1                	mov    %esi,%ecx
  8021e6:	d3 e8                	shr    %cl,%eax
  8021e8:	09 d0                	or     %edx,%eax
  8021ea:	d3 eb                	shr    %cl,%ebx
  8021ec:	89 da                	mov    %ebx,%edx
  8021ee:	f7 f7                	div    %edi
  8021f0:	89 d3                	mov    %edx,%ebx
  8021f2:	f7 24 24             	mull   (%esp)
  8021f5:	89 c6                	mov    %eax,%esi
  8021f7:	89 d1                	mov    %edx,%ecx
  8021f9:	39 d3                	cmp    %edx,%ebx
  8021fb:	0f 82 87 00 00 00    	jb     802288 <__umoddi3+0x134>
  802201:	0f 84 91 00 00 00    	je     802298 <__umoddi3+0x144>
  802207:	8b 54 24 04          	mov    0x4(%esp),%edx
  80220b:	29 f2                	sub    %esi,%edx
  80220d:	19 cb                	sbb    %ecx,%ebx
  80220f:	89 d8                	mov    %ebx,%eax
  802211:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802215:	d3 e0                	shl    %cl,%eax
  802217:	89 e9                	mov    %ebp,%ecx
  802219:	d3 ea                	shr    %cl,%edx
  80221b:	09 d0                	or     %edx,%eax
  80221d:	89 e9                	mov    %ebp,%ecx
  80221f:	d3 eb                	shr    %cl,%ebx
  802221:	89 da                	mov    %ebx,%edx
  802223:	83 c4 1c             	add    $0x1c,%esp
  802226:	5b                   	pop    %ebx
  802227:	5e                   	pop    %esi
  802228:	5f                   	pop    %edi
  802229:	5d                   	pop    %ebp
  80222a:	c3                   	ret    
  80222b:	90                   	nop
  80222c:	89 fd                	mov    %edi,%ebp
  80222e:	85 ff                	test   %edi,%edi
  802230:	75 0b                	jne    80223d <__umoddi3+0xe9>
  802232:	b8 01 00 00 00       	mov    $0x1,%eax
  802237:	31 d2                	xor    %edx,%edx
  802239:	f7 f7                	div    %edi
  80223b:	89 c5                	mov    %eax,%ebp
  80223d:	89 f0                	mov    %esi,%eax
  80223f:	31 d2                	xor    %edx,%edx
  802241:	f7 f5                	div    %ebp
  802243:	89 c8                	mov    %ecx,%eax
  802245:	f7 f5                	div    %ebp
  802247:	89 d0                	mov    %edx,%eax
  802249:	e9 44 ff ff ff       	jmp    802192 <__umoddi3+0x3e>
  80224e:	66 90                	xchg   %ax,%ax
  802250:	89 c8                	mov    %ecx,%eax
  802252:	89 f2                	mov    %esi,%edx
  802254:	83 c4 1c             	add    $0x1c,%esp
  802257:	5b                   	pop    %ebx
  802258:	5e                   	pop    %esi
  802259:	5f                   	pop    %edi
  80225a:	5d                   	pop    %ebp
  80225b:	c3                   	ret    
  80225c:	3b 04 24             	cmp    (%esp),%eax
  80225f:	72 06                	jb     802267 <__umoddi3+0x113>
  802261:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802265:	77 0f                	ja     802276 <__umoddi3+0x122>
  802267:	89 f2                	mov    %esi,%edx
  802269:	29 f9                	sub    %edi,%ecx
  80226b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80226f:	89 14 24             	mov    %edx,(%esp)
  802272:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802276:	8b 44 24 04          	mov    0x4(%esp),%eax
  80227a:	8b 14 24             	mov    (%esp),%edx
  80227d:	83 c4 1c             	add    $0x1c,%esp
  802280:	5b                   	pop    %ebx
  802281:	5e                   	pop    %esi
  802282:	5f                   	pop    %edi
  802283:	5d                   	pop    %ebp
  802284:	c3                   	ret    
  802285:	8d 76 00             	lea    0x0(%esi),%esi
  802288:	2b 04 24             	sub    (%esp),%eax
  80228b:	19 fa                	sbb    %edi,%edx
  80228d:	89 d1                	mov    %edx,%ecx
  80228f:	89 c6                	mov    %eax,%esi
  802291:	e9 71 ff ff ff       	jmp    802207 <__umoddi3+0xb3>
  802296:	66 90                	xchg   %ax,%ax
  802298:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80229c:	72 ea                	jb     802288 <__umoddi3+0x134>
  80229e:	89 d9                	mov    %ebx,%ecx
  8022a0:	e9 62 ff ff ff       	jmp    802207 <__umoddi3+0xb3>
