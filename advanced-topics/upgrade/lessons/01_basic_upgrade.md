Sui Contract Upgrade Tutorial with Detailed Examples
## Basic Upgrade Example
### Example 1: Simple Function Addition
Original Contract (v1):

```move
module counter::counter;

public struct Counter has key {
    id: UID,
    value: u64,
}

fun init(ctx: &mut TxContext) {
    transfer::share_object(Counter {
        id: object::new(ctx),
        value: 0,
    })
}

public fun increment(c: &mut Counter) {
    c.value = c.value + 1;
}
```

publish contract V1
```shell
sui client publish
```
```shell
Transaction Digest: HKCNWWmS2k1bscWwbpRCedsu4jxU6T4n7k11nZk2uoXS
╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Data                                                                                             │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Sender: 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f                                   │
│ Gas Owner: 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f                                │
│ Gas Budget: 10641200 MIST                                                                                    │
│ Gas Price: 1000 MIST                                                                                         │
│ Gas Payment:                                                                                                 │
│  ┌──                                                                                                         │
│  │ ID: 0x6e6ad2c5d789bea9242ec41ac820fc6293ad54956e514b2c3eea7e2b5f284825                                    │
│  │ Version: 259766517                                                                                        │
│  │ Digest: Ft1TDTm4fCbVjGJGdZBgrxoetEqZk4DH2mVXkM2Ye8yg                                                      │
│  └──                                                                                                         │
│                                                                                                              │
│ Transaction Kind: Programmable                                                                               │
│ ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────╮ │
│ │ Input Objects                                                                                            │ │
│ ├──────────────────────────────────────────────────────────────────────────────────────────────────────────┤ │
│ │ 0   Pure Arg: Type: address, Value: "0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f" │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│ ╭─────────────────────────────────────────────────────────────────────────╮                                  │
│ │ Commands                                                                │                                  │
│ ├─────────────────────────────────────────────────────────────────────────┤                                  │
│ │ 0  Publish:                                                             │                                  │
│ │  ┌                                                                      │                                  │
│ │  │ Dependencies:                                                        │                                  │
│ │  │   0x0000000000000000000000000000000000000000000000000000000000000001 │                                  │
│ │  │   0x0000000000000000000000000000000000000000000000000000000000000002 │                                  │
│ │  └                                                                      │                                  │
│ │                                                                         │                                  │
│ │ 1  TransferObjects:                                                     │                                  │
│ │  ┌                                                                      │                                  │
│ │  │ Arguments:                                                           │                                  │
│ │  │   Result 0                                                           │                                  │
│ │  │ Address: Input  0                                                    │                                  │
│ │  └                                                                      │                                  │
│ ╰─────────────────────────────────────────────────────────────────────────╯                                  │
│                                                                                                              │
│ Signatures:                                                                                                  │
│    SRUhbVi4Fr9s620KesEmM6HgQOt/oyMN0vkeh1DnXThl999wiSbkmCtHD0/pm+NZ3fqXfas6V3Fe7Wn5bPW7DA==                  │
│                                                                                                              │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Effects                                                                               │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Digest: HKCNWWmS2k1bscWwbpRCedsu4jxU6T4n7k11nZk2uoXS                                              │
│ Status: Success                                                                                   │
│ Executed Epoch: 809                                                                               │
│                                                                                                   │
│ Created Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x4e519ef76c37837c968aa7a99b3db10904e0bed238c6c45f3f22c2abca7d0300                         │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )  │
│  │ Version: 259766518                                                                             │
│  │ Digest: a8PoyBSCxxwXozihnwELsbxpp1kpwjZSTefY1dtQ9cL                                            │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0x88850229c722434309131fd8f84db693e6bf53c31c4d27c32fa0a734e7229cee                         │
│  │ Owner: Shared( 259766518 )                                                                     │
│  │ Version: 259766518                                                                             │
│  │ Digest: A6NXt6Hr8wmPAwTmAYmGHtVffm7WmDidE3Yadw26SZcj                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0xbfd07a5e74050b44201de548a3784412fd2df2b5ad769db38ed657ffdd4d31f0                         │
│  │ Owner: Immutable                                                                               │
│  │ Version: 1                                                                                     │
│  │ Digest: Fy5Fy9LJU18jcg53UMrbGUhN72XfsQpkbi1gfG7RLY4X                                           │
│  └──                                                                                              │
│ Mutated Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x6e6ad2c5d789bea9242ec41ac820fc6293ad54956e514b2c3eea7e2b5f284825                         │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )  │
│  │ Version: 259766518                                                                             │
│  │ Digest: 82j1mBgKuqycr2gtsVLY7ssFzEX3xSp1h4bR85qSGPnY                                           │
│  └──                                                                                              │
│ Gas Object:                                                                                       │
│  ┌──                                                                                              │
│  │ ID: 0x6e6ad2c5d789bea9242ec41ac820fc6293ad54956e514b2c3eea7e2b5f284825                         │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )  │
│  │ Version: 259766518                                                                             │
│  │ Digest: 82j1mBgKuqycr2gtsVLY7ssFzEX3xSp1h4bR85qSGPnY                                           │
│  └──                                                                                              │
│ Gas Cost Summary:                                                                                 │
│    Storage Cost: 8641200 MIST                                                                     │
│    Computation Cost: 1000000 MIST                                                                 │
│    Storage Rebate: 978120 MIST                                                                    │
│    Non-refundable Storage Fee: 9880 MIST                                                          │
│                                                                                                   │
│ Transaction Dependencies:                                                                         │
│    6pZ2bpkwLwnCH4qdHS1NcJypXLFUNvSHRKfKXhZvXQuo                                                   │
│    DAQgvuy7RSDPug6hxEjThcmQDeez59Bzywrdn4pTtbLE                                                   │
│    EUZwUpNHYrLddC3tuyc6dJMLvnagDcVrtXX9qENrpus2                                                   │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─────────────────────────────╮
│ No transaction block events │
╰─────────────────────────────╯

╭──────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Object Changes                                                                                       │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Created Objects:                                                                                     │
│  ┌──                                                                                                 │
│  │ ObjectID: 0x4e519ef76c37837c968aa7a99b3db10904e0bed238c6c45f3f22c2abca7d0300                      │
│  │ Sender: 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f                        │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )     │
│  │ ObjectType: 0x2::package::UpgradeCap                                                              │
│  │ Version: 259766518                                                                                │
│  │ Digest: a8PoyBSCxxwXozihnwELsbxpp1kpwjZSTefY1dtQ9cL                                               │
│  └──                                                                                                 │
│  ┌──                                                                                                 │
│  │ ObjectID: 0x88850229c722434309131fd8f84db693e6bf53c31c4d27c32fa0a734e7229cee                      │
│  │ Sender: 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f                        │
│  │ Owner: Shared( 259766518 )                                                                        │
│  │ ObjectType: 0xbfd07a5e74050b44201de548a3784412fd2df2b5ad769db38ed657ffdd4d31f0::counter::Counter  │
│  │ Version: 259766518                                                                                │
│  │ Digest: A6NXt6Hr8wmPAwTmAYmGHtVffm7WmDidE3Yadw26SZcj                                              │
│  └──                                                                                                 │
│ Mutated Objects:                                                                                     │
│  ┌──                                                                                                 │
│  │ ObjectID: 0x6e6ad2c5d789bea9242ec41ac820fc6293ad54956e514b2c3eea7e2b5f284825                      │
│  │ Sender: 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f                        │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )     │
│  │ ObjectType: 0x2::coin::Coin<0x2::sui::SUI>                                                        │
│  │ Version: 259766518                                                                                │
│  │ Digest: 82j1mBgKuqycr2gtsVLY7ssFzEX3xSp1h4bR85qSGPnY                                              │
│  └──                                                                                                 │
│ Published Objects:                                                                                   │
│  ┌──                                                                                                 │
│  │ PackageID: 0xbfd07a5e74050b44201de548a3784412fd2df2b5ad769db38ed657ffdd4d31f0                     │
│  │ Version: 1                                                                                        │
│  │ Digest: Fy5Fy9LJU18jcg53UMrbGUhN72XfsQpkbi1gfG7RLY4X                                              │
│  │ Modules: counter                                                                                  │
│  └──                                                                                                 │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Balance Changes                                                                                   │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│  ┌──                                                                                              │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )  │
│  │ CoinType: 0x2::sui::SUI                                                                        │
│  │ Amount: -8663080                                                                               │
│  └──                                                                                              │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯

```

find package id 

```shell
│  │ PackageID: 0xbfd07a5e74050b44201de548a3784412fd2df2b5ad769db38ed657ffdd4d31f0                     │
│  │ Version: 1                                                                                        │
│  │ Digest: Fy5Fy9LJU18jcg53UMrbGUhN72XfsQpkbi1gfG7RLY4X                                              │
│  │ Modules: counter  
```


add to move.toml
`published-at = "0xbfd07a.."`

```toml
[package]
name = "counter"
edition = "2024.beta" # edition = "legacy" to use legacy (pre-2024) Move
published-at = "0xbfd07a5e74050b44201de548a3784412fd2df2b5ad769db38ed657ffdd4d31f0"
```


find `ObjectID`  ObjectType: 0x2::package::UpgradeCap
```shell
ObjectID: 0x4e519ef76c37837c968aa7a99b3db10904e0bed238c6c45f3f22c2abca7d0300                      │
│  │ Sender: 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f                        │
│  │ Owner: Account Address ( 0x1fda7ad14f7fde060bec93172f47aa22a7601a42f579659cc632cb6eabcbf10f )     │
│  │ ObjectType: 0x2::package::UpgradeCap  
```
`0x4e519ef76c37837c968aa7a99b3db10904e0bed238c6c45f3f22c2abca7d0300`


Upgraded Version (v2) - Adding New Function:

```move
module counter::counter;

public struct Counter has key {
    id: UID,
    value: u64,
}

fun init(ctx: &mut TxContext) {
    transfer::share_object(Counter {
        id: object::new(ctx),
        value: 0,
    })
}

public fun increment(c: &mut Counter) {
    c.value = c.value + 1;
}

public fun decreament(c: &mut Counter) {
    c.value = c.value - 1;
}
```

```shell
sui client upgrade --upgrade-capability 0x4e519ef76c37837c968aa7a99b3db10904e0bed238c6c45f3f22c2abca7d0300
```

echo 
```
...
 Published Objects:                                                                               │
│  ┌──                                                                                             │
│  │ PackageID: 0xa0f057f3b816d188e7c5f2e064d3442292ffa1608fbd844bef53b208c2396a47                 │
│  │ Version: 2                                                                                    │
│  │ Digest: 77qv6EBDs5R6WCDshMafEXjaDUq51Xt3eRccuktUGQce                                          │
│  │ Modules: counter                                                                              │
│  └──   
... 
```
Complete the upgrade and get new packageID
`0xa0f057f3b816d188e7c5f2e064d3442292ffa1608fbd844bef53b208c2396a47`

