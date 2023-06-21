import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/models/wallet.dart';
import 'package:untitled/utils/methods.dart';

class DbHelper {
  DbHelper._createInstance();

  String db_name = "walletApp.db";

  static Database _database;
  static DbHelper helper;

  String wallet_table = "wallet_table";
  String col_wallet_id = "id";
  String col_wallet_seed = "seed";
  String col_wallet_passphrase = "passphrase";
  String col_wallet_password = "password";
  String col_wallet_hex = "hex";

  Future createDb(Database db, int version) async {
    String create_wallet_table = "create table $wallet_table ("
        "$col_wallet_id integer primary key autoincrement,"
        "$col_wallet_passphrase text,"
        "$col_wallet_hex text,"
        "$col_wallet_password text,"
        "$col_wallet_seed text)";

    await db.execute(create_wallet_table);
  }

  factory DbHelper(){
    if(helper == null){
      helper = DbHelper._createInstance();
    }
    return helper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    final db_path = await getDatabasesPath();
    final path = join(db_path, db_name);
    return await openDatabase(path, version: 1, onCreate: createDb);
  }

  Future<bool> saveWallet(Wallet wallet) async {
    Database db = await database;
    String query = "insert into $wallet_table ($col_wallet_hex, $col_wallet_password, "
        "$col_wallet_seed, $col_wallet_passphrase) values ('${wallet.hex}', '${wallet.password}', "
        "'${wallet.seed}', '${wallet.passphrase}')";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      print("db_helper.saveWallet error: ${e.toString()}");
      showToast("Wallet not saved");
      return false;
    }
  }

  Future<bool> deleteWallet(Wallet wallet) async {
    Database db = await database;
    String query = "delete from $wallet_table where $col_wallet_id = ${wallet.id}";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      print("db_helper.deleteWallet error: ${e.toString()}");
      showToast("Wallet not deleted");
      return false;
    }
  }

  Future<List<Wallet>> getWallets() async {
    List<Wallet> wallets = [];
    Database db = await database;
    String query = "select * from $wallet_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (int i = 0; i < result.length; i++) {
      Wallet w = Wallet(
        id: int.parse(result[i][col_wallet_id].toString()),
        seed: result[i][col_wallet_seed].toString(),
        password: result[i][col_wallet_password].toString(),
        hex: result[i][col_wallet_hex].toString(),
        passphrase: result[i][col_wallet_passphrase].toString(),
      );
      wallets.add(w);
    }
    return wallets;
  }

}