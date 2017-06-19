//
//  KissXMLParser.m
//  iphone_zsyyt
//
//  Created by Wixapp on 11-6-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonParser.h"


//安全释放内存
//#define SELF_DELETE(O_TARGET); ({if(O_TARGET){[O_TARGET release]; O_TARGET = nil;}})

/***********************************XML数据模型**********************************/
/*
#define CODER_XmlObject_haveAttribute			@"CODER_XmlObject_haveAttribute"
#define CODER_XmlObject_haveChild				@"CODER_XmlObject_haveChild"
#define CODER_XmlObject_name					@"CODER_XmlObject_name"
#define CODER_XmlObject_value					@"CODER_XmlObject_value"
#define CODER_XmlObject_attributeDictionary		@"CODER_XmlObject_attributeDictionary"
#define CODER_XmlObject_childArray				@"CODER_XmlObject_childArray"

@implementation XmlObject : NSObject

@synthesize haveAttribute;
@synthesize haveChild;
@synthesize name;
@synthesize value;
@synthesize attributeDictionary;
@synthesize childArray;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeBool:haveAttribute forKey:CODER_XmlObject_haveAttribute];
	[aCoder encodeBool:haveChild forKey:CODER_XmlObject_haveChild];
	
	[aCoder encodeObject:name forKey:CODER_XmlObject_name];
	[aCoder encodeObject:value forKey:CODER_XmlObject_value];
	[aCoder encodeObject:attributeDictionary forKey:CODER_XmlObject_attributeDictionary];
	[aCoder encodeObject:childArray forKey:CODER_XmlObject_childArray];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	if((self=[super init]))
	{
		if(aDecoder)
		{
			haveAttribute = [aDecoder decodeBoolForKey:CODER_XmlObject_haveAttribute];
			haveChild = [aDecoder decodeBoolForKey:CODER_XmlObject_haveChild];
			
			name = [[aDecoder decodeObjectForKey:CODER_XmlObject_name] retain];
			value = [[aDecoder decodeObjectForKey:CODER_XmlObject_value] retain];
			attributeDictionary = [[aDecoder decodeObjectForKey:CODER_XmlObject_attributeDictionary] retain];
			childArray = [[aDecoder decodeObjectForKey:CODER_XmlObject_childArray] retain];
		}
	}
	return self;
}

-(id)initWithXmlElement:(DDXMLElement *)element
{
	if(element==nil)
	{
		return nil;
	}
	
	if((self = [super init]))
	{
		haveAttribute = NO;
		haveChild = NO;
		attributeDictionary = [[NSMutableDictionary dictionary] retain];
		childArray = [[NSMutableArray array] retain];
		
		//设置节点名称
		name = [[NSString alloc] initWithString:element.name];
		//NSLog(@"name : %@",name);
		
		//设置节点属性
		if(element.attributes.count>0)
		{
			haveAttribute = YES;
			for(DDXMLNode *item in element.attributes)
			{
				if(item.stringValue.length>0)
				{
					[attributeDictionary setObject:item.stringValue forKey:item.name];
					//NSLog(@"[%@ = %@]",item.name,item.stringValue);
				}
			}
		}
		
		//添加子节点
		if(element.children.count>0)
		{
			haveChild = YES;
			for(DDXMLElement *item in element.children)
			{
				if(item.kind==DDXMLElementKind)
				{
					XmlObject *node = [[[XmlObject alloc] initWithXmlElement:item] autorelease];
					if(node)
					{
						[childArray addObject:node];
					}
				}
				else if(item.kind==DDXMLTextKind || item.kind==XML_CDATA_SECTION_NODE)
				{
					//设置节点值
					if(item.stringValue.length>0)
					{
						value = [[NSString alloc] initWithString:item.stringValue];
						//NSLog(@"value : %@",value);
					}
				}
				
			}
		}
	}
	return self;
}

-(NSString *)attributeByKey:(NSString *)key
{
	NSString *rtnStr = nil;
	
	NSEnumerator *enumerator = [attributeDictionary keyEnumerator];
	NSString *itemKey;
	while(itemKey = [enumerator nextObject])
	{
		if([itemKey caseInsensitiveCompare:key]==NSOrderedSame)
		{
			rtnStr = [attributeDictionary objectForKey:key];
		}
	}
	
	return rtnStr;
}

-(XmlObject *)childByKey:(NSString *)key
{
	XmlObject *rtnXmlObject = nil;
	for(XmlObject *item in childArray)
	{
		if([item.name caseInsensitiveCompare:key]==NSOrderedSame)
		{
			rtnXmlObject = item;
			break;
		}
	}
	return rtnXmlObject;
}

-(XmlObject *)childByKey:(NSString *)key andValue:(NSString *)valueStr
{
	XmlObject *rtnXmlObject = nil;
	for(XmlObject *item in childArray)
	{
		if([[item attributeByKey:key] caseInsensitiveCompare:valueStr]==NSOrderedSame)
		{
			rtnXmlObject = item;
			break;
		}
	}
	return rtnXmlObject;
}

-(NSArray *)childArrayByKey:(NSString *)key
{
	NSMutableArray *rtnArray = [NSMutableArray array];
	
	for(XmlObject *item in childArray)
	{
		if([item.name caseInsensitiveCompare:key]==NSOrderedSame)
		{
			[rtnArray addObject:item];
		}
	}
	
	return rtnArray;
}

-(NSString *)description
{
	NSMutableString *str = [NSMutableString string];
	[str appendFormat:@"<%@",name];
	
	NSEnumerator *enumerator = [attributeDictionary keyEnumerator];
	NSString *attriName;
	while(attriName = [enumerator nextObject])
	{
		[str appendFormat:@" %@=\"%@\"",attriName,[attributeDictionary objectForKey:attriName]];
	}
	[str appendString:@">"];
	
	for(XmlObject *item in childArray)
	{
		[str appendString:item.description];
	}
	
	if(childArray.count>0)
	{
		[str appendFormat:@"</%@>",name];
	}
	else
	{
		if(value.length>0)
		{
			[str appendFormat:@"%@</%@>",value,name];
		}
		else
		{
			[str appendFormat:@"</%@>",name];
		}
	}
    return str;
}

-(void)dealloc
{
//	NSLog(@"XmlObject dealloc");
	SELF_DELETE(name);
	SELF_DELETE(value);
	SELF_DELETE(attributeDictionary);
	SELF_DELETE(childArray);
    [super dealloc];
}
@end
*/


/************************************解析XML************************************/
/*
@implementation JsonParser

+(XmlObject *)parseXMLFile:(NSString *)xmlFilePath XPath:(NSString *)XPath elementAtIndex:(NSInteger)index
{
	//支持内容中文
//	NSLog(@"%@",xmlFilePath);
	NSString *xmlFileString = [NSString stringWithContentsOfFile:xmlFilePath encoding:NSUTF8StringEncoding error:nil];
	
	if([xmlFileString length]<=0)
	{
		NSLog(@"XML文件内容为空");
		return nil;
	}
	
//	NSLog(@"%@",xmlFileString);
	
	return [KissXMLParser parseXMLString:xmlFileString XPath:XPath elementAtIndex:index];
}

+(XmlObject *)parseXMLString:(NSString *)xmlString XPath:(NSString *)XPath elementAtIndex:(NSInteger)index
{
	//替换字符串解决不支持namespace问题
	NSString *tempString = [xmlString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"nsError" options:NSCaseInsensitiveSearch range:NSMakeRange(0,[xmlString length])];
	
	//注意:当xml字符串内容不规范时以下内容为nil
	DDXMLDocument *xmlDoc = [[[DDXMLDocument alloc] initWithXMLString:tempString options:0 error:nil] autorelease];
	if(xmlDoc==nil)
	{
		NSLog(@"XML文件格式错误");
		return nil;
	}
	//NSLog(@"%@",[xmlDoc description]);
	
	NSArray *docArray = [xmlDoc nodesForXPath:XPath error:nil];
	if([docArray count]<index || [docArray count]==0)
	{
		//NSLog(@"XML文件没有[XPath=%@]的第[index=%d]个节点",XPath,index);
		return nil;
	}
	
	DDXMLElement *rootElement = [docArray objectAtIndex:index];
	XmlObject *root = [[XmlObject alloc] initWithXmlElement:rootElement];;
//	NSLog(@"%@",root.description);
	return root;
}
@end
*/