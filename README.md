# XBCodingObject
先前做APP做离线的时候经常遇到有需求要把自定义模型存入数据库,但是需要实现NSCoding协议的两个方法,模型属性少的时候还有耐心写,但是当有100个属性的时候难道还一个个写吗,程序员写代码就是要避免重复的代码,这里作者只是帮助开发者省去了这些枯燥简单没有技术的代码,其次能更有效的提高开发效率.
###只要把这个类拖进工程,在创建数据模型的时候直接继承就OK了,内部就自动帮你实现了NSCoding协议的两个方法了,详细用法看下文!
![Alt text](https://github.com/zhouxubin/XBCodingObject/blob/master/Simulator%20Screen%20Shot.png)
###自定义类person类
    #import "XBCodingObject.h"
    #import "XBDog.h"

    @interface XBPerson : XBCodingObject

    @property (nonatomic, copy) NSString *name;
    @property (nonatomic, copy) NSString *age;

    /**
     狗类
     */
    @property (nonatomic, strong) XBDog *dog;

    /**
     数组里面装的是猫类
     */
    @property (nonatomic, strong) NSArray *cats;
    
    @end
    
###自定义dog类

	#import "XBCodingObject.h"

    @interface XBDog : XBCodingObject
    
    @property (nonatomic, copy) NSString *dogName;
    @property (nonatomic, copy) NSString *dogAge;
    
    @end
    
###自定义cat类
 
    #import "XBCodingObject.h"
    
    @interface XBCat : XBCodingObject
    
    @property (nonatomic, copy) NSString *catName;
    @property (nonatomic, copy) NSString *catAge;
    
    @end
    
###用法
    #import "ViewController.h"
    #import "XBPerson.h"
    #import "XBCat.h"
    
    @interface ViewController ()
    
    @end
    
    @implementation ViewController
    
    - (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < 3; ++i) {
        XBPerson *person1 = [[XBPerson alloc] init];
        person1.name = @"123";
        person1.age = @"aaaa";
        
        XBDog *dog = [[XBDog alloc] init];
        dog.dogName = @"哈哈哈";
        dog.dogAge = @"111";
        person1.dog = dog;
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i < 3; ++i) {
            XBCat *cat = [[XBCat alloc] init];
            cat.catName = @"444";
            cat.catAge = @"555";
            [tempArray addObject:cat];
        }
        person1.cats = tempArray;
        
        [array addObject:person1];
        }
        // 这里可以直接实现归档方法
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
        // 解档
        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@", arr);
    }
    
### 核心代码

    // 获取所有属性列表
    - (NSArray *)properties {
    	NSMutableArray *properties = [NSMutableArray array];
    	unsigned int count = 0;
   	    Ivar *propertyArr = class_copyIvarList([self class], &count);
        objc_property_t *propertyArray = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
           Ivar property = propertyArr[i];
           const char *propertyNameC = ivar_getName(property);
            NSString *propertyNameOC = [[NSString alloc] initWithCString:propertyNameC encoding:NSUTF8StringEncoding];
        [properties addObject:propertyNameOC];
    }
        free(propertyArray);
        return properties;
    }

	// 把所有属性归档
    - (void)encodeWithCoder:(NSCoder *)aCoder {
        NSArray *propertyArray = [self properties];
        for (NSString *property in propertyArray) {
            [aCoder encodeObject:[self valueForKey:property] forKey:property];
        }    
    }

	// 对所有属性解档
    - (instancetype)initWithCoder:(NSCoder *)aDecoder {
        if (self == [super init]) {
            for (NSString *property in [self properties]) {
            [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
            }
        }
        return self;
    }

####有任何问题可以联系作者:QQ447808449
