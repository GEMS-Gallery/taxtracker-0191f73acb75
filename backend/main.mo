import Array "mo:base/Array";
import Hash "mo:base/Hash";

import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Option "mo:base/Option";

actor {
  type TaxPayer = {
    tid: Nat;
    firstName: Text;
    lastName: Text;
    address: Text;
  };

  stable var nextTid: Nat = 1;
  let taxPayers = HashMap.HashMap<Nat, TaxPayer>(10, Nat.equal, Nat.hash);

  public func createTaxPayer(firstName: Text, lastName: Text, address: Text) : async Result.Result<Nat, Text> {
    let tid = nextTid;
    nextTid += 1;
    let taxPayer: TaxPayer = {
      tid = tid;
      firstName = firstName;
      lastName = lastName;
      address = address;
    };
    taxPayers.put(tid, taxPayer);
    #ok(tid)
  };

  public query func getAllTaxPayers() : async [TaxPayer] {
    Iter.toArray(taxPayers.vals())
  };

  public query func getTaxPayerByTID(tid: Nat) : async ?TaxPayer {
    taxPayers.get(tid)
  };
}
