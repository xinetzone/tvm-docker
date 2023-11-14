from pathlib import Path
from invoke import task
from d2py.utils.file import mkdir

ORIGIN = Path("/home/workspace/tvm").resolve()
TARGET = Path("/home/workspace/outputs").resolve()
mkdir(TARGET)
mkdir(f'{TARGET}/src/bin')
mkdir(f'{TARGET}/src/tvm')
mkdir(f'{TARGET}/src/tvm/relay')
mkdir(f'{TARGET}/src/tvm/relay/quantize')
mkdir(f"{TARGET}/src/vta_hw/build")

@task
def cpp(ctx):
    ctx.run(f"cp -rf {ORIGIN}/build/libtvm*.so {TARGET}/src/bin")
    ctx.run(f"cp {ORIGIN}/build/libvta*.so {TARGET}/src/vta_hw/build")
    # ctx.run(f"cp {TARGET}/replace/vta/environment.py {ORIGIN}/vta/python/vta")
    # ctx.run(f"cp -rf {ORIGIN}/3rdparty/vta-hw/config/ {TARGET}/src/vta_hw")

@task
def package(ctx,
            name="vta",
            origin_dir="vta/python",
            out_dir="src", 
            is_package=True):
    cmd = f"cd {ORIGIN}/{origin_dir} && "
    cmd += "python3 -m nuitka --remove-output --no-pyi-file "
    cmd += f"--output-dir={TARGET}/{out_dir} "
    cmd += f"--module {name} "
    if is_package:
        cmd += f"--include-package={name}"
    ctx.run(cmd)

@task
def tvm(ctx,
        origin_dir="python/tvm",
        out_dir="src/tvm"):
    root = ORIGIN/origin_dir
    for path in root.iterdir():
        name = path.name
        if name.endswith(".pyi"):
            continue
        if name not in ["__pycache__", "relay"]:
            if name == "__init__.py":
                ctx.run(f"cp -rf {path} {TARGET}/{out_dir}/")
                continue
            if path.is_dir():
                is_package = True
            else:
                is_package = False
            package(ctx,
                    name=name,
                    origin_dir=origin_dir,
                    out_dir=out_dir, 
                    is_package=is_package)

@task     
def relay(ctx,
          origin_dir="python/tvm/relay",
          out_dir="src/tvm/relay"):
    root = ORIGIN/origin_dir
    for path in root.iterdir():
        print(path)
        name = path.name
        if name.endswith(".pyi"):
            continue
        if name not in ["__pycache__", "quantize"]:
            if name in ["__init__.py", "std"]:
                ctx.run(f"cp -rf {path} {TARGET}/{out_dir}/")
                continue
            if path.is_dir():
                is_package = True
            else:
                is_package = False
            package(ctx,
                    name=name,
                    origin_dir=origin_dir,
                    out_dir=out_dir, 
                    is_package=is_package)
            
@task     
def quantize(ctx,
             origin_dir="python/tvm/relay/quantize",
             out_dir="src/tvm/relay/quantize"):
    root = ORIGIN/origin_dir
    for path in root.iterdir():
        print(path)
        name = path.name
        if name.endswith(".pyi"):
            continue
        if name not in ["__pycache__"]:
            if name in ["__init__.py", "_calibrate.py"]:
                ctx.run(f"cp -rf {path} {TARGET}/{out_dir}/")
                continue
            if path.is_dir():
                is_package = True
            else:
                is_package = False
            package(ctx,
                    name=name,
                    origin_dir=origin_dir,
                    out_dir=out_dir, 
                    is_package=is_package)

@task
def all(ctx):
    cpp(ctx)
    # VTA
    package(ctx,
            name="vta",
            origin_dir="vta/python",
            out_dir="src", 
            is_package=True)
    # TVM
    tvm(ctx,
        origin_dir="python/tvm",
        out_dir="src/tvm")
    relay(ctx,
          origin_dir="python/tvm/relay",
          out_dir="src/tvm/relay")
    quantize(ctx,
             origin_dir="python/tvm/relay/quantize",
             out_dir="src/tvm/relay/quantize")
    # 打包
    ctx.run(f"cd {TARGET};hatch build")
