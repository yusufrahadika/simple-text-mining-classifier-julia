Simple text classifier written in Julia for final project of Text Mining Course in Fakultas Ilmu Komputer Universitas Brawijaya.

## How to Use
1. Run src/testclassification.jl
2. Input your directory of data train and data test.

Example of directory structure.
```bash
├── Data latih
│   ├── class1
│   │   └── *.txt
│   ├── class2
│   │   └── *.txt
│   ├── class3
│   │   └── *.txt
│   └── class*
│       └── *.txt
└── Data uji
    ├── class1
    │   └── *.txt
    ├── class2
    │   └── *.txt
    ├── class3
    │   └── *.txt
    └─── class*
        └── *.txt
```


## List of Features
- [x] Naive-bayes with Laplace smoothing
- [ ] Rocchio
- [ ] KNN


## Known Bugs
- Inconsistent char index when data contains character besides UTF-8
