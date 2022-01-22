import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/page/top_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _accessTokenIsSaved = false;
  @override
  void initState() {
    super.initState();
    substituteBool();
  }

  void substituteBool() async {
    _accessTokenIsSaved = await QiitaClient.accessTokenIsSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.05),),),
            Column(children :<Widget>[
              Container(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("アプリ情報",style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    enableDrag: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => privacyModal(),
                  );
                },
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text("プライバシーポリシー"),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                        child: Icon(Icons.arrow_forward_ios_rounded, color: HexColor(Constants.black),),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 20,
                endIndent: 0,
              ),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => termsModal()
                  );
                },
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text("利用規約"),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                        child: Icon(Icons.arrow_forward_ios_rounded, color: HexColor(Constants.black),),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 20,
                endIndent: 0,
              ),
              Container(
                constraints: BoxConstraints.tightForFinite(height: 50),
                decoration: BoxDecoration(color: Colors.white),
                child:Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                      child: Text("アプリバージョン", style: TextStyle(color: HexColor(Constants.black),),),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      child: Text("v1.0.0", style: TextStyle(color: HexColor(Constants.black), fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 20,
                endIndent: 0,
              ),
              Container(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("その他",style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  print("LogOut is tapped");
                  _accessTokenIsSaved
                  ? showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("ログアウトしますか？"),
                        actions: [
                          TextButton(
                            child: Text("キャンセル"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("OK"),
                            onPressed: () async {
                              await QiitaClient.deleteAccessToken();
                              Navigator.of(context).pushReplacementNamed("/");
                            }
                          ),
                        ],
                      );
                    },
                  )
                  : showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("ログインしていません"),
                        content: Text("ログインしますか？"),
                        actions: [
                          TextButton(
                            child: Text("No"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => TopPage()));
                              }
                          ),
                        ],
                      );
                    },
                  );
                  },
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text("ログアウトする"),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 20,
                endIndent: 0,
              ),
            ])
          ],
        )
    );
  }

  Widget privacyModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(20),
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Align(alignment: Alignment.center,
                child: Text("プライバシーポリシー",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(child: Text(privacy)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget termsModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(20),
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Align(alignment: Alignment.center,
                child: Text("利用規約",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(child: Text(terms)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var privacy =
  """プライバシーポリシー
情報の収集と使用
第三者に個人を特定できる情報を提供することはありません。
より良い体験のために、私たちのサービスを使用している間、特定の個人情報を提供するようにあなたに要求する場合があります。
アプリは、あなたを識別するために使用される情報を収集する可能性のあるサードパーティのサービスを使用します。
アプリで使用されるサードパーティのサービスプロバイダー
- ログデータ
サービスを使用するたびに、アプリでエラーが発生した場合、ログデータと呼ばれる電話でデータと情報を（サードパーティ製品を通じて）収集することをお知らせします。このログデータには、デバイスのインターネットプロトコル（「IP」）アドレス、デバイス名、オペレーティングシステムのバージョン、サービスを利用する際のアプリの構成、サービスの使用日時、その他の統計などの情報が含まれる場合があります。
Qiita Feed Appではアプリの利便性向上を目的にして、個人を特定できないよう匿名化したデータを用いてアクセス解析を行なっています。
例えばアプリのクラッシュ情報を匿名で送信し、バグの修正のために利用しています。
またご利用端末のOSやアプリバージョンの使用率などを解析しアプリの改善に役立てています。
このプライバシーポリシーの変更
プライバシーポリシーを随時更新する場合があります。したがって、変更がある場合はこのページを定期的に確認することをお勧めします。このページに新しいプライバシーポリシーを掲載して、変更をお知らせします。これらの変更は、このページに投稿された直後に有効になります。
お問い合わせ
プライバシーポリシーについてご質問やご提案がありましたら、hoge@gmail.comまでお気軽にお問い合わせください。""";

  var terms =
  """Qiita Feed App プライバシーポリシー
Hoge, inc.（以下「当社」といいます。）は、当社が運営するサービス（以下「本サービス」といいます。）を提供するにあたり、個人情報保護に関する法規範を遵守し、以下のプライバシーポリシー（以下「本ポリシー」といいます。）に従って個人情報の適切な取得、利用、提供等を行います。
1. 個人情報について
本ポリシーにおいて個人情報とは、個人情報の保護に関する法律（以下「個人情報保護法」といいます。）に定める「個人情報」をいいます。
当社は、本サービスに関して、以下の情報をはじめとしたユーザーの情報を取得する場合があり、これらの情報には個人情報が含まれることがあります。
	ユーザーが本サービスに登録する情報（氏名、ニックネーム、電話番号、メールアドレスおよびパスワード等）
	ユーザーのプロフィールに関する情報（アイコン写真、オフィスへのチェックイン日時等、その他の個人に関する属性情報等）
	通信端末に関する情報（ユーザーのＩＰアドレス、利用状況、履歴、位置情報、利用端末、これまでにご利用いただいたサービスやご購入いただいた商品、ご覧になったページ・広告、ご利用時間帯、ご利用の方法、ご利用環境等）
2. 取得した個人情報の利用目的について
当社は、取得した個人情報を、以下の目的のために利用いたします。 なお、個人情報の取得にあたって本ポリシーとは別に利用目的を通知した場合は、当社は、以下の目的に加え、個別に通知した目的のためにも当該個人情報を利用いたします。
	本サービスをご利用するユーザー同士が本サービス上でお互いを認識できるようにするため
	本サービスの改善・内容を充実させるため。
	新しいサービスの企画、検討、開発および提供をするため。
	ユーザーからのお問い合わせに対応するため。
	ユーザーの本人確認を行うため。
	その他、上記の利用目的および当社の事業に付帯、関連する目的のため。
3．個人情報の第三者への提供について
本サービスは、以下に定める場合、個人情報を第三者に提供します。
	本サービスにおけるユーザーの識別のため、他のユーザー向けに本サービス上でユーザーの個人情報を表示する場合
	ユーザーの指示または同意に基づいて第三者に個人情報を提供する場合。
	裁判所、監督官庁その他の公的機関から取得情報を提供するよう求められた場合等の個人情報保護法で第三者への個人情報の提供が認められている場合。
4. 第三者が提供するサービスについて
当社は、第三者が提供するサービスを用いて本サービスの品質向上または表示するコンテンツを最適化するために、 クッキーおよびアクセスログ等の情報を第三者に提供する場合があります。
アプリで使用されているサードパーイティのサービスプロバイダは下記になります。
・Firebase Analytics
6．個人情報の管理について
本法人は個人データを正確かつ最新の状態に保ち、紛失・改ざん・漏えいの防止等、安全管理のために必要かつ適切な措置を講じます。
5．業務委託の際の扱い
利用目的の達成のため、個人情報の取り扱いを外部に委託することがあります。その際は業務委託先に対して、漏えい、再提供のないよう個人情報の取扱いに関する契約を結ぶ等、適切な管理を行います
6. 情報の開示・訂正・削除について
当社は、必要に応じて、本ポリシーを変更することがあります。 なお、法令上ユーザーの同意が必要となるような変更を実施する場合、当社所定の方法によりユーザーからの同意を取得いたします。
7. 個人情報に関するお問い合わせ等について
このプライバシーポリシーに関するお問い合わせは、下記までお願いいたします。
アプリ開発チーム
MAIL: hoge@hoge.io""";
}