from zzz import *
from xml.dom.minidom import parse


def clean(tree):
    # print("clean", tree)
    flag = 1
    while True:
        flag = 1
        for i in tree.childNodes:
            # print("detected node type", i.nodeType)
            if i.nodeType == 1:
                clean(i)
            elif i.nodeType == 3:
                tree.removeChild(i)
                flag = 0
                break
            else:
                print("Unrecognized node type", i.nodeType)
        if flag:
            break


srcdir = "Z:/2226345952/dstimages/"
dssrcdir = "Z:/2226345952/hamlet/"
xmls = [i for i in os.listdir(srcdir) if i.endswith("xml")]
dsxmls = [i for i in os.listdir(dssrcdir) if i.endswith("xml")]
dstdir = srcdir
dstfile = "syms.json"
dsfile = "symsds.json"
tablefile = "mapping.json"
arrayfile = "arr.json"
dstimgdir = "images/dstimages/"
dsimgdir = "images/"
no_repeat_asset = True
syms = {}


def CollectSymbol(name, path):
    DOMTree = parse(path)
    Atlas = DOMTree.documentElement
    Elements = Atlas.getElementsByTagName("Elements")[0]
    Element = Elements.getElementsByTagName("Element")
    if not name in syms:
        syms[name] = [i.getAttribute("name") for i in Element]
    else:
        syms[name].extend([i.getAttribute("name") for i in Element])


def main(force=False):
    global syms
    if not force and os.path.exists(dstdir + dstfile):
        pass
    else:
        for i in xmls:
            CollectSymbol(i, srcdir + i)
        with open(dstdir + dstfile, "w") as f:
            json.dump(syms, f, ensure_ascii=False)
    if no_repeat_asset:
        syms = {}
    if not force and os.path.exists(dstdir + dsfile):
        pass
    else:
        for i in dsxmls:
            CollectSymbol(i, dssrcdir + i)
        with open(dstdir + dsfile, "w") as f:
            json.dump(syms, f, ensure_ascii=False)


def GetKey(tex, dstxml):
    for i in dstxml:
        if tex in dstxml[i]:
            # This assumes that dst tex name==ds tex name
            return [dstimgdir + i, tex]
    return None


def maketable():
    dstatlas = json.load(open(srcdir + dstfile))
    dsatlas = json.load(open(srcdir + dsfile))
    table = {}
    for dsxml in dsatlas:
        key = dsimgdir + dsxml
        table[key] = {}
        for dstex in dsatlas[dsxml]:
            table[key][dstex] = GetKey(dstex, dstatlas)
            if not table[key][dstex]:
                del table[key][dstex]
    with open(dstdir + tablefile, "w") as f:
        json.dump(table, f, ensure_ascii=False, sort_keys=True)


def makearray():
    dstatlas = json.load(open(srcdir + dstfile))
    dsatlas = json.load(open(srcdir + dsfile))
    table = {}
    for dsxml in dsatlas:
        key = dsimgdir + dsxml
        table[key] = []
        for dstex in dsatlas[dsxml]:
            for dstxml in dstatlas:
                if dstex in dstatlas[dstxml]:
                    table[key].append(dstex)
                else:
                    pass
    # fall into hud
    dsxml = "hud.xml"
    for i in dstatlas:
        for dsttex in dstatlas[i]:
            if not dsttex in table[dsimgdir + dsxml]:
                table[dsimgdir + dsxml].append(dsttex)
    for i in table:
        table[i] = sorted(table[i])
    with open(dstdir + arrayfile, "w") as f:
        json.dump(table, f, ensure_ascii=False, sort_keys=True)


if __name__ == '__main__':
    main()
    # maketable()
    makearray()
