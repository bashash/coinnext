require "./../../helpers/spec_helper"

describe "Payment", ->
  payment = undefined

  beforeEach (done)->
    payment = GLOBAL.db.Payment.build {user_id: 1, wallet_id: 1, amount: 10, currency: "BTC", address: "mrLpnPMsKR8oFqRRYA28y4Txu98TUNQzVw"}
    GLOBAL.db.sequelize.sync({force: true}).complete ()->
      done()

  describe "isProcessed", ()->
    describe "when the status is processed", ()->
      it "returns true", ()->
        payment.status = "processed"
        payment.isProcessed().should.eql true

    describe "when the status is not processed", ()->
      it "returns false", ()->
        payment.status = "pending"
        payment.isProcessed().should.eql false


  describe "isCanceled", ()->
    describe "when the status is canceled", ()->
      it "returns true", ()->
        payment.status = "canceled"
        payment.isCanceled().should.eql true

    describe "when the status is not canceled", ()->
      it "returns false", ()->
        payment.status = "pending"
        payment.isCanceled().should.eql false


  describe "isPending", ()->
    describe "when the status is pending", ()->
      it "returns true", ()->
        payment.status = "pending"
        payment.isPending().should.eql true

    describe "when the status is not pending", ()->
      it "returns false", ()->
        payment.status = "canceled"
        payment.isPending().should.eql false


  describe "process", ()->
    it "sets the status processed", (done)->
      payment.process "txid", (err, pm)->
        console.log err
        pm.status.should.eql "processed"
        done()

    it "sets the transaction id", (done)->
      payment.process "txid", (err, pm)->
        pm.transaction_id.should.eql "txid"
        done()

    it "sets the given result as log", (done)->
      payment.process "txid", (err, pm)->
        pm.log.toString().should.eql JSON.stringify("txid")
        done()


  describe "cancel", ()->
    it "sets the status canceled", (done)->
      payment.cancel "result", (err, pm)->
        pm.status.should.eql "canceled"
        done()

    it "sets the given result as log", (done)->
      payment.cancel "result", (err, pm)->
        pm.log.toString().should.eql "\"\\\"result\\\"\""
        done()


  describe "errored", ()->
    it "keeps the old status", (done)->
      payment.errored "result", (err, pm)->
        pm.status.should.eql "pending"
        done()

    it "sets the given result as log", (done)->
      payment.errored "result", (err, pm)->
        pm.log.toString().should.eql "\"\\\"result\\\"\""
        done()
