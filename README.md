# Analysis
UI控件统计数据埋点
导入后只需要，在AppDelegate的didFinishlaunch方法中，调用[AnalysisManager shareInstance]初始化，并将代理设置给他，最后实现AnalysisDelegate的接口方法即可。
```
@protocol AnalysisDelegate <NSObject>
/**
 *UIControl响应事件回调，可以在这里添加埋点逻辑
 *@param action 响应方法名
 *@param target 响应者
 *@param event 响应事件
 */
- (void)hxw_UIControlSendAction:(SEL)action target:(id)target forEvent:(UIEvent*)event;
/**
 *UIGestureCognized响应事件回调，可以在这里添加埋点逻辑
 *@param gestureCognized 响应对应的手势
 *gestureCognized的属性name赋值为[NSString stringWithFormat:@"hxw_%@_%@",NSStringFromClass(clazz),NSStringFromSelector(action)];其中clazz为事件响应者target的class。
 */
- (void)hxw_UIGestureCognizedRespondAction:(UIGestureRecognizer*)gestureCognized;

///UIViewController analysis 可以在这里添加埋点逻辑页面统计
/**
 *hxw_viewDidLoad
 *@param viewController 页面控制器
 */
- (void)hxw_viewDidLoad:(UIViewController*)viewController;
/**
 *hxw_viewWillAppear
 *@param viewController 页面控制器
 */
- (void)hxw_viewWillAppear:(BOOL)animated viewController:(UIViewController*)viewController;
/**
 *hxw_viewWillDisappear
 *@param viewController 页面控制器
 */
- (void)hxw_viewWillDisappear:(BOOL)animated viewController:(UIViewController*)viewController;


/**
 *UITableView 点击cell统计
 *@param tableView tableView 其中tableview的tag值需要设置，用来区分不同的tableview
 *@param indexPath 点击的位置
 *@param delegate UITableViewDelegate的实现者
 */
- (void)hxw_tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath delagete:(id<UITableViewDelegate>)delegate;
```
