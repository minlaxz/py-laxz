from os import path
from setuptools import setup, find_packages

here = path.abspath(path.dirname(__file__))

requires = [
    'rich', 
    'speedtest-cli', 
]

info = {}
with open(path.join(here, 'pylaxz', '__version__.py'), 'r') as f:
    exec(f.read(), info)

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="py-laxz",
    version=info['version'],
    description="A small until for my needs.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/minlaxz/py-laxz",
    author="Min Latt",
    author_email="minminlaxz@gmail.com",
    license="MIT",
    classifiers=[
        "Programming Language :: Python :: 3",
        'Programming Language :: Python :: 3 :: Only',
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    packages=find_packages(),
    include_package_data=True,    
    # package_dir={'pylaxz':'pylaxz'},
    keywords='sample, setuptools, development, pylaxz',
    python_requires='>=3.5, <4',
    install_requires=requires,
    project_urls={  # Optional
        'Bug Reports': 'https://github.com/minlaxz/pylaxz/issues',
        'Say Thanks!': 'http://saythanks.io/to/minminlaxz%40gmail.com',
        'Source': "https://github.com/minlaxz/py-laxz",
    },
    entry_points={"console_scripts": ["pylaxz=pylaxz.__main__:main"]},
)