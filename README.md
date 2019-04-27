# ☢⚛ dangerous-components

Easy way to embed dangerous Inner HTML for React.

This is a spiritual sucessor of [dangerous](https://www.npmjs.com/package/dangerous) library, which was harder to use and much bigger in terms of library size.

# 🤔 Why?

React core team has made it especially hard to embed dangerous HTML in React.  
And texts are encoded to prevent security issue such as XSS (Cross-site scripting).

So you are stuck with doing an arcane syntax, [dangerouslySetInnerHTML](https://reactjs.org/docs/dom-elements.html#dangerouslysetinnerhtml).

```jsx
function createMarkup() {
  return {__html: 'First &middot; Second'};
}

function MyComponent() {
  return <div dangerouslySetInnerHTML={createMarkup()} />;
}
```

## First reason

### It's easier to type.
Check out the code snippet below (this is it).

```jsx
import Dangerous from 'dangerous-components';

const title = `<h1>Some Title</h1>`;
const Header = ({title}) => <Dangerous html={title} />

const App = () => (
    <>
        <Header title={title} />
        ...
    </>
)
```

It will render `Header` accepting `title` as a `div`.

```jsx
<div dangerouslySetInnerHTML={{__html: `<h1>Some Title</h1>`}} />
```

## Second Reason

### It's easier to read.

You can read the following code as "Dangerous HTML title".

```jsx
<Dangerous html={title} />
```

If you need to render it as a head, such as `h1`, then you can specify `as` prop to do so.

```jsx
<Dangerous html={title} as="h1" />
```
It reads like "render dangerous html title as h1".

## Third Reason

If your site makes a heavy use of HTML from another data source (such as internal site or Gatsby blog sites, etc), you already might have an internal utility function to make it easy to render dangerous HTMl anyways.

Just use this tiny module without having to worry about module paths like `import Dangerous from '../../../util'`


# Don't use it

If you can't trust your users' input.  
There is a reason why it's intentionally hard to render insecure content in React.

# Where to use it?

Gatsby uses heavy use of `dangerouslySetInnerHTML` everywhere.  
If you trust your input, then use it there.  
I've used [it](https://github.com/dance2die/sung.codes/blob/master/src/templates/post.js#L31) (dogfooding) for my static site as an example, which made the code much more readable.

e.g.) A logic to generate a blog post

```diff
function PostTemplate({ data }) {
  const post = data.wordpressPost;
  const {
    link,
    title,
    fields: { content },
    categories
  } = post;

  return (
    <Layout>
      <SEO
        title={title}
        canonicalURL={link}
        description={title}
        keywords={categories.map(_ => _.name)}
      />
-      <h1 dangerouslySetInnerHTML={{ __html: title }} />
+      <Dangerous html={title} as="h1" />
      <img src={post.jetpack_featured_media_url} alt="featured" />
      <PostIcons node={post} css={{ marginBottom: rhythm(1 / 2) }} />
      <OriginalPost canonicalURL={link} />
-      <div dangerouslySetInnerHTML={{ __html: content }} />
+      <Dangerous html={content} />
    </Layout>
  );
}

```

You can see that the code is much more declarative and readable.  
You can read it as "render dangerous html title as h1" and "render dangerous html content".






