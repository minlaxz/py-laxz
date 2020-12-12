import setuptools, os

here = os.path.abspath(os.path.dirname(__file__))

requires = [
    'rich', 
    'speedtest-cli'
]

meta = {}
with open(os.path.join(here, 'pylaxz', '__meta__.py'), 'r') as f:
    exec(f.read(), meta)

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name=meta['__name__'], # Replace with your own username
    version=meta['__version__'],
    author=meta['__author__'],
    author_email=meta['__author_email__'],
    description=meta['__description__'],
    long_description=long_description,
    long_description_content_type="text/markdown",
    url=meta['__github_project__'],
    packages=setuptools.find_packages(where='pylaxz'),
    classifiers=[
        "Programming Language :: Python :: 3",
        'Programming Language :: Python :: 3 :: Only',
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    keywords='sample, setuptools, development, pylaxz',
    package_dir={'': 'pylaxz'},
    python_requires='>=3.5, <4',
    install_requires=requires,
    license=meta['__license__'],
    project_urls={  # Optional
        'Bug Reports': 'https://github.com/minlaxz/pylaxz/issues',
        'Say Thanks!': 'http://saythanks.io/to/minlaxz',
        'Source': meta['__github_project__'],
    },
)