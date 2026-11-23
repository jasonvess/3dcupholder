"""Give an OpenSCAD-exported 3MF a proper object name and title. Usage: python3 tools_name3mf.py FILE.3mf "Name" """
import sys, zipfile, io, re
path, name = sys.argv[1], sys.argv[2]
src = zipfile.ZipFile(path)
items = [(i, src.read(i.filename)) for i in src.infolist()]
src.close()
buf = io.BytesIO()
with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as z:
    for info, data in items:
        if info.filename == "3D/3dmodel.model":
            m = data.decode()
            m = m.replace('name="OpenSCAD Model"', 'name="%s"' % name, 1)
            m = re.sub(r"(<model [^>]*>)", r'\1\n\t<metadata name="Title">%s</metadata>' % name, m, count=1)
            data = m.encode()
        z.writestr(info.filename, data)
open(path, "wb").write(buf.getvalue())
