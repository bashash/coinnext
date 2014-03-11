(function() {
  var PpcWallet, exports, trTime, transactionData;

  trTime = Date.now() / 1000;

  transactionData = {
    amount: 1,
    txid: "unique_tx_id",
    confirmations: 6,
    time: trTime,
    details: [
      {
        account: "account",
        fee: 0.0001,
        address: "address",
        category: "send"
      }
    ]
  };

  PpcWallet = (function() {
    function PpcWallet() {}

    PpcWallet.prototype.getTransaction = function(txId, callback) {
      return callback(null, transactionData);
    };

    PpcWallet.prototype.getBalance = function(account, callback) {
      return callback(null, 1);
    };

    PpcWallet.prototype.chargeAccount = function(account, balance, callback) {
      return callback(null, true);
    };

    PpcWallet.prototype.sendToAddress = function(address, account, amount, callback) {
      return callback(null, "unique_tx_id");
    };

    return PpcWallet;

  })();

  exports = module.exports = PpcWallet;

}).call(this);
